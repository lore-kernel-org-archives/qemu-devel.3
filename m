Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD979CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTb-0005zb-Dx; Thu, 15 Oct 2026 08:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTW-0005f5-CO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTU-0005bo-5A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0hmxwpk5OQKcEu/LT0JvkEk5nqGRSJbPFS7UQjNSvE=;
 b=OCLIZ04jemXMs5ZIt+eYF7lPH10A9evFvdVsT5xe1aVsd1YYKmufqGY52CLHizLcZZ0CVk
 mpi8uc7l0lp4cmdF4dW0BKoDYogjVx5AUoSI77HW9XOnieGuCfZaoIQq+gvta3S9z5i9MU
 qzUcaRnhKucw6IqEwh4lEvCi5V9dMWY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-B5vRx68aMRGK1dVrGgGHKw-1; Thu,
 15 Oct 2026 12:22:16 +0000
X-MC-Unique: B5vRx68aMRGK1dVrGgGHKw-1
X-Mimecast-MFC-AGG-ID: B5vRx68aMRGK1dVrGgGHKw_1792066935
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28CC4195606C; Thu, 15 Oct 2026 12:22:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80B2B7D5; Thu, 15 Oct 2026 12:22:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/21] hw/arm/aspeed_ast2400: Use a table for unimplemented
 devices
Date: Thu, 15 Oct 2026 14:21:40 +0200
Message-ID: <20261015122151.889017-11-clg@redhat.com>
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

Add an unimp_devs table in AspeedSoCClass to describe the unimplemented
devices, and use create_unimplemented_devices() to create and map them.
This makes the code easier to maintain and read. Convert AST2400/AST2500
to use them.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  1 +
 hw/arm/aspeed_ast2400.c     | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index a11038574338..82e394f08539 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -190,6 +190,7 @@ struct AspeedSoCClass {
     int ioexp_num;
     const int *irqmap;
     const hwaddr *memmap;
+    const UnimplementedDeviceConfig *unimp_devs;
     uint32_t num_cpus;
     bool (*boot_from_emmc)(AspeedSoCState *s);
 };
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 79a653f65f09..fa2782da6180 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -23,8 +23,6 @@
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
 
-#define ASPEED_SOC_IOMEM_SIZE       0x00200000
-
 static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
     [ASPEED_DEV_IOMEM]  = 0x1E600000,
@@ -134,6 +132,12 @@ static const int aspeed_soc_ast2400_irqmap[] = {
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
 
+static const UnimplementedDeviceConfig aspeed_soc_ast2400_unimp_devs[] = {
+    { "iomem", "aspeed.io", 0x1E600000, 0x00200000, -1000 },
+    { "video", "aspeed.video", 0x1E700000, 0x1000, -1000 },
+    { }
+};
+
 static qemu_irq aspeed_soc_ast2400_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed2400SoCState *a = ASPEED2400_SOC(s);
@@ -239,9 +243,6 @@ static void aspeed_ast2400_soc_init(Object *obj)
 
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
     object_initialize_child(obj, "hace", &s->hace, typename);
-
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
@@ -259,16 +260,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SPI_BOOT],
                                 &s->spi_boot_container);
 
-    /* IO space */
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
-                                  "aspeed.io",
-                                  sc->memmap[ASPEED_DEV_IOMEM],
-                                  ASPEED_SOC_IOMEM_SIZE);
-
-    /* Video engine stub */
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),
-                                  "aspeed.video",
-                                  sc->memmap[ASPEED_DEV_VIDEO], 0x1000);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
@@ -542,6 +535,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART1;
     sc->irqmap       = aspeed_soc_ast2400_irqmap;
     sc->memmap       = aspeed_soc_ast2400_memmap;
+    sc->unimp_devs   = aspeed_soc_ast2400_unimp_devs;
     sc->num_cpus     = 1;
 }
 
@@ -569,6 +563,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART1;
     sc->irqmap       = aspeed_soc_ast2500_irqmap;
     sc->memmap       = aspeed_soc_ast2500_memmap;
+    sc->unimp_devs   = aspeed_soc_ast2400_unimp_devs;
     sc->num_cpus     = 1;
 }
 
-- 
2.56.0


