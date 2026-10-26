Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698C606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n76XYaV5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjb-0001dV-C6; Mon, 26 Oct 2026 06:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <QingboZhang@linux.alibaba.com>)
 id 1xLHjV-0001LC-08
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:15:13 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <QingboZhang@linux.alibaba.com>)
 id 1xLHjQ-0001am-R9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1793009691; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=iMT5Y09JhM9zqxuMXStyvOLKqMs3HCyukPNm0lkEUmc=;
 b=n76XYaV5X8yw5Z7Gn8MUNz6DWNOC2jc+FSHChbv+CUjptGXVrzvvO+RKwV4Fdlq2I37NN5Eipq/N3nYvJIvvftdIRnqJi0PIhS/uEl+hZroIBKcklZ2dLATSoWcLbuN+5JpXIELkeC37OVRqPP0AaB1d3sfgXZ57xwLEWOH0l8M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=qingbozhang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0XDWmqP._1793009378; 
Received: from localhost.localdomain(mailfrom:QingboZhang@linux.alibaba.com
 fp:SMTPD_---0XDWmqP._1793009378 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 26 Oct 2026 18:09:39 +0800
From: Qingbo Zhang <QingboZhang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 jan.kiszka@siemens.com, mohamed@unpredictable.fr,
 Qingbo Zhang <QingboZhang@linux.alibaba.com>
Subject: [PATCH] hw/i386/vapic: fix a deadlock between vapic_write() and
 machine reset
Date: Mon, 26 Oct 2026 18:09:33 +0800
Message-Id: <20261026100933.12715-1-QingboZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=QingboZhang@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A 1-byte write to the VAPIC port 0x7e (vapic_write() case 1, the
reactivation path) patches the ROM trigger instruction to a NOP under
pause_all_vcpus() / resume_all_vcpus().

The BQL does not serialize this against a machine reset: both
pause_all_vcpus() and the run_on_cpu() work in the reset path drop the
BQL while waiting, so a concurrent reactivation's resume_all_vcpus() can
slip in mid-reset.  It clears the stopped state of every vCPU,
restarting one the reset had just stopped.  That vCPU re-enters KVM_RUN
and, if it does not exit to userspace again (e.g. it halts in the
kernel), holds its vcpu->mutex indefinitely; the reset's
KVM_SET_VAPIC_ADDR for it then blocks forever, leaving the main thread
stuck holding the BQL and the whole VM hung, monitor included.

Fix this by patching on the current vCPU via async_safe_run_on_cpu()
instead of pausing all vCPUs.  The patch becomes an exclusive work item
that, under KVM, runs before the vCPU re-enters the guest; it sleeps the
other vCPUs without touching the stopped state, so it can no longer
restart a vCPU that a concurrent reset has stopped.

Reproduced on an 8-vCPU KVM guest issuing 1-byte writes to port 0x7e
concurrently with machine resets: the unfixed code hangs the VM on the
first reset, the fixed build survives 500+ resets.

Fixes: e5ad936b0fd7 ("kvmvapic: Introduce TPR access optimization for Windows guests")
Signed-off-by: Qingbo Zhang <QingboZhang@linux.alibaba.com>
---

Reproducer: a KVM guest (-smp 8, host kernel 6.12.0, in-kernel irqchip)
booted via -kernel/-initrd with panic=1, so each reset reboots and
retries.  /init runs a long unrolled sequence of "outb %al, $0x7e"
(.rept 200000) on one vCPU (each OUT enters vapic_write() case 1), while
another vCPU issues machine resets through the i8042 (outb 0xfe -> 0x64)
after a 200 ms warmup, so the resets race the 0x7e writes.

Result: without the fix the VM hangs on the first reset; the fixed build
survives 588 resets with the main thread never blocking on
KVM_SET_VAPIC_ADDR.

Hang analysis (unfixed build, -smp 8, captured at the wedge):

  main thread, State D, ioctl(fd=15, KVM_SET_VAPIC_ADDR):
    kvm_vcpu_ioctl+0x88/0x7f0 [kvm]     <-- mutex_lock_killable(&vcpu->mutex)
    __x64_sys_ioctl+0x94/0xd0
    do_syscall_64+0x7d/0x160
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

  the vCPU it targets, "CPU 0/KVM", same fd=15, ioctl(fd=15, KVM_RUN),
  halted:
    kvm_vcpu_block+0x4c/0xc0 [kvm]
    kvm_vcpu_halt+0x185/0x430 [kvm]
    vcpu_run+0x1d1/0x2a0 [kvm]
    kvm_arch_vcpu_ioctl_run+0x381/0x520 [kvm]
    kvm_vcpu_ioctl+0x114/0x7f0 [kvm]    <-- holds vcpu->mutex
    __x64_sys_ioctl+0x94/0xd0
    do_syscall_64+0x7d/0x160
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

  Both on fd 15 (the same vCPU): the main thread waits at
  kvm_vcpu_ioctl+0x88 (mutex_lock_killable) while "CPU 0/KVM" holds that
  mutex at +0x114 inside KVM_RUN and, being halted, never exits to
  userspace to release it, so the reset never completes.

Interleaving:

  Three threads are involved:
    - vCPU1, which runs the guest "outb 0x7e" and so keeps re-entering
      vapic_write() case 1, where resume_all_vcpus() restarts a vCPU the
      reset had stopped;
    - vCPU2, an idle vCPU, halted in KVM_RUN and holding its vcpu->mutex;
    - the main thread, which performs the machine reset, and is where the
      deadlock lands: its KVM_SET_VAPIC_ADDR ioctl for vCPU2 must take
      vCPU2's vcpu->mutex, but vCPU2 holds it in KVM_RUN and never
      releases it, so the main thread blocks forever holding the BQL,
      hanging the whole VM.
  The BQL does not serialize the reset against vapic_write():
  pause_all_vcpus() (on both threads) and the reset's run_on_cpu() each
  drop the BQL while waiting (marked "<-- drops the BQL" below), so the
  two interleave.

  main thread:
    machine reset
      main_loop_should_exit()
        pause_all_vcpus()
          qemu_cond_wait(&qemu_pause_cond, &bql)     <-- drops the BQL
        qemu_system_reset()
          cpu_synchronize_all_states()
            run_on_cpu(GET) -> do_run_on_cpu()
              qemu_cond_wait(&qemu_work_cond, &bql)  <-- drops the BQL
          qemu_devices_reset()
            apic_reset_common() -> vapic_base_update()
              kvm_vcpu_ioctl(vCPU2, KVM_SET_VAPIC_ADDR)
                mutex_lock_killable(&vCPU2->mutex)   <-- blocks forever

  vCPU1:
    guest "outb 0x7e"
      kvm_cpu_exec() -> KVM_EXIT_IO -> kvm_handle_io() -> address_space_rw()
        prepare_mmio_access(): bql_lock()   <-- re-takes the dropped BQL
        vapic_write() case 1
          pause_all_vcpus()
            qemu_cond_wait(&qemu_pause_cond, &bql)   <-- drops the BQL
          patch_byte() x2  (NOP the ROM trigger)
          resume_all_vcpus()
            cpu_resume(vCPU2): cpu->stop = false; cpu->stopped = false
            qemu_cpu_kick(vCPU2)
              -> vCPU2 re-enters kvm_cpu_exec() -> KVM_RUN, holding its
                 vcpu->mutex; being idle it halts in kvm_vcpu_block() and
                 never exits to userspace, so the mutex is never released.

  So vCPU2, which the reset had stopped, is restarted into KVM_RUN
  mid-reset; the main thread's KVM_SET_VAPIC_ADDR(vCPU2) blocks on
  vCPU2's mutex while holding the BQL, and vCPU1 is starved of the BQL,
  so it can no longer kick vCPU2.  The whole VM hangs.

 hw/i386/vapic.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 5c3911cf9c..8c2b6b0a6b 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -657,6 +657,15 @@ static int vapic_prepare(VAPICROMState *s)
     return 0;
 }
 
+static void do_vapic_nop_patch(CPUState *cs, run_on_cpu_data data)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    target_ulong addr = (target_ulong)data.target_ptr;
+
+    patch_byte(cpu, addr, 0x66);
+    patch_byte(cpu, addr + 1, 0x90);
+}
+
 static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
                         unsigned int size)
 {
@@ -709,16 +718,9 @@ static void vapic_write(void *opaque, hwaddr addr, uint64_t data,
              * Oddly enough, KVM increments EIP _before_ the execution
              * of the instruction is finished.
              */
-            pause_all_vcpus();
-            if (!kvm_enabled()) {
-                patch_byte(cpu, env->eip, 0x66);
-                patch_byte(cpu, env->eip + 1, 0x90);
-            }
-            else {
-                patch_byte(cpu, env->eip - 2, 0x66);
-                patch_byte(cpu, env->eip - 1, 0x90);
-            }
-            resume_all_vcpus();
+            target_ulong ip = kvm_enabled() ? env->eip - 2 : env->eip;
+            async_safe_run_on_cpu(current_cpu, do_vapic_nop_patch,
+                                  RUN_ON_CPU_TARGET_PTR(ip));
         }
 
         if (s->state == VAPIC_ACTIVE) {
-- 
2.39.5 (Apple Git-154)


