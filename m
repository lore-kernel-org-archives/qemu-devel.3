Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8176AC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvW-0003mY-Uz; Fri, 24 Jan 2025 08:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJv3-0001bg-5G
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:24 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuz-0003xi-L6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726018; x=1769262018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HJDg2gNrnTLyeXcVYWNvxi1qJesg421w8qhKg61bf0I=;
 b=DynKI5oP3llwF88zeYyWv1V0NPwVWZ9pWw2cntPHdy/wij2XAdevV3ZK
 JKAE8NsT11v0vRif2uJjl2RhDKy+n5/YGhCPUDjc8WqDjQSOM3bWljv3A
 tdWeswUeAm5xUUjT9F0urUd/mFtdz8mAOGw4la4BMU+SKAKUz4afiKCUd
 FBy6AVzPRwiSJbpatmjYxqPdYSnfdkPQjNxgrkoYKRQNIYjV31XSIdw79
 czmdVEUyeC8BSmwjs9PO7MwTdHnJQN1O4zGIBFskDLeRuT9dp9OunbpUM
 Juh5fTNmxINrQE5xNtfwz/eIcPQxSDf8Q3XTVUGWJurv5byfI4rsFUbH3 Q==;
X-CSE-ConnectionGUID: hHjh1L5xSICZt7igp0xPdA==
X-CSE-MsgGUID: 812phNGdQtiZjGi9t7+YWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246608"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246608"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:55 -0800
X-CSE-ConnectionGUID: LG/CYRvYQkyYkHJ10JL3Qg==
X-CSE-MsgGUID: jYYsE2hrSvyw1W0v3/j+pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804472"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:51 -0800
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
Subject: [PATCH v7 46/52] i386/tdx: Mark the configurable bit not reported by
 KVM as unsupported
Date: Fri, 24 Jan 2025 08:20:42 -0500
Message-Id: <20250124132048.3229049-47-xiaoyao.li@intel.com>
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

There is no interface in KVM to report the support bits of TD guest.
QEMU has to maintain the knowledge itself. E.g., fixed0 and fixed1 are
already hardcoded in tdx_fixed0_bits and tdx_fixed1_bits.

For configurable bits, KVM might filer some due to KVM lacks the support
currently. The filtered bits need to be marked as unsupported as well.
However, there is no interface to report which configurable bit is
turned unconfigurable.

Maintain the configurable bits of TDX module in QEMU and compare with
KVM reported configurable to find the ones being turned unconfigurable
by KVM and mark them as unsupported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 61 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index b46e581bb40e..2b9a47020934 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -529,6 +529,50 @@ KvmCpuidInfo tdx_fixed1_bits = {
     },
 };
 
+/* TDX module 1.5.08.04.0784 on EMR */
+KvmCpuidInfo tdx_configurable_bits = {
+    .cpuid.nent = 6,
+    .entries[0] = {
+        .function = 0x1,
+        .index = 0,
+        .eax = 0x0fff3fff,
+        .ebx = 0x00ff0000,
+        .ecx = 0x31044988,
+        .edx = 0xb8400000,
+    },
+    .entries[1] = {
+        .function = 0x7,
+        .index = 0,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .ebx = 0xd02b9b18,
+        .ecx = 0x02417f64,
+        .edx = 0x00054010,
+    },
+    .entries[2] = {
+        .function = 0x7,
+        .index = 0x1,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .eax = 0x00001c30,
+    },
+    .entries[3] = {
+        .function = 0x7,
+        .index = 0x2,
+        .flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX,
+        .edx = 0x00000008,
+    },
+    .entries[4] = {
+        .function = 0x1c,
+        .index = 0x0,
+        .eax = 0x0000000b,
+    },
+    .entries[5] = {
+        .function = 0x80000008,
+        .index = 0,
+        .eax = 0x000000ff,
+        .ebx = 0x00000200,
+    },
+};
+
 typedef struct TdxAttrsMap {
     uint32_t attr_index;
     uint32_t cpuid_leaf;
@@ -621,7 +665,7 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                           uint32_t feature, uint32_t index,
                                           int reg, uint32_t value)
 {
-    struct kvm_cpuid_entry2 *e;
+    struct kvm_cpuid_entry2 *e, *e1;
     uint32_t fixed0, fixed1;
 
     switch (feature) {
@@ -653,6 +697,21 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
     tdx_mask_cpuid_by_attrs(feature, index, reg, &value);
     tdx_mask_cpuid_by_xfam(feature, index, reg, &value);
 
+    e = cpuid_find_entry(&tdx_caps->cpuid, feature, index);
+    if (e) {
+        e1 = cpuid_find_entry(&tdx_configurable_bits.cpuid, feature, index);
+        if (e1) {
+            uint32_t kvm_configurable = cpuid_entry_get_reg(e, reg);
+            uint32_t tdx_module_configurable = cpuid_entry_get_reg(e1, reg);
+            for (int i = 0; i < 32; i++) {
+                uint32_t f = 1U << i;
+                if (f & tdx_module_configurable && !(f & kvm_configurable)) {
+                    value &= ~f;
+                }
+            }
+        }
+    }
+
     e = cpuid_find_entry(&tdx_fixed0_bits.cpuid, feature, index);
     if (e) {
         fixed0 = cpuid_entry_get_reg(e, reg);
-- 
2.34.1


