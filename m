Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CE2E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGHV-0007kC-4Z; Wed, 11 Dec 2024 01:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGZ-0005LB-JX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGS-00007a-1b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QX82KuJMjU0rbdbkKhq3B+kF00zTAP44ZwlV2QmZqFw=;
 b=dcrvLXUJUp/oKjvCXgO6BlKfdGEi0johJdEpz/NMKlH2zhWgoCusVmY4aeLb+V2kEuaRQ5
 reqWJ7Shy+BU7+svTnnrCsSJXR6r+ipx5+YW1H35pFlRwhWuglR2WoNWc3T0ifHMuJ1RUN
 uAEn75Q6CuFeVy5MjKKEqF2vIUlMWOI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-deMrCTHWP0ik-LiBzhEeWw-1; Wed,
 11 Dec 2024 01:31:55 -0500
X-MC-Unique: deMrCTHWP0ik-LiBzhEeWw-1
X-Mimecast-MFC-AGG-ID: deMrCTHWP0ik-LiBzhEeWw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39C3419560A2; Wed, 11 Dec 2024 06:31:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C8131956054; Wed, 11 Dec 2024 06:31:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/24] test/qtest: Introduce a new aspeed-smc-utils.c to place
 common testcases
Date: Wed, 11 Dec 2024 07:30:57 +0100
Message-ID: <20241211063058.1222038-24-clg@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The testcases for ASPEED SMC model were placed in aspeed_smc-test.c.
However, this test file only supports for ARM32. To support all ASPEED SOCs
such as AST2700 whose CPU architecture is aarch64, introduces a new
aspeed-smc-utils source file and move all common APIs and testcases
from aspeed_smc-test.c to aspeed-smc-utils.c.

Finally, users are able to re-used these testcase for AST2700 and future
ASPEED SOCs testing.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20241127091543.1243114-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |  95 ++++
 tests/qtest/aspeed-smc-utils.c | 686 ++++++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c  | 800 +++------------------------------
 tests/qtest/meson.build        |   1 +
 4 files changed, 841 insertions(+), 741 deletions(-)
 create mode 100644 tests/qtest/aspeed-smc-utils.h
 create mode 100644 tests/qtest/aspeed-smc-utils.c

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
new file mode 100644
index 000000000000..b07870f3b8fa
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
+typedef struct AspeedSMCTestData {
+    QTestState *s;
+    uint64_t spi_base;
+    uint64_t flash_base;
+    uint32_t jedec_id;
+    char *tmp_path;
+    uint8_t cs;
+    const char *node;
+    uint32_t page_addr;
+} AspeedSMCTestData;
+
+void aspeed_smc_test_read_jedec(const void *data);
+void aspeed_smc_test_erase_sector(const void *data);
+void aspeed_smc_test_erase_all(const void *data);
+void aspeed_smc_test_write_page(const void *data);
+void aspeed_smc_test_read_page_mem(const void *data);
+void aspeed_smc_test_write_page_mem(const void *data);
+void aspeed_smc_test_read_status_reg(const void *data);
+void aspeed_smc_test_status_reg_write_protection(const void *data);
+void aspeed_smc_test_write_block_protect(const void *data);
+void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
+void aspeed_smc_test_write_page_qpi(const void *data);
+
+#endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
new file mode 100644
index 000000000000..c27d09e767e5
--- /dev/null
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -0,0 +1,686 @@
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
+static inline void spi_writel(const AspeedSMCTestData *data, uint64_t offset,
+                              uint32_t value)
+{
+    qtest_writel(data->s, data->spi_base + offset, value);
+}
+
+static inline uint32_t spi_readl(const AspeedSMCTestData *data, uint64_t offset)
+{
+    return qtest_readl(data->s, data->spi_base + offset);
+}
+
+static inline void flash_writeb(const AspeedSMCTestData *data, uint64_t offset,
+                                uint8_t value)
+{
+    qtest_writeb(data->s, data->flash_base + offset, value);
+}
+
+static inline void flash_writel(const AspeedSMCTestData *data, uint64_t offset,
+                                uint32_t value)
+{
+    qtest_writel(data->s, data->flash_base + offset, value);
+}
+
+static inline uint8_t flash_readb(const AspeedSMCTestData *data,
+                                  uint64_t offset)
+{
+    return qtest_readb(data->s, data->flash_base + offset);
+}
+
+static inline uint32_t flash_readl(const AspeedSMCTestData *data,
+                                   uint64_t offset)
+{
+    return qtest_readl(data->s, data->flash_base + offset);
+}
+
+static void spi_conf(const AspeedSMCTestData *data, uint32_t value)
+{
+    uint32_t conf = spi_readl(data, R_CONF);
+
+    conf |= value;
+    spi_writel(data, R_CONF, conf);
+}
+
+static void spi_conf_remove(const AspeedSMCTestData *data, uint32_t value)
+{
+    uint32_t conf = spi_readl(data, R_CONF);
+
+    conf &= ~value;
+    spi_writel(data, R_CONF, conf);
+}
+
+static void spi_ce_ctrl(const AspeedSMCTestData *data, uint32_t value)
+{
+    uint32_t conf = spi_readl(data, R_CE_CTRL);
+
+    conf |= value;
+    spi_writel(data, R_CE_CTRL, conf);
+}
+
+static void spi_ctrl_setmode(const AspeedSMCTestData *data, uint8_t mode,
+                             uint8_t cmd)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+    ctrl &= ~(CTRL_USERMODE | 0xff << 16);
+    ctrl |= mode | (cmd << 16);
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
+static void spi_ctrl_start_user(const AspeedSMCTestData *data)
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
+static void spi_ctrl_stop_user(const AspeedSMCTestData *data)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+
+    ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
+static void spi_ctrl_set_io_mode(const AspeedSMCTestData *data, uint32_t value)
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
+static void flash_reset(const AspeedSMCTestData *data)
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
+static void read_page(const AspeedSMCTestData *data, uint32_t addr,
+                      uint32_t *page)
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
+static void read_page_mem(const AspeedSMCTestData *data, uint32_t addr,
+                          uint32_t *page)
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
+static void write_page_mem(const AspeedSMCTestData *data, uint32_t addr,
+                           uint32_t write_value)
+{
+    spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
+
+    for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(data, addr + i * 4, write_value);
+    }
+}
+
+static void assert_page_mem(const AspeedSMCTestData *data, uint32_t addr,
+                            uint32_t expected_value)
+{
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    read_page_mem(data, addr, page);
+    for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, expected_value);
+    }
+}
+
+void aspeed_smc_test_read_jedec(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_erase_sector(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_erase_all(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_write_page(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_read_page_mem(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_write_page_mem(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_read_status_reg(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_status_reg_write_protection(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_write_block_protect(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_write_block_protect_bottom_bit(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
+void aspeed_smc_test_write_page_qpi(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
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
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 59f3876cdc36..4e1389385d85 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -27,707 +27,9 @@
 #include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
+#include "aspeed-smc-utils.h"
 
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
-
-static void test_palmetto_bmc(TestData *data)
+static void test_palmetto_bmc(AspeedSMCTestData *data)
 {
     int ret;
     int fd;
@@ -751,25 +53,29 @@ static void test_palmetto_bmc(TestData *data)
     /* beyond 16MB */
     data->page_addr = 0x14000 * FLASH_PAGE_SIZE;
 
-    qtest_add_data_func("/ast2400/smc/read_jedec", data, test_read_jedec);
-    qtest_add_data_func("/ast2400/smc/erase_sector", data, test_erase_sector);
-    qtest_add_data_func("/ast2400/smc/erase_all",  data, test_erase_all);
-    qtest_add_data_func("/ast2400/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast2400/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast2400/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast2400/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast2400/smc/write_page",
+                        data, aspeed_smc_test_write_page);
     qtest_add_data_func("/ast2400/smc/read_page_mem",
-                        data, test_read_page_mem);
+                        data, aspeed_smc_test_read_page_mem);
     qtest_add_data_func("/ast2400/smc/write_page_mem",
-                        data, test_write_page_mem);
+                        data, aspeed_smc_test_write_page_mem);
     qtest_add_data_func("/ast2400/smc/read_status_reg",
-                        data, test_read_status_reg);
+                        data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2400/smc/status_reg_write_protection",
-                        data, test_status_reg_write_protection);
+                        data, aspeed_smc_test_status_reg_write_protection);
     qtest_add_data_func("/ast2400/smc/write_block_protect",
-                        data, test_write_block_protect);
+                        data, aspeed_smc_test_write_block_protect);
     qtest_add_data_func("/ast2400/smc/write_block_protect_bottom_bit",
-                        data, test_write_block_protect_bottom_bit);
+                        data, aspeed_smc_test_write_block_protect_bottom_bit);
 }
 
-static void test_ast2500_evb(TestData *data)
+static void test_ast2500_evb(AspeedSMCTestData *data)
 {
     int ret;
     int fd;
@@ -794,21 +100,25 @@ static void test_ast2500_evb(TestData *data)
     /* beyond 16MB */
     data->page_addr = 0x14000 * FLASH_PAGE_SIZE;
 
-    qtest_add_data_func("/ast2500/smc/read_jedec", data, test_read_jedec);
-    qtest_add_data_func("/ast2500/smc/erase_sector", data, test_erase_sector);
-    qtest_add_data_func("/ast2500/smc/erase_all",  data, test_erase_all);
-    qtest_add_data_func("/ast2500/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast2500/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast2500/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast2500/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast2500/smc/write_page",
+                        data, aspeed_smc_test_write_page);
     qtest_add_data_func("/ast2500/smc/read_page_mem",
-                        data, test_read_page_mem);
+                        data, aspeed_smc_test_read_page_mem);
     qtest_add_data_func("/ast2500/smc/write_page_mem",
-                        data, test_write_page_mem);
+                        data, aspeed_smc_test_write_page_mem);
     qtest_add_data_func("/ast2500/smc/read_status_reg",
-                        data, test_read_status_reg);
+                        data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2500/smc/write_page_qpi",
-                        data, test_write_page_qpi);
+                        data, aspeed_smc_test_write_page_qpi);
 }
 
-static void test_ast2600_evb(TestData *data)
+static void test_ast2600_evb(AspeedSMCTestData *data)
 {
     int ret;
     int fd;
@@ -833,21 +143,25 @@ static void test_ast2600_evb(TestData *data)
     /* beyond 16MB */
     data->page_addr = 0x14000 * FLASH_PAGE_SIZE;
 
-    qtest_add_data_func("/ast2600/smc/read_jedec", data, test_read_jedec);
-    qtest_add_data_func("/ast2600/smc/erase_sector", data, test_erase_sector);
-    qtest_add_data_func("/ast2600/smc/erase_all",  data, test_erase_all);
-    qtest_add_data_func("/ast2600/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast2600/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast2600/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast2600/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast2600/smc/write_page",
+                        data, aspeed_smc_test_write_page);
     qtest_add_data_func("/ast2600/smc/read_page_mem",
-                        data, test_read_page_mem);
+                        data, aspeed_smc_test_read_page_mem);
     qtest_add_data_func("/ast2600/smc/write_page_mem",
-                        data, test_write_page_mem);
+                        data, aspeed_smc_test_write_page_mem);
     qtest_add_data_func("/ast2600/smc/read_status_reg",
-                        data, test_read_status_reg);
+                        data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2600/smc/write_page_qpi",
-                        data, test_write_page_qpi);
+                        data, aspeed_smc_test_write_page_qpi);
 }
 
-static void test_ast1030_evb(TestData *data)
+static void test_ast1030_evb(AspeedSMCTestData *data)
 {
     int ret;
     int fd;
@@ -872,26 +186,30 @@ static void test_ast1030_evb(TestData *data)
     /* beyond 512KB */
     data->page_addr = 0x800 * FLASH_PAGE_SIZE;
 
-    qtest_add_data_func("/ast1030/smc/read_jedec", data, test_read_jedec);
-    qtest_add_data_func("/ast1030/smc/erase_sector", data, test_erase_sector);
-    qtest_add_data_func("/ast1030/smc/erase_all",  data, test_erase_all);
-    qtest_add_data_func("/ast1030/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast1030/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast1030/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast1030/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast1030/smc/write_page",
+                        data, aspeed_smc_test_write_page);
     qtest_add_data_func("/ast1030/smc/read_page_mem",
-                        data, test_read_page_mem);
+                        data, aspeed_smc_test_read_page_mem);
     qtest_add_data_func("/ast1030/smc/write_page_mem",
-                        data, test_write_page_mem);
+                        data, aspeed_smc_test_write_page_mem);
     qtest_add_data_func("/ast1030/smc/read_status_reg",
-                        data, test_read_status_reg);
+                        data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast1030/smc/write_page_qpi",
-                        data, test_write_page_qpi);
+                        data, aspeed_smc_test_write_page_qpi);
 }
 
 int main(int argc, char **argv)
 {
-    TestData palmetto_data;
-    TestData ast2500_evb_data;
-    TestData ast2600_evb_data;
-    TestData ast1030_evb_data;
+    AspeedSMCTestData palmetto_data;
+    AspeedSMCTestData ast2500_evb_data;
+    AspeedSMCTestData ast2600_evb_data;
+    AspeedSMCTestData ast1030_evb_data;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bd41c9da5fd9..f8b3907e370d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -360,6 +360,7 @@ qtests = {
   'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
 }
 
 if vnc.found()
-- 
2.47.1


