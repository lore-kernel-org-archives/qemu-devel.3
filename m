Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C009CC9830F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 01:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vguxL-0004qD-UX; Fri, 16 Jan 2026 20:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxD-0004mi-PX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:16 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxC-00077n-2B
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768612694; x=1800148694;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WVJQSNpNKHu3X0iUjOMBxv0QHS5KDEf9o+KQJ8gyVAQ=;
 b=gVZJ8uMqShYL/INe6YTbv/boC7zvTxcBIA8/0+G6G90Py+6i1tJ2zxF/
 7s3oUnXhCP/t8syEjg3Hu1gPy33LTt5uR07NM8/47J+lCdgTRM23zRRDe
 iC09f85kGoF61YpnR6Xzkirwj/kCV2uPRWLqOBS/8uSUOxFOKmMtVcvvI
 Q6F0CdnJvfowu+YLcRJaWRZYYlOc+F7OHTf3dJdm32WkgjXzWeOkMWGri
 7mQnBQiv5egHK/oRIWhMzhe5wfNdzvECFBjR6RewaVPIN0H7XaMYTGQfO
 /8nTA3pCNYhbf2bN3wn94adfvWBdczHau6jUwBSsdLgPAn3O/WeYCSuua w==;
X-CSE-ConnectionGUID: a0PLjm+BRhumKkzimtDJ8A==
X-CSE-MsgGUID: LjP/hSMqRAO7vpySNOCAKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69131153"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; d="scan'208";a="69131153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:08 -0800
X-CSE-ConnectionGUID: /+z504YORU+VnwiO6lsoeA==
X-CSE-MsgGUID: UW7hqU9YRR2jgIAvFDbxCg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:07 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH 2/7] target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSR
Date: Fri, 16 Jan 2026 17:10:48 -0800
Message-ID: <20260117011053.80723-3-zide.chen@intel.com>
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

MSR_CORE_PERF_GLOBAL_OVF_CTRL is a write-only MSR and reads always
return zero.

Saving and restoring this MSR is therefore unnecessary.  Replace
VMSTATE_UINT64 with VMSTATE_UNUSED in the VMStateDescription to ignore
env.msr_global_ovf_ctrl during migration.  This avoids the need to bump
version_id and does not introduce any migration incompatibility.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/cpu.h     | 1 -
 target/i386/kvm/kvm.c | 6 ------
 target/i386/machine.c | 4 ++--
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f2b79a8bf1dc..0b480c631ed0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2086,7 +2086,6 @@ typedef struct CPUArchState {
     uint64_t msr_fixed_ctr_ctrl;
     uint64_t msr_global_ctrl;
     uint64_t msr_global_status;
-    uint64_t msr_global_ovf_ctrl;
     uint64_t msr_fixed_counters[MAX_FIXED_COUNTERS];
     uint64_t msr_gp_counters[MAX_GP_COUNTERS];
     uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7b9b740a8e5a..cffbc90d1c50 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4069,8 +4069,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             if (has_architectural_pmu_version > 1) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
                                   env->msr_global_status);
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
-                                  env->msr_global_ovf_ctrl);
 
                 /* Now start the PMU.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
@@ -4588,7 +4586,6 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
-            kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
         }
         for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
@@ -4917,9 +4914,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_CORE_PERF_GLOBAL_STATUS:
             env->msr_global_status = msrs[i].data;
             break;
-        case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-            env->msr_global_ovf_ctrl = msrs[i].data;
-            break;
         case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
             env->msr_fixed_counters[index - MSR_CORE_PERF_FIXED_CTR0] = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c9139612813b..1125c8a64ec5 100644
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
2.52.0


