Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E2C5AC67
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsaWZ-0007Q0-AU; Sat, 08 Aug 2026 02:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaWX-0007PB-OQ; Sat, 08 Aug 2026 02:27:13 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaWV-0003WM-BV; Sat, 08 Aug 2026 02:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=au
 6PYCyTOdw4bLLTGp/hZOCcHgOCRHJMR57/EVoNumI=; b=BKDK2SS6EaRDLF2Nmt
 lRtP5wMF1HMKDnZu8CwJisrDRETY6Bjxp0sRoPXkfdcKxdcV+jf5iodJNvakvWXl
 rDTQQCVLAna8Ft63N4UuxHDfIPiZ6ZQ2DbFDz8a96FUc92+5y31xDvKODvKpVqnR
 GV9aRD5mjyIl35UL4msCeBFT0=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgC3_wsky3Zq2MzjLw--.10202S8;
 Sat, 08 Aug 2026 14:22:37 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v3 6/7] tests/qtest: add test for K230 decomp gzip
Date: Sat,  8 Aug 2026 14:22:26 +0800
Message-ID: <20260808062227.66961-7-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808062227.66961-1-dingtao0430@163.com>
References: <20260808062227.66961-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgC3_wsky3Zq2MzjLw--.10202S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxKry5Zr15Kw1rXFWDZw13urg_yoWfKr1kp3
 45Gw1Yvr10qF1fKanrXF1vkF1rWrZ3C348C3yjgry09r4kJryktF13t3y8Xw1kGrWkZF4F
 93s5tFn09F1xXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBBTnUUUUU=
X-Originating-IP: [101.204.17.203]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4g02dGp2yy1owgAA39
Received-SPF: pass client-ip=220.197.31.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This commit adds test cases for Decomp_gzip.
A compressed data segment has been pre-set, configure GSDMA and decomp_gzip.
Compare the decompressed data with the original data

Update MAINTAINERS for this test.

Run this qtest:
    $ mkdir build && cd build && ../configure --target-list="riscv64-softmmu"
    $ QTEST_QEMU_BINARY=./qemu-system-riscv64   tests/qtest/k230-decomp-gzip-test

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 MAINTAINERS                         |   1 +
 tests/qtest/k230-decomp-gzip-test.c | 200 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   2 +-
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c260199142..dcfcc51144 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1838,6 +1838,7 @@ F: include/hw/misc/k230_decomp_gzip.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-wdt-test.c
 F: tests/qtest/k230-gsdma-test.c
+F: tests/qtest/k230-decomp-gzip-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-decomp-gzip-test.c b/tests/qtest/k230-decomp-gzip-test.c
new file mode 100644
index 0000000000..e80113fd28
--- /dev/null
+++ b/tests/qtest/k230-decomp-gzip-test.c
@@ -0,0 +1,200 @@
+/*
+ * QTest testcase for K230 GZIP decompression engine
+ *
+ * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/dma/k230_gsdma.h"
+#include "hw/misc/k230_decomp_gzip.h"
+
+#define K230_DECOMP_GZIP_BASE 0x80808000
+#define K230_GSDMA_BASE       0x80800000
+#define K230_SRAM_BASE        0x80200000
+#define TEST_LLT_ADDR0        0x01000000
+#define TEST_LLT_ADDR1        0x01000040
+#define TEST_SRC_ADDR         0x01100000
+#define TEST_DST_ADDR         0x01200000
+
+#define TEST_PAYLOAD_LEN          (sizeof(test_payload) - 1)
+
+static inline uint64_t gzip_reg(hwaddr off)
+{
+    return K230_DECOMP_GZIP_BASE + off;
+}
+
+static inline uint64_t gsdma_reg(hwaddr off)
+{
+    return K230_GSDMA_BASE + off;
+}
+
+static inline uint64_t gsdma_ch_reg(unsigned int ch, hwaddr off)
+{
+    return K230_GSDMA_BASE + K230_GSDMA_CH_BASE +
+           ch * K230_GSDMA_CH_STRIDE + off;
+}
+
+static inline hwaddr k230_sram_addr(hwaddr off)
+{
+    return K230_SRAM_BASE + off;
+}
+
+static inline hwaddr k230_sram_input_addr(unsigned int slot)
+{
+    return k230_sram_addr(K230_DECOMP_GZIP_SRAM_IN_BASE +
+                          slot * K230_DECOMP_GZIP_BLOCK_SIZE);
+}
+
+/*
+ * test_gzip_data was generated by compressing test_payload in gzip format
+ * using Dynamic Huffman coding. The compression method byte in the gzip
+ * header was then changed from the standard value 0x08 to the K230-specific
+ * value 0x09.
+ */
+static const uint8_t test_gzip_data[] = {
+    0x1f, 0x8b, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x04, 0x03, 0x05, 0xc1, 0xb1, 0x0d, 0x00, 0x20,
+    0x08, 0x04, 0xc0, 0x9e, 0x29, 0x7e, 0x04, 0x23,
+    0x63, 0x38, 0x85, 0x05, 0x21, 0x14, 0x10, 0x23,
+    0x5f, 0x39, 0xbd, 0x77, 0x6b, 0xea, 0x80, 0xbf,
+    0x38, 0x68, 0x5e, 0xdb, 0x19, 0xe5, 0xa0, 0x35,
+    0x65, 0x4d, 0x1d, 0xf0, 0x17, 0x07, 0xcd, 0x6b,
+    0x3b, 0xa3, 0x1c, 0xb4, 0xa6, 0xac, 0xa9, 0x03,
+    0xfe, 0xe2, 0xa0, 0x79, 0x6d, 0x67, 0x94, 0x83,
+    0xd6, 0x94, 0x35, 0x75, 0xc0, 0x5f, 0x1c, 0x34,
+    0xaf, 0xed, 0x8c, 0x72, 0xd0, 0x9a, 0xb2, 0xa6,
+    0x0e, 0xf8, 0x8b, 0x83, 0xe6, 0xb5, 0x9d, 0x51,
+    0x0e, 0x5a, 0x53, 0xd6, 0xd4, 0x01, 0x7f, 0x71,
+    0xd0, 0xbc, 0xb6, 0x33, 0xca, 0x41, 0x6b, 0xca,
+    0x9a, 0x3a, 0xe0, 0x2f, 0x0e, 0x9a, 0xd7, 0x76,
+    0x46, 0x39, 0x68, 0x4d, 0x59, 0x53, 0x07, 0xfc,
+    0xc5, 0x41, 0xf3, 0xda, 0xce, 0x28, 0x07, 0xad,
+    0x29, 0x1f, 0xdb, 0x9d, 0xbc, 0xdd, 0xc8, 0x00,
+    0x00, 0x00,
+};
+
+static const uint8_t test_payload[] =
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n"
+    "K230 gzip streaming test\n";
+
+static void write_sdma_llt_node(QTestState *qts, hwaddr addr, uint32_t src,
+                                uint32_t dst, uint32_t len, uint32_t next)
+{
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, cfg), 0);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, src_addr), src);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_size), len);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_cfg), 0x1);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, dst_addr), dst);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, next_llt_addr), next);
+}
+
+static void test_reset_and_rw(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_DECOMP_START)),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_SRC_SIZE)),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_OUT_SIZE)),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_DECOMP_STAT)),
+                    ==, 0);
+
+    qtest_writel(qts, gzip_reg(K230_DECOMP_GZIP_DECOMP_START),
+                 K230_DECOMP_GZIP_START);
+
+    qtest_writel(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_SRC_SIZE), 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_SRC_SIZE)),
+                    ==, 0xffffffff);
+
+    qtest_writel(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_OUT_SIZE), 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_OUT_SIZE)),
+                    ==, 0x12345678);
+
+    qtest_quit(qts);
+}
+
+static void test_gsdma_handshake_flow(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t stat;
+    uint8_t output[TEST_PAYLOAD_LEN];
+
+    qtest_memwrite(qts, TEST_SRC_ADDR, test_gzip_data, sizeof(test_gzip_data));
+    write_sdma_llt_node(qts, TEST_LLT_ADDR0, TEST_SRC_ADDR,
+                        k230_sram_input_addr(0),
+                        sizeof(test_gzip_data), 0);
+    write_sdma_llt_node(qts, TEST_LLT_ADDR1,
+                        k230_sram_addr(K230_DECOMP_GZIP_SRAM_OUT_BASE),
+                        TEST_DST_ADDR, TEST_PAYLOAD_LEN, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0) | BIT(1));
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CFG),
+                 K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN);
+    qtest_writel(qts, gsdma_ch_reg(1, K230_GSDMA_CH_CFG), 0);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
+    qtest_writel(qts, gsdma_ch_reg(1, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR1);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
+    qtest_writel(qts, gsdma_ch_reg(1, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN)),
+                    ==, BIT(0) | BIT(1));
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CFG)) &
+                    K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN,
+                    ==, K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR)),
+                    ==, TEST_LLT_ADDR0);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(1, K230_GSDMA_CH_LLT_SADDR)),
+                    ==, TEST_LLT_ADDR1);
+
+    qtest_writel(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_SRC_SIZE),
+                 K230_DECOMP_GZIP_CTRL_EN | sizeof(test_gzip_data));
+    qtest_writel(qts, gzip_reg(K230_DECOMP_GZIP_GZIP_OUT_SIZE),
+                 TEST_PAYLOAD_LEN);
+    qtest_writel(qts, gzip_reg(K230_DECOMP_GZIP_DECOMP_START),
+                 K230_DECOMP_GZIP_START);
+
+    stat = qtest_readl(qts, gzip_reg(K230_DECOMP_GZIP_DECOMP_STAT));
+    g_assert_cmphex(stat & K230_DECOMP_GZIP_STAT_CRC_OK, ==,
+                    K230_DECOMP_GZIP_STAT_CRC_OK);
+
+    g_assert_cmphex(qtest_readl(qts,
+                                gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR0);
+    g_assert_cmphex(qtest_readl(qts,
+                                gsdma_ch_reg(1, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR1);
+
+    stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
+                    K230_GSDMA_SDMA_DONE_INT(0));
+    g_assert_cmphex(stat & K230_GSDMA_SDMA_DONE_INT(1), ==,
+                    K230_GSDMA_SDMA_DONE_INT(1));
+
+    qtest_memread(qts, TEST_DST_ADDR, output, sizeof(output));
+    g_assert_cmpmem(output, sizeof(output), test_payload, TEST_PAYLOAD_LEN);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-decomp-gzip/reset-and-rw", test_reset_and_rw);
+    qtest_add_func("/k230-decomp-gzip/gsdma-handshake-flow",
+                   test_gsdma_handshake_flow);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1b13a777c9..7da12421af 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gsdma-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gsdma-test', 'k230-decomp-gzip-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


