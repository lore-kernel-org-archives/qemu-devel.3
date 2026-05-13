Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49836CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzIN-0003yp-BI; Tue, 12 May 2026 22:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wMzIL-0003yQ-1i
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:25:57 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wMzIH-0005a2-Ul
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:25:56 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-50d6b9bca48so75317981cf.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778639152; x=1779243952; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7z2FOBWMAaefvXZumCi2Edzmn5NvQidHEEc5IEP+AVY=;
 b=sEaMUydKqoOJnVyhEd2q+yO5kj9bc7hBbM0+r7FCTnhrK51Lst09s7ELiDmOFqZAyt
 IknfT5oWuAdAi9xMgPIdikhjBNb2RSSK22NC+fBvjrqYs263nFcuCkNOsVzfL8XGIt3F
 BT+5PHspD8rXxVLjBFf3O/orEWXp2jCcxirpB+7BA8SSTB9h+5M//TzDJdfsVr1yf38S
 G/BmIFqolq6zyp48XXHpJ/nr0O9j9h6OHGtJKTaOdYjIaLLkNwDljzvqsnpySfT9YHed
 l104nh+1R9Rn3oamvgVwRXKxQi1SWTFOl41eG+1D+AlwMDaXfULcGrodIADuSwmhj6c2
 pgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778639152; x=1779243952;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7z2FOBWMAaefvXZumCi2Edzmn5NvQidHEEc5IEP+AVY=;
 b=tRHkhMga37U+8y7dyxXUt1Hi3pbri+VvutvPft4OoVnYwahHsOc15GZjhFOxQGRZrL
 0ZE9z52IeRLWSODig3ojxRciPuXeoa07Ckr4WV1oQslcOChPx6O+puYTrOkRoSpTZtLi
 wRqH9N/xEGjEM4hJO+0Nwe39aEmxko0Aka32YcAXzXzFtf5zhW+GPSGSo3BEPnrxFWX5
 fhrqqhnQpS6qXEzTMYTDB+8SEmKhjRw/LuFAElTjTOXAmoY32ZzoryOJqOJfcuUWgY76
 YCIw5vmySgO6svNaE0NXXqOGH2pW0gmHD0E+R4yXfGxlKyB2XCmrhGJxk4dIj5XuWFV5
 ZDyA==
X-Gm-Message-State: AOJu0YzHuZe6zhRlzMZ/AFCHDtod+L/xxNT+PvM2PxFwvNBV23gFc899
 wRr5euK1+K/oXuvcr917VmFYOmC6DUEMkJ+BqAIGH6kRjUkiq7HobbFe
X-Gm-Gg: Acq92OEW+c+6hZOTd1CKfZCnASLJxmfOWmr4ovrexynDB/1CM8MuA+O6hPrIQzntOur
 P1ElOwhPKVUL8xctvXVcR3xqtgWQ+Qi+XJVDlEenyfDUEyrsP2eOV/2z+9sjtb2KuAf0osv1ivL
 xY61dWuGpBrJyqKV/UlowVAaaiqZFqltRfjunCSxHaA8sGouCb0WHCsf1rvFbkjtd2nixwaEYxN
 PWz43gw3tSPHIbaZZ3Zjs+yn0LsqZ4HkKpiEXDK9bkyNS4L/Ss+toIYzgQT+EGukbGzPb2BOP6m
 vPqaZ91S4rmWnRjMC65YcV47Vks1LSC8holat1HpCDvad6XE5+I8y0aKR31Bx3lAPthSXDtVmWf
 4e5d7ukP6+qSkWq15sW+QPxtOsssJLjpopLsDT6YK5rU0+DohgoJO+DWwbgNcnRaL71WAvkSUuI
 4ijoyUHJdZu+TOmNi+bDGBwrDPaMQ8gk2zWaPp7zdxXxJ/mo4fQd/0sWbzytGWv26dH45timLN0
 rKcJjZxUS7uYiU=
X-Received: by 2002:ac8:7fc1:0:b0:50e:6054:ba with SMTP id
 d75a77b69052e-5162f43fbb9mr19595011cf.9.1778639152465; 
 Tue, 12 May 2026 19:25:52 -0700 (PDT)
Received: from localhost ([2603:7000:4df0:8300:fdb5:4a2a:97d0:addf])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e630729sm144814631cf.4.2026.05.12.19.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 19:25:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 22:25:49 -0400
Message-Id: <DIH6YGXVPFD4.2O7V71XKGBIB@gmail.com>
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Mohamed Mediouni" <mohamed@unpredictable.fr>, "Scott J. Goldman"
 <scottjgo@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Alexander Graf" <agraf@csgraf.de>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>, "Roman Bolshakov"
 <rbolshakov@ddn.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
X-Mailer: aerc 0.21.0
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
 <E8468087-647B-45B5-AF4E-85DD15A6D35C@unpredictable.fr>
In-Reply-To: <E8468087-647B-45B5-AF4E-85DD15A6D35C@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=scottjgo@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue May 12, 2026 at 9:21 PM EDT, Mohamed Mediouni wrote:
>
>> On 27. Apr 2026, at 21:55, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>=20
>> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> changed hvf_wfi() from blocking the vCPU thread with pselect() to
>> returning EXCP_HLT, intending QEMU's main event loop to handle the
>> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
>> always returns false and the vCPU thread spins at 100% CPU per core
>> while the guest is idle.
>>=20
>> Fix this by:
>>=20
>> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>>  halt_cond in qemu_process_cpu_events().
>>=20
>> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>>  virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>  because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>  hv_vcpu_run(), which is not called while the CPU is halted. The
>>  timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>  vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>  interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>=20
>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>  indicates a pending interrupt, and cancelling the WFI timer.
>>=20
>> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>>  transition for any halted vCPU, since the QEMUTimer is per-instance
>>  state and is not migrated. After cpu_synchronize_all_states() the
>>  migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>>  and CNTV_CVAL from there. If the vtimer has already expired by the
>>  time the destination resumes, hvf_wfi_timer_cb() is invoked
>>  directly so the halted vCPU is woken up.
>>=20
>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>> ---
>> Changes since v2:
>> - Use QEMU_CLOCK_VIRTUAL instead of QEMU_CLOCK_HOST so the timer
>>  pauses with the VM and a halted vCPU isn't woken (or its IRQ
>>  raised) while the user has stopped the guest. (Peter)
>> - Convert vtimer ticks to nanoseconds with muldiv64() to avoid
>>  intermediate overflow. (Peter)
>> - Re-arm the WFI timer from hvf_vm_state_change() on the resume
>>  transition so a halted vCPU on the migration destination is
>>  woken when its vtimer expires (the QEMUTimer is per-instance
>>  state and isn't migrated). (Peter)
>> v2: https://lore.kernel.org/qemu-devel/20260410055045.63001-1-scottjgo@g=
mail.com/
>> v1: https://lore.kernel.org/qemu-devel/20260410044726.61853-1-scottjgo@g=
mail.com/
>
> For QEMU 11.0 (for backporting to stable):
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> For QEMU 11.1:
>
> Adding some checks for !hvf_irqchip_in_kernel() needed
> but can do them on my side if you prefer.
>
> Looks ready apart from that bit.

Hi Mohamed,

TFTR - I sent a follow-up patch that gates the wfi timer as you requested.
For applying this v3 version to the stable tree, is there anyone else I
should ping? I'm not very familiar with the process.
=20
Thanks!
-sjg


>
>>=20
>> include/system/hvf_int.h |   1 +
>> target/arm/hvf/hvf.c     | 124 ++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 124 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>> index 2621164cb2..58fb865eba 100644
>> --- a/include/system/hvf_int.h
>> +++ b/include/system/hvf_int.h
>> @@ -48,6 +48,7 @@ struct AccelCPUState {
>>    hv_vcpu_exit_t *exit;
>>    bool vtimer_masked;
>>    bool guest_debug_enabled;
>> +    struct QEMUTimer *wfi_timer;
>> #endif
>> };
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 678afe5c8e..a19d7a5e1f 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -28,6 +28,7 @@
>> #include "hw/core/boards.h"
>> #include "hw/core/irq.h"
>> #include "qemu/main-loop.h"
>> +#include "qemu/timer.h"
>> #include "system/cpus.h"
>> #include "arm-powerctl.h"
>> #include "target/arm/cpu.h"
>> @@ -301,6 +302,8 @@ void hvf_arm_init_debug(void)
>> #define TMR_CTL_IMASK   (1 << 1)
>> #define TMR_CTL_ISTATUS (1 << 2)
>>=20
>> +static void hvf_wfi_timer_cb(void *opaque);
>> +
>> static uint32_t chosen_ipa_bit_size;
>>=20
>> typedef struct HVFVTimer {
>> @@ -1214,6 +1217,9 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>> {
>>    hv_return_t ret;
>>=20
>> +    timer_free(cpu->accel->wfi_timer);
>> +    cpu->accel->wfi_timer =3D NULL;
>> +
>>    ret =3D hv_vcpu_destroy(cpu->accel->fd);
>>    assert_hvf_ok(ret);
>> }
>> @@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>                              arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX])=
;
>>    assert_hvf_ok(ret);
>>=20
>> +    cpu->accel->wfi_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>> +                                          hvf_wfi_timer_cb, cpu);
>> +
> adding !hvf_irqchip_in_kernel()
>
>>     aarch64_add_sme_properties(OBJECT(cpu));
>>    return 0;
>> }
>> @@ -2027,8 +2036,67 @@ static uint64_t hvf_vtimer_val_raw(void)
>>    return mach_absolute_time() - hvf_state->vtimer_offset;
>> }
>>=20
>> +static void hvf_wfi_timer_cb(void *opaque)
>> +{
>> +    CPUState *cpu =3D opaque;
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +
>> +    /*
>> +     * vtimer expired while the CPU was halted for WFI.
>> +     * Mirror HV_EXIT_REASON_VTIMER_ACTIVATED: raise the vtimer
>> +     * interrupt and mark as masked so hvf_sync_vtimer() will
>> +     * check and unmask when the guest handles it.
>> +     *
>> +     * The interrupt delivery chain (GIC -> cpu_interrupt ->
>> +     * qemu_cpu_kick) wakes the vCPU thread from halt_cond.
>> +     */
>> +    qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
>> +    cpu->accel->vtimer_masked =3D true;
>> +}
>> +
>> +/*
>> + * Arm a host-side QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>> + * vtimer (CNTV_CVAL_EL0) is scheduled to expire. HVF only delivers
>> + * HV_EXIT_REASON_VTIMER_ACTIVATED during hv_vcpu_run(), which we won't
>> + * call while the vCPU is halted, so we need this to wake the vCPU.
>> + *
>> + * QEMU_CLOCK_VIRTUAL pauses while the VM is stopped, which keeps the
>> + * timer in lockstep with the guest's view of vtime across pause/resume=
.
>> + *
>> + * Caller must supply the current CNTV_CTL_EL0 and CNTV_CVAL_EL0 values=
,
>> + * since the appropriate source (HVF vs. env) depends on context.
>> + *
>> + * Returns 0 if the timer was armed (or if the vtimer is disabled/maske=
d
>> + * and the vCPU should still halt waiting on another event), or -1 if
>> + * the vtimer has already expired.
>> + */
>> +static int hvf_arm_wfi_timer(CPUState *cpu, uint64_t ctl, uint64_t cval=
)
>> +{
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    uint64_t now;
>> +    int64_t delta_ns;
>> +
>> +    if (!(ctl & TMR_CTL_ENABLE) || (ctl & TMR_CTL_IMASK)) {
>> +        return 0;
>> +    }
>> +
>> +    now =3D hvf_vtimer_val_raw();
>> +    if (cval <=3D now) {
>> +        return -1;
>> +    }
>> +
>> +    delta_ns =3D muldiv64(cval - now, NANOSECONDS_PER_SECOND,
>> +                        arm_cpu->gt_cntfrq_hz);
>> +    timer_mod(cpu->accel->wfi_timer,
>> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delta_ns);
>> +    return 0;
>> +}
>> +
>> static int hvf_wfi(CPUState *cpu)
>> {
>> +    uint64_t ctl, cval;
>> +    hv_return_t r;
>> +
>>    if (cpu_has_work(cpu)) {
>>        /*
>>         * Don't bother to go into our "low power state" if
>> @@ -2037,6 +2105,22 @@ static int hvf_wfi(CPUState *cpu)
>>        return 0;
>>    }
>>=20
>> +    /*
>> +     * Read the vtimer state directly from HVF. We're on the vCPU threa=
d,
>> +     * just exited from hv_vcpu_run(), so HVF holds the authoritative
>> +     * values and env may be stale.
>> +     */
>> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, =
&ctl);
>> +    assert_hvf_ok(r);
>> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0,=
 &cval);
>> +    assert_hvf_ok(r);
>> +
>> +    if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
>> +        /* vtimer already expired, don't halt */
>> +        return 0;
>> +    }
>> +
>> +    cpu->halted =3D 1;
>>    return EXCP_HLT;
>> }
>>=20
>> @@ -2332,7 +2416,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>>    hv_return_t r;
>>=20
>>    if (cpu->halted) {
>> -        return EXCP_HLT;
>> +        if (!cpu_has_work(cpu)) {
>> +            return EXCP_HLT;
>> +        }
>> +        cpu->halted =3D 0;
>> +        timer_del(cpu->accel->wfi_timer);
> !hvf_irqchip_in_kernel(), we shouldn=E2=80=99t have the wfi timer otherwi=
se
>>     }
>>=20
>>    flush_cpu_state(cpu);
>> @@ -2376,11 +2464,45 @@ static const VMStateDescription vmstate_hvf_vtim=
er =3D {
>> static void hvf_vm_state_change(void *opaque, bool running, RunState sta=
te)
>> {
>>    HVFVTimer *s =3D opaque;
>> +    CPUState *cpu;
>>=20
>>    if (running) {
>>        /* Update vtimer offset on all CPUs */
>>        hvf_state->vtimer_offset =3D mach_absolute_time() - s->vtimer_val=
;
>>        cpu_synchronize_all_states();
>> +
>> +        /*
>> +         * After migration restore (or any resume), the wfi_timer is no=
t
>> +         * scheduled on this QEMU instance, so re-arm it for any halted
>> +         * vCPU with a pending vtimer. For a non-migration resume the
>> +         * QEMU_CLOCK_VIRTUAL timer was already scheduled; recomputing =
the
>> +         * deadline produces the same value and is a harmless no-op.
>> +         *
>> +         * cpu_synchronize_all_states() above ensures env mirrors the
>> +         * authoritative vtimer state (whether that came from HVF or fr=
om
>> +         * the migration stream), so we can safely read it here from th=
e
>> +         * iothread.
>> +         */
>
> This should be gated behind !hvf_irqchip_in_kernel()
>
>> +        CPU_FOREACH(cpu) {
>> +            ARMCPU *arm_cpu;
>> +            uint64_t ctl, cval;
>> +
>> +            if (!cpu->accel || !cpu->halted) {
>> +                continue;
>> +            }
>> +
>> +            arm_cpu =3D ARM_CPU(cpu);
>> +            ctl =3D arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
>> +            cval =3D arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
>> +
>> +            if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
>> +                /*
>> +                 * vtimer already expired while we were paused; raise t=
he
>> +                 * IRQ now so the halted vCPU wakes up.
>> +                 */
>> +                hvf_wfi_timer_cb(cpu);
>> +            }
>> +        }
>>    } else {
>>        /* Remember vtimer value on every pause */
>>        s->vtimer_val =3D hvf_vtimer_val_raw();
>> --=20
>> 2.50.1 (Apple Git-155)
>>=20
>>=20


