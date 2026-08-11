Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D65CC5CFEB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNJ-0008QS-10; Tue, 11 Aug 2026 12:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMy-0007vK-WD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMt-0000VF-Ma
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnjUDvgbC4ATzjpBKASJrupTRFb2JoxoNyILPnN5f68=;
 b=G6tnls2VpQresncmxEYxw9War/ge1aei90o05ZQu3gN/ijCJBOd0927gNrG/fnQRCatN+w
 wKG6NAAqHHQeDnpklrkMVe64jnZXgIzmmmW9WgKYwMg5wgdo2G+pi+K/HOhs7sGEboAQ5a
 0rgASFlYbPv9aVLRtzq1JkpC2oKOs3I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-JkE3beuRMXuLBR-7z8vJJg-1; Tue,
 11 Aug 2026 12:30:15 -0400
X-MC-Unique: JkE3beuRMXuLBR-7z8vJJg-1
X-Mimecast-MFC-AGG-ID: JkE3beuRMXuLBR-7z8vJJg_1786465814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F6841800984; Tue, 11 Aug 2026 16:30:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FE44195DF98; Tue, 11 Aug 2026 16:30:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bin.meng@processmission.com>
Subject: [PULL 14/83] tests/qtest: aspeed_smc: Introduce read_page_mem_fn for
 page read helpers
Date: Tue, 11 Aug 2026 18:28:29 +0200
Message-ID: <20260811162938.1403216-15-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This to prepare for fast-read variants. No functional change.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Link: https://lore.kernel.org/qemu-devel/20260714124621.522948-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index c27d09e767e5..ed125741eb36 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -186,6 +186,9 @@ static void read_page_mem(const AspeedSMCTestData *data, uint32_t addr,
     }
 }
 
+typedef void (*read_page_mem_fn)(const AspeedSMCTestData *data,
+                                 uint32_t addr, uint32_t *page);
+
 static void write_page_mem(const AspeedSMCTestData *data, uint32_t addr,
                            uint32_t write_value)
 {
@@ -327,9 +330,9 @@ void aspeed_smc_test_erase_all(const void *data)
     flash_reset(test_data);
 }
 
-void aspeed_smc_test_write_page(const void *data)
+static void test_write_page(const AspeedSMCTestData *test_data,
+                            read_page_mem_fn reader)
 {
-    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
     uint32_t my_page_addr = test_data->page_addr;
     uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
@@ -350,13 +353,13 @@ void aspeed_smc_test_write_page(const void *data)
     spi_ctrl_stop_user(test_data);
 
     /* Check what was written */
-    read_page(test_data, my_page_addr, page);
+    reader(test_data, my_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
     }
 
     /* Check some other page. It should be full of 0xff */
-    read_page(test_data, some_page_addr, page);
+    reader(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
@@ -364,9 +367,14 @@ void aspeed_smc_test_write_page(const void *data)
     flash_reset(test_data);
 }
 
-void aspeed_smc_test_read_page_mem(const void *data)
+void aspeed_smc_test_write_page(const void *data)
+{
+    test_write_page(data, read_page);
+}
+
+static void test_read_page_mem(const AspeedSMCTestData *test_data,
+                               read_page_mem_fn reader)
 {
-    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
     uint32_t my_page_addr = test_data->page_addr;
     uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
@@ -393,13 +401,13 @@ void aspeed_smc_test_read_page_mem(const void *data)
     spi_conf_remove(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
 
     /* Check what was written */
-    read_page_mem(test_data, my_page_addr, page);
+    reader(test_data, my_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
     }
 
     /* Check some other page. It should be full of 0xff */
-    read_page_mem(test_data, some_page_addr, page);
+    reader(test_data, some_page_addr, page);
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
         g_assert_cmphex(page[i], ==, 0xffffffff);
     }
@@ -407,6 +415,11 @@ void aspeed_smc_test_read_page_mem(const void *data)
     flash_reset(test_data);
 }
 
+void aspeed_smc_test_read_page_mem(const void *data)
+{
+    test_read_page_mem(data, read_page_mem);
+}
+
 void aspeed_smc_test_write_page_mem(const void *data)
 {
     const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
-- 
2.55.0


