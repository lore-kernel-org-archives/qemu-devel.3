Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDD6C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcXK-0000Bj-NP; Tue, 14 Jul 2026 08:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wjcXJ-00009A-OL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wjcXH-0008C7-O9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784033215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTaXkoVkYfEsNfCpbt4txb6zDycLcBG7tKfW0fkss5g=;
 b=PsliRpLm0xcrmDn1nlBbk7lJgWiggHlGR14E2BqgnHXvXZAwkYY7jeND7YuIz2nEnGdMuz
 iPEfrezdSGfWqnLq3GTpuKFOganYdR6eSciUMFUaiD3ozf1Qsk8jg1TgXfcj2GqI+X4fIH
 GpHVxQMGe6ZGY33rAcDMA6b9CpBWYcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-jNIsdsnsOQWTr2dgeQP1vQ-1; Tue,
 14 Jul 2026 08:46:51 -0400
X-MC-Unique: jNIsdsnsOQWTr2dgeQP1vQ-1
X-Mimecast-MFC-AGG-ID: jNIsdsnsOQWTr2dgeQP1vQ_1784033210
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCCBC1800349; Tue, 14 Jul 2026 12:46:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53E3830001BE; Tue, 14 Jul 2026 12:46:45 +0000 (UTC)
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
Subject: [PATCH v2 4/4] tests/qtest: aspeed_smc: Add Quad Output Read (QOR)
 test coverage
Date: Tue, 14 Jul 2026 14:46:21 +0200
Message-ID: <20260714124621.522948-5-clg@redhat.com>
In-Reply-To: <20260714124621.522948-1-clg@redhat.com>
References: <20260714124621.522948-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Link: https://lore.kernel.org/qemu-devel/20260708111544.1440761-5-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |  4 ++++
 tests/qtest/aspeed-smc-utils.c | 43 ++++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c  | 16 +++++++++++++
 tests/qtest/ast2700-smc-test.c |  4 ++++
 4 files changed, 67 insertions(+)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index 04d3c7db5f7b..19c557b822da 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -28,6 +28,7 @@
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
+#define   CTRL_IO_QUAD_DATA     BIT(30)
 #define   CTRL_IO_DUAL_DATA     BIT(29)
 #define   CTRL_DUMMY_LOW_SHIFT   6
 #define   CTRL_DUMMY_HIGH_SHIFT  14
@@ -44,6 +45,7 @@ enum {
     READ = 0x03,
     FAST_READ = 0x0b,
     DOR = 0x3b,
+    QOR = 0x6b,
     PP = 0x02,
     WRSR = 0x1,
     WREN = 0x6,
@@ -83,5 +85,7 @@ void aspeed_smc_test_read_page_mem_fast_read(const void *data);
 void aspeed_smc_test_write_page_fast_read(const void *data);
 void aspeed_smc_test_read_page_mem_dor(const void *data);
 void aspeed_smc_test_write_page_dor(const void *data);
+void aspeed_smc_test_read_page_mem_qor(const void *data);
+void aspeed_smc_test_write_page_qor(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 454224ec28b4..6d75a95578e7 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -100,6 +100,8 @@ static void spi_ctrl_set_fast_read(const AspeedSMCTestData *data, uint8_t cmd)
 
     if (cmd == DOR) {
         iomode = CTRL_IO_DUAL_DATA;
+    } else if (cmd == QOR) {
+        iomode = CTRL_IO_QUAD_DATA;
     }
 
     ctrl &= ~(CTRL_USERMODE | (0xff << 16) |
@@ -783,3 +785,44 @@ void aspeed_smc_test_write_page_dor(const void *data)
 {
     test_write_page(data, read_page_dor);
 }
+
+static void read_page_mem_qor(const AspeedSMCTestData *data,
+                              uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_set_fast_read(data, QOR);
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
index a67cc5a999ca..59c96bd68ae8 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -60,6 +60,10 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
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
@@ -120,6 +124,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast2500/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast2500/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast2500/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
 }
 
 static void test_ast2600_evb(AspeedSMCTestData *data)
@@ -171,6 +179,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_dor);
     qtest_add_data_func("/ast2600/smc/write_page_dor",
                         data, aspeed_smc_test_write_page_dor);
+    qtest_add_data_func("/ast2600/smc/read_page_mem_qor",
+                        data, aspeed_smc_test_read_page_mem_qor);
+    qtest_add_data_func("/ast2600/smc/write_page_qor",
+                        data, aspeed_smc_test_write_page_qor);
 }
 
 static void test_ast1030_evb(AspeedSMCTestData *data)
@@ -222,6 +234,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
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


