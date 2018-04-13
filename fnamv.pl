#! /bin/perl

#########################################################
# file 中に含まれるある文字列を別の文字列に置換して
# ファイル名を書き換える
#	Usage :	fnamv.pl  source_word target_word  files
#########################################################
													
@list = @ARGV;											# 引数をリストに代入

if( scalar(@list) <= 2 ){								# 引数個数チェック
	$cmd = $0;											# $0 : 実行している Perl スクリプトのファイル名
	$cmd =~ s#^.*\/##;									# 絶対パス表示を削除
	print STDERR "\n    Usage : ${cmd} search_word  replace_word  file_name(s) \n\n";
}

else{													# 引数の個数が正常
	$searchword = @list[0];								# 引数から 1番目の引数 (置換される語句)取得
	shift @list;
	$replaceword = @list[0];							# 引数から 2番目の引数 (置換する語句)取得
	shift @list;

	@found = grep(/.*$searchword.*/, @list); 			#引数配列から検索対象を含む file 名の配列を作成
	@after = grep(s/$searchword/$replaceword/, @list); 	#置換された file 名の配列

	while(@found){
		$source = shift(@found);
		$target = shift(@after);
		print STDOUT "moved  ", "$source", "\t\t", "->", "\t", "$target", "\n";		# 結果を表示
		rename($source, $target);
	}
}

