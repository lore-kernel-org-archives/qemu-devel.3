Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7727CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BLf-0007nc-IL; Mon, 13 Oct 2025 01:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BLc-0007m2-M8; Mon, 13 Oct 2025 01:43:52 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BLa-0002DU-UP; Mon, 13 Oct 2025 01:43:52 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 13 Oct
 2025 13:43:34 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Oct 2025 13:43:34 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 01/16] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_uart_first() API
Date: Mon, 13 Oct 2025 13:43:13 +0800
Message-ID: <20251013054334.955331-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
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

Refactor the aspeed_uart_first() helper to remove its dependency on
AspeedSoCState and make the UART helper APIs more generic.

The function now takes uarts_base as an integer parameter instead of
requiring a full SoC class instance. Corresponding call sites in
aspeed.c and aspeed_soc_common.c are updated accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 6 +++---
 hw/arm/aspeed.c             | 2 +-
 hw/arm/aspeed_soc_common.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index ed32efb543..5786fbbcbb 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -326,14 +326,14 @@ static inline int aspeed_uart_index(int uart_dev)
     return uart_dev - ASPEED_DEV_UART0;
 }
 
-static inline int aspeed_uart_first(AspeedSoCClass *sc)
+static inline int aspeed_uart_first(int uarts_base)
 {
-    return aspeed_uart_index(sc->uarts_base);
+    return aspeed_uart_index(uarts_base);
 }
 
 static inline int aspeed_uart_last(AspeedSoCClass *sc)
 {
-    return aspeed_uart_first(sc) + sc->uarts_num - 1;
+    return aspeed_uart_first(sc->uarts_base) + sc->uarts_num - 1;
 }
 
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6046ec0bb2..471ad7fb84 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1310,7 +1310,7 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
     int val;
-    int uart_first = aspeed_uart_first(sc);
+    int uart_first = aspeed_uart_first(sc->uarts_base);
     int uart_last = aspeed_uart_last(sc);
 
     if (sscanf(value, "uart%u", &val) != 1) {
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index bc70e864fb..a4e74acdce 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -62,7 +62,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
 void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
 {
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    int uart_first = aspeed_uart_first(sc);
+    int uart_first = aspeed_uart_first(sc->uarts_base);
     int uart_index = aspeed_uart_index(dev);
     int i = uart_index - uart_first;
 
-- 
2.43.0


