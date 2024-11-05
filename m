Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE03CD1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DH4-0005lK-B9; Tue, 05 Nov 2024 01:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEh-0003Ul-F3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:28 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DEa-0001w0-9p
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788812; x=1762324812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+RyN2ozpNF9/qWmSSJyynxhc2IsEJ+Gu8thAMTAlGko=;
 b=bpMcBrIaEuS8eG15sHJprjKq2P/bCUlxHliBH1377vHEKWzclQGFzWG9
 7Ho8OFrRnFFRiiBCIfwe3U0yNXFvizn3yb9m2WViIzN8op0T5DsWs+BV6
 mlvWTBOsdFHRn3hiMk+z7H3ArsxWUBBVBZZAizMWrb1ghYKI3kGjU6P1Y
 dPcb+PjEBM++Aqhv3hk8n93NbJstzuccIrs9GjK7U1YoWThq0trdyT+VL
 US1muR3I2LtqWNFMrk/M1G0I79eAu1PiAKlDFsSA7tZitLKWey9kVqRUy
 VqkdKRyTFKirWAKP/7Xqo26QlGFOY/QYGzR4f29DZmnmhWQLBJREDqrTJ Q==;
X-CSE-ConnectionGUID: DIy7Jf1WQEmj/lS1URSlxg==
X-CSE-MsgGUID: +y/VQ/3PQ62KA4QHNm9KtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689872"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689872"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:01 -0800
X-CSE-ConnectionGUID: 5jqpsLxmSO+hY5dQHtlrcg==
X-CSE-MsgGUID: fhbU8dw3QlKkdGhUX6WkBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989877"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:39:57 -0800
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
Subject: [PATCH v6 51/60] i386/tdx: Mask off CPUID bits by unsupported XFAM
Date: Tue,  5 Nov 2024 01:23:59 -0500
Message-Id: <20241105062408.3533704-52-xiaoyao.li@intel.com>
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

Mask off the CPUID bits as unsupported if its matched XFAM bit is
not supported. Otherwise, it might fail the check in setup_td_xfam() as
unsupported XFAM being requested.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 5ac5f93907ca..e7e0f073dfc9 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -24,6 +24,7 @@
 #include <linux/kvm_para.h>
 
 #include "cpu.h"
+#include "cpu-internal.h"
 #include "host-cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
@@ -585,6 +586,42 @@ static void tdx_mask_cpuid_by_attrs(uint32_t feature, uint32_t index,
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
@@ -619,6 +656,7 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
     }
 
     tdx_mask_cpuid_by_attrs(feature, index, reg, &value);
+    tdx_mask_cpuid_by_xfam(feature, index, reg, &value);
 
     e = cpuid_find_entry(&tdx_fixed0_bits.cpuid, feature, index);
     if (e) {
-- 
2.34.1


