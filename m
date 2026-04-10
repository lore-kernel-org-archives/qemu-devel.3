Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E3FF36BAA
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB44n-0002je-O5; Fri, 10 Apr 2026 01:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wB44l-0002jA-PE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:06:39 -0400
Received: from p-west2-cluster6-host3-snip4-10.eps.apple.com ([57.103.70.13]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wB44j-000853-CS
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:06:39 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 E1A08180019A; Fri, 10 Apr 2026 05:06:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775797594; x=1778389594;
 bh=fFlzdLPddqiJVPIuJDZJCC+IL3keDdWnwv2Sa7Yn6v0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QsXvj74slMkKp13EKOo+omkKPSDdqrSSnqV+FyQ1ZHmNRPY4FGRaE07FCn8dzpRhRfosO8jHgS6e6XB+s9T6puD7MtSf1X97zHBHf+cny05lWV3CLqHPHZz+4eS+MwfU04HYsgaCc+DjhkCcLRaT4kIjXBzdUWU66Xv0Qg2ALJsPVJ8G5tD/e/3H9e47Q+z6rkV+tN78N7Jd/CZiuLAdbbE7Bmuxwu6Yz1OIne7szE8PNUovohz8v53sDkpBiP+YQ/2zela29gnVTNmAnc8g2bjtCoyomP0mvDkm0WKQlI6GDotLqOZIC7y0vffxi3xg9EjKcizRyuRPGIHV0/l5uQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 D5C2B1800136; Fri, 10 Apr 2026 05:06:31 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260410044726.61853-1-scottjgo@gmail.com>
Date: Fri, 10 Apr 2026 07:06:18 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, rbolshakov@ddn.com,
 phil@philjordan.eu, agraf@csgraf.de, peter.maydell@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E41FA391-ABC2-4CA9-850C-BDB3263C1E07@unpredictable.fr>
References: <20260410044726.61853-1-scottjgo@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=Ze0Q98VA c=1 sm=1 tr=0 ts=69d8855a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8
 a=wG9qhmRfGSGoVh_Ie2YA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: bNDyCNcHHrbGMgKGnHAz24R8jL1U25C9
X-Proofpoint-ORIG-GUID: bNDyCNcHHrbGMgKGnHAz24R8jL1U25C9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA0NCBTYWx0ZWRfX+rqT4V4g3iYu
 +SSX/E5ni58RvtiFXkGf4T6cpEMNLBGLAeS0M2VdDBgL01Hc03RLpPByowr9R4zU/MW/uQiK9q2
 ki5IhMczd1lDTkZIg71K/wQnrChqiYbNh5uBsDXfouFUqXnseWx/eG66YxNAlpk67Cvvyp1N17c
 +M9nIXeImU7EChUOP/K0rY5tp5C9Uq7X7EMPn+1Tdy2XAYvRfjC5RTNot1IGzGcNyhhVf9chjjv
 ukVScojm0bnU/ctCO7AE3wMfnVqD6cQ4dXVcWLEkqQvKK/D3QfQT2saLIFZEwOcPTJ2QOa+J5Pa
 KW1IMBC34F6w07bFdwXnqBcHlMb3H0B6NUEjoEgTMxk5Cwysn+ioB/0u6jquL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0
 clxscore=1030 adultscore=0 mlxlogscore=999 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604100044
Received-SPF: pass client-ip=57.103.70.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 10. Apr 2026, at 06:47, Scott J. Goldman <scottjgo@gmail.com> =
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
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/959
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>

Hi,

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
> index 5fc8f6bbbd..0e737d3583 100644
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
> @@ -2027,8 +2036,29 @@ static uint64_t hvf_vtimer_val_raw(void)
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
> +     * =09
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
> +    uint64_t ctl, cval;
> +    hv_return_t r;
> +
>     if (cpu_has_work(cpu)) {
>         /*
>          * Don't bother to go into our "low power state" if
> @@ -2037,6 +2067,35 @@ static int hvf_wfi(CPUState *cpu)
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

We have CNTFRQ_EL0 in cpu->gt_cntfrq_hz but this works too
as XNU today tries to take care that host and VM run with
the same CNTFRQ_EL0

> +        mach_timebase_info_data_t timebase;
> +        mach_timebase_info(&timebase);
> +        int64_t delta_ns =3D delta_ticks * timebase.numer / =
timebase.denom;
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


