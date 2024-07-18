Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D3C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMNV-0002S5-NL; Thu, 18 Jul 2024 04:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMNU-0002KE-8N
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:40 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMNS-0000CX-1N
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290838; x=1752826838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AoLX8HFE3w/BD0OMdXc1OoNCpqFuQPd3XHk/vD1Hxt8=;
 b=EuQY0yUTjCTEm0D3lYw3745UCtrJ5vlWmw0MXo3JY7WX/GnGKzdvlB0c
 Ke1U2/LH/RtmAlgEsQ5vNYkGcGZK9XKdpaAkrZLvMWal1WiYCHuisHUsu
 wtvJAPcKKJKxgcIsrsUEriFmpdpgytwICYL+HkZXpjl1MfDWLXbm88rtu
 GqdAdp6b7XVcp0DTKtTmsnXbyyxVjz4Io23qSe+Y8t7H7KkqwDVEWYI1P
 7RFveFrjfrOSJ9+MgIHj3uRzDbhs80wQo9NAlk7v4D4fDVWfxee6FrLrt
 /Awc04NsVcDyf+Z7Z8tcCyyslM8dvhJQVHXMvijM0VL+8ZJs3YGkrkvli A==;
X-CSE-ConnectionGUID: H0oO9eh4S/aT1fiQR75dog==
X-CSE-MsgGUID: yJhZBMvrQu2TSIVxcHiXug==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996430"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996430"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:37 -0700
X-CSE-ConnectionGUID: m90X9qSMTCGkhDvmJxNxVA==
X-CSE-MsgGUID: 98aWQuVbRZOM9R2AyuKvGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717620"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:32 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 17/17] tests/qtest: Add intel-iommu test
Date: Thu, 18 Jul 2024 16:16:36 +0800
Message-Id: <20240718081636.879544-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add the framework to test the intel-iommu device.

Currently only tested cap/ecap bits correctness in scalable
modern mode. Also tested cap/ecap bits consistency before
and after system reset.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                    |  1 +
 include/hw/i386/intel_iommu.h  |  1 +
 tests/qtest/intel-iommu-test.c | 71 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 4 files changed, 74 insertions(+)
 create mode 100644 tests/qtest/intel-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..ec765bf3d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3662,6 +3662,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
+F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 650641544c..b1848dbec6 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define VTD_HOST_AW_48BIT           48
 #define VTD_HOST_AW_AUTO            0xff
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
+#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
 
 #define DMAR_REPORT_F_INTR          (1)
 
diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
new file mode 100644
index 0000000000..8e07034f6f
--- /dev/null
+++ b/tests/qtest/intel-iommu-test.c
@@ -0,0 +1,71 @@
+/*
+ * QTest testcase for intel-iommu
+ *
+ * Copyright (c) 2024 Intel, Inc.
+ *
+ * Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/i386/intel_iommu_internal.h"
+
+#define CAP_MODERN_FIXED1    (VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | \
+                              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS)
+#define ECAP_MODERN_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IRO | VTD_ECAP_MHMV | \
+                              VTD_ECAP_SMTS | VTD_ECAP_FLTS)
+
+static inline uint32_t vtd_reg_readl(QTestState *s, uint64_t offset)
+{
+    return qtest_readl(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
+}
+
+static inline uint64_t vtd_reg_readq(QTestState *s, uint64_t offset)
+{
+    return qtest_readq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
+}
+
+static void test_intel_iommu_modern(void)
+{
+    uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
+    uint8_t post_reset_csr[DMAR_REG_SIZE];     /* register values */
+    uint64_t cap, ecap, tmp;
+    QTestState *s;
+
+    s = qtest_init("-M q35 -device intel-iommu,x-scalable-mode=modern");
+
+    cap = vtd_reg_readq(s, DMAR_CAP_REG);
+    g_assert((cap & CAP_MODERN_FIXED1) == CAP_MODERN_FIXED1);
+
+    tmp = cap & VTD_CAP_SAGAW_MASK;
+    g_assert(tmp == (VTD_CAP_SAGAW_39bit | VTD_CAP_SAGAW_48bit));
+
+    tmp = VTD_MGAW_FROM_CAP(cap);
+    g_assert(tmp == VTD_HOST_AW_48BIT - 1);
+
+    ecap = vtd_reg_readq(s, DMAR_ECAP_REG);
+    g_assert((ecap & ECAP_MODERN_FIXED1) == ECAP_MODERN_FIXED1);
+    g_assert(ecap & VTD_ECAP_IR);
+
+    qtest_memread(s, Q35_HOST_BRIDGE_IOMMU_ADDR, init_csr, DMAR_REG_SIZE);
+
+    qobject_unref(qtest_qmp(s, "{ 'execute': 'system_reset' }"));
+    qtest_qmp_eventwait(s, "RESET");
+
+    qtest_memread(s, Q35_HOST_BRIDGE_IOMMU_ADDR, post_reset_csr, DMAR_REG_SIZE);
+    /* Ensure registers are consistent after hard reset */
+    g_assert(!memcmp(init_csr, post_reset_csr, DMAR_REG_SIZE));
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/intel-iommu/modern", test_intel_iommu_modern);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6508bfb1a2..20d05d471b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -79,6 +79,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
2.34.1


