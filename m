Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD5EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 17:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryxAp-000706-1a; Mon, 22 Apr 2024 13:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryxAn-0006zO-94
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:09:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryxAl-0005QW-Ia
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:09:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f00f24f761so3862078b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713805781; x=1714410581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eZ7o6UTFEdOgCtPcl1YKurJE9hYXkqogY38GU/z1zG0=;
 b=tVL/rO8RFbsBaWGrfZxd1oZjt8M3BFs11HuCSdKgx+aiNPVwKHc9n20+tks7IGwns1
 6C5yerw0d3xhReQSk5qcodoSK+JjEvwc0uDVnuwwYFRKslIdJuqwt+UOuJDXZkr89SNg
 4AhwA9ojGrQhAZmIUdqSGdYxELL6Fcz8w/6ql82gilu7LzFy+ymbp4VUMbY/5pv2cmAJ
 GO7HoDEWDQcrL0pJ6EGpdhs60kMAIzr5l9OZHcz7xozSy+Aw73KtHOZ1T0LxPi/NpT2h
 jNB+E2ZyiG7aJXYBDQBwzf4RRL6H1KRuBVE626i43UNPWobKno1V2Dg23x7g2uD18Pe6
 eJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713805781; x=1714410581;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZ7o6UTFEdOgCtPcl1YKurJE9hYXkqogY38GU/z1zG0=;
 b=CQIVlnufCt/27PD7yd7BoEUyqe52QEsf7ic3iqg8TXkbnLjLgC0rr4nOgzi2NC/J1R
 uytmviWYeI8gTICWdvJyRwuPeTsQ4pW+nrS9ggYT14kSWGEhOifNeGeG6TKblsZY8qUY
 /vBc8ZIrY77oXoPLTXooAgaZbgc7bmdNbbXFcvjFjy05XTSrGDBFmK+SXqAmpRAy0p9t
 w9a7cviPjpc1T9nngJsuYz1AEpMocv/XdhuPx46QgKE5JMgfidZKTUpi/iJV20BjM6ES
 KfHl3XbjLT8ZT3ev2eb3mcAoD6zjlomm0ZrhTIANkWX/cRXgs783gTObhjnq1xkK2P5V
 XtBQ==
X-Gm-Message-State: AOJu0YzCOgCUb0QJclUfYJzTNCRhqOgH45Xtb2M/elMZpzi13kYOaGtY
 ZE5NManNm+u64LQR1H2nuI3PZ9r45lp2OLOaW0pqOVcAxBN+ZgDCpduO3/i/fEY/8JPFwuHBaB9
 G
X-Google-Smtp-Source: AGHT+IFWJF+nPbaTSMPG8uMjRSxX2gbI17po9BLyyFN44FoMTFdcxnFZq01eOev1StTYi1cs2RHZ1w==
X-Received: by 2002:a05:6a00:14cb:b0:6ed:8aa9:4783 with SMTP id
 w11-20020a056a0014cb00b006ed8aa94783mr14060657pfu.13.1713805781346; 
 Mon, 22 Apr 2024 10:09:41 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 n52-20020a056a000d7400b006ed0b798f1fsm8066250pfv.119.2024.04.22.10.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 10:09:40 -0700 (PDT)
Message-ID: <ea575a44-9ce6-4da0-ac62-f283c436c540@linaro.org>
Date: Mon, 22 Apr 2024 10:09:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict translation disabled alignment check
 to VMSA
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, qemu-stable@nongnu.org
References: <20240422170722.117409-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240422170722.117409-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/22/24 10:07, Richard Henderson wrote:
> For cpus using PMSA, when the MPU is disabled, the default memory
> type is Normal, Non-cachable.
> 
> Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
> Reported-by: Clément Chigot <chigot@adacore.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Since v9 will likely be tagged tomorrow without this fixed,
> Cc: qemu-stable@nongnu.org
> 
> ---
>   target/arm/tcg/hflags.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index 5da1b0fc1d..66de30b828 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
>       }
>   
>       /*
> -     * If translation is disabled, then the default memory type is
> -     * Device(-nGnRnE) instead of Normal, which requires that alignment
> +     * With PMSA, when the MPU is disabled, all memory types in the
> +     * default map is Normal.
> +     */
> +    if (arm_feature(env, ARM_FEATURE_PMSA)) {
> +        return false;
> +    }
> +
> +    /*
> +     * With VMSA, if translation is disabled, then the default memory type
> +     * is Device(-nGnRnE) instead of Normal, which requires that alignment
>        * be enforced.  Since this affects all ram, it is most efficient
>        * to handle this during translation.
>        */

Oh, I meant to add: since the armv7 manual has both VMSA and PMSA sections, and the 
language about default Device type and alignment traps, is in the VMSA section.
This will at least fix our two r-profile cpus.

r~

