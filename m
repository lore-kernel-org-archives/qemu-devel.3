Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CBBC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTiu-0008S8-Ci; Thu, 15 May 2025 04:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFThI-0008D8-Dn; Thu, 15 May 2025 04:12:09 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFThF-00018W-7E; Thu, 15 May 2025 04:12:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 May
 2025 16:10:15 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 May 2025 16:10:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 21/28] test/qtest/hace: Add SHA-384 test cases for ASPEED
 HACE model
Date: Thu, 15 May 2025 16:09:53 +0800
Message-ID: <20250515081008.583578-22-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
References: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
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

Introduced SHA-384 test functions to verify hashing operations.
Extended support for scatter-gather ("_sg") and accumulation ("_accum") tests.
Updated test result vectors for SHA-384 validation.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed-hace-utils.h |   6 ++
 tests/qtest/aspeed-hace-utils.c | 168 +++++++++++++++++++++++++++++++-
 2 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index 598577c69b..f4440561de 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -54,14 +54,20 @@ void aspeed_test_md5(const char *machine, const uint32_t base,
                      const uint32_t src_addr);
 void aspeed_test_sha256(const char *machine, const uint32_t base,
                         const uint32_t src_addr);
+void aspeed_test_sha384(const char *machine, const uint32_t base,
+                        const uint32_t src_addr);
 void aspeed_test_sha512(const char *machine, const uint32_t base,
                         const uint32_t src_addr);
 void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
                            const uint32_t src_addr);
+void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
+                           const uint32_t src_addr);
 void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
                            const uint32_t src_addr);
 void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
                               const uint32_t src_addr);
+void aspeed_test_sha384_accum(const char *machine, const uint32_t base,
+                              const uint32_t src_addr);
 void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
                               const uint32_t src_addr);
 void aspeed_test_addresses(const char *machine, const uint32_t base,
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 539d06e4f8..dad90ee81c 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -16,7 +16,7 @@
  * Expected results were generated using command line utitiles:
  *
  *  echo -n -e 'abc' | dd of=/tmp/test
- *  for hash in sha512sum sha256sum md5sum; do $hash /tmp/test; done
+ *  for hash in sha512sum sha384sum sha256sum md5sum; do $hash /tmp/test; done
  *
  */
 static const uint8_t test_vector[3] = {0x61, 0x62, 0x63};
@@ -29,6 +29,12 @@ static const uint8_t test_result_sha512[64] = {
     0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a, 0xc9, 0x4f,
     0xa5, 0x4c, 0xa4, 0x9f};
 
+static const uint8_t test_result_sha384[48] = {
+    0xcb, 0x00, 0x75, 0x3f, 0x45, 0xa3, 0x5e, 0x8b, 0xb5, 0xa0, 0x3d, 0x69,
+    0x9a, 0xc6, 0x50, 0x07, 0x27, 0x2c, 0x32, 0xab, 0x0e, 0xde, 0xd1, 0x63,
+    0x1a, 0x8b, 0x60, 0x5a, 0x43, 0xff, 0x5b, 0xed, 0x80, 0x86, 0x07, 0x2b,
+    0xa1, 0xe7, 0xcc, 0x23, 0x58, 0xba, 0xec, 0xa1, 0x34, 0xc8, 0x25, 0xa7};
+
 static const uint8_t test_result_sha256[32] = {
     0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41, 0x40, 0xde,
     0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
@@ -45,7 +51,7 @@ static const uint8_t test_result_md5[16] = {
  * Expected results were generated using command line utitiles:
  *
  *  echo -n -e 'abcdefghijkl' | dd of=/tmp/test
- *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
+ *  for hash in sha512sum sha384sum sha256sum; do $hash /tmp/test; done
  *
  */
 static const uint8_t test_vector_sg1[6] = {0x61, 0x62, 0x63, 0x64, 0x65, 0x66};
@@ -60,6 +66,12 @@ static const uint8_t test_result_sg_sha512[64] = {
     0x84, 0x25, 0x7c, 0x32, 0xc8, 0xf6, 0xd0, 0x85, 0x4a, 0xe6, 0xb5, 0x40,
     0xf8, 0x6d, 0xda, 0x2e};
 
+static const uint8_t test_result_sg_sha384[48] = {
+    0x10, 0x3c, 0xa9, 0x6c, 0x06, 0xa1, 0xce, 0x79, 0x8f, 0x08, 0xf8, 0xef,
+    0xf0, 0xdf, 0xb0, 0xcc, 0xdb, 0x56, 0x7d, 0x48, 0xb2, 0x85, 0xb2, 0x3d,
+    0x0c, 0xd7, 0x73, 0x45, 0x46, 0x67, 0xa3, 0xc2, 0xfa, 0x5f, 0x1b, 0x58,
+    0xd9, 0xcd, 0xf2, 0x32, 0x9b, 0xd9, 0x97, 0x97, 0x30, 0xbf, 0xaa, 0xff};
+
 static const uint8_t test_result_sg_sha256[32] = {
     0xd6, 0x82, 0xed, 0x4c, 0xa4, 0xd9, 0x89, 0xc1, 0x34, 0xec, 0x94, 0xf1,
     0x55, 0x1e, 0x1e, 0xc5, 0x80, 0xdd, 0x6d, 0x5a, 0x6e, 0xcd, 0xe9, 0xf3,
@@ -74,7 +86,7 @@ static const uint8_t test_result_sg_sha256[32] = {
  * Expected results were generated using command line utitiles:
  *
  *  echo -n -e 'abc' | dd of=/tmp/test
- *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
+ *  for hash in sha512sum sha384sum sha256sum; do $hash /tmp/test; done
  */
 static const uint8_t test_vector_accum_512[128] = {
     0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
@@ -94,6 +106,24 @@ static const uint8_t test_vector_accum_512[128] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
 
+static const uint8_t test_vector_accum_384[128] = {
+    0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
+
 static const uint8_t test_vector_accum_256[64] = {
     0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -112,6 +142,12 @@ static const uint8_t test_result_accum_sha512[64] = {
     0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a, 0xc9, 0x4f,
     0xa5, 0x4c, 0xa4, 0x9f};
 
+static const uint8_t test_result_accum_sha384[48] = {
+    0xcb, 0x00, 0x75, 0x3f, 0x45, 0xa3, 0x5e, 0x8b, 0xb5, 0xa0, 0x3d, 0x69,
+    0x9a, 0xc6, 0x50, 0x07, 0x27, 0x2c, 0x32, 0xab, 0x0e, 0xde, 0xd1, 0x63,
+    0x1a, 0x8b, 0x60, 0x5a, 0x43, 0xff, 0x5b, 0xed, 0x80, 0x86, 0x07, 0x2b,
+    0xa1, 0xe7, 0xcc, 0x23, 0x58, 0xba, 0xec, 0xa1, 0x34, 0xc8, 0x25, 0xa7};
+
 static const uint8_t test_result_accum_sha256[32] = {
     0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41, 0x40, 0xde,
     0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
@@ -195,6 +231,40 @@ void aspeed_test_sha256(const char *machine, const uint32_t base,
     qtest_quit(s);
 }
 
+void aspeed_test_sha384(const char *machine, const uint32_t base,
+                        const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t digest_addr = src_addr + 0x10000;
+    uint8_t digest[48] = {0};
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
+
+    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr,
+               HACE_ALGO_SHA384);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_sha384, sizeof(digest));
+
+    qtest_quit(s);
+}
+
 void aspeed_test_sha512(const char *machine, const uint32_t base,
                         const uint32_t src_addr)
 {
@@ -280,6 +350,57 @@ void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
     qtest_quit(s);
 }
 
+void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
+                           const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t src_addr_1 = src_addr + 0x10000;
+    const uint32_t src_addr_2 = src_addr + 0x20000;
+    const uint32_t src_addr_3 = src_addr + 0x30000;
+    const uint32_t digest_addr = src_addr + 0x40000;
+    uint8_t digest[48] = {0};
+    struct AspeedSgList array[] = {
+        {  cpu_to_le32(sizeof(test_vector_sg1)),
+           cpu_to_le32(src_addr_1) },
+        {  cpu_to_le32(sizeof(test_vector_sg2)),
+           cpu_to_le32(src_addr_2) },
+        {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
+           cpu_to_le32(src_addr_3) },
+    };
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr_1, test_vector_sg1, sizeof(test_vector_sg1));
+    qtest_memwrite(s, src_addr_2, test_vector_sg2, sizeof(test_vector_sg2));
+    qtest_memwrite(s, src_addr_3, test_vector_sg3, sizeof(test_vector_sg3));
+    qtest_memwrite(s, src_addr, array, sizeof(array));
+
+    write_regs(s, base, src_addr,
+               (sizeof(test_vector_sg1)
+                + sizeof(test_vector_sg2)
+                + sizeof(test_vector_sg3)),
+               digest_addr, HACE_ALGO_SHA384 | HACE_SG_EN);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_sg_sha384, sizeof(digest));
+
+    qtest_quit(s);
+}
+
 void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
                            const uint32_t src_addr)
 {
@@ -372,6 +493,47 @@ void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
     qtest_quit(s);
 }
 
+void aspeed_test_sha384_accum(const char *machine, const uint32_t base,
+                              const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t buffer_addr = src_addr + 0x10000;
+    const uint32_t digest_addr = src_addr + 0x40000;
+    uint8_t digest[48] = {0};
+    struct AspeedSgList array[] = {
+        {  cpu_to_le32(sizeof(test_vector_accum_384) | SG_LIST_LEN_LAST),
+           cpu_to_le32(buffer_addr) },
+    };
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, buffer_addr, test_vector_accum_384,
+                   sizeof(test_vector_accum_384));
+    qtest_memwrite(s, src_addr, array, sizeof(array));
+
+    write_regs(s, base, src_addr, sizeof(test_vector_accum_384),
+               digest_addr, HACE_ALGO_SHA384 | HACE_SG_EN | HACE_ACCUM_EN);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_accum_sha384, sizeof(digest));
+
+    qtest_quit(s);
+}
+
 void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
                               const uint32_t src_addr)
 {
-- 
2.43.0


