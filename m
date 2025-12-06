Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D554D3B7D8
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 15:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRubE-0006BK-4v; Sat, 06 Dec 2025 10:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRuaW-00067e-H0; Sat, 06 Dec 2025 10:52:50 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRuaT-00046y-Hp; Sat, 06 Dec 2025 10:52:48 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHKCVJUTRpK9VAAQ--.64275S2;
 Sat, 06 Dec 2025 23:52:41 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAHX+xAUTRpOAQKAA--.18744S7;
 Sat, 06 Dec 2025 23:52:40 +0800 (CST)
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
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v6 4/4] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
Date: Sat,  6 Dec 2025 23:52:03 +0800
Message-Id: <20251206155203.3015881-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHX+xAUTRpOAQKAA--.18744S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWkzPKwBkAAAsP
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw1DCF13JF4rCw47Jr17Awb_yoW7Zw4fpF
 yDCFy2yF4UJr1fC3Z3Ga10kr1ftan3Aw1UCr17Gr93Cr4qy347trs7KFW2q3s7J3y8XF1U
 Za4vkay5Wr18XaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Add a qtest suite that validates ARM SMMUv3 translation without guest
firmware or OS. The tests leverage iommu-testdev to trigger DMA
operations and the qos-smmuv3 library to configure IOMMU translation
structures.

This test suite targets the virt machine and covers:
- Stage 1 only translation (VA -> PA via CD page tables)
- Stage 2 only translation (IPA -> PA via STE S2 tables)
- Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
- Design to extended to support multiple security spaces
    (Non-Secure, Secure, Root, Realm)

Each test case follows this sequence:
1. Initialize SMMUv3 with appropriate command/event queues
2. Build translation tables (STE/CD/PTE) for the target scenario
3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
4. Trigger DMA and validate successful translation
5. Verify data integrity through a deterministic write-read pattern

This bare-metal approach provides deterministic IOMMU testing with
minimal dependencies, making failures directly attributable to the SMMU
translation path.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/iommu-smmuv3-test.c | 131 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |   1 +
 2 files changed, 132 insertions(+)
 create mode 100644 tests/qtest/iommu-smmuv3-test.c

diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
new file mode 100644
index 0000000000..96f66ee325
--- /dev/null
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -0,0 +1,131 @@
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
+static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QGenericPCIBus *gbus,
+                                          QPCIBar *bar)
+{
+    uint16_t vid, did;
+    QPCIDevice *dev = NULL;
+
+    qpci_init_generic(gbus, qts, NULL, false);
+
+    /* Find device by vendor/device ID to avoid slot surprises. */
+    for (int s = 0; s < 32 && !dev; s++) {
+        for (int fn = 0; fn < 8 && !dev; fn++) {
+            QPCIDevice *cand = qpci_device_find(&gbus->bus, QPCI_DEVFN(s, fn));
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
+static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
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
+    g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
+                   cfg->trans_mode, cfg->sec_sid);
+    qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
+    qtest_quit(qts);
+}
+
+static void test_smmuv3_ns_s1_only(void)
+{
+    QSMMUTestConfig cfg = {
+        .trans_mode = QSMMU_TM_S1_ONLY,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_iova = QSMMU_IOVA_OR_IPA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_smmuv3_translation(&cfg);
+}
+
+static void test_smmuv3_ns_s2_only(void)
+{
+    QSMMUTestConfig cfg = {
+        .trans_mode = QSMMU_TM_S2_ONLY,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_iova = QSMMU_IOVA_OR_IPA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_smmuv3_translation(&cfg);
+}
+
+static void test_smmuv3_ns_nested(void)
+{
+    QSMMUTestConfig cfg = {
+        .trans_mode = QSMMU_TM_NESTED,
+        .sec_sid = QSMMU_SEC_SID_NONSECURE,
+        .dma_iova = QSMMU_IOVA_OR_IPA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_smmuv3_translation(&cfg);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/iommu-testdev/translation/ns-s1-only",
+                   test_smmuv3_ns_s1_only);
+    qtest_add_func("/iommu-testdev/translation/ns-s2-only",
+                   test_smmuv3_ns_s2_only);
+    qtest_add_func("/iommu-testdev/translation/ns-nested",
+                   test_smmuv3_ns_nested);
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


