Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00941CC6B3D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKU8-0007bh-Kx; Thu, 15 Oct 2026 08:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTu-0006bI-8L
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTs-0005hY-4Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2Rrm6IKlaaZDhpA4W1gPO4DprvlkUlCAXvj1bF7xBY=;
 b=CEMXAPdl6NusM1OT2vmimqM1rhTSDlVNOxAXxHpXhqZSvEiyk6VMoKq5yzkiFgyk17dvTt
 FVNjU7mglhrvW76bwlBF/w4YY3V7D6yqtNTo4tPeeE/wketilmOMgFb/plwmJlY6zhJx6h
 5V1XG+wSpk3NZbF/vxh1DCPx3AqgEk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-nAWUEcxoNgqHDjbiXKryMA-1; Thu,
 15 Oct 2026 12:22:33 +0000
X-MC-Unique: nAWUEcxoNgqHDjbiXKryMA-1
X-Mimecast-MFC-AGG-ID: nAWUEcxoNgqHDjbiXKryMA_1792066952
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 042781955F1D; Thu, 15 Oct 2026 12:22:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5946E7D9; Thu, 15 Oct 2026 12:22:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/21] hw/arm/aspeed_ast1700: Use a table for unimplemented
 devices
Date: Thu, 15 Oct 2026 14:21:48 +0200
Message-ID: <20261015122151.889017-19-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Before this change, the I3C unimplemented device of AST1700 needed its
own field in AspeedAST1700SoCState and was created and mapped with
open-coded calls.

Describe it in a table and use create_unimplemented_devices() to create
and map it in the AST1700 memory region. This makes the code easier to
maintain and read.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast1700.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index 5af5da5b8a73..e5d5bf405623 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -15,7 +15,6 @@
 
 #define AST2700_SOC_LTPI_SIZE        0x01000000
 #define AST1700_SOC_SRAM_SIZE        0x00040000
-#define AST1700_SOC_I3C_SIZE         0x00010000
 
 enum {
     ASPEED_AST1700_DEV_SPI0,
@@ -51,6 +50,11 @@ static const hwaddr aspeed_ast1700_io_memmap[] = {
     [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
 };
 
+static const UnimplementedDeviceConfig aspeed_ast1700_unimp_devs[] = {
+    { "ioexp-i3c", "ioexp-i3c", 0x00C20000, 0x00010000, -1000 },
+    { }
+};
+
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
 {
     AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
@@ -181,14 +185,9 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]), 0));
     }
 
-    /* I3C */
-    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");
-    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);
-    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);
-    memory_region_add_subregion_overlap(&s->iomem,
-                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C],
-                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), 0),
-                        -1000);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), &s->iomem,
+                                 aspeed_ast1700_unimp_devs);
 }
 
 static void aspeed_ast1700_instance_init(Object *obj)
@@ -238,10 +237,6 @@ static void aspeed_ast1700_instance_init(Object *obj)
                                 &s->wdt[i], "aspeed.wdt-ast2700");
     }
 
-    /* I3C */
-    object_initialize_child(obj, "ioexp-i3c", &s->i3c,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-
     return;
 }
 
-- 
2.56.0


