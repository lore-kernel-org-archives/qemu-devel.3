Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEB5E64012
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 21:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEEHc-00055G-CU; Thu, 21 Nov 2024 16:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <wangfuqiang49@ZBMac-DY9GX4RFNX.localdomain>)
 id 1tEBDo-0001jF-TI
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:44:05 -0500
Received: from [209.95.133.113] (helo=ZBMac-DY9GX4RFNX.localdomain)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangfuqiang49@ZBMac-DY9GX4RFNX.localdomain>)
 id 1tEBDl-0000vu-56
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:44:04 -0500
Received: by ZBMac-DY9GX4RFNX.localdomain (Postfix, from userid 502)
 id AB8B72466CAA; Fri, 22 Nov 2024 01:34:16 +0800 (CST)
From: wangfuqiang49 <wangfuqiang49@jd.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Cc: qinzheng13 <qinzheng13@jd.com>,
	yaowenchao1 <yaowenchao@jd.com>
Subject: [PATCH] fix dirtyring not converge use small dirtylimit
Date: Fri, 22 Nov 2024 01:34:16 +0800
Message-ID: <20241121173416.75950-1-wangfuqiang49@jd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 209.95.133.113 (failed)
Received-SPF: none client-ip=209.95.133.113;
 envelope-from=wangfuqiang49@ZBMac-DY9GX4RFNX.localdomain;
 helo=ZBMac-DY9GX4RFNX.localdomain
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Nov 2024 16:00:11 -0500
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

From: fuqiang wang <wangfuqiang49@jd.com>

When using a low dirtylimit to restrict a VM with a high dirty ratio,
such as in the guestperf test scenario compr-dirty-limit-period-1000
(dirtylimit=1), this can lead to too long sleep times for the vcpu
threads and the migration thread may have to wait vcpu thread due to the
kick operation, and during this waiting period, the guest will make some
dirty pages at a high speed, which causes convergence issues.

However, during the vcpu thread sleeping, it is not in kernel space
(kvm), so there is no need to wait for a kick.

Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>
---
 accel/kvm/kvm-all.c   | 6 +++++-
 include/hw/core/cpu.h | 1 +
 system/cpus.c         | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..86b1b8a6c6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -926,7 +926,9 @@ static void kvm_cpu_synchronize_kick_all(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        run_on_cpu(cpu, do_kvm_cpu_synchronize_kick, RUN_ON_CPU_NULL);
+        if (cpu->vcpu_in_kvm) {
+            run_on_cpu(cpu, do_kvm_cpu_synchronize_kick, RUN_ON_CPU_NULL);
+        }
     }
 }
 
@@ -3131,7 +3133,9 @@ int kvm_cpu_exec(CPUState *cpu)
          */
         smp_rmb();
 
+        cpu->vcpu_in_kvm = true;
         run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
+        cpu->vcpu_in_kvm = false;
 
         attrs = kvm_arch_post_run(cpu, run);
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db8a6fbc6e..853aba4ef7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -537,6 +537,7 @@ struct CPUState {
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
     bool vcpu_dirty;
+    bool vcpu_in_kvm;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff682..572c7e4f4d 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -670,6 +670,7 @@ void qemu_init_vcpu(CPUState *cpu)
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
+    cpu->vcpu_in_kvm = false;
 
     if (!cpu->as) {
         /* If the target cpu hasn't set up any address spaces itself,
-- 
2.47.0


