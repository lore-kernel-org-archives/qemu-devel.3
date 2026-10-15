Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C343CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTf-0006H4-FC; Thu, 15 Oct 2026 08:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTa-0005x7-A0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTY-0005cn-Ac
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbHdsbD+UMw1rg2dwdbPIZly5FNZ2fGF7EZZV6CD/ic=;
 b=F/ocWLgIYHoEvcImvXvErzjzGyV4AbtDVDZnq4yET25g2ZlZIziUENQq5734vRXRTMd1YS
 Y5SPX7H2JSSRmk9wm/THVyVb6dUJ8mo3ta3xFu9Ze72a+JKzm5FSjZb469mpvtP3VLBAT5
 CtluSWOncXx+ts0ljgsNnovyaa6Pvk8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-8LUAOALBMFqTdbmNKMdBdw-1; Thu,
 15 Oct 2026 12:22:20 +0000
X-MC-Unique: 8LUAOALBMFqTdbmNKMdBdw-1
X-Mimecast-MFC-AGG-ID: 8LUAOALBMFqTdbmNKMdBdw_1792066939
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F7A51954235; Thu, 15 Oct 2026 12:22:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A77827D5; Thu, 15 Oct 2026 12:22:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/21] hw/arm/aspeed_ast27x0: Use a table for unimplemented
 devices
Date: Thu, 15 Oct 2026 14:21:42 +0200
Message-ID: <20261015122151.889017-13-clg@redhat.com>
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
AST2700 to use them.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6365dbd638b5..2ef29e31e9a5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -24,10 +24,6 @@
 #include "qobject/qlist.h"
 #include "qemu/log.h"
 
-#define AST2700_SOC_IO_SIZE          0x00FE0000
-#define AST2700_SOC_IOMEM_SIZE       0x01000000
-#define AST2700_SOC_DPMCU_SIZE       0x00040000
-
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_VBOOTROM]  =  0x00000000,
     [ASPEED_DEV_IOMEM]     =  0x00020000,
@@ -263,6 +259,14 @@ static const struct gic_intc_irq_info ast2700_gic_intcmap[] = {
     {201, 3, 1, ast2700_gic201_intcmap},
 };
 
+static const UnimplementedDeviceConfig aspeed_soc_ast2700_unimp_devs[] = {
+    { "dpmcu", "aspeed.dpmcu", 0x11000000, 0x00040000, -1000 },
+    { "iomem", "aspeed.io", 0x00020000, 0x00FE0000, -1000 },
+    { "iomem0", "aspeed.iomem0", 0x12000000, 0x01000000, -1000 },
+    { "iomem1", "aspeed.iomem1", 0x14000000, 0x01000000, -1000 },
+    { }
+};
+
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
@@ -558,15 +562,6 @@ static void aspeed_soc_ast2700_init(Object *obj)
         qdev_prop_set_uint32(DEVICE(&s->ioexp[i]), "silicon-rev",
                              sc->silicon_rev);
     }
-
-    object_initialize_child(obj, "dpmcu", &s->dpmcu,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "iomem", &s->iomem,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "iomem0", &s->iomem0,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "iomem1", &s->iomem1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 /*
@@ -1137,22 +1132,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
-                                  "aspeed.dpmcu",
-                                  sc->memmap[ASPEED_DEV_DPMCU],
-                                  AST2700_SOC_DPMCU_SIZE);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
-                                  "aspeed.io",
-                                  sc->memmap[ASPEED_DEV_IOMEM],
-                                  AST2700_SOC_IO_SIZE);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem0),
-                                  "aspeed.iomem0",
-                                  sc->memmap[ASPEED_DEV_IOMEM0],
-                                  AST2700_SOC_IOMEM_SIZE);
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem1),
-                                  "aspeed.iomem1",
-                                  sc->memmap[ASPEED_DEV_IOMEM1],
-                                  AST2700_SOC_IOMEM_SIZE);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 }
 
 static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
@@ -1183,6 +1164,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART0;
     sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
     sc->memmap       = aspeed_soc_ast2700_memmap;
+    sc->unimp_devs   = aspeed_soc_ast2700_unimp_devs;
 }
 
 static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *data)
@@ -1213,6 +1195,7 @@ static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART0;
     sc->irqmap       = aspeed_soc_ast2700a1_irqmap;
     sc->memmap       = aspeed_soc_ast2700_memmap;
+    sc->unimp_devs   = aspeed_soc_ast2700_unimp_devs;
 }
 
 static const TypeInfo aspeed_soc_ast27x0_types[] = {
-- 
2.56.0


