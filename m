Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9603ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H96-0005q3-Rq; Mon, 29 Sep 2025 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8O-0003kb-Sc
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H8E-0002vk-02
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mXm5DSSgEvyNoYtMbO+sXk1x+QyYuOOC0jKCXBXWUw=;
 b=a4MSuQvcN5V3et75oHZX6PTSQYH+UqYMi1RWq9eFYKVMiEQsPzdr4zxMVy+9AjVhU2CseH
 pPMV8IJRYlD4mpBj1AWlOhLPvH/bYaqzxNztn9/6ICdZbMqjcusQR/ftIqqaowYMqjoBkH
 vaWQ4sMb+2fO1Nn7DeAAgz/S91xo3fM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-K3koB3xdNKyrrq7DtHDu8w-1; Mon,
 29 Sep 2025 12:53:37 -0400
X-MC-Unique: K3koB3xdNKyrrq7DtHDu8w-1
X-Mimecast-MFC-AGG-ID: K3koB3xdNKyrrq7DtHDu8w_1759164817
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2D701955D56; Mon, 29 Sep 2025 16:53:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42397180047F; Mon, 29 Sep 2025 16:53:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/32] hw/arm/aspeed: Move aspeed_board_init_flashes() to
 common SoC code
Date: Mon, 29 Sep 2025 18:52:25 +0200
Message-ID: <20250929165230.797471-28-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Relocate aspeed_board_init_flashes() from hw/arm/aspeed.c into
hw/arm/aspeed_soc_common.c so the helper can be reused by all
ASPEED machines. The API was already declared in
include/hw/arm/aspeed_soc.h; this change moves its
implementation out of the machine file to keep aspeed.c cleaner.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925050535.2657256-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c            | 22 ----------------------
 hw/arm/aspeed_soc_common.c | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d21b21965aa6..55f0afe0a499 100644
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
index 1c4ac93a0ff8..31b1e683c375 100644
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
2.51.0


