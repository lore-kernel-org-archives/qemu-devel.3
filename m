Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73718F36BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4QE-0007x5-5s; Fri, 10 Apr 2026 01:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wB4QB-0007ws-Vr
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:28:48 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wB4QA-0007F4-4H
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 01:28:47 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so2478810eec.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775798924; x=1776403724; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//BvhHT67uK2nLwJxFUrnIe05Ect6gqGWpNnBixz1iE=;
 b=s0gY8Xdd1r1i/xzPkrrs0TwUcnq3BdYAIRLz0R1APG1EiyyS5GD2fFvf54VuCc3rL8
 humVLojKkaQm5pd9QkW8GhgtH/xSbHyuQPX/pUFqekT1TbBOEetrovoFLzapbACL7XlP
 eYx8TjSO2jWbVvhkvljr3bCMtbYcbcb257/hUJKe7RmSqpF/Tlfvw0D02h2p80f9BBW4
 yc5eYGLULcRUjG5IBJuQ+oI8FrpucvBbiu2OnjI1vFhL1NVGHFe5xiuXByld/ktEfBaF
 IJNn53/k+Yqyq1vQRO0moPmr6T7J6ggdN5EyIfd1YkpJ68P6DYqkHCuYFoJPu+kf5mCR
 E9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775798924; x=1776403724;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//BvhHT67uK2nLwJxFUrnIe05Ect6gqGWpNnBixz1iE=;
 b=Uf0DsEsJDzUDE/7HQ1LWHiSPjEAT8Z3AwnZRKP/oCL1lv4i+hhCecMpCyFjTkPalnS
 o5lP1G/mUdoGw9rfYR4vD+2bPbgUI/NreXzC274gNz85VWeJDpy7sVW32/rql+aAsTwX
 T9GcKPpM60bsGMSNLiv21HEOkD3djXAjspIty4VsBjLAfmiCB8n3Mb2+1QfZFtOQdDUL
 RPPl6R89zmEQYVB29qurH0LLsb3XPLS7oenpGQl4yrS18jPTAGEMpeq4AVLr8mzehUD/
 DdKiiNo2bQNdoJI3wPSp4KMRxBSx+S9RQ90v9hlvoRcJsTdOJcd8uZGp4qETRWeoaY0b
 iVWw==
X-Gm-Message-State: AOJu0Yx1kOWfBMFr6h6+8kWliJzbxW9NRq8eK9BSYy4dohjsrUaMk8mr
 szj+AY4MwY285Z8Ow/sApHheuaiFXNY42mZ8my1OYtddn1UkOzLzJd5I
X-Gm-Gg: AeBDievjLUQ5Rx6iLkkTCrw26q7tFG3tzaTEMidsv4/YUdFQrZlRbAHjHzY0JyYaQbx
 l25o8w5eX5YdUisvffk7xmp5vCGEnd4R9LquAK1Al3EAxNE8RVixqLMZD6UZsax6XqDarPBsu4A
 CzfEsMJolKyWxzHhVUcK2u8LqUebm/9ddzGGOOpTBXz7ZjpfL3932c7wiAwPf7o+NmX5jmh7Fct
 EXlQ2NhDd92E+4i5hSyPF626TCbpGYnEqBfHBuRtgpCzK/ZVGGlwiGhF282+Vb18uQw549NJiOK
 Ug8w0aCD4GVNwv3NgRONPi8NcNCTDEHQjZth+7sMsJO4RlmGeaQtpqMLu5Vmes8V5LUOx3i80rL
 Zi8gjN5pdIp2RmENaMTtO2G5/WlsJtIio/o/WdXCPBFdBLk28p9dmCTVMpkerp62DnNXrylIHlO
 n78cVbhM6+L0iYMQQUIF3iq5csUAW0Plhz+8BOfikH5oU1XuOIyGjUxdfN7kYD8RMwNc5ObDH7A
 5M6Dkcsif4=
X-Received: by 2002:a05:7301:608e:b0:2c1:6cfd:73ee with SMTP id
 5a478bee46e88-2d589898d4cmr957712eec.24.1775798924080; 
 Thu, 09 Apr 2026 22:28:44 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:ade2:73a1:54c5:e0fe])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69casm3396964eec.2.2026.04.09.22.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 22:28:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 22:28:42 -0700
Message-Id: <DHP86IRPEW4G.16N17DFVR56EW@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <rbolshakov@ddn.com>,
 <phil@philjordan.eu>, <agraf@csgraf.de>, <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Mohamed Mediouni" <mohamed@unpredictable.fr>, "Scott J. Goldman"
 <scottjgo@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260410044726.61853-1-scottjgo@gmail.com>
 <E41FA391-ABC2-4CA9-850C-BDB3263C1E07@unpredictable.fr>
In-Reply-To: <E41FA391-ABC2-4CA9-850C-BDB3263C1E07@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Apr 9, 2026 at 10:06 PM PDT, Mohamed Mediouni wrote:
>
>
>> On 10. Apr 2026, at 06:47, Scott J. Goldman <scottjgo@gmail.com> wrote:
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
>>   halt_cond in qemu_process_cpu_events().
>>=20
>> 2. Arming a host-side QEMU_CLOCK_HOST timer to fire when the guest's
>>   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>   hv_vcpu_run(), which is not called while the CPU is halted. The
>>   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>   vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>=20
>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>   indicates a pending interrupt, and cancelling the WFI timer.
>>=20
>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/959
>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>
> Hi,
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> include/system/hvf_int.h |  1 +
>> target/arm/hvf/hvf.c     | 65 +++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 65 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>> index 2621164cb2..58fb865eba 100644
>> --- a/include/system/hvf_int.h
>> +++ b/include/system/hvf_int.h
>> @@ -48,6 +48,7 @@ struct AccelCPUState {
>>     hv_vcpu_exit_t *exit;
>>     bool vtimer_masked;
>>     bool guest_debug_enabled;
>> +    struct QEMUTimer *wfi_timer;
>> #endif
>> };
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 5fc8f6bbbd..0e737d3583 100644
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
>>     hv_return_t ret;
>>=20
>> +    timer_free(cpu->accel->wfi_timer);
>> +    cpu->accel->wfi_timer =3D NULL;
>> +
>>     ret =3D hv_vcpu_destroy(cpu->accel->fd);
>>     assert_hvf_ok(ret);
>> }
>> @@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]=
);
>>     assert_hvf_ok(ret);
>>=20
>> +    cpu->accel->wfi_timer =3D timer_new_ns(QEMU_CLOCK_HOST,
>> +                                          hvf_wfi_timer_cb, cpu);
>> +
>>     aarch64_add_sme_properties(OBJECT(cpu));
>>     return 0;
>> }
>> @@ -2027,8 +2036,29 @@ static uint64_t hvf_vtimer_val_raw(void)
>>     return mach_absolute_time() - hvf_state->vtimer_offset;
>> }
>>=20
>> +static void hvf_wfi_timer_cb(void *opaque)
>> +{
>> +    CPUState *cpu =3D opaque;
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +
>> +    /*
>> +     * vtimer expired while the CPU was halted for WFI.
>> +     * =09
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
>> static int hvf_wfi(CPUState *cpu)
>> {
>> +    uint64_t ctl, cval;
>> +    hv_return_t r;
>> +
>>     if (cpu_has_work(cpu)) {
>>         /*
>>          * Don't bother to go into our "low power state" if
>> @@ -2037,6 +2067,35 @@ static int hvf_wfi(CPUState *cpu)
>>         return 0;
>>     }
>>=20
>> +    /*
>> +     * Set up a host-side timer to wake us when the vtimer expires.
>> +     * HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>> +     * hv_vcpu_run(), which we won't call while halted.
>> +     */
>> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, =
&ctl);
>> +    assert_hvf_ok(r);
>> +
>> +    if ((ctl & TMR_CTL_ENABLE) && !(ctl & TMR_CTL_IMASK)) {
>> +        r =3D hv_vcpu_get_sys_reg(cpu->accel->fd,
>> +                                HV_SYS_REG_CNTV_CVAL_EL0, &cval);
>> +        assert_hvf_ok(r);
>> +
>> +        uint64_t now =3D hvf_vtimer_val_raw();
>> +        if (cval <=3D now) {
>> +            /* Timer already expired, don't halt */
>> +            return 0;
>> +        }
>> +
>> +        uint64_t delta_ticks =3D cval - now;
>
> We have CNTFRQ_EL0 in cpu->gt_cntfrq_hz but this works too
> as XNU today tries to take care that host and VM run with
> the same CNTFRQ_EL0
>

Ah, I can post a follow-up.

>> +        mach_timebase_info_data_t timebase;
>> +        mach_timebase_info(&timebase);
>> +        int64_t delta_ns =3D delta_ticks * timebase.numer / timebase.de=
nom;
>> +        int64_t deadline =3D qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta=
_ns;
>> +
>> +        timer_mod(cpu->accel->wfi_timer, deadline);
>> +    }
>> +
>> +    cpu->halted =3D 1;
>>     return EXCP_HLT;
>> }
>>=20
>> @@ -2332,7 +2391,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>>     hv_return_t r;
>>=20
>>     if (cpu->halted) {
>> -        return EXCP_HLT;
>> +        if (!cpu_has_work(cpu)) {
>> +            return EXCP_HLT;
>> +        }
>> +        cpu->halted =3D 0;
>> +        timer_del(cpu->accel->wfi_timer);
>>     }
>>=20
>>     flush_cpu_state(cpu);
>> --=20
>> 2.50.1 (Apple Git-155)
>>=20
>>=20

Thanks,
-sjg

