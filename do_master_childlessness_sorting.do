/*
*/
 
** This is a master do file for chapter 2 marital sorting. Cleaning, prerearing data, 
** constructing all vars, regressions, descriptives, tests. 

cd "C:\Users\..."

********************************************************************************
** Assigning czone identifiers, cleaning
********************************************************************************

** this do file joinby zs codes to census 1950, 1960, 1980, 1990, 2000 and 
** acs 2005, 2010, 2015 and 2018. It saves data samples with attached czone in
** the forlder temp_cz\. No data cleaing etc is made in these do files.
** It uses raw samples from folder raw\.
 do "do\joinby_cz_to_census_acs.do" 

********************************************************************************
** Constructing outcome vars.
********************************************************************************
** I fist prepare files and then contruct outcome vars. These do files are 
** saved in the folder ch2_do_outcomes\.

** Thes do files prepare respectively raw file temp_cz\census1960, census1970, census1980,
** census1990, census2000, acs2010 and acs2018 to further construct outcome vars.
** It creates hourly wage for each individual and a spouse. 
** This do file save the prepared data set with the same names in ch2_tempoutcomes\ 
do "ch2_do_outcomes\prepare_census1960.do"
do "ch2_do_outcomes\prepare_census1970.do"
do "ch2_do_outcomes\prepare_census1980.do"
do "ch2_do_outcomes\prepare_census1990.do"
do "ch2_do_outcomes\prepare_census2000.do"
do "ch2_do_outcomes\prepare_acs2010.do"
do "ch2_do_outcomes\prepare_acs2018.do"

** These do files create outcomes. They take corresopnding files from ch2_tempoutcomes\ 
** and save in the same folder. Files are named ds-1960-27-36.dta,
** ds-1970-27-36.dta and etc for each year.
do "ch2_do_outcomes\create-outcomes-1960.do"
do "ch2_do_outcomes\create-outcomes-1970.do"
do "ch2_do_outcomes\create-outcomes-1980.do"
do "ch2_do_outcomes\create-outcomes-1990.do"
do "ch2_do_outcomes\create-outcomes-2000.do"
do "ch2_do_outcomes\create-outcomes-2010.do"
do "ch2_do_outcomes\create-outcomes-2018.do"


********************************************************************************
** Constructing outcome vars.
********************************************************************************
** First I prepare data sets to create outcomes vars. Do files that prepare data 
** sets use raw files with czone such as "temp_cz\census1980/acs2010". Prepared files are 
** saved in "ch2_temp_outcomes\census1980/acs2010"
do "ch2_do_outcomes\prepare_census1980.do"
do "ch2_do_outcomes\prepare_acs2010.do"

** This do file creates outcomes for each year and save them in "ch2_temp_outcomes\ds-1980-27-36".
** Census and ACS files have the same name. 
do "ch2_do_outcomes\create-outcomes-1980.do"

********************************************************************************
** Constructing control vars.
********************************************************************************
** Construct controls. These do files use data files temp_cz\census1960,
** ... temp_cz\acs2010 and save control vars in "temp_controls\controls_1960_80"... 
do "do_controls\create-controls-czone-1960-1980.do"
do "do_controls\create-controls-czone-1970.do"
do "do_controls\create-controls-czone-1990.do"
do "do_controls\create-controls-czone-2000-2010-2018.do"
** Controsl are assembled in. Controls are saved in "temp_controls\controls_1960_2018".
do "do_controls\append-controls-czone-1960-2018.do"

********************************************************************************
** Assembling
********************************************************************************
** This do file assembles the data set and saves it in the folder ?
do "ch2_do_assemble_data_set\assemble_data_set.do"

********************************************************************************
** regress
********************************************************************************
do "ch2_do_regress\regress-new-dataset.do"

** first stage
do "ch2_do_regress\regress-first-stage.do"
** reduced form
do "ch2_do_regress\regress-reduced-form.do"

********************************************************************************
** sensitivity tests
********************************************************************************
** regressions run for potential full time full year earnings which are constructed as 
** mean lnhrwage in gender race coll occ6 foreign cell 27-36
** census 1960, 79, 80, 00. 
** prepare data sets to create mean lnhrwage in gender race coll occ6 foreign cell
** assing gender race coll occ6 foreign cell
do "ch2_do_outcomes\prepare_potential_earnings_census1960.do"
** acs2010 and 2018
do "ch2_do_outcomes\prepare_potential_earnings_acs2010.do"

** merge data sets by year, construct mean lnhrwage in gender race coll occ6 foreign cell
** this do file creates two data set with potential earnings one for men 
** and one for women - spouce
do "ch2_do_outcomes\append-potential-earnings-construct-mean-potential-earnings.do"
** assemble original data sets by year into one data set, assign cell identifiers, 
** merge potential earnings to all couples
do "ch2_do_outcomes\prepare-data-outcomes-potearn-1960-2018.do"
** construct marital sorting index for couples with valid non negative earnings.
do "ch2_do_outcomes\create-coef-potearn-nonnegat-earn.do"
** construct marital sorting index for couples with any earnings
do "ch2_do_outcomes\create-coef-potearn-any-earn.do"
********************************************************************************
** Plots over marital sorting index
********************************************************************************
** This do file creates a plot of corr over time 1960-2018 (czone level data weighted 
** by pop share) and saves in in the folder ch2_output\. 
do "ch2_do_outcomes\create-graph.do"

********************************************************************************
** Plots over shares women married to a husband of a particular earnings quintile
********************************************************************************
** This do file creates a plot of corr over time 1960-2018 (czone level data weighted 
** by pop share) and saves in in the folder ch2_output\. 
do "ch2_do_plot\do-plot-5-xtiles.do"

********************************************************************************
** Plots over sector/occ groups relaive premium
********************************************************************************
** This do file creates plots over sector/occ groups relative premium.
** It assembles data sets for differnt years, keeps 
** necessary vars and saves data set census1950-2018-wages-plot in the folder 
** ch2_temp_indep_var_inst "ch2_temp_indep_var_inst\census1950-2018-wages-plot".
** Then, it constructs plots used in the analysis and saves them in "ch2_output\".

do "ch2_do_plot\create-graph-nation.do"

********************************************************************************
** Plots over sector/occ groups employment shares in paper
********************************************************************************
** This do file prepeares data set to be further used for plots construction.
** This do file produces data set ds-19502018-plots.dta saved in the folder 
** ch2_temp_indep_var_inst\, i.e. "ch2_temp_indep_var_inst\ds-19502018-plots" 
do "ch2_do_plot\prepare-data-set.do"
** This do file creates plots over empl shares by sector occ groups that 
** are shown in the paper. This do file calls data set "saved in\named.dta"
** "ch2_temp_indep_var_inst\ds-19502018-plots". It saves plots in "ch2_output\"

do "ch2_do_plot\do-plots-nation-1950-2018.do"

** Plots for change in sector (occ gr) premiums between 1970 and 2018 relatively
** to the values in 1960. 
do "ch2_do_plot\plots-change-premium-1960-2018"

********************************************************************************
** Outcome vars in first diff
********************************************************************************
** Assembles data set with outcome vars in first difference
do "ch2_do_assemble_data_set\assemble_data_set_outcome_var_fdif.do"

** Do regressions with outcome vars in first difference. 
do "ch2_do_regress\regress-test-fdiff.do"










