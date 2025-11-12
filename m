Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419CCD3421
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 16:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJDc7-0002tJ-Hz; Wed, 12 Nov 2025 11:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vJDbr-0002fk-9g; Wed, 12 Nov 2025 11:22:19 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vJDbl-0004od-Aw; Wed, 12 Nov 2025 11:22:14 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHaCUotBRpaJvEAA--.11420S2;
 Thu, 13 Nov 2025 00:22:00 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDnP+0jtBRpz0YEAA--.8224S6;
 Thu, 13 Nov 2025 00:21:59 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 3/3] tests/qtest: add SMMUv3 bare-metal test using
 iommu-testdev
Date: Thu, 13 Nov 2025 00:21:52 +0800
Message-Id: <20251112162152.447327-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
References: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDnP+0jtBRpz0YEAA--.8224S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWkTmLAHdwAAsq
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw1DCF43Xw15ur43XFy5Arb_yoW7AryxpF
 yDCa4ayFZ7JF1fu3Z3Ja1kKr1rtan3Aw1UGr13KrnIkrs0y34UtrZ7KFWUKFZrJ3ykZF1U
 Za4ktF45Gr18XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a qtest suite that validates ARM SMMUv3 translation without guest
firmware or OS. The tests leverage iommu-testdev to trigger DMA
operations and the qos-smmuv3 library to configure IOMMU translation
structures.

Test coverage includes:
- Stage 1 only translation (VA -> PA via CD page tables)
- Stage 2 only translation (IPA -> PA via STE S2 tables)
- Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
- Could be easily extended to support multiple security spaces
  (Non-Secure, Secure, Root, Realm)

Each test:
1. Initializes SMMUv3 with appropriate command/event queues
2. Builds translation tables (STE/CD/PTE) for the target scenario
3. Configures iommu-testdev with IOVA and DMA attributes
4. Triggers DMA and validates successful translation
5. Verifies data integrity through the write-read pattern

This bare-metal approach provides deterministic IOMMU testing with
minimal dependencies, making failures directly attributable to the SMMU
translation path. The test infrastructure can be easily extended to
cover additional scenarios like fault handling, permission checks, and
invalidation commands.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/iommu-smmuv3-test.c | 116 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   1 +
 2 files changed, 117 insertions(+)
 create mode 100644 tests/qtest/iommu-smmuv3-test.c

diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
new file mode 100644
index 0000000000..100fbdfe05
--- /dev/null
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -0,0 +1,116 @@
+/*
+ * QTest for SMMUv3 with iommu-testdev
+ *
+ * This QTest file is used to test the SMMUv3 with iommu-testdev so that we can
+ * test SMMUv3 without any guest kernel or firmware.
+ *
+ * Copyright (c) 2025 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/generic-pcihost.h"
+#include "hw/pci/pci_regs.h"
+#include "hw/misc/iommu-testdev.h"
+#include "libqos/qos-smmuv3.h"
+
+#define DMA_LEN           4
+
+/* Test configurations for different SMMU modes and spaces */
+static const QSMMUTestConfig base_test_configs[] = {
+    {
+        .trans_mode = QSMMU_TM_S1_ONLY,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_iova = QSMMU_IOVA_OR_IPA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0
+    },
+    {
+        .trans_mode = QSMMU_TM_S2_ONLY,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_iova = QSMMU_IOVA_OR_IPA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0
+    },
+    {
+        .trans_mode = QSMMU_TM_NESTED,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_iova = QSMMU_IOVA_OR_IPA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0
+    }
+};
+
+static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
+                                          QPCIBar *bar)
+{
+    int slot, fn;
+    uint16_t vid, did;
+    QPCIDevice *dev = NULL;
+
+    qpci_init_generic(gbus, qts, NULL, false);
+
+    /* Find device by vendor/device ID to avoid slot surprises. */
+    for (slot = 0; slot < 32 && !dev; slot++) {
+        for (fn = 0; fn < 8 && !dev; fn++) {
+            QPCIDevice *cand = qpci_device_find(&gbus->bus,
+                                                QPCI_DEVFN(slot, fn));
+            if (!cand) {
+                continue;
+            }
+            vid = qpci_config_readw(cand, PCI_VENDOR_ID);
+            did = qpci_config_readw(cand, PCI_DEVICE_ID);
+            if (vid == IOMMU_TESTDEV_VENDOR_ID &&
+                did == IOMMU_TESTDEV_DEVICE_ID) {
+                dev = cand;
+                g_test_message("Found iommu-testdev! devfn: 0x%x", cand->devfn);
+            } else {
+                g_free(cand);
+            }
+        }
+    }
+    g_assert(dev);
+
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
+
+static void test_smmuv3_translation(void)
+{
+    QTestState *qts;
+    QGenericPCIBus gbus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    /* Initialize QEMU environment for SMMU testing */
+    qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 "
+                     "-smp 1 -m 512 -cpu max -net none "
+                     "-device iommu-testdev");
+
+    /* Setup and configure PCI device */
+    dev = setup_qtest_pci_device(qts, &gbus, &bar);
+    g_assert(dev);
+
+    /* Run the enhanced translation tests */
+    g_test_message("### Starting SMMUv3 translation tests...###");
+    qsmmu_translation_batch(base_test_configs, ARRAY_SIZE(base_test_configs),
+                            qts, dev, bar, VIRT_SMMU_BASE);
+    g_test_message("### SMMUv3 translation tests completed successfully! ###");
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/iommu-testdev/translation", test_smmuv3_translation);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..e2d2e68092 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -263,6 +263,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-smmuv3-test'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
-- 
2.34.1


