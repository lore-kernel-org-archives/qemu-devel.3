Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DDBEFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqkm-0005Q2-Dd; Wed, 04 Mar 2026 13:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkk-0005P6-BX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:22 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqki-0004ky-Fr
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648121; x=1804184121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZlsDJyWZ8NEqGfqtG4R35Isk8UxXwFM/cwR7y3dMnzA=;
 b=GOGvQ1ewIGEOVngj36yruXWk6fT9va+BF3TljibC0Oj32SpWNsErgAZQ
 S00q6eOiCwKoiwOVV7SIOeKBGU2Kc1ZoyvrdWye00TXeS7LtMM7Ueqqqa
 3PRCVBScY961ar62nB/dkq6w6K1+DFf7H9BAYcp774hH2E7o+HBIw6Ezm
 CbTtkG/cm5Tcp0E9GhUw0ePvamlhzDUSHv/B/2d4jEk62VYEYSV8SlZ+B
 VF4o3jX8xZSXNMaITdkGouFAkvOj7XYtOTehhrznK/OreTgXbSqjzOrf6
 X6ypYVOiCt3k5RWJoT8bDL7bu3fdB9LuhqMWuZrwdW1hTKAzfyforZLCL A==;
X-CSE-ConnectionGUID: liBFTYcMQzq4r1I2dPgmoQ==
X-CSE-MsgGUID: ySF7h4oTRUOAsWKyg4SM7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909354"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909354"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:20 -0800
X-CSE-ConnectionGUID: qr5+zhPfT3W8VKdKjvRejQ==
X-CSE-MsgGUID: XlzkhJd+TX6wBeOnuFeS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542830"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:19 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 07/13] target/i386: Add get/set/migrate support for legacy
 PEBS MSRs
Date: Wed,  4 Mar 2026 10:07:06 -0800
Message-ID: <20260304180713.360471-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

The legacy DS-based PEBS relies on IA32_DS_AREA and IA32_PEBS_ENABLE
to take snapshots of a subset of the machine registers into the Intel
Debug-Store.

Adaptive PEBS introduces MSR_PEBS_DATA_CFG to be able to capture only
the data of interest, which is enumerated via bit 14 (PEBS_BASELINE)
of IA32_PERF_CAPABILITIES.

QEMU must save, restore and migrate these MSRs when legacy PEBS is
enabled.  Though the availability of these MSRs may not be the same,
it's still valid to put them in the same vmstate subsection for
implementation simplicity.

Originally-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Add the missing Originally-by tag to credit Luwei.
- Fix the vmstate name of msr_ds_pebs.
- Fix the criteria for determining availability of IA32_PEBS_ENABLE
  and MSR_PEBS_DATA_CFG.
- Change title to cover all aspects of what this patch does.
- Re-work the commit messages.
---
 target/i386/cpu.h     | 10 ++++++++++
 target/i386/kvm/kvm.c | 29 +++++++++++++++++++++++++++++
 target/i386/machine.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7c241a20420c..3a10f3242329 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -422,6 +422,7 @@ typedef enum X86Seg {
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
 #define PERF_CAP_FULL_WRITE             (1U << 13)
+#define PERF_CAP_PEBS_BASELINE          (1U << 14)
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -479,6 +480,7 @@ typedef enum X86Seg {
 /* Indicates good rep/movs microcode on some processors: */
 #define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
 #define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL  (1ULL << 12)
 #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
 #define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     | \
                                          MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
@@ -514,6 +516,11 @@ typedef enum X86Seg {
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS       0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL          0xc0000301
 
+/* Legacy DS based PEBS MSRs */
+#define MSR_IA32_PEBS_ENABLE            0x3f1
+#define MSR_PEBS_DATA_CFG               0x3f2
+#define MSR_IA32_DS_AREA                0x600
+
 #define MSR_K7_EVNTSEL0                 0xc0010000
 #define MSR_K7_PERFCTR0                 0xc0010004
 #define MSR_F15H_PERF_CTL0              0xc0010200
@@ -2099,6 +2106,9 @@ typedef struct CPUArchState {
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
+    uint64_t msr_ds_area;
+    uint64_t msr_pebs_data_cfg;
+    uint64_t msr_pebs_enable;
     uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
     uint64_t msr_gp_counters[MAX_GP_COUNTERS];
     uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4ba54151320f..8c4564bcbb9e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4280,6 +4280,16 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             }
 
+            if (env->features[FEAT_1_EDX] & CPUID_DTS) {
+                kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, env->msr_ds_area);
+            }
+            if (!(env->msr_ia32_misc_enable & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL)) {
+                kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, env->msr_pebs_enable);
+            }
+            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_BASELINE) {
+                kvm_msr_entry_add(cpu, MSR_PEBS_DATA_CFG, env->msr_pebs_data_cfg);
+            }
+
             /* Set the counter values.  */
             for (i = 0; i < num_pmu_fixed_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
@@ -4900,6 +4910,16 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
             kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, 0);
         }
+
+        if (env->features[FEAT_1_EDX] & CPUID_DTS) {
+            kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, 0);
+        }
+        if (!(env->msr_ia32_misc_enable & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL)) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, 0);
+        }
+        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_BASELINE) {
+            kvm_msr_entry_add(cpu, MSR_PEBS_DATA_CFG, 0);
+        }
     }
 
     if (env->mcg_cap) {
@@ -5241,6 +5261,15 @@ static int kvm_get_msrs(X86CPU *cpu)
                 env->msr_gp_evtsel[index] = msrs[i].data;
             }
             break;
+        case MSR_IA32_DS_AREA:
+            env->msr_ds_area = msrs[i].data;
+            break;
+        case MSR_PEBS_DATA_CFG:
+            env->msr_pebs_data_cfg = msrs[i].data;
+            break;
+        case MSR_IA32_PEBS_ENABLE:
+            env->msr_pebs_enable = msrs[i].data;
+            break;
         case HV_X64_MSR_HYPERCALL:
             env->msr_hv_hypercall = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 7d08a05835fc..5cff5d5a9db5 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -659,6 +659,27 @@ static const VMStateDescription vmstate_msr_ia32_feature_control = {
     }
 };
 
+static bool ds_pebs_enabled(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return (env->msr_ds_area || env->msr_pebs_enable ||
+            env->msr_pebs_data_cfg);
+}
+
+static const VMStateDescription vmstate_msr_ds_pebs = {
+    .name = "cpu/msr_architectural_pmu/msr_ds_pebs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ds_pebs_enabled,
+    .fields = (const VMStateField[]){
+        VMSTATE_UINT64(env.msr_ds_area, X86CPU),
+        VMSTATE_UINT64(env.msr_pebs_data_cfg, X86CPU),
+        VMSTATE_UINT64(env.msr_pebs_enable, X86CPU),
+        VMSTATE_END_OF_LIST()}
+};
+
 static bool pmu_enable_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -697,7 +718,11 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
         VMSTATE_UINT64_ARRAY(env.msr_gp_counters, X86CPU, MAX_GP_COUNTERS),
         VMSTATE_UINT64_ARRAY(env.msr_gp_evtsel, X86CPU, MAX_GP_COUNTERS),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_msr_ds_pebs,
+        NULL,
+    },
 };
 
 static bool mpx_needed(void *opaque)
-- 
2.53.0


