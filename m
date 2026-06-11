Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCFFCD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYtr-0000Fp-42; Thu, 11 Jun 2026 02:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wXYtn-0000FM-HA
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:28:20 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wXYtl-0007GL-Jt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:28:18 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-304e83724bfso9674021eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781159295; x=1781764095; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JtOvPxLD4OsVqcRmNVsGUpSC760YCktH1/sKb4l8POM=;
 b=ju2s5VGpo/b4Hsh4HSeJ1osazZxbRix6VWV6rw6vO8LafRcQ7+ZuxRQnY1PyamhWy8
 v7n0NO46c/7tQAXzcorU2uuN98bsfgb/ZxoTvfG9PaVsxyMnRm5xV5MlXufWjKiGTvKZ
 zJqiStXFB45+pjbuJJG45G7ZrcORv8B1N2RZNfoEFcpsWjucAbsfDgAI828KTSHJp+7d
 EXqk9TCPkCLNI+4DX9qGCGacf9Dy6YkNKTapwQ0lfhw9bMUYqgXZ5FYjhEMf5As09PQt
 x6gj3lMFfaF+5Ndd+jE4nSTGCE9u6QNHW6k8llpQHDWUDTUoecJWmSnL3L4GDChnfdHH
 IxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781159295; x=1781764095;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtOvPxLD4OsVqcRmNVsGUpSC760YCktH1/sKb4l8POM=;
 b=E91lsrIM3zRV3HOO0QOg93RNDEHIDGZDwXSLKmAj9kmqb56ke8MXFNVE9ujCe7AqMq
 4ssb/xFNNk7NA8PmkZJfgPvjLSJa6gOxUqqoec0jesBB2sEMM4z685gv3VYYL1yp778X
 nRyiB80z8z7QDq5/nFIeqj8m/GAfY+G/hEpv3vVC63j/RI9HEXx7E9ONhOIL4/uUCpYR
 jJ1ngrKKXLtpd5nUq+1sH3RmmiqIdtPI3EQHvuBWSKN24YBnvLnFUKhxIpoFjAZ2KQhS
 utvpZEVJMbJGNog+ML6sdt9u50qYYXUIf/QCQC2/9bkAOxTcbS7iEa9KIGlYOaBZMs0p
 PvhQ==
X-Gm-Message-State: AOJu0Yxch9lCI/vxG1T9Q73vTENzI4KXw14UEj96nHCr0eZjfSIwWo5m
 ZetZvnMN30lz+M70V7HDfOOjzGS1q0zCQx6cS1BI+3xPR2D15xgQf4vz
X-Gm-Gg: Acq92OE6ha65EsnIESs3dsZCmshTd6m7zeiWJ7gcFbyNNMNRyUjPBIW9oJnXi2KzxAz
 fxwBpD6HzbkRYGwUUartuLwS5Vo6pGNJ924xtjlBojc7sAJmB7hdZl8on0H9ZTUyUKyIaZi7/u/
 X+0wKkwvalkGG5zE9VI473uj7DBcHXU72yU3V0g5V46z3JcY4wOa99WOvAXeQn2ZR/S3jmAL3lZ
 vOtgK5a6zg7hHodBph3EdVj4k3mMmqBxviu/reBry6/CGLRyAVVVbV47z5mdIxyqnP8epAE4Aef
 bf+rmbxu78cwHLWR+iwBmN6PqLrHZH0UCAI5dCyI0gt473Bm8mBb6xzF+tNJdAeh1YQUH6dkxWk
 a95V1DdCoFDAJ3SKChs4GwboBKHxzOo39bSZiw4H0UVco4DuH/oKfJG2NX0qVG4ysRNuEC1lzSk
 kbfCaFhmByu6ABJanT172fD29+iTar3x0vd+KxsCzzgoyb94oMxuTraIpUiNG3buaMkTFzKg==
X-Received: by 2002:a05:7300:4784:b0:304:c520:4e14 with SMTP id
 5a478bee46e88-308048196camr1263068eec.11.1781159294953; 
 Wed, 10 Jun 2026 23:28:14 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c464b2sm994109eec.8.2026.06.10.23.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 23:28:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:28:12 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 24/25] scripts/checkpatch: remove check on forbidden
 space before '[' in C++
Message-ID: <aipVbsDhzKjbGwFC@ChaodeMacBook-Pro.local>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-25-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603205152.1440291-25-pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 03, 2026 at 01:51:51PM +0800, Pierrick Bouvier wrote:
> Lambdas are very confusing for checkpatch, so just relax this check.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c74ec070c53..d90aca6fcbf 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2423,7 +2423,8 @@ sub process {
>  #  3. inside a curly brace -- = { [0...10] = 5 }
>  #  4. after a comma -- [1] = 5, [2] = 6
>  #  5. in a macro definition -- #define abc(x) [x] = y
> -		while ($line =~ /(.*?\s)\[/g) {
> +		my $cpp = $realfile =~ /(\.cpp)$/;
> +		while (!$cpp && $line =~ /(.*?\s)\[/g) {
>  			my ($where, $prefix) = ($-[1], $1);
>  			if ($prefix !~ /$Type\s+$/ &&
>  			    ($where != 0 || $prefix !~ /^.\s+$/) &&
> -- 
> 2.43.0
> 

