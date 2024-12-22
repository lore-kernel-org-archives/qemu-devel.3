Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7C8E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLai-00061V-0q; Sun, 22 Dec 2024 08:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZk-00058p-0y
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:52 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZg-0000e4-NM
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=xeVj6NR1RtwmxzLwpcufTW2T+BD6qRF1h7dmSVBMkkE=; b=l0Q7v6WMq6FbB3nsGT+TC995mC
 zYaDMpostyb5aqWTfcUonYlaYHCL4YS4exZe4RKIq+bjUTDEg5XaWVjtxvKA7jfxPaiz//PZHFVPZ
 CUaPxWZfHbRiPa7yhuDqDrOiSkkIaQIT0u8xvgybuSeUl210bLiCliEfdPzhpkywUSA9nXjJllSM+
 qrSHJPeRj9GwehtjBTl6v+ciWYbeG8O9rv4JB0JKM8WuHLbd6I9auuezFN67JHBQQAedYz8ChluAW
 MwpzYjA4s+9cIc5kwInR5czRSnyoWftKXqLU0HyAfNHY5xuxfruaf7yJYuBTiIOKFY+vka6Njz7/F
 8f2h4rrloqzI3N3caFHxL4rQm6YI8MyjZ6b+4ltbWnR9k2c7agwrR6fDxX4GULaus/T1jCj9szsvb
 /n/5mLAVMzCt1ZXfLEA44NlOHyRYK3oQGcbO2LLK/NBIp05agKECtpLdy7Uybt/WSoaRe4wBQuKJf
 SPpY8e7JHQhfEyT9j2erS+JUhzM9URIi5kdZFpz+dy7YD5TWyC/3EZz4tUtzUATLXn8L0DQjHFp+3
 JUCBA7xvomWGNvpglgpV+jngqEEhvAobBU15DrHfWch+KEwbAau7i5E7hVn3i6I9Zrw51bmpUBd2S
 Kon3ituVjMP+oD+RnZcvIsnbAMSmQZ8D/qf9Zqhms=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZ1-0002L7-MT; Sun, 22 Dec 2024 13:00:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:45 +0000
Message-Id: <20241222130012.1013374-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 06/33] next-cube: introduce next-scsi device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This device is intended to hold the ESP SCSI controller and the NeXT SCSI CSRs.
Start by creating the device and moving the ESP SCSI controller to be an
embedded child device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 93 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 75fc9724cd..248cd5b776 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -83,6 +83,18 @@ struct NeXTState {
     next_dma dma[10];
 };
 
+#define TYPE_NEXT_SCSI "next-scsi"
+OBJECT_DECLARE_SIMPLE_TYPE(NeXTSCSI, NEXT_SCSI)
+
+/* NeXT SCSI Controller */
+struct NeXTSCSI {
+    SysBusDevice parent_obj;
+
+    MemoryRegion scsi_mem;
+
+    SysBusESPState sysbus_esp;
+};
+
 #define TYPE_NEXT_PC "next-pc"
 OBJECT_DECLARE_SIMPLE_TYPE(NeXTPC, NEXT_PC)
 
@@ -94,7 +106,6 @@ struct NeXTPC {
 
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
-    MemoryRegion scsimem;
 
     uint32_t scr1;
     uint32_t scr2;
@@ -102,6 +113,8 @@ struct NeXTPC {
     uint32_t int_mask;
     uint32_t int_status;
     uint32_t led;
+
+    NeXTSCSI next_scsi;
     uint8_t scsi_csr_1;
     uint8_t scsi_csr_2;
 
@@ -825,38 +838,61 @@ static void nextscsi_write(void *opaque, uint8_t *buf, int size)
     nextdma_write(opaque, buf, size, NEXTDMA_SCSI);
 }
 
-static void next_scsi_init(DeviceState *pcdev)
+static void next_scsi_init(Object *obj)
 {
-    struct NeXTPC *next_pc = NEXT_PC(pcdev);
-    DeviceState *dev;
-    SysBusDevice *sysbusdev;
+    NeXTSCSI *s = NEXT_SCSI(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    object_initialize_child(obj, "esp", &s->sysbus_esp, TYPE_SYSBUS_ESP);
+
+    memory_region_init(&s->scsi_mem, obj, "next.scsi", 0x40);
+    sysbus_init_mmio(sbd, &s->scsi_mem);
+}
+
+static void next_scsi_realize(DeviceState *dev, Error **errp)
+{
+    NeXTSCSI *s = NEXT_SCSI(dev);
     SysBusESPState *sysbus_esp;
+    SysBusDevice *sbd;
     ESPState *esp;
+    NeXTPC *pcdev;
+
+    pcdev = NEXT_PC(container_of(s, NeXTPC, next_scsi));
 
-    dev = qdev_new(TYPE_SYSBUS_ESP);
-    sysbus_esp = SYSBUS_ESP(dev);
+    /* ESP */
+    sysbus_esp = SYSBUS_ESP(&s->sysbus_esp);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = nextscsi_read;
     esp->dma_memory_write = nextscsi_write;
     esp->dma_opaque = pcdev;
     sysbus_esp->it_shift = 0;
     esp->dma_enabled = 1;
-    sysbusdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbusdev, &error_fatal);
-    sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(pcdev, NEXT_SCSI_I));
-
-    memory_region_init(&next_pc->scsimem, OBJECT(next_pc), "next.scsi", 0x40);
-    memory_region_add_subregion(&next_pc->scsimem, 0x0,
-                                sysbus_mmio_get_region(sysbusdev, 0));
+    sbd = SYS_BUS_DEVICE(sysbus_esp);
+    if (!sysbus_realize(sbd, errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->scsi_mem, 0x0,
+                                sysbus_mmio_get_region(sbd, 0));
 
-    memory_region_add_subregion(&next_pc->scrmem, 0x14000, &next_pc->scsimem);
+    scsi_bus_legacy_handle_cmdline(&s->sysbus_esp.esp.bus);
+}
 
-    next_pc->scsi_reset = qdev_get_gpio_in(dev, 0);
-    next_pc->scsi_dma = qdev_get_gpio_in(dev, 1);
+static void next_scsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    scsi_bus_legacy_handle_cmdline(&esp->bus);
+    dc->desc = "NeXT SCSI Controller";
+    dc->realize = next_scsi_realize;
 }
 
+static const TypeInfo next_scsi_info = {
+    .name = TYPE_NEXT_SCSI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_scsi_init,
+    .instance_size = sizeof(NeXTSCSI),
+    .class_init = next_scsi_class_init,
+};
+
 static void next_escc_init(DeviceState *pcdev)
 {
     DeviceState *dev;
@@ -897,8 +933,24 @@ static void next_pc_reset(DeviceState *dev)
 
 static void next_pc_realize(DeviceState *dev, Error **errp)
 {
+    NeXTPC *s = NEXT_PC(dev);
+    SysBusDevice *sbd;
+    DeviceState *d;
+
     /* SCSI */
-    next_scsi_init(dev);
+    sbd = SYS_BUS_DEVICE(&s->next_scsi);
+    if (!sysbus_realize(sbd, errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s->scrmem, 0x14000,
+                                sysbus_mmio_get_region(sbd, 0));
+
+    d = DEVICE(object_resolve_path_component(OBJECT(&s->next_scsi), "esp"));
+    sysbus_connect_irq(SYS_BUS_DEVICE(d), 0,
+                       qdev_get_gpio_in(DEVICE(s), NEXT_SCSI_I));
+
+    s->scsi_reset = qdev_get_gpio_in(d, 0);
+    s->scsi_dma = qdev_get_gpio_in(d, 1);
 }
 
 static void next_pc_init(Object *obj)
@@ -915,6 +967,8 @@ static void next_pc_init(Object *obj)
 
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
+
+    object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
 }
 
 /*
@@ -1088,6 +1142,7 @@ static void next_register_type(void)
 {
     type_register_static(&next_typeinfo);
     type_register_static(&next_pc_info);
+    type_register_static(&next_scsi_info);
 }
 
 type_init(next_register_type)
-- 
2.39.5


