Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC14C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjCW-0006kW-Fw; Tue, 13 May 2025 02:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAe-0005Fn-0F; Tue, 13 May 2025 02:31:23 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAb-00026a-73; Tue, 13 May 2025 02:31:18 -0400
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
Subject: [PATCH v2 12/25] hw/misc/aspeed_hace: Add trace-events for better
 debugging
Date: Tue, 13 May 2025 14:28:42 +0800
Message-ID: <20250513062901.2256865-13-jamin_lin@aspeedtech.com>
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

Introduced "trace_aspeed_hace_hash_addr", "trace_aspeed_hace_hash_sg",
"trace_aspeed_hace_read", "trace_aspeed_hace_hash_execute_acc_mode",
and "trace_aspeed_hace_write" trace events.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_hace.c | 11 +++++++++++
 hw/misc/trace-events  |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 5454f51aa6..1ffec029dc 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -18,6 +18,7 @@
 #include "crypto/hash.h"
 #include "hw/qdev-properties.h"
 #include "hw/irq.h"
+#include "trace.h"
 
 #define R_CRYPT_CMD     (0x10 / 4)
 
@@ -170,6 +171,7 @@ static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov,
 
     plen = s->regs[R_HASH_SRC_LEN];
     src = hash_get_source_addr(s);
+    trace_aspeed_hace_hash_addr("src", src);
     haddr = address_space_map(&s->dram_as, src, &plen, false,
                               MEMTXATTRS_UNSPECIFIED);
     if (haddr == NULL) {
@@ -214,6 +216,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
     void *haddr;
 
     src = hash_get_source_addr(s);
+    trace_aspeed_hace_hash_addr("src", src);
     for (iov_idx = 0; !(len & SG_LIST_LEN_LAST); iov_idx++) {
         if (iov_idx == ASPEED_HACE_MAX_SG) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -227,6 +230,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
         sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
                                        MEMTXATTRS_UNSPECIFIED, NULL);
         sg_addr &= SG_LIST_ADDR_MASK;
+        trace_aspeed_hace_hash_sg(iov_idx, sg_addr, len);
         /*
          * To maintain compatibility with older SoCs such as the AST2600,
          * the AST2700 HW automatically set bit 34 of the 64-bit sg_addr.
@@ -290,6 +294,7 @@ static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
     uint64_t digest_addr = 0;
 
     digest_addr = hash_get_digest_addr(s);
+    trace_aspeed_hace_hash_addr("digest", digest_addr);
     if (address_space_write(&s->dram_as, digest_addr,
                             MEMTXATTRS_UNSPECIFIED,
                             digest_buf, digest_len)) {
@@ -332,6 +337,8 @@ static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
     Error *local_err = NULL;
     size_t digest_len;
 
+    trace_aspeed_hace_hash_execute_acc_mode(final_request);
+
     if (s->hash_ctx == NULL) {
         s->hash_ctx = qcrypto_hash_new(algo, &local_err);
         if (s->hash_ctx == NULL) {
@@ -403,6 +410,8 @@ static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int size)
 
     addr >>= 2;
 
+    trace_aspeed_hace_read(addr << 2, s->regs[addr]);
+
     return s->regs[addr];
 }
 
@@ -414,6 +423,8 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
 
     addr >>= 2;
 
+    trace_aspeed_hace_write(addr << 2, data);
+
     switch (addr) {
     case R_STATUS:
         if (data & HASH_IRQ) {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4383808d7a..b2587c37d7 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -302,6 +302,13 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%"
 aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRIx32 " status 0x%" PRIx32
 
+# aspeed_hace.c
+aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_hace_hash_sg(int index, uint64_t addr, uint32_t len) "%d: addr 0x%" PRIx64 " len 0x%" PRIx32
+aspeed_hace_hash_addr(const char *s, uint64_t addr) "%s: 0x%" PRIx64
+aspeed_hace_hash_execute_acc_mode(bool final_request) "final request: %d"
+
 # bcm2835_property.c
 bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
 
-- 
2.43.0


