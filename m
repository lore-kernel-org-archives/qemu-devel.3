Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C75CCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIk13-00024h-2O; Fri, 01 May 2026 05:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIk0x-00022e-Ej
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:18:27 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIk0v-0006KX-Oc
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:18:27 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so18646085ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777627104; x=1778231904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jXCkrC//GCi2/XK24O9hImxLbMG3Cjkj39H9Her/RJM=;
 b=jlHBiAtnULY27J3qqIpE2CC1xmTtmQFjqlSokPsTNFTZGY+9yJf+QSgv68VzIVIu0m
 YuyyKlvgVB4K4uoyi8BQI2fFqdJPPtokUzQJA2Lmj91sNRIHxsnEOL+r/yVQNNozyYp+
 WYpe7jJ8KCE7MaUL7Oi36KyBlYCiN1LNIs/Zri8PGgRDX4fDudQtzCNxg+YZcWe12UYB
 4Z20L7AzLMb38qnIyQsb/DDIh8/MT+m2jggqbx1aI0gNu6KH+XZaRfjySwJcRgNXEO9B
 7ctyUWJ45ytFp9pogrdgiOyrPQ4Qoc504MOgxkgQkEYZPWqbe38fwkE9aVLkd/wAzK8u
 6tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777627104; x=1778231904;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jXCkrC//GCi2/XK24O9hImxLbMG3Cjkj39H9Her/RJM=;
 b=TvzMIuyrpRY6iE9aeD+L3QxlMx584oJbWjji/ZuDb8+iADf43C+w5ZemyeS61ZyOu5
 iCa2ume4oH/QDCjw6fkBOQqmG5C/H2F175emFgE6jk76BX/J6lCKS9ePXrGh1A0sTMF5
 G2suJyXgAzaOnnqzj9AI3nDHN3MpYLshge3nJK0e3n2gagducpx164afh0t5b3fdgP11
 Xv0ZuEVJhN9h9d5sNG7GVluruYdMBCIDWisvdbZDIWXG5sG9M8khwWjc6oBpTKsk+93e
 /10/dDUvSZGiHb3kOb2udBU0FvQTpVk0Wp/MVqonfvBv05hWZ8Q0olJfdMy5u60750n0
 Pfpg==
X-Gm-Message-State: AOJu0YzfGXmdAueVyU7acK2su44dvsuinksHinBaXi/H4L5RgIaMp6p6
 s+BMaS1IeJdWmBnIqqOsIHPf5iJbUGuA1qjTiyv9ktFLn2j7pVfw0FJGaWDxdGb/6TIMPUDh1Tc
 +6G1AmJE=
X-Gm-Gg: AeBDietTl57Vx2XaFVQYMZxX+nirQ5X8+9gW4IWn23gdrx436XfUcCwziBvMgP1fO2s
 +FwdNLwtO0RGy+sTmz+VhNSGdWnXBhm2/Wr5Wt9llPOnAJ9OW20glJ+a759Y/ayVN51ewP3Z0B3
 5O0u8+pxU8POvbkt5VKvLd3U+MVZvUlqopxvVOz6p/v0UM5EhL+wu1gvEvt8NdmET9Q+t3gMJDk
 zfBOeVEXeqnNIx7qLiqGSnHX7csRV0sq0e8chJ8IxqEq1AS/pGTlsorvmGhmfsEFY5eQRvxL9cD
 47om1x6Dyqr+srpiAFV2ImYIigVhjiNnAIqwDDEH3UtHOunNuCSpuIR3Vn5YvvybehGc8e8ork+
 PtUweirMrTJAjkSHqy4YTB9u6W6Nb0Y49whIVGaXj6klN1MOOzAbks1erzec4ALQGJMuzIE3Wa3
 mAEXSKkrYnMPuXpPTBXzxiTNyihpPUGP3rXItiyxFLYOs0qV/8PYRk
X-Received: by 2002:a17:903:120f:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2b9a44e3639mr55661835ad.20.1777627103916; 
 Fri, 01 May 2026 02:18:23 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae110acsm16459795ad.42.2026.05.01.02.18.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:18:23 -0700 (PDT)
Message-ID: <58b6b468-1894-46ed-adce-2eb6d356826c@linaro.org>
Date: Fri, 1 May 2026 19:18:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] target/arm: teach arm_cpu_has_work about halting
 reasons
To: qemu-devel@nongnu.org
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
 <20260430104434.1482407-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430104434.1482407-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/30/26 20:44, Alex Bennée wrote:
> With the advent of WFE and WFI we need to pay closer attention to the
> reason why the vCPU may be sleeping to figure out if we should wake
> it up.
> 
> Create env->halt_reason to track this and then re-order the tests so
> we:
> 
>    - ignore everything is the vCPU is powered off
>    - wake up if the event_register is set and we were in a WFE
>    - otherwise any IRQ event does wake the vCPU up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - move arm_set_cpu_power_state to internals.h
>    - drop excess brackets
> ---
>   target/arm/cpu.h           | 16 +++++++++++++++
>   target/arm/internals.h     | 11 +++++++++++
>   target/arm/arm-powerctl.c  |  4 +++-
>   target/arm/cpu.c           | 40 +++++++++++++++++++++++++++-----------
>   target/arm/kvm.c           |  5 +++--
>   target/arm/machine.c       |  2 +-
>   target/arm/tcg/op_helper.c |  3 +++
>   7 files changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index be14a47c357..357359011cb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -257,6 +257,19 @@ typedef enum ARMFPStatusFlavour {
>   } ARMFPStatusFlavour;
>   #define FPST_COUNT  10
>   
> +/**
> + * ARMHaltReason - the reason we have entered halt state
> + *
> + * To be able to correctly wake up via arm_cpu_has_work() we need to
> + * track the reason we went to sleep.
> + */
> +typedef enum {
> +    NOT_HALTED = 0,
> +    HALT_PSCI,
> +    HALT_WFI,
> +    HALT_WFE
> +} ARMHaltReason;
> +
>   typedef struct CPUArchState {
>       /* Regs for current mode.  */
>       uint32_t regs[16];
> @@ -760,6 +773,9 @@ typedef struct CPUArchState {
>       /* Optional fault info across tlb lookup. */
>       ARMMMUFaultInfo *tlb_fi;
>   
> +    /* Reason the CPU is halted */
> +    ARMHaltReason halt_reason;
> +
>       /*
>        * The event register is shared by all ARM profiles (A/R/M),
>        * so it is stored in the top-level CPU state.
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index a632584a4e0..4a1ea5465d7 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1997,4 +1997,15 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
>                                          ARMCPRegMigToleranceType type);
>   
>   
> +/**
> + * arm_set_cpu_power_state() - set power state synced with halt_reason
> + */
> +static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
> +{
> +    CPUARMState *env = &cpu->env;
> +
> +    cpu->power_state = state;
> +    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
> +}
> +
>   #endif
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index a788376d1d3..4ca63a54443 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -78,6 +78,7 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
>   
>       /* Finally set the power status */
>       assert(bql_locked());
> +    target_cpu->env.halt_reason = NOT_HALTED;
>       target_cpu->power_state = PSCI_ON;

Use arm_set_cpu_power_state.

>   }
>   
> @@ -186,6 +187,7 @@ static void arm_set_cpu_on_and_reset_async_work(CPUState *target_cpu_state,
>   
>       /* Finally set the power status */
>       assert(bql_locked());
> +    target_cpu->env.halt_reason = NOT_HALTED;
>       target_cpu->power_state = PSCI_ON;
>   }

Likewise.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

