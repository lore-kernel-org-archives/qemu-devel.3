Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CE2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTgo-00066H-Nr; Thu, 15 May 2025 04:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTfw-0003PZ-C4; Thu, 15 May 2025 04:10:45 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTfu-00011Y-2m; Thu, 15 May 2025 04:10:43 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 May
 2025 16:10:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 May 2025 16:10:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 10/28] hw/misc/aspeed_hace: Rename R_HASH_DEST to
 R_HASH_DIGEST and introduce 64-bit hash digest address helper
Date: Thu, 15 May 2025 16:09:42 +0800
Message-ID: <20250515081008.583578-11-jamin_lin@aspeedtech.com>
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

Renaming R_HASH_DEST to R_HASH_DIGEST for better semantic clarity.

The AST2700 CPU, based on the Cortex-A35, features a 64-bit DRAM address space.
To prepare for future AST2700 support, this change introduces a new helper
function hash_get_digest_addr() to encapsulate digest address extraction logic
and improve code readability.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_hace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index b3c3af51fa..62649b5b27 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -27,7 +27,7 @@
 #define TAG_IRQ         BIT(15)
 
 #define R_HASH_SRC      (0x20 / 4)
-#define R_HASH_DEST     (0x24 / 4)
+#define R_HASH_DIGEST   (0x24 / 4)
 #define R_HASH_KEY_BUFF (0x28 / 4)
 #define R_HASH_SRC_LEN  (0x2c / 4)
 
@@ -238,17 +238,30 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
     return iov_idx;
 }
 
+static uint64_t hash_get_digest_addr(AspeedHACEState *s)
+{
+    uint64_t digest_addr = 0;
+
+    digest_addr = deposit64(digest_addr, 0, 32, s->regs[R_HASH_DIGEST]);
+
+    return digest_addr;
+}
+
 static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
                                             struct iovec *iov,
                                             int iov_idx,
                                             uint8_t *digest_buf,
                                             size_t digest_len)
 {
-    if (address_space_write(&s->dram_as, s->regs[R_HASH_DEST],
-                            MEMTXATTRS_UNSPECIFIED, digest_buf, digest_len)) {
+    uint64_t digest_addr = 0;
+
+    digest_addr = hash_get_digest_addr(s);
+    if (address_space_write(&s->dram_as, digest_addr,
+                            MEMTXATTRS_UNSPECIFIED,
+                            digest_buf, digest_len)) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Failed to write digest to 0x%x\n",
-                      __func__, s->regs[R_HASH_DEST]);
+                      "%s: Failed to write digest to 0x%" HWADDR_PRIx "\n",
+                      __func__, digest_addr);
     }
 
     for (; iov_idx > 0; iov_idx--) {
@@ -402,7 +415,7 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
     case R_HASH_SRC:
         data &= ahc->src_mask;
         break;
-    case R_HASH_DEST:
+    case R_HASH_DIGEST:
         data &= ahc->dest_mask;
         break;
     case R_HASH_KEY_BUFF:
-- 
2.43.0


