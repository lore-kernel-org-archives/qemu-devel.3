Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C303CC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJvN-0002cW-Ag; Fri, 24 Jan 2025 08:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJv3-0001bh-5T
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:25 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJuz-00041c-Li
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726018; x=1769262018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MtLjr/vDOT3CoWD5owRZWIVQtD1iwql3z/OowZZmgx4=;
 b=cihUpnqVAZlEZA6HdWOKnwMrKLg2XEXqHV5TIrgt+7Y8xP+4JJWrD8sC
 pY8tSmmdFjEg1w3mNCb7sAqIw9aUR2vjN+y3jJ1QVjM6aSD8OPXikwwSG
 yOZ3Y6NqovwDAgSfHEc1y+DyxrGqGTFK6/+cJ3RB2GafdWaSiiR7NTEOk
 vM3ap7bwQaQZ/2XLbjpDkAq4DqdLgAaAxljuKf/FPKPs/1Oi804SK5G2R
 oENYWNl+po4jUY4Lej7p5hPhKgRRwAgRWgbiW9XGOLg7ULxXUvJATxftl
 zDIldmj05BtIJR4U1vyuQRf7mvkfp1mgd5qlmm5teJ1wXz0nen7553PON w==;
X-CSE-ConnectionGUID: DY3zV5F0TUWowXAkm6g4Uw==
X-CSE-MsgGUID: R6YtLiI2QoGljoeERvGPpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246600"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246600"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:39:51 -0800
X-CSE-ConnectionGUID: 2caIy9gBT8q37pJ029fZIg==
X-CSE-MsgGUID: bGDRdGsuR5WmR5zvmRHLNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804467"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:39:47 -0800
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
Subject: [PATCH v7 45/52] i386/tdx: Mask off CPUID bits by unsupported XFAM
Date: Fri, 24 Jan 2025 08:20:41 -0500
Message-Id: <20250124132048.3229049-46-xiaoyao.li@intel.com>
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

Mask off the CPUID bits as unsupported if its matched XFAM bit is
not supported. Otherwise, it might fail the check in setup_td_xfam() as
unsupported XFAM being requested.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 3997a439f054..b46e581bb40e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -22,6 +22,8 @@
 
 #include <linux/kvm_para.h>
 
+#include "cpu.h"
+#include "cpu-internal.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf.h"
@@ -579,6 +581,42 @@ static void tdx_mask_cpuid_by_attrs(uint32_t feature, uint32_t index,
     }
 }
 
+static void tdx_mask_cpuid_by_xfam(uint32_t feature, uint32_t index,
+                                          int reg, uint32_t *value)
+{
+    const FeatureWordInfo *f;
+    const ExtSaveArea *esa;
+    uint64_t unavail = 0;
+    int i;
+
+    assert(tdx_caps);
+
+    for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        if ((1ULL << i) & tdx_caps->supported_xfam) {
+            continue;
+        }
+
+        if (!((1ULL << i) & CPUID_XSTATE_MASK)) {
+            continue;
+        }
+
+        esa = &x86_ext_save_areas[i];
+        f = &feature_word_info[esa->feature];
+        assert(f->type == CPUID_FEATURE_WORD);
+        if (f->cpuid.eax != feature ||
+            (f->cpuid.needs_ecx && f->cpuid.ecx != index) ||
+            f->cpuid.reg != reg) {
+            continue;
+        }
+
+        unavail |= esa->bits;
+    }
+
+    if (unavail) {
+        *value &= ~unavail;
+    }
+}
+
 static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
                                           uint32_t feature, uint32_t index,
                                           int reg, uint32_t value)
@@ -613,6 +651,7 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
     }
 
     tdx_mask_cpuid_by_attrs(feature, index, reg, &value);
+    tdx_mask_cpuid_by_xfam(feature, index, reg, &value);
 
     e = cpuid_find_entry(&tdx_fixed0_bits.cpuid, feature, index);
     if (e) {
-- 
2.34.1


