Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D5DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFy-0005Pm-5f; Mon, 05 Aug 2024 02:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFm-0004QB-2f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:36 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarFj-0002FJ-Fm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839491; x=1754375491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+gTPb7kGR/A9WlIO3Qas3Y/8henOtiHRKV6x1G6ILnU=;
 b=N/cEqF6wsY4nkSx3Ri/eQM7RZoKkypiLfiCGl/j/SKnwV1nhQKpwbjTp
 GPf8PMzEIvc4+0At/ZdwGN3GAv4FYwh6az2fzM8Pn5x47v+wFLp8DUfUJ
 i0Vt7iyssHyNwA3PyFzxAyVzw0jOZJ8+Bsko8Zw4bduP70WciKrrxjwH5
 YAeBWVx9uI1uCKL1l2w9DHXEM9+unB+QDxCHOcoHzVDY4CMA4dLLPZFpx
 8XFPh8Tl2NxD8Dk1Z1ZFYvKpS/cfZsTWKXKgvxY24Xj2QJfqOjGPzJQxh
 xL1nv06NLVFaFGN7Nqfj+vv6rAodLSGlhjSfb+HozecI49I3a1EA3R7so w==;
X-CSE-ConnectionGUID: Wd+1EXyISaClsvr8h/pYtw==
X-CSE-MsgGUID: vof6zuwbQ5+6yCinxNpRIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282934"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282934"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:27 -0700
X-CSE-ConnectionGUID: ZkXQbJ9ARaOca9OKR20anw==
X-CSE-MsgGUID: q/XYb0LFTa+YzFz2dbx/TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56787193"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:31:23 -0700
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
Subject: [PATCH v2 17/17] tests/qtest: Add intel-iommu test
Date: Mon,  5 Aug 2024 14:27:27 +0800
Message-Id: <20240805062727.2307552-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 MAINTAINERS                    |  1 +
 include/hw/i386/intel_iommu.h  |  1 +
 tests/qtest/intel-iommu-test.c | 70 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 4 files changed, 73 insertions(+)
 create mode 100644 tests/qtest/intel-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e34c2bd4cd..c9a2321f1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3673,6 +3673,7 @@ S: Supported
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
index 2f0d3ef080..76d183df74 100644
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


