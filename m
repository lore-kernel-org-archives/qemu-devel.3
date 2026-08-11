Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994F5C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO2-0002iM-9f; Tue, 11 Aug 2026 12:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO1-0002eJ-0d
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNy-0000pg-VV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMrLklYSb+PAdWlbU/ZT6AUk1PYbty1cUFgGDY1jVVI=;
 b=gnjmXtFUAik0envYO5Ku6xJyXYUD+4VhYOzKNji2JNUkBDW0FFfOZ2xEA9NZOCWJxFO4f1
 AhPVAKWq/kPVM0y2YD8ogUmthsWs09zGnsHVM+IQv8SxzgCClxmqLyrUFgKWFQK2K50Zq+
 EKcKU4V09G4z4Jk1yg6g8xEBIGyo244=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-P4BYEhDZOZitq6oyj1zt6w-1; Tue,
 11 Aug 2026 12:30:19 -0400
X-MC-Unique: P4BYEhDZOZitq6oyj1zt6w-1
X-Mimecast-MFC-AGG-ID: P4BYEhDZOZitq6oyj1zt6w_1786465818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 449F3195609E; Tue, 11 Aug 2026 16:30:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3075195DF91; Tue, 11 Aug 2026 16:30:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bin.meng@processmission.com>
Subject: [PULL 16/83] tests/qtest: aspeed_smc: Add Dual Output Read (DOR) test
 coverage
Date: Tue, 11 Aug 2026 18:28:31 +0200
Message-ID: <20260811162938.1403216-17-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Link: https://lore.kernel.org/qemu-devel/20260714124621.522948-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |  4 +++
 tests/qtest/aspeed-smc-utils.c | 45 ++++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c  | 16 ++++++++++++
 tests/qtest/ast2700-smc-test.c |  4 +++
 4 files changed, 69 insertions(+)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index 7504f5a525b4..04d3c7db5f7b 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -28,6 +28,7 @@
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
+#define   CTRL_IO_DUAL_DATA     BIT(29)
 #define   CTRL_DUMMY_LOW_SHIFT   6
 #define   CTRL_DUMMY_HIGH_SHIFT  14
 #define SR_WEL BIT(1)
@@ -42,6 +43,7 @@ enum {
     BULK_ERASE = 0xc7,
     READ = 0x03,
     FAST_READ = 0x0b,
+    DOR = 0x3b,
     PP = 0x02,
     WRSR = 0x1,
     WREN = 0x6,
@@ -79,5 +81,7 @@ void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
 void aspeed_smc_test_write_page_qpi(const void *data);
 void aspeed_smc_test_read_page_mem_fast_read(const void *data);
 void aspeed_smc_test_write_page_fast_read(const void *data);
+void aspeed_smc_test_read_page_mem_dor(const void *data);
+void aspeed_smc_test_write_page_dor(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 07e65e0173d9..454224ec28b4 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -98,6 +98,10 @@ static void spi_ctrl_set_fast_read(const AspeedSMCTestData *data, uint8_t cmd)
     uint32_t ctrl = spi_readl(data, ctrl_reg);
     uint32_t iomode = 0;
 
+    if (cmd == DOR) {
+        iomode = CTRL_IO_DUAL_DATA;
+    }
+
     ctrl &= ~(CTRL_USERMODE | (0xff << 16) |
               (0x3 << CTRL_DUMMY_LOW_SHIFT) |
               (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
@@ -738,3 +742,44 @@ void aspeed_smc_test_write_page_fast_read(const void *data)
 {
     test_write_page(data, read_page_fast_read);
 }
+
+static void read_page_mem_dor(const AspeedSMCTestData *data,
+                              uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_set_fast_read(data, DOR);
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
index 4697c493a813..a67cc5a999ca 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -56,6 +56,10 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
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
@@ -112,6 +116,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast2500/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast2500/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast2500/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
 }
 
 static void test_ast2600_evb(AspeedSMCTestData *data)
@@ -159,6 +167,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_fast_read);
     qtest_add_data_func("/ast2600/smc/write_page_fast_read",
                         data, aspeed_smc_test_write_page_fast_read);
+    qtest_add_data_func("/ast2600/smc/read_page_mem_dor",
+                        data, aspeed_smc_test_read_page_mem_dor);
+    qtest_add_data_func("/ast2600/smc/write_page_dor",
+                        data, aspeed_smc_test_write_page_dor);
 }
 
 static void test_ast1030_evb(AspeedSMCTestData *data)
@@ -206,6 +218,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
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
2.55.0


