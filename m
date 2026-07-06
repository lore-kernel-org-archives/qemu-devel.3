Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D610DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wginq-0000jP-Gv; Mon, 06 Jul 2026 08:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQU-0002rn-8h
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:30 -0400
Received: from [115.124.28.217] (helo=out28-217.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Rm-6V
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436261|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.228352-0.00012945-0.771519;
 FP=7097510869165867103|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033068005250;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.iEEStrb_1783317365; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEEStrb_1783317365 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:06 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Date: Mon,  6 Jul 2026 13:55:26 +0800
Message-ID: <20260706055530.1752094-6-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.217 (deferred)
Received-SPF: pass client-ip=115.124.28.217;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-217.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:12 -0400
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

From: Tina Zhang <zhang_wei@open-hieco.net>

On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
layout.  Hygon guests that enable PMU and request AMD PMU CPUID
features such as perfctr-core need QEMU's KVM PMU setup and MSR state
paths to use that layout too.

The relevant QEMU KVM PMU paths are currently restricted to
AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
information initialization, and AMD PMU MSR save/restore.  As a result,
a Hygon Dhyana guest can be rejected as unsupported because the guest
vendor is HygonGenuine rather than AuthenticAMD.  If the VM continues,
QEMU still skips AMD PMU setup and the AMD PMU MSR get/put paths.

Treat Hygon as using the AMD PMU CPUID/MSR layout for these KVM PMU
paths.  Because the PMU MSR layout is shared, accept both AMD and Hygon
hosts for guests using that layout.  This intentionally allows the PMU
compatibility check to pass for AMD-host/Hygon-guest and
Hygon-host/AMD-guest combinations.

This does not enable PMU, perfctr-core, or perfmon-v2 by default for the
Dhyana CPU model.  On backward migration to older QEMU, Hygon PMU MSR
state may still be dropped because older QEMU did not write that state
back through the AMD PMU MSR KVM paths for Hygon guests.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/kvm/kvm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e2bfbbe1d..215e0c8f03 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2175,6 +2175,21 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 }
 
+/*
+ * KVM exposes the AMD PMU CPUID/MSR layout for Hygon guests, so QEMU must
+ * use the AMD PMU setup and MSR state paths for Hygon too.
+ */
+static bool kvm_pmu_uses_amd_msrs(const CPUX86State *env)
+{
+    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
+}
+
+static bool host_cpu_uses_amd_pmu_msrs(const char *host_vendor)
+{
+    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
+           g_str_equal(host_vendor, CPUID_VENDOR_HYGON);
+}
+
 static bool is_host_compat_vendor(CPUX86State *env)
 {
     char host_vendor[CPUID_VENDOR_SZ + 1];
@@ -2191,8 +2206,8 @@ static bool is_host_compat_vendor(CPUX86State *env)
         return true;
     }
 
-    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
-           IS_AMD_CPU(env);
+    return host_cpu_uses_amd_pmu_msrs(host_vendor) &&
+           kvm_pmu_uses_amd_msrs(env);
 }
 
 static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
@@ -2222,7 +2237,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
 
     if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
         kvm_init_pmu_info_intel(cpuid);
-    } else if (IS_AMD_CPU(env)) {
+    } else if (kvm_pmu_uses_amd_msrs(env)) {
         kvm_init_pmu_info_amd(cpuid, cpu);
     }
 }
@@ -4309,7 +4324,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             }
         }
 
-        if (IS_AMD_CPU(env) && pmu_version > 0) {
+        if (kvm_pmu_uses_amd_msrs(env) && pmu_version > 0) {
             uint32_t sel_base = MSR_K7_EVNTSEL0;
             uint32_t ctr_base = MSR_K7_PERFCTR0;
             /*
@@ -4871,7 +4886,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
-    if (IS_AMD_CPU(env) && pmu_version > 0) {
+    if (kvm_pmu_uses_amd_msrs(env) && pmu_version > 0) {
         uint32_t sel_base = MSR_K7_EVNTSEL0;
         uint32_t ctr_base = MSR_K7_PERFCTR0;
         /*
-- 
2.43.7


