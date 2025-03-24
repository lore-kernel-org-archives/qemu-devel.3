Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA713C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 07:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twbw0-0008IF-8m; Mon, 24 Mar 2025 03:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1twbvZ-0008Gu-Sk
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:08:54 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1twbvX-0008JX-HW
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 03:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742800132; x=1774336132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bcLIsmrOKPi83DhR2wgRbrkYxT7RJ0kVGYi7GuXJLOQ=;
 b=JoZFWQYT9QSYSh+RrMoXqLR6N2AoQiXodQfi+2wERAM3tUEHW4HCv+LQ
 D0HRHVhOrzSQq7B7JMgLGdHbznhMFAnMb97niY6Goo8vHxOomlrMcBmCR
 5WmEOXHn7hdjAWEOAbqknDnI3ZnFSslfO4sNsIvVeAzm60aFGDClj97v6
 9Gbk1PNxlpTdlDq1EXLcwtkZi8HsrdcuMsoLRSmXZ9o/56HE10ktAIS0e
 uZcyhoSG6mf9XAycqXUjwC41inu07SZA3V5WL98QLY+fQ/qiIFUF0GGZU
 ix/ZPRJxQQNNcsY5cSAf1WEdgqVoJz1Xde9jbU66g6sbUKvUYIUl5zjbb g==;
X-CSE-ConnectionGUID: dhzub2eST3Wu8YXltlItEQ==
X-CSE-MsgGUID: cpcWyyIKSBGAQN52RqyiWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="31588480"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; d="scan'208";a="31588480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 00:08:50 -0700
X-CSE-ConnectionGUID: N3YfX5fhRDWeGrJegQyyAw==
X-CSE-MsgGUID: Gqadn5AZR9ejQjmgIv0XLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; d="scan'208";a="123944422"
Received: from emr.sh.intel.com ([10.112.229.56])
 by fmviesa007.fm.intel.com with ESMTP; 24 Mar 2025 00:08:47 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dongli Zhang <dongli.zhang@oracle.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 3/3] target/i386: Support
 VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL
Date: Mon, 24 Mar 2025 12:37:12 +0000
Message-Id: <20250324123712.34096-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
References: <20250324123712.34096-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Since Sapphire Rapids starts, VMX instrocude a new bit
SAVE_IA32_PERF_GLOBAL_CTRL in VMCS VM-EXIT control field to manage if
vmx can save guest PERF_GLOBAL_CTRL MSR.

This patch enables this feature.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 target/i386/cpu.c | 12 ++++++++----
 target/i386/cpu.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba..317ccc8b0a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1481,7 +1481,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
+            NULL, "vmx-exit-load-pkrs", "vmx-exit-save-perf-global-ctrl",
+            "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -4212,7 +4213,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
-            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
+            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
         .features[FEAT_VMX_MISC] =
             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
             MSR_VMX_MISC_VMWRITE_VMEXIT,
@@ -4368,7 +4370,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
-            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
+            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
         .features[FEAT_VMX_MISC] =
             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
             MSR_VMX_MISC_VMWRITE_VMEXIT,
@@ -4511,7 +4514,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
-            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
+            VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL,
         .features[FEAT_VMX_MISC] =
             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
             MSR_VMX_MISC_VMWRITE_VMEXIT,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a5..ad387e6ee7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1312,6 +1312,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
 #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
 #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
+#define VMX_VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL      0x40000000
 #define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
 
 #define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
-- 
2.40.1


