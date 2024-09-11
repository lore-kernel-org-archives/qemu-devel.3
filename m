Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C83CEE020B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFst-0006Ye-1I; Wed, 11 Sep 2024 01:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFsq-0006Dl-Lb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:27:16 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFso-0004Mp-Ef
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726032435; x=1757568435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bZWcEWPUvXrW2dfLoI2QO7d604JqxTuRIvII2jmDh/U=;
 b=dGLQbRcRLy94vD82Eod0NZXJBopqwgUmZdq181tcVc0Oas0Mx5zfxNvz
 46+qcbOfBbrt6Lpu121rLfIlM8NwcTEFXNQtdYuAxNJpgkX7J4zohwCvm
 SYphcz2yns1bAaCLDnm2rWma1n1zOWVGp6GlUwGOD+9r4N+gDOp3yh62z
 PXQNN1Zvur7PdXHHCJDiX329RxFGIMRYj9R+5J2OHlP4iBmvmLdCnVBIW
 dpNqjEQ0jitzQeGlA/Dd1lTxWAkuSpWL6bZdI7cMG00LP6HE1xfC2gTST
 2MgsHaTn0zP1xs/kYgdetQWncRH57XqrCHVnbskUmcEMwwxjhG5I9sWhk Q==;
X-CSE-ConnectionGUID: rz0e0roqRr2XSeO31Js2kA==
X-CSE-MsgGUID: bTPJ1ESET2ypAujKjxtj/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35403642"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="35403642"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:27:14 -0700
X-CSE-ConnectionGUID: eAjBiPkUSeuEObiY7mJ7Rg==
X-CSE-MsgGUID: hCxTUM93R2KKiMoGQKT9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="67536578"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:27:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 17/17] tests/qtest: Add intel-iommu test
Date: Wed, 11 Sep 2024 13:22:55 +0800
Message-Id: <20240911052255.1294071-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 MAINTAINERS                    |  1 +
 include/hw/i386/intel_iommu.h  |  1 +
 tests/qtest/intel-iommu-test.c | 70 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 4 files changed, 73 insertions(+)
 create mode 100644 tests/qtest/intel-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1bc69828..120e8b86e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3690,6 +3690,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
+F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index f6d9b41b80..0c9bb8eab6 100644
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
index 0000000000..fa9169f1a3
--- /dev/null
+++ b/tests/qtest/intel-iommu-test.c
@@ -0,0 +1,70 @@
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
+#define ECAP_MODERN_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IR | VTD_ECAP_IRO | \
+                              VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FLTS)
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
index fc852f3d8b..826e967a81 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -80,6 +80,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
2.34.1


