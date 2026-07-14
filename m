Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB2BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcXD-0008Tv-Jz; Tue, 14 Jul 2026 08:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wjcXB-0008R0-Gl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wjcX9-0008BC-3B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784033205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCAiYwmj8ExlhKBSy8E/CycN6Swlk96mXU/Oa0xI/Kc=;
 b=Mw79UGt+S60cBcPZCcLs5/bQZDB8G0yysdWPTKAvvz88+IBHWHf5cb1ycUwgJ6z6TBD5mx
 /kx0L85VMfSnPRuosFOusc533YEb4+A6q86HSWUJft+4+7I/08zCTyniqg33WqsuGr0qtf
 9RMQ5nok7g8HzQUHeTLO9Lv4RbimmxI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-hSBqUBWxP3STZMGZPkGGLg-1; Tue,
 14 Jul 2026 08:46:42 -0400
X-MC-Unique: hSBqUBWxP3STZMGZPkGGLg-1
X-Mimecast-MFC-AGG-ID: hSBqUBWxP3STZMGZPkGGLg_1784033200
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0C56180064A; Tue, 14 Jul 2026 12:46:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43B7D3000232; Tue, 14 Jul 2026 12:46:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 2/4] tests/qtest: aspeed_smc: Add fast-read test coverage
Date: Tue, 14 Jul 2026 14:46:19 +0200
Message-ID: <20260714124621.522948-3-clg@redhat.com>
In-Reply-To: <20260714124621.522948-1-clg@redhat.com>
References: <20260714124621.522948-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Introduce a spi_ctrl_set_fast_read() helper and add
read_page_mem_fast_read (CTRL_FREADMODE with dummy byte) and
write_page_fast_read (user-mode FAST_READ) tests.

While at it, replace the license boilerplate with SPDX identifier.

Link: https://lore.kernel.org/qemu-devel/20260708111544.1440761-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h | 23 +++--------
 tests/qtest/aspeed-smc-utils.c | 75 ++++++++++++++++++++++++++--------
 tests/qtest/aspeed_smc-test.c  | 39 ++++++++++--------
 tests/qtest/ast2700-smc-test.c |  4 ++
 4 files changed, 90 insertions(+), 51 deletions(-)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index e2fd8ff1bd16..7504f5a525b4 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -4,23 +4,7 @@
  *
  * Copyright (C) 2016 IBM Corp.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * SPDX-License-Identifier: MIT
  */
 
 #ifndef TESTS_ASPEED_SMC_UTILS_H
@@ -44,6 +28,8 @@
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
+#define   CTRL_DUMMY_LOW_SHIFT   6
+#define   CTRL_DUMMY_HIGH_SHIFT  14
 #define SR_WEL BIT(1)
 
 /*
@@ -55,6 +41,7 @@ enum {
     WRDI = 0x4,
     BULK_ERASE = 0xc7,
     READ = 0x03,
+    FAST_READ = 0x0b,
     PP = 0x02,
     WRSR = 0x1,
     WREN = 0x6,
@@ -90,5 +77,7 @@ void aspeed_smc_test_status_reg_write_protection(const void *data);
 void aspeed_smc_test_write_block_protect(const void *data);
 void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
 void aspeed_smc_test_write_page_qpi(const void *data);
+void aspeed_smc_test_read_page_mem_fast_read(const void *data);
+void aspeed_smc_test_write_page_fast_read(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index ed125741eb36..07e65e0173d9 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -4,23 +4,7 @@
  *
  * Copyright (C) 2016 IBM Corp.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * SPDX-License-Identifier: MIT
  */
 
 #include "qemu/osdep.h"
@@ -107,6 +91,23 @@ static void spi_ctrl_setmode(const AspeedSMCTestData *data, uint8_t mode,
     spi_writel(data, ctrl_reg, ctrl);
 }
 
+/* Set FREADMODE with a fast read command and 1 dummy byte */
+static void spi_ctrl_set_fast_read(const AspeedSMCTestData *data, uint8_t cmd)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+    uint32_t iomode = 0;
+
+    ctrl &= ~(CTRL_USERMODE | (0xff << 16) |
+              (0x3 << CTRL_DUMMY_LOW_SHIFT) |
+              (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
+              CTRL_IO_MODE_MASK);
+    ctrl |= CTRL_FREADMODE | (cmd << 16) |
+            (1 << CTRL_DUMMY_LOW_SHIFT) |
+            iomode;
+    spi_writel(data, ctrl_reg, ctrl);
+}
+
 static void spi_ctrl_start_user(const AspeedSMCTestData *data)
 {
     uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
@@ -697,3 +698,43 @@ void aspeed_smc_test_write_page_qpi(const void *data)
     flash_reset(test_data);
 }
 
+static void read_page_mem_fast_read(const AspeedSMCTestData *data,
+                                uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_set_fast_read(data, FAST_READ);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, addr + i * 4));
+    }
+}
+
+void aspeed_smc_test_read_page_mem_fast_read(const void *data)
+{
+    test_read_page_mem(data, read_page_mem_fast_read);
+}
+
+static void read_page_fast_read(const AspeedSMCTestData *data,
+                                uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_start_user(data);
+
+    flash_writeb(data, 0, EN_4BYTE_ADDR);
+    flash_writeb(data, 0, FAST_READ);
+    flash_writel(data, 0, make_be32(addr));
+    /* 1 dummy byte for standard SPI fast-read */
+    flash_writeb(data, 0, 0x00);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, 0));
+    }
+    spi_ctrl_stop_user(data);
+}
+
+void aspeed_smc_test_write_page_fast_read(const void *data)
+{
+    test_write_page(data, read_page_fast_read);
+}
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 39af1df0ed75..4697c493a813 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -4,23 +4,7 @@
  *
  * Copyright (C) 2016 IBM Corp.
  *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * SPDX-License-Identifier: MIT
  */
 
 #include "qemu/osdep.h"
@@ -68,6 +52,15 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2400/smc/status_reg_write_protection",
                         data, aspeed_smc_test_status_reg_write_protection);
+    qtest_add_data_func("/ast2400/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2400/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
+    /*
+     * Block protect tests must be run last because the block protect
+     * state is not cleared by reset_memory() and silently prevents
+     * subsequent flash writes.
+     */
     qtest_add_data_func("/ast2400/smc/write_block_protect",
                         data, aspeed_smc_test_write_block_protect);
     qtest_add_data_func("/ast2400/smc/write_block_protect_bottom_bit",
@@ -115,6 +108,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2500/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast2500/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2500/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 static void test_ast2600_evb(AspeedSMCTestData *data)
@@ -158,6 +155,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2600/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast2600/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2600/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 static void test_ast1030_evb(AspeedSMCTestData *data)
@@ -201,6 +202,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast1030/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast1030/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast1030/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index 33fc47230ee5..9ad04b574c0d 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -52,6 +52,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2700/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast2700/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2700/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 int main(int argc, char **argv)
-- 
2.54.0


