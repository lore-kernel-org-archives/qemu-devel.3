Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB90D3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 07:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSVwT-0007FK-PL; Mon, 08 Dec 2025 02:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvm-00071L-QS; Mon, 08 Dec 2025 02:45:14 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vSVvk-0008LH-5F; Mon, 08 Dec 2025 02:45:13 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 15:44:40 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 15:44:40 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 08/18] hw/arm/aspeed: Attach UART device to AST1700 model
Date: Mon, 8 Dec 2025 15:44:20 +0800
Message-ID: <20251208074436.1871180-9-kane_chen@aspeedtech.com>
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

Connect the UART controller to the AST1700 model by mapping its MMIO
region.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_ast1700.h |  2 ++
 hw/arm/aspeed_ast1700.c         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index b9ee4952d0..a0d6b3ae44 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -10,6 +10,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/misc/aspeed_ltpi.h"
+#include "hw/char/serial-mm.h"
 
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
 
@@ -21,6 +22,7 @@ struct AspeedAST1700SoCState {
     MemoryRegion iomem;
 
     AspeedLTPIState ltpi;
+    SerialMM uart;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 5255bd0daa..f88052ec8a 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -10,15 +10,18 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/aspeed_ast1700.h"
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
 
 enum {
+    ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
 };
 
 static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
 };
 
@@ -32,6 +35,17 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                        AST2700_SOC_LTPI_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 
+    /* UART */
+    qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
+    qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);
+    qdev_prop_set_uint8(DEVICE(&s->uart), "endianness", DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -45,6 +59,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
 {
     AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
 
+    /* UART */
+    object_initialize_child(obj, "uart[*]", &s->uart,
+                            TYPE_SERIAL_MM);
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
-- 
2.43.0


