Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE8FC44503
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQGP-0007Yj-LD; Wed, 08 Jul 2026 07:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQGN-0007YQ-Pv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQGM-0003IV-59
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783509381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLNKunQoDDJUsz79zJdFRXcy4SqehjkP0GSVlanFaQQ=;
 b=X1jjzflNJAqpUI9q5Xh899M2+gJYbZcXcyPuTEPm5Td5qqoLNMPVYsr44c9tbXqxi2V/U1
 Glu75tAKsz49biz9tXRDp5Ku4ffyqizK9oeMoU2gk2lQ2wsz6JYMk4KfwLBkJJ/XonKoJ4
 9kDxpTF0bYt5YVe47NvjYXctXRt1FsY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-lB0GYOzkPd-SHx-puQ3eHw-1; Wed,
 08 Jul 2026 07:16:17 -0400
X-MC-Unique: lB0GYOzkPd-SHx-puQ3eHw-1
X-Mimecast-MFC-AGG-ID: lB0GYOzkPd-SHx-puQ3eHw_1783509375
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56F001955E72; Wed,  8 Jul 2026 11:16:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D84D1955F7B; Wed,  8 Jul 2026 11:16:10 +0000 (UTC)
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
Subject: [PATCH 4/4] tests/qtest: aspeed_smc: Add Quad Output Read (QOR) test
 coverage
Date: Wed,  8 Jul 2026 13:15:44 +0200
Message-ID: <20260708111544.1440761-5-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-1-clg@redhat.com>
References: <20260708111544.1440761-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add read_page_mem_qor (CTRL_FREADMODE with QOR command and quad data
IO mode) and write_page_qor (user-mode QOR) tests.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |  4 +++
 tests/qtest/aspeed-smc-utils.c | 50 ++++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c  | 16 +++++++++++
 tests/qtest/ast2700-smc-test.c |  4 +++
 4 files changed, 74 insertions(+)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index fbfb94e831d8..f5720f1becc1 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -44,6 +44,7 @@
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
+#define   CTRL_IO_QUAD_DATA     BIT(30)
 #define   CTRL_IO_DUAL_DATA     BIT(29)
 #define   CTRL_DUMMY_LOW_SHIFT   6
 #define   CTRL_DUMMY_HIGH_SHIFT  14
@@ -60,6 +61,7 @@ enum {
     READ = 0x03,
     FAST_READ = 0x0b,
     DOR = 0x3b,
+    QOR = 0x6b,
     PP = 0x02,
     WRSR = 0x1,
     WREN = 0x6,
@@ -99,5 +101,7 @@ void aspeed_smc_test_read_page_mem_fast_read(const void *data);
 void aspeed_smc_test_write_page_fast_read(const void *data);
 void aspeed_smc_test_read_page_mem_dor(const void *data);
 void aspeed_smc_test_write_page_dor(const void *data);
+void aspeed_smc_test_read_page_mem_qor(const void *data);
+void aspeed_smc_test_write_page_qor(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 25e3d28ec646..bc64a3eb9477 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -796,3 +796,53 @@ void aspeed_smc_test_write_page_dor(const void *data)
 {
     test_write_page(data, read_page_dor);
 }
+
+static void read_page_mem_qor(const AspeedSMCTestData *data,
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
+    ctrl |= CTRL_FREADMODE | (QOR << 16) |
+            (1 << CTRL_DUMMY_LOW_SHIFT) |
+            CTRL_IO_QUAD_DATA;
+    spi_writel(data, ctrl_reg, ctrl);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, addr + i * 4));
+    }
+}
+
+void aspeed_smc_test_read_page_mem_qor(const void *data)
+{
+    test_read_page_mem(data, read_page_mem_qor);
+}
+
+static void read_page_qor(const AspeedSMCTestData *data,
+                          uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_start_user(data);
+
+    flash_writeb(data, 0, EN_4BYTE_ADDR);
+    flash_writeb(data, 0, QOR);
+    flash_writel(data, 0, make_be32(addr));
+    /* 1 dummy byte for standard SPI QOR */
+    flash_writeb(data, 0, 0x00);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, 0));
+    }
+    spi_ctrl_stop_user(data);
+}
+
+void aspeed_smc_test_write_page_qor(const void *data)
+{
+    test_write_page(data, read_page_qor);
+}
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 6d48444fd71b..004951380e9e 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -76,6 +76,10 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast2400/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast2400/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast2400/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
     /*
      * Block protect tests must be run last because the block protect
      * state is not cleared by reset_memory() and silently prevents
@@ -136,6 +140,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast2500/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast2500/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast2500/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
 }
 
 static void test_ast2600_evb(AspeedSMCTestData *data)
@@ -187,6 +195,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast2600/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast2600/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast2600/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
 }
 
 static void test_ast1030_evb(AspeedSMCTestData *data)
@@ -238,6 +250,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast1030/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast1030/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast1030/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index bd9d3f7905b3..f85077e04ff4 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -60,6 +60,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast2700/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast2700/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast2700/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
 }
 
 int main(int argc, char **argv)
-- 
2.54.0


