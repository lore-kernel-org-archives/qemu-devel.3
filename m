Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042A5C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYqA-0004UQ-Iq; Fri, 03 Jul 2026 04:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYq0-0004Ra-NB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:33 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wfYpy-0001gX-R1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783065687; x=1814601687;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bYXimPDPjWx48lnFAG4DCzOY+K7yAnsmiKAMaq78rzw=;
 b=ZBOvqPk6CR6mJXzhkJF1SWSUHmM0htlHESB5pLU8ARSTBQN5zDsUosm/
 nj4+cSub7NqrLSJCokBU41wquNdxbLepqnJO+S+WnMJpU0U+6iHxTu90Q
 fYpLD15t2UYqfty/fKstA+BnV6oc1gx/sPLkYadu9ces2vGmuzkDtZ2l2
 SXUQntAeQQBX6TuE2GJrnqQyzQzmEzWZSDK5ZVunj9gPmGNcNPd1YvcF6
 WH9QNfM+NVamDkFE9/HdGs60KinkvzA8SR613dl3eCq1pbjH2Fx9qg2nm
 7hysHNzMRJ8kcGSCngJYE36AtExZ/y1fTVvlTBazX9PLJhzCbOFjfoXTd Q==;
X-CSE-ConnectionGUID: ij22QdCaRbiEsXh7dBDgAQ==
X-CSE-MsgGUID: 5/yuup/mR4yNqmUxM64fBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94464656"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94464656"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:26 -0700
X-CSE-ConnectionGUID: 3Ox7USkoRkG/2oOsB9nnKA==
X-CSE-MsgGUID: UfBClxU5QuqKcgL0QeNliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="277379553"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:01:23 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fengyuan Yu <15fengyuan@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, junjie.cao@intel.com
Subject: [PATCH v1 1/3] tests/qtest/libqos: share Intel IOMMU test setup
 helpers
Date: Fri,  3 Jul 2026 15:21:56 +0800
Message-ID: <20260703072200.463082-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703072200.463082-1-junjie.cao@intel.com>
References: <20260703072200.463082-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

iommu-intel-test.c keeps the iommu-testdev PCI setup (save_fn(),
setup_qtest_pci_device()) and the VT-d command-line / capability
helpers (qvtd_iommu_args(), qvtd_check_caps()) as file-local statics.
A second Intel IOMMU test would have to copy them, which defeats the
purpose of the shared qos-intel-iommu module.

Move them into qos-intel-iommu so sibling tests can reuse them:
save_fn() becomes qvtd_save_pci_dev() and setup_qtest_pci_device()
becomes qvtd_setup_qtest_pci_device(); qvtd_iommu_args() and
qvtd_check_caps() keep their names.

No functional change: iommu-intel-test now calls the public
qvtd_setup_qtest_pci_device() instead of its file-local copy.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/iommu-intel-test.c       | 78 +---------------------------
 tests/qtest/libqos/qos-intel-iommu.c | 77 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h | 23 ++++++++
 3 files changed, 101 insertions(+), 77 deletions(-)

diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
index 703bbfef73..c2744def6f 100644
--- a/tests/qtest/iommu-intel-test.c
+++ b/tests/qtest/iommu-intel-test.c
@@ -24,82 +24,6 @@ static uint64_t intel_iommu_expected_gpa(uint64_t iova)
     return (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (iova & 0xfff);
 }
 
-static void save_fn(QPCIDevice *dev, int devfn, void *data)
-{
-    QPCIDevice **pdev = (QPCIDevice **) data;
-
-    *pdev = dev;
-}
-
-static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
-                                          QPCIBar *bar)
-{
-    QPCIDevice *dev = NULL;
-
-    *pcibus = qpci_new_pc(qts, NULL);
-    g_assert(*pcibus != NULL);
-
-    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
-                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
-
-    g_assert(dev);
-    qpci_device_enable(dev);
-    *bar = qpci_iomap(dev, 0, NULL);
-    g_assert_false(bar->is_io);
-
-    return dev;
-}
-
-static const char *qvtd_iommu_args(QVTDTransMode mode)
-{
-    switch (mode) {
-    case QVTD_TM_SCALABLE_FLT:
-        return "-device intel-iommu,scalable-mode=on,fsts=on ";
-    case QVTD_TM_SCALABLE_PT:
-    case QVTD_TM_SCALABLE_SLT:
-        return "-device intel-iommu,scalable-mode=on ";
-    default:
-        return "-device intel-iommu ";
-    }
-}
-
-static bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
-{
-    uint64_t ecap = qtest_readq(qts,
-                                Q35_HOST_BRIDGE_IOMMU_ADDR + DMAR_ECAP_REG);
-
-    /* All scalable modes require SMTS */
-    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
-        g_test_skip("ECAP.SMTS not supported");
-        return false;
-    }
-
-    switch (mode) {
-    case QVTD_TM_SCALABLE_PT:
-        if (!(ecap & VTD_ECAP_PT)) {
-            g_test_skip("ECAP.PT not supported");
-            return false;
-        }
-        break;
-    case QVTD_TM_SCALABLE_SLT:
-        if (!(ecap & VTD_ECAP_SSTS)) {
-            g_test_skip("ECAP.SSTS not supported");
-            return false;
-        }
-        break;
-    case QVTD_TM_SCALABLE_FLT:
-        if (!(ecap & VTD_ECAP_FSTS)) {
-            g_test_skip("ECAP.FSTS not supported");
-            return false;
-        }
-        break;
-    default:
-        break;
-    }
-
-    return true;
-}
-
 static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
 {
     QTestState *qts;
@@ -124,7 +48,7 @@ static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
     }
 
     /* Setup and configure IOMMU-testdev PCI device */
-    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
+    dev = qvtd_setup_qtest_pci_device(qts, &pcibus, &bar);
     g_assert(dev);
 
     g_test_message("### Intel IOMMU translation mode=%d ###", cfg->trans_mode);
diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos-intel-iommu.c
index f8ca4c871b..4095ac0917 100644
--- a/tests/qtest/libqos/qos-intel-iommu.c
+++ b/tests/qtest/libqos/qos-intel-iommu.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/i386/intel_iommu_internal.h"
 #include "tests/qtest/libqos/pci.h"
+#include "tests/qtest/libqos/pci-pc.h"
 #include "qos-iommu-testdev.h"
 #include "qos-intel-iommu.h"
 
@@ -452,3 +453,79 @@ void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
         }
     }
 }
+
+const char *qvtd_iommu_args(QVTDTransMode mode)
+{
+    switch (mode) {
+    case QVTD_TM_SCALABLE_FLT:
+        return "-device intel-iommu,scalable-mode=on,fsts=on ";
+    case QVTD_TM_SCALABLE_PT:
+    case QVTD_TM_SCALABLE_SLT:
+        return "-device intel-iommu,scalable-mode=on ";
+    default:
+        return "-device intel-iommu ";
+    }
+}
+
+bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
+{
+    uint64_t ecap = qtest_readq(qts,
+                                Q35_HOST_BRIDGE_IOMMU_ADDR + DMAR_ECAP_REG);
+
+    /* All scalable modes require SMTS */
+    if (qvtd_is_scalable(mode) && !(ecap & VTD_ECAP_SMTS)) {
+        g_test_skip("ECAP.SMTS not supported");
+        return false;
+    }
+
+    switch (mode) {
+    case QVTD_TM_SCALABLE_PT:
+        if (!(ecap & VTD_ECAP_PT)) {
+            g_test_skip("ECAP.PT not supported");
+            return false;
+        }
+        break;
+    case QVTD_TM_SCALABLE_SLT:
+        if (!(ecap & VTD_ECAP_SSTS)) {
+            g_test_skip("ECAP.SSTS not supported");
+            return false;
+        }
+        break;
+    case QVTD_TM_SCALABLE_FLT:
+        if (!(ecap & VTD_ECAP_FSTS)) {
+            g_test_skip("ECAP.FSTS not supported");
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
+
+static void qvtd_save_pci_dev(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **)data;
+
+    *pdev = dev;
+}
+
+QPCIDevice *qvtd_setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                        QPCIBar *bar)
+{
+    QPCIDevice *dev = NULL;
+
+    *pcibus = qpci_new_pc(qts, NULL);
+    g_assert(*pcibus != NULL);
+
+    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
+                        IOMMU_TESTDEV_DEVICE_ID, qvtd_save_pci_dev, &dev);
+
+    g_assert(dev);
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
diff --git a/tests/qtest/libqos/qos-intel-iommu.h b/tests/qtest/libqos/qos-intel-iommu.h
index c6cacc5c3f..dd6f920464 100644
--- a/tests/qtest/libqos/qos-intel-iommu.h
+++ b/tests/qtest/libqos/qos-intel-iommu.h
@@ -182,4 +182,27 @@ void qvtd_run_translation_case(QTestState *qts, QPCIDevice *dev,
                                QPCIBar bar, uint64_t iommu_base,
                                const QVTDTestConfig *cfg);
 
+/*
+ * qvtd_iommu_args - Build the -device intel-iommu command-line fragment
+ *                   for the requested translation mode.
+ */
+const char *qvtd_iommu_args(QVTDTransMode mode);
+
+/*
+ * qvtd_check_caps - Check whether the running QEMU exposes the ECAP bits
+ *                   required by @mode.  Calls g_test_skip() and returns
+ *                   false when a required capability is missing.
+ */
+bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode);
+
+/*
+ * qvtd_setup_qtest_pci_device - Create a QPCIBus, locate the iommu-testdev
+ *                               PCI function, enable it and map BAR0.
+ *
+ * On success, *pcibus and *bar are populated and the returned QPCIDevice
+ * must be released by the caller via g_free().
+ */
+QPCIDevice *qvtd_setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                        QPCIBar *bar);
+
 #endif /* QTEST_LIBQOS_INTEL_IOMMU_H */
-- 
2.43.0


