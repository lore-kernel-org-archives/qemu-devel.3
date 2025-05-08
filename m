Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7B2C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2qz-0001HB-Aj; Thu, 08 May 2025 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qt-0000c4-1s
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2qp-0007RW-MI
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716875; x=1778252875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zwqK2o9qmNeBEwv23lEVYGCEEx+xSPBeMhTP6/mZuCc=;
 b=M0FfwBBkvK5nR0nQD0EuQQ2mb2NBJka3QzVJntkjJWGbYsz/mnJ3E2Yc
 oLazlR9VStTE77jSiN3ahgbVgia0buygWZsXpyiNRLNAChO28/7DPLy/O
 l7S6JOA+ffFColQm7HKqzq2co/cK8dKWNMopnjm1jW6PhPRsxUJj/+f6V
 sJhuWU0SNzklk4UnrXH8YdPjiotXIvNXlfIl5C2tipWpPCr5wdUtFa5v7
 6tnQ8oTjMz/3/Ti2q7LQoOd9eH7UyolBczd6TGz/uX/pvQ1HkuVyOCPbW
 bK7PQ+XH30ejq0s3jKOQbRPVqZMuM4ptKz5NUxj0TahltVv1qyYjDw0SI A==;
X-CSE-ConnectionGUID: 6KiOYoMYRwOmKSC24Upv8g==
X-CSE-MsgGUID: 29JSqAAfRrWjd04AMJe41A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888395"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888395"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:58 -0700
X-CSE-ConnectionGUID: UVWrO2DrRAGYwkYXknUZ1A==
X-CSE-MsgGUID: vLeCKFT+R5W8HO5pRBb+zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440339"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:55 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 40/55] i386/tdx: Only configure MSR_IA32_UCODE_REV in
 kvm_init_msrs() for TDs
Date: Thu,  8 May 2025 10:59:46 -0400
Message-ID: <20250508150002.689633-41-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For TDs, only MSR_IA32_UCODE_REV in kvm_init_msrs() can be configured
by VMM, while the features enumerated/controlled by other MSRs except
MSR_IA32_UCODE_REV in kvm_init_msrs() are not under control of VMM.

Only configure MSR_IA32_UCODE_REV for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c | 44 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ead1d0263385..4078ba40473e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3863,32 +3863,34 @@ static void kvm_init_msrs(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
 
     kvm_msr_buf_reset(cpu);
-    if (has_msr_arch_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
-                          env->features[FEAT_ARCH_CAPABILITIES]);
-    }
-
-    if (has_msr_core_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
-                          env->features[FEAT_CORE_CAPABILITY]);
-    }
-
-    if (has_msr_perf_capabs && cpu->enable_pmu) {
-        kvm_msr_entry_add_perf(cpu, env->features);
+
+    if (!is_tdx_vm()) {
+        if (has_msr_arch_capabs) {
+            kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+                                env->features[FEAT_ARCH_CAPABILITIES]);
+        }
+
+        if (has_msr_core_capabs) {
+            kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
+                                env->features[FEAT_CORE_CAPABILITY]);
+        }
+
+        if (has_msr_perf_capabs && cpu->enable_pmu) {
+            kvm_msr_entry_add_perf(cpu, env->features);
+        }
+
+        /*
+         * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
+         * all kernels with MSR features should have them.
+         */
+        if (kvm_feature_msrs && cpu_has_vmx(env)) {
+            kvm_msr_entry_add_vmx(cpu, env->features);
+        }
     }
 
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-
-    /*
-     * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
-     * all kernels with MSR features should have them.
-     */
-    if (kvm_feature_msrs && cpu_has_vmx(env)) {
-        kvm_msr_entry_add_vmx(cpu, env->features);
-    }
-
     assert(kvm_buf_set_msrs(cpu) == 0);
 }
 
-- 
2.43.0


