Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83578CD37AC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 06:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOUoc-0004Dq-GM; Sun, 17 May 2026 02:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1wOUoT-0004As-9e
 for qemu-devel@nongnu.org; Sun, 17 May 2026 02:17:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1wOUoP-0004Bf-5r
 for qemu-devel@nongnu.org; Sun, 17 May 2026 02:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778998621; bh=BultDMM4u468t0d+glXtM4jIyECq2jQIh70JfIOFe8E=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=BO59yA14UR7S5OqVT+JbTDy5gjo9hnVEV+IUsPs4ygp98b9Fl0lSFYS6SqxZ4Quzw
 HbPD+zA7ayPAOyx0MH45SKKYX1tG2yc1nk4ln5drLzp4YAY1buCuTxGV2cBx/wUxV0
 +C0cEsIJ5NRxdLQ/m9KAHW72shDUMryAXuUfu/ZXqldRHasY6D/CeuFEG4HH7wTVzH
 sh+7Ry1BR9mG9eT5bwTPzJkM/h6aaHPQHb8knxAbdj+n6ldk/rT1CaTfAflPCoZrA1
 qeqBojKePf6aAQd5B02pc9DqCih5NClso51trjkP4kXHsoJwouUhC8yldUwOc16rMh
 yOSVZBpGkx1Kg==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 8495C1AC5F3;
 Sun, 17 May 2026 09:17:01 +0300 (MSK)
Message-ID: <9d864bdd-2bb3-4fbb-8020-1eced5d6c131@tls.msk.ru>
Date: Sun, 17 May 2026 09:17:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/23] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
 <20260515104945.4145203-24-peter.maydell@linaro.org>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260515104945.4145203-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 15.05.2026 13:49, Peter Maydell wrote:
> From: "Scott J. Goldman" <scottjgo@gmail.com>
> 
> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> changed hvf_wfi() from blocking the vCPU thread with pselect() to
> returning EXCP_HLT, intending QEMU's main event loop to handle the
> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
> always returns false and the vCPU thread spins at 100% CPU per core
> while the guest is idle.
> 
> Fix this by:
> 
> 1. Setting cpu->halted = 1 in hvf_wfi() so the vCPU thread sleeps on
>     halt_cond in qemu_process_cpu_events().
> 
> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>     virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>     because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>     hv_vcpu_run(), which is not called while the CPU is halted. The
>     timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>     vtimer IRQ through the GIC and marks vtimer_masked, causing the
>     interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
> 
> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>     indicates a pending interrupt, and cancelling the WFI timer.
> 
> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>     transition for any halted vCPU, since the QEMUTimer is per-instance
>     state and is not migrated. After cpu_synchronize_all_states() the
>     migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>     and CNTV_CVAL from there. If the vtimer has already expired by the
>     time the destination resumes, hvf_wfi_timer_cb() is invoked
>     directly so the halted vCPU is woken up.
> 
> All wfi_timer handling (allocation, arming, deletion, and the resume
> re-arm) is gated on !hvf_irqchip_in_kernel(): with the Apple in-kernel
> vGIC, HVF owns the vtimer and delivers wake-ups itself.
> 
> Note for stable backports: this commit won't apply to 11.0 as
> it has changes to handle the hvf in-kernel irqchip support that
> landed after the 11.0 release. The v3 version of this commit:
>    https://patchew.org/QEMU/20260427195516.46256-1-scottjgo@gmail.com/
> should be suitable for 11.0 backporting (it is essentially
> identical except that it doesn't make the changes conditional
> on !hvf_irqchip_in_kernel()).

Hi!

How about I pick up this patch instead, but add a one-line on top
of target/arm/hvf/hvf.c (or to include/system/hvf_int.h):

#define hvf_irqchip_in_kernel() 0

with a comment saying why it's here?  I think it will be cleaner
this way, with better traceable roots.

Thanks,

/mjt

> Cc: qemu-stable@nongnu.org
> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> [PMM: added note about stable backports to commit message]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/system/hvf_int.h |   1 +
>   target/arm/hvf/hvf.c     | 140 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 140 insertions(+), 1 deletion(-)
> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index ad7d375109..d5eaf26dda 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -48,6 +48,7 @@ struct AccelCPUState {
>       hv_vcpu_exit_t *exit;
>       bool vtimer_masked;
>       bool guest_debug_enabled;
> +    struct QEMUTimer *wfi_timer;
>   #endif
>   };
>   
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 9312607001..d88cbe7c82 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -29,6 +29,7 @@
>   #include "hw/core/irq.h"
>   #include "hw/arm/virt.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/timer.h"
>   #include "system/cpus.h"
>   #include "arm-powerctl.h"
>   #include "target/arm/cpu.h"
> @@ -308,6 +309,8 @@ void hvf_arm_init_debug(void)
>   #define TMR_CTL_IMASK   (1 << 1)
>   #define TMR_CTL_ISTATUS (1 << 2)
>   
> +static void hvf_wfi_timer_cb(void *opaque);
> +
>   static uint32_t chosen_ipa_bit_size;
>   
>   typedef struct HVFVTimer {
> @@ -1296,6 +1299,11 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>   {
>       hv_return_t ret;
>   
> +    if (!hvf_irqchip_in_kernel()) {
> +        timer_free(cpu->accel->wfi_timer);
> +        cpu->accel->wfi_timer = NULL;
> +    }
> +
>       ret = hv_vcpu_destroy(cpu->accel->fd);
>       assert_hvf_ok(ret);
>   }
> @@ -1487,6 +1495,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>                                 arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
>       assert_hvf_ok(ret);
>   
> +    if (!hvf_irqchip_in_kernel()) {
> +        cpu->accel->wfi_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                             hvf_wfi_timer_cb, cpu);
> +    }
> +
>       aarch64_add_sme_properties(OBJECT(cpu));
>       return 0;
>   }
> @@ -2194,6 +2207,62 @@ static uint64_t hvf_vtimer_val_raw(void)
>       return mach_absolute_time() - hvf_state->vtimer_offset;
>   }
>   
> +static void hvf_wfi_timer_cb(void *opaque)
> +{
> +    CPUState *cpu = opaque;
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +
> +    /*
> +     * vtimer expired while the CPU was halted for WFI.
> +     * Mirror HV_EXIT_REASON_VTIMER_ACTIVATED: raise the vtimer
> +     * interrupt and mark as masked so hvf_sync_vtimer() will
> +     * check and unmask when the guest handles it.
> +     *
> +     * The interrupt delivery chain (GIC -> cpu_interrupt ->
> +     * qemu_cpu_kick) wakes the vCPU thread from halt_cond.
> +     */
> +    qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
> +    cpu->accel->vtimer_masked = true;
> +}
> +
> +/*
> + * Arm a host-side QEMU_CLOCK_VIRTUAL timer to fire when the guest's
> + * vtimer (CNTV_CVAL_EL0) is scheduled to expire. HVF only delivers
> + * HV_EXIT_REASON_VTIMER_ACTIVATED during hv_vcpu_run(), which we won't
> + * call while the vCPU is halted, so we need this to wake the vCPU.
> + *
> + * QEMU_CLOCK_VIRTUAL pauses while the VM is stopped, which keeps the
> + * timer in lockstep with the guest's view of vtime across pause/resume.
> + *
> + * Caller must supply the current CNTV_CTL_EL0 and CNTV_CVAL_EL0 values,
> + * since the appropriate source (HVF vs. env) depends on context.
> + *
> + * Returns 0 if the timer was armed (or if the vtimer is disabled/masked
> + * and the vCPU should still halt waiting on another event), or -1 if
> + * the vtimer has already expired.
> + */
> +static int hvf_arm_wfi_timer(CPUState *cpu, uint64_t ctl, uint64_t cval)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    uint64_t now;
> +    int64_t delta_ns;
> +
> +    if (!(ctl & TMR_CTL_ENABLE) || (ctl & TMR_CTL_IMASK)) {
> +        return 0;
> +    }
> +
> +    now = hvf_vtimer_val_raw();
> +    if (cval <= now) {
> +        return -1;
> +    }
> +
> +    delta_ns = muldiv64(cval - now, NANOSECONDS_PER_SECOND,
> +                        arm_cpu->gt_cntfrq_hz);
> +    timer_mod(cpu->accel->wfi_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delta_ns);
> +    return 0;
> +}
> +
>   static int hvf_wfi(CPUState *cpu)
>   {
>       if (cpu_has_work(cpu)) {
> @@ -2204,6 +2273,29 @@ static int hvf_wfi(CPUState *cpu)
>           return 0;
>       }
>   
> +    if (!hvf_irqchip_in_kernel()) {
> +        uint64_t ctl, cval;
> +        hv_return_t r;
> +
> +        /*
> +         * Read the vtimer state directly from HVF. We're on the vCPU
> +         * thread, just exited from hv_vcpu_run(), so HVF holds the
> +         * authoritative values and env may be stale.
> +         */
> +        r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0,
> +                                &ctl);
> +        assert_hvf_ok(r);
> +        r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0,
> +                                &cval);
> +        assert_hvf_ok(r);
> +
> +        if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
> +            /* vtimer already expired, don't halt */
> +            return 0;
> +        }
> +    }
> +
> +    cpu->halted = 1;
>       return EXCP_HLT;
>   }
>   
> @@ -2502,7 +2594,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>       hv_return_t r;
>   
>       if (cpu->halted) {
> -        return EXCP_HLT;
> +        if (!cpu_has_work(cpu)) {
> +            return EXCP_HLT;
> +        }
> +        cpu->halted = 0;
> +        if (!hvf_irqchip_in_kernel()) {
> +            timer_del(cpu->accel->wfi_timer);
> +        }
>       }
>   
>       flush_cpu_state(cpu);
> @@ -2551,6 +2649,46 @@ static void hvf_vm_state_change(void *opaque, bool running, RunState state)
>           /* Update vtimer offset on all CPUs */
>           hvf_state->vtimer_offset = mach_absolute_time() - s->vtimer_val;
>           cpu_synchronize_all_states();
> +
> +        /*
> +         * After migration restore (or any resume), the wfi_timer is not
> +         * scheduled on this QEMU instance, so re-arm it for any halted
> +         * vCPU with a pending vtimer. For a non-migration resume the
> +         * QEMU_CLOCK_VIRTUAL timer was already scheduled; recomputing the
> +         * deadline produces the same value and is a harmless no-op.
> +         *
> +         * cpu_synchronize_all_states() above ensures env mirrors the
> +         * authoritative vtimer state (whether that came from HVF or from
> +         * the migration stream), so we can safely read it here from the
> +         * iothread.
> +         *
> +         * Only applies when we own the wfi_timer; with an in-kernel vGIC
> +         * the timer is never allocated and HVF handles vtimer wake-ups.
> +         */
> +        if (!hvf_irqchip_in_kernel()) {
> +            CPUState *cpu;
> +
> +            CPU_FOREACH(cpu) {
> +                ARMCPU *arm_cpu;
> +                uint64_t ctl, cval;
> +
> +                if (!cpu->accel || !cpu->halted) {
> +                    continue;
> +                }
> +
> +                arm_cpu = ARM_CPU(cpu);
> +                ctl = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
> +                cval = arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
> +
> +                if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
> +                    /*
> +                     * vtimer already expired while we were paused; raise
> +                     * the IRQ now so the halted vCPU wakes up.
> +                     */
> +                    hvf_wfi_timer_cb(cpu);
> +                }
> +            }
> +        }
>       } else {
>           /* Remember vtimer value on every pause */
>           s->vtimer_val = hvf_vtimer_val_raw();


