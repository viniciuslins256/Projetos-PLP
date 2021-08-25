-- Declaração do modulo
module Peca where

-- Importes
import qualified Data.Map as Map
import Tipos
import Util
import Tabuleiro

-- (ler de trás pra frente) map.filter: trás todo mapa que contem aquela peca; map.keys: retorna uma lista com as chaves do map.filter; head: retorna apenas a cabeca daquela lista de chaves
getPosicaoPeca :: Peca -> Tabuleiro -> Posicao
getPosicaoPeca peca tab = head $ Map.keys $ Map.filter (elem peca) tab

-- cria um novo tabuleiro com a peca a ser removida e o retorna
removePecaDePosicao :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
removePecaDePosicao peca posi tab = Map.insert posi (remove peca (getCasaTabuleiro posi tab)) tab

-- cria um novo tabuleiro com a peca a ser adicionada e o retorna
adicionaPecaEmPosicao :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
adicionaPecaEmPosicao peca posi tab = Map.insert posi (insert peca (getCasaTabuleiro posi tab)) tab

-- adiciona uma peca a posicao acima (decrescendo um na linha) e remove a peca que estava na posicao anterior
movePecaCima :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaCima  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin - 1, col)

-- adiciona uma peca a posicao abaixo (acrescentando um na linha) e remove a peca que estava na posicao anterior
movePecaBaixo :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaBaixo  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin + 1, col)

-- adiciona uma peca a posicao a esquerda (decrescendo um na coluna) e remove a peca que estava na posicao anterior
movePecaEsquerda :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaEsquerda  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin, col - 1)

-- adiciona uma peca a posicao a direita (acrescentando um na coluna) e remove a peca que estava na posicao anterior
movePecaDireita :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaDireita  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin, col + 1)


-- adiciona uma peca a posicao a cima-esquerda (decrescendo um na coluna e na linha) e remove a peca que estava na posicao anterior
movePecaCimaEsquerda :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaCimaEsquerda  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin - 1, col - 1)

-- adiciona uma peca a posicao a cima-direita (decrescendo um na linha e acrescentando um na linha) e remove a peca que estava na posicao anterior
movePecaCimaDireita :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaCimaDireita  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin - 1, col + 1)

-- adiciona uma peca a posicao a baixo-direita (acrescentando um na coluna e na linha) e remove a peca que estava na posicao anterior
movePecaBaixoDireita :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaBaixoDireita  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin + 1, col + 1)


-- adiciona uma peca a posicao a baixo-esquerda (acrescentando um na linha e decrescendo um na linha) e remove a peca que estava na posicao anterior
movePecaBaixoEsquerda :: Peca -> Posicao -> Tabuleiro -> Tabuleiro
movePecaBaixoEsquerda  peca (lin, col) tab =
  adicionaPecaEmPosicao peca novaPosicao (removePecaDePosicao peca (lin, col) tab)
    where
      novaPosicao = (lin + 1, col - 1)

-- retorna a lista de movimentos necessarios para que uma peca obtenha a vitoria
getListaMovimentosVitoria :: Cor -> [Movimento]
getListaMovimentosVitoria cor
  | cor == Amarelo = replicate 1 Direita ++ replicate 4 Cima ++ replicate 1 CimaEsquerda ++ replicate 5 Esquerda ++ replicate 2 Cima ++ replicate 5 Direita ++
   replicate 1 CimaDireita ++ replicate 5 Cima ++ replicate 2 Direita ++ replicate 5 Baixo ++ replicate 1 BaixoDireita ++ replicate 5 Direita ++
    replicate 2 Baixo ++ replicate 5 Esquerda ++ replicate 1 BaixoEsquerda ++ replicate 5 Baixo ++ replicate 1 Esquerda ++ replicate 6 Cima
  | cor == Vermelho = replicate 1 Baixo ++ replicate 4 Direita ++ replicate 1 CimaDireita ++ replicate 5 Cima ++ replicate 2 Direita ++
   replicate 5 Baixo ++ replicate 1 BaixoDireita ++ replicate 5 Direita ++ replicate 2 Baixo ++ replicate 5 Esquerda ++ replicate 1 BaixoEsquerda ++
    replicate 5 Baixo ++ replicate 2 Esquerda ++ replicate 5 Cima ++ replicate 1 CimaEsquerda ++ replicate 5 Esquerda ++ replicate 1 Cima ++
     replicate 6 Direita
  | cor == Verde = replicate 1 Esquerda ++ replicate 4 Baixo ++ replicate 1 BaixoDireita ++ replicate 5 Direita ++ replicate 2 Baixo ++
   replicate 5 Esquerda ++ replicate 1 BaixoEsquerda ++ replicate 5 Baixo ++ replicate 2 Esquerda ++ replicate 5 Cima ++
    replicate 1 CimaEsquerda ++ replicate 5 Esquerda ++ replicate 2 Cima ++ replicate 5 Direita ++ replicate 1 CimaDireita ++
     replicate 5 Cima ++ replicate 1 Direita ++ replicate 6 Baixo
  | cor == Azul = replicate 1 Cima ++ replicate 4 Esquerda ++ replicate 1 BaixoEsquerda ++ replicate 5 Baixo ++ replicate 2 Esquerda ++
   replicate 5 Cima ++ replicate 1 CimaEsquerda ++ replicate 5 Esquerda ++ replicate 2 Cima ++ replicate 5 Direita ++ replicate 1 CimaDireita ++
    replicate 5 Cima ++ replicate 2 Direita ++ replicate 5 Baixo ++ replicate 1 BaixoDireita ++ replicate 5 Direita ++ replicate 1 Baixo ++
     replicate 6 Esquerda
  | otherwise = []

-- Retorna o movimento inverso de um movimento
getMovimentoInverso :: Movimento -> Movimento
getMovimentoInverso movi
 | movi == Cima = Baixo
 | movi == Baixo = Cima
 | movi == Direita = Esquerda
 | movi == Esquerda = Direita
 | movi == CimaEsquerda = BaixoDireita
 | movi == BaixoDireita = CimaEsquerda
 | movi == CimaDireita = BaixoEsquerda
 | movi == BaixoEsquerda = CimaDireita
 | otherwise = movi

executaMovimentoPeca :: Peca -> Posicao -> Movimento -> Tabuleiro -> Tabuleiro
executaMovimentoPeca peca posi movi tab
  | movi == Cima = movePecaCima peca posi tab
  | movi == Baixo = movePecaBaixo peca posi tab
  | movi == Esquerda = movePecaEsquerda peca posi tab
  | movi == Direita = movePecaDireita peca posi tab
  | movi == CimaEsquerda = movePecaCimaEsquerda peca posi tab
  | movi == CimaDireita = movePecaCimaDireita peca posi tab
  | movi == BaixoEsquerda = movePecaBaixoEsquerda peca posi tab
  | movi == BaixoDireita = movePecaBaixoDireita peca posi tab
  | otherwise = tab

existeSomenteOutraPecaDeOutraCorNaPosicao :: Peca -> Tabuleiro -> Bool
existeSomenteOutraPecaDeOutraCorNaPosicao peca tab
  | length listaPecasPosicao == 2 && corPeca (head (remove peca listaPecasPosicao)) /= corPeca peca = True
  | otherwise = False
  where
    posicaoPeca = getPosicaoPeca peca tab
    listaPecasPosicao = getCasaTabuleiro posicaoPeca tab

existeDuasPecasDeOutraCorNaPosicao :: Peca -> Tabuleiro -> Bool
existeDuasPecasDeOutraCorNaPosicao peca tab
  | length listaPecasPosicao >= 3 && all (\p -> corPeca p /= corPeca peca) (remove peca listaPecasPosicao) = True
  | otherwise = False
  where
    posicaoPeca = getPosicaoPeca peca tab
    listaPecasPosicao = getCasaTabuleiro posicaoPeca tab

movimentaPeca :: Peca -> Tabuleiro -> Tabuleiro
movimentaPeca peca tab
  | not (null listaMovi) = executaMovimentoPeca (Peca (corPeca peca) (nomePeca peca) (drop 1 listaMovi)) (getPosicaoPeca peca tab) (head listaMovi) tab
  | otherwise = tab
  where
    listaMovi = listaMovimentosVitoria peca

pecaEstaEmCasaTabuleiroVoltaDuas :: Peca -> Tabuleiro -> Bool
pecaEstaEmCasaTabuleiroVoltaDuas peca tab = getPosicaoPeca peca tab `elem` getCasasTabuleiroVoltaDuas

movimentaPecaRepetidamente :: Peca -> Dado -> Tabuleiro -> Tabuleiro
movimentaPecaRepetidamente peca 0 tab
  | existeSomenteOutraPecaDeOutraCorNaPosicao peca tab = do -- Se um jogador chegar a uma casa já ocupada por um peão adversário, o peão adversário deve voltar para sua base
    let posicaoPecas = getPosicaoPeca peca tab
    let outraPecaNaPosicao = head (remove peca (getCasaTabuleiro posicaoPecas tab))
    let tabOutraPecaRemovida = removePecaDePosicao outraPecaNaPosicao posicaoPecas tab
    adicionaPecaEmPosicao (Peca (corPeca outraPecaNaPosicao) (nomePeca outraPecaNaPosicao) (getListaMovimentosVitoria (corPeca outraPecaNaPosicao))) (getPosicaoBaseInicial (corPeca outraPecaNaPosicao)) tabOutraPecaRemovida
  | pecaEstaEmCasaTabuleiroVoltaDuas peca tab = voltaPecaDePosicao peca 2 tab -- Falta testar
  | otherwise = tab

movimentaPecaRepetidamente peca dado tab
  | null (listaMovimentosVitoria peca) = voltaPecaDePosicao peca dado tab -- Se a lista de movimentos está vazia e ainda tem uma quantidade de movimentos a realizar, realize o movimento voltando da peca
  | existeDuasPecasDeOutraCorNaPosicao peca tab = voltaPecaDePosicao peca 1 tab -- Se 2 peões da mesma cor ocuparem uma mesma casa, eles não podem ser capturados e nenhum adversário pode passar por essa casa, tendo seus peões bloqueados  
  | otherwise = movimentaPecaRepetidamente (Peca (corPeca peca) (nomePeca peca) (drop 1 (listaMovimentosVitoria peca))) (dado - 1) tabPecaMovida
  where
    tabPecaMovida = movimentaPeca peca tab

getListaPecasJogaveis :: [Peca] -> Dado -> Tabuleiro -> [Peca]
getListaPecasJogaveis [] _ _ = []
getListaPecasJogaveis (h:t) dado tab
  | posicaoDeBaseInicial (getPosicaoPeca h tab) && dado /= 6 || null (listaMovimentosVitoria h) = getListaPecasJogaveis t dado tab
  | otherwise = h : getListaPecasJogaveis t dado tab

printListaPecas :: [Peca]-> String
printListaPecas [] = ""
printListaPecas (h:t) = "(" ++ show(length (h:t))  ++ ") - " ++ nomePeca h ++ "\n" ++ printListaPecas t

voltaPecaDePosicao :: Peca -> Int -> Tabuleiro -> Tabuleiro
voltaPecaDePosicao peca numVoltas tab = movimentaPecaRepetidamente newPeca numVoltas tab
  where
    listaMovimentosRemovidos = take (length (getListaMovimentosVitoria (corPeca peca)) - length (listaMovimentosVitoria peca)) (getListaMovimentosVitoria (corPeca peca))
    listaMovimentosVoltando = drop (length listaMovimentosRemovidos - numVoltas) listaMovimentosRemovidos
    newPeca = Peca (corPeca peca) (nomePeca peca) ([getMovimentoInverso m | m <- listaMovimentosVoltando] ++ listaMovimentosVoltando ++ listaMovimentosVitoria peca)

pecasJogador:: Jogador -> Tabuleiro -> [Peca]
pecasJogador jog tab = concat[filter (\p -> corPeca p == corJogador jog) x | x <- Map.elems tab]
