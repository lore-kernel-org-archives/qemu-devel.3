Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98367CCFA17
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUgF-0007Z7-Gs; Tue, 04 Nov 2025 22:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgD-0007YF-UW; Tue, 04 Nov 2025 22:59:29 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUgC-0006sZ-Hq; Tue, 04 Nov 2025 22:59:29 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:02 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:02 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 08/17] hw/arm/aspeed: Attach SRAM device to AST1700 model
Date: Wed, 5 Nov 2025 11:58:46 +0800
Message-ID: <20251105035859.3709907-9-kane_chen@aspeedtech.com>
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

Map the SRAM device to AST1700 model

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/misc/aspeed_ast1700.h |  1 +
 hw/misc/aspeed_ast1700.c         | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
index e105ceb027..391c8687f5 100644
--- a/include/hw/misc/aspeed_ast1700.h
+++ b/include/hw/misc/aspeed_ast1700.h
@@ -32,6 +32,7 @@ struct AspeedAST1700SoCState {
 
     AspeedLTPIState ltpi;
     SerialMM uart;
+    MemoryRegion sram;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
index 1c2d367cdb..6f7ff625b5 100644
--- a/hw/misc/aspeed_ast1700.c
+++ b/hw/misc/aspeed_ast1700.c
@@ -15,14 +15,18 @@
 #include "migration/vmstate.h"
 #include "hw/misc/aspeed_ast1700.h"
 
+#define AST1700_BOARD1_MEM_ADDR      0x30000000
 #define AST2700_SOC_LTPI_SIZE        0x01000000
+#define AST1700_SOC_SRAM_SIZE        0x00040000
 
 enum {
+    ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
 };
 
 static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
 };
@@ -31,12 +35,33 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
     AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     hwaddr uart_base;
+    Error *err = NULL;
+    int board_idx;
+    char sram_name[32];
+
+    if (s->mapped_base == AST1700_BOARD1_MEM_ADDR) {
+        board_idx = 0;
+    } else {
+        board_idx = 1;
+    }
 
     /* Occupy memory space for all controllers in AST1700 */
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
                        AST2700_SOC_LTPI_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 
+    /* SRAM */
+    snprintf(sram_name, sizeof(sram_name), "aspeed.ioexp-sram.%d", board_idx);
+    memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
+                           AST1700_SOC_SRAM_SIZE, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                                aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SRAM],
+                                &s->sram);
+
     /* UART */
     uart_base = s->mapped_base +
                aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12];
-- 
2.43.0


