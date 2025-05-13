Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70889C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjEM-00030z-Mn; Tue, 13 May 2025 02:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjBJ-0005gq-9o; Tue, 13 May 2025 02:32:04 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjBH-00029w-CG; Tue, 13 May 2025 02:32:00 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 14:29:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 13 May 2025 14:29:09 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 20/25] test/qtest/hace: Add tests for AST1030
Date: Tue, 13 May 2025 14:28:50 +0800
Message-ID: <20250513062901.2256865-21-jamin_lin@aspeedtech.com>
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

The HACE model in AST2600 and AST1030 is identical. Referencing the AST2600
test cases, new tests have been created for AST1030.

Implemented test functions for SHA-256, SHA-384, SHA-512, and MD5.
Added scatter-gather and accumulation test variants.
For AST1030, the HACE controller base address starts at "0x7e6d0000", and the
SDRAM start address is "0x0".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed_hace-test.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.c
index ab0c98330e..31890d574e 100644
--- a/tests/qtest/aspeed_hace-test.c
+++ b/tests/qtest/aspeed_hace-test.c
@@ -10,6 +10,12 @@
 #include "qemu/bitops.h"
 #include "aspeed-hace-utils.h"
 
+static const struct AspeedMasks ast1030_masks = {
+    .src  = 0x7fffffff,
+    .dest = 0x7ffffff8,
+    .len  = 0x0fffffff,
+};
+
 static const struct AspeedMasks ast2600_masks = {
     .src  = 0x7fffffff,
     .dest = 0x7ffffff8,
@@ -28,6 +34,62 @@ static const struct AspeedMasks ast2400_masks = {
     .len  = 0x0fffffff,
 };
 
+/* ast1030 */
+static void test_md5_ast1030(void)
+{
+    aspeed_test_md5("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha256_ast1030(void)
+{
+    aspeed_test_sha256("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha256_sg_ast1030(void)
+{
+    aspeed_test_sha256_sg("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha384_ast1030(void)
+{
+    aspeed_test_sha384("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha384_sg_ast1030(void)
+{
+    aspeed_test_sha384_sg("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha512_ast1030(void)
+{
+    aspeed_test_sha512("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha512_sg_ast1030(void)
+{
+    aspeed_test_sha512_sg("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha256_accum_ast1030(void)
+{
+    aspeed_test_sha256_accum("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha384_accum_ast1030(void)
+{
+    aspeed_test_sha384_accum("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_sha512_accum_ast1030(void)
+{
+    aspeed_test_sha512_accum("-machine ast1030-evb", 0x7e6d0000, 0x00000000);
+}
+
+static void test_addresses_ast1030(void)
+{
+    aspeed_test_addresses("-machine ast1030-evb", 0x7e6d0000, &ast1030_masks);
+}
+
 /* ast2600 */
 static void test_md5_ast2600(void)
 {
@@ -130,6 +192,20 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    qtest_add_func("ast1030/hace/addresses", test_addresses_ast1030);
+    qtest_add_func("ast1030/hace/sha512", test_sha512_ast1030);
+    qtest_add_func("ast1030/hace/sha384", test_sha384_ast1030);
+    qtest_add_func("ast1030/hace/sha256", test_sha256_ast1030);
+    qtest_add_func("ast1030/hace/md5", test_md5_ast1030);
+
+    qtest_add_func("ast1030/hace/sha512_sg", test_sha512_sg_ast1030);
+    qtest_add_func("ast1030/hace/sha384_sg", test_sha384_sg_ast1030);
+    qtest_add_func("ast1030/hace/sha256_sg", test_sha256_sg_ast1030);
+
+    qtest_add_func("ast1030/hace/sha512_accum", test_sha512_accum_ast1030);
+    qtest_add_func("ast1030/hace/sha384_accum", test_sha384_accum_ast1030);
+    qtest_add_func("ast1030/hace/sha256_accum", test_sha256_accum_ast1030);
+
     qtest_add_func("ast2600/hace/addresses", test_addresses_ast2600);
     qtest_add_func("ast2600/hace/sha512", test_sha512_ast2600);
     qtest_add_func("ast2600/hace/sha384", test_sha384_ast2600);
-- 
2.43.0


