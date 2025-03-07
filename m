Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78512C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 04:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqOuR-0002po-PI; Thu, 06 Mar 2025 23:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOuL-0002Vu-VW; Thu, 06 Mar 2025 23:01:58 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOuJ-00056A-Gq; Thu, 06 Mar 2025 23:01:56 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 7 Mar
 2025 11:59:54 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 7 Mar 2025 11:59:54 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 24/29] hw/arm/aspeed_ast27x0: Sort the memmap table by
 mapping address
Date: Fri, 7 Mar 2025 11:59:33 +0800
Message-ID: <20250307035945.3698802-25-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

To improve readability, sort the memmap table by mapping address

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 7439512b83..3330484bf5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -24,16 +24,40 @@
 #include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
-    [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SRAM]      =  0x10000000,
+    [ASPEED_DEV_HACE]      =  0x12070000,
+    [ASPEED_DEV_EMMC]      =  0x12090000,
+    [ASPEED_DEV_INTC]      =  0x12100000,
+    [ASPEED_GIC_DIST]      =  0x12200000,
+    [ASPEED_GIC_REDIST]    =  0x12280000,
     [ASPEED_DEV_SDMC]      =  0x12C00000,
     [ASPEED_DEV_SCU]       =  0x12C02000,
+    [ASPEED_DEV_RTC]       =  0x12C0F000,
+    [ASPEED_DEV_TIMER1]    =  0x12C10000,
+    [ASPEED_DEV_SLI]       =  0x12C17000,
+    [ASPEED_DEV_UART4]     =  0X12C1A000,
+    [ASPEED_DEV_FMC]       =  0x14000000,
+    [ASPEED_DEV_SPI0]      =  0x14010000,
+    [ASPEED_DEV_SPI1]      =  0x14020000,
+    [ASPEED_DEV_SPI2]      =  0x14030000,
+    [ASPEED_DEV_MII1]      =  0x14040000,
+    [ASPEED_DEV_MII2]      =  0x14040008,
+    [ASPEED_DEV_MII3]      =  0x14040010,
+    [ASPEED_DEV_ETH1]      =  0x14050000,
+    [ASPEED_DEV_ETH2]      =  0x14060000,
+    [ASPEED_DEV_ETH3]      =  0x14070000,
+    [ASPEED_DEV_SDHCI]     =  0x14080000,
+    [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_SCUIO]     =  0x14C02000,
+    [ASPEED_DEV_GPIO]      =  0x14C0B000,
+    [ASPEED_DEV_I2C]       =  0x14C0F000,
+    [ASPEED_DEV_INTCIO]    =  0x14C18000,
+    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
+    [ASPEED_DEV_VUART]     =  0X14C30000,
     [ASPEED_DEV_UART0]     =  0X14C33000,
     [ASPEED_DEV_UART1]     =  0X14C33100,
     [ASPEED_DEV_UART2]     =  0X14C33200,
     [ASPEED_DEV_UART3]     =  0X14C33300,
-    [ASPEED_DEV_UART4]     =  0X12C1A000,
     [ASPEED_DEV_UART5]     =  0X14C33400,
     [ASPEED_DEV_UART6]     =  0X14C33500,
     [ASPEED_DEV_UART7]     =  0X14C33600,
@@ -43,32 +67,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_UART11]    =  0X14C33A00,
     [ASPEED_DEV_UART12]    =  0X14C33B00,
     [ASPEED_DEV_WDT]       =  0x14C37000,
-    [ASPEED_DEV_VUART]     =  0X14C30000,
-    [ASPEED_DEV_FMC]       =  0x14000000,
-    [ASPEED_DEV_SPI0]      =  0x14010000,
-    [ASPEED_DEV_SPI1]      =  0x14020000,
-    [ASPEED_DEV_SPI2]      =  0x14030000,
+    [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
-    [ASPEED_DEV_MII1]      =  0x14040000,
-    [ASPEED_DEV_MII2]      =  0x14040008,
-    [ASPEED_DEV_MII3]      =  0x14040010,
-    [ASPEED_DEV_ETH1]      =  0x14050000,
-    [ASPEED_DEV_ETH2]      =  0x14060000,
-    [ASPEED_DEV_ETH3]      =  0x14070000,
-    [ASPEED_DEV_EMMC]      =  0x12090000,
-    [ASPEED_DEV_INTC]      =  0x12100000,
-    [ASPEED_DEV_INTCIO]    =  0x14C18000,
-    [ASPEED_DEV_SLI]       =  0x12C17000,
-    [ASPEED_DEV_SLIIO]     =  0x14C1E000,
-    [ASPEED_GIC_DIST]      =  0x12200000,
-    [ASPEED_GIC_REDIST]    =  0x12280000,
-    [ASPEED_DEV_ADC]       =  0x14C00000,
-    [ASPEED_DEV_I2C]       =  0x14C0F000,
-    [ASPEED_DEV_GPIO]      =  0x14C0B000,
-    [ASPEED_DEV_RTC]       =  0x12C0F000,
-    [ASPEED_DEV_SDHCI]     =  0x14080000,
-    [ASPEED_DEV_TIMER1]    =  0x12C10000,
-    [ASPEED_DEV_HACE]      =  0x12070000,
 };
 
 #define AST2700_MAX_IRQ 256
-- 
2.43.0


