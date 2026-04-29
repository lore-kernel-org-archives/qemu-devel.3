Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439E3FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5yN-00075t-6b; Wed, 29 Apr 2026 10:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5yC-000742-LG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:32:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5yA-0007qm-EB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:32:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA6CF5BD56;
 Wed, 29 Apr 2026 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777473166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yVs8oYYUQJDcL18TH0v/eC11VU1GLIv2m3WS3+wh7Y=;
 b=z9+130a+CTcdZFymDKvYLHwGb9QgT1xsN4JR94WATqknhhq8p4k8Z1F4PFK9ryuqIy74So
 uusAL13458yuSS/OOz/9f1SzwyUUvGBYUh3Luu6DsgLB+X8qRNqF9swP//sjq1Kz/kYZjT
 fz58im5rCp2TbTpPQlbrKj14e35IrNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777473166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yVs8oYYUQJDcL18TH0v/eC11VU1GLIv2m3WS3+wh7Y=;
 b=rWaFInrvmn0xTfSSOGW/Zbh4JP5SnBxC8Sqx26sK5sKESOrzxqO5lgb7xlHijk1YjSAGnR
 /gdyEryIv7rVyjAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MqzPIDPY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=E7g65csE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777473161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yVs8oYYUQJDcL18TH0v/eC11VU1GLIv2m3WS3+wh7Y=;
 b=MqzPIDPYVwcGUzJdLYHlsmmFtXWVpu9fwr9Hm9Wgg9oZdrVBfSCFBMudkl3qHaV1sDXStG
 JtFMm75RDmHf7UJaV5cMJk8J7QYPT9coF/RJIQnVDPqQ3iXlZgVLj1x8W4E22TFfu1dMME
 t7ztuTj2xY31yLuBO9Q0yKD0K6bMS+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777473161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yVs8oYYUQJDcL18TH0v/eC11VU1GLIv2m3WS3+wh7Y=;
 b=E7g65csEWlJy5joZKJRM9jw7iskOKZfNycBT+E7FOmaUam3jU9I/d2oj6M2PkcmARYHhCw
 Hehl8eayvlfbLOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6BEE593B4;
 Wed, 29 Apr 2026 14:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0CcFIYgW8mksagAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 14:32:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Fengyuan Yu <15fengyuan@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PULL 2/3] tests/qtest: Add Intel IOMMU bare-metal test
Date: Wed, 29 Apr 2026 11:32:30 -0300
Message-ID: <20260429143235.25115-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429143235.25115-1-farosas@suse.de>
References: <20260429143235.25115-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,phytium.com.cn];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EA6CF5BD56
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Fengyuan Yu <15fengyuan@gmail.com>

Add a qtest suite for the Intel IOMMU (VT-d) device on the Q35 machine.
The test exercises both Legacy and Scalable translation modes using
iommu-testdev and the qos-intel-iommu helpers, without requiring any
guest kernel or firmware.

The test validates:
- Legacy-mode Root Entry Table and Context Entry Table configuration
- Scalable-mode Context Entry, PASID Directory, and PASID Table setup
- Legacy-mode 4-level page table walks for 48-bit address translation
- Scalable-mode second-level and first-level 4-level page table walks
- Pass-through mode in both Legacy and Scalable modes
- DMA transaction execution with memory content verification

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
Link: https://lore.kernel.org/qemu-devel/ce3c44f3b07734a4f0ee43f55b21c856034af1b1.1774421649.git.15fengyuan@gmail.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                    |   1 +
 tests/qtest/iommu-intel-test.c | 216 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   2 +
 3 files changed, 219 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3887dda851..b570c43673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4010,6 +4010,7 @@ F: hw/i386/intel_iommu_accel.*
 F: include/hw/i386/intel_iommu.h
 F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
+F: tests/qtest/iommu-intel-test.c
 
 AMD-Vi Emulation
 M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
new file mode 100644
index 0000000000..a52c45e298
--- /dev/null
+++ b/tests/qtest/iommu-intel-test.c
@@ -0,0 +1,216 @@
+/*
+ * QTest for Intel IOMMU (VT-d) with iommu-testdev
+ *
+ * This QTest file is used to test the Intel IOMMU with iommu-testdev so that
+ * we can test VT-d without any guest kernel or firmware.
+ *
+ * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+#include "hw/i386/intel_iommu_internal.h"
+#include "hw/misc/iommu-testdev.h"
+#include "libqos/qos-intel-iommu.h"
+
+#define DMA_LEN           4
+
+static uint64_t intel_iommu_expected_gpa(uint64_t iova)
+{
+    return (QVTD_PT_VAL & VTD_PAGE_MASK_4K) + (iova & 0xfff);
+}
+
+static void save_fn(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **) data;
+
+    *pdev = dev;
+}
+
+static QPCIDevice *setup_qtest_pci_device(QTestState *qts, QPCIBus **pcibus,
+                                          QPCIBar *bar)
+{
+    QPCIDevice *dev = NULL;
+
+    *pcibus = qpci_new_pc(qts, NULL);
+    g_assert(*pcibus != NULL);
+
+    qpci_device_foreach(*pcibus, IOMMU_TESTDEV_VENDOR_ID,
+                        IOMMU_TESTDEV_DEVICE_ID, save_fn, &dev);
+
+    g_assert(dev);
+    qpci_device_enable(dev);
+    *bar = qpci_iomap(dev, 0, NULL);
+    g_assert_false(bar->is_io);
+
+    return dev;
+}
+
+static const char *qvtd_iommu_args(QVTDTransMode mode)
+{
+    switch (mode) {
+    case QVTD_TM_SCALABLE_FLT:
+        return "-device intel-iommu,x-scalable-mode=on,x-flts=on ";
+    case QVTD_TM_SCALABLE_PT:
+    case QVTD_TM_SCALABLE_SLT:
+        return "-device intel-iommu,x-scalable-mode=on ";
+    default:
+        return "-device intel-iommu ";
+    }
+}
+
+static bool qvtd_check_caps(QTestState *qts, QVTDTransMode mode)
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
+static void run_intel_iommu_translation(const QVTDTestConfig *cfg)
+{
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    /* Initialize QEMU environment for Intel IOMMU testing */
+    qts = qtest_initf("-machine q35 -smp 1 -m 512 -net none "
+                      "%s -device iommu-testdev",
+                      qvtd_iommu_args(cfg->trans_mode));
+
+    /* Check CAP/ECAP capabilities for required translation mode */
+    if (!qvtd_check_caps(qts, cfg->trans_mode)) {
+        qtest_quit(qts);
+        return;
+    }
+
+    /* Setup and configure IOMMU-testdev PCI device */
+    dev = setup_qtest_pci_device(qts, &pcibus, &bar);
+    g_assert(dev);
+
+    g_test_message("### Intel IOMMU translation mode=%d ###", cfg->trans_mode);
+    qvtd_run_translation_case(qts, dev, bar, Q35_HOST_BRIDGE_IOMMU_ADDR, cfg);
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
+static void test_intel_iommu_legacy_pt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_LEGACY_PT,
+        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_legacy_trans(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_LEGACY_TRANS,
+        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_scalable_pt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_SCALABLE_PT,
+        .dma_gpa = QVTD_IOVA,  /* pass-through: GPA == IOVA */
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_scalable_slt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_SCALABLE_SLT,
+        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+static void test_intel_iommu_scalable_flt(void)
+{
+    QVTDTestConfig cfg = {
+        .trans_mode = QVTD_TM_SCALABLE_FLT,
+        .dma_gpa = intel_iommu_expected_gpa(QVTD_IOVA),
+        .dma_len = DMA_LEN,
+        .expected_result = 0,
+    };
+
+    run_intel_iommu_translation(&cfg);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* Legacy mode tests */
+    qtest_add_func("/iommu-testdev/intel/legacy-pt",
+                   test_intel_iommu_legacy_pt);
+    qtest_add_func("/iommu-testdev/intel/legacy-trans",
+                   test_intel_iommu_legacy_trans);
+
+    /* Scalable mode tests */
+    qtest_add_func("/iommu-testdev/intel/scalable-pt",
+                   test_intel_iommu_scalable_pt);
+    qtest_add_func("/iommu-testdev/intel/scalable-slt",
+                   test_intel_iommu_scalable_slt);
+    qtest_add_func("/iommu-testdev/intel/scalable-flt",
+                   test_intel_iommu_scalable_flt);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b735f55fc4..43f83ffd3a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -96,6 +96,8 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_VTD') and
+   config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-intel-test'] : []) +      \
   (host_os != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
-- 
2.51.0


