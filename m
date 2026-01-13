Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86033D2D108
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfewF-00069N-QZ; Tue, 13 Jan 2026 09:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfew3-00066t-QV
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:59:53 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfevz-0000wd-R2
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:59:51 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-792768a0cd3so26897187b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768312782; x=1768917582; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3q9+VKXfc1yBHSTbPVSTTCsIYHQBqS+OGCzLqF0AHo=;
 b=R39QTo74yffIZERFo7zdUMS5Yt83LrBIvtggLcLEQO20pnASAv7aiBqmykHIqVvy+1
 W59mvXQ6xXQefVt5LmkYPp7j9WwjBycIdKhsjT22zdMWTfii8mzuoPriEIf+2Axy0BKc
 6jTr0s7PTT6QMtX0jA3Kf5wlpnwgeMsbgYrzm9A28J7RKPGScfB1tUkGHhZ9kgk9KRZ6
 +77zS44+QGJM4/gTSTaQ1eO+B8Lq7H1NICAsgOHVG1n40FFGi5Wb4HFB0GZKUnPKV4gg
 Ee0algk5NFj/e7MJEs7kVAlkPYtKhFJm7qw7STcbHfeSD1zQGd7W5usOiNZw7uMWIFA6
 ZXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312782; x=1768917582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3q9+VKXfc1yBHSTbPVSTTCsIYHQBqS+OGCzLqF0AHo=;
 b=aai0cMYHFxMrQ5IdvpuYG+4U/5PkYbMLH1EtvQIaPnN8EGt9CLiYg41PTTYEsX/6kX
 KnfKeyvBBeMOWCo5WM5tMOqN9V2wBr900YxMqwjzCUaxj1y81PtyGgtZlhMopiRZcFVT
 XqQVTYYUBsc5pYwHBERJkQueoVffJPI9ixEuwSHnN9nZ3vWYp1ZXcsNtQ2i9xa2BaB6C
 0NDZeAMZsWWZnRBSpnCwC5xnEviUt9YzTpmg4FpGlH7mCeqAS7VfS8bKVleZ05NrIQXa
 Atfsvwm5b1qHdB/k34SAWzyc/TZDoIb62hd9K6opwXPHUYNm2N3lbFijyghrStFpKtvV
 5EyQ==
X-Gm-Message-State: AOJu0YwhlRZueCx/2sW+/eEzcmInAcUxMUz5T1jWkWcnm2PrCIdseXHF
 XsKdhICdI+2Ouf1Loy2ji9h0lnsn4cjzo4TveZdL7VkNiEZ1Mche9qxVBmYo1GABrfnEW4T2s0n
 OP+IvjZnzPFdOLPQD5YvS9t0kb5oYzjMzDkPNVf8eqg==
X-Gm-Gg: AY/fxX6VGrnhF99STtLKw1YUPKxvbK4OTteh7NxTzoWILOeTQceejWESm0o/A0vC2mD
 l71Vb/TdyCrKBqBe2hIMxSe74rcvks5QGBH3gakMJ+W4hUY42i+tzXlqIzEJtiIC8+Qy9VLly33
 O6J4SpBNJzzppGXXk8FGcpE0n9380TP3iSls05/2kze0C8Vo4kqmJxdZCpCYSOW5ys6fS3YRdz0
 m6NtKs3PXqRzxoNmnTEG/lKD8tGOy+ITGUR9a8LAg3cqgmBNibhM9U3RilbFvZUjU9SKBKIEg+A
 DN8xbMerO4ZQA+GYaGJdgnU=
X-Google-Smtp-Source: AGHT+IGa6qVaYbnt1kDKE85T4PskdvrQeo1YZb4O5AB53ZeAjQ4qG8412I+djCwrrKYCJb6eAkwq2A9Rj/RIkkk4CH0=
X-Received: by 2002:a53:d706:0:b0:646:5127:9d0a with SMTP id
 956f58d0204a3-64716c97460mr13295987d50.81.1768312781535; Tue, 13 Jan 2026
 05:59:41 -0800 (PST)
MIME-Version: 1.0
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
 <20251223120012.541777-1-ashish.a6@samsung.com>
In-Reply-To: <20251223120012.541777-1-ashish.a6@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 13:59:30 +0000
X-Gm-Features: AZwV_QiVNyoT6TxcqNp7VrsdYEdUSnWbdMEJu1LJfjxBE6DAbngut9u9jVcZEvU
Message-ID: <CAFEAcA-UFgxLx8uYM10DoLXutMMNVQaq9xWBjZS5BY6RL1eRnw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
To: Ashish Anand <ashish.a6@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, y.kaushal@samsung.com, 
 vishwa.mg@samsung.com, ashish.anand202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 23 Dec 2025 at 12:02, Ashish Anand <ashish.a6@samsung.com> wrote:
>
> From: "ashish.a6" <ashish.a6@samsung.com>
>
>     Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
>     a simple yield. This causes high host CPU usage because Guest
>     RTOS idle loops effectively become busy-wait loops.
>
>     To improve efficiency, this patch transitions WFE to use the architectural
>     'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
>     to sleep when the guest is idle.

Thanks for this patch; it's been a missing piece in QEMU's emulation
for a long time. I think implementing it just for M-profile is fine.


>     To support this transition, we implement the full architectural behavior
>     required for WFE, specifically the 'Event Register' and 'SEVONPEND' logic
>     defined in the ARMv7-M specification. This ensures that the CPU correctly
>     identifies wakeup conditions as defined by the architecture.
>
>     Changes include:
>     1.  target/arm/cpu.h: Added 'event_register' to the v7m state struct.
>     2.  target/arm/cpu.c: Ensured event_register is cleared on reset and
>         updated arm_cpu_has_work() to check the event register state.
>     3.  target/arm/machine.c: Added VMState subsection for migration compatibility.
>     4.  hw/intc/armv7m_nvic.h: Added was_pending flag, to check for SEVONPEND logic.
>     5.  hw/intc/armv7m_nvic.c: Implemented SEVONPEND logic in :
>         nvic_recompute_state() and nvic_recompute_state_secure().
>         This sets the event register and kicks the CPU when a new interrupt
>         becomes pending.
>     6.  target/arm/tcg/helper.h: Declare the new helper_sev function.
>     7.  target/arm/tcg/op_helper.c:
>         - Update HELPER(wfe) to use EXCP_HLT for M-profile CPUs.
>         - Implement HELPER(sev) to set the event register and kick all vCPUs.
>     8.  target/arm/tcg/t16.decode / t32.decode: Enable decoding of the SEV
>         instruction in Thumb/Thumb-2 mode.
>     9.  target/arm/tcg/translate.c: Implement trans_SEV using inline
>         TCG generation to ensure system-wide visibility.

You don't really need to provide this kind of fine-grained "what
the changes are" info in the commit message -- it's more interesting
to talk about "what" at a higher level, and about "why".

>
>     This patch enables resource-efficient idle emulation for Cortex-M.
>
>     Signed-off-by: Ashish Anand ashish.a6@samsung.com

>  hw/intc/armv7m_nvic.c         | 22 ++++++++++++++++-
>  include/hw/intc/armv7m_nvic.h |  1 +
>  target/arm/cpu.c              |  7 ++++++
>  target/arm/cpu.h              |  1 +
>  target/arm/machine.c          | 19 +++++++++++++++
>  target/arm/tcg/helper.h       |  1 +
>  target/arm/tcg/op_helper.c    | 45 +++++++++++++++++++++++++++++------
>  target/arm/tcg/t16.decode     |  2 +-
>  target/arm/tcg/t32.decode     |  2 +-
>  target/arm/tcg/translate.c    | 20 ++++++++++++----
>  10 files changed, 106 insertions(+), 14 deletions(-)

It looks like there's a missing piece here: R_BPBR in the v8M
Arm ARM says that the event register is also set on exception
entry and exception return.

> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 7c78961040..a60990c71f 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -16,6 +16,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/timer.h"
>  #include "hw/intc/armv7m_nvic.h"
> +#include "hw/arm/armv7m.h"

This shouldn't be needed.

>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
>  #include "system/tcg.h"
> @@ -232,6 +233,8 @@ static void nvic_recompute_state_secure(NVICState *s)
>      int pend_irq = 0;
>      bool pending_is_s_banked = false;
>      int pend_subprio = 0;
> +    ARMv7MState *armv7m = container_of(s, ARMv7MState, nvic);
> +    ARMCPU *cpu = armv7m->cpu;

You don't need this roundabout way to get at the CPU object:
we already have a direct pointer to it in s->cpu (which is
how the rest of the code in this file gets to it).

>
>      /* R_CQRV: precedence is by:
>       *  - lowest group priority; if both the same then
> @@ -259,6 +262,14 @@ static void nvic_recompute_state_secure(NVICState *s)
>                  targets_secure = !exc_is_banked(i) && exc_targets_secure(s, i);
>              }
>
> +            if (!vec->was_pending && vec->pending) {
> +                if (cpu->env.v7m.scr[bank] & R_V7M_SCR_SEVONPEND_MASK) {
> +                    cpu->env.v7m.event_register = 1;
> +                    qemu_cpu_kick(CPU(cpu));
> +                }
> +            }
> +            vec->was_pending = vec->pending;

I don't think this is the right way to implement the "set event
register when an exception transitions from inactive to pending"
requirement. We should do this when we write vec->pending from
0 to 1. This means we'll need to abstract out the "set vec->pending"
action into a function, because currently we do it in multiple places
in the source code as a direct write. When we do that we will
have a single place we can do the "if this is 0->1 then set
the event register" change.

Also, the spec says it is interrupts going to pending that are
WFE wakeup events, not all exceptions, so I think we only want
to do this for anything NVIC_FIRST_IRQ and above.

> +
>              prio = exc_group_prio(s, vec->prio, targets_secure);
>              subprio = vec->prio & ~nvic_gprio_mask(s, targets_secure);
>              if (vec->enabled && vec->pending &&
> @@ -293,6 +304,8 @@ static void nvic_recompute_state(NVICState *s)
>      int pend_prio = NVIC_NOEXC_PRIO;
>      int active_prio = NVIC_NOEXC_PRIO;
>      int pend_irq = 0;
> +    ARMv7MState *armv7m = container_of(s, ARMv7MState, nvic);
> +    ARMCPU *cpu = armv7m->cpu;
>
>      /* In theory we could write one function that handled both
>       * the "security extension present" and "not present"; however
> @@ -316,6 +329,13 @@ static void nvic_recompute_state(NVICState *s)
>          if (vec->active && vec->prio < active_prio) {
>              active_prio = vec->prio;
>          }
> +        if (!vec->was_pending && vec->pending) {
> +            if (cpu->env.v7m.scr[M_REG_NS] & R_V7M_SCR_SEVONPEND_MASK) {
> +                cpu->env.v7m.event_register = 1;
> +                qemu_cpu_kick(CPU(cpu));
> +            }
> +        }
> +        vec->was_pending = vec->pending;
>      }
>
>      if (active_prio > 0) {
> @@ -1657,7 +1677,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>          }
>          /* We don't implement deep-sleep so these bits are RAZ/WI.
>           * The other bits in the register are banked.
> -         * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
> +         * QEMU's implementation ignores SLEEPONEXIT, which
>           * is architecturally permitted.
>           */
>          value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
> diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
> index 7b9964fe7e..305eaf6e6a 100644
> --- a/include/hw/intc/armv7m_nvic.h
> +++ b/include/hw/intc/armv7m_nvic.h
> @@ -32,6 +32,7 @@ typedef struct VecInfo {
>      uint8_t pending;
>      uint8_t active;
>      uint8_t level; /* exceptions <=15 never set level */
> +    bool was_pending;
>  } VecInfo;
>
>  struct NVICState {
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 39292fb9bc..0a044f7254 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -143,6 +143,12 @@ static bool arm_cpu_has_work(CPUState *cs)
>  {
>      ARMCPU *cpu = ARM_CPU(cs);
>
> +    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
> +        if (cpu->env.v7m.event_register) {
> +            return true;
> +        }
> +    }
> +
>      return (cpu->power_state != PSCI_OFF)
>          && cpu_test_interrupt(cs,
>                 CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
> @@ -480,6 +486,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
>              ~(R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK);
>          env->v7m.control[M_REG_S] |= R_V7M_CONTROL_FPCA_MASK;
>  #endif
> +        env->v7m.event_register = 0;

CPU reset resets most state fields to 0 by default, so we
don't need to do this explicitly here.

>      }
>
>      /* M profile requires that reset clears the exclusive monitor;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 39f2b2e54d..44433a444c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -639,6 +639,7 @@ typedef struct CPUArchState {
>          uint32_t nsacr;
>          uint32_t ltpsize;
>          uint32_t vpr;
> +        uint32_t event_register;
>      } v7m;
>
>      /* Information associated with an exception about to be taken:
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 0befdb0b28..acc79188f2 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c

All the migration handling looks good; thanks for remembering
to include it.

> diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
> index 4636d1bc03..5a10a9fba3 100644
> --- a/target/arm/tcg/helper.h
> +++ b/target/arm/tcg/helper.h
> @@ -60,6 +60,7 @@ DEF_HELPER_1(yield, void, env)
>  DEF_HELPER_1(pre_hvc, void, env)
>  DEF_HELPER_2(pre_smc, void, env, i32)
>  DEF_HELPER_1(vesb, void, env)
> +DEF_HELPER_1(sev, void, env)
>
>  DEF_HELPER_3(cpsr_write, void, env, i32, i32)
>  DEF_HELPER_2(cpsr_write_eret, void, env, i32)
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 4fbd219555..ad79724778 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -469,16 +469,47 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
>  #endif
>  }
>
> +void HELPER(sev)(CPUARMState *env)
> +{
> +    CPUState *cs = env_cpu(env);
> +    CPU_FOREACH(cs) {
> +        ARMCPU *target_cpu = ARM_CPU(cs);
> +        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
> +            target_cpu->env.v7m.event_register = 1;
> +        }
> +        qemu_cpu_kick(cs);

I don't think we need to kick the CPU if it is ourselves
(by definition we can't be waiting in WFE if we're executing
SEV), so we could write

        if (!qemu_cpu_is_self(cs)) {
            qemu_cpu_kick(cs);
        }

> +    }
> +}
> +
>  void HELPER(wfe)(CPUARMState *env)
>  {
> -    /* This is a hint instruction that is semantically different
> -     * from YIELD even though we currently implement it identically.
> -     * Don't actually halt the CPU, just yield back to top
> -     * level loop. This is not going into a "low power state"
> -     * (ie halting until some event occurs), so we never take
> -     * a configurable trap to a different exception level.
> +    /*
> +     * WFE (Wait For Event) is a hint instruction.
> +     * For Cortex-M (M-profile), we implement the strict architectural behavior:
> +     * 1. Check the Event Register (set by SEV or SEVONPEND).
> +     * 2. If set, clear it and continue (consume the event).
>       */

You should add a CONFIG_USER_ONLY version similar to what
we have in the wfi helper that makes WFE a nop there. Otherwise
trying to do WFE in the user-mode emulator will abort when
we raise EXCP_HLT.

> -    HELPER(yield)(env);
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        CPUState *cs = env_cpu(env);
> +
> +        if (env->v7m.event_register) {
> +            env->v7m.event_register = 0;
> +            return;
> +        }
> +
> +        cs->exception_index = EXCP_HLT;
> +        cs->halted = 1;
> +        cpu_loop_exit(cs);
> +    } else {
> +        /*
> +         * For A-profile and others, we rely on the existing "yield" behavior.
> +         * Don't actually halt the CPU, just yield back to top
> +         * level loop. This is not going into a "low power state"
> +         * (ie halting until some event occurs), so we never take
> +         * a configurable trap to a different exception level
> +         */
> +        HELPER(yield)(env);
> +    }
>  }
>
>  void HELPER(yield)(CPUARMState *env)
> diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
> index 646c74929d..ac6e24ac14 100644
> --- a/target/arm/tcg/t16.decode
> +++ b/target/arm/tcg/t16.decode
> @@ -229,7 +229,7 @@ REVSH           1011 1010 11 ... ...            @rdm
>      WFI         1011 1111 0011 0000
>
>      # TODO: Implement SEV, SEVL; may help SMP performance.

We should update the TODO comment to note that we only
implement SEV for M-profile, and that A-profile SEV, SEVL
are still a TODO item. (Ditto the comment in t32.decode.)

> -    # SEV       1011 1111 0100 0000
> +    SEV         1011 1111 0100 0000
>      # SEVL      1011 1111 0101 0000
>
>      # The canonical nop has the second nibble as 0000, but the whole of the
> diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
> index d327178829..59b0edf63f 100644
> --- a/target/arm/tcg/t32.decode
> +++ b/target/arm/tcg/t32.decode
> @@ -370,7 +370,7 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
>          WFI      1111 0011 1010 1111 1000 0000 0000 0011
>
>          # TODO: Implement SEV, SEVL; may help SMP performance.
> -        # SEV    1111 0011 1010 1111 1000 0000 0000 0100
> +        SEV      1111 0011 1010 1111 1000 0000 0000 0100
>          # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
>
>          ESB      1111 0011 1010 1111 1000 0000 0001 0000
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 63735d9789..bfe2691884 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3241,14 +3241,25 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
>      return true;
>  }
>
> +static bool trans_SEV(DisasContext *s, arg_SEV *a)
> +{

This should translate to a NOP if CONFIG_USER_ONLY, or
if we're not M-profile.

> +    gen_update_pc(s, curr_insn_len(s));
> +    gen_helper_sev(tcg_env);
> +    tcg_gen_exit_tb(NULL, 0);
> +    s->base.is_jmp = DISAS_NORETURN;

Why do we need to do this tcg_gen_exit_tb() and set DISAS_NORETURN ?

Do we even need to end the current TB on a SEV instruction ?

> +    return true;

> +}
> +
>  static bool trans_WFE(DisasContext *s, arg_WFE *a)
>  {
>      /*
>       * When running single-threaded TCG code, use the helper to ensure that
> -     * the next round-robin scheduled vCPU gets a crack.  In MTTCG mode we
> -     * just skip this instruction.  Currently the SEV/SEVL instructions,
> -     * which are *one* of many ways to wake the CPU from WFE, are not
> -     * implemented so we can't sleep like WFI does.
> +     * the next round-robin scheduled vCPU gets a crack.
> +     *
> +     * For Cortex-M, we implement the architectural WFE behavior (sleeping
> +     * until an event occurs or the Event Register is set).
> +     * For other profiles, we currently treat this as a NOP or yield,
> +     * to preserve existing performance characteristics.
>       */
>      if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
>          gen_update_pc(s, curr_insn_len(s));
> @@ -6807,6 +6818,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>              break;
>          case DISAS_WFE:
>              gen_helper_wfe(tcg_env);
> +            tcg_gen_exit_tb(NULL, 0);

Why is this necessary ?

>              break;
>          case DISAS_YIELD:
>              gen_helper_yield(tcg_env);
> --
> 2.43.0

thanks
-- PMM

