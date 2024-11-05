Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827ECD1CA3C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DG7-000410-IH; Tue, 05 Nov 2024 01:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEO-0002gx-Fs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:01 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEM-0001vd-Hf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788799; x=1762324799;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xbrsyTH8bvg8xsrUxtQa3cOVPKG1OlwWAfdK7z7v1Zw=;
 b=Pe0HaStynf2Zw8aZj1/ySwOCEkkdSEJfaaUz9tILiPf7FFUibLsiydDG
 UG2i3tZ+aM+MS14qIpAj4J0wnVwOGXikpAq+uRqQL+mbT3nTpl7PqwhO+
 oaJeJ3waOR+2PUsOCA3c0Lyp9XR3w2eSFBeOKUwT4t+cuO4jLOjlvBVoR
 xgYul+kp/7oixf+Q/MGzFozYXT61trrlhLbA+5cson50YnFgJ7IEbupvy
 ZMohJ59RaK+r6ni4snGcPBjmikuCLDxVPoBEHFnq0/5NAjcsfHtvSj9ai
 Neig/h0tpXBnr/70pOmUSYQMPpJ9rXmnE5gPIHSsyOmwtfrr4+e2UbhXo A==;
X-CSE-ConnectionGUID: fyacEsJgRP2WjnuIA+1WMg==
X-CSE-MsgGUID: eV+WfMCJQy6c9MghH4a2NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689834"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689834"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:39:44 -0800
X-CSE-ConnectionGUID: I1dHo+kSQGaDnrUYcs9Eow==
X-CSE-MsgGUID: xUQf/ZneTdyrNfoRVh6f7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989754"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:39:40 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 47/60] i386/tdx: Implement adjust_cpuid_features() for TDX
Date: Tue,  5 Nov 2024 01:23:55 -0500
Message-Id: <20241105062408.3533704-48-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

1. QEMU's support for Intel PT is borken in general, thus doesn't
   support for TDX.

2. Only limited KVM PV features are supported for TD guest.

3. Drop the AMD specific bits that are reserved on Intel platform.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 9dcb77e011bd..ba723db92bfe 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -33,6 +33,8 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#include "standard-headers/asm-x86/kvm_para.h"
+
 #define TDX_MIN_TSC_FREQUENCY_KHZ   (100 * 1000)
 #define TDX_MAX_TSC_FREQUENCY_KHZ   (10 * 1000 * 1000)
 
@@ -41,6 +43,14 @@
 #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
 #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
 
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
@@ -436,6 +446,39 @@ static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
     }
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
@@ -781,4 +824,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->cpu_realizefn = tdx_cpu_realizefn;
+    x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
 }
-- 
2.34.1


