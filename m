Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3300D29C40
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrqy-0005Yy-FD; Mon, 19 Jan 2026 11:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vhrqv-0005WW-E9; Mon, 19 Jan 2026 11:11:41 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vhrqt-00028s-6o; Mon, 19 Jan 2026 11:11:41 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAH6CS0V25panw4Aw--.48494S2;
 Tue, 20 Jan 2026 00:11:32 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX8O2mV25pCfIUAA--.37135S9;
 Tue, 20 Jan 2026 00:11:31 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v9 6/8] tests/qtest: Add libqos iommu-testdev helpers
Date: Tue, 20 Jan 2026 00:11:10 +0800
Message-Id: <20260119161112.3841386-7-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8O2mV25pCfIUAA--.37135S9
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWltPrkFLgAAss
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw4DuF4fZFyDKFWfJrW3trb_yoW7Zr1fpF
 1Uuayag3yxGF4fGrn3Gw10yw1rtr4kAF17uryfGas3ZrWxZry8Jr9rKFyY9r9rX3yUZF1r
 Zan0vFZ5WF1rZaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a libqos helper module for the iommu-testdev
device used by qtests. This module provides some common functions to
all IOMMU test cases using iommu-testdev.

Wire the new sources into tests/qtest/libqos/meson.build so
they are built as part of the qtest support library.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 MAINTAINERS                            |  5 ++
 tests/qtest/libqos/meson.build         |  3 +
 tests/qtest/libqos/qos-iommu-testdev.c | 82 ++++++++++++++++++++++++++
 tests/qtest/libqos/qos-iommu-testdev.h | 43 ++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 tests/qtest/libqos/qos-iommu-testdev.c
 create mode 100644 tests/qtest/libqos/qos-iommu-testdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1abfec594f..ee8f6eb3af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3578,6 +3578,11 @@ F: docs/devel/testing/qtest.rst
 X: tests/qtest/bios-tables-test*
 X: tests/qtest/migration-*
 
+QTest IOMMU helpers
+M: Tao Tang <tangtao1634@phytium.com.cn>
+S: Maintained
+F: tests/qtest/libqos/qos-iommu*
+
 Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
 R: Paolo Bonzini <pbonzini@redhat.com>
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 1ddaf7b095..9805d63a29 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -60,6 +60,9 @@ libqos_srcs = files(
         'x86_64_pc-machine.c',
         'riscv-virt-machine.c',
         'loongarch-virt-machine.c',
+
+        # SMMU:
+        'qos-iommu-testdev.c',
 )
 
 if have_virtfs
diff --git a/tests/qtest/libqos/qos-iommu-testdev.c b/tests/qtest/libqos/qos-iommu-testdev.c
new file mode 100644
index 0000000000..91718a5673
--- /dev/null
+++ b/tests/qtest/libqos/qos-iommu-testdev.c
@@ -0,0 +1,82 @@
+/*
+ * IOMMU test device helpers for libqos qtests
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "../libqtest.h"
+#include "pci.h"
+#include "qos-iommu-testdev.h"
+
+uint32_t qos_iommu_testdev_trigger_dma(QPCIDevice *dev, QPCIBar bar,
+                                       uint64_t iova, uint64_t gpa,
+                                       uint32_t len, uint32_t attrs)
+{
+    uint32_t result = ITD_DMA_RESULT_BUSY;
+
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GVA_LO, (uint32_t)iova);
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GVA_HI, (uint32_t)(iova >> 32));
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GPA_LO, (uint32_t)gpa);
+    qpci_io_writel(dev, bar, ITD_REG_DMA_GPA_HI, (uint32_t)(gpa >> 32));
+    qpci_io_writel(dev, bar, ITD_REG_DMA_LEN, len);
+    qpci_io_writel(dev, bar, ITD_REG_DMA_ATTRS, attrs);
+
+    qpci_io_writel(dev, bar, ITD_REG_DMA_DBELL, ITD_DMA_DBELL_ARM);
+    qpci_io_readl(dev, bar, ITD_REG_DMA_TRIGGERING);
+
+    for (int i = 0; i < 1000; i++) {
+        result = qpci_io_readl(dev, bar, ITD_REG_DMA_RESULT);
+        if (result != ITD_DMA_RESULT_BUSY) {
+            break;
+        }
+        g_usleep(1000);
+    }
+
+    if (result == ITD_DMA_RESULT_BUSY) {
+        return ITD_DMA_ERR_TX_FAIL;
+    }
+
+    return result;
+}
+
+void qos_iommu_testdev_single_translation(const QOSIOMMUTestdevDmaCfg *dma,
+                                          void *opaque,
+                                          QOSIOMMUTestdevSetupFn setup_fn,
+                                          QOSIOMMUTestdevAttrsFn attrs_fn,
+                                          QOSIOMMUTestdevValidateFn validate_fn,
+                                          QOSIOMMUTestdevReportFn report_fn,
+                                          uint32_t *dma_result_out)
+{
+    uint32_t config_result;
+    uint32_t dma_result;
+    uint32_t attrs_val;
+
+    g_assert(dma);
+    g_assert(setup_fn);
+    g_assert(attrs_fn);
+
+    config_result = setup_fn(opaque);
+    g_assert_cmpuint(config_result, ==, 0);
+
+    attrs_val = attrs_fn(opaque);
+    dma_result = qos_iommu_testdev_trigger_dma(dma->dev, dma->bar,
+                                               dma->iova, dma->gpa,
+                                               dma->len, attrs_val);
+    if (dma_result_out) {
+        *dma_result_out = dma_result;
+    }
+
+    if (report_fn) {
+        report_fn(opaque, dma_result);
+    }
+
+    if (validate_fn) {
+        g_assert_true(validate_fn(opaque));
+    }
+}
diff --git a/tests/qtest/libqos/qos-iommu-testdev.h b/tests/qtest/libqos/qos-iommu-testdev.h
new file mode 100644
index 0000000000..3713b89ea4
--- /dev/null
+++ b/tests/qtest/libqos/qos-iommu-testdev.h
@@ -0,0 +1,43 @@
+/*
+ * IOMMU test device helpers for libqos qtests
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QTEST_LIBQOS_IOMMU_TESTDEV_H
+#define QTEST_LIBQOS_IOMMU_TESTDEV_H
+
+#include "pci.h"
+#include "hw/misc/iommu-testdev.h"
+
+typedef uint32_t (*QOSIOMMUTestdevSetupFn)(void *opaque);
+typedef uint32_t (*QOSIOMMUTestdevAttrsFn)(void *opaque);
+typedef bool (*QOSIOMMUTestdevValidateFn)(void *opaque);
+typedef void (*QOSIOMMUTestdevReportFn)(void *opaque, uint32_t dma_result);
+
+typedef struct QOSIOMMUTestdevDmaCfg {
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint64_t iova;
+    uint64_t gpa;
+    uint32_t len;
+} QOSIOMMUTestdevDmaCfg;
+
+uint32_t qos_iommu_testdev_trigger_dma(QPCIDevice *dev, QPCIBar bar,
+                                       uint64_t iova, uint64_t gpa,
+                                       uint32_t len, uint32_t attrs);
+
+void qos_iommu_testdev_single_translation(const QOSIOMMUTestdevDmaCfg *dma,
+                                          void *opaque,
+                                          QOSIOMMUTestdevSetupFn setup_fn,
+                                          QOSIOMMUTestdevAttrsFn attrs_fn,
+                                          QOSIOMMUTestdevValidateFn validate_fn,
+                                          QOSIOMMUTestdevReportFn report_fn,
+                                          uint32_t *dma_result_out);
+
+#endif /* QTEST_LIBQOS_IOMMU_TESTDEV_H */
-- 
2.34.1


