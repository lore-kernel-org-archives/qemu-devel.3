Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E8D107BCEE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1DYq-0001Br-5U; Fri, 13 Mar 2026 21:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w1DYi-00016E-NO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 21:12:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w1DYe-0005z9-Tx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 21:12:52 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35a1cc6e478so1353806a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 18:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773450766; x=1774055566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUg9zQW4TUp2M9Mnsl63wqaTFctvVTFS5wLLtQH1GrE=;
 b=H2dUYyQl4AGfGeXL7kx+dh/ewczqeRJqAPidk4lwy4ZIsm5aDvbIff2eQo4tZoUpqF
 T4f25jQ9cs1xYtATtYDi+vnguG8quTCYu5/v8qo++gvfYeSek6hIhi1AR76wbZRSjd+u
 Otwf9YzrvYWFvWBeSCwEpzSxtiWSfWaeIPq/Z2RqNqZK0AGja8evk1oNz7fpss3993ou
 eG2ZqHVkK9hTdEASAW1fjMjlbEfQFAsOQ5xaq6YiJqYCwAKFfsD3JBoF+1OtHw42dmHp
 5hKMu4/aRsiBfhsxbf057PIu8GTyHs+mOfI4sltXdwi5yFJnOJfv5JwOSPWkI9QiOoEu
 7QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450766; x=1774055566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eUg9zQW4TUp2M9Mnsl63wqaTFctvVTFS5wLLtQH1GrE=;
 b=cVZf3K462/XFpRi4pnKEKoWLzf1e0+NYZHwXDu3EiwFBgfYVWMpriJSXH6/y6aOuvb
 dhu3eMgy1H/DXABk66EoJuiH/w4XSXaacp4HY3aljkBi/yWn21mOXHCdwbWG0nJ3oJcc
 FgkZqrG87ssx0Cdeu0Tali/jK7u9t0BRKSKbYB9MrcjLI8Zucr3t4+tbe43CbcFSNRjM
 DSahGNBeoXBm4LxdjPY02S7r171SV1jw/TSVfQ320xb1DqUwBGqkqABq/kqdPY6c2KQx
 ujp2URroNqV43yBm0voiqgQanOpKsLnnQG7dNvZ/qkB3G8GBOZWfSB5V8Po8tgUL2G2J
 0u4g==
X-Gm-Message-State: AOJu0Yw4+1POhLYrVmEJuryW1A00kWKO8DGudcHnM28/kWeEiOmq43OF
 WtUH4bbUkQoGPz+WyGozw0SaH5D1EyJ4nN15rmG44/nPWqGFhOtBHbDA
X-Gm-Gg: ATEYQzx87yUpAsgbrkYLEBdgFfSSbhhea9jeUD+Qi6QnHAkiEu5rMt9H4/d1lR4WsQF
 uBciY87brjo+JZRwZwfiyEK8NX/3eUMdC7LJAY5TkP+qTH9olmYwpfQeLG+0bXyEC3GojHgAOpy
 8rDkvqvyeQCvVDNeUX7DDaicfz5nH8YFR7BY4IVkJpIiBnLx5LAmm9VRmj84y3n1/+heXVAxpcq
 qdvAMjkytfjJBR9Ol7YTK82AR9sc3XZflMdMBCllbH+cfw0AALFMrv3tCxN7h1UE6eWaPndLfPl
 UjcQxLWEpNX3zsAUq/KhADAb67CD0A4PtLaBVvupr+gcxKq45LQ9j3/PST8GFnMoSRlyT+/Rdkv
 ykFOJxO4A2lZAYIoW8l7HrnRkR0e+sbMHUAx4X5ofTXVLM5/lZ34ifg6wvqkJ+qaYJrUhU5GDAk
 IJyN0UR0YKrJ1zf8zPMBLFYmu4Rn8=
X-Received: by 2002:a17:90b:3888:b0:34c:9cec:dd83 with SMTP id
 98e67ed59e1d1-35a2206d86emr4803899a91.27.1773450766146; 
 Fri, 13 Mar 2026 18:12:46 -0700 (PDT)
Received: from orion-o6.tail020997.ts.net ([2408:8352:441:f661::1008])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a2454a7bdsm1248545a91.8.2026.03.13.18.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:12:45 -0700 (PDT)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>,
 Fengyuan Yu <15fengyuan@gmail.com>
Subject: [PATCH v2 2/2] tests/qtest: Add Intel IOMMU bare-metal test
Date: Sat, 14 Mar 2026 09:11:37 +0800
Message-Id: <4bb96344e7d181473b0ed4520bef783cbda586e1.1773450180.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1773450180.git.15fengyuan@gmail.com>
References: <cover.1773450180.git.15fengyuan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=15fengyuan@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
---
 tests/qtest/iommu-intel-test.c | 215 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   2 +
 2 files changed, 217 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c

diff --git a/tests/qtest/iommu-intel-test.c b/tests/qtest/iommu-intel-test.c
new file mode 100644
index 0000000000..ec74a4c0d4
--- /dev/null
+++ b/tests/qtest/iommu-intel-test.c
@@ -0,0 +1,215 @@
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
+    uint64_t ecap = qtest_readq(qts, Q35_IOMMU_BASE + DMAR_ECAP_REG);
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
+    qvtd_run_translation_case(qts, dev, bar, Q35_IOMMU_BASE, cfg);
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
index be4fa627b5..264bce9f81 100644
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
2.39.5


