Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178A5C3600E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txruc-0008CJ-Ci; Thu, 27 Mar 2025 14:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1txruA-00087e-IN
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:24:39 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1txru7-0003Wm-46
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 14:24:37 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1txrtw-00000000T8V-1ZU8; Thu, 27 Mar 2025 19:24:24 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Reset parked vCPUs together with the online ones
Date: Thu, 27 Mar 2025 19:24:16 +0100
Message-ID: <e8b85a5915f79aa177ca49eccf0e9b534470c1cd.1743099810.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.083, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Commit 3f2a05b31ee9 ("target/i386: Reset TSCs of parked vCPUs too on VM
reset") introduced a way to reset TSCs of parked vCPUs during VM reset to
prevent them getting desynchronized with the online vCPUs and therefore
causing the KVM PV clock to lose PVCLOCK_TSC_STABLE_BIT.

The way this was done was by registering a parked vCPU-specific QEMU reset
callback via qemu_register_reset().

However, it turns out that on particularly device-rich VMs QEMU reset
callbacks can take a long time to execute (which isn't surprising,
considering that they involve resetting all of VM devices).

In particular, their total runtime can exceed the 1-second TSC
synchronization window introduced in KVM commit 5d3cb0f6a8e3 ("KVM:
Improve TSC offset matching").
Since the TSCs of online vCPUs are only reset from "synchronize_post_reset"
AccelOps handler (which runs after all qemu_register_reset() handlers) this
essentially makes that fix ineffective on these VMs.

The easiest way to guarantee that these parked vCPUs are reset at the same
time as the online ones (regardless how long it takes for VM devices to
reset) is to piggyback on post-reset vCPU synchronization handler for one
of online vCPUs - as there is no generic post-reset AccelOps handler that
isn't per-vCPU.

The first online vCPU was selected for that since it is easily available
under "first_cpu" define.
This does not create an ordering issue since the order of vCPU TSC resets
does not matter.

Fixes: 3f2a05b31ee9 ("target/i386: Reset TSCs of parked vCPUs too on VM reset")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 accel/kvm/kvm-all.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa397..951e8214e079 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -437,9 +437,8 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_fd;
 }
 
-static void kvm_reset_parked_vcpus(void *param)
+static void kvm_reset_parked_vcpus(KVMState *s)
 {
-    KVMState *s = param;
     struct KVMParkedVcpu *cpu;
 
     QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
@@ -2738,7 +2737,6 @@ static int kvm_init(MachineState *ms)
     }
 
     qemu_register_reset(kvm_unpoison_all, NULL);
-    qemu_register_reset(kvm_reset_parked_vcpus, s);
 
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
@@ -2908,6 +2906,10 @@ static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg
 void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 {
     run_on_cpu(cpu, do_kvm_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+
+    if (cpu == first_cpu) {
+        kvm_reset_parked_vcpus(kvm_state);
+    }
 }
 
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)

