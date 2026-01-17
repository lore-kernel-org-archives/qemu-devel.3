Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875C5C9830C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 01:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vguxM-0004qS-Da; Fri, 16 Jan 2026 20:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxE-0004mk-5e
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:16 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxC-0007Aa-Fc
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768612695; x=1800148695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0EHb9zhaCZcf7BErUyjTZ5rV4RNsDDaKZWDuBspJf60=;
 b=V5El7gmY5lZ6ZgMvmAURYm0HhJvgIyOe+klb8egMS5f+I2iU8NCF/wy1
 447WQKNjPXNjWTdR6cFe2iDcsPz7fgCbPk77bWyTWF6KIi4MSTvbSKEoS
 e/cMIdniSwvbgVhTBcmniI4DWTPYDDdTzyPS+UFK4PCaVKtrVsNnYCsHX
 2Y5UMLSo78efqFZzn41u1F2Tzty5t8RC/LbaOSpOXkNPexO9sHTyVbTRz
 reT8T9vBXasFfvcS7vK4Jyy7DepkgTC9EvA5oA8LTxgCCR9tCLPebCeRP
 7vzO/q4102IUG0eJ1Bj5Z1lBJqjhgNC2VQM93EedUMezvm2MesPYLPiOJ Q==;
X-CSE-ConnectionGUID: Hh0vng1FR7yfRbPQ0Q3Cdg==
X-CSE-MsgGUID: 6U1zHtkRTV2UKqxCUmJiTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69131163"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; d="scan'208";a="69131163"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:08 -0800
X-CSE-ConnectionGUID: mNuTuSRfQAWCK/ad0cnTvQ==
X-CSE-MsgGUID: uPiptIIgRwyNypKjc59FXQ==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:08 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH 4/7] target/i386: Support full-width writes for perf counters
Date: Fri, 16 Jan 2026 17:10:50 -0800
Message-ID: <20260117011053.80723-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117011053.80723-1-zide.chen@intel.com>
References: <20260117011053.80723-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

If IA32_PERF_CAPABILITIES.FW_WRITE (bit 13) is set, each general-
purpose counter IA32_PMCi (starting at 0xc1) is accompanied by a
corresponding alias MSR starting at 0x4c1 (IA32_A_PMC0), which are
64-bit wide.

The legacy IA32_PMCi MSRs are not full-width and their effective width
is determined by CPUID.0AH:EAX[23:16].

Since these two sets of MSRs are aliases, when IA32_A_PMCi is supported
it is safe to use it for save/restore instead of the legacy MSRs,
regardless of whether the hypervisor uses the legacy or the 64-bit
counterpart.

Full-width write is a user-visible feature and can be disabled
individually.

Reduce MAX_GP_COUNTERS from 18 to 15 to avoid conflicts between the
full-width MSR range and MSR_MCG_EXT_CTL.  Current CPUs support at most
10 general-purpose counters, so 15 is sufficient for now and leaves room
for future expansion.

Bump minimum_version_id to avoid migration from older QEMU, as this may
otherwise cause VMState overflow. This also requires bumping version_id,
which prevents migration to older QEMU as well.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     |  5 ++++-
 target/i386/kvm/kvm.c | 19 +++++++++++++++++--
 target/i386/machine.c |  4 ++--
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b480c631ed0..e7cf4a7bd594 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -421,6 +421,7 @@ typedef enum X86Seg {
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
+#define PERF_CAP_FULL_WRITE             (1U << 13)
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -448,6 +449,8 @@ typedef enum X86Seg {
 #define MSR_IA32_SGXLEPUBKEYHASH3       0x8f
 
 #define MSR_P6_PERFCTR0                 0xc1
+/* Alternative perfctr range with full access. */
+#define MSR_IA32_PMC0                   0x4c1
 
 #define MSR_IA32_SMBASE                 0x9e
 #define MSR_SMI_COUNT                   0x34
@@ -1740,7 +1743,7 @@ typedef struct {
 #endif
 
 #define MAX_FIXED_COUNTERS 3
-#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
+#define MAX_GP_COUNTERS    15
 
 #define NB_OPMASK_REGS 8
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e81fa46ed66c..530f50e4b218 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4049,6 +4049,12 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
         }
 
         if (has_architectural_pmu_version > 0) {
+            uint32_t perf_cntr_base = MSR_P6_PERFCTR0;
+
+            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_FULL_WRITE) {
+                perf_cntr_base = MSR_IA32_PMC0;
+            }
+
             if (has_architectural_pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4061,7 +4067,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                                   env->msr_fixed_counters[i]);
             }
             for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
-                kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i,
+                kvm_msr_entry_add(cpu, perf_cntr_base + i,
                                   env->msr_gp_counters[i]);
                 kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i,
                                   env->msr_gp_evtsel[i]);
@@ -4582,6 +4588,12 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
     }
     if (has_architectural_pmu_version > 0) {
+        uint32_t perf_cntr_base = MSR_P6_PERFCTR0;
+
+        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_FULL_WRITE) {
+            perf_cntr_base = MSR_IA32_PMC0;
+        }
+
         if (has_architectural_pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4591,7 +4603,7 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
         }
         for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
-            kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
+            kvm_msr_entry_add(cpu, perf_cntr_base + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
     }
@@ -4920,6 +4932,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_counters[index - MSR_P6_PERFCTR0] = msrs[i].data;
             break;
+        case MSR_IA32_PMC0 ... MSR_IA32_PMC0 + MAX_GP_COUNTERS - 1:
+            env->msr_gp_counters[index - MSR_IA32_PMC0] = msrs[i].data;
+            break;
         case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 1125c8a64ec5..7d08a05835fc 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -685,8 +685,8 @@ static bool pmu_enable_needed(void *opaque)
 
 static const VMStateDescription vmstate_msr_architectural_pmu = {
     .name = "cpu/msr_architectural_pmu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = pmu_enable_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
-- 
2.52.0


