Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE10E95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaC3-0002K5-Hv; Wed, 04 Feb 2026 05:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBu-00027H-Of
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBr-0004A7-7v
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDcF54dbpi1uatfvjlM36mQUh0PyyenaadXDPuNJYVo=;
 b=G4UY7IbsJOj15WBMxmmpZDXOZ6ZZ2I/PIbbpM7rV4pVET+LX4GjsCD2DWd6gBo5HNhrK+4
 OKUpS2TnAePTPr3MWar/CtGtT2b9jIYUgC73rh0BvomXcHY44PjMqAB5y9ncrjFOQnCaXs
 K2Q/7ot2FHsKJbn9d8K/ZBphpUUHD5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-5b7tRKfVMn-KHL5WlkQ_kw-1; Wed,
 04 Feb 2026 05:32:51 -0500
X-MC-Unique: 5b7tRKfVMn-KHL5WlkQ_kw-1
X-Mimecast-MFC-AGG-ID: 5b7tRKfVMn-KHL5WlkQ_kw_1770201170
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E5DF180025B; Wed,  4 Feb 2026 10:32:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8F7318003F6; Wed,  4 Feb 2026 10:32:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/45] hw/arm/aspeed: Attach SPI device to AST1700 model
Date: Wed,  4 Feb 2026 11:31:24 +0100
Message-ID: <20260204103136.1795455-34-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

Connect the SPI device to AST1700 model.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-11-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_ast1700.h |  3 +++
 hw/arm/aspeed_ast1700.c         | 30 ++++++++++++++++++++++++++++++
 hw/arm/aspeed_ast27x0.c         |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
index a981bff3b268..89562eb64f60 100644
--- a/include/hw/arm/aspeed_ast1700.h
+++ b/include/hw/arm/aspeed_ast1700.h
@@ -10,6 +10,7 @@
 
 #include "hw/core/sysbus.h"
 #include "hw/misc/aspeed_ltpi.h"
+#include "hw/ssi/aspeed_smc.h"
 #include "hw/char/serial-mm.h"
 
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
@@ -20,11 +21,13 @@ struct AspeedAST1700SoCState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    MemoryRegion *dram_mr;
     uint8_t board_idx;
 
     AspeedLTPIState ltpi;
     SerialMM uart;
     MemoryRegion sram;
+    AspeedSMCState spi;
 };
 
 #endif /* ASPEED_AST1700_H */
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
index fd5db3268e75..97990688f8d3 100644
--- a/hw/arm/aspeed_ast1700.c
+++ b/hw/arm/aspeed_ast1700.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/aspeed_ast1700.h"
 
@@ -16,15 +17,19 @@
 #define AST1700_SOC_SRAM_SIZE        0x00040000
 
 enum {
+    ASPEED_AST1700_DEV_SPI0,
     ASPEED_AST1700_DEV_SRAM,
     ASPEED_AST1700_DEV_UART12,
     ASPEED_AST1700_DEV_LTPI_CTRL,
+    ASPEED_AST1700_DEV_SPI0_MEM,
 };
 
 static const hwaddr aspeed_ast1700_io_memmap[] = {
+    [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
     [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
     [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
     [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
+    [ASPEED_AST1700_DEV_SPI0_MEM]  =  0x04000000,
 };
 
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
@@ -33,6 +38,11 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     char dev_name[32];
 
+    if (!s->dram_mr) {
+        error_setg(errp, TYPE_ASPEED_AST1700 ": 'dram' link not set");
+        return;
+    }
+
     /* Occupy memory space for all controllers in AST1700 */
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
                        AST2700_SOC_LTPI_SIZE);
@@ -57,6 +67,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12],
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0));
 
+    /* SPI */
+    object_property_set_link(OBJECT(&s->spi), "dram",
+                             OBJECT(s->dram_mr), errp);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 0));
+
+    memory_region_add_subregion(&s->iomem,
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0_MEM],
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), 1));
+
     /* LTPI controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
         return;
@@ -74,6 +98,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
     object_initialize_child(obj, "uart", &s->uart,
                             TYPE_SERIAL_MM);
 
+    /* SPI */
+    object_initialize_child(obj, "ioexp-spi", &s->spi,
+                            "aspeed.spi0-ast2700");
+
     /* LTPI controller */
     object_initialize_child(obj, "ltpi-ctrl",
                             &s->ltpi, TYPE_ASPEED_LTPI);
@@ -83,6 +111,8 @@ static void aspeed_ast1700_instance_init(Object *obj)
 
 static const Property aspeed_ast1700_props[] = {
     DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
+    DEFINE_PROP_LINK("dram", AspeedAST1700SoCState, dram_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6a144742ead6..2fc50af8b420 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1024,6 +1024,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     /* IO Expander */
     for (i = 0; i < sc->ioexp_num; i++) {
         qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
+        object_property_set_link(OBJECT(&s->ioexp[i]), "dram",
+                                 OBJECT(s->dram_mr), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
             return;
         }
-- 
2.52.0


