Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F7BE909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNpT-0005iN-QR; Tue, 17 Feb 2026 11:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNpM-0005fz-1P
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:21:33 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNpI-0005DB-Rf
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:21:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F0A65BCF0;
 Tue, 17 Feb 2026 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771345274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Zml0/5t7HYkkGqLO73zKb8bJ2DnYnBYcsnZH93akNk=;
 b=MNoD9SP/ROdWPoUZtFRMUPDbZTmdkBt2+UEOjg16upuOr5vDl62L6CYryw/seVT73QoP01
 608ic+ZaT15BojoMzi3d0vDqck3GIsLTnSKIwrwENLomJpetM+L3p5djAIcyWw6G9aANLL
 xiYerq5MwM6YTBdBru4VDNDG19lUTJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771345274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Zml0/5t7HYkkGqLO73zKb8bJ2DnYnBYcsnZH93akNk=;
 b=ZPjGlXePcZ2F3BpCurDSicwoyI3ACvXDfMtj9PEXHoysDDmkxyOr7UJAqyidadPdN1NGS6
 qfy47T0BHFQgmWBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="MNoD9SP/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZPjGlXeP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771345274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Zml0/5t7HYkkGqLO73zKb8bJ2DnYnBYcsnZH93akNk=;
 b=MNoD9SP/ROdWPoUZtFRMUPDbZTmdkBt2+UEOjg16upuOr5vDl62L6CYryw/seVT73QoP01
 608ic+ZaT15BojoMzi3d0vDqck3GIsLTnSKIwrwENLomJpetM+L3p5djAIcyWw6G9aANLL
 xiYerq5MwM6YTBdBru4VDNDG19lUTJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771345274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Zml0/5t7HYkkGqLO73zKb8bJ2DnYnBYcsnZH93akNk=;
 b=ZPjGlXePcZ2F3BpCurDSicwoyI3ACvXDfMtj9PEXHoysDDmkxyOr7UJAqyidadPdN1NGS6
 qfy47T0BHFQgmWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B17BB3EA65;
 Tue, 17 Feb 2026 16:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kGN2HXiVlGnPVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:21:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
Date: Tue, 17 Feb 2026 13:21:06 -0300
Message-ID: <20260217162106.13630-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217162106.13630-1-farosas@suse.de>
References: <20260217162106.13630-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[phytium.com.cn:email,qualcomm.com:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,vrull.eu:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[gmail.com,phytium.com.cn,oss.qualcomm.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,vrull.eu:email,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F0A65BCF0
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

Add a qtest suite for the RISC-V IOMMU PCI device on the virt machine.
The test exercises bare, S-stage, G-stage, and nested translation paths
using iommu-testdev and the qos-riscv-iommu helpers.

The test validates:
- Device context (DC) configuration
- SV39 page table walks for S-stage translation
- SV39x4 page table walks for G-stage translation
- Nested translation combining both stages
- FCTL register constraints

This provides regression coverage for the RISC-V IOMMU implementation
without requiring a full guest OS boot.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/35f046c8d21aa6d5f9a531258762e01be198d8cf.1770127918.git.chao.liu.zevorn@gmail.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                    |   1 +
 tests/qtest/iommu-riscv-test.c | 279 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   5 +-
 3 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/iommu-riscv-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 950212e32c..e0c481e212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -350,6 +350,7 @@ F: common-user/host/riscv*
 F: tests/functional/riscv32
 F: tests/functional/riscv64
 F: tests/tcg/riscv64/
+F: tests/qtest/iommu-riscv-test.c
 
 RISC-V XThead* extensions
 M: Christoph Muellner <christoph.muellner@vrull.eu>
diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
new file mode 100644
index 0000000000..2638024891
--- /dev/null
+++ b/tests/qtest/iommu-riscv-test.c
@@ -0,0 +1,279 @@
+/*
+ * QTest testcase for RISC-V IOMMU with iommu-testdev
+ *
+ * This QTest file is used to test the RISC-V IOMMU with iommu-testdev so that
+ * we can test RISC-V IOMMU without any guest kernel or firmware.
+ *
+ * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqos/generic-pcihost.h"
+#include "hw/pci/pci_regs.h"
+#include "hw/misc/iommu-testdev.h"
+#include "hw/riscv/riscv-iommu-bits.h"
+#include "libqos/qos-riscv-iommu.h"
+#include "libqos/riscv-iommu.h"
+
+#define DMA_LEN           4
+
+/* RISC-V virt machine PCI configuration */
+#define RISCV_GPEX_PIO_BASE        0x3000000
+#define RISCV_BUS_PIO_LIMIT        0x10000
+#define RISCV_BUS_MMIO_ALLOC_PTR   0x40000000
+#define RISCV_BUS_MMIO_LIMIT       0x80000000
+#define RISCV_ECAM_ALLOC_PTR       0x30000000
+
+typedef struct RiscvIommuTestState {
+    QTestState *qts;
+    QGenericPCIBus gbus;
+    QPCIDevice *iommu_dev;
+    QPCIDevice *testdev;
+    QPCIBar testdev_bar;
+    uint64_t iommu_base;
+} RiscvIommuTestState;
+
+static void riscv_config_qpci_bus(QGenericPCIBus *qpci)
+{
+    qpci->gpex_pio_base = RISCV_GPEX_PIO_BASE;
+    qpci->bus.pio_limit = RISCV_BUS_PIO_LIMIT;
+    qpci->bus.mmio_alloc_ptr = RISCV_BUS_MMIO_ALLOC_PTR;
+    qpci->bus.mmio_limit = RISCV_BUS_MMIO_LIMIT;
+    qpci->ecam_alloc_ptr = RISCV_ECAM_ALLOC_PTR;
+}
+
+static uint64_t riscv_iommu_expected_gpa(uint64_t iova)
+{
+    return QRIOMMU_SPACE_OFFS + QRIOMMU_L2_PTE_VAL + (iova & 0xfff);
+}
+
+static void save_fn(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **) data;
+    uint16_t vendor = qpci_config_readw(dev, 0);
+    uint16_t device = qpci_config_readw(dev, 2);
+
+    g_test_message("Found PCI device: vendor=0x%04x device=0x%04x devfn=0x%02x",
+                   vendor, device, devfn);
+
+    if (!*pdev) {
+        *pdev = dev;
+    }
+}
+
+static QPCIDevice *find_riscv_iommu_pci(QGenericPCIBus *gbus,
+                                        uint64_t *iommu_base)
+{
+    QPCIDevice *iommu_dev = NULL;
+    QPCIBar iommu_bar;
+
+    g_test_message("Searching for riscv-iommu-pci "
+                   "(vendor=0x%04x, device=0x%04x)",
+                   RISCV_IOMMU_PCI_VENDOR_ID, RISCV_IOMMU_PCI_DEVICE_ID);
+
+    qpci_device_foreach(&gbus->bus, RISCV_IOMMU_PCI_VENDOR_ID,
+                        RISCV_IOMMU_PCI_DEVICE_ID, save_fn, &iommu_dev);
+
+    if (!iommu_dev) {
+        g_test_message("riscv-iommu-pci device not found!");
+        return NULL;
+    }
+
+    g_test_message("Found riscv-iommu-pci at devfn=0x%02x", iommu_dev->devfn);
+
+    qpci_device_enable(iommu_dev);
+    iommu_bar = qpci_iomap(iommu_dev, 0, NULL);
+    g_assert_false(iommu_bar.is_io);
+
+    *iommu_base = iommu_bar.addr;
+    g_test_message("RISC-V IOMMU MMIO base address: 0x%" PRIx64, *iommu_base);
+
+    return iommu_dev;
+}
+
+static QPCIDevice *find_iommu_testdev(QGenericPCIBus *gbus, QPCIBar *bar)
+{
+    QPCIDevice *dev = NULL;
+
+    g_test_message("Searching for iommu-testdev (vendor=0x%04x, device=0x%04x)",
+                   IOMMU_TESTDEV_VENDOR_ID, IOMMU_TESTDEV_DEVICE_ID);
+
+    qpci_device_foreach(&gbus->bus, IOMMU_TESTDEV_VENDOR_ID,
+                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
+    g_assert(dev);
+
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
+
+static bool riscv_iommu_test_setup(RiscvIommuTestState *state)
+{
+    if (!qtest_has_machine("virt")) {
+        g_test_skip("virt machine not available");
+        return false;
+    }
+
+    state->qts = qtest_init("-machine virt,acpi=off "
+                            "-cpu max -smp 1 -m 512 -net none "
+                            "-device riscv-iommu-pci "
+                            "-device iommu-testdev");
+
+    qpci_init_generic(&state->gbus, state->qts, NULL, false);
+    riscv_config_qpci_bus(&state->gbus);
+
+    state->iommu_dev = find_riscv_iommu_pci(&state->gbus, &state->iommu_base);
+    g_assert(state->iommu_dev);
+
+    state->testdev = find_iommu_testdev(&state->gbus, &state->testdev_bar);
+    g_assert(state->testdev);
+
+    return true;
+}
+
+static void riscv_iommu_test_teardown(RiscvIommuTestState *state)
+{
+    g_free(state->iommu_dev);
+    g_free(state->testdev);
+    qtest_quit(state->qts);
+}
+
+static uint64_t riscv_iommu_check(QTestState *qts, uint64_t iommu_base,
+                                  QRIOMMUTransMode mode)
+{
+    uint64_t cap;
+    uint64_t ddtp;
+    uint32_t cqcsr;
+    uint32_t fqcsr;
+    uint32_t pqcsr;
+    uint32_t fctl;
+    uint32_t fctl_mask;
+    uint32_t fctl_desired;
+    uint32_t igs;
+
+    cap = qtest_readq(qts, iommu_base + RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint((uint32_t)(cap & RISCV_IOMMU_CAP_VERSION), ==,
+                     RISCV_IOMMU_SPEC_DOT_VER);
+
+    fctl = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_FCTL);
+    igs = (cap & RISCV_IOMMU_CAP_IGS) >> 28;
+    g_assert_cmpuint(igs, <=, RISCV_IOMMU_CAP_IGS_BOTH);
+
+    fctl_mask = RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI |
+                RISCV_IOMMU_FCTL_GXL;
+    fctl_desired = fctl & ~fctl_mask;
+    if (igs == RISCV_IOMMU_CAP_IGS_WSI) {
+        fctl_desired |= RISCV_IOMMU_FCTL_WSI;
+    }
+
+    if ((fctl & fctl_mask) != (fctl_desired & fctl_mask)) {
+        ddtp = qtest_readq(qts, iommu_base + RISCV_IOMMU_REG_DDTP);
+        cqcsr = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_CQCSR);
+        fqcsr = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_FQCSR);
+        pqcsr = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_PQCSR);
+
+        g_assert_cmpuint((uint32_t)(ddtp & RISCV_IOMMU_DDTP_MODE), ==,
+                         RISCV_IOMMU_DDTP_MODE_OFF);
+        g_assert_cmpuint(cqcsr & RISCV_IOMMU_CQCSR_CQON, ==, 0);
+        g_assert_cmpuint(fqcsr & RISCV_IOMMU_FQCSR_FQON, ==, 0);
+        g_assert_cmpuint(pqcsr & RISCV_IOMMU_PQCSR_PQON, ==, 0);
+
+        qtest_writel(qts, iommu_base + RISCV_IOMMU_REG_FCTL, fctl_desired);
+        fctl = qtest_readl(qts, iommu_base + RISCV_IOMMU_REG_FCTL);
+    }
+
+    g_assert_cmpuint(fctl & fctl_mask, ==, fctl_desired & fctl_mask);
+
+    if (mode == QRIOMMU_TM_S_STAGE_ONLY || mode == QRIOMMU_TM_NESTED) {
+        g_assert((cap & RISCV_IOMMU_CAP_SV39) != 0);
+    }
+    if (mode == QRIOMMU_TM_G_STAGE_ONLY || mode == QRIOMMU_TM_NESTED) {
+        g_assert((cap & RISCV_IOMMU_CAP_SV39X4) != 0);
+        g_assert_cmpuint(fctl & RISCV_IOMMU_FCTL_GXL, ==, 0);
+    }
+
+    return cap;
+}
+
+static void run_riscv_iommu_translation(const QRIOMMUTestConfig *cfg)
+{
+    RiscvIommuTestState state = { 0 };
+
+    if (!riscv_iommu_test_setup(&state)) {
+        return;
+    }
+
+    riscv_iommu_check(state.qts, state.iommu_base, cfg->trans_mode);
+
+    g_test_message("### RISC-V IOMMU translation mode=%d ###",
+                   cfg->trans_mode);
+    qriommu_run_translation_case(state.qts, state.testdev, state.testdev_bar,
+                                 state.iommu_base, cfg);
+    riscv_iommu_test_teardown(&state);
+}
+
+static void test_riscv_iommu_bare(void)
+{
+    QRIOMMUTestConfig cfg = {
+        .trans_mode = QRIOMMU_TM_BARE,
+        .dma_gpa = QRIOMMU_IOVA,
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_riscv_iommu_translation(&cfg);
+}
+
+static void test_riscv_iommu_s_stage_only(void)
+{
+    QRIOMMUTestConfig cfg = {
+        .trans_mode = QRIOMMU_TM_S_STAGE_ONLY,
+        .dma_gpa = riscv_iommu_expected_gpa(QRIOMMU_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_riscv_iommu_translation(&cfg);
+}
+
+static void test_riscv_iommu_g_stage_only(void)
+{
+    QRIOMMUTestConfig cfg = {
+        .trans_mode = QRIOMMU_TM_G_STAGE_ONLY,
+        .dma_gpa = riscv_iommu_expected_gpa(QRIOMMU_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_riscv_iommu_translation(&cfg);
+}
+
+static void test_riscv_iommu_nested(void)
+{
+    QRIOMMUTestConfig cfg = {
+        .trans_mode = QRIOMMU_TM_NESTED,
+        .dma_gpa = riscv_iommu_expected_gpa(QRIOMMU_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_riscv_iommu_translation(&cfg);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/iommu-testdev/translation/bare",
+                   test_riscv_iommu_bare);
+    qtest_add_func("/iommu-testdev/translation/s-stage-only",
+                   test_riscv_iommu_s_stage_only);
+    qtest_add_func("/iommu-testdev/translation/g-stage-only",
+                   test_riscv_iommu_g_stage_only);
+    qtest_add_func("/iommu-testdev/translation/ns-nested",
+                   test_riscv_iommu_nested);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index dfb83650c6..25fdbc7980 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -287,7 +287,10 @@ qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
 qtests_riscv64 = ['riscv-csr-test'] + \
-  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
+  (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
+   config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
+   ['iommu-riscv-test'] : [])
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
-- 
2.51.0


