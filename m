Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCE6C44506
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQGB-0007Vl-Ks; Wed, 08 Jul 2026 07:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQG8-0007UL-6w
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQG5-0003Gg-UH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783509365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PMtoFzLpOb0RAicG7IQcOYmtK8BR4cP7TwKFW9WKKM=;
 b=ZzPrjOhcww1mgvgvV6X8IBQ8XCf2ZJrOM0V8rnRf5PJq4Mia/d2ikZK7+1UQgNaH68BXeE
 2Se9TjmWs811wGB9vT4pi+YyaFMy123+6IPn2s8F5pNftkOH+swdP1fRvbGrLmJWPZC2w9
 oUWpFuTUIVBeDB6M6K+USjeccatZEwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-eGnN9TiuMAiy-fYq_FfUhg-1; Wed,
 08 Jul 2026 07:16:01 -0400
X-MC-Unique: eGnN9TiuMAiy-fYq_FfUhg-1
X-Mimecast-MFC-AGG-ID: eGnN9TiuMAiy-fYq_FfUhg_1783509360
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDFE4195606C; Wed,  8 Jul 2026 11:15:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB7AF1955F7B; Wed,  8 Jul 2026 11:15:53 +0000 (UTC)
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
Subject: [PATCH 1/4] tests/qtest: aspeed_smc: Introduce read_page_mem_fn for
 page read helpers
Date: Wed,  8 Jul 2026 13:15:41 +0200
Message-ID: <20260708111544.1440761-2-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-1-clg@redhat.com>
References: <20260708111544.1440761-1-clg@redhat.com>
MIME-Version: 1.0
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

This to prepare for fast-read variants. No functional change.

Signed-off-by: Cedric Le Goater <clg@redhat.com>
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
2.54.0


