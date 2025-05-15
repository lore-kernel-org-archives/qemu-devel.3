Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFThV-0000ix-Pz; Thu, 15 May 2025 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTfw-0003OA-0D; Thu, 15 May 2025 04:10:44 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTfu-00010V-1H; Thu, 15 May 2025 04:10:43 -0400
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
Subject: [PATCH v3 09/28] hw/misc/aspeed_hace: Introduce 64-bit hash source
 address helper function
Date: Thu, 15 May 2025 16:09:41 +0800
Message-ID: <20250515081008.583578-10-jamin_lin@aspeedtech.com>
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

The AST2700 CPU, based on the Cortex-A35, is a 64-bit processor, and its DRAM
address space is also 64-bit. To support future AST2700 updates, the source
hash buffer address data type is being updated to 64-bit.

Introduces the "hash_get_source_addr()" helper function to extract the source hash
buffer address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_hace.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 33e13974fe..b3c3af51fa 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -142,21 +142,30 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
     return false;
 }
 
+static uint64_t hash_get_source_addr(AspeedHACEState *s)
+{
+    uint64_t src_addr = 0;
+
+    src_addr = deposit64(src_addr, 0, 32, s->regs[R_HASH_SRC]);
+
+    return src_addr;
+}
+
 static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov)
 {
-    uint32_t src;
+    uint64_t src;
     void *haddr;
     hwaddr plen;
     int iov_idx;
 
     plen = s->regs[R_HASH_SRC_LEN];
-    src = s->regs[R_HASH_SRC];
+    src = hash_get_source_addr(s);
     haddr = address_space_map(&s->dram_as, src, &plen, false,
                               MEMTXATTRS_UNSPECIFIED);
     if (haddr == NULL) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Unable to map address, addr=0x%x, "
-                      "plen=0x%" HWADDR_PRIx "\n",
+                      "%s: Unable to map address, addr=0x%" HWADDR_PRIx
+                      " ,plen=0x%" HWADDR_PRIx "\n",
                       __func__, src, plen);
         return -1;
     }
@@ -175,11 +184,12 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
     uint32_t pad_offset;
     uint32_t len = 0;
     uint32_t sg_addr;
-    uint32_t src;
+    uint64_t src;
     int iov_idx;
     hwaddr plen;
     void *haddr;
 
+    src = hash_get_source_addr(s);
     for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
         if (iov_idx == ASPEED_HACE_MAX_SG) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -188,8 +198,6 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
             return -1;
         }
 
-        src = s->regs[R_HASH_SRC] + (iov_idx * SG_LIST_ENTRY_SIZE);
-
         len = address_space_ldl_le(&s->dram_as, src,
                                    MEMTXATTRS_UNSPECIFIED, NULL);
         sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
@@ -208,6 +216,8 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
             return -1;
         }
 
+        src += SG_LIST_ENTRY_SIZE;
+
         iov[iov_idx].iov_base = haddr;
         if (acc_mode) {
             s->total_req_len += plen;
-- 
2.43.0


