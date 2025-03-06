Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BA8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8dF-0004rY-81; Thu, 06 Mar 2025 05:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8dD-0004qy-Sc; Thu, 06 Mar 2025 05:39:11 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tq8dA-0000St-Vh; Thu, 06 Mar 2025 05:39:11 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 6 Mar
 2025 18:38:47 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 6 Mar 2025 18:38:47 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v5 04/29] hw/intc/aspeed: Support setting different register
 size
Date: Thu, 6 Mar 2025 18:38:12 +0800
Message-ID: <20250306103846.429221-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, the size of the regs array is 0x2000, which is too large. So far,
it only use GICINT128 - GICINT134, and the offsets from 0 to 0x1000 are unused.
To save code size, introduce a new class attribute "reg_size" to set the
different register sizes for the INTC models in AST2700 and add a regs
sub-region in the memory container.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/intc/aspeed_intc.h |  2 +-
 hw/intc/aspeed_intc.c         | 22 +++++-----------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 47ea0520b5..17cd889e0d 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -16,7 +16,6 @@
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
-#define ASPEED_INTC_NR_REGS (0x2000 >> 2)
 #define ASPEED_INTC_NR_INTS 9
 
 struct AspeedINTCState {
@@ -42,6 +41,7 @@ struct AspeedINTCClass {
     uint32_t num_lines;
     uint32_t num_ints;
     uint64_t mem_size;
+    uint64_t reg_size;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index feb2c52441..1c3dc3fce0 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -120,13 +120,6 @@ static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
     uint32_t reg = offset >> 2;
     uint32_t value = 0;
 
-    if (reg >= ASPEED_INTC_NR_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, offset);
-        return 0;
-    }
-
     value = s->regs[reg];
     trace_aspeed_intc_read(offset, size, value);
 
@@ -143,13 +136,6 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     uint32_t change;
     uint32_t irq;
 
-    if (reg >= ASPEED_INTC_NR_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, offset);
-        return;
-    }
-
     trace_aspeed_intc_write(offset, size, data);
 
     switch (reg) {
@@ -288,8 +274,9 @@ static void aspeed_intc_instance_init(Object *obj)
 static void aspeed_intc_reset(DeviceState *dev)
 {
     AspeedINTCState *s = ASPEED_INTC(dev);
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
 
-    memset(s->regs, 0, ASPEED_INTC_NR_REGS);
+    memset(s->regs, 0, aic->reg_size);
     memset(s->enable, 0, sizeof(s->enable));
     memset(s->mask, 0, sizeof(s->mask));
     memset(s->pending, 0, sizeof(s->pending));
@@ -307,9 +294,9 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_mmio(sbd, &s->iomem_container);
 
-    s->regs = g_malloc0(ASPEED_INTC_NR_REGS);
+    s->regs = g_malloc0(aic->reg_size);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
-                          TYPE_ASPEED_INTC ".regs", ASPEED_INTC_NR_REGS << 2);
+                          TYPE_ASPEED_INTC ".regs", aic->reg_size << 2);
 
     memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
 
@@ -361,6 +348,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     aic->num_lines = 32;
     aic->num_ints = 9;
     aic->mem_size = 0x4000;
+    aic->reg_size = 0x2000 >> 2;
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.43.0


