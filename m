Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B3FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjCx-0007Ys-Jc; Tue, 13 May 2025 02:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAR-00053K-2v; Tue, 13 May 2025 02:31:10 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAL-000252-Bl; Tue, 13 May 2025 02:31:03 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 14:29:05 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 13 May 2025 14:29:05 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 09/25] hw/misc/aspeed_hace: Move register size to instance
 class and dynamically allocate regs
Date: Tue, 13 May 2025 14:28:39 +0800
Message-ID: <20250513062901.2256865-10-jamin_lin@aspeedtech.com>
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

Dynamically allocate the register array by removing the hardcoded
ASPEED_HACE_NR_REGS macro.

To support different register sizes across SoC variants, introduce a new
"nr_regs" class attribute and replace the static "regs" array with dynamically
allocated memory.

Add a new "aspeed_hace_unrealize" function to properly free the allocated "regs"
memory during device cleanup.

Remove the bounds checking in the MMIO read/write handlers since the
MemoryRegion size now matches the (register array size << 2).

This commit updates the VMState fields accordingly. The VMState version was
already bumped in a previous patch of this series, so no further version change
is needed.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_hace.h |  5 +++--
 hw/misc/aspeed_hace.c         | 36 ++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index b69a038d35..f30d606559 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -22,7 +22,6 @@
 
 OBJECT_DECLARE_TYPE(AspeedHACEState, AspeedHACEClass, ASPEED_HACE)
 
-#define ASPEED_HACE_NR_REGS (0x64 >> 2)
 #define ASPEED_HACE_MAX_SG  256 /* max number of entries */
 
 struct AspeedHACEState {
@@ -31,7 +30,7 @@ struct AspeedHACEState {
     MemoryRegion iomem;
     qemu_irq irq;
 
-    uint32_t regs[ASPEED_HACE_NR_REGS];
+    uint32_t *regs;
     uint32_t total_req_len;
 
     MemoryRegion *dram_mr;
@@ -44,10 +43,12 @@ struct AspeedHACEState {
 struct AspeedHACEClass {
     SysBusDeviceClass parent_class;
 
+    const MemoryRegionOps *reg_ops;
     uint32_t src_mask;
     uint32_t dest_mask;
     uint32_t key_mask;
     uint32_t hash_mask;
+    uint64_t nr_regs;
     bool raise_crypt_interrupt_workaround;
 };
 
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index ef777bb594..63404a76f7 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -386,13 +386,6 @@ static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int size)
 
     addr >>= 2;
 
-    if (addr >= ASPEED_HACE_NR_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, addr << 2);
-        return 0;
-    }
-
     return s->regs[addr];
 }
 
@@ -404,13 +397,6 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
 
     addr >>= 2;
 
-    if (addr >= ASPEED_HACE_NR_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, addr << 2);
-        return;
-    }
-
     switch (addr) {
     case R_STATUS:
         if (data & HASH_IRQ) {
@@ -507,13 +493,14 @@ static const MemoryRegionOps aspeed_hace_ops = {
 static void aspeed_hace_reset(DeviceState *dev)
 {
     struct AspeedHACEState *s = ASPEED_HACE(dev);
+    AspeedHACEClass *ahc = ASPEED_HACE_GET_CLASS(s);
 
     if (s->hash_ctx != NULL) {
         qcrypto_hash_free(s->hash_ctx);
         s->hash_ctx = NULL;
     }
 
-    memset(s->regs, 0, sizeof(s->regs));
+    memset(s->regs, 0, ahc->nr_regs << 2);
     s->total_req_len = 0;
 }
 
@@ -521,11 +508,13 @@ static void aspeed_hace_realize(DeviceState *dev, Error **errp)
 {
     AspeedHACEState *s = ASPEED_HACE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedHACEClass *ahc = ASPEED_HACE_GET_CLASS(s);
 
     sysbus_init_irq(sbd, &s->irq);
 
+    s->regs = g_new(uint32_t, ahc->nr_regs);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_hace_ops, s,
-            TYPE_ASPEED_HACE, 0x1000);
+                          TYPE_ASPEED_HACE, ahc->nr_regs << 2);
 
     if (!s->dram_mr) {
         error_setg(errp, TYPE_ASPEED_HACE ": 'dram' link not set");
@@ -548,17 +537,25 @@ static const VMStateDescription vmstate_aspeed_hace = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, AspeedHACEState, ASPEED_HACE_NR_REGS),
         VMSTATE_UINT32(total_req_len, AspeedHACEState),
         VMSTATE_END_OF_LIST(),
     }
 };
 
+static void aspeed_hace_unrealize(DeviceState *dev)
+{
+    AspeedHACEState *s = ASPEED_HACE(dev);
+
+    g_free(s->regs);
+    s->regs = NULL;
+}
+
 static void aspeed_hace_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = aspeed_hace_realize;
+    dc->unrealize = aspeed_hace_unrealize;
     device_class_set_legacy_reset(dc, aspeed_hace_reset);
     device_class_set_props(dc, aspeed_hace_properties);
     dc->vmsd = &vmstate_aspeed_hace;
@@ -579,6 +576,7 @@ static void aspeed_ast2400_hace_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "AST2400 Hash and Crypto Engine";
 
+    ahc->nr_regs = 0x64 >> 2;
     ahc->src_mask = 0x0FFFFFFF;
     ahc->dest_mask = 0x0FFFFFF8;
     ahc->key_mask = 0x0FFFFFC0;
@@ -598,6 +596,7 @@ static void aspeed_ast2500_hace_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "AST2500 Hash and Crypto Engine";
 
+    ahc->nr_regs = 0x64 >> 2;
     ahc->src_mask = 0x3fffffff;
     ahc->dest_mask = 0x3ffffff8;
     ahc->key_mask = 0x3FFFFFC0;
@@ -617,6 +616,7 @@ static void aspeed_ast2600_hace_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "AST2600 Hash and Crypto Engine";
 
+    ahc->nr_regs = 0x64 >> 2;
     ahc->src_mask = 0x7FFFFFFF;
     ahc->dest_mask = 0x7FFFFFF8;
     ahc->key_mask = 0x7FFFFFF8;
@@ -636,6 +636,7 @@ static void aspeed_ast1030_hace_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "AST1030 Hash and Crypto Engine";
 
+    ahc->nr_regs = 0x64 >> 2;
     ahc->src_mask = 0x7FFFFFFF;
     ahc->dest_mask = 0x7FFFFFF8;
     ahc->key_mask = 0x7FFFFFF8;
@@ -655,6 +656,7 @@ static void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "AST2700 Hash and Crypto Engine";
 
+    ahc->nr_regs = 0x64 >> 2;
     ahc->src_mask = 0x7FFFFFFF;
     ahc->dest_mask = 0x7FFFFFF8;
     ahc->key_mask = 0x7FFFFFF8;
-- 
2.43.0


