Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F987C282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 04:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqOsY-0007fr-JA; Thu, 06 Mar 2025 23:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOsU-0007bC-3L; Thu, 06 Mar 2025 23:00:02 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOsS-0004iq-0E; Thu, 06 Mar 2025 23:00:01 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 7 Mar
 2025 11:59:46 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 7 Mar 2025 11:59:46 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v6 03/29] hw/intc/aspeed: Introduce dynamic allocation for
 regs array
Date: Fri, 7 Mar 2025 11:59:12 +0800
Message-ID: <20250307035945.3698802-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
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

Currently, the size of the "regs" array is 0x2000, which is too large. To save
code size and avoid mapping large unused gaps, will update it to only map the
useful set of registers. This update will support multiple sub-regions with
different sizes.

To address the redundant size issue, replace the static "regs" array with a
dynamically allocated "regs" memory.

Introduce a new "aspeed_intc_unrealize" function to free the allocated "regs"
memory.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/intc/aspeed_intc.h |  2 +-
 hw/intc/aspeed_intc.c         | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 03324f05ab..47ea0520b5 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -27,7 +27,7 @@ struct AspeedINTCState {
     MemoryRegion iomem;
     MemoryRegion iomem_container;
 
-    uint32_t regs[ASPEED_INTC_NR_REGS];
+    uint32_t *regs;
     OrIRQState orgates[ASPEED_INTC_NR_INTS];
     qemu_irq output_pins[ASPEED_INTC_NR_INTS];
 
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 465f41e4fd..558901570f 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -289,7 +289,7 @@ static void aspeed_intc_reset(DeviceState *dev)
 {
     AspeedINTCState *s = ASPEED_INTC(dev);
 
-    memset(s->regs, 0, sizeof(s->regs));
+    memset(s->regs, 0, ASPEED_INTC_NR_REGS << 2);
     memset(s->enable, 0, sizeof(s->enable));
     memset(s->mask, 0, sizeof(s->mask));
     memset(s->pending, 0, sizeof(s->pending));
@@ -307,6 +307,7 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_mmio(sbd, &s->iomem_container);
 
+    s->regs = g_new(uint32_t, ASPEED_INTC_NR_REGS);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
                           TYPE_ASPEED_INTC ".regs", ASPEED_INTC_NR_REGS << 2);
 
@@ -322,12 +323,21 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void aspeed_intc_unrealize(DeviceState *dev)
+{
+    AspeedINTCState *s = ASPEED_INTC(dev);
+
+    g_free(s->regs);
+    s->regs = NULL;
+}
+
 static void aspeed_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "ASPEED INTC Controller";
     dc->realize = aspeed_intc_realize;
+    dc->unrealize = aspeed_intc_unrealize;
     device_class_set_legacy_reset(dc, aspeed_intc_reset);
     dc->vmsd = NULL;
 }
-- 
2.43.0


