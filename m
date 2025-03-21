Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B59C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYfM-0007dS-8n; Fri, 21 Mar 2025 05:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYf4-0007CH-Ne; Fri, 21 Mar 2025 05:27:31 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYf2-0005EC-UJ; Fri, 21 Mar 2025 05:27:30 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 21 Mar
 2025 17:26:28 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 21 Mar 2025 17:26:28 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 14/22] test/qtest/hace: Adjust test address range for
 AST1030 due to SRAM limitations
Date: Fri, 21 Mar 2025 17:26:10 +0800
Message-ID: <20250321092623.2097234-15-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
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

The digest_addr is set to "src_addr + 0x1000000", where src_addr is the DRAM
base address. However, the value 0x1000000 (16MB) is too large because the
AST1030 does not support DRAM, and its SRAM size is only 768KB.

A range size of 0x1000 (64KB) is sufficient for HACE test cases, as the test
vector size does not exceed 64KB.

Updates:
1. Direct Access Mode
Update digest_addr to "src_addr + 0x1000" in the following functions:
aspeed_test_md5
aspeed_test_sha256
aspeed_test_sha512

2. Scatter-Gather (SG) Mode
Update source address for different SG buffer addresses in the following
functions:
src_addr1 = src_addr + 0x1000
src_addr2 = src_addr + 0x2000
src_addr3 = src_addr + 0x3000
digest_addr = src_addr + 0x4000

aspeed_test_sha256_sg
aspeed_test_sha512_sg

3. ACC Mode Update
Update the SG List start address: src_addr + 0x10000
Update the SG List buffer size to 0x3000 (192KB).

buffer_addr = src_addr + 0x10000
digest_addr = src_addr + 0x40000

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed-hace-utils.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 8582847945..8fbbba49c1 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -132,7 +132,7 @@ void aspeed_test_md5(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    uint32_t digest_addr = src_addr + 0x01000000;
+    uint32_t digest_addr = src_addr + 0x010000;
     uint8_t digest[16] = {0};
 
     /* Check engine is idle, no busy or irq bits set */
@@ -166,7 +166,7 @@ void aspeed_test_sha256(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    const uint32_t digest_addr = src_addr + 0x1000000;
+    const uint32_t digest_addr = src_addr + 0x10000;
     uint8_t digest[32] = {0};
 
     /* Check engine is idle, no busy or irq bits set */
@@ -200,7 +200,7 @@ void aspeed_test_sha512(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    const uint32_t digest_addr = src_addr + 0x1000000;
+    const uint32_t digest_addr = src_addr + 0x10000;
     uint8_t digest[64] = {0};
 
     /* Check engine is idle, no busy or irq bits set */
@@ -234,10 +234,10 @@ void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    const uint32_t src_addr_1 = src_addr + 0x1000000;
-    const uint32_t src_addr_2 = src_addr + 0x2000000;
-    const uint32_t src_addr_3 = src_addr + 0x3000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
+    const uint32_t src_addr_1 = src_addr + 0x10000;
+    const uint32_t src_addr_2 = src_addr + 0x20000;
+    const uint32_t src_addr_3 = src_addr + 0x30000;
+    const uint32_t digest_addr = src_addr + 0x40000;
     uint8_t digest[32] = {0};
     struct AspeedSgList array[] = {
         {  cpu_to_le32(sizeof(test_vector_sg1)),
@@ -285,10 +285,10 @@ void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    const uint32_t src_addr_1 = src_addr + 0x1000000;
-    const uint32_t src_addr_2 = src_addr + 0x2000000;
-    const uint32_t src_addr_3 = src_addr + 0x3000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
+    const uint32_t src_addr_1 = src_addr + 0x10000;
+    const uint32_t src_addr_2 = src_addr + 0x20000;
+    const uint32_t src_addr_3 = src_addr + 0x30000;
+    const uint32_t digest_addr = src_addr + 0x40000;
     uint8_t digest[64] = {0};
     struct AspeedSgList array[] = {
         {  cpu_to_le32(sizeof(test_vector_sg1)),
@@ -336,8 +336,8 @@ void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    const uint32_t buffer_addr = src_addr + 0x1000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
+    const uint32_t buffer_addr = src_addr + 0x10000;
+    const uint32_t digest_addr = src_addr + 0x40000;
     uint8_t digest[32] = {0};
     struct AspeedSgList array[] = {
         {  cpu_to_le32(sizeof(test_vector_accum_256) | SG_LIST_LEN_LAST),
@@ -377,8 +377,8 @@ void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
 {
     QTestState *s = qtest_init(machine);
 
-    const uint32_t buffer_addr = src_addr + 0x1000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
+    const uint32_t buffer_addr = src_addr + 0x10000;
+    const uint32_t digest_addr = src_addr + 0x40000;
     uint8_t digest[64] = {0};
     struct AspeedSgList array[] = {
         {  cpu_to_le32(sizeof(test_vector_accum_512) | SG_LIST_LEN_LAST),
-- 
2.43.0


