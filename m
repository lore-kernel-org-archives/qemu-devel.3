Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC3BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkXc-0005kp-Vl; Thu, 12 Dec 2024 09:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLkXQ-0005k1-3N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:51:38 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLkXM-00055R-Hy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:51:34 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tLkXB-00000003f6l-1DsD; Thu, 12 Dec 2024 15:51:21 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Reset TSCs of parked vCPUs too on VM reset
Date: Thu, 12 Dec 2024 15:51:15 +0100
Message-ID: <5a605a88e9a231386dc803c60f5fed9b48108139.1734014926.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since commit 5286c3662294 ("target/i386: properly reset TSC on reset")
QEMU writes the special value of "1" to each online vCPU TSC on VM reset
to reset it.

However parked vCPUs don't get that handling and due to that their TSCs
get desynchronized when the VM gets reset.
This in turn causes KVM to turn off PVCLOCK_TSC_STABLE_BIT in its exported
PV clock.
Note that KVM has no understanding of vCPU being currently parked.

Without PVCLOCK_TSC_STABLE_BIT the sched clock is marked unstable in
the guest's kvm_sched_clock_init().
This causes a performance regressions to show in some tests.

Fix this issue by writing the special value of "1" also to TSCs of parked
vCPUs on VM reset.


Reproducing the issue:
1) Boot a VM with "-smp 2,maxcpus=3" or similar

2) device_add host-x86_64-cpu,id=vcpu,node-id=0,socket-id=0,core-id=2,thread-id=0

3) Wait a few seconds

4) device_del vcpu

5) Inside the VM run:
# echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
Observe the sched_clock_stable() value is 1.

6) Reboot the VM

7) Once the VM boots once again run inside it:
# echo "t" >/proc/sysrq-trigger; dmesg | grep sched_clock_stable
Observe the sched_clock_stable() value is now 0.


Fixes: 5286c3662294 ("target/i386: properly reset TSC on reset")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 accel/kvm/kvm-all.c                | 11 +++++++++++
 configs/targets/i386-softmmu.mak   |  1 +
 configs/targets/x86_64-softmmu.mak |  1 +
 include/sysemu/kvm.h               |  8 ++++++++
 target/i386/kvm/kvm.c              | 15 +++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5a2..dec1d1c16a0d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -437,6 +437,16 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_fd;
 }
 
+static void kvm_reset_parked_vcpus(void *param)
+{
+    KVMState *s = param;
+    struct KVMParkedVcpu *cpu;
+
+    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
+        kvm_arch_reset_parked_vcpu(cpu->vcpu_id, cpu->kvm_fd);
+    }
+}
+
 int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
@@ -2728,6 +2738,7 @@ static int kvm_init(MachineState *ms)
     }
 
     qemu_register_reset(kvm_unpoison_all, NULL);
+    qemu_register_reset(kvm_reset_parked_vcpus, s);
 
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 2ac69d5ba370..2eb0e8625005 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index e12ac3dc59bf..920e9a42006f 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -2,4 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c3a60b28909a..ab17c09a551f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -377,6 +377,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
+#ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
+void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
+#else
+static inline void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
+{
+}
+#endif
+
 bool kvm_vcpu_id_is_valid(int vcpu_id);
 
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3ba1..2ff618fbf138 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2415,6 +2415,21 @@ void kvm_arch_after_reset_vcpu(X86CPU *cpu)
     }
 }
 
+void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd)
+{
+    g_autofree struct kvm_msrs *msrs = NULL;
+
+    msrs = g_malloc0(sizeof(*msrs) + sizeof(msrs->entries[0]));
+    msrs->entries[0].index = MSR_IA32_TSC;
+    msrs->entries[0].data = 1; /* match the value in x86_cpu_reset() */
+    msrs->nmsrs++;
+
+    if (ioctl(kvm_fd, KVM_SET_MSRS, msrs) != 1) {
+        warn_report("parked vCPU %lu TSC reset failed: %d",
+                    vcpu_id, errno);
+    }
+}
+
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;

