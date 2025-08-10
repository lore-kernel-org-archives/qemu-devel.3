Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F446C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 20:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulCUh-0006hm-9E; Sun, 10 Aug 2025 16:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulCUf-0006ez-4h
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 16:18:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulCUd-0000Na-Gb
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 16:18:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b42348bae1fso2068796a12.0
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754857089; x=1755461889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1zboHadwnpuOEDviK37mMh0jOpWEoMe00cCDcaExxuI=;
 b=xWqVAgZkNsIM9tpEuJOnkCRj77Brwn6y6ABevGVRfQgZiT2afAZcZkr//u82jgUKZX
 HTyYbXSRjof3afdPRTW86jCSRzrrCpHo8aUqxdOfrSX6tGCjrISYN5/9kW2Xrk2nENrw
 Mcq4Wta/0cQ2XpyE6MAAX/5WbRs3w20/BpWAk80YzWJazi0MagpM/1xh+VONY03Zv2bM
 9lfvnf3I4gLNM9iWIjEjN0+5NNzgljjc3uPsEequlBJawXZjBHEB755ApHh4r9+SMzFj
 pDaOVn0df4e0ixgXl/5aYv9z6byxCwPIvuLIdt4q0CMFORocVryTpcWAOLy+FYoV/Em/
 HeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754857089; x=1755461889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zboHadwnpuOEDviK37mMh0jOpWEoMe00cCDcaExxuI=;
 b=Kb+emuYVyDZ9ghNPSYorQrM767NW/es1PW/DiG+J21BJM1e2MBnD23ulTYrtbN+pf6
 PEk5HKp/dGhTjHl5IKTV+rf6I2pEr9C4i/p4utZRhiiTJQCc99izK2vi3ikavj/OQd1G
 pfwtohG9FVagqAhrRGlhqg/Yh1CzCW31Kp29PEmmaNYv3WnbleA0edkTOEgeTh1XFodk
 x87VSckP1QV43pOAp5zsPisEZBl/EfkSEe4Ua350ErWX0YgojRbN4qN+KOgB26Z9Gp4m
 PWosEciYh9tkVlgw4z5sHZ3Gdo289L/YFE/pwBX0S4xVzsA68BEPMPB99zhMiBUvYswS
 UYWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+w5IMtBLF+vqfCOQXXFkXqJm+RsoheaIE/vIW3Nn1+8nbvMGKykZKUd02iZ+sp4xiNhK8ZXASPMl@nongnu.org
X-Gm-Message-State: AOJu0YyiRjmPF1Nx8iekB1dDz/Dpameg8JcB6Wg0FBgWIzJZdpnw2gWI
 D6yQ9FBjYwtjsVXDc/niTRxt5sTUgQpPS4VbdOrsu9opZANtfJeubvVXI9k2p+g+Sz0=
X-Gm-Gg: ASbGnculyhv8jZ58YXUBxQri1Q/gEhj/xPZR+fvbcwk14xKmZP4kQtakTbt8hM5nPYL
 fsnCJj69qFEaTKrmAzgNHWO9SWUFicgYYJ+u84AIetaEP/GuwS8tBze0QgeMXcB8p1LwA7J0e/M
 dFA6VEXRR1Adywt5L6Ikh8p7MLCZE3lBZqmsU5WfUs9qdOS2uujdkwrbM1/TI66Dqap71BAQYO7
 Ou98RlPqfvR2LWviNvAU/PbEgIJgmg/JGKpZ9JMBl9jw7TVunMBpnkWqpuw/dF1/fTjYKwensPn
 6jRDlR09gp7zeIDz2Va4hywCdmE08bZ4EaGvw9i/iACa4iebYImCqwX3uE5AAhDQakVpJm7p+ll
 FEDhp6Gppj2lM4W/qOSeDd5cZZFzgQ0u3KFSIDq0=
X-Google-Smtp-Source: AGHT+IFpZoeGq84WkAfMXR03bWBYQR9aCOsos3R9rbTvJ4uVuMcfU5MDk1GGICLenSe8zvPp1bRjuw==
X-Received: by 2002:a17:902:c946:b0:240:3e72:efb3 with SMTP id
 d9443c01a7336-242c22544e0mr152689335ad.43.1754857089381; 
 Sun, 10 Aug 2025 13:18:09 -0700 (PDT)
Received: from [172.24.214.227] ([144.6.205.142])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6713sm255252245ad.12.2025.08.10.13.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Aug 2025 13:18:08 -0700 (PDT)
Message-ID: <28ca222f-71c1-43e8-8164-39ddf1a14c38@linaro.org>
Date: Mon, 11 Aug 2025 06:18:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/arm: Code refactoring of pmreg_access/pmcr
To: Smail AIDER <smail.aider@huawei.com>, qemu-devel@nongnu.org
Cc: alexander.spyridakis@huawei.com, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, zhangyue165@huawei.com,
 liuyutao2@huawei.com
References: <20250801090645.2205449-1-smail.aider@huawei.com>
 <20250801090645.2205449-3-smail.aider@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250801090645.2205449-3-smail.aider@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 8/1/25 19:06, Smail AIDER wrote:
> Create a common helper for pmreg_access and pmreg_access_pmcr to improve
> readability.
> 
> Signed-off-by: Smail AIDER <smail.aider@huawei.com>
> ---
>   target/arm/cpregs-pmu.c | 40 +++++++++++++++++++---------------------
>   1 file changed, 19 insertions(+), 21 deletions(-)

The squash of these two patch is what I asked for.

> 
> diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
> index 3aacd4f652..adaaaf2517 100644
> --- a/target/arm/cpregs-pmu.c
> +++ b/target/arm/cpregs-pmu.c
> @@ -228,22 +228,28 @@ static bool event_supported(uint16_t number)
>       return supported_event_map[number] != UNSUPPORTED_EVENT;
>   }
>   
> -static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
> -                                   bool isread)
> +static CPAccessResult do_pmreg_access(CPUARMState *env, bool is_pmcr)
>   {
>       /*
>        * Performance monitor registers user accessibility is controlled
> -     * by PMUSERENR. MDCR_EL2.TPM and MDCR_EL3.TPM allow configurable
> +     * by PMUSERENR. MDCR_EL2.TPM/TPMCR and MDCR_EL3.TPM allow configurable
>        * trapping to EL2 or EL3 for other accesses.
>        */
>       int el = arm_current_el(env);
> -    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
> +    uint64_t mdcr_el2;
>   
>       if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
>           return CP_ACCESS_TRAP_EL1;
>       }
> -    if (el < 2 && (mdcr_el2 & MDCR_TPM)) {
> -        return CP_ACCESS_TRAP_EL2;
> +    if (el < 2) {
> +        mdcr_el2 = arm_mdcr_el2_eff(env);

Move the declaration here too:

	uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);

With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

