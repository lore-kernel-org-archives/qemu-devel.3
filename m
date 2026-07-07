Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A0C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Ek-0008Ax-Ca; Tue, 07 Jul 2026 13:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh9Ec-0008A1-Ec; Tue, 07 Jul 2026 13:05:27 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wh9EX-0000M0-2j; Tue, 07 Jul 2026 13:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/B
 yKZXimCJi4X7EzjbGxNgZhT93ZP7A7Lx8bsxLV0w4=; b=AO1VOwuOOfbjDYiN4x
 IK/yu75I6HYektc3lU8It96ZMefJBS5apBRYjwbul1+bZZg+sDbSZtd692rXz+kG
 Ve22Ck4zeKPlmO3PYBy5KTAcuxysOkgH4romEsfxs06sr5b32xspP2CdUCqY7Vpo
 N2TJk0wyU0KDEBgfTiJqA47zs=
Received: from dt-VM.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wCHJnO9MU1qKkBHHw--.27147S4; 
 Wed, 08 Jul 2026 01:05:03 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Ding <dingtao0430@163.com>
Subject: [PATCH v5 2/2] qtest: add xilinx-zynq SDHCI sdma test
Date: Wed,  8 Jul 2026 01:04:57 +0800
Message-ID: <20260707170457.11659-3-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707170457.11659-1-dingtao0430@163.com>
References: <20260707170457.11659-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHJnO9MU1qKkBHHw--.27147S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFyDWF4rGF4xuF1xXw4UXFb_yoW3XryDpa
 yj9FyjyrZ0yF18Xrs3G3W5tF1Y9rsxZa4UWFW5urs2kr4kJF9Fvrs7KFyUXrs7JrW8XFyr
 urs8WF1DGw1xWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi8nY7UUUUU=
X-Originating-IP: [175.152.42.218]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC4R9pp2pNMb9+xAAA3j
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

Add a standalone qtest for the SDHCI controller on the
xilinx-zynq-a9 machine.

The test covers the SDMA boundary continuation case for a
multi-block read. After the controller stops at a boundary,
software updates SYSAD to continue the transfer. This verifies
the generic SDHCI behavior that previously failed when the
continuation SYSAD write was ignored and the transfer stalled.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
Build:
  mkdir build
  cd build
  ../configure --target-list="arm-softmmu"  --disable-slirp --enable-debug --disable-werror
  make -j4

Run:
  QTEST_QEMU_BINARY=./qemu-system-arm \
  tests/qtest/xilinx-zynq-sdhci-test

Before the fix, the test fails with a BLKCNT assertion:
  ERROR:../tests/qtest/xilinx-zynq-sdhci-test.c:90:wait_for_block_count: 
  assertion failed (qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT) == expected): (1 == 0)

After applying the fix, the test passes:
  ok 1 /arm/xilinx-zynq-sdhci/sdma/read-boundary-continue

 tests/qtest/meson.build              |   1 +
 tests/qtest/xilinx-zynq-sdhci-test.c | 178 +++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 tests/qtest/xilinx-zynq-sdhci-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2ae720156f..c12a35721d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -244,6 +244,7 @@ qtests_arm = \
    config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
+  (config_all_devices.has_key('CONFIG_ZYNQ') ? ['xilinx-zynq-sdhci-test'] : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
diff --git a/tests/qtest/xilinx-zynq-sdhci-test.c b/tests/qtest/xilinx-zynq-sdhci-test.c
new file mode 100644
index 0000000000..1be9bdabf7
--- /dev/null
+++ b/tests/qtest/xilinx-zynq-sdhci-test.c
@@ -0,0 +1,178 @@
+/*
+* QTests for the Xilinx Zynq SDHCI controller.
+*
+* Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
+*
+* SPDX-License-Identifier: GPL-2.0-or-later
+*/
+
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#include "libqtest.h"
+#include "libqtest-single.h"
+#include "libqos/sdhci-cmd.h"
+
+#define XILINX_ZYNQ_MMC_BA             0xE0100000
+#define XILINX_ZYNQ_BLK_SIZE           512
+#define XILINX_ZYNQ_TEST_IMAGE_SIZE    (1 << 20)
+#define XILINX_ZYNQ_SDMA_BOUNDARY_ARG  7
+#define XILINX_ZYNQ_SDMA_BOUNDARY_SIZE (512 * 1024)
+#define XILINX_ZYNQ_SDMA_BLOCK_COUNT \
+    ((XILINX_ZYNQ_SDMA_BOUNDARY_SIZE / XILINX_ZYNQ_BLK_SIZE) + 1)
+#define XILINX_ZYNQ_SDMA_TRANSFER_SIZE \
+    (XILINX_ZYNQ_SDMA_BLOCK_COUNT * XILINX_ZYNQ_BLK_SIZE)
+#define XILINX_ZYNQ_DMA_ADDR           0x00100000
+
+#define SDHC_MAKE_BLKSZ(boundary, size) (((boundary) << 12) | (size))
+
+static char *sd_path;
+
+static QTestState *setup_sd_card(void)
+{
+    QTestState *qts;
+    uint16_t rca;
+
+    qts = qtest_initf(
+        "-machine xilinx-zynq-a9 "
+        "-drive if=sd,index=0,file=%s,format=raw,auto-read-only=off",
+        sd_path);
+
+    qtest_writew(qts, XILINX_ZYNQ_MMC_BA + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, XILINX_ZYNQ_MMC_BA + SDHC_CLKCON,
+                 SDHC_CLOCK_SDCLK_EN | SDHC_CLOCK_INT_STABLE |
+                 SDHC_CLOCK_INT_EN);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0, 0, SDHC_APP_CMD);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0x41200000, 0,
+                   (41 << 8));
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, 0, 0,
+                   SDHC_SEND_RELATIVE_ADDR | SDHC_CMD_RESPONSE);
+    rca = qtest_readl(qts, XILINX_ZYNQ_MMC_BA + SDHC_RSPREG0) >> 16;
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA, 0, 0, rca << 16, 0,
+                   SDHC_SELECT_DESELECT_CARD);
+
+    return qts;
+}
+
+static void write_pattern_to_image(size_t offset, size_t len)
+{
+    int fd;
+    int ret;
+    uint8_t *buf = g_malloc(len);
+
+    for (size_t i = 0; i < len; i++) {
+        buf[i] = (i * 13 + 7) & 0xff;
+    }
+
+    fd = open(sd_path, O_WRONLY);
+    g_assert_cmpint(fd, >=, 0);
+    ret = pwrite(fd, buf, len, offset);
+    close(fd);
+    g_assert_cmpint(ret, ==, len);
+
+    g_free(buf);
+}
+
+static void wait_for_block_count(QTestState *qts, uint16_t expected)
+{
+    int i;
+
+    for (i = 0; i < 1000; i++) {
+        if (qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT) == expected) {
+            return;
+        }
+        g_usleep(100);
+    }
+
+    g_assert_cmpuint(qtest_readw(qts, XILINX_ZYNQ_MMC_BA + SDHC_BLKCNT),
+                     ==, expected);
+}
+
+/*
+ * SDMA stops at each boundary and requires software to update SYSAD
+ * to continue. The bug this test covers leaves DOING_READ/WRITE asserted,
+ * so the continuation SYSAD write is ignored and the transfer stalls.
+ */
+static void test_read_sdma_boundary_continue(void)
+{
+    QTestState *qts = setup_sd_card();
+    uint8_t *actual = g_malloc0(XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+    uint8_t *expected = g_malloc(XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+
+    write_pattern_to_image(0, XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+
+    for (size_t i = 0; i < XILINX_ZYNQ_SDMA_TRANSFER_SIZE; i++) {
+        expected[i] = (i * 13 + 7) & 0xff;
+    }
+
+    qtest_writel(qts, XILINX_ZYNQ_DMA_ADDR, 0xdeadbeef);
+    qtest_writel(qts, XILINX_ZYNQ_DMA_ADDR + XILINX_ZYNQ_SDMA_BOUNDARY_SIZE,
+                 0xcafef00d);
+
+    qtest_writel(qts, XILINX_ZYNQ_MMC_BA + SDHC_SYSAD, XILINX_ZYNQ_DMA_ADDR);
+    sdhci_cmd_regs(qts, XILINX_ZYNQ_MMC_BA,
+                   SDHC_MAKE_BLKSZ(XILINX_ZYNQ_SDMA_BOUNDARY_ARG,
+                                   XILINX_ZYNQ_BLK_SIZE),
+                   XILINX_ZYNQ_SDMA_BLOCK_COUNT, 0,
+                   SDHC_TRNS_DMA | SDHC_TRNS_MULTI | SDHC_TRNS_READ |
+                   SDHC_TRNS_BLK_CNT_EN,
+                   SDHC_READ_MULTIPLE_BLOCK | SDHC_CMD_DATA_PRESENT);
+
+    wait_for_block_count(qts, 1);
+
+    qtest_writew(qts, XILINX_ZYNQ_MMC_BA + SDHC_NORINTSTS, 0xffff);
+    qtest_writel(qts, XILINX_ZYNQ_MMC_BA + SDHC_SYSAD,
+                 XILINX_ZYNQ_DMA_ADDR + XILINX_ZYNQ_SDMA_BOUNDARY_SIZE);
+
+    wait_for_block_count(qts, 0);
+
+    qtest_memread(qts, XILINX_ZYNQ_DMA_ADDR, actual,
+                  XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+    g_assert_cmpmem(actual, XILINX_ZYNQ_SDMA_TRANSFER_SIZE,
+                    expected, XILINX_ZYNQ_SDMA_TRANSFER_SIZE);
+
+    g_free(expected);
+    g_free(actual);
+    qtest_quit(qts);
+}
+
+static void drive_destroy(void)
+{
+    unlink(sd_path);
+    g_free(sd_path);
+}
+
+static void drive_create(void)
+{
+    int fd;
+    int ret;
+    GError *error = NULL;
+
+    fd = g_file_open_tmp("xilinx-zynq-sdhci.XXXXXX", &sd_path, &error);
+    if (fd == -1) {
+        fprintf(stderr, "unable to create sdhci file: %s\n", error->message);
+        g_error_free(error);
+    }
+    g_assert_nonnull(sd_path);
+
+    ret = ftruncate(fd, XILINX_ZYNQ_TEST_IMAGE_SIZE);
+    g_assert_cmpint(ret, ==, 0);
+    close(fd);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    drive_create();
+
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("xilinx-zynq-sdhci/sdma/read-boundary-continue",
+                   test_read_sdma_boundary_continue);
+
+    ret = g_test_run();
+    drive_destroy();
+    return ret;
+}
-- 
2.43.0


