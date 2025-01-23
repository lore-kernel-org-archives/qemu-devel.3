Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E79C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasQu-0005Kp-72; Thu, 23 Jan 2025 03:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tasQq-0005If-W9; Thu, 23 Jan 2025 03:19:21 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tasQp-0002Qj-FA; Thu, 23 Jan 2025 03:19:20 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 23 Jan
 2025 16:19:02 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 23 Jan 2025 16:19:02 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 2/2] aspeed/wdt: Support software reset mode for AST2600
Date: Thu, 23 Jan 2025 16:19:01 +0800
Message-ID: <20250123081901.2688471-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250123081901.2688471-1-jamin_lin@aspeedtech.com>
References: <20250123081901.2688471-1-jamin_lin@aspeedtech.com>
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

On the AST2400 and AST2500 platforms, the system can only be reset by enabling
the WDT (Watchdog Timer) and waiting for the WDT timeout. However, starting
from the AST2600 platform, the reset event can be triggered directly and
intentionally by software, without relying on the WDT timeout.

This mechanism, referred to as "software restart", is implemented in hardware.
When using the software restart mechanism, the WDT counter is not enabled.

To trigger a reset generation in software mode, write 0xAEEDF123 to register
0x24 and software mode reset only support SOC reset mode.

A new function, "aspeed_wdt_is_soc_reset_mode", is introduced to determine
whether the SoC reset mode is active.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/watchdog/wdt_aspeed.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 22e94e7b9c..94fb643395 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -51,11 +51,20 @@
 #define WDT_TIMEOUT_CLEAR               (0x14 / 4)
 
 #define WDT_RESTART_MAGIC               0x4755
+#define WDT_SW_RESET_ENABLE             0xAEEDF123
 
 #define AST2600_SCU_RESET_CONTROL1      (0x40 / 4)
 #define SCU_RESET_CONTROL1              (0x04 / 4)
 #define    SCU_RESET_SDRAM              BIT(0)
 
+static bool aspeed_wdt_is_soc_reset_mode(const AspeedWDTState *s)
+{
+    uint32_t mode;
+
+    mode = extract32(s->regs[WDT_CTRL], 5, 2);
+    return (mode == 0);
+}
+
 static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
 {
     return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
@@ -199,13 +208,18 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
     case WDT_TIMEOUT_STATUS:
     case WDT_TIMEOUT_CLEAR:
     case WDT_RESET_MASK2:
-    case WDT_SW_RESET_CTRL:
     case WDT_SW_RESET_MASK1:
     case WDT_SW_RESET_MASK2:
         qemu_log_mask(LOG_UNIMP,
                       "%s: uninmplemented write at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
         break;
+    case WDT_SW_RESET_CTRL:
+        if (aspeed_wdt_is_soc_reset_mode(s) &&
+            (data == WDT_SW_RESET_ENABLE)) {
+            watchdog_perform_action();
+        }
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
-- 
2.34.1


