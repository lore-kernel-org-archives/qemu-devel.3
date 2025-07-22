Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4080C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 15:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueFLu-0006xU-E2; Tue, 22 Jul 2025 11:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueEcF-0005Cx-2P
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:09:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueEcC-0001QS-7E
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:09:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23f8bcce78dso11664535ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753196949; x=1753801749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5EhoVYjPL9YcbUccrBG87A+NbeYnGdLHumlMWjuLWUA=;
 b=kwbnMkO4I2jWxXiganNNNRFuNL6k+vkUlc1rwPyjiG8pJAJWGA+Ux4XlM5xyt1WI51
 OokLgZp0pwpnWGyAk89+Kxdxvq/vR7gGDve/Sv7kDNKyUR5b7Eg8R5rfdlJDHQFyewfj
 tcD5RcsPNwk3sFteJ3gl8d3hBivMOL1HbqczlMy8SADFeAHnJq3O0U5T9BMJOYLqTV6W
 6uit8YALUForuEzesY+4XapqIFNl4KVIz9YnQ6iZhlM98FkB4s7HQSj1W2MZFU7QCOsP
 rtFolauEotyYjv6Y55Faobx1s+jsgknGp6QFT74hYVuD5DhNuqtNKxzUm9hRJfO+HF2x
 kp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753196949; x=1753801749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5EhoVYjPL9YcbUccrBG87A+NbeYnGdLHumlMWjuLWUA=;
 b=iW5CZISL58VDibe47JPszwCcbzGU44kY+xCcDsX1EDToiazdxB3O6hiEi6lf5F/dHP
 1aFOoMXPMyE5gaxda9X/ax5raAjb1ubW3wb9AqwlsdGy9ToyFogd2LFprfea2JgQQf12
 PpRskcFP2NmtESKRjfRMh2BMAY6TgFYfkRKTFj26kxDArUWRCmvHvwFfjJP0QV3y7sZV
 pX4SVILOkbV+SBI7jmvFoT8LM9capmrdniIA+V65x5Mgv1EaMDYv0NzIS0NkkMES+SUk
 LabO7EFPlbnhGO0BPI/e7B3YKZLMNWnwrSunNsCVoybofS9gTN2Z3ik4bGGHOtH8moae
 xq3w==
X-Gm-Message-State: AOJu0YzNq/nnPY7gNpc2UK2xxnrVa2mrTq+I4tW2RyWIZlvRWPYOyfBv
 15dXo8p4nlUsxctJ/Vm5hXpccARaAum1w5LnjYIxJHduvADBSz1Di+Jh1Q3GhLnYQKchv0oAX89
 VoMot
X-Gm-Gg: ASbGncukozCCmkJAmHOdzFqdztB7m02MCHulDNBQaYS+p7YNYHR/DJgn2uxjxUMR/Qy
 Ff9dasnv2uiU7LKjdUqiw2wyo346ZYmpDaA+BnAoib/7q9egapO1sa69WrSkDNiN6ro1zPQYu2R
 t46LyrY6rH6+o6Gr7CxpLzPD2nFBBZgOgrlsNK5XKGE2jWfUd8+UCgBEZMREIr5PtYQrtJFMyRn
 gdVeuaNLj7HR4v2TBeua9EBzDPBDvGP1MBBKlkLuI0tEp/jI8qSMmsJ1TYbN6gEwxHEhImGy3KS
 2a9NBq5kqpX5SIZoOI0kNOCAOTT+QLQ0QUTBHVa4wEwV78gjXSMWZCnPW15UwJ1Op1uA8Z1+V9a
 W8FZWXgSCQy4nNwOQrlSH6YabrADJEqvcihjV
X-Google-Smtp-Source: AGHT+IH6pT5MpyvU6VlmtEfBVkGxPMxABC7LINsQWOHaBO5H610cvJSeGkldVvdN1VBOjRxF0oyatQ==
X-Received: by 2002:a17:903:8c5:b0:23d:da20:1685 with SMTP id
 d9443c01a7336-23e302821f4mr268294545ad.4.1753196949343; 
 Tue, 22 Jul 2025 08:09:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e2ca8sm78726245ad.28.2025.07.22.08.09.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 08:09:08 -0700 (PDT)
Message-ID: <b810c63b-7650-49a4-a41f-9065d44208e9@linaro.org>
Date: Tue, 22 Jul 2025 08:09:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
To: qemu-devel@nongnu.org
References: <20250722131925.2119169-1-smail.aider@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250722131925.2119169-1-smail.aider@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/22/25 06:19, Smail AIDER via wrote:
> Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
> Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
> accesses to the PMCR register to EL2.
> 
> Signed-off-by: Smail AIDER <smail.aider@huawei.com>
> ---
>   target/arm/cpregs-pmu.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
> index 0f295b1376..3aacd4f652 100644
> --- a/target/arm/cpregs-pmu.c
> +++ b/target/arm/cpregs-pmu.c
> @@ -252,6 +252,26 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
>       return CP_ACCESS_OK;
>   }
>   
> +/*
> + * Check for traps to PMCR register, which are controlled by PMUSERENR.EN
> + * for EL1, MDCR_EL2.TPM/TPMCR for EL2 and MDCR_EL3.TPM for EL3.
> + */
> +static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                   bool isread)
> +{
> +    int el = arm_current_el(env);
> +    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
> +

This could be improved by not computing these until they're needed.

> +    CPAccessResult ret = pmreg_access(env, ri, isread);
> +
> +    /* Check MDCR_TPMCR if not already trapped to EL1 */
> +    if (ret != CP_ACCESS_TRAP_EL1 && el < 2 && (mdcr_el2 & MDCR_TPMCR)) {
> +        ret = CP_ACCESS_TRAP_EL2;
> +    }

Or by creating a common helper for pmreg_access and pmreg_access_pmcr such that those 
values only need computing once within the common helper.  That could make the code more 
obvious as well.

E.g.

static CPAccessResult do_pmreg_access(CPUARMState *env, bool with_tpmcr)
{
     int el = arm_current_el(env);

     if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
         return CP_ACCESS_TRAP_EL1;
     }

     if (el < 2) {
         uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);

         if (mdcr_el2 & MDCR_TPM) {
             return CP_ACCESS_TRAP_EL2;
         }
         if (with_tpmcr && (mdcr_el2 & MDCR_TPMCR)) {
             return CP_ACCESS_TRAP_EL2;
         }
     }

     if (el < 3 && (env->cp15.mdcr_el3 & MDCR_TPM)) {
         return CP_ACCESS_TRAP_EL3;
     }
     return CP_ACCESS_OK;
}

static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
{
     return do_pmreg_access(env, false);
}

static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
                                         bool isread)
{
     return do_pmreg_access(env, true);
}


r~

