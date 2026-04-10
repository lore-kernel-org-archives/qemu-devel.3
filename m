Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFF8F36BAE
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 06:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB5D8-0007MO-Ig; Fri, 10 Apr 2026 02:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wB5D7-0007L8-2g
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 02:19:21 -0400
Received: from p-east2-cluster4-host9-snip4-2.eps.apple.com ([57.103.78.213]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wB5D4-0002F3-O5
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 02:19:20 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id
 6A6E218001BB; Fri, 10 Apr 2026 06:19:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775801956; x=1778393956;
 bh=hiGAvIkWBpXGLB9Dz+wm+Q8whPNmlxLZFKh9k4VOspQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=NEuGomWht5rSgGD+JBTR8alnk+i/HNpDoIx7L9oakLWcIrQqXxuFg6xZKlWHiWAwYQw5Z3IAZVKvOO4RIK80tBAryjvWIeDwE++P5XdP6A0Zza6+S0y4oWyY6FfckD8fWTSejW3j0EXhAKc61Yg4OT1k/TvJy+pcqHs1Y4pWhvyjW4Sffef+r6MVco9VOTHmHwuqE0kjsxadiVaiIRTrsTQpsghMGiQuZqRZr+f346DGr3gRpf8Zv438/pHjlZEdOvlY9dSEy5C/rtdTVdHoSi7P9HhfoPHNYp1Jgla0pWCuB8TLvpvnldPZ7PsUkYrSAQvW7QH7L9liHjnFLMdfkw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id
 82DF21802183; Fri, 10 Apr 2026 06:19:07 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260410055045.63001-1-scottjgo@gmail.com>
Date: Fri, 10 Apr 2026 08:18:55 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, rbolshakov@ddn.com,
 phil@philjordan.eu, agraf@csgraf.de, peter.maydell@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86D19C52-2A31-4802-ADF2-703D9AE83E75@unpredictable.fr>
References: <20260410044726.61853-1-scottjgo@gmail.com>
 <20260410055045.63001-1-scottjgo@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=Ze0Q98VA c=1 sm=1 tr=0 ts=69d8965d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=wG9qhmRfGSGoVh_Ie2YA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: OJhmKsaVbVnmJ8oYEkiXMoQ5nDGyRuzI
X-Proofpoint-ORIG-GUID: OJhmKsaVbVnmJ8oYEkiXMoQ5nDGyRuzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1NyBTYWx0ZWRfX4wran3CTUTwA
 x9k1EZg7o+eBI5+araeSLY0doc2iQQ4Q93K65YyD+7xfDSNo+j2ejvWcg6/1Re049BMV6opbSX9
 zSUOzT+gfnIj/3O16TU6iZiGIoeUvZBFzQY06VmXcBUCat1If5gf6pke7Z5DeeELk2kZeNkov0T
 kCag6j3pZmhOsYlJf07OIrevxWOsdH9OLj3uMlMf/DNVHN5wcOhPvHnLOpYMINjYCiakRRTQLbZ
 qALMqNCB12DKpxZHA9OkTsWcqV8gX9DMCtFTUisHexWhfvR7dUzSZYHpiU213BnGDw1O3W94ILo
 E4dHQufSIm3x7HHrEZRzhm0c8P5To9jz8BGuy8paBmtYFmxHxLTUGLJzvyJ/YA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0
 clxscore=1030 adultscore=0 mlxlogscore=999 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604100057
Received-SPF: pass client-ip=57.103.78.213;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10. Apr 2026, at 07:50, Scott J. Goldman <scottjgo@gmail.com> =
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
>   halt_cond in qemu_process_cpu_events().
>=20
> 2. Arming a host-side QEMU_CLOCK_HOST timer to fire when the guest's
>   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>   hv_vcpu_run(), which is not called while the CPU is halted. The
>   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>   vtimer IRQ through the GIC and marks vtimer_masked, causing the
>   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>=20
> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>   indicates a pending interrupt, and cancelling the WFI timer.
>=20
> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> include/system/hvf_int.h |  1 +
> target/arm/hvf/hvf.c     | 65 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 65 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 2621164cb2..58fb865eba 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -48,6 +48,7 @@ struct AccelCPUState {
>     hv_vcpu_exit_t *exit;
>     bool vtimer_masked;
>     bool guest_debug_enabled;
> +    struct QEMUTimer *wfi_timer;
> #endif
> };
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bbbd..f5d7221845 100644
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
>     hv_return_t ret;
>=20
> +    timer_free(cpu->accel->wfi_timer);
> +    cpu->accel->wfi_timer =3D NULL;
> +
>     ret =3D hv_vcpu_destroy(cpu->accel->fd);
>     assert_hvf_ok(ret);
> }
> @@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>                               =
arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
>     assert_hvf_ok(ret);
>=20
> +    cpu->accel->wfi_timer =3D timer_new_ns(QEMU_CLOCK_HOST,
> +                                          hvf_wfi_timer_cb, cpu);
> +
>     aarch64_add_sme_properties(OBJECT(cpu));
>     return 0;
> }
> @@ -2027,8 +2036,30 @@ static uint64_t hvf_vtimer_val_raw(void)
>     return mach_absolute_time() - hvf_state->vtimer_offset;
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
> static int hvf_wfi(CPUState *cpu)
> {
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    uint64_t ctl, cval;
> +    hv_return_t r;
> +
>     if (cpu_has_work(cpu)) {
>         /*
>          * Don't bother to go into our "low power state" if
> @@ -2037,6 +2068,34 @@ static int hvf_wfi(CPUState *cpu)
>         return 0;
>     }
>=20
> +    /*
> +     * Set up a host-side timer to wake us when the vtimer expires.
> +     * HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
> +     * hv_vcpu_run(), which we won't call while halted.
> +     */
> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_CNTV_CTL_EL0, &ctl);
> +    assert_hvf_ok(r);
> +
> +    if ((ctl & TMR_CTL_ENABLE) && !(ctl & TMR_CTL_IMASK)) {
> +        r =3D hv_vcpu_get_sys_reg(cpu->accel->fd,
> +                                HV_SYS_REG_CNTV_CVAL_EL0, &cval);
> +        assert_hvf_ok(r);
> +
> +        uint64_t now =3D hvf_vtimer_val_raw();
> +        if (cval <=3D now) {
> +            /* Timer already expired, don't halt */
> +            return 0;
> +        }
> +
> +        uint64_t delta_ticks =3D cval - now;
> +        int64_t delta_ns =3D delta_ticks * NANOSECONDS_PER_SECOND
> +                           / arm_cpu->gt_cntfrq_hz;
> +        int64_t deadline =3D qemu_clock_get_ns(QEMU_CLOCK_HOST) + =
delta_ns;
> +
> +        timer_mod(cpu->accel->wfi_timer, deadline);
> +    }
> +
> +    cpu->halted =3D 1;
>     return EXCP_HLT;
> }
>=20
> @@ -2332,7 +2391,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>     hv_return_t r;
>=20
>     if (cpu->halted) {
> -        return EXCP_HLT;
> +        if (!cpu_has_work(cpu)) {
> +            return EXCP_HLT;
> +        }
> +        cpu->halted =3D 0;
> +        timer_del(cpu->accel->wfi_timer);
>     }
>=20
>     flush_cpu_state(cpu);
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20


