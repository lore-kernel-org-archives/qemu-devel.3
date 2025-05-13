Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7897C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjEI-0002U5-06; Tue, 13 May 2025 02:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjBy-0006J6-FN; Tue, 13 May 2025 02:32:48 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjBu-00029w-55; Tue, 13 May 2025 02:32:42 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 14:29:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 13 May 2025 14:29:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 24/25] test/qtest/hace: Support to validate 64-bit hmac key
 buffer addresses
Date: Tue, 13 May 2025 14:28:54 +0800
Message-ID: <20250513062901.2256865-25-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
References: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Added "key" and "key_hi" fields to "AspeedMasks" for 64-bit addresses test.
Updated "aspeed_test_addresses" to validate "HACE_HASH_KEY_BUFF" and
"HACE_HASH_KEY_BUFF_HI".
Ensured correct masking of 64-bit addresses by checking both lower and upper
32-bit registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-hace-utils.h |  2 ++
 tests/qtest/aspeed-hace-utils.c | 14 ++++++++++++++
 tests/qtest/aspeed_hace-test.c  |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index de8055a1db..c8b2ec45af 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -50,9 +50,11 @@ struct AspeedSgList {
 struct AspeedMasks {
     uint32_t src;
     uint32_t dest;
+    uint32_t key;
     uint32_t len;
     uint32_t src_hi;
     uint32_t dest_hi;
+    uint32_t key_hi;
 };
 
 void aspeed_test_md5(const char *machine, const uint32_t base,
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index cb78f18117..0f7f911e5e 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -591,6 +591,8 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST_HI), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_KEY_BUFF), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_KEY_BUFF_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
 
     /* Check that the address masking is correct */
@@ -609,6 +611,14 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST_HI), ==,
                     expected->dest_hi);
 
+    qtest_writel(s, base + HACE_HASH_KEY_BUFF, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_KEY_BUFF), ==,
+                    expected->key);
+
+    qtest_writel(s, base + HACE_HASH_KEY_BUFF_HI, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_KEY_BUFF_HI), ==,
+                    expected->key_hi);
+
     qtest_writel(s, base + HACE_HASH_DATA_LEN, 0xffffffff);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==,
                     expected->len);
@@ -618,6 +628,8 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
     qtest_writel(s, base + HACE_HASH_SRC_HI, 0);
     qtest_writel(s, base + HACE_HASH_DIGEST, 0);
     qtest_writel(s, base + HACE_HASH_DIGEST_HI, 0);
+    qtest_writel(s, base + HACE_HASH_KEY_BUFF, 0);
+    qtest_writel(s, base + HACE_HASH_KEY_BUFF_HI, 0);
     qtest_writel(s, base + HACE_HASH_DATA_LEN, 0);
 
     /* Check that all bits are now zero */
@@ -625,6 +637,8 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST_HI), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_KEY_BUFF), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_KEY_BUFF_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
 
     qtest_quit(s);
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.c
index 31890d574e..38777020ca 100644
--- a/tests/qtest/aspeed_hace-test.c
+++ b/tests/qtest/aspeed_hace-test.c
@@ -13,24 +13,28 @@
 static const struct AspeedMasks ast1030_masks = {
     .src  = 0x7fffffff,
     .dest = 0x7ffffff8,
+    .key = 0x7ffffff8,
     .len  = 0x0fffffff,
 };
 
 static const struct AspeedMasks ast2600_masks = {
     .src  = 0x7fffffff,
     .dest = 0x7ffffff8,
+    .key = 0x7ffffff8,
     .len  = 0x0fffffff,
 };
 
 static const struct AspeedMasks ast2500_masks = {
     .src  = 0x3fffffff,
     .dest = 0x3ffffff8,
+    .key = 0x3fffffc0,
     .len  = 0x0fffffff,
 };
 
 static const struct AspeedMasks ast2400_masks = {
     .src  = 0x0fffffff,
     .dest = 0x0ffffff8,
+    .key = 0x0fffffc0,
     .len  = 0x0fffffff,
 };
 
-- 
2.43.0


