Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49157C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8Jp-0006j1-IF; Tue, 21 Jan 2025 02:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8Ji-0006g4-Hy; Tue, 21 Jan 2025 02:04:54 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8Jf-0001Q8-6V; Tue, 21 Jan 2025 02:04:53 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:25 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:25 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 03/18] hw/intc/aspeed: Introduce a new
 aspeed_2700_intc0_ops for INTC0
Date: Tue, 21 Jan 2025 15:04:09 +0800
Message-ID: <20250121070424.2465942-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
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

Rename "aspeed_intc_read" to "aspeed_2700_intc0_read" and "aspeed_intc_write" to
"aspeed_2700_intc0_write".

Introduce a new memory region operation, "aspeed_2700_intc0_ops", for the
AST2700 INTC0 model.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 628f69ea88..219ca02940 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -114,7 +114,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
+static uint64_t aspeed_2700_intc0_read(void *opaque, hwaddr offset,
+                                       unsigned int size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
     uint32_t addr = offset >> 2;
@@ -133,8 +134,8 @@ static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
     return value;
 }
 
-static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
-                                        unsigned size)
+static void aspeed_2700_intc0_write(void *opaque, hwaddr offset, uint64_t data,
+                                    unsigned size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
@@ -261,8 +262,6 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
 }
 
 static const MemoryRegionOps aspeed_intc_ops = {
-    .read = aspeed_intc_read,
-    .write = aspeed_intc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -339,6 +338,16 @@ static const TypeInfo aspeed_intc_info = {
     .abstract = true,
 };
 
+static const MemoryRegionOps aspeed_2700_intc0_ops = {
+    .read = aspeed_2700_intc0_read,
+    .write = aspeed_2700_intc0_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
 static void aspeed_2700_intc0_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -347,6 +356,7 @@ static void aspeed_2700_intc0_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2700 INTC 0 Controller";
     aic->num_lines = 32;
     aic->num_ints = 9;
+    aic->reg_ops = &aspeed_2700_intc0_ops;
 }
 
 static const TypeInfo aspeed_2700_intc0_info = {
-- 
2.34.1


