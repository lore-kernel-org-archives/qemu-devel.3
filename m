Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97BAE87855
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 18:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnKzx-00083o-U7; Tue, 03 Feb 2026 13:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1vnKzw-00083G-A6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:19:36 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1vnKzu-0002jw-PG
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 13:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770142775; x=1801678775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sVj4mpCE0QOp2zGt4i35GCFNwiVzV9EMvK7yxKqAX4c=;
 b=KrbHZd6OKH7GvNjnwYJAJE5BIRB+96Y9jUdMpOoDxbz3YzwbaNMGWP9M
 UhuvGY6p8T0YzmEMI0H93CDf8v4GUKO3lkHAUvyfYvfAVTnTWI0fv90uT
 aHkKRd86ZaxN1cc/mZIk8QKeFJCb0+BPO7ldJpeVzggPTZZc6btSscSAa
 m+z1qGexJ8j2ipKpRZKOQVaMUkh45WbHnXXPZh9KZQZLG3L4OPI4Vze5g
 5QQ57SN6uYQqVsXXP8xzn+I9jf5h9lUC4lEhP0CZVwtIvMviG7bXHq08/
 TPfPCk2tCl22tYytUmpk1hQwX/Qq5biJh7rUC+SokG8gCix+a51NZem+k Q==;
X-CSE-ConnectionGUID: Tj1VY2qLQ9ivqKHfzbpOMw==
X-CSE-MsgGUID: OWvxDIEXTj+jyl15DWE9EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70523250"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; d="scan'208";a="70523250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 10:19:24 -0800
X-CSE-ConnectionGUID: u6gU2gasSvmPDf5TpNpDBw==
X-CSE-MsgGUID: O944K3p6Sla8RjqNB5DXqg==
X-ExtLoop1: 1
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost)
 ([10.124.221.188])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 10:19:24 -0800
From: isaku.yamahata@intel.com
To: qemu-devel@nongnu.org
Cc: isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 2/2] target/i386/kvm: Advertize tertiary procbased exec
 control to guest
Date: Tue,  3 Feb 2026 10:19:19 -0800
Message-ID: <bb006e42069cae656ec1e9260a7dd57205e3b6c0.1770116952.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e41ffc4af96b8b4ee3a65f8da1f52dac7f3f4913.1770116952.git.isaku.yamahata@intel.com>
References: <e41ffc4af96b8b4ee3a65f8da1f52dac7f3f4913.1770116952.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

When KVM supports tertiary processor based execution control, advertise
it to the guest.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 target/i386/kvm/kvm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0c940d4b640c..4f235c211ae8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -162,6 +162,7 @@ static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
 static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
+static bool has_msr_vmx_procbased_ctls3;
 static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
 static bool has_msr_hwcr;
@@ -2639,6 +2640,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_VMX_PROCBASED_CTLS2:
                 has_msr_vmx_procbased_ctls2 = true;
                 break;
+            case MSR_IA32_VMX_PROCBASED_CTLS3:
+                has_msr_vmx_procbased_ctls3 = true;
+                break;
             case MSR_IA32_PKRS:
                 has_msr_pkrs = true;
                 break;
@@ -3839,6 +3843,13 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
     if (has_msr_vmx_vmfunc) {
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMFUNC, f[FEAT_VMX_VMFUNC]);
     }
+    if (has_msr_vmx_procbased_ctls3 &&
+        /* >> 32 is for high bit. */
+        (f[FEAT_VMX_PROCBASED_CTLS] >> 32) &
+        VMX_CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_PROCBASED_CTLS3,
+                          f[FEAT_VMX_TERTIARY_CTLS]);
+    }
 
     /*
      * Just to be safe, write these with constant values.  The CRn_FIXED1
@@ -3852,10 +3863,22 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
     if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
         /* FRED injected-event data (0x2052).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);
+    } else if (f[FEAT_VMX_TERTIARY_CTLS] &
+               VMX_TERTIARY_EXEC_APIC_TIMER_VIRT) {
+        /*
+         * APIC timer virtualization:
+         * virtual timer vector (0xa), guest deadline (0x2830), and
+         * guest deadline shadow (0x204e).
+         */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x4e);
     } else if (f[FEAT_VMX_EXIT_CTLS] &
                VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
         /* Secondary VM-exit controls (0x2044).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x44);
+    } else if (f[FEAT_VMX_PROCBASED_CTLS] &
+               VMX_CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
+        /* Tertiary procbased VM-execution controls (0x2034).  */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x34);
     } else if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
         /* TSC multiplier (0x2032).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x32);
-- 
2.45.2


