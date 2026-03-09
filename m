Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B17F3C24A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaOZ-0006lD-IC; Mon, 09 Mar 2026 09:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzaOX-0006O6-MC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzaOU-0000Xx-Us
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773061890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ehgVpd4yoRoNoh2D8P875SHlqx+USsACWmpeLp5Vxc=;
 b=OWqVZVmmHjk3o9WENE7eTF3FVrxrEaVdkP11+71nBeAPJQUt5wbycGn5EtnFkMHXgCzd2F
 /W8RvH0OibOJfi2pJdi7T55izUJfeaVOZGYChiLmmo9ynWYlh4KCncthrD2qlG0HeOeJwX
 WvOi3iwRlagMtIEVCNHP1HnMnnmwf8I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-uHhF8mesMR6C_sV-gdm79w-1; Mon, 09 Mar 2026 09:11:29 -0400
X-MC-Unique: uHhF8mesMR6C_sV-gdm79w-1
X-Mimecast-MFC-AGG-ID: uHhF8mesMR6C_sV-gdm79w_1773061888
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ae66ee7354so59684305ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773061888; x=1773666688; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ehgVpd4yoRoNoh2D8P875SHlqx+USsACWmpeLp5Vxc=;
 b=Mgi3vU5/UpQOz8E2ShKZcEEu/44qzvkDLa+NqtxlmT4DLbp441drJDRSlhvdyZP+Vf
 RFM/0QbdryaTMeOMLLcGVOrIpEVYeDTu1RYGIcVgTT+XBW2yHtg6QKAP0Twpu4tsY726
 SlIREpbKCFe1cmnNBpvafL5tY+2gwS0F4HbPW+RVFenfR1WFUBs4pihrEFWxnG8LokNH
 xrvZgA6o8jEvqDPSyxkUPh3KYTTqxJ8lYuhIhgI1HTLMlKK/q6I4Lq40/Y08BNrhCyqk
 WjZvkbTo9yBOXt9fSP4pDIh5jzUv58d8cQiZSgF3RYOKtFzL/KtSDW5airaLBiKtKG/l
 8u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773061888; x=1773666688;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ehgVpd4yoRoNoh2D8P875SHlqx+USsACWmpeLp5Vxc=;
 b=KDA0Faug9TOloaQX0M8BpBM0wzhCVx3sFGxlNlBWAYVTFjw99+W8ZVt+cRPBwN1+Xm
 IQ9gst6nEqKjaams+ZZ2lpwRRm4YFpX5fDA+SwKzb7ryYoJllMHbYCTPPdI+ODnZi8k9
 zkaqhZC938n5M2gfMUJTODVZsgNdBPYqQxM12nD2RuXh+rz/6QaEw+e6A+zSrKa+DHUb
 UZFFtbjzRRCSLYQdNkC8ECTQ/eadyRC65U6LnntMxKjtiwjBKOdLG8pLPyksr117BsGh
 7ZTSE1jAis47XVgJqJ7un4x9Z23Lg8f/TmsvFk5X8nVYPS8JIxfHNVdSQtBAb46HZ19p
 nCUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZrOBxcs8P6rP20z1qusVDdbJUWOwpWjtFNcQZFM04bnEcVbxG9qYAimm/ZLgGTHv6KSX71NS7vL8p@nongnu.org
X-Gm-Message-State: AOJu0Yzs+yWlwyeOb8l5OrJUnyl17GqhgSjY8tRpRdGv6/e43m0bLhIG
 ImGNcdzMehrSRYyiJd5hV1fTT5EiQc6Hqa2viRUY5LMVvBDcc1r+mPX3Gi5OBe2IDgl/v8W8EuE
 XokWC6vAPFdTdbsP8Vr4hD1Bu44+GZeWpE5RHGHBEMjE+i5kbSxXz75Aw
X-Gm-Gg: ATEYQzwDmgW+u1sDaPt3E/Ol7DFM763fMKF123XyB7sRiT8SWr7PjobMCk980diN05K
 OyrIvxxj3zIXct4MoZ8QDDWNPypv8VsCxm54UOgMeztgdJ0XbYs0URcuyhe8jwpPAbqG1jKU0hk
 K4NK6ytrq5Note2cICm+V1vq1siGMPHJvD+uYmm8F6jaMOKJnG08FkefdDPYtwrEEitZh3lMhAE
 wJhGLCjfaCfyKMvvvNJSYpyl599RbqalVe1lYAvh2V+myUreEjoviqjV3baE1wu9JelvpqGJF/D
 6f+ZhTspHcE9TCGhg7vV7eJbyMUeU3lSHWLlput+QaJISHFiF+HLTyDUBbsQ1vzkVzFhmJFJM4S
 wxNhpjLg6tjnxMDTHT6i5smm4FJrsECV+JkTSa577uLwvaKzoypc9ypFer2fB3PLh2fU5m0rIe5
 Q=
X-Received: by 2002:a17:902:c94a:b0:2ae:698d:94a6 with SMTP id
 d9443c01a7336-2ae8241dd3dmr129589615ad.2.1773061887608; 
 Mon, 09 Mar 2026 06:11:27 -0700 (PDT)
X-Received: by 2002:a17:902:c94a:b0:2ae:698d:94a6 with SMTP id
 d9443c01a7336-2ae8241dd3dmr129589125ad.2.1773061886989; 
 Mon, 09 Mar 2026 06:11:26 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae840ad92fsm183046145ad.77.2026.03.09.06.11.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:11:26 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
Date: Mon, 9 Mar 2026 18:41:11 +0530
Cc: Misbah Anjum N <misanjum@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 9 Mar 2026, at 4:34=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
> Hi Ani, Paolo,
>=20
> I think the problem lies here:
>=20
> For archs which doesnt support vm fd change, we are baling out as =
below in kvm_reset_vmfd.
>=20
>=20
>    /*
>     * bail if the current architecture does not support VM file
>     * descriptor change.
>     */
>    if (!kvm_arch_supports_vmfd_change()) {
>        error_report("This target architecture does not support KVM VM =
"
>                     "file descriptor change.");
>        return -EOPNOTSUPP;
>    }
>=20
> However, when rebuild_guest (kvm_reset_vmfd) is called in
> qemu_system_reset here:
>=20
>    if ((reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>         reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
>        (current_machine->new_accel_vmfd_on_reset || =
!cpus_are_resettable())) {
>        if (ac->rebuild_guest) {
>            ret =3D ac->rebuild_guest(current_machine);
>            if (ret < 0) {
>                error_report("unable to rebuild guest: %s(%d)",
>                             strerror(-ret), ret);
>                vm_stop(RUN_STATE_INTERNAL_ERROR);
>            } else {
>                info_report("virtual machine state has been rebuilt =
with new "
>                            "guest file handle.");
>                guest_state_rebuilt =3D true;
>            }
>        } else if (!cpus_are_resettable())  {
>            error_report("accelerator does not support reset!");
>        } else {
>            error_report("accelerator does not support rebuilding guest =
state,"
>                         " proceeding with normal reset!");
>        }
>    }
>=20
>=20
> it just does a vm_stop if rebuild_guest returns < 0.
>=20
> IMHO, This should handle -EOPNOTSUPP gracefully.
> Please advise if this needs to be taken care differently?

Is this a confidential guest that cannot be normally reset?


>=20
> regards,
> Harsh
>=20
> On 09/03/26 1:58 pm, Misbah Anjum N wrote:
>> Hi Ani and Paolo,
>> Following up on my previous report, I've attempted additional =
debugging to isolate the issue on ppc64le.
>> I implemented the architecture-specific hooks for ppc64le. After =
adding the following changes and recompiling QEMU and testing with the =
direct qemu-system-ppc64 command, the hang persists with the same issue =
- no output and complete unresponsiveness.
>> Could you suggest what additional changes are needed to ensure the VM =
FD change doesn't affect architectures that don't support this feature?
>> Tested with the following changes:
>> File: stubs/kvm.c
>> Changed the abort() call to return 0:
>> int kvm_arch_on_vmfd_change(MachineState *ms, KVMState s)
>> {
>> return 0;  / Changed from abort() */
>> }
>> File: target/ppc/kvm.c
>> Added the following stubs:
>> int kvm_arch_on_vmfd_change(MachineState *ms, KVMState s)
>> {
>> / ppc64le doesn't support VM FD changes for confidential guests */
>> return 0;
>> }
>> bool kvm_arch_supports_vmfd_change(void)
>> {
>> return false;
>> }
>> GDB Backtrace:
>> I ran QEMU under GDB to capture the hang state. The backtrace shows =
the vCPU thread is waiting on a condition variable:
>> Thread 4 "CPU 0/KVM" received signal SIGUSR1, User defined signal 1.
>> __syscall_cancel_arch () at ../sysdeps/unix/sysv/linux/powerpc/ =
syscall_cancel.S:77
>> #0  __syscall_cancel_arch () at ../sysdeps/unix/sysv/linux/powerpc/ =
syscall_cancel.S:77
>> #1  0x00007ffff58a9678 in __internal_syscall_cancel (nr=3D221) at =
cancellation.c:49
>> #2  0x00007ffff58aa220 in __futex_abstimed_wait_common64 =
(futex_word=3D0x10131ba10, expected=3D0, op=3D393, abstime=3D0x0, =
cancel=3Dtrue) at futex-internal.c:57
>> #3  __futex_abstimed_wait_common (futex_word=3D0x10131ba10, =
expected=3D0, clockid=3D0, abstime=3D<optimized out>, private=3D0, =
cancel=3Dtrue) at futex- internal.c:87
>> #4  __GI___futex_abstimed_wait_cancelable64 (futex_word=3D0x10131ba10, =
expected=3D0, clockid=3D0, abstime=3D0x0, private=3D0) at =
futex-internal.c:139
>> #5  0x00007ffff58ae0bc in __pthread_cond_wait_common =
(cond=3D0x10131b9f0, mutex=3D0x101222ce0 <bql>, clockid=3D0, =
abstime=3D0x0) at pthread_cond_wait.c:426
>> #6  ___pthread_cond_wait (cond=3D0x10131b9f0, mutex=3D0x101222ce0 =
<bql>) at pthread_cond_wait.c:458
>> #7  0x0000000100b9bea8 in qemu_cond_wait_impl (cond=3D0x10131b9f0, =
mutex=3D0x101222ce0 <bql>, file=3D0x100c59900 "../system/cpus.c", =
line=3D472) at ../util/qemu-thread-posix.c:240
>> #8  0x00000001006a0408 in qemu_process_cpu_events (cpu=3D0x1019dd260) =
at ../system/cpus.c:472
>> #9  0x0000000100913354 in kvm_vcpu_thread_fn (arg=3D0x1019dd260) at =
../ accel/kvm/kvm-accel-ops.c:50
>> #10 0x0000000100b9b30c in qemu_thread_start (args=3D0x1019f1fe0) at =
../ util/qemu-thread-posix.c:414
>> #11 0x00007ffff58aed94 in start_thread (arg=3D0x7ffff0bce320) at =
pthread_create.c:448
>> #12 0x00007ffff59555f8 in __GI___clone3 () at ../sysdeps/unix/sysv/ =
linux/powerpc/powerpc64/clone3.S:114
>> Thanks,
>> Misbah Anjum N <misanjum@linux.ibm.com>
>> On 2026-03-06 16:22, Misbah Anjum N wrote:
>>> Hi,
>>> I'm reporting a critical regression on ppc64le that causes all KVM
>>> guests to hang immediately during startup. Git bisect identified
>>> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a as the first bad
>>> commit. The commit completely breaks KVM functionality on ppc64le.
>>>=20
>>> Regression Details:
>>> Working Version: QEMU 10.2.50 (v10.2.0-1669-gffcf1a7981)
>>> Broken Version: QEMU 10.2.50 (v10.2.0-1816-g3fb456e9a0)
>>> Bad Commit: 98884e0cc10997a17ce9abfd6ff10be19224ca6a "accel/kvm: add
>>> changes required to support KVM VM file descriptor change"
>>> Commit Link:
>>> https://gitlab.com/qemu-project/qemu/-/ =
commit/98884e0cc10997a17ce9abfd6ff10be19224ca6a
>>>=20
>>> Environment:
>>> Host: Fedora 42, Kernel 7.0.0-rc2, Power11 (ppc64le)
>>> Libvirt: 12.1.0
>>> Guest: Fedora 42, Kernel 7.0.0-rc2
>>> Machine Type: pseries with KVM acceleration
>>>=20
>>> Build Configuration:
>>> git clone https://gitlab.com/qemu-project/qemu.git
>>> cd qemu
>>> git submodule init
>>> git submodule update --recursive
>>> ./configure --target-list=3Dppc64-softmmu --disable-tcg =
--prefix=3D/usr
>>> make && make install
>>>=20
>>> Reproduction:
>>> Using virt-install:
>>> /usr/bin/virt-install --connect=3Dqemu:///system --hvm --accelerate
>>> --name 'avocado-vt-vm1' --machine pseries --memory=3D32768
>>> --vcpu=3D32,sockets=3D1,cores=3D32,threads=3D1 --import --nographics
>>> --os-variant rhel8.0 --serial pty --memballoon model=3Dvirtio
>>> --controller type=3Dscsi,model=3Dvirtio-scsi --disk
>>> path=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel- =
ppc64le.qcow2,bus=3Dscsi,size=3D10,format=3Dqcow2
>>> --network=3Dbridge=3Dvirbr0,model=3Dvirtio --boot
>>> emulator=3D/usr/bin/qemu-system-ppc64
>>> Result: Starting install...
>>>         <hangs indefinitely with no output>
>>>=20
>>> Using direct QEMU command:
>>> /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine
>>> pseries,accel=3Dkvm -enable-kvm -m 32768 -smp
>>> 32,sockets=3D1,cores=3D32,threads=3D1 -nographic -serial pty -device
>>> virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 -drive
>>> file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel- =
ppc64le.qcow2,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2
>>> -device scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 -netdev
>>> bridge,id=3Dnet0,br=3Dvirbr0 -device virtio-net-pci,netdev=3Dnet0
>>> Result: <hangs indefinitely with no output>
>>>=20
>>> Analysis:
>>> The commit introduces VM file descriptor change support with
>>> architecture-specific hooks.
>>> I attempted the following fixes without success:
>>> 1. Changed abort() to return 0; in stubs/kvm.c
>>> 2. Added early return in kvm_reset_vmfd() when
>>> kvm_arch_supports_vmfd_change() returns false
>>>=20
>>> Git Bisect Log:
>>> # git bisect bad
>>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a is the first bad commit
>>> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a (HEAD)
>>> Author: Ani Sinha <anisinha@redhat.com>
>>> Date:   Wed Feb 25 09:19:10 2026 +0530
>>>=20
>>>     accel/kvm: add changes required to support KVM VM file =
descriptor change
>>>=20
>>>     This change adds common kvm specific support to handle KVM VM =
file
>>> descriptor
>>>     change. KVM VM file descriptor can change as a part of
>>> confidential guest reset
>>>     mechanism. A new function api kvm_arch_on_vmfd_change() per
>>>     architecture platform is added in order to implement =
architecture specific
>>>     changes required to support it. A subsequent patch will add x86 =
specific
>>>     implementation for kvm_arch_on_vmfd_change() as currently only =
x86 supports
>>>     confidential guest reset.
>>>=20
>>>     Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>     Link: https://lore.kernel.org/r/20260225035000.385950-6- =
anisinha@redhat.com
>>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>=20
>>>  MAINTAINERS            |  6 ++++++
>>>  accel/kvm/kvm-all.c    | 88
>>> =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ =
+++++++++++++++---
>>>  accel/kvm/trace-events |  1 +
>>>  include/system/kvm.h   |  3 +++
>>>  stubs/kvm.c            | 22 ++++++++++++++++++++++
>>>  stubs/meson.build      |  1 +
>>>  target/i386/kvm/kvm.c  | 10 ++++++++++
>>>  7 files changed, 128 insertions(+), 3 deletions(-)
>>>  create mode 100644 stubs/kvm.c
>>>=20
>>> # git bisect log
>>> git bisect start
>>> git bisect good ffcf1a7981793973ffbd8100a7c3c6042d02ae23
>>> git bisect bad 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
>>> git bisect bad e76c30bb13ecb9dc716fa629954bfb6253056ce2
>>> git bisect good 9bdc612a18588975f5776ee4e562df607fea1b2c
>>> git bisect bad 40c015e96942fd2a3e4d5ace6063b3333a3dd372
>>> git bisect good df8df3cb6b743372ebb335bd8404bc3d748da350
>>> git bisect bad 0f53f021ad1ede28dc8944686544e496cab02e5e
>>> git bisect bad 9f0c2b3032639315faf141010a2603b0dbf56230
>>> git bisect bad 98884e0cc10997a17ce9abfd6ff10be19224ca6a
>>> first bad commit: [98884e0cc10997a17ce9abfd6ff10be19224ca6a]
>>>=20
>>> Thanks,
>>> Misbah Anjum N <misanjum@linux.ibm.com>
>=20


