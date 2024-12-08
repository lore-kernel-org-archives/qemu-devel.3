Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D4E77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 18:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKLax-0006jf-G3; Sun, 08 Dec 2024 13:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKLat-0006jD-1S
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 13:01:25 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKLar-00027P-69
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 13:01:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so23989785e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733680879; x=1734285679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Mx4RyYxAJDnRnqET8fH32LPN9niMLi8X04oM/Vrlyo=;
 b=oR++gYoUkY0sQJRW7PNN/pcClj68dyOjUd2tM56hctzcVtQkiaGs3Mo2urPT0dUw8q
 XZ05BrieJ19RA5SZTK+FWXZFD9KzkIwiSFF0OQhj1+p5o630ckS9LSHV3wt3g/QN0SLx
 lQBsVSg9hTVNOR08nlfi2a66lXnzQNJBA7r4KSC39yGINIc4DEfpqGsOKihCrTzaHNdO
 tqMIPaKv2hFGZMiqPi6Uh3kuBAU8oQQfyueFGN6BXjdTvQyFj9trdC7NS0LtPHgz+cT1
 uBBTCXiKmb09m/ImQN4p+/pgK+I1xu8foV/9IymSNXABklFbrSZAfz03ZdttcH2YimPh
 qj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733680879; x=1734285679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Mx4RyYxAJDnRnqET8fH32LPN9niMLi8X04oM/Vrlyo=;
 b=B8Q2vX81wr4SIv2FO+0Cx4jTZ68LMn/Hg3ksvaeygdnb+MgTFxQA0VJl4oEBRnW5v5
 blmUkkFdWpvSPr8BkoPymm8VDnKwvIi/USCF8IQLFclroegqtbwWN+RspmqbvGSK0/CB
 C4o4HkIMioW6mJ7HjIumH2kUTGWWmuqN9/00PsXt/G/ulQoEVsEng8/FvePDARNffzn7
 72XNvbUzxrKeIHrv7zz6JOueaq5BuRSkOpIrjCmIjTPT+7ht1wVbdV9hs4PBhMKVPHht
 qq4dj9jFteJ0bhc54MlLJsqp5tj6Hk3uQZgW6BTh2v7F8Pgd1jhn+b+pFGiYtw4BT55v
 FUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm6tGhZkexGj/pqJI+WY2MfHGsVWbkqe6cR243jfgtbzL0sm5ssDv44uSECxKmtFz7yQRwG04EZQsl@nongnu.org
X-Gm-Message-State: AOJu0Ywbdhbodf8bpXa4Ouur4p7PKpnz9H4agIA7/K6T2fyf5e2qw88S
 q1XWJgoam3yrg50x6me1gaABAkdvOedGRybsEmTt7HgZHfDthJQSeJ4oyoMTBEY=
X-Gm-Gg: ASbGncsnIYQCh/dVyTZ48ncmzQYl7VvHvMCloki2awwRqPP87+YLZg7e7YB8OT3BsBc
 LGjgJSDKkpw2zq1/ps4UYP+7v5c2hcYTIbQghm9fNZNZitSvei/T82BFBqc3RbPjF5PWdILMHg3
 YVeB1QALTkJvgCgyDFJuDpUVM/kNBAazyqHEAK3Tt3EPc+EFy1VgvNEYOAPszbdkRbkhtswzZNq
 qIqjf5DkmLcFUMyVfVPz1QrrS6y+eCuvfB/aSs9liSYR56ApilKqAsbz7GgqMjYh8MOiRYgXm9J
 hPJw7vu97Po8G6prObkbAnkYrbru0SQL
X-Google-Smtp-Source: AGHT+IGwuUdUb2bAngBsm5fOtvePD4seVG+J8p+bi8xZOLYALL6tlytZmOIoEY42HmDjVCdfPRJmnw==
X-Received: by 2002:a05:6000:793:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-3862b351418mr6969317f8f.21.1733680879336; 
 Sun, 08 Dec 2024 10:01:19 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386336328e6sm5651533f8f.67.2024.12.08.10.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 10:01:18 -0800 (PST)
Message-ID: <73f7357a-fe49-4cbd-8492-cb4ac7ed312a@linaro.org>
Date: Sun, 8 Dec 2024 19:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Reset free_temps before tcg_optimize
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 wannacu <wannacu2049@gmail.com>
References: <20241207214700.211066-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241207214700.211066-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/12/24 22:47, Richard Henderson wrote:
> When allocating new temps during tcg_optmize, do not re-use
> any EBB temps that were used within the TB.  We do not have
> any idea what span of the TB in which the temp was live.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")

Hmm, the problem is due to arg_new_temp()?

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2711
> Reported-by: wannacu <wannacu2049@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Unless there's some other reason to spin an -rc4, this can wait
> to be the first patch for 10.0.1.
> 
> r~
> 
> ---
>   tcg/tcg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0babae1b88..eece825e2e 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -6120,6 +6120,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>       }
>   #endif
>   
> +    /* Do not reuse any EBB that may be allocated within the TB. */
> +    memset(s->free_temps, 0, sizeof(s->free_temps));

Maybe add as tcg_temp_[ebb]_[reset|flush]() helper so we can reuse,
like in tcg_func_start() and plugin_gen_inject()?

>       tcg_optimize(s);
>   
>       reachable_code_pass(s);


