Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A7EC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvO-0002m4-LQ; Fri, 24 Jan 2025 08:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuh-0001QI-Qn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:08 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuf-00042W-Jh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725998; x=1769261998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nEl4TCuOb3xMvomAtSQmQ5FpTfT7WK6HIdgq9DzAG/A=;
 b=QbGI6y46yyOt4Yv/KXLUMTZJ5KBkvStOw4pg96Moj9Igtb49hBt/HcEi
 YRIktESq4oiBIAbHBekdw7XzdZWmyXahocddRZdJc+EYwhQWJKIuEeCWe
 8o6RfqzH4FXQ1HeR/2Xaz5k+w0egbXdIPFwyJMJiK1FuWB/TGimlQKwvp
 ycnpyY3Dk/XbL+9yviPO5YV2Ee4G7toolyJsJRkjRZEb2D2rcqbURviLo
 n7XwFFVuEW4dLy9IINzd2GVfuoSGhCVY3cQJDLWkqFhn7ayT7414xZpUx
 ln7H4SrAuTbLODF5KAXwJmMihcDWBB5/If0ShgHq+W85HR9Pp/l1M8YaP g==;
X-CSE-ConnectionGUID: KSFeNjR7S7mX7tC3ne4x1w==
X-CSE-MsgGUID: xFKeNH5aTYWPWkckHRiODA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246562"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:37 -0800
X-CSE-ConnectionGUID: ifW55XqjSmCxoKv9I1zumQ==
X-CSE-MsgGUID: fZJtod0oTJ+gDSX001OnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804448"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:32 -0800
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
Subject: [PATCH v7 41/52] i386/tdx: Implement adjust_cpuid_features() for TDX
Date: Fri, 24 Jan 2025 08:20:37 -0500
Message-Id: <20250124132048.3229049-42-xiaoyao.li@intel.com>
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

1. QEMU's support for Intel PT is borken in general, thus doesn't
   support for TDX.

2. Only limited KVM PV features are supported for TD guest.

3. Drop the AMD specific bits that are reserved on Intel platform.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index dcbbe350ec91..9bdb9d795952 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -30,6 +30,8 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#include "standard-headers/asm-x86/kvm_para.h"
+
 #define TDX_MIN_TSC_FREQUENCY_KHZ   (100 * 1000)
 #define TDX_MAX_TSC_FREQUENCY_KHZ   (10 * 1000 * 1000)
 
@@ -42,6 +44,14 @@
                                  TDX_TD_ATTRIBUTES_PKS | \
                                  TDX_TD_ATTRIBUTES_PERFMON)
 
+#define TDX_SUPPORTED_KVM_FEATURES  ((1U << KVM_FEATURE_NOP_IO_DELAY) | \
+                                     (1U << KVM_FEATURE_PV_UNHALT) | \
+                                     (1U << KVM_FEATURE_PV_TLB_FLUSH) | \
+                                     (1U << KVM_FEATURE_PV_SEND_IPI) | \
+                                     (1U << KVM_FEATURE_POLL_CONTROL) | \
+                                     (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
+                                     (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -430,6 +440,39 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
     x86cpu->enable_cpuid_0x1f = true;
 }
 
+static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
+                                          uint32_t feature, uint32_t index,
+                                          int reg, uint32_t value)
+{
+    switch (feature) {
+    case 0x7:
+        if (index == 0 && reg == R_EBX) {
+            /* QEMU Intel PT support is broken */
+            value &= ~CPUID_7_0_EBX_INTEL_PT;
+        }
+        break;
+    case 0x40000001:
+        if (reg == R_EAX) {
+            value &= TDX_SUPPORTED_KVM_FEATURES;
+        }
+        break;
+    case 0x80000001:
+        if (reg == R_EDX) {
+            value &= ~CPUID_EXT2_AMD_ALIASES;
+        }
+        break;
+    case 0x80000008:
+        if (reg == R_EBX) {
+            value &= CPUID_8000_0008_EBX_WBNOINVD;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return value;
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -789,4 +832,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
+    x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
 }
-- 
2.34.1


