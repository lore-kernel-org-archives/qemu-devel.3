Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B75CD1CDCD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BOw-0003Ps-UN; Tue, 22 Oct 2024 05:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BOt-0003KP-SI; Tue, 22 Oct 2024 05:42:03 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BOs-00019W-0O; Tue, 22 Oct 2024 05:42:03 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 22 Oct
 2024 17:41:15 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 22 Oct 2024 17:41:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 11/18] test/qtest/aspeed_smc-test: Support to test all CE
 pins
Date: Tue, 22 Oct 2024 17:41:03 +0800
Message-ID: <20241022094110.1574011-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, these test cases only support to test CE0. To test all CE pins,
introduces new ce and node members in TestData structure. The ce member is used
for saving the ce index and node member is used for saving the node path,
respectively.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed_smc-test.c | 77 ++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 4c62009605..b8ab20b43d 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -32,11 +32,11 @@
  * ASPEED SPI Controller registers
  */
 #define R_CONF              0x00
-#define   CONF_ENABLE_W0       (1 << 16)
+#define   CONF_ENABLE_W0       16
 #define R_CE_CTRL           0x04
 #define   CRTL_EXTENDED0       0  /* 32 bit addressing for SPI */
 #define R_CTRL0             0x10
-#define   CTRL_CE_STOP_ACTIVE  (1 << 2)
+#define   CTRL_CE_STOP_ACTIVE  BIT(2)
 #define   CTRL_READMODE        0x0
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
@@ -70,6 +70,8 @@ typedef struct TestData {
     uint64_t flash_base;
     uint32_t jedec_id;
     char *tmp_path;
+    uint8_t cs;
+    const char *node;
 } TestData;
 
 /*
@@ -140,34 +142,37 @@ static void spi_ce_ctrl(const TestData *data, uint32_t value)
 
 static void spi_ctrl_setmode(const TestData *data, uint8_t mode, uint8_t cmd)
 {
-    uint32_t ctrl = spi_readl(data, R_CTRL0);
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
     ctrl &= ~(CTRL_USERMODE | 0xff << 16);
     ctrl |= mode | (cmd << 16);
-    spi_writel(data, R_CTRL0, ctrl);
+    spi_writel(data, ctrl_reg, ctrl);
 }
 
 static void spi_ctrl_start_user(const TestData *data)
 {
-    uint32_t ctrl = spi_readl(data, R_CTRL0);
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
 
     ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    spi_writel(data, R_CTRL0, ctrl);
+    spi_writel(data, ctrl_reg, ctrl);
 
     ctrl &= ~CTRL_CE_STOP_ACTIVE;
-    spi_writel(data, R_CTRL0, ctrl);
+    spi_writel(data, ctrl_reg, ctrl);
 }
 
 static void spi_ctrl_stop_user(const TestData *data)
 {
-    uint32_t ctrl = spi_readl(data, R_CTRL0);
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
 
     ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    spi_writel(data, R_CTRL0, ctrl);
+    spi_writel(data, ctrl_reg, ctrl);
 }
 
 static void flash_reset(const TestData *data)
 {
-    spi_conf(data, CONF_ENABLE_W0);
+    spi_conf(data, 1 << (CONF_ENABLE_W0 + data->cs));
 
     spi_ctrl_start_user(data);
     flash_writeb(data, 0, RESET_ENABLE);
@@ -177,7 +182,7 @@ static void flash_reset(const TestData *data)
     flash_writeb(data, 0, WRDI);
     spi_ctrl_stop_user(data);
 
-    spi_conf_remove(data, CONF_ENABLE_W0);
+    spi_conf_remove(data, 1 << (CONF_ENABLE_W0 + data->cs));
 }
 
 static void test_read_jedec(const void *data)
@@ -185,7 +190,7 @@ static void test_read_jedec(const void *data)
     const TestData *test_data = (const TestData *)data;
     uint32_t jedec = 0x0;
 
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, JEDEC_READ);
@@ -255,7 +260,7 @@ static void test_erase_sector(const void *data)
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     /*
      * Previous page should be full of 0xffs after backend is
@@ -307,7 +312,7 @@ static void test_erase_all(const void *data)
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     /*
      * Previous page should be full of 0xffs after backend is
@@ -358,7 +363,7 @@ static void test_write_page(const void *data)
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, EN_4BYTE_ADDR);
@@ -396,13 +401,12 @@ static void test_read_page_mem(const void *data)
     int i;
 
     /*
-     * Enable 4BYTE mode for controller. This is should be strapped by
-     * HW for CE0 anyhow.
+     * Enable 4BYTE mode for controller.
      */
-    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
 
     /* Enable 4BYTE mode for flash. */
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, EN_4BYTE_ADDR);
     flash_writeb(test_data, 0, WREN);
@@ -414,7 +418,7 @@ static void test_read_page_mem(const void *data)
         flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
     }
     spi_ctrl_stop_user(test_data);
-    spi_conf_remove(test_data, CONF_ENABLE_W0);
+    spi_conf_remove(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     /* Check what was written */
     read_page_mem(test_data, my_page_addr, page);
@@ -439,13 +443,12 @@ static void test_write_page_mem(const void *data)
     int i;
 
     /*
-     * Enable 4BYTE mode for controller. This is should be strapped by
-     * HW for CE0 anyhow.
+     * Enable 4BYTE mode for controller.
      */
-    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
 
     /* Enable 4BYTE mode for flash. */
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, EN_4BYTE_ADDR);
     flash_writeb(test_data, 0, WREN);
@@ -473,7 +476,7 @@ static void test_read_status_reg(const void *data)
     const TestData *test_data = (const TestData *)data;
     uint8_t r;
 
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, RDSR);
@@ -482,7 +485,7 @@ static void test_read_status_reg(const void *data)
 
     g_assert_cmphex(r & SR_WEL, ==, 0);
     g_assert(!qtest_qom_get_bool
-            (test_data->s, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
+            (test_data->s, test_data->node, "write-enable"));
 
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, WREN);
@@ -492,7 +495,7 @@ static void test_read_status_reg(const void *data)
 
     g_assert_cmphex(r & SR_WEL, ==, SR_WEL);
     g_assert(qtest_qom_get_bool
-            (test_data->s, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
+            (test_data->s, test_data->node, "write-enable"));
 
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, WRDI);
@@ -502,7 +505,7 @@ static void test_read_status_reg(const void *data)
 
     g_assert_cmphex(r & SR_WEL, ==, 0);
     g_assert(!qtest_qom_get_bool
-            (test_data->s, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
+            (test_data->s, test_data->node, "write-enable"));
 
     flash_reset(test_data);
 }
@@ -512,7 +515,7 @@ static void test_status_reg_write_protection(const void *data)
     const TestData *test_data = (const TestData *)data;
     uint8_t r;
 
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     /* default case: WP# is high and SRWD is low -> status register writable */
     spi_ctrl_start_user(test_data);
@@ -537,8 +540,7 @@ static void test_status_reg_write_protection(const void *data)
     g_assert_cmphex(r & SRWD, ==, 0);
 
     /* WP# low and SRWD low -> status register writable */
-    qtest_set_irq_in(test_data->s,
-                     "/machine/soc/fmc/ssi.0/child[0]", "WP#", 0, 0);
+    qtest_set_irq_in(test_data->s, test_data->node, "WP#", 0, 0);
     spi_ctrl_start_user(test_data);
     flash_writeb(test_data, 0, WREN);
     /* test ability to write SRWD */
@@ -561,8 +563,7 @@ static void test_status_reg_write_protection(const void *data)
     /* write is not successful */
     g_assert_cmphex(r & SRWD, ==, SRWD);
 
-    qtest_set_irq_in(test_data->s,
-                     "/machine/soc/fmc/ssi.0/child[0]", "WP#", 0, 1);
+    qtest_set_irq_in(test_data->s, test_data->node, "WP#", 0, 1);
     flash_reset(test_data);
 }
 
@@ -572,8 +573,8 @@ static void test_write_block_protect(const void *data)
     uint32_t sector_size = 65536;
     uint32_t n_sectors = 512;
 
-    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     uint32_t bp_bits = 0b0;
 
@@ -617,8 +618,8 @@ static void test_write_block_protect_bottom_bit(const void *data)
     uint32_t sector_size = 65536;
     uint32_t n_sectors = 512;
 
-    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
-    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     /* top bottom bit is enabled */
     uint32_t bp_bits = 0b00100 << 3;
@@ -676,6 +677,8 @@ static void test_palmetto_bmc(TestData *data)
     data->flash_base = 0x20000000;
     data->spi_base = 0x1E620000;
     data->jedec_id = 0x20ba19;
+    data->cs = 0;
+    data->node = "/machine/soc/fmc/ssi.0/child[0]";
 
     qtest_add_data_func("/ast2400/smc/read_jedec", data, test_read_jedec);
     qtest_add_data_func("/ast2400/smc/erase_sector", data, test_erase_sector);
-- 
2.34.1


