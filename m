Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220BEC02197
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezzb-0006ja-UO; Mon, 03 Feb 2025 12:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezza-0006jR-Cz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:12:14 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tezzY-0003Pe-Gi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:12:14 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so99384395ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738602730; x=1739207530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I6i777hNBFGojaCptpiGvUYhE3e37KTEE4FcRnsEmvM=;
 b=QenmHSOuVjwAV9/SNJh6FQvZdvinfsZ9OnFIuMt0fMc8Zkkjs9am/CgwqwEzTZehYz
 W6ULSRmtUS06OWRS6DKr//CaG/f8rUqx88e2YbyXp+bSYpalKGm3BEEFSfRbMAAIh7Hc
 xUPV83bVzPmO9V3/mWbDbY1LjUwn0AtNjYOgBf4HOnylm5WZKdABxcKcghFAdQakg5G/
 DmIenwa2gktQsi+xzXqvhrsgZQWOVPohulplZckCjuIdXuW09ok0phlU8PubQPdeLIp6
 qbbbaCWrnL3P8AHhwA0/ii/23yJKLeisYlY4RxdOn3IxrLJkIRFaYxjK8iYLYm71lirD
 mFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738602730; x=1739207530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I6i777hNBFGojaCptpiGvUYhE3e37KTEE4FcRnsEmvM=;
 b=UykCClWKe0BijRkrTyuFf2nQaSaBVjX8vKzBXDXa2Zhx7IewFn+moazhdjPrkOxRFF
 lOA4ASnhV+d1YDzmwZFGUEFako+GH87jT7tIfRGY5J4GSoaeWWJxyj25zIf/g3d3TTdq
 SH2Zjz78ROC8IvPJLVt1QESm4LDLGd+PsFxv06g/qaHB3ScCoIV8srw7Dd+mOLOWesj3
 NzyQLO5x/m9uCHrB32Ln9++4kebzCxCFHzvCjL7I8mP4b8sGQ5SMzBgr6LBXxQtnXv+O
 WLi6XB06O4Y7epJpTvZ7EhRUnMoJbi19p9VSfHdwFxtIwoA2KKxcXAPkx+LWkp4wIqAu
 MvZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDt3vt2Z8rcZEOgSKTnuodf2iL+jBZU80yKY011gUVBIsF0B6w4AZPeT89SYkpCIoIkWdrirswpu5J@nongnu.org
X-Gm-Message-State: AOJu0YyKUbzk34GwN9RFwU/h3W+8tGQ6gzQydPqiYU6GmDexFZoLqYvj
 xkTiKxtLUPVawmIGbC0W9eokOAG/VQVxXN5N3tEB96qdi/wrUOT5ITSfmGiyrLg=
X-Gm-Gg: ASbGncvQOJjorfKKUTpt9iqx7iSQwYR25OtDfKi0JX9uYi3UdCdXhL8jhNgJ6iAkEx8
 v8iDhMLlNc/wBeRilxezMk8wo7YLAxdR1GLvuELMWQPX3zwMDm27azBEmklSV4CT04YntzEBSL9
 sFfttM7KTt6wguSO6oRYhVc0NZrtLtQhJk5wrTUUSFU9xOppf4gW10KOniZst+nStDi2q2usS48
 gc9R4gZAew3Fk/cIo9j8yWN3W+8OtaI/E1NSuaTID/fyRM6FMtFxPAxClvEF17vNqN2rAMNTneT
 wmcfLw1D77nYpSRgWkG65vrZjk6W7PAYPOn5AHhwlLhFj1YZ3YqkRUg=
X-Google-Smtp-Source: AGHT+IEubBwe9V9pkOfcU6RZrNpoHpDKnlzchQvjMogyo2MkOCskDgIkuUdEYmo1GIJrC1grWTH1Xg==
X-Received: by 2002:a05:6a00:2181:b0:724:db17:f975 with SMTP id
 d2e1a72fcca58-7302724516emr89610b3a.12.1738602729879; 
 Mon, 03 Feb 2025 09:12:09 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba418sm8924617b3a.105.2025.02.03.09.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:12:09 -0800 (PST)
Message-ID: <caf4c64a-98ea-4836-95cf-f59737db0d0c@linaro.org>
Date: Mon, 3 Feb 2025 09:12:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Fix register selection for the fdtox and
 fqtox instructions
To: Mikael Szreder <git@miszr.win>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250203140130.78240-1-git@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250203140130.78240-1-git@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/3/25 06:01, Mikael Szreder wrote:
> A bug was introduced in commit 0bba7572d40d which causes the fdtox and
>   fqtox instructions to incorrectly select the destination registers.
> More information and a test program can be found in issue #2802.
> 
> Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
> Signed-off-by: Mikael Szreder <git@miszr.win>
> ---
>   target/sparc/insns.decode | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 989c20b44a..694a28d88c 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -322,8 +322,8 @@ FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
>   FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
>   FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
>   FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
> -FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
> -FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
> +FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
> +FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @q_q2
>   FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
>   FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
>   FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2

Same issue with FsTOx and FxTOs.


r~

