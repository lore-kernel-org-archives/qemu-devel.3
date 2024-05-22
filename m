Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412A7C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fSK-0006lT-5j; Wed, 22 May 2024 02:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fRY-0006B9-Mk
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:27:24 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fRV-0006jy-Cm
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359237; x=1747895237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XbvGY/yne5qZRRsCJ3DXqnpyiiOKvycEPODgYdQNGng=;
 b=KGlFWB9OXKiT36X85rfIaEwagZVNEpANZuo9g6bs82od/RBion+fWBdF
 Gj+O9jr3+H4l1wB1nsNQqg98V6jzAAT+GUHJaVnXHPOSeC1Xp9nmRiFmn
 eSilgzzOlftm/px1eu0O9eTDfdwpFneiZUq8My+CkwmX6kOMxRJfnLQKY
 H0EPn3SzleM64QZRX3NHYrE0D99qsOWT/Z3QbB59NVI97xvlT7ZHzfyaV
 AE+EUbewYn88511qcKIoUUdAf6urWnjVdY6Qmm1c5kWoLv+2dbAAZx4Rp
 cF1VwaPXndAr4Y+SEj2psRhgVKDYBCArZrfb2c7pOV0wTsAvTS1xWC66L A==;
X-CSE-ConnectionGUID: puCGhZElRbew4Qux4MF3OA==
X-CSE-MsgGUID: AVsgMcb/Sum/LAEx0rYrbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972807"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972807"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:27:16 -0700
X-CSE-ConnectionGUID: 7Tb3TMLsTbW7HlXetnm/mw==
X-CSE-MsgGUID: YUO8KYBgQyumG4tl7z/J8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33598064"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:27:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH rfcv2 17/17] tests/qtest: Add intel-iommu test
Date: Wed, 22 May 2024 14:23:13 +0800
Message-Id: <20240522062313.453317-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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
 tests/qtest/intel-iommu-test.c | 63 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 3 files changed, 65 insertions(+)
 create mode 100644 tests/qtest/intel-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dab60bd04..f1ef6128c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
+F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
new file mode 100644
index 0000000000..e1273bce14
--- /dev/null
+++ b/tests/qtest/intel-iommu-test.c
@@ -0,0 +1,63 @@
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
+#include "libqtest-single.h"
+#include "hw/i386/intel_iommu_internal.h"
+
+#define vtd_reg_readl(offset)    (readq(Q35_HOST_BRIDGE_IOMMU_ADDR + offset))
+#define CAP_MODERN_FIXED1    (VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | \
+                              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS)
+#define ECAP_MODERN_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IRO | VTD_ECAP_MHMV | \
+                              VTD_ECAP_SMTS | VTD_ECAP_FLTS)
+
+static void test_intel_iommu_modern(void)
+{
+    uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
+    uint8_t post_reset_csr[DMAR_REG_SIZE];     /* register values */
+    uint64_t cap, ecap, tmp;
+
+    qtest_start("-M q35 -device intel-iommu,x-scalable-mode=modern");
+
+    g_assert(vtd_reg_readl(DMAR_VER_REG) == 0x30);
+
+    cap = vtd_reg_readl(DMAR_CAP_REG);
+    g_assert((cap & CAP_MODERN_FIXED1) == CAP_MODERN_FIXED1);
+
+    tmp = cap & VTD_CAP_SAGAW_MASK;
+    g_assert(tmp == (VTD_CAP_SAGAW_39bit | VTD_CAP_SAGAW_48bit));
+
+    tmp = VTD_MGAW_FROM_CAP(cap);
+    g_assert(tmp == VTD_HOST_AW_48BIT - 1);
+
+    ecap = vtd_reg_readl(DMAR_ECAP_REG);
+    g_assert((ecap & ECAP_MODERN_FIXED1) == ECAP_MODERN_FIXED1);
+    g_assert(ecap & VTD_ECAP_IR);
+
+    memread(Q35_HOST_BRIDGE_IOMMU_ADDR, init_csr, DMAR_REG_SIZE);
+
+    qobject_unref(qmp("{ 'execute': 'system_reset' }"));
+    qmp_eventwait("RESET");
+
+    memread(Q35_HOST_BRIDGE_IOMMU_ADDR, post_reset_csr, DMAR_REG_SIZE);
+    /* Ensure registers are consistent after hard reset */
+    g_assert(!memcmp(init_csr, post_reset_csr, DMAR_REG_SIZE));
+
+    qtest_end();
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
index 6f2f594ace..09106739d2 100644
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


