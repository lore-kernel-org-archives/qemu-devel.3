Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DA3C9830E
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 01:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vguxO-0004sJ-Sk; Fri, 16 Jan 2026 20:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxF-0004nI-Qs
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:18 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxE-00078g-19
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768612696; x=1800148696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5SM+V/i5RlkKEUO9iOkuBJwBqiK8SuXbIsYPBKq/HyY=;
 b=i+aQ28ga9XPA23pbaQ2eFa4QwQCUs1etNoK9h4WJaNEdsCFKnITkyNmB
 VjlNkRYUbaRyZHO3fOyRMFbWXSeG5ryNT51+CFDNBFZG97joF2D47uPhh
 2vPS5jwj/5JuGG6uFC13aCsl2+t9x2CDiRy5MD1xuTHvhpJtEFvkWR5ZK
 xatCy+7XJwMsqYRfyRucU6jBHz1wGUOc2oWfQMFqYyi5E8GPbFZQm83+X
 Gf4ApQIad+9v/BLjS5bLU0hWQ0vlXmP3xKmyybh2yNUDgVkD6IdWC0qLv
 0MSIF2F3SuB9vrWggtqrGMQlzWeacUOiD4MfvXn9ckyYqMmcLjc0LAExd Q==;
X-CSE-ConnectionGUID: jDk76PZlTZmSfJQYf6po1g==
X-CSE-MsgGUID: OR08xBtGQx6ufw0ri1wAxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69131168"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; d="scan'208";a="69131168"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:09 -0800
X-CSE-ConnectionGUID: sJNxcObPTb+uadIIa0gWYQ==
X-CSE-MsgGUID: YfzqnsF3R/yLt9eB/BipSA==
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
Subject: [PATCH 5/7] target/i386: Save/Restore DS based PEBS specfic MSRs
Date: Fri, 16 Jan 2026 17:10:51 -0800
Message-ID: <20260117011053.80723-6-zide.chen@intel.com>
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

DS-based PEBS introduces three MSRs: MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
and MSR_IA32_PEBS_ENABLE. Save and restore these MSRs when legacy DS
PEBS is enabled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     |  9 +++++++++
 target/i386/kvm/kvm.c | 25 +++++++++++++++++++++++++
 target/i386/machine.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7cf4a7bd594..dc5b477be283 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -422,6 +422,7 @@ typedef enum X86Seg {
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
 #define PERF_CAP_FULL_WRITE             (1U << 13)
+#define PERF_CAP_PEBS_BASELINE          (1U << 14)
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -512,6 +513,11 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
+/* Legacy DS based PEBS MSRs */
+#define MSR_IA32_PEBS_ENABLE            0x3f1
+#define MSR_PEBS_DATA_CFG               0x3f2
+#define MSR_IA32_DS_AREA                0x600
+
 #define MSR_MC0_CTL                     0x400
 #define MSR_MC0_STATUS                  0x401
 #define MSR_MC0_ADDR                    0x402
@@ -2089,6 +2095,9 @@ typedef struct CPUArchState {
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
index 530f50e4b218..80974114a173 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4061,6 +4061,15 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             }
 
+            if (env->features[FEAT_1_EDX] & CPUID_DTS) {
+                kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, env->msr_ds_area);
+            }
+
+            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_BASELINE) {
+                kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, env->msr_pebs_enable);
+                kvm_msr_entry_add(cpu, MSR_PEBS_DATA_CFG, env->msr_pebs_data_cfg);
+            }
+
             /* Set the counter values.  */
             for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
@@ -4606,6 +4615,13 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, perf_cntr_base + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
+        if (env->features[FEAT_1_EDX] & CPUID_DTS) {
+            kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, 0);
+        }
+        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_BASELINE) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, 0);
+            kvm_msr_entry_add(cpu, MSR_PEBS_DATA_CFG, 0);
+        }
     }
 
     if (env->mcg_cap) {
@@ -4938,6 +4954,15 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
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
index 7d08a05835fc..7f45db1247b1 100644
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
+    .name = "cpu/msr_ds_pebs",
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
2.52.0


