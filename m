Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900D2C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsaWf-0007Sv-M5; Sat, 08 Aug 2026 02:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaWd-0007Qk-II; Sat, 08 Aug 2026 02:27:19 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wsaWb-0003WW-3b; Sat, 08 Aug 2026 02:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=X9
 De1TlTvMmoNubQUj7YZ0fVNK74eKsFflt0ZdpFXyQ=; b=FthqHBSs8pncmv8o11
 +Gamw31L59kVa9CcTSjbGn99bhxO0OwOscBSAdFk/pgCE+FOm9Ixevgg7tI+fKhg
 gsnSsdDo9JQwox3DRybSmqdgJF0H12zFp5f1f/W4G7dxo7pQmuXxtfogkTxb+L74
 9A8E7ZJwJmoFkZNgFE5+kQEbo=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgC3_wsky3Zq2MzjLw--.10202S5;
 Sat, 08 Aug 2026 14:22:36 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v3 3/7] tests/qtest: add test for K230 gsdma
Date: Sat,  8 Aug 2026 14:22:23 +0800
Message-ID: <20260808062227.66961-4-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808062227.66961-1-dingtao0430@163.com>
References: <20260808062227.66961-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgC3_wsky3Zq2MzjLw--.10202S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw4DtF47Cw1DCFyxJF4rAFb_yoWfuw1Upa
 yFkryayr12kF1rWan7GF1UA3Z8Wrn3Ga48C3y5Wry8uw1xX3s8tFnIq34UWr98JrWkZryF
 93WDKFn8uF1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKg4S9UUUUU=
X-Originating-IP: [101.204.17.203]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4gw2dGp2yyxosgAA3N
Received-SPF: pass client-ip=117.135.210.3; envelope-from=dingtao0430@163.com;
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

This commit adds test cases for GSDMA.
Imitate the behavior of the driver, set LLT and sdma registers.
After the data transmission is completed, check the destination address data.

Update MAINTAINERS for this test.

Run this qtest:
    $ mkdir build && cd build && ../configure --target-list="riscv64-softmmu"
    $ QTEST_QEMU_BINARY=./qemu-system-riscv64   tests/qtest/k230-gsdma-test

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/k230-gsdma-test.c | 201 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   2 +-
 3 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-gsdma-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 49c8013d5f..9c546596e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1835,6 +1835,7 @@ F: include/hw/watchdog/k230_wdt.h
 F: include/hw/dma/k230_gsdma.h
 F: tests/functional/riscv64/test_k230.py
 F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/k230-gsdma-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-gsdma-test.c b/tests/qtest/k230-gsdma-test.c
new file mode 100644
index 0000000000..44d4248739
--- /dev/null
+++ b/tests/qtest/k230-gsdma-test.c
@@ -0,0 +1,201 @@
+/*
+ * QTest testcase for K230 GSDMA
+ *
+ * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "exec/hwaddr.h"
+#include "hw/dma/k230_gsdma.h"
+#include "libqtest.h"
+
+#define K230_GSDMA_BASE              0x80800000
+#define TEST_LLT_ADDR0               0x10000
+#define TEST_LLT_ADDR1               0x10040
+#define TEST_LLT_ADDR2               0x10080
+
+#define TEST_SRC_ADDR0               0x20000
+#define TEST_SRC_ADDR1               0x22000
+#define TEST_SRC_ADDR2               0x23000
+#define TEST_DST_ADDR0               0x30000
+#define TEST_DST_ADDR1               0x32000
+#define TEST_DST_ADDR2               0x33000
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
+static void write_sdma_llt_node_full(QTestState *qts, hwaddr addr,
+                                     uint32_t cfg, hwaddr src,
+                                     uint32_t size, hwaddr dst,
+                                     hwaddr next)
+{
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, cfg), cfg);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, src_addr), src);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_size), size);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_cfg), 0x1);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, dst_addr), dst);
+    qtest_writel(qts, addr + offsetof(K230GSDMALLT, next_llt_addr), next);
+}
+
+static void write_sdma_llt_node(QTestState *qts, hwaddr addr, uint32_t cfg,
+                                uint32_t next)
+{
+    write_sdma_llt_node_full(qts, addr, cfg, 0x11110000, 0x200,
+                             0x22220000, next);
+}
+
+static void fill_pattern(uint8_t *buf, size_t size, uint8_t seed)
+{
+    for (size_t i = 0; i < size; i++) {
+        buf[i] = seed + i * 37;
+    }
+}
+
+static void test_global_registers(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), ==,
+                    K230_GSDMA_DMA_CFG_RESET);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), 0xff);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN)), ==,
+                    K230_GSDMA_DMA_CH_EN_MASK);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK), 0x12345);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK)), ==,
+                    0x12345);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CFG), 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), ==,
+                    0xa5a5a5a5);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT), 0xff55aa55);
+    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT)), ==,
+                    0x55aa55);
+
+    qtest_quit(qts);
+}
+
+static void test_sdma_pause_resume(void)
+{
+    uint32_t int_stat;
+    QTestState *qts = qtest_init("-machine k230");
+
+    write_sdma_llt_node(qts, TEST_LLT_ADDR0, K230_GSDMA_LLT_PAUSE,
+                        TEST_LLT_ADDR1);
+    write_sdma_llt_node(qts, TEST_LLT_ADDR1, K230_GSDMA_LLT_NODE_INTR, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
+                    K230_GSDMA_SDMA_STATUS_PAUSE);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR0);
+
+    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), ==,
+                    K230_GSDMA_SDMA_PAUSE_INT(0));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT), int_stat);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_RESUME);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
+                    0);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR1);
+
+    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
+                    K230_GSDMA_SDMA_DONE_INT(0));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_ITEM_INT(0), ==,
+                    K230_GSDMA_SDMA_ITEM_INT(0));
+
+    qtest_quit(qts);
+}
+
+static void test_sdma_three_llt_copy(void)
+{
+    uint8_t src0[0x1000];
+    uint8_t src1[1];
+    uint8_t src2[511];
+    uint8_t dst0[sizeof(src0)];
+    uint8_t dst1[sizeof(src1)];
+    uint8_t dst2[sizeof(src2)];
+    uint32_t int_stat;
+    QTestState *qts = qtest_init("-machine k230");
+
+    fill_pattern(src0, sizeof(src0), 0x10);
+    fill_pattern(src1, sizeof(src1), 0x31);
+    fill_pattern(src2, sizeof(src2), 0x52);
+    memset(dst0, 0xa5, sizeof(dst0));
+    memset(dst1, 0xa5, sizeof(dst1));
+    memset(dst2, 0xa5, sizeof(dst2));
+
+    qtest_memwrite(qts, TEST_SRC_ADDR0, src0, sizeof(src0));
+    qtest_memwrite(qts, TEST_SRC_ADDR1, src1, sizeof(src1));
+    qtest_memwrite(qts, TEST_SRC_ADDR2, src2, sizeof(src2));
+    qtest_memwrite(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
+    qtest_memwrite(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
+    qtest_memwrite(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
+
+    write_sdma_llt_node_full(qts, TEST_LLT_ADDR0, 0, TEST_SRC_ADDR0,
+                             sizeof(src0), TEST_DST_ADDR0, TEST_LLT_ADDR1);
+    write_sdma_llt_node_full(qts, TEST_LLT_ADDR1, 0, TEST_SRC_ADDR1,
+                             sizeof(src1), TEST_DST_ADDR1, TEST_LLT_ADDR2);
+    write_sdma_llt_node_full(qts, TEST_LLT_ADDR2, 0, TEST_SRC_ADDR2,
+                             sizeof(src2), TEST_DST_ADDR2, 0);
+
+    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
+    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
+
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
+                    0);
+    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
+                    ==, TEST_LLT_ADDR2);
+
+    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
+                    K230_GSDMA_SDMA_DONE_INT(0));
+    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), ==, 0);
+
+    memset(dst0, 0, sizeof(dst0));
+    memset(dst1, 0, sizeof(dst1));
+    memset(dst2, 0, sizeof(dst2));
+    qtest_memread(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
+    qtest_memread(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
+    qtest_memread(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
+
+    g_assert_cmpmem(dst0, sizeof(dst0), src0, sizeof(src0));
+    g_assert_cmpmem(dst1, sizeof(dst1), src1, sizeof(src1));
+    g_assert_cmpmem(dst2, sizeof(dst2), src2, sizeof(src2));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-gsdma/global-registers", test_global_registers);
+    qtest_add_func("/k230-gsdma/sdma-pause-resume", test_sdma_pause_resume);
+    qtest_add_func("/k230-gsdma/sdma-three-llt-copy",
+                   test_sdma_three_llt_copy);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..1b13a777c9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gsdma-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


