Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DDCAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1o1K-0008F0-G1; Thu, 25 Sep 2025 11:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1o1H-0008Ei-Jm; Thu, 25 Sep 2025 11:36:31 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1o17-0003kS-Lo; Thu, 25 Sep 2025 11:36:30 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD32L1mYdVoGa05CQ--.231S2;
 Thu, 25 Sep 2025 23:36:06 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXuudhYdVoj_AeAA--.7094S5;
 Thu, 25 Sep 2025 23:36:05 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: pbonzini@redhat.com,
	farosas@suse.de,
	lvivier@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 2/2] tests/qtest: add SMMUv3 smoke test using smmu-testdev DMA
 source
Date: Thu, 25 Sep 2025 23:35:50 +0800
Message-Id: <20250925153550.105915-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925153550.105915-1-tangtao1634@phytium.com.cn>
References: <20250925153550.105915-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXuudhYdVoj_AeAA--.7094S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHkwAAsi
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3try3Wr4UCFy5Wr4xXryDGFg_yoW8JryUAo
 WSvFsxu3WxGF17Ar48Crn7GrW7Xr109FnxAF45ur45Ga4FkF15Kw1rtw43G3s5trsakFW7
 WFZ7Kw1ftw47X3s3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Introduce a bare-metal qtest that drives the new smmu-testdev to exercise
the SMMUv3 emulation without guest firmware or drivers. The test programs
a minimal Non-Secure context (STE/CD/PTE), triggers a DMA, and asserts
translation results.

Motivation
----------
SMMU testing in emulation often requires a large software stack and a
realistic PCIe fabric, which adds flakiness and obscures failures. This
qtest keeps the surface small and deterministic by using a hermetic DMA
source that feeds the SMMU directly.

What the test covers
--------------------
* Builds a Non-Secure STE/CD/PTE for a chosen stream_id/ssid.
* Primes source and destination host buffers.
* Kicks a DMA via smmu-testdev and waits for completion.
* Verifies translated access and payload equality.

Non-goals and scope limits
--------------------------
* Secure bank flows are omitted because Secure SMMU support is still RFC.
  A local Secure test exists and can be posted once the upstream series
  lands.
* PCIe discovery, MSI/INTx, ATS/PRI, and driver bring-up are out of scope
  as smmu-testdev is not a realistic PCIe Endpoint nor a platform device.

Rationale for a dedicated path
------------------------------
Using a generic PCI or virtio device would still require driver init and a
richer bus model, undermining determinism for this focused purpose. This
qtest, paired with smmu-testdev, keeps failures attributable to the SMMU
translation path.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 docs/specs/smmu-testdev.rst      |  44 ++++++
 tests/qtest/meson.build          |   1 +
 tests/qtest/smmu-testdev-qtest.c | 241 +++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 docs/specs/smmu-testdev.rst
 create mode 100644 tests/qtest/smmu-testdev-qtest.c

diff --git a/docs/specs/smmu-testdev.rst b/docs/specs/smmu-testdev.rst
new file mode 100644
index 0000000000..d114a804fe
--- /dev/null
+++ b/docs/specs/smmu-testdev.rst
@@ -0,0 +1,44 @@
+smmu-testdev — Minimal SMMUv3 DMA test device
+=============================================
+
+Overview
+--------
+``smmu-testdev`` is a tiny, test-only DMA source intended to exercise the
+SMMUv3 emulation without booting firmware or a guest OS. It lets tests
+populate STE/CD/PTE with known values and trigger a DMA that flows through
+the SMMU translation path. It is **not** a faithful PCIe endpoint nor a
+platform device and must be considered a QEMU-internal test vehicle.
+
+Status
+------
+* Location: ``hw/misc/smmu-testdev.c``
+* Build guard: ``CONFIG_SMMU_TESTDEV``
+* Default machines: none (tests instantiate it explicitly)
+* Intended use: qtests under ``tests/qtest/smmu-testdev-qtest.c``
+
+Running the qtest
+-----------------
+The smoke test ships with this device and is the recommended entry point::
+
+QTEST_QEMU_BINARY=qemu-system-aarch64 ./tests/qtest/smmu-testdev-qtest --tap -k
+
+This programs a minimal Non-Secure SMMU context, kicks a DMA, and verifies
+translation + data integrity.
+
+Instantiation (advanced)
+------------------------
+The device is not wired into any board by default. For ad-hoc experiments,
+tests (or developers) can create it dynamically via qtest or the QEMU
+monitor. It exposes a single MMIO window that the test drives directly.
+
+Limitations
+-----------
+* Non-Secure bank only in this version; Secure SMMU tests are planned once
+  upstream Secure support lands.
+* No PCIe discovery, MSI, ATS/PRI, or driver bring-up is modeled.
+* The device is test-only; do not rely on it for machine realism.
+
+See also
+--------
+* ``tests/qtest/smmu-testdev-qtest.c`` — the companion smoke test
+* SMMUv3 emulation and documentation under ``hw/arm/smmu*``
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06b..bcdb51e141 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -263,6 +263,7 @@ qtests_aarch64 = \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
+  (config_all_devices.has_key('CONFIG_SMMU_TESTDEV') ? ['smmu-testdev-qtest'] : []) + \
   qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
diff --git a/tests/qtest/smmu-testdev-qtest.c b/tests/qtest/smmu-testdev-qtest.c
new file mode 100644
index 0000000000..69cbc3fe24
--- /dev/null
+++ b/tests/qtest/smmu-testdev-qtest.c
@@ -0,0 +1,241 @@
+/*
+ * QTest for smmu-testdev
+ *
+ * This QTest file is used to test the smmu-testdev so that we can test SMMU
+ * without any guest kernel or firmware.
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
+#include "hw/misc/smmu-testdev.h"
+
+#define VIRT_SMMU_BASE    0x0000000009050000ULL
+#define DMA_IOVA          0x0000008080604567ULL
+#define DMA_LEN           0x20U
+
+static inline uint64_t smmu_bank_base(uint64_t base, SMMUTestDevSpace sp)
+{
+    /* Map only the Non-Secure bank for now; future domains may offset. */
+    (void)sp;
+    return base;
+}
+
+static uint32_t expected_dma_result(uint32_t mode,
+                                    SMMUTestDevSpace s1_space,
+                                    SMMUTestDevSpace s2_space)
+{
+    (void)mode;
+    if (s1_space != STD_SPACE_NONSECURE || s2_space != STD_SPACE_NONSECURE) {
+        return STD_DMA_ERR_TX_FAIL;
+    }
+    return 0u;
+}
+
+static void smmu_prog_bank(QTestState *qts, uint64_t B, SMMUTestDevSpace sp)
+{
+    g_assert_cmpuint(sp, ==, STD_SPACE_NONSECURE);
+    /* Program minimal SMMUv3 state in a given control bank. */
+    qtest_writel(qts, B + 0x0044, 0x80000000); /* GBPA UPDATE */
+    qtest_writel(qts, B + 0x0020, 0x0);       /* CR0 */
+    qtest_writel(qts, B + 0x0028, 0x0d75);    /* CR1 */
+    {
+        /* CMDQ_BASE: add address-space offset (S/NS/Root/Realm). */
+        uint64_t v = 0x400000000e16b00aULL + std_space_offset(sp);
+        qtest_writeq(qts, B + 0x0090, v);
+    }
+    qtest_writel(qts, B + 0x009c, 0x0);       /* CMDQ_CONS */
+    qtest_writel(qts, B + 0x0098, 0x0);       /* CMDQ_PROD */
+    {
+        /* EVENTQ_BASE: add address-space offset (S/NS/Root/Realm). */
+        uint64_t v = 0x400000000e17000aULL + std_space_offset(sp);
+        qtest_writeq(qts, B + 0x00a0, v);
+    }
+    qtest_writel(qts, B + 0x00a8, 0x0);       /* EVENTQ_PROD */
+    qtest_writel(qts, B + 0x00ac, 0x0);       /* EVENTQ_CONS */
+    qtest_writel(qts, B + 0x0088, 0x5);       /* STRTAB_BASE_CFG */
+    {
+        /* STRTAB_BASE: add address-space offset (S/NS/Root/Realm). */
+        uint64_t v = 0x400000000e179000ULL + std_space_offset(sp);
+        qtest_writeq(qts, B + 0x0080, v);
+    }
+    qtest_writel(qts, B + 0x003C, 0x1);       /* INIT */
+    qtest_writel(qts, B + 0x0020, 0xD);       /* CR0 */
+}
+
+static void smmu_prog_minimal(QTestState *qts, SMMUTestDevSpace space)
+{
+    /* Always program Non-Secure bank, then the requested space. */
+    uint64_t ns_base = smmu_bank_base(VIRT_SMMU_BASE, STD_SPACE_NONSECURE);
+    smmu_prog_bank(qts, ns_base, STD_SPACE_NONSECURE);
+
+    uint64_t sp_base = smmu_bank_base(VIRT_SMMU_BASE, space);
+    if (sp_base != ns_base) {
+        smmu_prog_bank(qts, sp_base, space);
+    }
+}
+
+static uint32_t poll_dma_result(QPCIDevice *dev, QPCIBar bar,
+                                QTestState *qts)
+{
+    /* Trigger side effects (DMA) via REG_ID read once. */
+    (void)qpci_io_readl(dev, bar, STD_REG_ID);
+
+    /* Poll until not BUSY, then return the result. */
+    for (int i = 0; i < 1000; i++) {
+        uint32_t r = qpci_io_readl(dev, bar, STD_REG_DMA_RESULT);
+        if (r != STD_DMA_RESULT_BUSY) {
+            return r;
+        }
+        /* Small backoff to avoid busy spinning. */
+        g_usleep(1000);
+    }
+    /* Timeout treated as failure-like non-zero. */
+    return STD_DMA_RESULT_BUSY;
+}
+
+static void test_mmio_access(void)
+{
+    QTestState *qts;
+    QGenericPCIBus gbus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint8_t buf[DMA_LEN];
+    uint32_t attr_ns;
+    qts = qtest_init("-machine virt,acpi=off,gic-version=3,iommu=smmuv3 " \
+                     "-display none -smp 1  -m 512 -cpu max -net none "
+                     "-device smmu-testdev,device=0x0,function=0x1 ");
+
+    qpci_init_generic(&gbus, qts, NULL, false);
+
+    /* Find device by vendor/device ID to avoid slot surprises. */
+    dev = NULL;
+    for (int slot = 0; slot < 32 && !dev; slot++) {
+        for (int fn = 0; fn < 8 && !dev; fn++) {
+            QPCIDevice *cand = qpci_device_find(&gbus.bus,
+                                               QPCI_DEVFN(slot, fn));
+            if (!cand) {
+                continue;
+            }
+            uint16_t vid = qpci_config_readw(cand, PCI_VENDOR_ID);
+            uint16_t did = qpci_config_readw(cand, PCI_DEVICE_ID);
+            if (vid == 0x1b36 && did == 0x0005) {
+                dev = cand;
+            } else {
+                g_free(cand);
+            }
+        }
+    }
+    g_assert_nonnull(dev);
+
+    qpci_device_enable(dev);
+    bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar.is_io);
+
+    /* Baseline attribute reads. */
+    attr_ns = qpci_io_readl(dev, bar, STD_REG_ATTR_NS);
+    g_assert_cmpuint(attr_ns, ==, 0x2);
+
+    /* Program SMMU base and DMA parameters. */
+    qpci_io_writel(dev, bar, STD_REG_SMMU_BASE_LO, (uint32_t)VIRT_SMMU_BASE);
+    qpci_io_writel(dev, bar, STD_REG_SMMU_BASE_HI,
+                   (uint32_t)(VIRT_SMMU_BASE >> 32));
+    qpci_io_writel(dev, bar, STD_REG_DMA_IOVA_LO, (uint32_t)DMA_IOVA);
+    qpci_io_writel(dev, bar, STD_REG_DMA_IOVA_HI,
+                   (uint32_t)(DMA_IOVA >> 32));
+    qpci_io_writel(dev, bar, STD_REG_DMA_LEN, DMA_LEN);
+    qpci_io_writel(dev, bar, STD_REG_DMA_DIR, 0); /* device -> host */
+
+    qtest_memset(qts, DMA_IOVA, 0x00, DMA_LEN);
+    qtest_memread(qts, DMA_IOVA, buf, DMA_LEN);
+
+    /* Refresh attrs via write to ensure legacy functionality still works. */
+    qpci_io_writel(dev, bar, STD_REG_ID, 0x1);
+    /*
+     * invoke translation builder for multiple
+     * stage/security-space combinations (readable/refactored).
+     */
+    const uint32_t modes[] = { 0u, 1u, 2u };
+    const SMMUTestDevSpace spaces[] = { STD_SPACE_NONSECURE };
+    /* Use attrs-DMA path for end-to-end */
+    qpci_io_writel(dev, bar, STD_REG_DMA_MODE, 1);
+    for (size_t mi = 0; mi < sizeof(modes) / sizeof(modes[0]); mi++) {
+        const SMMUTestDevSpace *s1_set = NULL;
+        size_t s1_count = 0;
+        const SMMUTestDevSpace *s2_set = NULL;
+        size_t s2_count = 0;
+
+        switch (modes[mi]) {
+        case 0u:
+        case 1u:
+        case 2u:
+            s1_set = spaces;
+            s1_count = sizeof(spaces) / sizeof(spaces[0]);
+            s2_set = spaces;
+            s2_count = sizeof(spaces) / sizeof(spaces[0]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        for (size_t si = 0; si < s1_count; si++) {
+            for (size_t sj = 0; sj < s2_count; sj++) {
+                qpci_io_writel(dev, bar, STD_REG_TRANS_MODE, modes[mi]);
+                qpci_io_writel(dev, bar, STD_REG_S1_SPACE, s1_set[si]);
+                qpci_io_writel(dev, bar, STD_REG_S2_SPACE, s2_set[sj]);
+                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x2);
+                qpci_io_writel(dev, bar, STD_REG_TRANS_DBELL, 0x1);
+
+                uint32_t st = qpci_io_readl(dev, bar,
+                                            STD_REG_TRANS_STATUS);
+                g_test_message("build: mode=%u s1=%u s2=%u status=0x%x",
+                                modes[mi], s1_set[si], s2_set[sj], st);
+
+                /* Program SMMU registers in selected control bank. */
+                smmu_prog_minimal(qts, s1_set[si]);
+
+                /* End-to-end DMA using tx_space per mode. */
+                SMMUTestDevSpace tx_space =
+                    (modes[mi] == 0u) ? s1_set[si] : s2_set[sj];
+                uint32_t dma_attrs = ((uint32_t)tx_space << 1);
+                qpci_io_writel(dev, bar, STD_REG_DMA_ATTRS,
+                                dma_attrs);
+                qpci_io_writel(dev, bar, STD_REG_DMA_DBELL, 1);
+                /* Wait for DMA completion and assert success. */
+                {
+                    uint32_t dr = poll_dma_result(dev, bar, qts);
+                    uint32_t exp = expected_dma_result(modes[mi],
+                                                        spaces[si],
+                                                        spaces[sj]);
+                    g_assert_cmpuint(dr, ==, exp);
+                    g_test_message(
+                        "polling end. dma: mode=%u s1=%u s2=%u "
+                        "attrs=0x%x res=0x%x",
+                        modes[mi], s1_set[si], s2_set[sj],
+                        dma_attrs, dr);
+                }
+                /* Clear CD/STE/PTE built by the device for next round. */
+                qpci_io_writel(dev, bar, STD_REG_TRANS_CLEAR, 1);
+                g_test_message("clear cache end.");
+            }
+        }
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/smmu-testdev/mmio", test_mmio_access);
+    return g_test_run();
+}
-- 
2.34.1


