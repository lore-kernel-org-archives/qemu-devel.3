Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949E6E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhe-0006b8-Ot; Sun, 29 Dec 2024 02:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhd-0006aw-S8
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:09 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhc-0002Aw-5a
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:09 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso13380405a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457226; x=1736062026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4l+TGHlXOBajtfUIglTchzUa6DZDsxbmzAyjdJQacs=;
 b=lf+ZVmriNmfMiWIHnznIJr0ru8cf+ZUi9uH27a3tbowMIa+JJLEQyb5L/oqQJ0lEQz
 9cgYghh/rwS+6Kp5idDJigqC1Y+TL/vQyQsRZNKVZhelwGT6ysXVJNFbiFlHZB7zGQsS
 5izSo7/jgBNz5GGQ6a6FSU5tYxHxpx50nq/ruRhzQxjtEaEt2tJu9fvvyclkcvAGbOVg
 j31UbYy9+D8ZL8IENXPLs90IX2efRhqkWKqfbzsu8vV2hsgCTgq6o/bWcAMEB1GnUV7F
 dNVbEdVV+vTWhOVCA20DnRzNTnm009eH7P9kFrwD04MVMGa23C9zrMEirvG/gVL6hPba
 J4Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURhht7p5uUAJ+m5Fyg9ENgGefqU5h4i0QHlDQyxwO5WvV7y7yBHYytEWTEar/RC4NX7vUJqmPU6Pno@nongnu.org
X-Gm-Message-State: AOJu0YxVAg/FFkcCRJAUKOneo8XEXuHAKWoFmUp/snQz/ueXRktb+lgU
 vwz5PXgyxZHTmJOmTJKzl1haakcK6MGK8++ivAJ/nLyxVH6QN+DD
X-Gm-Gg: ASbGnculiAJWfSF8EJoA94ih4M7KUjBlIC0/agH7pDDNmxNv0dGAOUXkyfaFRe32sNw
 Ua/IgS6neQYXk8LN536Don7bc9PMSTcYnggK8xCex40GjcUMGLFkll59pZkrQrVjMmIKadShEp0
 8t0rTtAVBRFFAcrh3im6qjgodzGhi6dX+PjIr1t8RsQW41omeb/+P7t6vzh2tJiRc6s31mUgRyq
 hQ8nPetorjJECi2GyrT7qE6iZherhYsRVMPjrd136+g+My5M/UMfV2X5s1aihVsGZJb1pnB3mQ0
 MdY=
X-Google-Smtp-Source: AGHT+IFHK/AsFRSwlXIsHkLKFfrsPQ/pqefIt3wxAU1U3u2GWl4YXoUkZSDO4uOR5jkrm8aKV/IwWg==
X-Received: by 2002:a05:6402:270d:b0:5d0:fb56:3f with SMTP id
 4fb4d7f45d1cf-5d81dd9cdf0mr70072915a12.12.1735457226192; 
 Sat, 28 Dec 2024 23:27:06 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:05 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 17/35] next-cube: remove unused next.scr memory region
Date: Sun, 29 Dec 2024 08:25:08 +0100
Message-ID: <20241229072526.166555-18-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.52; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f52.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now that the next.scr memory region is unused it can be removed and the next-pc
devices mapped directly within the machine init function. This is the last
remaining overlapping memory region within the NeXTCube machine.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 73 +++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 6ca9170108..73c4d4ea9c 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -369,38 +369,6 @@ static const MemoryRegionOps next_mmio_ops = {
 #define SCSICSR_CPUDMA  0x10  /* if set, dma enabled */
 #define SCSICSR_INTMASK 0x20  /* if set, interrupt enabled */
 
-static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
-{
-    uint64_t val;
-
-    switch (addr) {
-    default:
-        DPRINTF("BMAP Read @ 0x%x size %u\n", (unsigned int)addr, size);
-        val = 0;
-        break;
-    }
-
-    return val;
-}
-
-static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
-                             unsigned size)
-{
-    switch (addr) {
-    default:
-        DPRINTF("BMAP Write @ 0x%x with 0x%"PRIx64 " size %u\n",
-                (unsigned int)addr, val, size);
-    }
-}
-
-static const MemoryRegionOps next_scr_ops = {
-    .read = next_scr_readfn,
-    .write = next_scr_writefn,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 #define NEXTDMA_SCSI(x)      (0x10 + x)
 #define NEXTDMA_FD(x)        (0x10 + x)
 #define NEXTDMA_ENTX(x)      (0x110 + x)
@@ -1063,17 +1031,11 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     DeviceState *d;
 
-    /* en network (dummy) */
-    memory_region_add_subregion(&s->scrmem, 0x6000,
-                                &s->dummyen_mem);
-
     /* SCSI */
     sbd = SYS_BUS_DEVICE(&s->next_scsi);
     if (!sysbus_realize(sbd, errp)) {
         return;
     }
-    memory_region_add_subregion(&s->scrmem, 0x14000,
-                                sysbus_mmio_get_region(sbd, 0));
 
     d = DEVICE(object_resolve_path_component(OBJECT(&s->next_scsi), "esp"));
     sysbus_connect_irq(SYS_BUS_DEVICE(d), 0,
@@ -1082,10 +1044,6 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     s->scsi_reset = qdev_get_gpio_in(d, 0);
     s->scsi_dma = qdev_get_gpio_in(d, 1);
 
-    /* Floppy */
-    memory_region_add_subregion(&s->scrmem, 0x14108,
-                                &s->floppy_mem);
-
     /* ESCC */
     d = DEVICE(&s->escc);
     qdev_prop_set_uint32(d, "disabled", 0);
@@ -1103,12 +1061,6 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
     sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
-
-    memory_region_add_subregion(&s->scrmem, 0x18000,
-                                sysbus_mmio_get_region(sbd, 0));
-
-    /* Timer */
-    memory_region_add_subregion(&s->scrmem, 0x1a000, &s->timer_mem);
 }
 
 static void next_pc_init(Object *obj)
@@ -1120,24 +1072,27 @@ static void next_pc_init(Object *obj)
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
                           "next.mmio", 0x9000);
-    memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
-                          "next.scr", 0x20000);
-
     sysbus_init_mmio(sbd, &s->mmiomem);
-    sysbus_init_mmio(sbd, &s->scrmem);
 
     memory_region_init_io(&s->dummyen_mem, OBJECT(s), &next_dummy_en_ops, s,
                           "next.en", 0x20);
+    sysbus_init_mmio(sbd, &s->dummyen_mem);
 
     object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
+    sysbus_init_mmio(sbd,
+                     sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->next_scsi), 0));
 
     memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
                           "next.floppy", 4);
+    sysbus_init_mmio(sbd, &s->floppy_mem);
 
     object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
+    sysbus_init_mmio(sbd,
+                     sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->escc), 0));
 
     memory_region_init_io(&s->timer_mem, OBJECT(s), &next_timer_ops, s,
                           "next.timer", 4);
+    sysbus_init_mmio(sbd, &s->timer_mem);
 }
 
 /*
@@ -1239,13 +1194,27 @@ static void next_cube_init(MachineState *machine)
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
+    /* en network (dummy) */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02106000);
+
     /* unknown: Brightness control register? */
     empty_slot_init("next.unknown.0", 0x02110000, 0x10);
     /* unknown: Magneto-Optical drive controller? */
     empty_slot_init("next.unknown.1", 0x02112000, 0x10);
+
+    /* SCSI */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 2, 0x02114000);
+    /* Floppy */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 3, 0x02114108);
+    /* ESCC */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 4, 0x02118000);
+
     /* unknown: Serial clock configuration register? */
     empty_slot_init("next.unknown.2", 0x02118004, 0x10);
 
+    /* Timer */
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 5, 0x0211a000);
+
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
-- 
2.47.1


