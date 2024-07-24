Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE090C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWX3i-0002r5-Jc; Wed, 24 Jul 2024 04:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1sWX3c-0002qL-JK
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:09:08 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1sWX3Z-0006Fm-OQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721808546; x=1753344546;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZCHPqRkAPaaK7jIc8I0RwDlUEvdpc1r9dJXDCMFtXtw=;
 b=KCS0ahKJLa/R9lQJVWiW6C5ehEridL4dvFiSFbrF6jTONFSXrVNPcZZG
 4Tvf6UnVhCUxl9U8F0vLh2yYALHkMZDSEgdVcT7Krs8GxgQhTbwrF9KmD
 i0Wicj94LL1nYI03xzpzKPDfmnXVMnxfkN5kYe3e9cgLzwKJ3Dixy0GnC
 VMWL4YYVgQCzjGycj5ulCPP5Zua0YTTEgB9dSDMBhqlnoFqX0H3wvMiUl
 HxexBPF9A77XQYs78G1zA3GzV2pQ4loFkIT9J46DGhz5qv1f3OnTlkvVy
 OWtFCqooeJpVEx5uzvxvoaA+7UhCUuE67bOFm/qo10SclX6tNaeW7pYy4 A==;
X-CSE-ConnectionGUID: vGjQDsskQnGYJC+aORbibA==
X-CSE-MsgGUID: TVT9m3ddTWWwZ834t0kOqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19347440"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="19347440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 01:09:02 -0700
X-CSE-ConnectionGUID: ziHbI3rIS9OplWmFzi0xlA==
X-CSE-MsgGUID: E/DptciSQNKaSrRSSdnHFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="56820196"
Received: from sqa-gate.sh.intel.com (HELO emr-bkc.tsp.org) ([10.239.48.212])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:09:00 -0700
From: Lei Wang <lei4.wang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Xin Li <xin3.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Lei Wang <lei4.wang@intel.com>
Subject: [PATCH] target/i386: Raise the highest index value used for any VMCS
 encoding
Date: Wed, 24 Jul 2024 04:08:58 -0400
Message-Id: <20240724080858.46609-1-lei4.wang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Because the index value of the VMCS field encoding of Secondary VM-exit
controls, 0x44, is larger than any existing index value, raise the highest
index value used for any VMCS encoding to 0x44.

Because the index value of the VMCS field encoding of FRED injected-event
data (one of the newly added VMCS fields for FRED transitions), 0x52, is
larger than any existing index value, raise the highest index value used
for any VMCS encoding to 0x52.

Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Lei Wang <lei4.wang@intel.com>
---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/kvm.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3..5604cc2994 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1192,6 +1192,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
 #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
 #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
+#define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
 
 #define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
 #define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b4aab9a410..7c8cb16675 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3694,7 +3694,14 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
     kvm_msr_entry_add(cpu, MSR_IA32_VMX_CR4_FIXED0,
                       CR4_VMXE_MASK);
 
-    if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
+    if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+        /* FRED injected-event data (0x2052).  */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);
+    } else if (f[FEAT_VMX_EXIT_CTLS] &
+               VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
+        /* Secondary VM-exit controls (0x2044).  */
+        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x44);
+    } else if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
         /* TSC multiplier (0x2032).  */
         kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x32);
     } else {
-- 
2.39.3


