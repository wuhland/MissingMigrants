install.packages("XML")
install.packages("htmltab")
insall.packages("plyr")
require("plyr")
require("googlesheets")
require("htmltab")
require("RCurl")
url <- "http://missingmigrants.iom.int/latest-global-figures"
html <- getURL(url)
doc <- htmlParse(html, asText=TRUE)
mm <- htmltab(doc = url, which = "//strong[text()='Recorded migrant deaths by month, 2016']/../../../following-sibling::table")

comments <- xpathSApply(doc,"//strong[text()='Recorded migrant deaths by month, 2016']/../../../following-sibling::p[2]", xmlValue)


(my_sheets <- gs_ls())
mmgs <- gs_new("2016data", ws_title = "MissingMigrants", input = mm,
                    trim = TRUE, verbose = FALSE)


mmgs <- mmgs %>% 
  gs_ws_new(ws_title = "metadata", input = comments,
            trim = TRUE, verbose = FALSE)
