Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50214C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQGL-0007Y5-EP; Wed, 08 Jul 2026 07:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQGK-0007Xq-30
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQGI-0003I3-Dr
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783509377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Fbn+VK0OtQnpi0tsE230Ytk7RdN1mqvznePHHzJSW4=;
 b=c9F2euLBApw6HM9ywxOMhRmBWgD100E/Y9/y7+IL/nJu73zny7epMYda4IGvflKzZK5iKq
 FOx+gn0XHQWZ3viAaVfsp+H2BHusXpGrfxPmuv5kptXr5BppJC7IM89aNxxp5+BaTJKqXI
 7JH5iVFmMeq3agp5DNPq8ROJq96JVRg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-E13dc8oyOE2EusiDS5Ag_A-1; Wed,
 08 Jul 2026 07:16:12 -0400
X-MC-Unique: E13dc8oyOE2EusiDS5Ag_A-1
X-Mimecast-MFC-AGG-ID: E13dc8oyOE2EusiDS5Ag_A_1783509370
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 209A01955DC2; Wed,  8 Jul 2026 11:16:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A1FC1955F43; Wed,  8 Jul 2026 11:16:04 +0000 (UTC)
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
Subject: [PATCH 3/4] tests/qtest: aspeed_smc: Add Dual Output Read (DOR) test
 coverage
Date: Wed,  8 Jul 2026 13:15:43 +0200
Message-ID: <20260708111544.1440761-4-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-1-clg@redhat.com>
References: <20260708111544.1440761-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add read_page_mem_dor (CTRL_FREADMODE with DOR command and dual data
IO mode) and write_page_dor (user-mode DOR) tests.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |  4 +++
 tests/qtest/aspeed-smc-utils.c | 50 ++++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c  | 16 +++++++++++
 tests/qtest/ast2700-smc-test.c |  4 +++
 4 files changed, 74 insertions(+)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index 5a86514caf35..fbfb94e831d8 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -44,6 +44,7 @@
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
+#define   CTRL_IO_DUAL_DATA     BIT(29)
 #define   CTRL_DUMMY_LOW_SHIFT   6
 #define   CTRL_DUMMY_HIGH_SHIFT  14
 #define SR_WEL BIT(1)
@@ -58,6 +59,7 @@ enum {
     BULK_ERASE = 0xc7,
     READ = 0x03,
     FAST_READ = 0x0b,
+    DOR = 0x3b,
     PP = 0x02,
     WRSR = 0x1,
     WREN = 0x6,
@@ -95,5 +97,7 @@ void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
 void aspeed_smc_test_write_page_qpi(const void *data);
 void aspeed_smc_test_read_page_mem_fast_read(const void *data);
 void aspeed_smc_test_write_page_fast_read(const void *data);
+void aspeed_smc_test_read_page_mem_dor(const void *data);
+void aspeed_smc_test_write_page_dor(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 9883ade0815c..25e3d28ec646 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -746,3 +746,53 @@ void aspeed_smc_test_write_page_fast_read(const void *data)
 {
     test_write_page(data, read_page_fast_read);
 }
+
+static void read_page_mem_dor(const AspeedSMCTestData *data,
+                              uint32_t addr, uint32_t *page)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+    int i;
+
+    ctrl &= ~(CTRL_USERMODE | (0xff << 16) |
+              (0x3 << CTRL_DUMMY_LOW_SHIFT) |
+              (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
+              CTRL_IO_MODE_MASK);
+    ctrl |= CTRL_FREADMODE | (DOR << 16) |
+            (1 << CTRL_DUMMY_LOW_SHIFT) |
+            CTRL_IO_DUAL_DATA;
+    spi_writel(data, ctrl_reg, ctrl);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, addr + i * 4));
+    }
+}
+
+void aspeed_smc_test_read_page_mem_dor(const void *data)
+{
+    test_read_page_mem(data, read_page_mem_dor);
+}
+
+static void read_page_dor(const AspeedSMCTestData *data,
+                          uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_start_user(data);
+
+    flash_writeb(data, 0, EN_4BYTE_ADDR);
+    flash_writeb(data, 0, DOR);
+    flash_writel(data, 0, make_be32(addr));
+    /* 1 dummy byte for standard SPI DOR */
+    flash_writeb(data, 0, 0x00);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, 0));
+    }
+    spi_ctrl_stop_user(data);
+}
+
+void aspeed_smc_test_write_page_dor(const void *data)
+{
+    test_write_page(data, read_page_dor);
+}
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index bbda15ad17ea..6d48444fd71b 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -72,6 +72,10 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast2400/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast2400/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast2400/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
     /*
      * Block protect tests must be run last because the block protect
      * state is not cleared by reset_memory() and silently prevents
@@ -128,6 +132,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast2500/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast2500/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast2500/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
 }
 
 static void test_ast2600_evb(AspeedSMCTestData *data)
@@ -175,6 +183,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast2600/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast2600/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast2600/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
 }
 
 static void test_ast1030_evb(AspeedSMCTestData *data)
@@ -222,6 +234,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast1030/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast1030/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast1030/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index 9ad04b574c0d..bd9d3f7905b3 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -56,6 +56,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast2700/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast2700/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast2700/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
 }
 
 int main(int argc, char **argv)
-- 
2.54.0


