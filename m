Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAEED1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BOz-0003Rv-4G; Tue, 22 Oct 2024 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BOw-0003Ph-KI; Tue, 22 Oct 2024 05:42:06 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BOu-00019W-UW; Tue, 22 Oct 2024 05:42:06 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 22 Oct
 2024 17:41:15 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 22 Oct 2024 17:41:15 +0800
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
Subject: [PATCH v2 12/18] test/qtest/aspeed_smc-test: Introducing a
 "page_addr" data field
Date: Tue, 22 Oct 2024 17:41:04 +0800
Message-ID: <20241022094110.1574011-13-jamin_lin@aspeedtech.com>
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

Currently, these test cases used the hardcode offset 0x1400000 (0x14000 * 256)
which was beyond the 16MB flash size for flash page read/write command testing.
However, the default fmc flash model of ast1030-a1 EVB is "w25q80bl" whose size
is 1MB. To test all flash models, introduces a new page_addr member in TestData
structure, so users can set the offset for flash parge read/write command
testing.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed_smc-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index b8ab20b43d..6db18451d2 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -72,6 +72,7 @@ typedef struct TestData {
     char *tmp_path;
     uint8_t cs;
     const char *node;
+    uint32_t page_addr;
 } TestData;
 
 /*
@@ -256,7 +257,7 @@ static void assert_page_mem(const TestData *data, uint32_t addr,
 static void test_erase_sector(const void *data)
 {
     const TestData *test_data = (const TestData *)data;
-    uint32_t some_page_addr = 0x600 * FLASH_PAGE_SIZE;
+    uint32_t some_page_addr = test_data->page_addr;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
@@ -308,7 +309,7 @@ static void test_erase_sector(const void *data)
 static void test_erase_all(const void *data)
 {
     const TestData *test_data = (const TestData *)data;
-    uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
+    uint32_t some_page_addr = test_data->page_addr;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
@@ -358,8 +359,8 @@ static void test_erase_all(const void *data)
 static void test_write_page(const void *data)
 {
     const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = 0x14000 * FLASH_PAGE_SIZE; /* beyond 16MB */
-    uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
@@ -395,8 +396,8 @@ static void test_write_page(const void *data)
 static void test_read_page_mem(const void *data)
 {
     const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = 0x14000 * FLASH_PAGE_SIZE; /* beyond 16MB */
-    uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
+    uint32_t my_page_addr = test_data->page_addr;
+    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
@@ -438,7 +439,7 @@ static void test_read_page_mem(const void *data)
 static void test_write_page_mem(const void *data)
 {
     const TestData *test_data = (const TestData *)data;
-    uint32_t my_page_addr = 0x15000 * FLASH_PAGE_SIZE;
+    uint32_t my_page_addr = test_data->page_addr;
     uint32_t page[FLASH_PAGE_SIZE / 4];
     int i;
 
@@ -679,6 +680,8 @@ static void test_palmetto_bmc(TestData *data)
     data->jedec_id = 0x20ba19;
     data->cs = 0;
     data->node = "/machine/soc/fmc/ssi.0/child[0]";
+    /* beyond 16MB */
+    data->page_addr = 0x14000 * FLASH_PAGE_SIZE;
 
     qtest_add_data_func("/ast2400/smc/read_jedec", data, test_read_jedec);
     qtest_add_data_func("/ast2400/smc/erase_sector", data, test_erase_sector);
-- 
2.34.1


