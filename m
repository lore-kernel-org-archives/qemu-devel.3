Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D30BD3C54E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 05:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1fah-00006e-KB; Fri, 18 Oct 2024 01:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t1faf-000069-RA; Fri, 18 Oct 2024 01:31:57 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t1fac-00089Y-AV; Fri, 18 Oct 2024 01:31:57 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 18 Oct
 2024 13:31:15 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 18 Oct 2024 13:31:15 +0800
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
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 09/16] test/qtest/aspeed_smc-test: Introduce a new TestData
 to test different BMC SOCs
Date: Fri, 18 Oct 2024 13:31:05 +0800
Message-ID: <20241018053112.1886173-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, these test cases are only used for testing fmc_cs0 for AST2400.
To test others BMC SOCs, introduces a new TestData structure.
Users can set the spi base address, flash base address, jedesc id and so on
for different BMC SOCs and flash model testing.

Introduce new helper functions to make the test case more readable.

Set spi base address 0x1E620000, flash_base address 0x20000000
and jedec id 0x20ba19 for fmc_cs0 with n25q256a flash for AST2400
SMC model testing.

To pass the TestData into the test case, replace qtest_add_func with
qtest_add_data_func.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed_smc-test.c | 546 +++++++++++++++++++---------------
 1 file changed, 299 insertions(+), 247 deletions(-)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index ec1fa6ec15..4c62009605 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -43,9 +43,6 @@
 #define   CTRL_USERMODE        0x3
 #define SR_WEL BIT(1)
 
-#define ASPEED_FMC_BASE    0x1E620000
-#define ASPEED_FLASH_BASE  0x20000000
-
 /*
  * Flash commands
  */
@@ -65,11 +62,16 @@ enum {
     ERASE_SECTOR = 0xd8,
 };
 
-#define FLASH_JEDEC         0x20ba19  /* n25q256a */
-#define FLASH_SIZE          (32 * 1024 * 1024)
-
 #define FLASH_PAGE_SIZE           256
 
+typedef struct TestData {
+    QTestState *s;
+    uint64_t spi_base;
+    uint64_t flash_base;
+    uint32_t jedec_id;
+    char *tmp_path;
+} TestData;
+
 /*
  * Use an explicit bswap for the values read/wrote to the flash region
  * as they are BE and the Aspeed CPU is LE.
@@ -79,275 +81,315 @@ static inline uint32_t make_be32(uint32_t data)
     return bswap32(data);
 }
 
-static void spi_conf(uint32_t value)
+static inline void spi_writel(const TestData *data, uint64_t offset,
+                              uint32_t value)
+{
+    qtest_writel(data->s, data->spi_base + offset, value);
+}
+
+static inline uint32_t spi_readl(const TestData *data, uint64_t offset)
+{
+    return qtest_readl(data->s, data->spi_base + offset);
+}
+
+static inline void flash_writeb(const TestData *data, uint64_t offset,
+                                uint8_t value)
+{
+    qtest_writeb(data->s, data->flash_base + offset, value);
+}
+
+static inline void flash_writel(const TestData *data, uint64_t offset,
+                                uint32_t value)
+{
+    qtest_writel(data->s, data->flash_base + offset, value);
+}
+
+static inline uint8_t flash_readb(const TestData *data, uint64_t offset)
 {
-    uint32_t conf = readl(ASPEED_FMC_BASE + R_CONF);
+    return qtest_readb(data->s, data->flash_base + offset);
+}
+
+static inline uint32_t flash_readl(const TestData *data, uint64_t offset)
+{
+    return qtest_readl(data->s, data->flash_base + offset);
+}
+
+static void spi_conf(const TestData *data, uint32_t value)
+{
+    uint32_t conf = spi_readl(data, R_CONF);
 
     conf |= value;
-    writel(ASPEED_FMC_BASE + R_CONF, conf);
+    spi_writel(data, R_CONF, conf);
 }
 
-static void spi_conf_remove(uint32_t value)
+static void spi_conf_remove(const TestData *data, uint32_t value)
 {
-    uint32_t conf = readl(ASPEED_FMC_BASE + R_CONF);
+    uint32_t conf = spi_readl(data, R_CONF);
 
     conf &= ~value;
-    writel(ASPEED_FMC_BASE + R_CONF, conf);
+    spi_writel(data, R_CONF, conf);
 }
 
-static void spi_ce_ctrl(uint32_t value)
+static void spi_ce_ctrl(const TestData *data, uint32_t value)
 {
-    uint32_t conf = readl(ASPEED_FMC_BASE + R_CE_CTRL);
+    uint32_t conf = spi_readl(data, R_CE_CTRL);
 
     conf |= value;
-    writel(ASPEED_FMC_BASE + R_CE_CTRL, conf);
+    spi_writel(data, R_CE_CTRL, conf);
 }
 
-static void spi_ctrl_setmode(uint8_t mode, uint8_t cmd)
+static void spi_ctrl_setmode(const TestData *data, uint8_t mode, uint8_t cmd)
 {
-    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    uint32_t ctrl = spi_readl(data, R_CTRL0);
     ctrl &= ~(CTRL_USERMODE | 0xff << 16);
     ctrl |= mode | (cmd << 16);
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    spi_writel(data, R_CTRL0, ctrl);
 }
 
-static void spi_ctrl_start_user(void)
+static void spi_ctrl_start_user(const TestData *data)
 {
-    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    uint32_t ctrl = spi_readl(data, R_CTRL0);
 
     ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    spi_writel(data, R_CTRL0, ctrl);
 
     ctrl &= ~CTRL_CE_STOP_ACTIVE;
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    spi_writel(data, R_CTRL0, ctrl);
 }
 
-static void spi_ctrl_stop_user(void)
+static void spi_ctrl_stop_user(const TestData *data)
 {
-    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    uint32_t ctrl = spi_readl(data, R_CTRL0);
 
     ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    spi_writel(data, R_CTRL0, ctrl);
 }
 
-static void flash_reset(void)
+static void flash_reset(const TestData *data)
 {
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(data, CONF_ENABLE_W0);
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, RESET_ENABLE);
-    writeb(ASPEED_FLASH_BASE, RESET_MEMORY);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, BULK_ERASE);
-    writeb(ASPEED_FLASH_BASE, WRDI);
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(data);
+    flash_writeb(data, 0, RESET_ENABLE);
+    flash_writeb(data, 0, RESET_MEMORY);
+    flash_writeb(data, 0, WREN);
+    flash_writeb(data, 0, BULK_ERASE);
+    flash_writeb(data, 0, WRDI);
+    spi_ctrl_stop_user(data);
 
-    spi_conf_remove(CONF_ENABLE_W0);
+    spi_conf_remove(data, CONF_ENABLE_W0);
 }
 
-static void test_read_jedec(void)
+static void test_read_jedec(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t jedec = 0x0;
 
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, JEDEC_READ);
-    jedec |= readb(ASPEED_FLASH_BASE) << 16;
-    jedec |= readb(ASPEED_FLASH_BASE) << 8;
-    jedec |= readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, JEDEC_READ);
+    jedec |= flash_readb(test_data, 0) << 16;
+    jedec |= flash_readb(test_data, 0) << 8;
+    jedec |= flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
 
-    flash_reset();
+    flash_reset(test_data);
 
-    g_assert_cmphex(jedec, ==, FLASH_JEDEC);
+    g_assert_cmphex(jedec, ==, test_data->jedec_id);
 }
 
-static void read_page(uint32_t addr, uint32_t *page)
+static void read_page(const TestData *data, uint32_t addr, uint32_t *page)
 {
     int i;
 
-    spi_ctrl_start_user();
+    spi_ctrl_start_user(data);
 
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, READ);
-    writel(ASPEED_FLASH_BASE, make_be32(addr));
+    flash_writeb(data, 0, EN_4BYTE_ADDR);
+    flash_writeb(data, 0, READ);
+    flash_writel(data, 0, make_be32(addr));
 
     /* Continuous read are supported */
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        page[i] = make_be32(readl(ASPEED_FLASH_BASE));
+        page[i] = make_be32(flash_readl(data, 0));
     }
-    spi_ctrl_stop_user();
+    spi_ctrl_stop_user(data);
 }
 
-static void read_page_mem(uint32_t addr, uint32_t *page)
+static void read_page_mem(const TestData *data, uint32_t addr, uint32_t *page)
 {
     int i;
 
     /* move out USER mode to use direct reads from the AHB bus */
-    spi_ctrl_setmode(CTRL_READMODE, READ);
+    spi_ctrl_setmode(data, CTRL_READMODE, READ);
 
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        page[i] = make_be32(readl(ASPEED_FLASH_BASE + addr + i * 4));
+        page[i] = make_be32(flash_readl(data, addr + i * 4));
     }
 }
 
-static void write_page_mem(uint32_t addr, uint32_t write_value)
+static void write_page_mem(const TestData *data, uint32_t addr,
+                           uint32_t write_value)
 {
-    spi_ctrl_setmode(CTRL_WRITEMODE, PP);
+    spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
 
     for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE + addr + i * 4, write_value);
+        flash_writel(data, addr + i * 4, write_value);
     }
 }
 
-static void assert_page_mem(uint32_t addr, uint32_t expected_value)
+static void assert_page_mem(const TestData *data, uint32_t addr,
+                            uint32_t expected_value)
 {
     uint32_t page[FLASH_PAGE_SIZE / 4];
-    read_page_mem(addr, page);
+    read_page_mem(data, addr, page);
     for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, expected_value);
     }
 }
 
-static void test_erase_sector(void)
+static void test_erase_sector(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t some_page_addr = 0x600 * FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
     /*
      * Previous page should be full of 0xffs after backend is
      * initialized
      */
-    read_page(some_page_addr - FLASH_PAGE_SIZE, page);
+    read_page(test_data, some_page_addr - FLASH_PAGE_SIZE, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, PP);
-    writel(ASPEED_FLASH_BASE, make_be32(some_page_addr));
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(some_page_addr));
 
     /* Fill the page with its own addresses */
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE, make_be32(some_page_addr + i * 4));
+        flash_writel(test_data, 0, make_be32(some_page_addr + i * 4));
     }
-    spi_ctrl_stop_user();
+    spi_ctrl_stop_user(test_data);
 
     /* Check the page is correctly written */
-    read_page(some_page_addr, page);
+    read_page(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, some_page_addr + i * 4);
     }
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, ERASE_SECTOR);
-    writel(ASPEED_FLASH_BASE, make_be32(some_page_addr));
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, ERASE_SECTOR);
+    flash_writel(test_data, 0, make_be32(some_page_addr));
+    spi_ctrl_stop_user(test_data);
 
     /* Check the page is erased */
-    read_page(some_page_addr, page);
+    read_page(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_erase_all(void)
+static void test_erase_all(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
     /*
      * Previous page should be full of 0xffs after backend is
      * initialized
      */
-    read_page(some_page_addr - FLASH_PAGE_SIZE, page);
+    read_page(test_data, some_page_addr - FLASH_PAGE_SIZE, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, PP);
-    writel(ASPEED_FLASH_BASE, make_be32(some_page_addr));
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(some_page_addr));
 
     /* Fill the page with its own addresses */
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE, make_be32(some_page_addr + i * 4));
+        flash_writel(test_data, 0, make_be32(some_page_addr + i * 4));
     }
-    spi_ctrl_stop_user();
+    spi_ctrl_stop_user(test_data);
 
     /* Check the page is correctly written */
-    read_page(some_page_addr, page);
+    read_page(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, some_page_addr + i * 4);
     }
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, BULK_ERASE);
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, BULK_ERASE);
+    spi_ctrl_stop_user(test_data);
 
     /* Check the page is erased */
-    read_page(some_page_addr, page);
+    read_page(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_write_page(void)
+static void test_write_page(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t my_page_addr = 0x14000 * FLASH_PAGE_SIZE; /* beyond 16MB */
     uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, PP);
-    writel(ASPEED_FLASH_BASE, make_be32(my_page_addr));
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(my_page_addr));
 
     /* Fill the page with its own addresses */
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE, make_be32(my_page_addr + i * 4));
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
     }
-    spi_ctrl_stop_user();
+    spi_ctrl_stop_user(test_data);
 
     /* Check what was written */
-    read_page(my_page_addr, page);
+    read_page(test_data, my_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
     }
 
     /* Check some other page. It should be full of 0xff */
-    read_page(some_page_addr, page);
+    read_page(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_read_page_mem(void)
+static void test_read_page_mem(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t my_page_addr = 0x14000 * FLASH_PAGE_SIZE; /* beyond 16MB */
     uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
@@ -357,40 +399,41 @@ static void test_read_page_mem(void)
      * Enable 4BYTE mode for controller. This is should be strapped by
      * HW for CE0 anyhow.
      */
-    spi_ce_ctrl(1 << CRTL_EXTENDED0);
+    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
 
     /* Enable 4BYTE mode for flash. */
-    spi_conf(CONF_ENABLE_W0);
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, PP);
-    writel(ASPEED_FLASH_BASE, make_be32(my_page_addr));
+    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(my_page_addr));
 
     /* Fill the page with its own addresses */
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE, make_be32(my_page_addr + i * 4));
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
     }
-    spi_ctrl_stop_user();
-    spi_conf_remove(CONF_ENABLE_W0);
+    spi_ctrl_stop_user(test_data);
+    spi_conf_remove(test_data, CONF_ENABLE_W0);
 
     /* Check what was written */
-    read_page_mem(my_page_addr, page);
+    read_page_mem(test_data, my_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
     }
 
     /* Check some other page. It should be full of 0xff */
-    read_page_mem(some_page_addr, page);
+    read_page_mem(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_write_page_mem(void)
+static void test_write_page_mem(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t my_page_addr = 0x15000 * FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
@@ -399,150 +442,153 @@ static void test_write_page_mem(void)
      * Enable 4BYTE mode for controller. This is should be strapped by
      * HW for CE0 anyhow.
      */
-    spi_ce_ctrl(1 << CRTL_EXTENDED0);
+    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
 
     /* Enable 4BYTE mode for flash. */
-    spi_conf(CONF_ENABLE_W0);
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    spi_ctrl_stop_user();
+    spi_conf(test_data, CONF_ENABLE_W0);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    spi_ctrl_stop_user(test_data);
 
     /* move out USER mode to use direct writes to the AHB bus */
-    spi_ctrl_setmode(CTRL_WRITEMODE, PP);
+    spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
 
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE + my_page_addr + i * 4,
+        flash_writel(test_data, my_page_addr + i * 4,
                make_be32(my_page_addr + i * 4));
     }
 
     /* Check what was written */
-    read_page_mem(my_page_addr, page);
+    read_page_mem(test_data, my_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_read_status_reg(void)
+static void test_read_status_reg(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint8_t r;
 
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
 
     g_assert_cmphex(r & SR_WEL, ==, 0);
     g_assert(!qtest_qom_get_bool
-            (global_qtest, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
+            (test_data->s, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
 
     g_assert_cmphex(r & SR_WEL, ==, SR_WEL);
     g_assert(qtest_qom_get_bool
-            (global_qtest, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
+            (test_data->s, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
 
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WRDI);
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WRDI);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
 
     g_assert_cmphex(r & SR_WEL, ==, 0);
     g_assert(!qtest_qom_get_bool
-            (global_qtest, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
+            (test_data->s, "/machine/soc/fmc/ssi.0/child[0]", "write-enable"));
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_status_reg_write_protection(void)
+static void test_status_reg_write_protection(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint8_t r;
 
-    spi_conf(CONF_ENABLE_W0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
     /* default case: WP# is high and SRWD is low -> status register writable */
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
     /* test ability to write SRWD */
-    writeb(ASPEED_FLASH_BASE, WRSR);
-    writeb(ASPEED_FLASH_BASE, SRWD);
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, SRWD);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
     g_assert_cmphex(r & SRWD, ==, SRWD);
 
     /* WP# high and SRWD high -> status register writable */
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
     /* test ability to write SRWD */
-    writeb(ASPEED_FLASH_BASE, WRSR);
-    writeb(ASPEED_FLASH_BASE, 0);
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, 0);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
     g_assert_cmphex(r & SRWD, ==, 0);
 
     /* WP# low and SRWD low -> status register writable */
-    qtest_set_irq_in(global_qtest,
+    qtest_set_irq_in(test_data->s,
                      "/machine/soc/fmc/ssi.0/child[0]", "WP#", 0, 0);
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
     /* test ability to write SRWD */
-    writeb(ASPEED_FLASH_BASE, WRSR);
-    writeb(ASPEED_FLASH_BASE, SRWD);
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, SRWD);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
     g_assert_cmphex(r & SRWD, ==, SRWD);
 
     /* WP# low and SRWD high -> status register NOT writable */
-    spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0 , WREN);
     /* test ability to write SRWD */
-    writeb(ASPEED_FLASH_BASE, WRSR);
-    writeb(ASPEED_FLASH_BASE, 0);
-    writeb(ASPEED_FLASH_BASE, RDSR);
-    r = readb(ASPEED_FLASH_BASE);
-    spi_ctrl_stop_user();
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, 0);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
     /* write is not successful */
     g_assert_cmphex(r & SRWD, ==, SRWD);
 
-    qtest_set_irq_in(global_qtest,
+    qtest_set_irq_in(test_data->s,
                      "/machine/soc/fmc/ssi.0/child[0]", "WP#", 0, 1);
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_write_block_protect(void)
+static void test_write_block_protect(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t sector_size = 65536;
     uint32_t n_sectors = 512;
 
-    spi_ce_ctrl(1 << CRTL_EXTENDED0);
-    spi_conf(CONF_ENABLE_W0);
+    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
     uint32_t bp_bits = 0b0;
 
     for (int i = 0; i < 16; i++) {
         bp_bits = ((i & 0b1000) << 3) | ((i & 0b0111) << 2);
 
-        spi_ctrl_start_user();
-        writeb(ASPEED_FLASH_BASE, WREN);
-        writeb(ASPEED_FLASH_BASE, BULK_ERASE);
-        writeb(ASPEED_FLASH_BASE, WREN);
-        writeb(ASPEED_FLASH_BASE, WRSR);
-        writeb(ASPEED_FLASH_BASE, bp_bits);
-        writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-        writeb(ASPEED_FLASH_BASE, WREN);
-        spi_ctrl_stop_user();
+        spi_ctrl_start_user(test_data);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, BULK_ERASE);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, WRSR);
+        flash_writeb(test_data, 0, bp_bits);
+        flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+        flash_writeb(test_data, 0, WREN);
+        spi_ctrl_stop_user(test_data);
 
         uint32_t num_protected_sectors = i ? MIN(1 << (i - 1), n_sectors) : 0;
         uint32_t protection_start = n_sectors - num_protected_sectors;
@@ -551,27 +597,28 @@ static void test_write_block_protect(void)
         for (int sector = 0; sector < n_sectors; sector++) {
             uint32_t addr = sector * sector_size;
 
-            assert_page_mem(addr, 0xffffffff);
-            write_page_mem(addr, make_be32(0xabcdef12));
+            assert_page_mem(test_data, addr, 0xffffffff);
+            write_page_mem(test_data, addr, make_be32(0xabcdef12));
 
             uint32_t expected_value = protection_start <= sector
                                       && sector < protection_end
                                       ? 0xffffffff : 0xabcdef12;
 
-            assert_page_mem(addr, expected_value);
+            assert_page_mem(test_data, addr, expected_value);
         }
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static void test_write_block_protect_bottom_bit(void)
+static void test_write_block_protect_bottom_bit(const void *data)
 {
+    const TestData *test_data = (const TestData *)data;
     uint32_t sector_size = 65536;
     uint32_t n_sectors = 512;
 
-    spi_ce_ctrl(1 << CRTL_EXTENDED0);
-    spi_conf(CONF_ENABLE_W0);
+    spi_ce_ctrl(test_data, 1 << CRTL_EXTENDED0);
+    spi_conf(test_data, CONF_ENABLE_W0);
 
     /* top bottom bit is enabled */
     uint32_t bp_bits = 0b00100 << 3;
@@ -579,15 +626,15 @@ static void test_write_block_protect_bottom_bit(void)
     for (int i = 0; i < 16; i++) {
         bp_bits = (((i & 0b1000) | 0b0100) << 3) | ((i & 0b0111) << 2);
 
-        spi_ctrl_start_user();
-        writeb(ASPEED_FLASH_BASE, WREN);
-        writeb(ASPEED_FLASH_BASE, BULK_ERASE);
-        writeb(ASPEED_FLASH_BASE, WREN);
-        writeb(ASPEED_FLASH_BASE, WRSR);
-        writeb(ASPEED_FLASH_BASE, bp_bits);
-        writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-        writeb(ASPEED_FLASH_BASE, WREN);
-        spi_ctrl_stop_user();
+        spi_ctrl_start_user(test_data);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, BULK_ERASE);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, WRSR);
+        flash_writeb(test_data, 0, bp_bits);
+        flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+        flash_writeb(test_data, 0, WREN);
+        spi_ctrl_stop_user(test_data);
 
         uint32_t num_protected_sectors = i ? MIN(1 << (i - 1), n_sectors) : 0;
         uint32_t protection_start = 0;
@@ -596,64 +643,69 @@ static void test_write_block_protect_bottom_bit(void)
         for (int sector = 0; sector < n_sectors; sector++) {
             uint32_t addr = sector * sector_size;
 
-            assert_page_mem(addr, 0xffffffff);
-            write_page_mem(addr, make_be32(0xabcdef12));
+            assert_page_mem(test_data, addr, 0xffffffff);
+            write_page_mem(test_data, addr, make_be32(0xabcdef12));
 
             uint32_t expected_value = protection_start <= sector
                                       && sector < protection_end
                                       ? 0xffffffff : 0xabcdef12;
 
-            assert_page_mem(addr, expected_value);
+            assert_page_mem(test_data, addr, expected_value);
         }
     }
 
-    flash_reset();
+    flash_reset(test_data);
 }
 
-static int test_palmetto_bmc(void)
+static void test_palmetto_bmc(TestData *data)
 {
-    g_autofree char *tmp_path = NULL;
     int ret;
     int fd;
 
-    fd = g_file_open_tmp("qtest.m25p80.XXXXXX", &tmp_path, NULL);
+    fd = g_file_open_tmp("qtest.m25p80.n25q256a.XXXXXX", &data->tmp_path, NULL);
     g_assert(fd >= 0);
-    ret = ftruncate(fd, FLASH_SIZE);
+    ret = ftruncate(fd, 32 * 1024 * 1024);
     g_assert(ret == 0);
     close(fd);
 
-    global_qtest = qtest_initf("-m 256 -machine palmetto-bmc "
-                               "-drive file=%s,format=raw,if=mtd",
-                               tmp_path);
-
-    qtest_add_func("/ast2400/smc/read_jedec", test_read_jedec);
-    qtest_add_func("/ast2400/smc/erase_sector", test_erase_sector);
-    qtest_add_func("/ast2400/smc/erase_all",  test_erase_all);
-    qtest_add_func("/ast2400/smc/write_page", test_write_page);
-    qtest_add_func("/ast2400/smc/read_page_mem", test_read_page_mem);
-    qtest_add_func("/ast2400/smc/write_page_mem", test_write_page_mem);
-    qtest_add_func("/ast2400/smc/read_status_reg", test_read_status_reg);
-    qtest_add_func("/ast2400/smc/status_reg_write_protection",
-                   test_status_reg_write_protection);
-    qtest_add_func("/ast2400/smc/write_block_protect",
-                   test_write_block_protect);
-    qtest_add_func("/ast2400/smc/write_block_protect_bottom_bit",
-                   test_write_block_protect_bottom_bit);
-
-    flash_reset();
-    ret = g_test_run();
-    qtest_quit(global_qtest);
-    unlink(tmp_path);
-
-    return ret;
+    data->s = qtest_initf("-m 256 -machine palmetto-bmc "
+                          "-drive file=%s,format=raw,if=mtd",
+                          data->tmp_path);
+
+    /* fmc cs0 with n25q256a flash */
+    data->flash_base = 0x20000000;
+    data->spi_base = 0x1E620000;
+    data->jedec_id = 0x20ba19;
+
+    qtest_add_data_func("/ast2400/smc/read_jedec", data, test_read_jedec);
+    qtest_add_data_func("/ast2400/smc/erase_sector", data, test_erase_sector);
+    qtest_add_data_func("/ast2400/smc/erase_all",  data, test_erase_all);
+    qtest_add_data_func("/ast2400/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast2400/smc/read_page_mem",
+                        data, test_read_page_mem);
+    qtest_add_data_func("/ast2400/smc/write_page_mem",
+                        data, test_write_page_mem);
+    qtest_add_data_func("/ast2400/smc/read_status_reg",
+                        data, test_read_status_reg);
+    qtest_add_data_func("/ast2400/smc/status_reg_write_protection",
+                        data, test_status_reg_write_protection);
+    qtest_add_data_func("/ast2400/smc/write_block_protect",
+                        data, test_write_block_protect);
+    qtest_add_data_func("/ast2400/smc/write_block_protect_bottom_bit",
+                        data, test_write_block_protect_bottom_bit);
 }
 
 int main(int argc, char **argv)
 {
+    TestData palmetto_data;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
-    ret = test_palmetto_bmc();
 
+    test_palmetto_bmc(&palmetto_data);
+    ret = g_test_run();
+
+    qtest_quit(palmetto_data.s);
+    unlink(palmetto_data.tmp_path);
     return ret;
 }
-- 
2.34.1


