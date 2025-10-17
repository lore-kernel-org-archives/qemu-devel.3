Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BE7CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 01:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ZVF-0001FX-Eh; Thu, 16 Oct 2025 21:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v9ZVC-0001FO-5h
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 21:43:31 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v9ZV4-0008VA-UV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 21:43:29 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3c99a6a2afeso36622fac.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1760665399; x=1761270199; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6sJdcKSsm3k4g1+uesAYaOVYh8uUI6CcxdyeEXJiB0=;
 b=O/5JMcK/S7cyP1DqO5Bkh6ihqctTq1gcRR3FoleIU83F3l486ejJ0xPTAq75bMgooi
 8YO0Ok7USHAysvpsu0rZWkdjbNlRQXyCtzV8qkOUuxojrqIjiWWmQxq9jwgn3WCeMn/B
 Hr2UIJrIEtQpO63Id5q29Y6XP4i3OLYUjC3rNxAICIR1h+2snG2I7iaSFltwMNY+uLp+
 Jpd9PGD+LdjFLc/LCAVqxrWmYAVJJBUlGHYev1FaU7ns79K4UC7ZLL/qn1sCC5Yu/BhN
 X/9lCzpF3rmwhS3qWfEcKTHXpRWRo7gi4fDlpExFxg5Lsbq0spgzN/nFT4HVYMt+McFS
 iRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760665399; x=1761270199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6sJdcKSsm3k4g1+uesAYaOVYh8uUI6CcxdyeEXJiB0=;
 b=TdUZDbBhn7U84ah1RTNISoklN4Qk+QumGyJbhPvPwQ+LldYqWlUFXPwR//QZW+9Tjt
 ksOOfwxQiju8QqF9CvcuMwEvWjdV/VKrqK1RPYdqjr3EC5s0wky8guYdDE/Pn9aaPhYg
 llcf9iW1jwVgyoRbtpGbBtifP2W9rGs3/rC7igJszRO/U3sL81jivvZTXd++4hU27vKF
 XUb3djM8rotb2s2AxG3BES3GU8vaOTPyD0K2LQyY7Fwp/FZmroMVaUQQCTIlqUCFdKE2
 NUD5qcy4vVqG07lwTHCe3nJl2DNnl/87sqnPjc91IhjEsIah0M4RBl+mR6FmffqMC9OW
 sF3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4bQAJoqSpaFRshwZdlfYKiR0MSNgDHVuQm/VONi2N+8+UfyyI5idn/atXCN03X2u5OFNhRn3a89ZR@nongnu.org
X-Gm-Message-State: AOJu0YzXKqOTOcGK9/eb2e0/KJDxcWlayMKA3GDRMtbd/N+0FoxuYHj3
 xnOT8zufaK/NT0To6dTDCyS7cB2ogAKihebXDwgFdJBrkpwlHllluS3pugF/adCMa+jurigGXlm
 xNzjwxnVDfW1h531jGZrIbaRtNZrWISZeN8QrYutzPw==
X-Gm-Gg: ASbGncvFxUJXy2z7SjZb905uhwSvLSQac5eLe/nal5NqBp/zRZpkxcNQx36biRCRn/4
 OACEST7wgruDMnYoLp09I4R3e2owC1SPHgYH/kqSxEBIPzEvBObJcvs2SOaCott5HcKMSorlpx8
 uZ9nYLdbGIZx9Xs1GUpfHy/i93ZSM4zuBkvKHXCL3wrxkPtf4jb9QYecexRL+sF6s1y5zO7f3e3
 36szx2Xu/CM7EtIECAFkLPZTqul3AusbYux6AST3ZHivys1F81O1m4vNAKaV17OwqNiNexTWfa6
 G9rSLzEeZRZUxd/d9K4xnjOkVpi/4R6Ti5GUNw1nRA==
X-Google-Smtp-Source: AGHT+IEQUsnrISjmT75iKk+2NAwG8ailkrxSchrkcQJCy1dbWQTt5MrpivSBVc+2YqXTJ9TBAdG/juUPKq6QmP2qjg4=
X-Received: by 2002:a05:6871:4188:b0:34b:3002:d48e with SMTP id
 586e51a60fabf-3c98d17d43amr794113fac.50.1760665398705; Thu, 16 Oct 2025
 18:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
 <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
 <a630fc58d9f946988bd6c27479543dd1@huawei.com>
 <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
 <880fc89ebcb9404cbc135a501e635671@huawei.com>
 <CAFEAcA-gZj7PBM4whrvvz=qy3taO9Dz4Z2HEAAB8cE0vxH3bug@mail.gmail.com>
 <bdc3791ac7004bb281447cb8b707995f@huawei.com>
In-Reply-To: <bdc3791ac7004bb281447cb8b707995f@huawei.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Fri, 17 Oct 2025 01:43:07 +0000
X-Gm-Features: AS18NWAg9pWOWKgUBUP_IcI9ti-uG1SIoXREDkbwlrkvqbo1QyV8AA53m-unVRM
Message-ID: <CAJ7pxeZpUKLzgp50N=qVQuBSn5MJ3rkruMvwSPbDgxHnLkX5Bw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x33.google.com
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

Hi Peter,

On Tue, Oct 14, 2025 at 7:36=E2=80=AFPM Salil Mehta <salil.mehta@huawei.com=
> wrote:
>
> Hi Peter,
>
> > From: qemu-devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org <qemu-
> > devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Peter
> > Maydell
> > Sent: Tuesday, October 14, 2025 4:44 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> >
> > On Tue, 14 Oct 2025 at 16:33, Salil Mehta <salil.mehta@huawei.com> wrot=
e:
> > >
> > > > From: Peter Maydell <peter.maydell@linaro.org>
> > > > Sent: Tuesday, October 14, 2025 4:24 PM
> > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > >
> > > > On Tue, 14 Oct 2025 at 16:13, Salil Mehta <salil.mehta@huawei.com>
> > wrote:
> > > > >
> > > > > > From: Peter Maydell <peter.maydell@linaro.org> In what situatio=
n
> > > > > > do we ever start running a VCPU before the *GIC* has been
> > > > > > realized? The GIC should get realized as part of creating the
> > > > > > virt board, which must complete before we do anything like runn=
ing a
> > vcpu.
> > > > >
> > > > >
> > > > > Just after realization of vCPU in the machvirt_init() you can see
> > > > > the default power_state is PSCI CPU_ON, which means
> > > > KVM_MP_STATE_RUNNABLE.
> > > > > Since, the thread is up and not doing IO wait in userspace it get=
s
> > > > > into
> > > > > cpu_exec() loop and actually run KVM_RUN IOCTL. Inside the KVM it
> > > > > momentarily takes the vCPU mutex but later exit and releases. Thi=
s
> > > > > keeps going on for all of the vCPU threads realized early.
> > > >
> > > > Yikes. We definitely should fix that : letting the vcpu run before
> > > > we get to
> > > > qemu_machine_creation_done() seems like it would be a massive sourc=
e
> > > > of race conditions.
> > >
> > > I've already proposed fix for this by parking such threads in
> > > userspace. Please check functions virt_(un)park_cpu_in_userspace().
> > > But need to check if we can use this trick can be used at the very ea=
rly
> > stages of the VM initialization.
> >
> > I had a look at this on x86, and we correctly don't try to KVM_RUN the =
vcpus
> > early. What happens there is:
> >  * the vcpu thread calls qemu_process_cpu_events()
>
>
> I cannot find this function in the Qemu mainline of 28th September ?
>
>
> >  * this causes it to go to sleep on the cpu->halt_cond: so
> >    it will not end up doing KVM_RUN yet
> >  * later, the main thread completes initialization of the board
> >  * qdev_machine_creation_done() calls cpu_synchronize_all_post_init()
> >  * for kvm, this causes us to call kvm_cpu_synchronize_post_init()
> >    for each vcpu
> >  * that will call run_on_cpu() which ends up calling qemu_cpu_kick()
> >  * qemu_cpu_kick() does a broadcast on cpu->halt_cond, which
> >    wakes up the vcpu thread and lets it go into kvm_cpu_exec()
> >    for the first time
> >
> > Why doesn't this mechanism work on Arm ?
>
> It is a combination of things:
>
> void qemu_wait_io_event(CPUState *cpu)
> {
> [...]
>     while (cpu_thread_is_idle(cpu)) {
>          [...]
>         qemu_cond_wait(cpu->halt_cond, &bql);
>     }
> [...]
> }
>
> 1. To block we should wait on 'halt_cond' as you rightly pointed.
> 2. but condition to wait is to check of the CPU is IDLE or not.
> 3. Various conditions in which CPU can be termed IDLE are:
>      3.1  STOPPED
>      3.2  HALTED
>      3.3 It does not have any queued  work to process.
>
>

I was partly wrong in my earlier analysis=E2=80=94sorry about that. The rea=
l flow is:

qdev_realize() -> qemu_vcpu_init() sets CPUState::stopped =3D true.
This ensures the threads created during machvirt_init() block in I/O
wait. That part works as expected.

qemu_system_reset() runs via qemu_machine_creation_done(). This performs
the CPU reset, and cpu_common_reset_hold() initializes
CPUState::halted from the start-powered-off property.

resume_all_vcpus() is called from vm_start(). It sets
CPUState::stopped =3D false and kicks each vCPU. However,
CPUState::halted remains whatever start-powered-off configured
(typically 1 for secondaries).

Thus, for each secondary vCPU we have: halted =3D 1, stopped =3D 0.

These conditions should be sufficient for the vCPU thread to be treated as
idle and to sleep (I/O wait) on halt_cond.

However, inside cpu_thread_is_idle(), the halted =3D 1 condition is
effectively bypassed because kvm_halt_in_kernel_allowed defaults to
true. As a result, the thread does not take the userspace sleep path
even though the vCPU is halted.

I traced the code and the earlier patch as follows:

bool cpu_thread_is_idle(CPUState *cpu)
{
    if (cpu->stop || !cpu_work_list_empty(cpu)) {
        return false;
    }
    if (cpu_is_stopped(cpu)) {
        return true;
    }
    if (!cpu->halted || cpu_has_work(cpu)) {
        return false;
    }

     // at this point we expect CPUState::halted =3D 1

    if (cpus_accel->cpu_thread_is_idle) {
        /* flows goes into this for ARM and returns false */
        return cpus_accel->cpu_thread_is_idle(cpu);
    }
    return true;
}

where cpu_thread_is_idle =3D kvm_vcpu_thread_is_idle()

static bool kvm_vcpu_thread_is_idle(CPUState *cpu)
{
    return !kvm_halt_in_kernel();
}


File: kvm.h
/**
 * kvm_halt_in_kernel
 *
 * Returns: true if halted cpus should still get a KVM_RUN ioctl to run
 * inside of kernel space. This only works if MP state is implemented.
 */
#define kvm_halt_in_kernel() (kvm_halt_in_kernel_allowed)


File: target/arm/kvm.c
int kvm_arch_init(MachineState *ms, KVMState *s)
{
[...]

    /*
     * PSCI wakes up secondary cores, so we always need to
     * have vCPUs waiting in kernel space
     */
    kvm_halt_in_kernel_allowed =3D true;
[...]
}

Patch: ARM: KVM: Enable in-kernel timers with user space gic
https://lore.kernel.org/qemu-devel/1499768952-24990-4-git-send-email-peter.=
maydell@linaro.org/

Net effect: even when halted =3D 1 and there is no work, KVM/ARM forces
cpu_thread_is_idle() to return false so the thread enters KVM_RUN. This
causes vCPU lock contention during the VM Initialization.

It looks to be a 2017 patch, maybe you can help throw more light in this?


Many thanks!

Best regards
Salil.

