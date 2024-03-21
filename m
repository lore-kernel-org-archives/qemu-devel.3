Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442FFC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFDW-0005Cx-7s; Thu, 21 Mar 2024 06:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnFDV-0005CB-5M
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:00:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnFDQ-0006tm-7u
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 06:00:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56b857bac38so397583a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711015202; x=1711620002; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VoKRH/EywjLkbCKh6mWJyNVhDWMOYCJQkBm9THdcC9Y=;
 b=mf4ec/YyNHpAnho/F2RIV5ASkJk5bXDVvEXGhAkfrWbJUd6TKMnzS4sn9UJ4ce3Rag
 Nq7tkBVhwuOYD29NVJjMKHLe0ecrR9EsN37VMP6zxDKuvDCJvCauTvKT0/SfVGcZmy//
 J6biilZ9wOPo3Y96a1rATngkPCRElaENkiwyLOKtsloCK+LqPMTzXuutEFZtN//YZ4L0
 +rNS5lSaqBqKAtwOZ7gCTfrahYKm2JiqGM8YWVriiPNaT5W9/kluP2uoTZtv0y79WTdx
 vU5Q4oLSXX8CZeFaxIoF9+51Txy7lx2WmdwthGlg5sCSnkJmBox2Lf5sBtsT4KcvYcGw
 wVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015202; x=1711620002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VoKRH/EywjLkbCKh6mWJyNVhDWMOYCJQkBm9THdcC9Y=;
 b=aMQ0i3QQ9u66gf2uGuvKSKt7v4orPLd07jRvXRHsfvH5N5lh/d1VZKHnsk4kBE/scq
 /sjUYyo81RHNsEbDLRGyrjB8y+WLC2To+m/UPl3FAQt79PI+OXPQs5mKw10lSz3CNvev
 zKyJx459bONzvvDY2XgurmrYjB8sGrr2S7LwyekHflX1LmOzv6Z5vJLCmPQY8C/blB3N
 iZZRMeHCrrY5aE8KBhnsjhlSaXsheKri6/ObSORjWJUGhOsKfh/GaaWeElqtJMrWXeZN
 9T7OIfiRtB5kZ19F02L8QVAawzwhdIHlrGZg8raMLAX0j/OlWpfNAjbEXXJq0hymajiE
 JeQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGsoE4+CaQefzMsExPACbpDwo3d4wh7EMm+iC1GMh6Ay4S7T9oj8agbq4i8po4zJ9HrQA+PrHyAYqrWs4cFpL9JNwf57E=
X-Gm-Message-State: AOJu0YwL5vtXWh4KYVMU2DLOsGOjkAt6kbYISG7T6xVxB42P8/NmkJfO
 Sc7le7IGqwP6+vE5RibgB9MsT9eOmm9WS5K2UoEv+bkW8s8XDBy+pl696/i1CRc3KyM4cDUAqNa
 kcpDk9ajEGUjQdSPwS8knDNT1RGL+lhJ3zUoCrg==
X-Google-Smtp-Source: AGHT+IHWaNHLcifyfFnTy4Ut84tUQ/5g4YQ+uX5RnGmkYN1IJNWePScSw4kwhRW1mkmhXUWaHAYkS+qeuL1y8+uN6f4=
X-Received: by 2002:a50:d6cb:0:b0:568:b5d3:2b89 with SMTP id
 l11-20020a50d6cb000000b00568b5d32b89mr1464840edj.31.1711015202388; Thu, 21
 Mar 2024 03:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-7-ruanjinjie@huawei.com>
 <CAFEAcA_xSHAJnn0_O9=zGo9u8omzhuB_WvuMo9gf7wKt8OVDmw@mail.gmail.com>
 <90475c65-f148-9f49-8c5b-ea55137e1a6f@huawei.com>
In-Reply-To: <90475c65-f148-9f49-8c5b-ea55137e1a6f@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 09:59:51 +0000
Message-ID: <CAFEAcA-3O2p3MPMGbV3TBAzjrWncSp7XzE+N4KV_Y7wS1RmRoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 21 Mar 2024 at 09:27, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/3/20 1:28, Peter Maydell wrote:
> > On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >>
> >> This only implements the external delivery method via the GICv3.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> v8:
> >> - Fix the rcu stall after sending a VNMI in qemu VM.
> >> v7:
> >> - Add Reviewed-by.
> >> v6:
> >> - env->cp15.hcr_el2 -> arm_hcr_el2_eff().
> >> - env->cp15.hcrx_el2 -> arm_hcrx_el2_eff().
> >> - Not include VF && VFNMI in CPU_INTERRUPT_VNMI.
> >> v4:
> >> - Accept NMI unconditionally for arm_cpu_has_work() but add comment.
> >> - Change from & to && for EXCP_IRQ or EXCP_FIQ.
> >> - Refator nmi mask in arm_excp_unmasked().
> >> - Also handle VNMI in arm_cpu_exec_interrupt() and arm_cpu_set_irq().
> >> - Rename virtual to Virtual.
> >> v3:
> >> - Not include CPU_INTERRUPT_NMI when FEAT_NMI not enabled
> >> - Add ARM_CPU_VNMI.
> >> - Refator nmi mask in arm_excp_unmasked().
> >> - Test SCTLR_ELx.NMI for ALLINT mask for NMI.
> >> ---
> >>  target/arm/cpu-qom.h   |  4 +-
> >>  target/arm/cpu.c       | 85 +++++++++++++++++++++++++++++++++++++++---
> >>  target/arm/cpu.h       |  4 ++
> >>  target/arm/helper.c    |  2 +
> >>  target/arm/internals.h |  9 +++++
> >>  5 files changed, 97 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> >> index 8e032691db..e0c9e18036 100644
> >> --- a/target/arm/cpu-qom.h
> >> +++ b/target/arm/cpu-qom.h
> >> @@ -36,11 +36,13 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
> >>  #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
> >>  #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
> >>
> >> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
> >> +/* Meanings of the ARMCPU object's six inbound GPIO lines */
> >>  #define ARM_CPU_IRQ 0
> >>  #define ARM_CPU_FIQ 1
> >>  #define ARM_CPU_VIRQ 2
> >>  #define ARM_CPU_VFIQ 3
> >> +#define ARM_CPU_NMI 4
> >> +#define ARM_CPU_VNMI 5
> >>
> >>  /* For M profile, some registers are banked secure vs non-secure;
> >>   * these are represented as a 2-element array where the first element
> >
> >> @@ -678,13 +687,31 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
> >>          return false;
> >>      }
> >>
> >> +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
> >> +        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
> >> +        allIntMask = env->pstate & PSTATE_ALLINT ||
> >> +                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
> >> +                      (env->pstate & PSTATE_SP));
> >> +    }
> >> +
> >>      switch (excp_idx) {
> >> +    case EXCP_NMI:
> >> +        pstate_unmasked = !allIntMask;
> >> +        break;
> >> +
> >> +    case EXCP_VNMI:
> >> +        if ((!(hcr_el2 & HCR_IMO) && !(hcr_el2 & HCR_FMO)) ||
> >> +             (hcr_el2 & HCR_TGE)) {
> >> +            /* VNMIs(VIRQs or VFIQs) are only taken when hypervized.  */
> >> +            return false;
> >> +        }
> >
> > VINMI and VFNMI aren't the same thing: do we definitely want to
> > merge them into one EXCP_VNMI ? It feels like it would be simpler
> > to keep them separate. Similarly CPU_INTERRUPT_VNMI, and
> > arm_cpu_update_vnmi() probably want VINMI and VFNMI versions.
>
> It's not like that. The VFNMI cannot be reported from the GIC, there
> will be no opportunity to call arm_cpu_update_vfnmi().

The GIC can't trigger it, but the hypervisor can by setting
the HCRX_EL2.VFNMI bit. So writes to HCRX_EL2 (and HCR_EL2)
would need to call arm_cpu_update_vfnmi().

-- PMM

