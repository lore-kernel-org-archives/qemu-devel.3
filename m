Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 05:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1eBR-00005f-G2; Thu, 25 Sep 2025 01:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eBJ-0008WI-14; Thu, 25 Sep 2025 01:06:13 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eBF-0006qM-2a; Thu, 25 Sep 2025 01:06:11 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 25 Sep
 2025 13:05:36 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 25 Sep 2025 13:05:36 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 1/8] hw/arm/aspeed: Move aspeed_board_init_flashes() to
 common SoC code
Date: Thu, 25 Sep 2025 13:05:27 +0800
Message-ID: <20250925050535.2657256-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
References: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Relocate aspeed_board_init_flashes() from hw/arm/aspeed.c into
hw/arm/aspeed_soc_common.c so the helper can be reused by all
ASPEED machines. The API was already declared in
include/hw/arm/aspeed_soc.h; this change moves its
implementation out of the machine file to keep aspeed.c cleaner.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c            | 22 ----------------------
 hw/arm/aspeed_soc_common.c | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d21b21965a..55f0afe0a4 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -337,28 +337,6 @@ static void aspeed_load_vbootrom(AspeedMachineState *bmc, const char *bios_name,
     }
 }
 
-void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
-                                      unsigned int count, int unit0)
-{
-    int i;
-
-    if (!flashtype) {
-        return;
-    }
-
-    for (i = 0; i < count; ++i) {
-        DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
-        DeviceState *dev;
-
-        dev = qdev_new(flashtype);
-        if (dinfo) {
-            qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
-        }
-        qdev_prop_set_uint8(dev, "cs", i);
-        qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
-    }
-}
-
 static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
                                bool boot_emmc)
 {
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 1c4ac93a0f..31b1e683c3 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -16,6 +16,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial-mm.h"
+#include "system/blockdev.h"
 
 
 const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
@@ -124,6 +125,28 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
+void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
+                               unsigned int count, int unit0)
+{
+    int i;
+
+    if (!flashtype) {
+        return;
+    }
+
+    for (i = 0; i < count; ++i) {
+        DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
+        DeviceState *dev;
+
+        dev = qdev_new(flashtype);
+        if (dinfo) {
+            qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
+        }
+        qdev_prop_set_uint8(dev, "cs", i);
+        qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
+    }
+}
+
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSoCState *s = ASPEED_SOC(dev);
-- 
2.43.0


