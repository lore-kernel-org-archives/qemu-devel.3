Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9BEC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYf2-00075E-DQ; Fri, 21 Mar 2025 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYet-0006pm-QY; Fri, 21 Mar 2025 05:27:22 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYep-00056F-UI; Fri, 21 Mar 2025 05:27:19 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 21 Mar
 2025 17:26:27 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 21 Mar 2025 17:26:27 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/22] hw/misc/aspeed_hace: Add trace-events for better
 debugging
Date: Fri, 21 Mar 2025 17:26:07 +0800
Message-ID: <20250321092623.2097234-12-jamin_lin@aspeedtech.com>
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

Introduced "trace_aspeed_hace_addr", "trace_aspeed_hace_sg",
"trace_aspeed_hace_read", and "trace_aspeed_hace_write" trace events.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_hace.c | 8 ++++++++
 hw/misc/trace-events  | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 53b3b390e3..b8e473ee3f 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -18,6 +18,7 @@
 #include "crypto/hash.h"
 #include "hw/qdev-properties.h"
 #include "hw/irq.h"
+#include "trace.h"
 
 #define R_CRYPT_CMD     (0x10 / 4)
 
@@ -186,6 +187,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             if (ahc->has_dma64) {
                 src = deposit64(src, 32, 32, s->regs[R_HASH_SRC_HI]);
             }
+            trace_aspeed_hace_addr("src", src);
             src += i * SG_LIST_ENTRY_SIZE;
 
             len = address_space_ldl_le(&s->dram_as, src,
@@ -194,6 +196,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             sg_addr = address_space_ldl_le(&s->dram_as, src + SG_LIST_LEN_SIZE,
                                            MEMTXATTRS_UNSPECIFIED, NULL);
             sg_addr &= SG_LIST_ADDR_MASK;
+            trace_aspeed_hace_sg(i, sg_addr, len);
             /*
              * Ideally, sg_addr should be 64-bit for the AST2700, using the
              * following program to obtain the 64-bit sg_addr and convert it
@@ -237,6 +240,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
     } else {
         plen = s->regs[R_HASH_SRC_LEN];
         src = deposit64(src, 0, 32, s->regs[R_HASH_SRC]);
+        trace_aspeed_hace_addr("src", src);
         if (ahc->has_dma64) {
             src = deposit64(src, 32, 32, s->regs[R_HASH_SRC_HI]);
         }
@@ -299,6 +303,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
     if (ahc->has_dma64) {
         digest_addr = deposit64(digest_addr, 32, 32, s->regs[R_HASH_DEST_HI]);
     }
+    trace_aspeed_hace_addr("digest", digest_addr);
     if (address_space_write(&s->dram_as, digest_addr,
                             MEMTXATTRS_UNSPECIFIED,
                             digest_buf, digest_len)) {
@@ -326,6 +331,7 @@ static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int size)
         return 0;
     }
 
+    trace_aspeed_hace_read(addr << 2, s->regs[addr]);
     return s->regs[addr];
 }
 
@@ -344,6 +350,8 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
         return;
     }
 
+    trace_aspeed_hace_write(addr << 2, data);
+
     switch (addr) {
     case R_STATUS:
         if (data & HASH_IRQ) {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4383808d7a..cf96e68cfa 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -302,6 +302,12 @@ aspeed_peci_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%"
 aspeed_peci_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_peci_raise_interrupt(uint32_t ctrl, uint32_t status) "ctrl 0x%" PRIx32 " status 0x%" PRIx32
 
+# aspeed_hace.c
+aspeed_hace_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_hace_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_hace_sg(int index, uint64_t addr, uint32_t len) "%d: addr 0x%" PRIx64 " len 0x%" PRIx32
+aspeed_hace_addr(const char *s, uint64_t addr) "%s: 0x%" PRIx64
+
 # bcm2835_property.c
 bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
 
-- 
2.43.0


