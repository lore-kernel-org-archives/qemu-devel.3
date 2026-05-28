Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47537CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjID-0001bn-3n; Thu, 28 May 2026 18:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSjIB-0001b4-Ah
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:33:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSjI9-0000D6-Mm
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:33:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-83ec36a13e9so6796876b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780007608; x=1780612408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gyEu49Z6M3fX0YH/zwu9x8ApPANqz7j3tAfBQMK/VsE=;
 b=rK8tJOKyA6bzEqhJkEqozAYQA1rem1eubAJhb4Ao5OaICZL3yVtsfRCwqbDNg48Pux
 103B/QM0DKYNfySurJ414l89kJf85tvHfCJc3TqIYYHuw2v8pExmDV1NpcPtGar9MCIZ
 clHpciibDA2MJ8MhTk3yGuuEmw1TKtGTq91gJxgndzoCSsRyGlq9nRTGChmonPihomT4
 Z1dm5yDGPsGqdtuAKuOqmMJ7qVlPLXL4K/WjXSUrCCmLHfNrPMPGXtTaGe5IOHdpJsTI
 pNdGB8qQiIyOwIDu0njUt5eVPOADdVluoUsTrkYqsaQuZeMLgAro6/Op9lYn/zcB565K
 5yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780007608; x=1780612408;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyEu49Z6M3fX0YH/zwu9x8ApPANqz7j3tAfBQMK/VsE=;
 b=jBcEa6aWC0331UmHSHKmZQde7GmRasWyFA008Q0H3OwlmXxU9tjaG4AsnUuBKd/BkL
 AlP+uDXXYSffOaqKBez4zdcyUQEfDEkxk11TFpeTr6vOPNgeWrI2ReVVl/BmAHvtejJ0
 8t0burBU0bAFJSZ3Rskq/odBo+xtYRW/Kbxr++rmVM6RHfDBHqkJ0ri6VllCDQZ+1+NP
 l7pyBTk5NOJZzD+HvG88wJyXkrDBQ6u2hNbPdbyHcI1J9ivGspTmMc1HdPSU1r8Cw9tc
 BpuOmaVK+JDTjCFcVQV7J4gXol06+9UQNO2/L19QfPJUPaaEtp6s2XPXM2Qbb0+LEapZ
 SkHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tHtP8xz89adONGkCPOXxzCYhj+WsJSR6uQsdGovmCrnmxsI3+PSafQytaCx8UANXWay5s0rFQrOQG@nongnu.org
X-Gm-Message-State: AOJu0Yw+7gpfNEp+xgjZiGPdXJnr2dOFqJ9pu1IiXDzriNjdToPWD6Es
 fX1DwL81ssnoDkpCcUbjenQzXs1vuiCKWBMQff/rdyPv0z/Lkk2ub40vHsj6ePhFFi8=
X-Gm-Gg: Acq92OFly+wM/i6TOTEPDk8cP+jLfMWcbFUVHstusYAPF5kIYCSTbehbyVsgxnAYC6Z
 6nbRX8akdgWfYUG4wU5u9eJ0PfMMvGfckmrZTFMLc5z5Jc137HRLb+H2w2ke6ooCcb9KUCg1GSZ
 ZoEtl9ix7p6BDmjUTYYc+DNTWvi4OA4Cg31JDe3OJF8ytoCHk9InG8p2P5OMwsoAEe20b4X3ftO
 ax7eOo0YrKho++baY/rF7PWTlNsfTuyYoIo3KHPzoAKwUJGprIHXrXhRvu6riu7BOsVVXu0F/Mx
 e2OuOnXOzwCy4jM+VYkuXMOq0TKQ/NSYhtw499vL4gTRq3ve3j5Rj/FL22grEAs/y4Y79lShNWb
 LeMts9NOsYvVT15P9cIeHZ8Dp1e/nr/Bc0NhM2aiLYwQqbLjaTGBRfEI/SZWqMsPV3hBxxIcl44
 dB359r3IgRKerLFZWwZoS4P3WJjAtdOw7/gRXkpU6A5+5mzglUHUHxkMvUZg==
X-Received: by 2002:a05:6a00:1742:b0:81f:9b4c:81c0 with SMTP id
 d2e1a72fcca58-84212d2ca6cmr102172b3a.41.1780007608072; 
 Thu, 28 May 2026 15:33:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d71f2d45sm6947492b3a.47.2026.05.28.15.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 15:33:27 -0700 (PDT)
Message-ID: <8b02d8c4-8fad-4600-8e0e-64c9914cc598@linaro.org>
Date: Thu, 28 May 2026 15:33:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/15] docs: add MTE4 features to docs
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
 <20260511-feat-mte4-v6-13-8557cc1313b9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-feat-mte4-v6-13-8557cc1313b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/11/26 07:01, Gabriel Brookman wrote:
> The implemented MTE4 features are now present in
> docs/system/arm/emulation.rst
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 5 +++++
>   target/arm/tcg/cpu64.c        | 8 ++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 8cd7fe7b00..c660074ec4 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -111,6 +111,11 @@ the following architecture extensions:
>   - FEAT_MTE3 (MTE Asymmetric Fault Handling)
>   - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
>   - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
> +- FEAT_MTE_PERM (NoTagAccess memory attribute)
> +- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
> +- FEAT_MTE_STORE_ONLY (Store-only tag checking)
> +- FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
> +- FEAT_MTE_NO_ADDRESS_TAGS (Address tagging disabled)

These should be alphabetically sorted.

>   - FEAT_NMI (Non-maskable Interrupt)
>   - FEAT_NV (Nested Virtualization)
>   - FEAT_NV2 (Enhanced nested virtualization support)
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 649d854a65..77b8c2a0a9 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1291,8 +1291,16 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
>       t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
>       t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
> +    t = FIELD_DP64(t, ID_AA64PFR1,
> +            MTEX, 1);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */

Better as

     /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);


r~

