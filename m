Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD950CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUyNr-0001Rx-Fp; Wed, 03 Jun 2026 23:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNp-0001RV-7K
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:37 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNn-0007rh-CX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780542275; x=1812078275;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4SPDUVFod+VWSgwd5Iuz4sLihxemNPrvCyTioHMz+Gc=;
 b=MnUvlOlJLoI1vsDqtiXUUkarp5dVXO5BBKHGbF8BtycUKz0/7eQDWKfi
 PS2OZelIP0zi6t2oRFacOQyx94jlpix5M6UMPx1ILEb98nbgEDfhWc0vf
 wXs7AGTwRJy5mVeKAOt1xK3RkMGxLobBEqirUFxVJPvqP3MEbRbr/BZex
 CNFq4DTqcT+qI3IqOLAoXoXKTgWes8RU2kDPTI9d4t+krvtNq36Phy9ql
 vnfnMEv1Aj1T3/g7VtTSASe9vEPvCf6Ya3PfigyN3isfxUT3hQjdGPvPG
 YiwjTyqO7yCRhQ2jciLitCg3CyeURCJs36yGN2NqSgDAXD4mliauy7Q5S A==;
X-CSE-ConnectionGUID: XsEkVR3WTZ281z91AeCYmg==
X-CSE-MsgGUID: G3To1YDjTP+TqGS5NqHH3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399625"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="80399625"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: PrRGKT41R1O5bZ9TULc3Lw==
X-CSE-MsgGUID: Lk4f/j0wRPy6u1VvWazFqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="241915837"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:27 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 1/6] target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL
 MSRs
Date: Wed,  3 Jun 2026 19:55:41 -0700
Message-ID: <20260604025546.19378-2-zide.chen@intel.com>
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

MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
are write-only MSRs and reads always return zero.

Saving and restoring these MSRs is therefore unnecessary.  Replace
VMSTATE_UINT64 with VMSTATE_UNUSED in the VMStateDescription to ignore
env.msr_global_ovf_ctrl during migration.  This avoids the need to bump
version_id and does not introduce any migration incompatibility.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Fixes: e587632c228e ("target/i386/kvm: support perfmon-v2 for reset")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR as well.
---
 target/i386/cpu.h     |  3 ---
 target/i386/kvm/kvm.c | 10 ----------
 target/i386/machine.c |  4 ++--
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b500737c3be..ff44487d0b6d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -507,11 +507,9 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_FIXED_CTR_CTRL    0x38d
 #define MSR_CORE_PERF_GLOBAL_STATUS     0x38e
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS       0xc0000300
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL          0xc0000301
-#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR   0xc0000302
 
 #define MSR_K7_EVNTSEL0                 0xc0010000
 #define MSR_K7_PERFCTR0                 0xc0010004
@@ -2104,7 +2102,6 @@ typedef struct CPUArchState {
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
-    uint64_t msr_global_ovf_ctrl;
     uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
     uint64_t msr_gp_counters[MAX_GP_COUNTERS];
     uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a29f757c168a..1ac1803e8a2e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4290,8 +4290,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             if (pmu_version > 1) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
                                   env->msr_global_status);
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
-                                  env->msr_global_ovf_ctrl);
 
                 /* Now start the PMU.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
@@ -4335,8 +4333,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             if (pmu_version > 1) {
                 kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
                                   env->msr_global_status);
-                kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
-                                  env->msr_global_ovf_ctrl);
                 kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
                                   env->msr_global_ctrl);
             }
@@ -4852,7 +4848,6 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
         }
         for (i = 0; i < num_pmu_fixed_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
@@ -4895,7 +4890,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         if (pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
             kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, 0);
-            kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0);
         }
     }
 
@@ -5218,10 +5212,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
             env->msr_global_status = msrs[i].data;
             break;
-        case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
-            env->msr_global_ovf_ctrl = msrs[i].data;
-            break;
         case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
             env->msr_fixed_counters[index - MSR_CORE_PERF_FIXED_CTR0] = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 48a2a4b31907..e0a5a5da6f5a 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -666,7 +666,7 @@ static bool pmu_enable_needed(void *opaque)
     int i;
 
     if (env->msr_fixed_ctr_ctrl || env->msr_global_ctrl ||
-        env->msr_global_status || env->msr_global_ovf_ctrl) {
+        env->msr_global_status) {
         return true;
     }
     for (i = 0; i < MAX_FIXED_COUNTERS; i++) {
@@ -692,7 +692,7 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
         VMSTATE_UINT64(env.msr_fixed_ctr_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_global_ctrl, X86CPU),
         VMSTATE_UINT64(env.msr_global_status, X86CPU),
-        VMSTATE_UINT64(env.msr_global_ovf_ctrl, X86CPU),
+        VMSTATE_UNUSED(sizeof(uint64_t)),
         VMSTATE_UINT64_ARRAY(env.msr_fixed_counters, X86CPU, MAX_FIXED_COUNTERS),
         VMSTATE_UINT64_ARRAY(env.msr_gp_counters, X86CPU, MAX_GP_COUNTERS),
         VMSTATE_UINT64_ARRAY(env.msr_gp_evtsel, X86CPU, MAX_GP_COUNTERS),
-- 
2.54.0


