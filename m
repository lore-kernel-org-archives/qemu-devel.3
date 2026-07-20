Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254C7C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljaF-0007Ms-8c; Mon, 20 Jul 2026 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wlilW-0002Cq-Qb; Mon, 20 Jul 2026 03:50:18 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingqian_gi@163.com>)
 id 1wlilS-00060R-O5; Mon, 20 Jul 2026 03:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xf
 QAF3pASk/X22PbLv+DG+EvxlGOZRNJcqfEQvSaA/0=; b=ES8BcWDvXJXyZ04DAq
 HkrYotItbqS6WQG/gDNvE0s4RL6pqnFm1CS8hq1YPx7so7VAJKYkhR57mwkPvlf1
 tif1wEMtci7SikfEtkOKDELHbiph+K+ExTCIL1A285wKu2w/n357zEJ5Wn8q4cnk
 fRjQD1EGhvVTAlVitWwcJsCrU=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3sFop0l1qwlRuKw--.5096S5; 
 Mon, 20 Jul 2026 15:45:47 +0800 (CST)
From: Jian Cai <lingqian_gi@163.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: chao.liu@processmission.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: [RFC PATCH 3/3] tests/qtest: add K230 SRAM qtest
Date: Mon, 20 Jul 2026 15:45:45 +0800
Message-ID: <20260720074545.8987-4-lingqian_gi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720074545.8987-1-lingqian_gi@163.com>
References: <20260720074545.8987-1-lingqian_gi@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3sFop0l1qwlRuKw--.5096S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw4fAFWrtF1DAF1kWw4fuFg_yoWxZFWfpr
 WDurn8Kr1xKF4fXwsrJF1UXF1Fgrs3Ca48KrWUCrWv9r4kAryUtF9FgFyj93yDJFWkZ3W5
 uaySq3W3G3WDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bercfUUUUU=
X-Originating-IP: [42.193.175.155]
X-CM-SenderInfo: 5olqw15ldqswrl6rljoofrz/xtbCwguwpmpd0ivnAQAA33
Received-SPF: pass client-ip=117.135.210.4; envelope-from=lingqian_gi@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2026 04:42:41 -0400
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

Add qtest coverage for the K230 SRAM device model.  Six test cases
verify the MMIO region:

- address_mapped:       write/read at SRAM base address
- read_write_consistency: 4-offset write-read verification
- byte_access:          byte-level R/W and 32-bit LE composition
- initial_zeroed:       SRAM is zero-initialized on startup
- unmapped_beyond_range: out-of-range access does not crash QEMU
- write_and_verify_range: 64 KiB step full-range verification

Signed-off-by: Jian Cai <lingqian_gi@163.com>
---
 MAINTAINERS                  |   2 +
 tests/qtest/k230-sram-test.c | 161 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |   3 +-
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-sram-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3567563ba6..eebe8b3def 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,9 +1827,11 @@ F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/riscv/k230_sram.c
 F: include/hw/riscv/k230_sram.h
+F: tests/qtest/k230-sram-test.c
 F: hw/riscv/k230_sram.c
 F: include/hw/riscv/k230_sram.h
 F: tests/qtest/k230-sram-test.c
+F: tests/qtest/k230-sram-test.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
diff --git a/tests/qtest/k230-sram-test.c b/tests/qtest/k230-sram-test.c
new file mode 100644
index 0000000000..b00e1173c5
--- /dev/null
+++ b/tests/qtest/k230-sram-test.c
@@ -0,0 +1,161 @@
+/*
+ * QTest testcase for K230 SRAM
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * The K230 shared SRAM is 2 MB at 0x80200000, accessed directly via the
+ * AXI bus.  It has no software-visible controller registers, so the tests
+ * focus on MMIO read/write consistency across the full range.
+ *
+ * Copyright (c) 2026 Jian Cai <lingqian_gi@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/* K230 SRAM MMIO base address and size */
+#define K230_SRAM_BASE  0x80200000
+#define K230_SRAM_SIZE  (2 * 1024 * 1024) /* 2 MiB */
+
+static void test_address_mapped(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Write a known pattern at the start of SRAM */
+    const uint32_t pattern = 0xDEADBEEF;
+    qtest_writel(qts, K230_SRAM_BASE, pattern);
+
+    /* Read back and verify */
+    uint32_t value = qtest_readl(qts, K230_SRAM_BASE);
+    g_assert_cmphex(value, ==, pattern);
+
+    qtest_quit(qts);
+}
+
+static void test_read_write_consistency(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Write and read back a sequence of patterns at different offsets */
+    static const struct {
+        const char *desc;
+        uint32_t offset;
+        uint32_t pattern;
+    } test_cases[] = {
+        { "start",       0x000000, 0x12345678 },
+        { "mid",         0x100000, 0x9ABCDEF0 }, /* 1 MiB */
+        { "end-4",       K230_SRAM_SIZE - 4, 0xCAFEBABE },
+        { "aligned-256", 0x000100, 0x55AA55AA },
+    };
+
+    for (size_t i = 0; i < G_N_ELEMENTS(test_cases); i++) {
+        uint32_t addr = K230_SRAM_BASE + test_cases[i].offset;
+        qtest_writel(qts, addr, test_cases[i].pattern);
+
+        uint32_t value = qtest_readl(qts, addr);
+        g_assert_cmphex(value, ==, test_cases[i].pattern);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_byte_access(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Verify byte-level access */
+    uint32_t base = K230_SRAM_BASE;
+
+    qtest_writeb(qts, base + 0, 0xAA);
+    qtest_writeb(qts, base + 1, 0xBB);
+    qtest_writeb(qts, base + 2, 0xCC);
+    qtest_writeb(qts, base + 3, 0xDD);
+
+    uint8_t b0 = qtest_readb(qts, base + 0);
+    uint8_t b1 = qtest_readb(qts, base + 1);
+    uint8_t b2 = qtest_readb(qts, base + 2);
+    uint8_t b3 = qtest_readb(qts, base + 3);
+
+    g_assert_cmphex(b0, ==, 0xAA);
+    g_assert_cmphex(b1, ==, 0xBB);
+    g_assert_cmphex(b2, ==, 0xCC);
+    g_assert_cmphex(b3, ==, 0xDD);
+
+    /* Verify 32-bit read sees the combined value (LE) */
+    uint32_t word = qtest_readl(qts, base);
+    g_assert_cmphex(word, ==, 0xDDCCBBAA);
+
+    qtest_quit(qts);
+}
+
+static void test_initial_zeroed(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* SRAM should be zero-initialized by memory_region_init_ram */
+    uint32_t value = qtest_readl(qts, K230_SRAM_BASE);
+    g_assert_cmphex(value, ==, 0);
+
+    value = qtest_readl(qts, K230_SRAM_BASE + K230_SRAM_SIZE - 4);
+    g_assert_cmphex(value, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_unmapped_beyond_range(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /*
+     * Writes beyond the SRAM region should not crash QEMU.
+     * The exact behaviour (unassigned access / abort) is platform-specific;
+     * we just verify the write does not take the process down.
+     */
+    qtest_writel(qts, K230_SRAM_BASE + K230_SRAM_SIZE, 0xBADF00D);
+    qtest_readl(qts, K230_SRAM_BASE + K230_SRAM_SIZE);
+
+    qtest_quit(qts);
+}
+
+static void test_write_and_verify_range(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /*
+     * Write a walking-bit pattern across the full 2 MiB range in
+     * 64 KiB steps, verifying each word writes correctly.
+     */
+    for (uint32_t offset = 0; offset < K230_SRAM_SIZE; offset += 0x10000) {
+        uint32_t addr = K230_SRAM_BASE + offset;
+        uint32_t pattern = offset | 0x3;  /* keep bottom bits set */
+
+        qtest_writel(qts, addr, pattern);
+        uint32_t value = qtest_readl(qts, addr);
+        g_assert_cmphex(value, ==, pattern);
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-sram/address_mapped",
+                   test_address_mapped);
+    qtest_add_func("/k230-sram/read_write_consistency",
+                   test_read_write_consistency);
+    qtest_add_func("/k230-sram/byte_access",
+                   test_byte_access);
+    qtest_add_func("/k230-sram/initial_zeroed",
+                   test_initial_zeroed);
+    qtest_add_func("/k230-sram/unmapped_beyond_range",
+                   test_unmapped_beyond_range);
+    qtest_add_func("/k230-sram/write_and_verify_range",
+                   test_write_and_verify_range);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..cf64539acb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test',
+   'k230-sram-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


