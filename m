Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB41CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLemg-0007fl-4z; Thu, 12 Dec 2024 03:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLemc-0007Jt-HO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:54 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLema-00084H-MA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992973; x=1765528973;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8GE0LggHTsIuspUoT4zHyBsrduJ7RB0n9u9Dborexeg=;
 b=THYTpMeb9r5O716d0gl1lubuZefflFMtOi8Zz3gvF206Axj7HtCEl2SL
 DYtxhaqp7OFTDEbQrUYwdG+b2fjf5iXOXXhHraylksCGzAoPkRkXx2zZJ
 idql3zB2etjMbsN+Lw7HI/QnBidSytuFWUoWWyJOas8SFjk08pO3XMuL8
 4UQnHdTp7rlxegm4fLyt62xTeHAMYxzVYqzI3I6p3XdiGjD/CrxXhmtPN
 q6yoEVjfzMovTjmJlVa+pmV1I1FsKWeQDYM784WMSHaKsUZGViIIhV21m
 jHJXw7jtf7K+Pq5HSHjjmXx3ubQ60KI+KWuroTWIQNCr78oZhS0IaYP7Q Q==;
X-CSE-ConnectionGUID: mVAi+tckSfuStF0oNubu6w==
X-CSE-MsgGUID: iaGOvuSbTACcA5zBDJYeXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34125061"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34125061"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:42 -0800
X-CSE-ConnectionGUID: 9UBvIMXeQgGDIVC4SW2x5Q==
X-CSE-MsgGUID: SpfUys3sTFC0ah3xnsxbMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407261"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 20/20] tests/qtest: Add intel-iommu test
Date: Thu, 12 Dec 2024 16:37:57 +0800
Message-Id: <20241212083757.605022-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently only tested cap/ecap bits correctness when x-flts=on in scalable
mode. Also tested cap/ecap bits consistency before and after system reset.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS                    |  1 +
 include/hw/i386/intel_iommu.h  |  1 +
 tests/qtest/intel-iommu-test.c | 64 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  1 +
 4 files changed, 67 insertions(+)
 create mode 100644 tests/qtest/intel-iommu-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a21..62fddaccd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3674,6 +3674,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
+F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 9e92bffd5a..e95477e855 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
 #define VTD_HOST_AW_48BIT           48
 #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_48BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
+#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
 
 #define DMAR_REPORT_F_INTR          (1)
 
diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
new file mode 100644
index 0000000000..c521b3796e
--- /dev/null
+++ b/tests/qtest/intel-iommu-test.c
@@ -0,0 +1,64 @@
+/*
+ * QTest testcase for intel-iommu
+ *
+ * Copyright (c) 2024 Intel, Inc.
+ *
+ * Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/i386/intel_iommu_internal.h"
+
+#define CAP_STAGE_1_FIXED1    (VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | \
+                              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS)
+#define ECAP_STAGE_1_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IR | VTD_ECAP_IRO | \
+                              VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FLTS)
+
+static inline uint64_t vtd_reg_readq(QTestState *s, uint64_t offset)
+{
+    return qtest_readq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
+}
+
+static void test_intel_iommu_stage_1(void)
+{
+    uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
+    uint8_t post_reset_csr[DMAR_REG_SIZE];     /* register values */
+    uint64_t cap, ecap, tmp;
+    QTestState *s;
+
+    s = qtest_init("-M q35 -device intel-iommu,x-scalable-mode=on,x-flts=on");
+
+    cap = vtd_reg_readq(s, DMAR_CAP_REG);
+    g_assert((cap & CAP_STAGE_1_FIXED1) == CAP_STAGE_1_FIXED1);
+
+    tmp = cap & VTD_CAP_SAGAW_MASK;
+    g_assert(tmp == (VTD_CAP_SAGAW_39bit | VTD_CAP_SAGAW_48bit));
+
+    tmp = VTD_MGAW_FROM_CAP(cap);
+    g_assert(tmp == VTD_HOST_AW_48BIT - 1);
+
+    ecap = vtd_reg_readq(s, DMAR_ECAP_REG);
+    g_assert((ecap & ECAP_STAGE_1_FIXED1) == ECAP_STAGE_1_FIXED1);
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
+    qtest_add_func("/q35/intel-iommu/stage-1", test_intel_iommu_stage_1);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 89db3ecf2f..72d1b191c6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -93,6 +93,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
2.34.1


