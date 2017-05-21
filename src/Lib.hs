module Lib
    ( complete
    ) where

import Network.Curl.Download
import System.Directory
import System.FilePath.Posix

download :: String -> String -> IO()
download url target = do
  file <- openURIString url
  case file of
    Left err ->
      putStrLn $ "-- error " ++ err
    Right html ->
      writeFile target html

complete :: IO ()
complete =  do
  let raw = "https://raw.githubusercontent.com/wk-j/dotnet-completion/master/dotnet.fish"
  home <- getHomeDirectory

  let complete = home </> ".complete"
  createDirectoryIfMissing True complete

  let target = complete </> "dotnet.fish"
  download raw target
