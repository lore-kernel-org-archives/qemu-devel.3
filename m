Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69ABC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNi-0001Sy-VP; Tue, 11 Aug 2026 12:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNG-0008Er-Je
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpND-0000do-5N
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgNu+z8I6bP5UkS65U7QHRTgBEr1RZknGgR+QfGVUSc=;
 b=MnfZDVRKB8f21savVBYBAD1i4yJzJvIScCOzzfaEpgazOwon9EL33Sn1yEpqS2tbAMZ1sT
 6yZWrxkk74J41BcPGmY+00bgoKMZMscHE8V+P8071bbmzW+LClT567DauZZRF3fZjqFh7K
 coti1qQvwAKusNC0Pras7/2qwF88SyI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-dmcIaOuTMgSMz4zKXTBNvA-1; Tue,
 11 Aug 2026 12:30:41 -0400
X-MC-Unique: dmcIaOuTMgSMz4zKXTBNvA-1
X-Mimecast-MFC-AGG-ID: dmcIaOuTMgSMz4zKXTBNvA_1786465840
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3552195606C; Tue, 11 Aug 2026 16:30:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75F0D195DF91; Tue, 11 Aug 2026 16:30:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/83] tests/qtest/ast2700-smc-test: Add Data FIFO mode test
Date: Tue, 11 Aug 2026 18:28:41 +0200
Message-ID: <20260811162938.1403216-27-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add two qtest cases exercising the new AST2700 Data FIFO-based flash
access path (R_DATA_FIFO at spi_base + 0x200).

Write_page_datafifo sends the page-program command and data through
the FIFO port, then verifies the result via the regular read path.
Read_page_datafifo writes a page the regular way, then reads it back
through the FIFO port, so both directions are checked independently.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |   4 ++
 tests/qtest/aspeed-smc-utils.c | 102 +++++++++++++++++++++++++++++++++
 tests/qtest/ast2700-smc-test.c |   4 ++
 3 files changed, 110 insertions(+)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index 19c557b822da..e4f538e5794b 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -33,6 +33,8 @@
 #define   CTRL_DUMMY_LOW_SHIFT   6
 #define   CTRL_DUMMY_HIGH_SHIFT  14
 #define SR_WEL BIT(1)
+/* Data fifo */
+#define R_DATA_FIFO 0x200
 
 /*
  * Flash commands
@@ -87,5 +89,7 @@ void aspeed_smc_test_read_page_mem_dor(const void *data);
 void aspeed_smc_test_write_page_dor(const void *data);
 void aspeed_smc_test_read_page_mem_qor(const void *data);
 void aspeed_smc_test_write_page_qor(const void *data);
+void aspeed_smc_test_write_page_datafifo(const void *data);
+void aspeed_smc_test_read_page_datafifo(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 6d75a95578e7..146332240d66 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -57,6 +57,28 @@ static inline uint32_t flash_readl(const AspeedSMCTestData *data,
     return qtest_readl(data->s, data->flash_base + offset);
 }
 
+/*
+ * Data FIFO port, in spi_base's register bank (not flash_base). Accesses
+ * through the FIFO require the complete user-mode transaction (opcode,
+ * address, and data). Assumes CS0, whose FIFO slot is at R_DATA_FIFO.
+ */
+static inline void datafifo_writeb(const AspeedSMCTestData *data,
+                                   uint8_t value)
+{
+    qtest_writeb(data->s, data->spi_base + R_DATA_FIFO, value);
+}
+
+static inline void datafifo_writel(const AspeedSMCTestData *data,
+                                   uint32_t value)
+{
+    spi_writel(data, R_DATA_FIFO, value);
+}
+
+static inline uint32_t datafifo_readl(const AspeedSMCTestData *data)
+{
+    return spi_readl(data, R_DATA_FIFO);
+}
+
 static void spi_conf(const AspeedSMCTestData *data, uint32_t value)
 {
     uint32_t conf = spi_readl(data, R_CONF);
@@ -826,3 +848,83 @@ void aspeed_smc_test_write_page_qor(const void *data)
 {
     test_write_page(data, read_page_qor);
 }
+
+void aspeed_smc_test_write_page_datafifo(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /*
+     * Send the complete user-mode transaction (opcode, address, data)
+     * through the Data FIFO port.
+     */
+    spi_ctrl_start_user(test_data);
+    datafifo_writeb(test_data, EN_4BYTE_ADDR);
+    datafifo_writeb(test_data, WREN);
+    datafifo_writeb(test_data, PP);
+    datafifo_writel(test_data, make_be32(my_page_addr));
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        datafifo_writel(test_data, make_be32(my_page_addr + i * 4));
+    }
+    spi_ctrl_stop_user(test_data);
+
+    /* Check what was written, using the regular read path */
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
+void aspeed_smc_test_read_page_datafifo(const void *data)
+{
+    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t page[FLASH_PAGE_SIZE / 4];
+    int i;
+
+    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
+
+    /* Write the page the regular way */
+    spi_ctrl_start_user(test_data);
+    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
+    flash_writeb(test_data, 0, WREN);
+    flash_writeb(test_data, 0, PP);
+    flash_writel(test_data, 0, make_be32(my_page_addr));
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
+    }
+    spi_ctrl_stop_user(test_data);
+
+    /*
+     * Read it back through the data FIFO port, again sending the whole
+     * transaction (opcode, address, data) through it.
+     */
+    spi_ctrl_start_user(test_data);
+    datafifo_writeb(test_data, EN_4BYTE_ADDR);
+    datafifo_writeb(test_data, READ);
+    datafifo_writel(test_data, make_be32(my_page_addr));
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(datafifo_readl(test_data));
+    }
+    spi_ctrl_stop_user(test_data);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
+    }
+
+    flash_reset(test_data);
+}
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index f85077e04ff4..925dbcfaaf63 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -64,6 +64,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_page_mem_qor);
     qtest_add_data_func("/ast2700/smc/write_page_qor",
                         data, aspeed_smc_test_write_page_qor);
+    qtest_add_data_func("/ast2700/smc/write_page_datafifo",
+                        data, aspeed_smc_test_write_page_datafifo);
+    qtest_add_data_func("/ast2700/smc/read_page_datafifo",
+                        data, aspeed_smc_test_read_page_datafifo);
 }
 
 int main(int argc, char **argv)
-- 
2.55.0


