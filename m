Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30734D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVyN-0001JP-5N; Mon, 08 Dec 2025 02:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVwa-0007Nv-Np; Mon, 08 Dec 2025 02:46:08 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVwY-0000Ml-79; Mon, 08 Dec 2025 02:46:03 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:43 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:43 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 15/18] hw/arm/aspeed: Attach WDT device to AST1700 model
Date: Mon, 8 Dec 2025 15:44:27 +0800
Message-ID: <20251208074436.1871180-16-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Connect the WDT device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  4 ++++
 hw/arm/aspeed_ast1700.c         | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index d4b7abee7d..f43c0c5475 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -15,8 +15,11 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/misc/aspeed_ltpi.h"
 #include "hw/ssi/aspeed_smc.h"
+#include "hw/watchdog/wdt_aspeed.h"
 #include "hw/char/serial-mm.h"
 
+#define AST1700_WDT_NUM              9
+
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
 
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
@@ -36,6 +39,7 @@ struct AspeedAST1700SoCState {
     AspeedSCUState scu;
     AspeedGPIOState gpio;
     AspeedI2CState i2c;
+    AspeedWDTState wdt[AST1700_WDT_NUM];
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index bd677727f5..289c65749a 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -25,6 +25,7 @@ enum {
     ASPEED_AST1700_DEV_I2C,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
+    ASPEED_AST1700_DEV_WDT,
     ASPEED_AST1700_DEV_SPI0_MEM,
 };
 
@@ -37,6 +38,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_I2C]       =  0x00C0F000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
+    [ASPEED_AST1700_DEV_WDT]       =  0x00C37000,
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
 };
 
@@ -129,6 +131,22 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->iomem,
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
+
+    /* WDT */
+    for (int i = 0; i < AST1700_WDT_NUM; i++) {
+        AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
+        hwaddr wdt_offset = aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_WDT] +
+                            i * awc->iosize;
+
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
+                                 errp);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+        memory_region_add_subregion(&s->iomem,
+                        wdt_offset,
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
+    }
 }
 
 static void aspeed_ast1700_instance_init(Object *obj)
@@ -162,6 +180,12 @@ static void aspeed_ast1700_instance_init(Object *obj)
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
+
+    /* WDT */
+    for (int i = 0; i < AST1700_WDT_NUM; i++) {
+        object_initialize_child(obj, "ioexp-wdt[*]",
+                                &s->wdt[i], "aspeed.wdt-ast2700");
+    }
     return;
 }
 
-- 
2.43.0


