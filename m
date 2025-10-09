Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D1FCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tmM-0000t5-GM; Thu, 09 Oct 2025 12:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tmL-0000rp-4s
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:46:09 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tmI-0004Yr-0x
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:46:08 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-273a0aeed57so28381755ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028361; x=1760633161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFbfRaRLvytnU/QnPyHUgbPlDCOrBLNVNnBj9hc2nrs=;
 b=ZVx7kTEkZAtwuA6sR0ZnhvSfonlX4fN5E/8e6oP4Zx5NUNBfCeSXogmCZwbPeZtJ+V
 42gMF8eDxHylwWnX2ViX9j/WNzkOCEzX+ZYFYZnItCHmXAr3cCUPIjMDY2hYWUI0MTza
 RfxlGT/kygfEBujpzkVeooe8WIABJLnA6J73v6PHw0Uxzm2+R5vpZ5d62p+3Z6V+DiOf
 wiMnxnTf8uJziAiMU5pThgvSVDjFM7ikZ29g8ePQoNfroZcVZSQJ3p9Gt9l6Jpexjfis
 aEeK/sqR5QrBgO5cYpqoAQzfzvc4C/eDFfJvGkTSKJGNTpn4oBj5qdDFiNQhatP7ZPei
 P5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028361; x=1760633161;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFbfRaRLvytnU/QnPyHUgbPlDCOrBLNVNnBj9hc2nrs=;
 b=tVr9Z4Sb7DG7LyG1jVQ+H9R8KYkMgE5TxSwq6x08HiKZpPahcP7slm794m/v/R2Fi6
 WDKnGWIgxzuUfR2WFMYry7HC1ko8hT8opmvzQfLZuHDiBwovugvXjv/NUa7ik2fkuqfH
 RfhXWIZNTbL2S6o+xuuCY8tsxPSHH892CcXrcoqa/aTuBM2FkrY+mSulWC74nYA66UBJ
 lOTkj+SE3/YmYWPM9c9h30jxvYvWwvmyA6OtIHB/QnODtSOmYmwDvDn/3hBGD9l5gwUj
 Hfinczrib+5glVrlBmK6fPQ14X4mcewMv9b+wuaYmNMFFTy6ojFTBK/krqaseJwYQQJd
 iDmg==
X-Gm-Message-State: AOJu0YzZoXUdhV74vrS93BwX/4U/JnjDWO7d+1cRWz+wye1yPA7ifid/
 QZnP1oreMd6wnNWhXrxEDJpkB2GlPGx48QoDfSJ2vWSQT7MkLf7EeueuWmEW20lC8C71Vcch0CG
 aTBDBMAI=
X-Gm-Gg: ASbGncs7fhGIKqwj2Tj+vtOiqQy2FfYP86vA5CLezf6Swjs6wwTqqDcGxew0TReasiq
 vuTx26l9c9PPbgsqa/bRaZX3mwweegYrPrMgriC/zlxgXaD7QJWSn+G3qDMZ74SHG4Nh1HqbzM5
 gX59479TU3KbdaROAUiHJlTQkZAdYlRtLPvzUOcAgRItGV/vqNuXhL4yOjq8xhGwlISVZvIVOzY
 zd5oSppBeBbZhuT20x+MUwIVv9hWwCJE28MwNs0VFQUkCpOBgI49yZWp4xb24B3TY5JDmYZkhUp
 6IR0Psk5KzRyH7VMjrez3q/vF/Di9HIXUJ7acMOxAGpcZve32bCJrJe4LpnqSVop2NazYBh3OFv
 r1nn8HhaUqIvTS8xHrQCRn9kfi3Mtgzylp8V4B5WHgVD8h6q9No+ZqnqaVAMj9ujK
X-Google-Smtp-Source: AGHT+IGT4AGxF569RHYdwPElfVVU4a304c+nHg4ic/q4yoJT7VbNUxexUg7cTehKpevRGEuRuLR4ww==
X-Received: by 2002:a17:903:2c0f:b0:266:57f7:25f5 with SMTP id
 d9443c01a7336-28ec9c272b4mr149543155ad.7.1760028361319; 
 Thu, 09 Oct 2025 09:46:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e45100sm33559215ad.53.2025.10.09.09.46.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:46:01 -0700 (PDT)
Message-ID: <60e48803-e9e8-4893-ad94-ccdcce695c61@linaro.org>
Date: Thu, 9 Oct 2025 09:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] target/openrisc: Do not use target_ulong for @mr
 in MTSPR helper
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
> OpenRISCTLBEntry::@mr field is a uint32_t type since its
> introduction in commit 726fe045720 ("target-or32: Add MMU support").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/openrisc/sys_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index b091a9c6685..ad59939db3b 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -45,7 +45,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>       OpenRISCCPU *cpu = env_archcpu(env);
>   #ifndef CONFIG_USER_ONLY
>       CPUState *cs = env_cpu(env);
> -    target_ulong mr;
> +    uint32_t mr;
>       int idx;
>   #endif
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

