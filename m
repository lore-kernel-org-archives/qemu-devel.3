Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57851D1CDCA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BQ6-0006Dy-Lg; Tue, 22 Oct 2024 05:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BPq-0004i2-N6; Tue, 22 Oct 2024 05:43:03 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BPl-0001CU-Mj; Tue, 22 Oct 2024 05:43:02 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 22 Oct
 2024 17:41:17 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 22 Oct 2024 17:41:17 +0800
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
Subject: [PATCH v2 17/18] test/qtest: Introduce a new aspeed-smc-utils.c to
 place common testcases
Date: Tue, 22 Oct 2024 17:41:09 +0800
Message-ID: <20241022094110.1574011-18-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The testcases for ASPEED SMC model were placed in aspeed_smc-test.c.
However, this test file only supports for ARM32. To support all ASPEED SOCs
such as AST2700 whose CPU architecture is aarch64, introduces a new
aspeed-smc-utils source file and move all common APIs and testcases
from aspeed_smc-test.c to aspeed-smc-utils.c.

Finally, users are able to re-used these testcase for AST2700 and future
ASPEED SOCs testing.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed-smc-utils.c | 681 ++++++++++++++++++++++++++++++++
 tests/qtest/aspeed-smc-utils.h |  95 +++++
 tests/qtest/aspeed_smc-test.c  | 700 +--------------------------------
 tests/qtest/meson.build        |   1 +
 4 files changed, 778 insertions(+), 699 deletions(-)
 create mode 100644 tests/qtest/aspeed-smc-utils.c
 create mode 100644 tests/qtest/aspeed-smc-utils.h

diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
new file mode 100644
index 0000000000..37da5d1f3b
--- /dev/null
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -0,0 +1,681 @@
+/*
+ * QTest testcase for the M25P80 Flash (Using the Aspeed SPI
+ * Controller)
+ *
+ * Copyright (C) 2016 IBM Corp.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "libqtest-single.h"
+#include "qemu/bitops.h"
+#include "aspeed-smc-utils.h"
+
+/*
+ * Use an explicit bswap for the values read/wrote to the flash region
+ * as they are BE and the Aspeed CPU is LE.
+ */
+static inline uint32_t make_be32(uint32_t data)
+{
+    return bswap32(data);
+}
+
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
+{
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
+
+    conf |= value;
+    spi_writel(data, R_CONF, conf);
+}
+
+static void spi_conf_remove(const TestData *data, uint32_t value)
+{
+    uint32_t conf = spi_readl(data, R_CONF);
+
+    conf &= ~value;
+    spi_writel(data, R_CONF, conf);
+}
+
+static void spi_ce_ctrl(const TestData *data, uint32_t value)
+{
+    uint32_t conf = spi_readl(data, R_CE_CTRL);
+
+    conf |= value;
+    spi_writel(data, R_CE_CTRL, conf);
+}
+
+static void spi_ctrl_setmode(const TestData *data, uint8_t mode, uint8_t cmd)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+    ctrl &= ~(CTRL_USERMODE | 0xff << 16);
+    ctrl |= mode | (cmd << 16);
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
+static void spi_ctrl_start_user(const TestData *data)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+
+    ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
+    spi_writel(data, ctrl_reg, ctrl);
+
+    ctrl &= ~CTRL_CE_STOP_ACTIVE;
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
+static void spi_ctrl_stop_user(const TestData *data)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+
+    ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
+static void spi_ctrl_set_io_mode(const TestData *data, uint32_t value)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+    uint32_t mode;
+
+    mode = value & CTRL_IO_MODE_MASK;
+    ctrl &= ~CTRL_IO_MODE_MASK;
+    ctrl |= mode;
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
+static void flash_reset(const TestData *data)
+{
+    spi_conf(data, 1 << (CONF_ENABLE_W0 + data->cs));
+
+    spi_ctrl_start_user(data);
+    flash_writeb(data, 0, RESET_ENABLE);
+    flash_writeb(data, 0, RESET_MEMORY);
+    flash_writeb(data, 0, WREN);
+    flash_writeb(data, 0, BULK_ERASE);
+    flash_writeb(data, 0, WRDI);
+    spi_ctrl_stop_user(data);
+
+    spi_conf_remove(data, 1 << (CONF_ENABLE_W0 + data->cs));
+}
+
+static void read_page(const TestData *data, uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_start_user(data);
+
+    flash_writeb(data, 0, EN_4BYTE_ADDR);
+    flash_writeb(data, 0, READ);
+    flash_writel(data, 0, make_be32(addr));
+
+    /* Continuous read are supported */
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, 0));
+    }
+    spi_ctrl_stop_user(data);
+}
+
+static void read_page_mem(const TestData *data, uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    /* move out USER mode to use direct reads from the AHB bus */
+    spi_ctrl_setmode(data, CTRL_READMODE, READ);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, addr + i * 4));
+    }
+}
+
+static void write_page_mem(const TestData *data, uint32_t addr,
+                           uint32_t write_value)
+{
+    spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
+
+    for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(data, addr + i * 4, write_value);
+    }
+}
+
+static void assert_page_mem(const TestData *data, uint32_t addr,
+                            uint32_t expected_value)
+{
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    read_page_mem(data, addr, page);
+    for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, expected_value);
+    }
+}
+
+void test_read_jedec(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t jedec = 0x0;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, JEDEC_READ);
+    jedec |= flash_readb(test_data, 0) << 16;
+    jedec |= flash_readb(test_data, 0) << 8;
+    jedec |= flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+
+    flash_reset(test_data);
+
+    g_assert_cmphex(jedec, ==, test_data->jedec_id);
+}
+
+void test_erase_sector(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t some_page_addr = test_data->page_addr;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /*
+     * Previous page should be full of 0xffs after backend is
+     * initialized
+     */
+    read_page(test_data, some_page_addr - FLASH_PAGE_SIZE, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(some_page_addr));
+
+    /* Fill the page with its own addresses */
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, 0, make_be32(some_page_addr + i * 4));
+    }
+    spi_ctrl_stop_user(test_data);
+
+    /* Check the page is correctly written */
+    read_page(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, some_page_addr + i * 4);
+    }
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, ERASE_SECTOR);
+    flash_writel(test_data, 0, make_be32(some_page_addr));
+    spi_ctrl_stop_user(test_data);
+
+    /* Check the page is erased */
+    read_page(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    flash_reset(test_data);
+}
+
+void test_erase_all(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t some_page_addr = test_data->page_addr;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /*
+     * Previous page should be full of 0xffs after backend is
+     * initialized
+     */
+    read_page(test_data, some_page_addr - FLASH_PAGE_SIZE, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(some_page_addr));
+
+    /* Fill the page with its own addresses */
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, 0, make_be32(some_page_addr + i * 4));
+    }
+    spi_ctrl_stop_user(test_data);
+
+    /* Check the page is correctly written */
+    read_page(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, some_page_addr + i * 4);
+    }
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, BULK_ERASE);
+    spi_ctrl_stop_user(test_data);
+
+    /* Check the page is erased */
+    read_page(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    flash_reset(test_data);
+}
+
+void test_write_page(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(my_page_addr));
+
+    /* Fill the page with its own addresses */
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
+    }
+    spi_ctrl_stop_user(test_data);
+
+    /* Check what was written */
+    read_page(test_data, my_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    /* Check some other page. It should be full of 0xff */
+    read_page(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    flash_reset(test_data);
+}
+
+void test_read_page_mem(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    /*
+     * Enable 4BYTE mode for controller.
+     */
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
+
+    /* Enable 4BYTE mode for flash. */
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(my_page_addr));
+
+    /* Fill the page with its own addresses */
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
+    }
+    spi_ctrl_stop_user(test_data);
+    spi_conf_remove(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /* Check what was written */
+    read_page_mem(test_data, my_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    /* Check some other page. It should be full of 0xff */
+    read_page_mem(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    flash_reset(test_data);
+}
+
+void test_write_page_mem(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    /*
+     * Enable 4BYTE mode for controller.
+     */
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
+
+    /* Enable 4BYTE mode for flash. */
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    spi_ctrl_stop_user(test_data);
+
+    /* move out USER mode to use direct writes to the AHB bus */
+    spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, my_page_addr + i * 4,
+               make_be32(my_page_addr + i * 4));
+    }
+
+    /* Check what was written */
+    read_page_mem(test_data, my_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    flash_reset(test_data);
+}
+
+void test_read_status_reg(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint8_t r;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+
+    g_assert_cmphex(r & SR_WEL, ==, 0);
+    g_assert(!qtest_qom_get_bool
+            (test_data->s, test_data->node, "write-enable"));
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+
+    g_assert_cmphex(r & SR_WEL, ==, SR_WEL);
+    g_assert(qtest_qom_get_bool
+            (test_data->s, test_data->node, "write-enable"));
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WRDI);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+
+    g_assert_cmphex(r & SR_WEL, ==, 0);
+    g_assert(!qtest_qom_get_bool
+            (test_data->s, test_data->node, "write-enable"));
+
+    flash_reset(test_data);
+}
+
+void test_status_reg_write_protection(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint8_t r;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /* default case: WP# is high and SRWD is low -> status register writable */
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    /* test ability to write SRWD */
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, SRWD);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+    g_assert_cmphex(r & SRWD, ==, SRWD);
+
+    /* WP# high and SRWD high -> status register writable */
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    /* test ability to write SRWD */
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, 0);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+    g_assert_cmphex(r & SRWD, ==, 0);
+
+    /* WP# low and SRWD low -> status register writable */
+    qtest_set_irq_in(test_data->s, test_data->node, "WP#", 0, 0);
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, WREN);
+    /* test ability to write SRWD */
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, SRWD);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+    g_assert_cmphex(r & SRWD, ==, SRWD);
+
+    /* WP# low and SRWD high -> status register NOT writable */
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0 , WREN);
+    /* test ability to write SRWD */
+    flash_writeb(test_data, 0, WRSR);
+    flash_writeb(test_data, 0, 0);
+    flash_writeb(test_data, 0, RDSR);
+    r = flash_readb(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+    /* write is not successful */
+    g_assert_cmphex(r & SRWD, ==, SRWD);
+
+    qtest_set_irq_in(test_data->s, test_data->node, "WP#", 0, 1);
+    flash_reset(test_data);
+}
+
+void test_write_block_protect(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t sector_size = 65536;
+    uint32_t n_sectors = 512;
+
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    uint32_t bp_bits = 0b0;
+
+    for (int i = 0; i < 16; i++) {
+        bp_bits = ((i & 0b1000) << 3) | ((i & 0b0111) << 2);
+
+        spi_ctrl_start_user(test_data);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, BULK_ERASE);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, WRSR);
+        flash_writeb(test_data, 0, bp_bits);
+        flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+        flash_writeb(test_data, 0, WREN);
+        spi_ctrl_stop_user(test_data);
+
+        uint32_t num_protected_sectors = i ? MIN(1 << (i - 1), n_sectors) : 0;
+        uint32_t protection_start = n_sectors - num_protected_sectors;
+        uint32_t protection_end = n_sectors;
+
+        for (int sector = 0; sector < n_sectors; sector++) {
+            uint32_t addr = sector * sector_size;
+
+            assert_page_mem(test_data, addr, 0xffffffff);
+            write_page_mem(test_data, addr, make_be32(0xabcdef12));
+
+            uint32_t expected_value = protection_start <= sector
+                                      && sector < protection_end
+                                      ? 0xffffffff : 0xabcdef12;
+
+            assert_page_mem(test_data, addr, expected_value);
+        }
+    }
+
+    flash_reset(test_data);
+}
+
+void test_write_block_protect_bottom_bit(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t sector_size = 65536;
+    uint32_t n_sectors = 512;
+
+    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /* top bottom bit is enabled */
+    uint32_t bp_bits = 0b00100 << 3;
+
+    for (int i = 0; i < 16; i++) {
+        bp_bits = (((i & 0b1000) | 0b0100) << 3) | ((i & 0b0111) << 2);
+
+        spi_ctrl_start_user(test_data);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, BULK_ERASE);
+        flash_writeb(test_data, 0, WREN);
+        flash_writeb(test_data, 0, WRSR);
+        flash_writeb(test_data, 0, bp_bits);
+        flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+        flash_writeb(test_data, 0, WREN);
+        spi_ctrl_stop_user(test_data);
+
+        uint32_t num_protected_sectors = i ? MIN(1 << (i - 1), n_sectors) : 0;
+        uint32_t protection_start = 0;
+        uint32_t protection_end = num_protected_sectors;
+
+        for (int sector = 0; sector < n_sectors; sector++) {
+            uint32_t addr = sector * sector_size;
+
+            assert_page_mem(test_data, addr, 0xffffffff);
+            write_page_mem(test_data, addr, make_be32(0xabcdef12));
+
+            uint32_t expected_value = protection_start <= sector
+                                      && sector < protection_end
+                                      ? 0xffffffff : 0xabcdef12;
+
+            assert_page_mem(test_data, addr, expected_value);
+        }
+    }
+
+    flash_reset(test_data);
+}
+
+void test_write_page_qpi(const void *data)
+{
+    const TestData *test_data = (const TestData *)data;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    uint32_t page_pattern[] = {
+        0xebd8c134, 0x5da196bc, 0xae15e729, 0x5085ccdf
+    };
+    int i;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(my_page_addr));
+
+    /* Set QPI mode */
+    spi_ctrl_set_io_mode(test_data, CTRL_IO_QUAD_IO);
+
+    /* Fill the page pattern */
+    for (i = 0; i < ARRAY_SIZE(page_pattern); i++) {
+        flash_writel(test_data, 0, make_be32(page_pattern[i]));
+    }
+
+    /* Fill the page with its own addresses */
+    for (; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
+    }
+
+    /* Restore io mode */
+    spi_ctrl_set_io_mode(test_data, 0);
+    spi_ctrl_stop_user(test_data);
+
+    /* Check what was written */
+    read_page(test_data, my_page_addr, page);
+    for (i = 0; i < ARRAY_SIZE(page_pattern); i++) {
+        g_assert_cmphex(page[i], ==, page_pattern[i]);
+    }
+    for (; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    /* Check some other page. It should be full of 0xff */
+    read_page(test_data, some_page_addr, page);
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, 0xffffffff);
+    }
+
+    flash_reset(test_data);
+}
+
diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
new file mode 100644
index 0000000000..0f298085c2
--- /dev/null
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -0,0 +1,95 @@
+/*
+ * QTest testcase for the M25P80 Flash (Using the Aspeed SPI
+ * Controller)
+ *
+ * Copyright (C) 2016 IBM Corp.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TESTS_ASPEED_SMC_UTILS_H
+#define TESTS_ASPEED_SMC_UTILS_H
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "libqtest-single.h"
+#include "qemu/bitops.h"
+
+/*
+ * ASPEED SPI Controller registers
+ */
+#define R_CONF              0x00
+#define   CONF_ENABLE_W0       16
+#define R_CE_CTRL           0x04
+#define   CRTL_EXTENDED0       0  /* 32 bit addressing for SPI */
+#define R_CTRL0             0x10
+#define   CTRL_IO_QUAD_IO      BIT(31)
+#define   CTRL_CE_STOP_ACTIVE  BIT(2)
+#define   CTRL_READMODE        0x0
+#define   CTRL_FREADMODE       0x1
+#define   CTRL_WRITEMODE       0x2
+#define   CTRL_USERMODE        0x3
+#define SR_WEL BIT(1)
+
+/*
+ * Flash commands
+ */
+enum {
+    JEDEC_READ = 0x9f,
+    RDSR = 0x5,
+    WRDI = 0x4,
+    BULK_ERASE = 0xc7,
+    READ = 0x03,
+    PP = 0x02,
+    WRSR = 0x1,
+    WREN = 0x6,
+    SRWD = 0x80,
+    RESET_ENABLE = 0x66,
+    RESET_MEMORY = 0x99,
+    EN_4BYTE_ADDR = 0xB7,
+    ERASE_SECTOR = 0xd8,
+};
+
+#define CTRL_IO_MODE_MASK  (BIT(31) | BIT(30) | BIT(29) | BIT(28))
+#define FLASH_PAGE_SIZE           256
+
+typedef struct TestData {
+    QTestState *s;
+    uint64_t spi_base;
+    uint64_t flash_base;
+    uint32_t jedec_id;
+    char *tmp_path;
+    uint8_t cs;
+    const char *node;
+    uint32_t page_addr;
+} TestData;
+
+void test_read_jedec(const void *data);
+void test_erase_sector(const void *data);
+void test_erase_all(const void *data);
+void test_write_page(const void *data);
+void test_read_page_mem(const void *data);
+void test_write_page_mem(const void *data);
+void test_read_status_reg(const void *data);
+void test_status_reg_write_protection(const void *data);
+void test_write_block_protect(const void *data);
+void test_write_block_protect_bottom_bit(const void *data);
+void test_write_page_qpi(const void *data);
+
+#endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 59f3876cdc..ef3fdc516e 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -27,705 +27,7 @@
 #include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
-
-/*
- * ASPEED SPI Controller registers
- */
-#define R_CONF              0x00
-#define   CONF_ENABLE_W0       16
-#define R_CE_CTRL           0x04
-#define   CRTL_EXTENDED0       0  /* 32 bit addressing for SPI */
-#define R_CTRL0             0x10
-#define   CTRL_IO_QUAD_IO      BIT(31)
-#define   CTRL_CE_STOP_ACTIVE  BIT(2)
-#define   CTRL_READMODE        0x0
-#define   CTRL_FREADMODE       0x1
-#define   CTRL_WRITEMODE       0x2
-#define   CTRL_USERMODE        0x3
-#define SR_WEL BIT(1)
-
-/*
- * Flash commands
- */
-enum {
-    JEDEC_READ = 0x9f,
-    RDSR = 0x5,
-    WRDI = 0x4,
-    BULK_ERASE = 0xc7,
-    READ = 0x03,
-    PP = 0x02,
-    WRSR = 0x1,
-    WREN = 0x6,
-    SRWD = 0x80,
-    RESET_ENABLE = 0x66,
-    RESET_MEMORY = 0x99,
-    EN_4BYTE_ADDR = 0xB7,
-    ERASE_SECTOR = 0xd8,
-};
-
-#define CTRL_IO_MODE_MASK  (BIT(31) | BIT(30) | BIT(29) | BIT(28))
-#define FLASH_PAGE_SIZE           256
-
-typedef struct TestData {
-    QTestState *s;
-    uint64_t spi_base;
-    uint64_t flash_base;
-    uint32_t jedec_id;
-    char *tmp_path;
-    uint8_t cs;
-    const char *node;
-    uint32_t page_addr;
-} TestData;
-
-/*
- * Use an explicit bswap for the values read/wrote to the flash region
- * as they are BE and the Aspeed CPU is LE.
- */
-static inline uint32_t make_be32(uint32_t data)
-{
-    return bswap32(data);
-}
-
-static inline void spi_writel(const TestData *data, uint64_t offset,
-                              uint32_t value)
-{
-    qtest_writel(data->s, data->spi_base + offset, value);
-}
-
-static inline uint32_t spi_readl(const TestData *data, uint64_t offset)
-{
-    return qtest_readl(data->s, data->spi_base + offset);
-}
-
-static inline void flash_writeb(const TestData *data, uint64_t offset,
-                                uint8_t value)
-{
-    qtest_writeb(data->s, data->flash_base + offset, value);
-}
-
-static inline void flash_writel(const TestData *data, uint64_t offset,
-                                uint32_t value)
-{
-    qtest_writel(data->s, data->flash_base + offset, value);
-}
-
-static inline uint8_t flash_readb(const TestData *data, uint64_t offset)
-{
-    return qtest_readb(data->s, data->flash_base + offset);
-}
-
-static inline uint32_t flash_readl(const TestData *data, uint64_t offset)
-{
-    return qtest_readl(data->s, data->flash_base + offset);
-}
-
-static void spi_conf(const TestData *data, uint32_t value)
-{
-    uint32_t conf = spi_readl(data, R_CONF);
-
-    conf |= value;
-    spi_writel(data, R_CONF, conf);
-}
-
-static void spi_conf_remove(const TestData *data, uint32_t value)
-{
-    uint32_t conf = spi_readl(data, R_CONF);
-
-    conf &= ~value;
-    spi_writel(data, R_CONF, conf);
-}
-
-static void spi_ce_ctrl(const TestData *data, uint32_t value)
-{
-    uint32_t conf = spi_readl(data, R_CE_CTRL);
-
-    conf |= value;
-    spi_writel(data, R_CE_CTRL, conf);
-}
-
-static void spi_ctrl_setmode(const TestData *data, uint8_t mode, uint8_t cmd)
-{
-    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
-    uint32_t ctrl = spi_readl(data, ctrl_reg);
-    ctrl &= ~(CTRL_USERMODE | 0xff << 16);
-    ctrl |= mode | (cmd << 16);
-    spi_writel(data, ctrl_reg, ctrl);
-}
-
-static void spi_ctrl_start_user(const TestData *data)
-{
-    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
-    uint32_t ctrl = spi_readl(data, ctrl_reg);
-
-    ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    spi_writel(data, ctrl_reg, ctrl);
-
-    ctrl &= ~CTRL_CE_STOP_ACTIVE;
-    spi_writel(data, ctrl_reg, ctrl);
-}
-
-static void spi_ctrl_stop_user(const TestData *data)
-{
-    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
-    uint32_t ctrl = spi_readl(data, ctrl_reg);
-
-    ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    spi_writel(data, ctrl_reg, ctrl);
-}
-
-static void spi_ctrl_set_io_mode(const TestData *data, uint32_t value)
-{
-    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
-    uint32_t ctrl = spi_readl(data, ctrl_reg);
-    uint32_t mode;
-
-    mode = value & CTRL_IO_MODE_MASK;
-    ctrl &= ~CTRL_IO_MODE_MASK;
-    ctrl |= mode;
-    spi_writel(data, ctrl_reg, ctrl);
-}
-
-static void flash_reset(const TestData *data)
-{
-    spi_conf(data, 1 << (CONF_ENABLE_W0 + data->cs));
-
-    spi_ctrl_start_user(data);
-    flash_writeb(data, 0, RESET_ENABLE);
-    flash_writeb(data, 0, RESET_MEMORY);
-    flash_writeb(data, 0, WREN);
-    flash_writeb(data, 0, BULK_ERASE);
-    flash_writeb(data, 0, WRDI);
-    spi_ctrl_stop_user(data);
-
-    spi_conf_remove(data, 1 << (CONF_ENABLE_W0 + data->cs));
-}
-
-static void test_read_jedec(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t jedec = 0x0;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, JEDEC_READ);
-    jedec |= flash_readb(test_data, 0) << 16;
-    jedec |= flash_readb(test_data, 0) << 8;
-    jedec |= flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-
-    flash_reset(test_data);
-
-    g_assert_cmphex(jedec, ==, test_data->jedec_id);
-}
-
-static void read_page(const TestData *data, uint32_t addr, uint32_t *page)
-{
-    int i;
-
-    spi_ctrl_start_user(data);
-
-    flash_writeb(data, 0, EN_4BYTE_ADDR);
-    flash_writeb(data, 0, READ);
-    flash_writel(data, 0, make_be32(addr));
-
-    /* Continuous read are supported */
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        page[i] = make_be32(flash_readl(data, 0));
-    }
-    spi_ctrl_stop_user(data);
-}
-
-static void read_page_mem(const TestData *data, uint32_t addr, uint32_t *page)
-{
-    int i;
-
-    /* move out USER mode to use direct reads from the AHB bus */
-    spi_ctrl_setmode(data, CTRL_READMODE, READ);
-
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        page[i] = make_be32(flash_readl(data, addr + i * 4));
-    }
-}
-
-static void write_page_mem(const TestData *data, uint32_t addr,
-                           uint32_t write_value)
-{
-    spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
-
-    for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(data, addr + i * 4, write_value);
-    }
-}
-
-static void assert_page_mem(const TestData *data, uint32_t addr,
-                            uint32_t expected_value)
-{
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    read_page_mem(data, addr, page);
-    for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, expected_value);
-    }
-}
-
-static void test_erase_sector(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t some_page_addr = test_data->page_addr;
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    int i;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    /*
-     * Previous page should be full of 0xffs after backend is
-     * initialized
-     */
-    read_page(test_data, some_page_addr - FLASH_PAGE_SIZE, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, PP);
-    flash_writel(test_data, 0, make_be32(some_page_addr));
-
-    /* Fill the page with its own addresses */
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(test_data, 0, make_be32(some_page_addr + i * 4));
-    }
-    spi_ctrl_stop_user(test_data);
-
-    /* Check the page is correctly written */
-    read_page(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, some_page_addr + i * 4);
-    }
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, ERASE_SECTOR);
-    flash_writel(test_data, 0, make_be32(some_page_addr));
-    spi_ctrl_stop_user(test_data);
-
-    /* Check the page is erased */
-    read_page(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_erase_all(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t some_page_addr = test_data->page_addr;
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    int i;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    /*
-     * Previous page should be full of 0xffs after backend is
-     * initialized
-     */
-    read_page(test_data, some_page_addr - FLASH_PAGE_SIZE, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, PP);
-    flash_writel(test_data, 0, make_be32(some_page_addr));
-
-    /* Fill the page with its own addresses */
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(test_data, 0, make_be32(some_page_addr + i * 4));
-    }
-    spi_ctrl_stop_user(test_data);
-
-    /* Check the page is correctly written */
-    read_page(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, some_page_addr + i * 4);
-    }
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, BULK_ERASE);
-    spi_ctrl_stop_user(test_data);
-
-    /* Check the page is erased */
-    read_page(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_write_page(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = test_data->page_addr;
-    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    int i;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, PP);
-    flash_writel(test_data, 0, make_be32(my_page_addr));
-
-    /* Fill the page with its own addresses */
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
-    }
-    spi_ctrl_stop_user(test_data);
-
-    /* Check what was written */
-    read_page(test_data, my_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
-    }
-
-    /* Check some other page. It should be full of 0xff */
-    read_page(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_read_page_mem(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = test_data->page_addr;
-    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    int i;
-
-    /*
-     * Enable 4BYTE mode for controller.
-     */
-    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
-
-    /* Enable 4BYTE mode for flash. */
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, PP);
-    flash_writel(test_data, 0, make_be32(my_page_addr));
-
-    /* Fill the page with its own addresses */
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
-    }
-    spi_ctrl_stop_user(test_data);
-    spi_conf_remove(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    /* Check what was written */
-    read_page_mem(test_data, my_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
-    }
-
-    /* Check some other page. It should be full of 0xff */
-    read_page_mem(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_write_page_mem(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = test_data->page_addr;
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    int i;
-
-    /*
-     * Enable 4BYTE mode for controller.
-     */
-    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
-
-    /* Enable 4BYTE mode for flash. */
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, WREN);
-    spi_ctrl_stop_user(test_data);
-
-    /* move out USER mode to use direct writes to the AHB bus */
-    spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
-
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(test_data, my_page_addr + i * 4,
-               make_be32(my_page_addr + i * 4));
-    }
-
-    /* Check what was written */
-    read_page_mem(test_data, my_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_read_status_reg(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint8_t r;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-
-    g_assert_cmphex(r & SR_WEL, ==, 0);
-    g_assert(!qtest_qom_get_bool
-            (test_data->s, test_data->node, "write-enable"));
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-
-    g_assert_cmphex(r & SR_WEL, ==, SR_WEL);
-    g_assert(qtest_qom_get_bool
-            (test_data->s, test_data->node, "write-enable"));
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WRDI);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-
-    g_assert_cmphex(r & SR_WEL, ==, 0);
-    g_assert(!qtest_qom_get_bool
-            (test_data->s, test_data->node, "write-enable"));
-
-    flash_reset(test_data);
-}
-
-static void test_status_reg_write_protection(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint8_t r;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    /* default case: WP# is high and SRWD is low -> status register writable */
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WREN);
-    /* test ability to write SRWD */
-    flash_writeb(test_data, 0, WRSR);
-    flash_writeb(test_data, 0, SRWD);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-    g_assert_cmphex(r & SRWD, ==, SRWD);
-
-    /* WP# high and SRWD high -> status register writable */
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WREN);
-    /* test ability to write SRWD */
-    flash_writeb(test_data, 0, WRSR);
-    flash_writeb(test_data, 0, 0);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-    g_assert_cmphex(r & SRWD, ==, 0);
-
-    /* WP# low and SRWD low -> status register writable */
-    qtest_set_irq_in(test_data->s, test_data->node, "WP#", 0, 0);
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, WREN);
-    /* test ability to write SRWD */
-    flash_writeb(test_data, 0, WRSR);
-    flash_writeb(test_data, 0, SRWD);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-    g_assert_cmphex(r & SRWD, ==, SRWD);
-
-    /* WP# low and SRWD high -> status register NOT writable */
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0 , WREN);
-    /* test ability to write SRWD */
-    flash_writeb(test_data, 0, WRSR);
-    flash_writeb(test_data, 0, 0);
-    flash_writeb(test_data, 0, RDSR);
-    r = flash_readb(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-    /* write is not successful */
-    g_assert_cmphex(r & SRWD, ==, SRWD);
-
-    qtest_set_irq_in(test_data->s, test_data->node, "WP#", 0, 1);
-    flash_reset(test_data);
-}
-
-static void test_write_block_protect(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t sector_size = 65536;
-    uint32_t n_sectors = 512;
-
-    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    uint32_t bp_bits = 0b0;
-
-    for (int i = 0; i < 16; i++) {
-        bp_bits = ((i & 0b1000) << 3) | ((i & 0b0111) << 2);
-
-        spi_ctrl_start_user(test_data);
-        flash_writeb(test_data, 0, WREN);
-        flash_writeb(test_data, 0, BULK_ERASE);
-        flash_writeb(test_data, 0, WREN);
-        flash_writeb(test_data, 0, WRSR);
-        flash_writeb(test_data, 0, bp_bits);
-        flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-        flash_writeb(test_data, 0, WREN);
-        spi_ctrl_stop_user(test_data);
-
-        uint32_t num_protected_sectors = i ? MIN(1 << (i - 1), n_sectors) : 0;
-        uint32_t protection_start = n_sectors - num_protected_sectors;
-        uint32_t protection_end = n_sectors;
-
-        for (int sector = 0; sector < n_sectors; sector++) {
-            uint32_t addr = sector * sector_size;
-
-            assert_page_mem(test_data, addr, 0xffffffff);
-            write_page_mem(test_data, addr, make_be32(0xabcdef12));
-
-            uint32_t expected_value = protection_start <= sector
-                                      && sector < protection_end
-                                      ? 0xffffffff : 0xabcdef12;
-
-            assert_page_mem(test_data, addr, expected_value);
-        }
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_write_block_protect_bottom_bit(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t sector_size = 65536;
-    uint32_t n_sectors = 512;
-
-    spi_ce_ctrl(test_data, 1 << (CRTL_EXTENDED0 + test_data->cs));
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    /* top bottom bit is enabled */
-    uint32_t bp_bits = 0b00100 << 3;
-
-    for (int i = 0; i < 16; i++) {
-        bp_bits = (((i & 0b1000) | 0b0100) << 3) | ((i & 0b0111) << 2);
-
-        spi_ctrl_start_user(test_data);
-        flash_writeb(test_data, 0, WREN);
-        flash_writeb(test_data, 0, BULK_ERASE);
-        flash_writeb(test_data, 0, WREN);
-        flash_writeb(test_data, 0, WRSR);
-        flash_writeb(test_data, 0, bp_bits);
-        flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-        flash_writeb(test_data, 0, WREN);
-        spi_ctrl_stop_user(test_data);
-
-        uint32_t num_protected_sectors = i ? MIN(1 << (i - 1), n_sectors) : 0;
-        uint32_t protection_start = 0;
-        uint32_t protection_end = num_protected_sectors;
-
-        for (int sector = 0; sector < n_sectors; sector++) {
-            uint32_t addr = sector * sector_size;
-
-            assert_page_mem(test_data, addr, 0xffffffff);
-            write_page_mem(test_data, addr, make_be32(0xabcdef12));
-
-            uint32_t expected_value = protection_start <= sector
-                                      && sector < protection_end
-                                      ? 0xffffffff : 0xabcdef12;
-
-            assert_page_mem(test_data, addr, expected_value);
-        }
-    }
-
-    flash_reset(test_data);
-}
-
-static void test_write_page_qpi(const void *data)
-{
-    const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = test_data->page_addr;
-    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
-    uint32_t page[FLASH_PAGE_SIZE / 4];
-    uint32_t page_pattern[] = {
-        0xebd8c134, 0x5da196bc, 0xae15e729, 0x5085ccdf
-    };
-    int i;
-
-    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
-
-    spi_ctrl_start_user(test_data);
-    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
-    flash_writeb(test_data, 0, WREN);
-    flash_writeb(test_data, 0, PP);
-    flash_writel(test_data, 0, make_be32(my_page_addr));
-
-    /* Set QPI mode */
-    spi_ctrl_set_io_mode(test_data, CTRL_IO_QUAD_IO);
-
-    /* Fill the page pattern */
-    for (i = 0; i < ARRAY_SIZE(page_pattern); i++) {
-        flash_writel(test_data, 0, make_be32(page_pattern[i]));
-    }
-
-    /* Fill the page with its own addresses */
-    for (; i < FLASH_PAGE_SIZE / 4; i++) {
-        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
-    }
-
-    /* Restore io mode */
-    spi_ctrl_set_io_mode(test_data, 0);
-    spi_ctrl_stop_user(test_data);
-
-    /* Check what was written */
-    read_page(test_data, my_page_addr, page);
-    for (i = 0; i < ARRAY_SIZE(page_pattern); i++) {
-        g_assert_cmphex(page[i], ==, page_pattern[i]);
-    }
-    for (; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
-    }
-
-    /* Check some other page. It should be full of 0xff */
-    read_page(test_data, some_page_addr, page);
-    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
-        g_assert_cmphex(page[i], ==, 0xffffffff);
-    }
-
-    flash_reset(test_data);
-}
+#include "aspeed-smc-utils.h"
 
 static void test_palmetto_bmc(TestData *data)
 {
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 41f3678cee..fde4de902b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -353,6 +353,7 @@ qtests = {
   'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
 }
 
 if vnc.found()
-- 
2.34.1


