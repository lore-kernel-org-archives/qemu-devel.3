Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1B2C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmD6g-0001Xt-Av; Tue, 21 Jul 2026 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmD6e-0001Wl-J5; Tue, 21 Jul 2026 12:14:08 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wmD6Y-0006mw-Cc; Tue, 21 Jul 2026 12:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2C
 wr/NQLi2LBpvm2lynDSiv8qhWyCobDkd/OMkiCYzM=; b=SmPO91hXFRM2P5A54r
 DKE96IMIYBXBEayr0VPQ8qpCkRBVishaxe/a6RG1lEb6ng3GPo8J79gU2ePSlRdg
 ccae12p0v03Zc1AzUOgAExgmmk5rx7rumyt0YDL2ow6iBsVfYjGrGdgHxBbGIwue
 pfQLcdE/6ikuG3APbrAfvfimY=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3F6+wml9qkr5qKg--.58375S8; 
 Wed, 22 Jul 2026 00:13:41 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 6/7] tests/qtest: add test for K230 decomp gzip
Date: Wed, 22 Jul 2026 00:13:34 +0800
Message-ID: <20260721161335.73872-7-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721161335.73872-1-dingtao0430@163.com>
References: <20260721161335.73872-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3F6+wml9qkr5qKg--.58375S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFyxtFW3tw4xtr4UAw1DWrg_yoW3uFWfp3
 s8Gw1Yvr18tF4fGanrXF4kCF15WrZ3K34rC3yjgry09rs7JryktFn3t3yrXwn5G3ykZF1F
 9395K3Z09F18XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRyCJ9UUUUU=
X-Originating-IP: [101.204.18.42]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-RVGhGpfmrVfEwAA38
Received-SPF: pass client-ip=117.135.210.5; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Run this qtest:
    $ mkdir build && cd build && ../configure --target-list="riscv64-softmmu"
    $ QTEST_QEMU_BINARY=./qemu-system-riscv64   tests/qtest/k230-decomp-gzip-test

Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 tests/qtest/k230-decomp-gzip-test.c | 181 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   2 +-
 2 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-decomp-gzip-test.c

diff --git a/tests/qtest/k230-decomp-gzip-test.c b/tests/qtest/k230-decomp-gzip-test.c
new file mode 100644
index 0000000000..adddf8f2eb
--- /dev/null
+++ b/tests/qtest/k230-decomp-gzip-test.c
@@ -0,0 +1,181 @@
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
+static const uint8_t test_gzip_data[] = {
+    0x1f, 0x8b, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x02, 0xff, 0xf3, 0x36, 0x32, 0x36, 0x50, 0x48,
+    0xaf, 0xca, 0x2c, 0x50, 0x28, 0x2e, 0x29, 0x4a,
+    0x4d, 0xcc, 0xcd, 0xcc, 0x4b, 0x57, 0x28, 0x49,
+    0x2d, 0x2e, 0xe1, 0xf2, 0x1e, 0x5a, 0x12, 0x00,
+    0xdb, 0x9d, 0xbc, 0xdd, 0xc8, 0x00, 0x00, 0x00,
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


