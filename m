Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A287CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTi-0006MD-Q2; Thu, 15 Oct 2026 08:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTc-00065N-Dd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTa-0005dN-Bd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdSDI4L0PkUyATVEQukscE+KxGua2cTbmsX02E7F6Kc=;
 b=MISqT0+KBKhGFlKbTg5Trj2gpOA65B8/Pu1y7Fobnw1kSIb+NyJwIg5FHyhQD+l7T0oY2J
 fRjlmLZDlTWmggmwN3UvEwzTJy1VxsdatFLxcxeOdasZyAhW3aSl8rIFGXnLtZrXSxWChv
 G6aslIY9FMw9Amlq9YAdwbCaP8kbJk8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-utoW-PNDPrOLLkUlEonxYg-1; Thu,
 15 Oct 2026 12:22:22 +0000
X-MC-Unique: utoW-PNDPrOLLkUlEonxYg-1
X-Mimecast-MFC-AGG-ID: utoW-PNDPrOLLkUlEonxYg_1792066941
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63A8F1956076; Thu, 15 Oct 2026 12:22:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC3907D8; Thu, 15 Oct 2026 12:22:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/21] hw/arm/aspeed_ast10x0: Use a table for unimplemented
 devices
Date: Thu, 15 Oct 2026 14:21:43 +0200
Message-ID: <20261015122151.889017-14-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Before this change, each unimplemented device needed its own field in
AspeedSoCState. This made the variable names confusing. For example,
AspeedSoCState has "udc" as an unimplemented device, but
Aspeed2600SoCState also has "udc" as the real UDC model.

Use the unimp_devs table in AspeedSoCClass to describe the
unimplemented devices, and use create_unimplemented_devices() to create
and map them. This makes the code easier to maintain and read. Convert
AST1030/AST1060 to use them.

This also fixes a type mismatch. AST10x0 used the "pwm" field
(AspeedPWMState) and the "sgpiom" field (AspeedSGPIOState array) to
create unimplemented devices. They are not used for that anymore.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast10x0.c | 55 +++++++++++------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index aeb5a4423dd3..07908597351a 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -17,8 +17,6 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 
-#define ASPEED_SOC_IOMEM_SIZE 0x00200000
-
 static const hwaddr aspeed_soc_ast1030_memmap[] = {
     [ASPEED_DEV_SRAM0]     = 0x00000000,
     [ASPEED_DEV_SRAM1]     = 0x79000000, /* SEC SRAM */
@@ -99,6 +97,17 @@ static const int aspeed_soc_ast1030_irqmap[] = {
     [ASPEED_DEV_JTAG1]     = 53,
 };
 
+static const UnimplementedDeviceConfig aspeed_soc_ast10x0_unimp_devs[] = {
+    { "iomem", "aspeed.io", 0x7E600000, 0x00200000, -1000 },
+    { "pwm", "aspeed.pwm", 0x7E610000, 0x100, -1000 },
+    { "espi", "aspeed.espi", 0x7E6EE000, 0x800, -1000 },
+    { "udc", "aspeed.udc", 0x7E6A2000, 0x1000, -1000 },
+    { "sgpiom", "aspeed.sgpiom", 0x7E780500, 0x100, -1000 },
+    { "jtag[0]", "aspeed.jtag0", 0x7E6E4000, 0x20, -1000 },
+    { "jtag[1]", "aspeed.jtag1", 0x7E6E4100, 0x20, -1000 },
+    { }
+};
+
 static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed10x0SoCState *a = ASPEED10X0_SOC(s);
@@ -161,17 +170,6 @@ static void aspeed_soc_ast10x0_init(Object *obj, const char *socname)
 
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
     object_initialize_child(obj, "hace", &s->hace, typename);
-
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "udc", &s->udc, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "sgpiom", &s->sgpiom,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "jtag[0]", &s->jtag[0],
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "jtag[1]", &s->jtag[1],
-                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void aspeed_soc_ast1030_init(Object *obj)
@@ -215,11 +213,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
         return false;
     }
 
-    /* General I/O memory space to catch all unimplemented device */
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
-                                  "aspeed.io",
-                                  sc->memmap[ASPEED_DEV_IOMEM],
-                                  ASPEED_SOC_IOMEM_SIZE);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
     /* AST10x0 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
@@ -394,28 +389,6 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_GPIO));
 
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
-                                  "aspeed.pwm",
-                                  sc->memmap[ASPEED_DEV_PWM], 0x100);
-
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),
-                                  "aspeed.espi",
-                                  sc->memmap[ASPEED_DEV_ESPI], 0x800);
-
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),
-                                  "aspeed.udc",
-                                  sc->memmap[ASPEED_DEV_UDC], 0x1000);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
-                                  "aspeed.sgpiom",
-                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
-
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
-                                  "aspeed.jtag",
-                                  sc->memmap[ASPEED_DEV_JTAG0], 0x20);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
-                                  "aspeed.jtag",
-                                  sc->memmap[ASPEED_DEV_JTAG1], 0x20);
-
     return true;
 }
 
@@ -503,6 +476,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
     sc->uarts_base = ASPEED_DEV_UART1;
     sc->irqmap = aspeed_soc_ast1030_irqmap;
     sc->memmap = aspeed_soc_ast1030_memmap;
+    sc->unimp_devs = aspeed_soc_ast10x0_unimp_devs;
     sc->num_cpus = 1;
 }
 
@@ -529,6 +503,7 @@ static void aspeed_soc_ast1060_class_init(ObjectClass *klass, const void *data)
     sc->uarts_base = ASPEED_DEV_UART5;
     sc->irqmap = aspeed_soc_ast1030_irqmap;
     sc->memmap = aspeed_soc_ast1030_memmap;
+    sc->unimp_devs = aspeed_soc_ast10x0_unimp_devs;
     sc->num_cpus = 1;
 }
 
-- 
2.56.0


