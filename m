Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5226AF3C24F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaal-0003gH-6l; Mon, 09 Mar 2026 09:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzaae-0003fK-1T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzaaa-0002Fq-Ni
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773062643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ja9jbVz31bdlpp68Ybq3M8zUAnhLhlTHmt0RnxppbYw=;
 b=JtYYRzPoMnowKgGeWzx2ceAAwImZZn4S++WdTXQ5eK8GBz6CMMvbVasdRLUVtgBT2HEtOx
 IAmnCVAZeIXwAUYPRzTRRKiPV9w8ccRpFOTyt+5XHiR8nQASdtrt7j+FOvYMzvV2708UVo
 htiWFjTgQs9qLRX4rhrLB6Nxe+TTXsY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-JEruVxahP1yHjG3iUetL2w-1; Mon, 09 Mar 2026 09:24:02 -0400
X-MC-Unique: JEruVxahP1yHjG3iUetL2w-1
X-Mimecast-MFC-AGG-ID: JEruVxahP1yHjG3iUetL2w_1773062641
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ae62c87973so324080945ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773062641; x=1773667441; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ja9jbVz31bdlpp68Ybq3M8zUAnhLhlTHmt0RnxppbYw=;
 b=tVrxA5XOry0c89CMPlo6D8aB/jSBv6bNTl95/1ij2OAXQo9SOl/O3AwofRDDFVxlFV
 4pivxwb/M25pgHd/GEnCVBdn3R9ccpqIzizo24f3X2RppLyFJqPQTW/29/PEmm12wq7J
 5qUu0h9eKkbqj6EYHvAutsp81ncXZr8dnhIN2Pone+zoVTLJmugTT2g12w58z/5nzaOl
 56eHe9lhk6Cd6qAxjbXdbg05fzyJ+0m3LE7xPcBbFttAn01mmcTfR1EAh3Ptl3gjuyJ2
 Pjtxac/5F/1UaPVjl9YVwxKg1QzpvTRFTiL2OZ70/tLooD7QzoNjLMCtGBveFobidHyl
 uhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773062641; x=1773667441;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ja9jbVz31bdlpp68Ybq3M8zUAnhLhlTHmt0RnxppbYw=;
 b=RYdZm7I4R0ppePEMZiaCiK2YQy5pG8yJXk1AQ3+TUWDFV5j2QgziEGzUzMOrkN9WuO
 GXx4HcRjVs7VZEvNnmKwGuYL/5j+c80QAizMMOC2wGQIaZMaOnnPLCUEMLCnRO2d/6XW
 d333gikjAEzy68mzWA9CzFjVi5xUGnRqk0xKkt5R8IPTR12T7mXe4EeJf0n60xkBFGMu
 ulyPSbx+glgyfrqKosOrJDZVCVyJ0Oet44eDsFUucDneGVryXdvgpjsAfNrM6ms62p4F
 xN01mssh3LFUMxmqKVGyKVvGA/I0dqDmIowAoiEYmHrzMfSQgyt+MXpQN3iQMtw64Pyp
 pQ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbdRtqlOgarstFazORw8seyJs3GZtumhGvyVZ2m0AXq8lww9PvL8x1TKhEBsdDj5rH6HzOYomrKL83@nongnu.org
X-Gm-Message-State: AOJu0YzQh3cEeYCmlb+wn+yAH3FQBg9/tI8xGRaFVk2nMT8dRSVzBNmj
 mw69+cA6ssXPC/4Wyf57nARngghE6GYQf85losHNVm06AZbqCr3jHguGRYfvERzzROOD+Pf9qQF
 9n7km5SdzmLDtB/uCsHh/vGbNFlF+fEnvJC3DmeH8MZ+IlWeoc6N0so1d
X-Gm-Gg: ATEYQzyRTm8exfrNF9lBvfKrrYQvboO0bztQTDQAj+csEfNGbi/AOlEJHr+6yTVcLk4
 MMmr5sgHTUMDI88bTWo14ReqlZ7iAePfAlPIhzJWDWpDlIaBMqjPL0xcyv06QVI+1QXDL2WgrL4
 Wlp15g1J+C4IADGQOo3RkrtgEmx6RFAXui95s2y7u5WIUstiW2W0atu/lk73NHw6RdLqWzv3oHm
 wbKnQ2m84R5STp7G7dJbmHYiiZTJK1XsXnXwZZpjXLSEANogiXVbojvESzdqj3IGL0k/JLg+KkB
 7NNzp17MRupj1MLcjcasmk9wJ42OjDO03Ab6RFkUowQbi1w6lw7uAfI9bU7FAtOfYKPvRBS321Y
 9AgWCVuAY8uyndYesUqCmjqXNn/GBAn+CMOhb2/++uhU91/BwB8LLspcerxg=
X-Received: by 2002:a17:903:380f:b0:2ae:5b64:12e3 with SMTP id
 d9443c01a7336-2ae82451355mr119150025ad.41.1773062640706; 
 Mon, 09 Mar 2026 06:24:00 -0700 (PDT)
X-Received: by 2002:a17:903:380f:b0:2ae:5b64:12e3 with SMTP id
 d9443c01a7336-2ae82451355mr119149815ad.41.1773062640218; 
 Mon, 09 Mar 2026 06:24:00 -0700 (PDT)
Received: from fc40 ([122.176.129.56]) by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ae8852e638sm150037965ad.2.2026.03.09.06.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 06:23:59 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:53:53 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Misbah Anjum N <misanjum@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
In-Reply-To: <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
Message-ID: <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="279738495-739688553-1773062639=:2608"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279738495-739688553-1773062639=:2608
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 9 Mar 2026, Ani Sinha wrote:

>
>
> > On 9 Mar 2026, at 4:34 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
> >
> > Hi Ani, Paolo,
> >
> > I think the problem lies here:
> >
> > For archs which doesnt support vm fd change, we are baling out as below in kvm_reset_vmfd.
> >
> >
> >    /*
> >     * bail if the current architecture does not support VM file
> >     * descriptor change.
> >     */
> >    if (!kvm_arch_supports_vmfd_change()) {
> >        error_report("This target architecture does not support KVM VM "
> >                     "file descriptor change.");
> >        return -EOPNOTSUPP;
> >    }
> >
> > However, when rebuild_guest (kvm_reset_vmfd) is called in
> > qemu_system_reset here:
> >
> >    if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
> >         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
> >        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
> >        if (ac->rebuild_guest) {
> >            ret = ac->rebuild_guest(current_machine);
> >            if (ret < 0) {
> >                error_report("unable to rebuild guest: %s(%d)",
> >                             strerror(-ret), ret);
> >                vm_stop(RUN_STATE_INTERNAL_ERROR);
> >            } else {
> >                info_report("virtual machine state has been rebuilt with new "
> >                            "guest file handle.");
> >                guest_state_rebuilt = true;
> >            }
> >        } else if (!cpus_are_resettable())  {
> >            error_report("accelerator does not support reset!");
> >        } else {
> >            error_report("accelerator does not support rebuilding guest state,"
> >                         " proceeding with normal reset!");
> >        }
> >    }
> >
> >
> > it just does a vm_stop if rebuild_guest returns < 0.
> >
> > IMHO, This should handle -EOPNOTSUPP gracefully.
> > Please advise if this needs to be taken care differently?

Yes seems this is an issue and I will fix it. Not sure if the fix will
address your issue though ...

Can you try the following patch?

From 9e5a6945181d4c1fce7f8438e1b6213f1eb79c14 Mon Sep 17 00:00:00 2001
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 9 Mar 2026 18:44:40 +0530
Subject: [PATCH] Fix reset for non-x86 archs that do not support reset yet

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..c1f41284c9 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause reason)
         (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
-            if (ret < 0) {
+            if (ret < 0 && ret != -EOPNOTSUPP) {
                 error_report("unable to rebuild guest: %s(%d)",
                              strerror(-ret), ret);
                 vm_stop(RUN_STATE_INTERNAL_ERROR);
+            } else if (ret == -EOPNOTSUPP) {
+                error_report("accelerator does not support reset!");
             } else {
                 info_report("virtual machine state has been rebuilt with new "
                             "guest file handle.");
-- 
2.42.0


>
> Is this a confidential guest that cannot be normally reset?
>

> >> #2  0x00007ffff58aa220 in __futex_abstimed_wait_common64 (futex_word=0x10131ba10, expected=0, op=393, abstime=0x0, cancel=true) at futex-internal.c:57
> >> #3  __futex_abstimed_wait_common (futex_word=0x10131ba10, expected=0, clockid=0, abstime=<optimized out>, private=0, cancel=true) at futex- internal.c:87
> >> #4  __GI___futex_abstimed_wait_cancelable64 (futex_word=0x10131ba10, expected=0, clockid=0, abstime=0x0, private=0) at futex-internal.c:139
> >> #5  0x00007ffff58ae0bc in __pthread_cond_wait_common (cond=0x10131b9f0, mutex=0x101222ce0 <bql>, clockid=0, abstime=0x0) at pthread_cond_wait.c:426
> >> #6  ___pthread_cond_wait (cond=0x10131b9f0, mutex=0x101222ce0 <bql>) at pthread_cond_wait.c:458
> >> #7  0x0000000100b9bea8 in qemu_cond_wait_impl (cond=0x10131b9f0, mutex=0x101222ce0 <bql>, file=0x100c59900 "../system/cpus.c", line=472) at ../util/qemu-thread-posix.c:240
> >> #8  0x00000001006a0408 in qemu_process_cpu_events (cpu=0x1019dd260) at ../system/cpus.c:472
> >> #9  0x0000000100913354 in kvm_vcpu_thread_fn (arg=0x1019dd260) at ../ accel/kvm/kvm-accel-ops.c:50
> >> #10 0x0000000100b9b30c in qemu_thread_start (args=0x1019f1fe0) at ../ util/qemu-thread-posix.c:414
> >> #11 0x00007ffff58aed94 in start_thread (arg=0x7ffff0bce320) at pthread_create.c:448
> >> #12 0x00007ffff59555f8 in __GI___clone3 () at ../sysdeps/unix/sysv/ linux/powerpc/powerpc64/clone3.S:114
> >> Thanks,
> >> Misbah Anjum N <misanjum@linux.ibm.com>
> >> On 2026-03-06 16:22, Misbah Anjum N wrote:
> >>> Hi,
> >>> I'm reporting a critical regression on ppc64le that causes all KVM
> >>> guests to hang immediately during startup. Git bisect identified
> >>> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a as the first bad
> >>> commit. The commit completely breaks KVM functionality on ppc64le.
> >>>
> >>> Regression Details:
> >>> Working Version: QEMU 10.2.50 (v10.2.0-1669-gffcf1a7981)
> >>> Broken Version: QEMU 10.2.50 (v10.2.0-1816-g3fb456e9a0)
> >>> Bad Commit: 98884e0cc10997a17ce9abfd6ff10be19224ca6a "accel/kvm: add
> >>> changes required to support KVM VM file descriptor change"
> >>> Commit Link:
> >>> https://gitlab.com/qemu-project/qemu/-/ commit/98884e0cc10997a17ce9abfd6ff10be19224ca6a
> >>>
> >>> Environment:
> >>> Host: Fedora 42, Kernel 7.0.0-rc2, Power11 (ppc64le)
> >>> Libvirt: 12.1.0
> >>> Guest: Fedora 42, Kernel 7.0.0-rc2
> >>> Machine Type: pseries with KVM acceleration
> >>>
> >>> Build Configuration:
> >>> git clone https://gitlab.com/qemu-project/qemu.git
> >>> cd qemu
> >>> git submodule init
> >>> git submodule update --recursive
> >>> ./configure --target-list=ppc64-softmmu --disable-tcg --prefix=/usr
> >>> make && make install
> >>>
> >>> Reproduction:
> >>> Using virt-install:
> >>> /usr/bin/virt-install --connect=qemu:///system --hvm --accelerate
> >>> --name 'avocado-vt-vm1' --machine pseries --memory=32768
> >>> --vcpu=32,sockets=1,cores=32,threads=1 --import --nographics
> >>> --os-variant rhel8.0 --serial pty --memballoon model=virtio
> >>> --controller type=scsi,model=virtio-scsi --disk
> >>> path=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel- ppc64le.qcow2,bus=scsi,size=10,format=qcow2
> >>> --network=bridge=virbr0,model=virtio --boot
> >>> emulator=/usr/bin/qemu-system-ppc64
> >>> Result: Starting install...
> >>>         <hangs indefinitely with no output>
> >>>
> >>> Using direct QEMU command:
> >>> /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine
> >>> pseries,accel=kvm -enable-kvm -m 32768 -smp
> >>> 32,sockets=1,cores=32,threads=1 -nographic -serial pty -device
> >>> virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive
> >>> file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel- ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2
> >>> -device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev
> >>> bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
> >>> Result: <hangs indefinitely with no output>
> >>>
> >>> Analysis:
> >>> The commit introduces VM file descriptor change support with
> >>> architecture-specific hooks.
> >>> I attempted the following fixes without success:
> >>> 1. Changed abort() to return 0; in stubs/kvm.c
> >>> 2. Added early return in kvm_reset_vmfd() when
> >>> kvm_arch_supports_vmfd_change() returns false
> >>>
> >>> Git Bisect Log:
> >>> # git bisect bad
> >>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a is the first bad commit
> >>> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a (HEAD)
> >>> Author: Ani Sinha <anisinha@redhat.com>
> >>> Date:   Wed Feb 25 09:19:10 2026 +0530
> >>>
> >>>     accel/kvm: add changes required to support KVM VM file descriptor change
> >>>
> >>>     This change adds common kvm specific support to handle KVM VM file
> >>> descriptor
> >>>     change. KVM VM file descriptor can change as a part of
> >>> confidential guest reset
> >>>     mechanism. A new function api kvm_arch_on_vmfd_change() per
> >>>     architecture platform is added in order to implement architecture specific
> >>>     changes required to support it. A subsequent patch will add x86 specific
> >>>     implementation for kvm_arch_on_vmfd_change() as currently only x86 supports
> >>>     confidential guest reset.
> >>>
> >>>     Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>     Link: https://lore.kernel.org/r/20260225035000.385950-6- anisinha@redhat.com
> >>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>>
> >>>  MAINTAINERS            |  6 ++++++
> >>>  accel/kvm/kvm-all.c    | 88
> >>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ +++++++++++++++---
> >>>  accel/kvm/trace-events |  1 +
> >>>  include/system/kvm.h   |  3 +++
> >>>  stubs/kvm.c            | 22 ++++++++++++++++++++++
> >>>  stubs/meson.build      |  1 +
> >>>  target/i386/kvm/kvm.c  | 10 ++++++++++
> >>>  7 files changed, 128 insertions(+), 3 deletions(-)
> >>>  create mode 100644 stubs/kvm.c
> >>>
> >>> # git bisect log
> >>> git bisect start
> >>> git bisect good ffcf1a7981793973ffbd8100a7c3c6042d02ae23
> >>> git bisect bad 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
> >>> git bisect bad e76c30bb13ecb9dc716fa629954bfb6253056ce2
> >>> git bisect good 9bdc612a18588975f5776ee4e562df607fea1b2c
> >>> git bisect bad 40c015e96942fd2a3e4d5ace6063b3333a3dd372
> >>> git bisect good df8df3cb6b743372ebb335bd8404bc3d748da350
> >>> git bisect bad 0f53f021ad1ede28dc8944686544e496cab02e5e
> >>> git bisect bad 9f0c2b3032639315faf141010a2603b0dbf56230
> >>> git bisect bad 98884e0cc10997a17ce9abfd6ff10be19224ca6a
> >>> first bad commit: [98884e0cc10997a17ce9abfd6ff10be19224ca6a]
> >>>
> >>> Thanks,
> >>> Misbah Anjum N <misanjum@linux.ibm.com>
> >
>
>
--279738495-739688553-1773062639=:2608--


