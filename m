Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98C5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUgB-0007X6-Hj; Tue, 04 Nov 2025 22:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg9-0007WG-Au; Tue, 04 Nov 2025 22:59:25 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUg7-0006sZ-R7; Tue, 04 Nov 2025 22:59:24 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 06/17] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
Date: Wed, 5 Nov 2025 11:58:44 +0800
Message-ID: <20251105035859.3709907-7-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Connect the LTPI controller to the AST1700 model by mapping its MMIO
region and wiring its interrupt line.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_ast1700.h |  2 ++
 hw/misc/aspeed_ast1700.c         | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
index 624ef61eda..c2bea11346 100644
--- a/include/hw/misc/aspeed_ast1700.h
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -28,6 +28,8 @@ struct AspeedAST1700SoCState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+
+    AspeedLTPIState ltpi;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
index 3125bec795..0ca2b90ff0 100644
--- a/hw/misc/aspeed_ast1700.c
+++ b/hw/misc/aspeed_ast1700.c
@@ -16,6 +16,14 @@
 #include "hw/misc/aspeed_ast1700.h"
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
+
+enum {
+    ASPEED_AST1700_DEV_LTPI_CTRL,
+};
+
+static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
+};
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
 {
     AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
@@ -26,10 +34,23 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                        AST2700_SOC_LTPI_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 
+    /* LTPI controller */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
 }
 
 static void aspeed_ast1700_instance_init(Object *obj)
 {
+    AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
+
+    /* LTPI controller */
+    object_initialize_child(obj, "ltpi-ctrl",
+                            &s->ltpi, TYPE_ASPEED_LTPI);
+
     return;
 }
 
-- 
2.43.0


