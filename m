Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A729BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjDl-0000Zo-Sx; Tue, 13 May 2025 02:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAa-00059v-2e; Tue, 13 May 2025 02:31:22 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAX-00026a-FY; Tue, 13 May 2025 02:31:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 14:29:06 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 13 May 2025 14:29:06 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 11/25] hw/misc/aspeed_hace: Support DMA 64 bits dram address
Date: Tue, 13 May 2025 14:28:41 +0800
Message-ID: <20250513062901.2256865-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
References: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
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

According to the AST2700 design, the data source address is 64-bit, with
R_HASH_SRC_HI storing bits [63:32] and R_HASH_SRC storing bits [31:0].

Similarly, the digest address is 64-bit, with R_HASH_DEST_HI storing bits
[63:32] and R_HASH_DEST storing bits [31:0].

To maintain compatibility with older SoCs such as the AST2600, the AST2700 HW
automatically set bit 34 of the 64-bit sg_addr. As a result, the firmware
only needs to provide a 32-bit sg_addr containing bits [31:0]. This is
sufficient for the AST2700, as it uses a DRAM offset rather than a DRAM
address.

Introduce a has_dma64 class attribute and set it to true for the AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_hace.h |  1 +
 hw/misc/aspeed_hace.c         | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index 9945b61863..d5d07c6c02 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -53,6 +53,7 @@ struct AspeedHACEClass {
     uint32_t src_hi_mask;
     uint32_t dest_hi_mask;
     uint32_t key_hi_mask;
+    bool has_dma64;
 };
 
 #endif /* ASPEED_HACE_H */
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 0fd8a167a2..5454f51aa6 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -147,9 +147,13 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
 
 static uint64_t hash_get_source_addr(AspeedHACEState *s)
 {
+    AspeedHACEClass *ahc = ASPEED_HACE_GET_CLASS(s);
     uint64_t src_addr = 0;
 
     src_addr = deposit64(src_addr, 0, 32, s->regs[R_HASH_SRC]);
+    if (ahc->has_dma64) {
+        src_addr = deposit64(src_addr, 32, 32, s->regs[R_HASH_SRC_HI]);
+    }
 
     return src_addr;
 }
@@ -223,7 +227,13 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
         sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
                                        MEMTXATTRS_UNSPECIFIED, NULL);
         sg_addr &= SG_LIST_ADDR_MASK;
-
+        /*
+         * To maintain compatibility with older SoCs such as the AST2600,
+         * the AST2700 HW automatically set bit 34 of the 64-bit sg_addr.
+         * As a result, the firmware only needs to provide a 32-bit sg_addr
+         * containing bits [31:0]. This is sufficient for the AST2700, as
+         * it uses a DRAM offset rather than a DRAM address.
+         */
         plen = len & SG_LIST_LEN_MASK;
         haddr = address_space_map(&s->dram_as, sg_addr, &plen, false,
                                   MEMTXATTRS_UNSPECIFIED);
@@ -260,9 +270,13 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
 
 static uint64_t hash_get_digest_addr(AspeedHACEState *s)
 {
+    AspeedHACEClass *ahc = ASPEED_HACE_GET_CLASS(s);
     uint64_t digest_addr = 0;
 
     digest_addr = deposit64(digest_addr, 0, 32, s->regs[R_HASH_DIGEST]);
+    if (ahc->has_dma64) {
+        digest_addr = deposit64(digest_addr, 32, 32, s->regs[R_HASH_DIGEST_HI]);
+    }
 
     return digest_addr;
 }
@@ -697,6 +711,7 @@ static void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void *data)
      * has completed. It is a temporary workaround.
      */
     ahc->raise_crypt_interrupt_workaround = true;
+    ahc->has_dma64 = true;
 }
 
 static const TypeInfo aspeed_ast2700_hace_info = {
-- 
2.43.0


