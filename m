Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7ECC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvS-0003MR-EV; Fri, 24 Jan 2025 08:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJub-0001Fz-H5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:53 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuZ-00041c-LP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725992; x=1769261992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XEwqmQoSvwYMfkPqc6TzR0UgP5NnIAttqomtt/9PTFQ=;
 b=Mvz+r297dm4ioDoRtJ2af6PALwG30k5mWcqxK5ViBCwMLUjnXb7DORYa
 gZ4FzkWaFOZ2IFBK2p8uIafFjGgSD9SJbszldGcjB06wOiWQadCffaDRr
 U80Yp3Y9KXqrIu1injWZAbyERE9HUaMMYKdlvYBi50YzuOhsuWxyVQb9o
 GaqMV7XN0/zVjNRwI2i9cdjjP09K4EJiIHzNcUAUNTs3D02vsxpaP5hZZ
 RbU72fdrsBSP7L9X3po9PiNYenKUdl8ZBBBI0c2IuHaRp8NKx95VnAKMM
 cW2ABDUZQTvgbc5ndbnt9cqWun/EEGxY6K7zPFRnwJ9VK2dSQJlEMOhPg Q==;
X-CSE-ConnectionGUID: r/HL7G7cTeawKjpoJ0vHgA==
X-CSE-MsgGUID: Gv7UPa3gR1OEmRmZPDvpEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246552"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246552"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:33 -0800
X-CSE-ConnectionGUID: e6jGRyZ/TK+fefS8MicOpQ==
X-CSE-MsgGUID: gNS9RrQUStOtIANF8dwOFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804442"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:29 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 40/52] i386/cgs: Rename *mask_cpuid_features() to
 *adjust_cpuid_features()
Date: Fri, 24 Jan 2025 08:20:36 -0500
Message-Id: <20250124132048.3229049-41-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Because for TDX case, there are also fixed-1 bits that enfored by TDX
module.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/confidential-guest.h | 20 ++++++++++----------
 target/i386/kvm/kvm.c            |  2 +-
 target/i386/sev.c                |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index a86c42a47558..777d43cc9688 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -40,8 +40,8 @@ struct X86ConfidentialGuestClass {
     /* <public> */
     int (*kvm_type)(X86ConfidentialGuest *cg);
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
-    uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
-                                    int reg, uint32_t value);
+    uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
+                                      uint32_t index, int reg, uint32_t value);
 };
 
 /**
@@ -71,21 +71,21 @@ static inline void x86_confidential_guest_cpu_instance_init(X86ConfidentialGuest
 }
 
 /**
- * x86_confidential_guest_mask_cpuid_features:
+ * x86_confidential_guest_adjust_cpuid_features:
  *
- * Removes unsupported features from a confidential guest's CPUID values, returns
- * the value with the bits removed.  The bits removed should be those that KVM
- * provides independent of host-supported CPUID features, but are not supported by
- * the confidential computing firmware.
+ * Adjust the supported features from a confidential guest's CPUID values,
+ * returns the adjusted value.  There are bits being removed that are not
+ * supported by the confidential computing firmware or bits being added that
+ * are forcibly exposed to guest by the confidential computing firmware.
  */
-static inline int x86_confidential_guest_mask_cpuid_features(X86ConfidentialGuest *cg,
+static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                                              uint32_t feature, uint32_t index,
                                                              int reg, uint32_t value)
 {
     X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
 
-    if (klass->mask_cpuid_features) {
-        return klass->mask_cpuid_features(cg, feature, index, reg, value);
+    if (klass->adjust_cpuid_features) {
+        return klass->adjust_cpuid_features(cg, feature, index, reg, value);
     } else {
         return value;
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4078ba40473e..fa46edaeac8d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -573,7 +573,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     }
 
     if (current_machine->cgs) {
-        ret = x86_confidential_guest_mask_cpuid_features(
+        ret = x86_confidential_guest_adjust_cpuid_features(
             X86_CONFIDENTIAL_GUEST(current_machine->cgs),
             function, index, reg, ret);
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0e1dbb6959ec..a6c0a697250b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -946,7 +946,7 @@ out:
 }
 
 static uint32_t
-sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
+sev_snp_adjust_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
                             int reg, uint32_t value)
 {
     switch (feature) {
@@ -2404,7 +2404,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     klass->launch_finish = sev_snp_launch_finish;
     klass->launch_update_data = sev_snp_launch_update_data;
     klass->kvm_init = sev_snp_kvm_init;
-    x86_klass->mask_cpuid_features = sev_snp_mask_cpuid_features;
+    x86_klass->adjust_cpuid_features = sev_snp_adjust_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
     object_class_property_add(oc, "policy", "uint64",
-- 
2.34.1


