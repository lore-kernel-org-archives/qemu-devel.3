Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D463AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGH5-0006Cu-Rq; Wed, 11 Dec 2024 01:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGF-0004mT-DG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGB-0008Vy-PD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A156I0tFkKuxsiWVuqE3BA+LY5ON5bhmxzR+rrHFI4A=;
 b=Mml/r9ohXs0EGyoeHu2rhO9mfKDYDxrpxPPk0qx4IPKhjx2uONnUs3KmDZoOS+VxSRr6OL
 rxqyglmWMjF1e+nfy/o5QcQfZ4OYO206rnoSc00OB0PDpzduiZQWnm5AFzR3NSjmIh/lzT
 dgxoN03uj9B6xS+qEMuEbCdkeJjj8t0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-8KFMQld1PsuSXiTWQhkD_g-1; Wed,
 11 Dec 2024 01:31:43 -0500
X-MC-Unique: 8KFMQld1PsuSXiTWQhkD_g-1
X-Mimecast-MFC-AGG-ID: 8KFMQld1PsuSXiTWQhkD_g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACD381954ADD; Wed, 11 Dec 2024 06:31:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C1111956054; Wed, 11 Dec 2024 06:31:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/24] test/qtest/aspeed_smc-test: Support to test all CE pins
Date: Wed, 11 Dec 2024 07:30:51 +0100
Message-ID: <20241211063058.1222038-18-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
References: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Currently, these test cases only support to test CE0. To test all CE pins,
introduces new ce and node members in TestData structure. The ce member is used
for saving the ce index and node member is used for saving the node path,
respectively.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20241127091543.1243114-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed_smc-test.c | 77 ++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 4c62009605d0..b8ab20b43dd6 100644
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
2.47.1


