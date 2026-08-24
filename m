Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971ACC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMje-0007Le-Gi; Mon, 24 Aug 2026 00:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMj9-0006au-GL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:56:08 -0400
Received: from [115.124.28.50] (helo=out28-50.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wyMiy-00038q-VZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 00:56:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00957263-0.000683732-0.989744;
 FP=7745995268663411031|1|1|1|0|-1|-1|-1; HT=maildocker-contentspam033045213054;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.ivXOSqU_1787547222; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.ivXOSqU_1787547222 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Aug 2026 12:53:42 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 05/10] target/i386/kvm: Classify PMU vendor families
Date: Mon, 24 Aug 2026 12:53:09 +0800
Message-ID: <20260824045314.162941-6-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824045314.162941-1-zhang_wei@open-hieco.net>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.50 (deferred)
Received-SPF: pass client-ip=115.124.28.50;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-50.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The Intel and Zhaoxin PMU architectures are compatible, while AMD uses
a separate PMU CPUID/MSR layout.  KVM's PMU initialization, host/guest
compatibility, and MSR save/restore paths open-code these vendor checks
in several places.

Introduce X86PMUVendor and helpers that classify the existing CPU and
host vendors by PMU architecture.  Use the classification consistently
for the compatibility check, PMU initialization, and PMU MSR paths.

This is a refactoring with no functional change.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 72 +++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d1c6dbe636..01fc1d0674 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2166,24 +2166,53 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 }
 
-static bool is_host_compat_vendor(CPUX86State *env)
+typedef enum X86PMUVendor {
+    X86_PMU_VENDOR_UNKNOWN,
+    X86_PMU_VENDOR_INTEL,
+    X86_PMU_VENDOR_AMD,
+} X86PMUVendor;
+
+static X86PMUVendor x86_cpu_pmu_vendor(const CPUX86State *env)
+{
+    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
+        return X86_PMU_VENDOR_INTEL;
+    }
+
+    if (IS_AMD_CPU(env)) {
+        return X86_PMU_VENDOR_AMD;
+    }
+
+    return X86_PMU_VENDOR_UNKNOWN;
+}
+
+static X86PMUVendor x86_host_pmu_vendor(void)
 {
     char host_vendor[CPUID_VENDOR_SZ + 1];
 
     host_cpu_vendor_fms(host_vendor, NULL, NULL, NULL);
 
-    /*
-     * Intel and Zhaoxin are compatible.
-     */
-    if ((g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
-         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
-         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) &&
-        (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
-        return true;
+    if (g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
+        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
+        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) {
+        return X86_PMU_VENDOR_INTEL;
     }
 
-    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
-           IS_AMD_CPU(env);
+    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD)) {
+        return X86_PMU_VENDOR_AMD;
+    }
+
+    return X86_PMU_VENDOR_UNKNOWN;
+}
+
+/*
+ * The guest vPMU can be virtualized only when the host and guest PMU
+ * architectures are compatible.
+ */
+static bool is_host_compat_vendor(CPUX86State *env)
+{
+    X86PMUVendor guest = x86_cpu_pmu_vendor(env);
+
+    return guest != X86_PMU_VENDOR_UNKNOWN && guest == x86_host_pmu_vendor();
 }
 
 static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
@@ -2211,10 +2240,15 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
         return;
     }
 
-    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
+    switch (x86_cpu_pmu_vendor(env)) {
+    case X86_PMU_VENDOR_INTEL:
         kvm_init_pmu_info_intel(cpuid);
-    } else if (IS_AMD_CPU(env)) {
+        break;
+    case X86_PMU_VENDOR_AMD:
         kvm_init_pmu_info_amd(cpuid, cpu);
+        break;
+    case X86_PMU_VENDOR_UNKNOWN:
+        break;
     }
 }
 
@@ -4268,7 +4302,8 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
-        if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+        if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_INTEL &&
+            pmu_version > 0) {
             if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4300,7 +4335,8 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             }
         }
 
-        if (IS_AMD_CPU(env) && pmu_version > 0) {
+        if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_AMD &&
+            pmu_version > 0) {
             uint32_t sel_base = MSR_K7_EVNTSEL0;
             uint32_t ctr_base = MSR_K7_PERFCTR0;
             /*
@@ -4846,7 +4882,8 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
 
-    if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+    if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_INTEL &&
+        pmu_version > 0) {
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4862,7 +4899,8 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
-    if (IS_AMD_CPU(env) && pmu_version > 0) {
+    if (x86_cpu_pmu_vendor(env) == X86_PMU_VENDOR_AMD &&
+        pmu_version > 0) {
         uint32_t sel_base = MSR_K7_EVNTSEL0;
         uint32_t ctr_base = MSR_K7_PERFCTR0;
         /*
-- 
2.43.7


