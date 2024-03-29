Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E828BCD128E
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq97q-00024t-EC; Fri, 29 Mar 2024 06:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97n-00023W-2z
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:15 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97l-000161-1N
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711706773; x=1743242773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tGavWDETP6FT06JEiwwRQmVvkPbXQlkwx2ajYdHWMAQ=;
 b=OYCt8IqBPr3WwTXvqdr6Gq8EN+AafBjpX893uWA4dMfMONfhrMSa+kby
 BKxRq1/8FXWyp/Kfvfu+sRh19OOEzP87Zj1s2jn8NjTscHt9yEA2uJCtH
 jS1R9/a3EwLTfIq83gGLvFTCKQdf5YOqX9ZA0UXu/M/Bd122pUMsHwutu
 lo0cj5cTFJVuhPKVhIlwdC/6jt57Ccm5kW3a2/gYddmczmC7Y6HVcIfnd
 qf5H685CKOIX3Qtihy+RxKOzdM3NxosFliA+YKUd2BK8kR8e4IU3NHGPb
 jj00wa3gCTgjD4YA5muRvmBk+XlKrCccUnva2TTldY6tm3aCyHAJ7w625 w==;
X-CSE-ConnectionGUID: HLJIVqBmTJGFqJuYwuSHoA==
X-CSE-MsgGUID: CRVuEC0ZTTOfGGPk235VCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17519197"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="17519197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 03:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="21441949"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2024 03:06:07 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-9.1 1/7] target/i386/kvm: Add feature bit definitions for
 KVM CPUID
Date: Fri, 29 Mar 2024 18:19:48 +0800
Message-Id: <20240329101954.3954987-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add feature definiations for KVM_CPUID_FEATURES in CPUID (
CPUID[4000_0001].EAX and CPUID[4000_0001].EDX), to get rid of lots of
offset calculations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/kvm/clock.c   |  5 ++---
 target/i386/cpu.h     | 23 +++++++++++++++++++++++
 target/i386/kvm/kvm.c | 28 ++++++++++++++--------------
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 40aa9a32c32c..7c9752d5036f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 
 #include <linux/kvm.h>
-#include "standard-headers/asm-x86/kvm_para.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_CLOCK "kvmclock"
@@ -334,8 +333,8 @@ void kvmclock_create(bool create_always)
 
     assert(kvm_enabled());
     if (create_always ||
-        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
-                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
+        cpu->env.features[FEAT_KVM] & (CPUID_FEAT_KVM_CLOCK |
+                                       CPUID_FEAT_KVM_CLOCK2)) {
         sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
     }
 }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 83e473584517..b1b8d11cb0fe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -27,6 +27,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qemu/cpu-float.h"
 #include "qemu/timer.h"
+#include "standard-headers/asm-x86/kvm_para.h"
 
 #define XEN_NR_VIRQS 24
 
@@ -951,6 +952,28 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* (Old) KVM paravirtualized clocksource */
+#define CPUID_FEAT_KVM_CLOCK            (1U << KVM_FEATURE_CLOCKSOURCE)
+/* (New) KVM specific paravirtualized clocksource */
+#define CPUID_FEAT_KVM_CLOCK2           (1U << KVM_FEATURE_CLOCKSOURCE2)
+/* KVM asynchronous page fault */
+#define CPUID_FEAT_KVM_ASYNCPF          (1U << KVM_FEATURE_ASYNC_PF)
+/* KVM stolen (when guest vCPU is not running) time accounting */
+#define CPUID_FEAT_KVM_STEAL_TIME       (1U << KVM_FEATURE_STEAL_TIME)
+/* KVM paravirtualized end-of-interrupt signaling */
+#define CPUID_FEAT_KVM_PV_EOI           (1U << KVM_FEATURE_PV_EOI)
+/* KVM paravirtualized spinlocks support */
+#define CPUID_FEAT_KVM_PV_UNHALT        (1U << KVM_FEATURE_PV_UNHALT)
+/* KVM host-side polling on HLT control from the guest */
+#define CPUID_FEAT_KVM_POLL_CONTROL     (1U << KVM_FEATURE_POLL_CONTROL)
+/* KVM interrupt based asynchronous page fault*/
+#define CPUID_FEAT_KVM_ASYNCPF_INT      (1U << KVM_FEATURE_ASYNC_PF_INT)
+/* KVM 'Extended Destination ID' support for external interrupts */
+#define CPUID_FEAT_KVM_MSI_EXT_DEST_ID  (1U << KVM_FEATURE_MSI_EXT_DEST_ID)
+
+/* Hint to KVM that vCPUs expect never preempted for an unlimited time */
+#define CPUID_FEAT_KVM_HINTS_REALTIME    (1U << KVM_HINTS_REALTIME)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe929302..2f3c8bc3a4ed 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -481,13 +481,13 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * be enabled without the in-kernel irqchip
          */
         if (!kvm_irqchip_in_kernel()) {
-            ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
+            ret &= ~CPUID_FEAT_KVM_PV_UNHALT;
         }
         if (kvm_irqchip_is_split()) {
-            ret |= 1U << KVM_FEATURE_MSI_EXT_DEST_ID;
+            ret |= CPUID_FEAT_KVM_MSI_EXT_DEST_ID;
         }
     } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
-        ret |= 1U << KVM_HINTS_REALTIME;
+        ret |= CPUID_FEAT_KVM_HINTS_REALTIME;
     }
 
     return ret;
@@ -3324,20 +3324,20 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
         kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
         kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF_INT) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
+        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
+        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_PV_EOI) {
             kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
         }
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
+        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_STEAL_TIME) {
             kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, env->steal_time_msr);
         }
 
-        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
+        if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_POLL_CONTROL) {
             kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
         }
 
@@ -3789,19 +3789,19 @@ static int kvm_get_msrs(X86CPU *cpu)
 #endif
     kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
     kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF_INT) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
+    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_ASYNCPF) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
+    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_PV_EOI) {
         kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
+    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_STEAL_TIME) {
         kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, 0);
     }
-    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
+    if (env->features[FEAT_KVM] & CPUID_FEAT_KVM_POLL_CONTROL) {
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
     if (has_architectural_pmu_version > 0) {
@@ -5434,7 +5434,7 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
         return address;
     }
     env = &X86_CPU(first_cpu)->env;
-    if (!(env->features[FEAT_KVM] & (1 << KVM_FEATURE_MSI_EXT_DEST_ID))) {
+    if (!(env->features[FEAT_KVM] & CPUID_FEAT_KVM_MSI_EXT_DEST_ID)) {
         return address;
     }
 
-- 
2.34.1


