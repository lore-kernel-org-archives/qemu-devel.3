Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F985CD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 01:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMyIg-0003Tu-48; Tue, 12 May 2026 21:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMyIc-0003T7-9O
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:22:10 -0400
Received: from p-east2-cluster2-host10-snip4-3.eps.apple.com ([57.103.78.76]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMyIZ-0007mk-5N
 for qemu-devel@nongnu.org; Tue, 12 May 2026 21:22:10 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-5 (Postfix) with ESMTPS id
 394A11802AD7; Wed, 13 May 2026 01:22:01 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTHxAB1sPWwpHFE4HWnVGBkV7TR4scV93XQFNdykGXnNGfUsGLnceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778635325; x=1781227325;
 bh=XtiLvt3L0Ijs8phMlB5ZtRDrIac5qY9OlmO8Y2kiqhk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=cZx1dNQCqVdR3QKTQ91Z5vtaUhbr2wgZenqcohIHRQOlEEDveDR0EZJz54V6n3xhKqlzI/yDugtWXGLGGpSI9wxy5SCBBKRD83wINT5NrwHml+1YTfXMgsUEg9Pv/8Jf0GYCdqswZusgvaEZ2HHRN+tSRga71vgJfcrwc5JTdwHB1U/N5VJqVEcg1QQ+TqWTimfuMDGjifvEo+PwrSDUdB9YITPKakuylT4ZqTqi5XWLNd2dHnJMp5SwiiQub+owT8Ao32y6cWKVMzAiLI3MgXODjnSfAq6RV/KM06cDnCMTkucGn5VXKC9d5szEZzcR5CjLxCU6M+DKyUj9zmVm+Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-5 (Postfix) with ESMTPSA id
 497C0180123F; Wed, 13 May 2026 01:22:00 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260427195516.46256-1-scottjgo@gmail.com>
Date: Wed, 13 May 2026 03:21:48 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8468087-647B-45B5-AF4E-85DD15A6D35C@unpredictable.fr>
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDAxMCBTYWx0ZWRfX3u9RExcMOUX4
 KNAfu/DUdmQQUjOjiGMtuMZj54B4n1V6rLW/CWdpTV+mtxxVUhl6jkMUpDgvbgvK8Yriux/3KuS
 5YxkTyj2vFnk2Z0+Ctg5k1Hv//TxsyBSlONe+6c2EjpkX2aCG6fRrIR3dbJkKg1H6t5OT2mtM1Q
 1fYL+I0TAXr1/RplTQaMDz0Q+uNqYIYFlw4J4RBZYRYLBetFO1VA01YzSO3yAZ9f1u+7pvNJmdo
 IYzBB61hLR3vRe47bYx4zeAKe65DJmcUe2p0jISurEilqxTjeHLKhgCjLtxXuDfQjoM/RAWrvUz
 JWqMN+rPIhUrlM2ETCOTwQp/Y/2dlUx6kjKIBoaQ3h09glX/ESoCI0vfRo7uHQ=
X-Authority-Info-Out: v=2.4 cv=UbtciaSN c=1 sm=1 tr=0 ts=6a03d23b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Pf3ESV-AWNvdeBmIBbQA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: rqPq67BQfNC3ums2YTxs2jUttOIxotz_
X-Proofpoint-GUID: rqPq67BQfNC3ums2YTxs2jUttOIxotz_
Received-SPF: pass client-ip=57.103.78.76;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


> On 27. Apr 2026, at 21:55, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>=20
> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> changed hvf_wfi() from blocking the vCPU thread with pselect() to
> returning EXCP_HLT, intending QEMU's main event loop to handle the
> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
> always returns false and the vCPU thread spins at 100% CPU per core
> while the guest is idle.
>=20
> Fix this by:
>=20
> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>  halt_cond in qemu_process_cpu_events().
>=20
> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>  virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>  because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>  hv_vcpu_run(), which is not called while the CPU is halted. The
>  timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>  vtimer IRQ through the GIC and marks vtimer_masked, causing the
>  interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>=20
> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>  indicates a pending interrupt, and cancelling the WFI timer.
>=20
> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>  transition for any halted vCPU, since the QEMUTimer is per-instance
>  state and is not migrated. After cpu_synchronize_all_states() the
>  migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>  and CNTV_CVAL from there. If the vtimer has already expired by the
>  time the destination resumes, hvf_wfi_timer_cb() is invoked
>  directly so the halted vCPU is woken up.
>=20
> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
> ---
> Changes since v2:
> - Use QEMU_CLOCK_VIRTUAL instead of QEMU_CLOCK_HOST so the timer
>  pauses with the VM and a halted vCPU isn't woken (or its IRQ
>  raised) while the user has stopped the guest. (Peter)
> - Convert vtimer ticks to nanoseconds with muldiv64() to avoid
>  intermediate overflow. (Peter)
> - Re-arm the WFI timer from hvf_vm_state_change() on the resume
>  transition so a halted vCPU on the migration destination is
>  woken when its vtimer expires (the QEMUTimer is per-instance
>  state and isn't migrated). (Peter)
> v2: =
https://lore.kernel.org/qemu-devel/20260410055045.63001-1-scottjgo@gmail.c=
om/
> v1: =
https://lore.kernel.org/qemu-devel/20260410044726.61853-1-scottjgo@gmail.c=
om/

For QEMU 11.0 (for backporting to stable):

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

For QEMU 11.1:

Adding some checks for !hvf_irqchip_in_kernel() needed
but can do them on my side if you prefer.

Looks ready apart from that bit.

>=20
> include/system/hvf_int.h |   1 +
> target/arm/hvf/hvf.c     | 124 ++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 124 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 2621164cb2..58fb865eba 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -48,6 +48,7 @@ struct AccelCPUState {
>    hv_vcpu_exit_t *exit;
>    bool vtimer_masked;
>    bool guest_debug_enabled;
> +    struct QEMUTimer *wfi_timer;
> #endif
> };
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 678afe5c8e..a19d7a5e1f 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -28,6 +28,7 @@
> #include "hw/core/boards.h"
> #include "hw/core/irq.h"
> #include "qemu/main-loop.h"
> +#include "qemu/timer.h"
> #include "system/cpus.h"
> #include "arm-powerctl.h"
> #include "target/arm/cpu.h"
> @@ -301,6 +302,8 @@ void hvf_arm_init_debug(void)
> #define TMR_CTL_IMASK   (1 << 1)
> #define TMR_CTL_ISTATUS (1 << 2)
>=20
> +static void hvf_wfi_timer_cb(void *opaque);
> +
> static uint32_t chosen_ipa_bit_size;
>=20
> typedef struct HVFVTimer {
> @@ -1214,6 +1217,9 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
> {
>    hv_return_t ret;
>=20
> +    timer_free(cpu->accel->wfi_timer);
> +    cpu->accel->wfi_timer =3D NULL;
> +
>    ret =3D hv_vcpu_destroy(cpu->accel->fd);
>    assert_hvf_ok(ret);
> }
> @@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>                              =
arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
>    assert_hvf_ok(ret);
>=20
> +    cpu->accel->wfi_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          hvf_wfi_timer_cb, cpu);
> +
adding !hvf_irqchip_in_kernel()

>     aarch64_add_sme_properties(OBJECT(cpu));
>    return 0;
> }
> @@ -2027,8 +2036,67 @@ static uint64_t hvf_vtimer_val_raw(void)
>    return mach_absolute_time() - hvf_state->vtimer_offset;
> }
>=20
> +static void hvf_wfi_timer_cb(void *opaque)
> +{
> +    CPUState *cpu =3D opaque;
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
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
> +    cpu->accel->vtimer_masked =3D true;
> +}
> +
> +/*
> + * Arm a host-side QEMU_CLOCK_VIRTUAL timer to fire when the guest's
> + * vtimer (CNTV_CVAL_EL0) is scheduled to expire. HVF only delivers
> + * HV_EXIT_REASON_VTIMER_ACTIVATED during hv_vcpu_run(), which we =
won't
> + * call while the vCPU is halted, so we need this to wake the vCPU.
> + *
> + * QEMU_CLOCK_VIRTUAL pauses while the VM is stopped, which keeps the
> + * timer in lockstep with the guest's view of vtime across =
pause/resume.
> + *
> + * Caller must supply the current CNTV_CTL_EL0 and CNTV_CVAL_EL0 =
values,
> + * since the appropriate source (HVF vs. env) depends on context.
> + *
> + * Returns 0 if the timer was armed (or if the vtimer is =
disabled/masked
> + * and the vCPU should still halt waiting on another event), or -1 if
> + * the vtimer has already expired.
> + */
> +static int hvf_arm_wfi_timer(CPUState *cpu, uint64_t ctl, uint64_t =
cval)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    uint64_t now;
> +    int64_t delta_ns;
> +
> +    if (!(ctl & TMR_CTL_ENABLE) || (ctl & TMR_CTL_IMASK)) {
> +        return 0;
> +    }
> +
> +    now =3D hvf_vtimer_val_raw();
> +    if (cval <=3D now) {
> +        return -1;
> +    }
> +
> +    delta_ns =3D muldiv64(cval - now, NANOSECONDS_PER_SECOND,
> +                        arm_cpu->gt_cntfrq_hz);
> +    timer_mod(cpu->accel->wfi_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delta_ns);
> +    return 0;
> +}
> +
> static int hvf_wfi(CPUState *cpu)
> {
> +    uint64_t ctl, cval;
> +    hv_return_t r;
> +
>    if (cpu_has_work(cpu)) {
>        /*
>         * Don't bother to go into our "low power state" if
> @@ -2037,6 +2105,22 @@ static int hvf_wfi(CPUState *cpu)
>        return 0;
>    }
>=20
> +    /*
> +     * Read the vtimer state directly from HVF. We're on the vCPU =
thread,
> +     * just exited from hv_vcpu_run(), so HVF holds the authoritative
> +     * values and env may be stale.
> +     */
> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CTL_EL0, &ctl);
> +    assert_hvf_ok(r);
> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CVAL_EL0, &cval);
> +    assert_hvf_ok(r);
> +
> +    if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
> +        /* vtimer already expired, don't halt */
> +        return 0;
> +    }
> +
> +    cpu->halted =3D 1;
>    return EXCP_HLT;
> }
>=20
> @@ -2332,7 +2416,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>    hv_return_t r;
>=20
>    if (cpu->halted) {
> -        return EXCP_HLT;
> +        if (!cpu_has_work(cpu)) {
> +            return EXCP_HLT;
> +        }
> +        cpu->halted =3D 0;
> +        timer_del(cpu->accel->wfi_timer);
!hvf_irqchip_in_kernel(), we shouldn=E2=80=99t have the wfi timer =
otherwise
>     }
>=20
>    flush_cpu_state(cpu);
> @@ -2376,11 +2464,45 @@ static const VMStateDescription =
vmstate_hvf_vtimer =3D {
> static void hvf_vm_state_change(void *opaque, bool running, RunState =
state)
> {
>    HVFVTimer *s =3D opaque;
> +    CPUState *cpu;
>=20
>    if (running) {
>        /* Update vtimer offset on all CPUs */
>        hvf_state->vtimer_offset =3D mach_absolute_time() - =
s->vtimer_val;
>        cpu_synchronize_all_states();
> +
> +        /*
> +         * After migration restore (or any resume), the wfi_timer is =
not
> +         * scheduled on this QEMU instance, so re-arm it for any =
halted
> +         * vCPU with a pending vtimer. For a non-migration resume the
> +         * QEMU_CLOCK_VIRTUAL timer was already scheduled; =
recomputing the
> +         * deadline produces the same value and is a harmless no-op.
> +         *
> +         * cpu_synchronize_all_states() above ensures env mirrors the
> +         * authoritative vtimer state (whether that came from HVF or =
from
> +         * the migration stream), so we can safely read it here from =
the
> +         * iothread.
> +         */

This should be gated behind !hvf_irqchip_in_kernel()

> +        CPU_FOREACH(cpu) {
> +            ARMCPU *arm_cpu;
> +            uint64_t ctl, cval;
> +
> +            if (!cpu->accel || !cpu->halted) {
> +                continue;
> +            }
> +
> +            arm_cpu =3D ARM_CPU(cpu);
> +            ctl =3D arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
> +            cval =3D arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
> +
> +            if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
> +                /*
> +                 * vtimer already expired while we were paused; raise =
the
> +                 * IRQ now so the halted vCPU wakes up.
> +                 */
> +                hvf_wfi_timer_cb(cpu);
> +            }
> +        }
>    } else {
>        /* Remember vtimer value on every pause */
>        s->vtimer_val =3D hvf_vtimer_val_raw();
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20


