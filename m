Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61C3CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0wU-0005ID-Cp; Mon, 17 Nov 2025 10:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL0wO-0005HK-Ih
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:14:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL0wK-00017s-0r
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:14:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477632d45c9so32551485e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763392484; x=1763997284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+agDVCUPrVpf0x/p0Wp0pFMwcxQ3N9CMxK667bWa0k=;
 b=tg6+Y4KcSoIzfLs8Yr452fUFNkISfXsy3vmvcfBlMyhmd2lD6U3pR8gmuBV6HYf1Eg
 CGA8zcX9ShBNhVK0EpXGyjqZ68jAOhSdQ+eZ4cDRKm9Wg09K5oXG6GyY9sXap16sx+NO
 PTcfkp7TxvD2+geaSXNeHN30jmhHawPb0HhQv6PaAVsSt29Q+yNfayDE+oG2RcT+3YJg
 NOqVZlMyRDb2b+8WpScw0BJr4Xfi0B35psBLO71hroBcYVxfU43CImvAhpDLGHIoBbTw
 a1M/bkqsoLHH3nil+reMQlRyydipH96TZDnBL/yAsAHhM6S/qCHtS6XB3MgwExWroPpZ
 wdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763392484; x=1763997284;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+agDVCUPrVpf0x/p0Wp0pFMwcxQ3N9CMxK667bWa0k=;
 b=s0SM2u+hI5nFK1xTWwCS9R0Q17QZ4L1BqJnTGf+4ok4MIufFi62GpI3iUfcy3z2iHo
 d2T0LPVuY4ZAKtTpOvjw1dyPJo0JPEq4OilCi+Jx7YUUc0HUykZzpTYQcBeWZLt1hcAk
 iRXszfvAuSwhTtYoR9cMTL+5sYcRHOv8MKC8JDveR6Ecp13bo3YtqhW4/mgs8p0RZImN
 vWuFCmtjtP9+0rKRSrWOGIhMnMvLwMHNpK+xL8/mq3Z96+T7FQ4XPCRmfu3hyqs22Z4c
 NwErJukuB7qKFbLfQK9YmQj7ZQ46d2kP6FGM8Hs90HXmzoSCb70tOB1U9qlhw7CHgu18
 mDMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGgDbj1zFdPhGHefgQ79Inqxj3ObT/ljRS90dGEAlNjXtJgazNG7/VlNOs4F20AWofn2R0JWkzKUxz@nongnu.org
X-Gm-Message-State: AOJu0Yyn18rfSSOL6sdYoAeisSzb2JnicCPgb3AtpE4i+4U7GCG7Ud1o
 XKmya553m/ZQc5sxJRruH4mLQNZeTARpOtUNojNbcPuM5XZVw6N1MASShUef5muPKiA=
X-Gm-Gg: ASbGncvosVUJUFcIAvxEBWjpHuWu6EpC+DLqkkXrHelW/ccKe2FuQA5Ee9bt06wHmLS
 n/nDWGUPE9H6CMs1KmSE3LI7P40a39Im3+pQm2L/xRezwDE4EmLM9DX9/U4YiO2tGAu+HenuYcp
 LbPcwIgA3tMfiwoqWAd5fNnDPjjVZIkfmrl+PLNkYgb9sbGDF1dgzcE7J6QVZ2ikwjdNWh6G+86
 ncaa//UI7lfl4111+6HPVDUKV2XxRDiGE6bnCvR2+ucF2KE/0KJMG3bf10IeRorxuj9A6Emgres
 YXf7c/ZVWdyScED7yIDCT2vdhzh81qy0nHh79gubiEGdkO/S0SzkrPD4fdBWVMSblTsdpyeH3+r
 LdlZSRY2Vr9qPxkz8lYHfgy4XOAHBfJV1M2PEbuFrkF12n3GSCaJhQDAfdg1PPmSKl4/7+hHi0u
 XKpohKVwuslDYEVkxZrzY9EBpNBptVioXcOziONygn/+Le2IUji9j/gHy8nt2vKdvk5IYMWnQ=
X-Google-Smtp-Source: AGHT+IEz3NFHUYmUyXQCv8BwIfro3tnQIXKX/BIkqaY7me5l0bNq4/XGQ2Q8H3LKa1Mp2UeIC4aZZw==
X-Received: by 2002:a05:600c:3542:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-4778fe7d0ecmr119070725e9.26.1763392483776; 
 Mon, 17 Nov 2025 07:14:43 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e43c2fsm298845525e9.6.2025.11.17.07.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 07:14:43 -0800 (PST)
Message-ID: <fe9177e7-8b43-4e9f-bdda-e32a3cf09c17@linaro.org>
Date: Mon, 17 Nov 2025 16:14:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 03/10] target/arm: add TCSO bitmasks to SCTLR
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-3-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-3-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> These are the bitmasks used to control the FEAT_MTE_STORE_ONLY feature.
> They are now named and setting these fields of SCTLR is ignored if MTE
> is disabled, as per convention.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/cpu.h    | 2 ++
>   target/arm/helper.c | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54d..6fe85b5e3a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1424,6 +1424,8 @@ void pmu_init(ARMCPU *cpu);
>   #define SCTLR_EnAS0   (1ULL << 55) /* FEAT_LS64_ACCDATA */
>   #define SCTLR_EnALS   (1ULL << 56) /* FEAT_LS64 */
>   #define SCTLR_EPAN    (1ULL << 57) /* FEAT_PAN3 */
> +#define SCTLR_TCSO0    (1ULL << 58) /* FEAT_MTE_STORE_ONLY */
> +#define SCTLR_TCSO    (1ULL << 59) /* FEAT_MTE_STORE_ONLY */
>   #define SCTLR_EnTP2   (1ULL << 60) /* FEAT_SME */

Indentation is off.

> @@ -3364,10 +3364,10 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>   
>       if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
>           if (ri->opc1 == 6) { /* SCTLR_EL3 */
> -            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA | SCTLR_TCSO);
>           } else {
>               value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
> -                       SCTLR_ATA0 | SCTLR_ATA);
> +                       SCTLR_ATA0 | SCTLR_ATA | SCTLR_TCSO | SCTLR_TCSO0);
>           }
>       }

You should be testing for FEAT_MTE_STORE_ONLY, not just plain MTE (since renamed MTE2).

Add the appropriate function to cpu-features.h.


r~

