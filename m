Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657C8D46C15
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnD-0008NB-AX; Wed, 28 Jan 2026 18:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnC-0008Ll-7B
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:46 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEn8-0001j1-6b
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642262; x=1801178262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X6eVlD0wWTJwoNEwxzsqjt1g8gKZ9ft2Xlc5mBum9NY=;
 b=iqu6csBAzoVPv7S5PkcsBXV9XMPOriGArCbT8ZNrxlx4n8NAbf9uQLww
 puMUOToCAPkaKGsi3ed1nwW14c7GP2kYlMvYCmQHP0nBs8P5hwHRrFgd1
 gp7bl8KUnVLi/L35+EJSdHkNVSNN4zKSiVNgtJ/k2ghEXCm/9d3jzHKhY
 vtlB0k07P436fCC3QB9mbH0sGydxhiHFSDrYf7llrtd0+xvDygqQKVI5h
 oDeJlne7hRAriYG36EPyEEhe6SzexA0yGyzsvDQgZVfqqXLrpDZOnQe6M
 1tPgu5dius3miGKz3i43SvFrgfOFPcmIkzKjLFoFFvIOl2vaM3TtW5EK0 g==;
X-CSE-ConnectionGUID: w9Ey/INOToa2+DkDf3weJQ==
X-CSE-MsgGUID: HAJIED4ySly4aGzESzfqWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462314"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462314"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:38 -0800
X-CSE-ConnectionGUID: 2FkKWPuER+ml+TpE6QAjEg==
X-CSE-MsgGUID: HdmXgQTDRBeyAmnBuEbHGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001763"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:37 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 02/11] target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL
 MSR
Date: Wed, 28 Jan 2026 15:09:39 -0800
Message-ID: <20260128231003.268981-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
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
V2:
- No changes.

 target/i386/cpu.h     | 1 -
 target/i386/kvm/kvm.c | 6 ------
 target/i386/machine.c | 4 ++--
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f02812bfd19f..f6e9b274e2ff 100644
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


