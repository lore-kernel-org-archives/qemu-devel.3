Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705FCCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkV9-0006l5-IU; Wed, 03 Sep 2025 06:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkV0-0006im-SC
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:13:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkUy-0001Fb-NU
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:13:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3d17f24d42fso2820974f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894430; x=1757499230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H8MEOlu+ZLnCYWq9U+SwRnL4mE3qsCJOFbby9kyvWxQ=;
 b=BVxkr80AUi3gVhDDNKBn6DfyeifmqcGPBP17jltSDPJVU3Sr6+BsqwOMZ1Kej2n7AA
 9vLr0y2qv5M4+d2BGjMwNVNPXFOM7OZKybLQJCZbUAouyc67r6G+aX5czFH/MJ/T2m3e
 GwxAxU6C3urfO8oABCeBByIOUStBoh2xAbZ8bPSruy2E4pagO3rCWYq7Wwkkx8mSsf3C
 iynx9uH5I+cNLe5EL3FsAtXmsPB23QZ+kpmuVrhEw7FFalNpAG3bBrw7up209GozI2RJ
 e5zShd7qCWfnZA5a5SZ+hrM0dktgf8guA+wYxp34/isuBPBqi4m7mnuo7U428Ovn1zMi
 zeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894430; x=1757499230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8MEOlu+ZLnCYWq9U+SwRnL4mE3qsCJOFbby9kyvWxQ=;
 b=W7CdVvwYL+Pd+h8x1vqFnAxBVrticU3gswwiSc8mHgDrI7oP4vQGFGgfyUrIj0db51
 9mSUwVmbKe4w2NV9SE+9ER3ognFJDz5A14gGEsl6HouoOfTzZEW+KrGjWTuhyPyJfEqU
 Ei3Mk6qQD4X376k9fO2lCmE1V/b6tNgxYTQpsa1jE7TRcB3DSRBmOvtnDSh1/kYpqhbt
 Rzk6bVV6zTDZmrlXvbQPGMbSznRHiL3nWMLACxi5azkK3gZK50kX7BUDI6mdvyhLKKN0
 qJ3Px0JzqvFQT4L3KVEiOCyd+FvWVYG0OyFRJ0Rr8rP86B//kAa+hfhLMqcomcM080RA
 F9Ow==
X-Gm-Message-State: AOJu0YwaE9vDbMae/HM3I0yuRM1KCpa8qXTUd0av5oC5hZ/d9oYKTSYR
 2WqHBmGb907TFLLEa9p7r8/Bry/UFWjvuwE/s5rg8hFFjLlhQdeRc+PDCUBKjsByY5klsjn6U3o
 SpWJzChU=
X-Gm-Gg: ASbGncv65YEW8Pu35CLLehvAYR6BZlJhc1W4W2uBHU1EhVyWCuZr/PfwwEyzYpMW+Rr
 DVn/83eJ8qSRQYUWS+WGE+dU0Cd9VoJA7xyWkaFPHn7ggdF1dU2E0/7eUy/AJGf3/f5C6JNhsqD
 ZRtnk7idkFBI/FjPV6jw9jDULEqrlD6aM8UKzPUSjeYV2u1zSkN4GKt1Wj2nvymga/nbVitME/f
 M69GsqdeAkwQPrJsIryxZeO2aOZkUJTuwjeOWzZsGpllDQLhdYBK2IYw+3Rtm/DT6c7xxhqCXHs
 osP865EaCiLmIS2Mvz2LKiNxP0j86iwPHDuuswyc4YCX/6Kk6hxNeDvsMjbieIy5cLDMrAMLt7c
 16zA7kePK4idCHgDRczrZb7d1Nnde9yo+u4VBWPYGgTYVIuqH6WhpKtGHysRSa4HYBE+vX9yltw
 ==
X-Google-Smtp-Source: AGHT+IEZBlYYxgLC6rPAJ8IpPPqweMoustDZlgwasiTmSY3Ir+zlUb+1uhHHxPPq9M1SkfiP5MaQRA==
X-Received: by 2002:a05:6000:24c3:b0:3dc:364d:8de6 with SMTP id
 ffacd0b85a97d-3dc364d903dmr2352048f8f.54.1756894430228; 
 Wed, 03 Sep 2025 03:13:50 -0700 (PDT)
Received: from [10.223.47.213] (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d60cf93cb2sm14261737f8f.12.2025.09.03.03.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 03:13:49 -0700 (PDT)
Message-ID: <b12ea41c-4db5-46d5-a40b-888c69e9a1c0@linaro.org>
Date: Wed, 3 Sep 2025 12:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] target/arm/hvf: switch
 hvf_arm_get_host_cpu_features to not create a vCPU
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-16-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250903100702.16726-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 3/9/25 12:06, Philippe Mathieu-Daudé wrote:
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Creating a vCPU locks out APIs such as hv_gic_create().
> 
> As a result, switch to using the hv_vcpu_config_get_feature_reg interface.
> 
> Besides, all the following methods must be run on a vCPU thread:
> 
>    - hv_vcpu_create()
>    - hv_vcpu_get_sys_reg()
>    - hv_vcpu_destroy()
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20250808070137.48716-3-mohamed@unpredictable.fr>
> [PMD: Release config calling os_release()]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 36 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 3039c0987dc..fd209d23c1e 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -869,24 +869,25 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>   {
>       ARMISARegisters host_isar = {};
>       const struct isar_regs {
> -        int reg;
> +        hv_feature_reg_t reg;
>           uint64_t *val;
>       } regs[] = {
> -        { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64PFR0_EL1, &host_isar.idregs[ID_AA64PFR0_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64PFR1_EL1, &host_isar.idregs[ID_AA64PFR1_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64DFR0_EL1, &host_isar.idregs[ID_AA64DFR0_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64DFR1_EL1, &host_isar.idregs[ID_AA64DFR1_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
>           /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
> -        { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
> -        { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64MMFR0_EL1, &host_isar.idregs[ID_AA64MMFR0_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64MMFR1_EL1, &host_isar.idregs[ID_AA64MMFR1_EL1_IDX] },
> +        { HV_FEATURE_REG_ID_AA64MMFR2_EL1, &host_isar.idregs[ID_AA64MMFR2_EL1_IDX] },
>           /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
> +        { HV_FEATURE_REG_CTR_EL0, &host_isar.idregs[CTR_EL0_IDX] },
> +        { HV_FEATURE_REG_CLIDR_EL1, &host_isar.idregs[CLIDR_EL1_IDX] },

I'd rather add the 2 last ones in a distinct patch, keeping
this one as a simple API conversion.

>       };
> -    hv_vcpu_t fd;
>       hv_return_t r = HV_SUCCESS;
> -    hv_vcpu_exit_t *exit;
> +    hv_vcpu_config_t config = hv_vcpu_config_create();
>       uint64_t t;
>       int i;
>   
> @@ -897,17 +898,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                        (1ULL << ARM_FEATURE_PMU) |
>                        (1ULL << ARM_FEATURE_GENERIC_TIMER);
>   
> -    /* We set up a small vcpu to extract host registers */
> -
> -    if (hv_vcpu_create(&fd, &exit, NULL) != HV_SUCCESS) {
> -        return false;
> -    }
> -
>       for (i = 0; i < ARRAY_SIZE(regs); i++) {
> -        r |= hv_vcpu_get_sys_reg(fd, regs[i].reg, regs[i].val);
> +        r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg, regs[i].val);
>       }
> -    r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
> -    r |= hv_vcpu_destroy(fd);
> +    os_release(config);
>   
>       /*
>        * Hardcode MIDR because Apple deliberately doesn't expose a divergent

