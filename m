Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821EBE77193
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhP-0006Xc-An; Sun, 29 Dec 2024 02:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhH-0006W8-LW
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:48 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhG-00028j-23
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:47 -0500
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so630807066b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457204; x=1736062004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ils5tuXfHtph1hTzd0HLTrs6Eu7Mo2u0cItG3OZiwZw=;
 b=fJsoJeugHwnFUj/+uWsESI59hXpBJGZA6pxLGoUv4DkvpRHNdC9SEwwzRR3N5apa+P
 BGAxQWsGyjuWdDxsw66rdki7LRALmmgXJLs7OM9n4doe6nSpgUPqNLf+db7VemIeCRur
 TTvJn9diXEIEt4qMzS2vKDj7U4elAnMEhdfxtL3uH3RAIfnZPU4KYBompsg9bmWSVK2i
 pXGAo/1R+WBrnq+ixEvIbADUn9p9zQO7h+T1ceW1xTtr7duojAdQJ+lGIOx+MfnYh3qO
 2seo5HXnKZpxzUQS5xT7duOxS5Nedy8L19C4dDJHyqZkNGQKT6qvI5LGrEb9ve+pulSQ
 W+8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXySbQoxpaWGUGuzOsUaUP6JUO+aAfF4t7+oeJpBHtYKSF+FInB87lI1xR4gka0UTNCcdvsryfJlnHr@nongnu.org
X-Gm-Message-State: AOJu0Ywj2E3n2aMxyCwseeiFJDi/jCvB+ZbUhQ5/BqIgqdIcSo4V2FbW
 e3ma1VD8eBEED9ZcwW16lOvDNFuF8o9UETInf0Mvr6EUM5YvmZjNbmw/TQ==
X-Gm-Gg: ASbGncuP7Mo7XjbYyF8dqdquacN8nFXtVWLcyc/UpTIWn8dvcrnmvIXsyYnnYyPsCP2
 R8vq8CVhzfMo/zQAGEGuEQiEEvdolWBNX4kW8cESLmH85FIXZwa5Lo17ad6g5V5DzTtx9T2OjVy
 3Dz6vynQCOHE9NXCD6Zr/fycdAyOrZg5blWOHzfb+jbG97suJ1/SKRh6XnlcBQHxsAY9MO3696d
 dgpIPYa5JVEpQ2dTTpWDdb/FUveHpeyU6h/aECpOJPq5AmLCqVzarPQdVtdxhhIZStelwv9qkiz
 WAE=
X-Google-Smtp-Source: AGHT+IGvJg1lEUc1MRwQ1WFrKdgCLDXVtCwFQ/6OfozB0LNXnFw4YUPvtJEmPmSEkGpltvBLDOVsOg==
X-Received: by 2002:a05:6402:2790:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d81de1c241mr78521972a12.28.1735457204205; 
 Sat, 28 Dec 2024 23:26:44 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:43 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 08/35] next-cube: introduce next-scsi device
Date: Sun, 29 Dec 2024 08:24:59 +0100
Message-ID: <20241229072526.166555-9-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This device is intended to hold the ESP SCSI controller and the NeXT SCSI CSRs.
Start by creating the device and moving the ESP SCSI controller to be an
embedded child device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 93 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index c187a469d9..ce147fa9af 100644
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
@@ -1089,6 +1143,7 @@ static void next_register_type(void)
 {
     type_register_static(&next_typeinfo);
     type_register_static(&next_pc_info);
+    type_register_static(&next_scsi_info);
 }
 
 type_init(next_register_type)
-- 
2.47.1


