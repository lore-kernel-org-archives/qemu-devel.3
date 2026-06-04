Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083C0CD6E71
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUyNt-0001T2-6x; Wed, 03 Jun 2026 23:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNs-0001So-4b
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:40 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNq-0007ss-8D
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780542278; x=1812078278;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EnVdVvtdOT57CZwQs5OzrqwYpQxvUB6tX6ySs6DnbNY=;
 b=LcRuhCjrRhsOx3PoJWiv325hDKHXQpfx4a1UCfNHFNPWDQTQ73Djeh/k
 IRt/+kvLzeDT/HY54KhINEkhvcBB5l4rFE/r5ZBW9NeF899UlKqAcmGwK
 2+HKtZeQUADh+Z6xWZy653t4l+7cvNXkkoxxf6QexCuufnV0XkfBXhJac
 kK3AHx42ZmcCRjy1Xf2Hg6H2ghDmU50VAbI2QQJqHgb3tuh3ZzBiPhlD9
 8IfRxDl26nRMxIAknxbxfDanMfTvqUJ2EUkoartOzND5Za3Le7jOcMNRa
 hXU+Dre+n05f703I9DoXCgEiNsc5kzjiCANaqV1Oc78JnpTsLBQO9aXlU A==;
X-CSE-ConnectionGUID: BO1jCwHwQ/GutXNvSHQzng==
X-CSE-MsgGUID: UYGIC4kUT8yQ1dXK7mosPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399643"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="80399643"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: QWvo0l2dSrCG04oBhBJRjQ==
X-CSE-MsgGUID: fIuHYvqQReK5djpPG8CdxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="241915846"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 4/6] target/i386: Support full-width writes for perf
 counters
Date: Wed,  3 Jun 2026 19:55:44 -0700
Message-ID: <20260604025546.19378-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604025546.19378-1-zide.chen@intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
corresponding 64-bit alias MSR starting at 0x4c1 (IA32_A_PMC0).

The legacy IA32_PMCi MSRs are not full-width and their effective width
is determined by CPUID.0AH:EAX[23:16].

Since these MSRs are architectural aliases, when IA32_A_PMCi is
supported it is safe to use it for save/restore instead of the legacy
IA32_PMCi MSRs.

Full-width write is a user-visible feature and can be disabled
individually.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Move the MAX_GP_COUNTERS change and migrate version ID code to
  [patch v3 4/13] to avoid bumping version IDs twice in one patch
  series.

V2:
- Slightly improve the commit message wording.
- Update the comment for MSR_IA32_PMC0 definition.
---
 target/i386/cpu.h     |  3 +++
 target/i386/kvm/kvm.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5288c92fe52f..8cc3c2f139e7 100644
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
+/* Alias MSR range for full-width general-purpose performance counters */
+#define MSR_IA32_PMC0                   0x4c1
 
 #define MSR_IA32_SMBASE                 0x9e
 #define MSR_SMI_COUNT                   0x34
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5c953a0f3a60..a99c1dba83f2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4270,6 +4270,12 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
         }
 
         if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+            uint32_t perf_cntr_base = MSR_P6_PERFCTR0;
+
+            if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_FULL_WRITE) {
+                perf_cntr_base = MSR_IA32_PMC0;
+            }
+
             if (pmu_version > 1) {
                 /* Stop the counter.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -4282,7 +4288,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                                   env->msr_fixed_counters[i]);
             }
             for (i = 0; i < num_pmu_gp_counters; i++) {
-                kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i,
+                kvm_msr_entry_add(cpu, perf_cntr_base + i,
                                   env->msr_gp_counters[i]);
                 kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i,
                                   env->msr_gp_evtsel[i]);
@@ -4844,6 +4850,11 @@ static int kvm_get_msrs(X86CPU *cpu)
     }
 
     if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
+        uint32_t perf_cntr_base = MSR_P6_PERFCTR0;
+
+        if (env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_FULL_WRITE) {
+            perf_cntr_base = MSR_IA32_PMC0;
+        }
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
@@ -4853,7 +4864,7 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
         }
         for (i = 0; i < num_pmu_gp_counters; i++) {
-            kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
+            kvm_msr_entry_add(cpu, perf_cntr_base + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
     }
@@ -5218,6 +5229,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_counters[index - MSR_P6_PERFCTR0] = msrs[i].data;
             break;
+        case MSR_IA32_PMC0 ... MSR_IA32_PMC0 + MAX_GP_COUNTERS - 1:
+            env->msr_gp_counters[index - MSR_IA32_PMC0] = msrs[i].data;
+            break;
         case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
             break;
-- 
2.54.0


