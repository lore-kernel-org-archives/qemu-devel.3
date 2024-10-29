Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BC1D2AB08
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5iMl-0000mF-6y; Tue, 29 Oct 2024 05:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t5iMQ-0000bU-Dh; Tue, 29 Oct 2024 05:18:04 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t5iMO-0003A3-Rx; Tue, 29 Oct 2024 05:17:58 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 29 Oct
 2024 17:17:31 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 29 Oct 2024 17:17:31 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 6/8] hw/sd/aspeed_sdhci: Introduce Capabilities Register 2
 for SD slot 0 and 1
Date: Tue, 29 Oct 2024 17:17:27 +0800
Message-ID: <20241029091729.3317512-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
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

The size of SDHCI capabilities register is 64bits, so introduces new
Capabilities Register 2 for SD slot 0 (0x144) and SD slot1 (0x244).

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/sd/aspeed_sdhci.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 427e5336a8..b73c18fbff 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -24,8 +24,10 @@
 #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
 #define ASPEED_SDHCI_BUS             0x08
 #define ASPEED_SDHCI_SDIO_140        0x10
+#define ASPEED_SDHCI_SDIO_144        0x14
 #define ASPEED_SDHCI_SDIO_148        0x18
 #define ASPEED_SDHCI_SDIO_240        0x20
+#define ASPEED_SDHCI_SDIO_244        0x24
 #define ASPEED_SDHCI_SDIO_248        0x28
 #define ASPEED_SDHCI_WP_POL          0xec
 #define ASPEED_SDHCI_CARD_DET        0xf0
@@ -35,21 +37,27 @@
 
 static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    uint32_t val = 0;
+    uint64_t val = 0;
     AspeedSDHCIState *sdhci = opaque;
 
     switch (addr) {
     case ASPEED_SDHCI_SDIO_140:
-        val = (uint32_t)sdhci->slots[0].capareg;
+        val = extract64(sdhci->slots[0].capareg, 0, 32);
+        break;
+    case ASPEED_SDHCI_SDIO_144:
+        val = extract64(sdhci->slots[0].capareg, 32, 32);
         break;
     case ASPEED_SDHCI_SDIO_148:
-        val = (uint32_t)sdhci->slots[0].maxcurr;
+        val = extract64(sdhci->slots[0].maxcurr, 0, 32);
         break;
     case ASPEED_SDHCI_SDIO_240:
-        val = (uint32_t)sdhci->slots[1].capareg;
+        val = extract64(sdhci->slots[1].capareg, 0, 32);
+        break;
+    case ASPEED_SDHCI_SDIO_244:
+        val = extract64(sdhci->slots[1].capareg, 32, 32);
         break;
     case ASPEED_SDHCI_SDIO_248:
-        val = (uint32_t)sdhci->slots[1].maxcurr;
+         val = extract64(sdhci->slots[1].maxcurr, 0, 32);
         break;
     default:
         if (addr < ASPEED_SDHCI_REG_SIZE) {
@@ -61,9 +69,9 @@ static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
         }
     }
 
-    trace_aspeed_sdhci_read(addr, size, (uint64_t) val);
+    trace_aspeed_sdhci_read(addr, size, val);
 
-    return (uint64_t)val;
+    return val;
 }
 
 static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
@@ -79,16 +87,26 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
         sdhci->regs[TO_REG(addr)] = (uint32_t)val & ~ASPEED_SDHCI_INFO_RESET;
         break;
     case ASPEED_SDHCI_SDIO_140:
-        sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
+    sdhci->slots[0].capareg = deposit64(sdhci->slots[0].capareg, 0, 32, val);
+    break;
+    case ASPEED_SDHCI_SDIO_144:
+    sdhci->slots[0].capareg = deposit64(sdhci->slots[0].capareg, 32, 32, val);
         break;
     case ASPEED_SDHCI_SDIO_148:
-        sdhci->slots[0].maxcurr = (uint64_t)(uint32_t)val;
+        sdhci->slots[0].maxcurr = deposit64(sdhci->slots[0].maxcurr,
+                                            0, 32, val);
         break;
     case ASPEED_SDHCI_SDIO_240:
-        sdhci->slots[1].capareg = (uint64_t)(uint32_t)val;
+        sdhci->slots[1].capareg = deposit64(sdhci->slots[1].capareg,
+                                            0, 32, val);
+        break;
+    case ASPEED_SDHCI_SDIO_244:
+        sdhci->slots[1].capareg = deposit64(sdhci->slots[1].capareg,
+                                            32, 32, val);
         break;
     case ASPEED_SDHCI_SDIO_248:
-        sdhci->slots[1].maxcurr = (uint64_t)(uint32_t)val;
+        sdhci->slots[1].maxcurr = deposit64(sdhci->slots[0].maxcurr,
+                                            0, 32, val);
         break;
     default:
         if (addr < ASPEED_SDHCI_REG_SIZE) {
-- 
2.34.1


