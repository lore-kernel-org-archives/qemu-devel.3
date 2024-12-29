Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18762E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhU-0006ZD-UH; Sun, 29 Dec 2024 02:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhU-0006Z2-17
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:00 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhS-0002A7-IU
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:59 -0500
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso11793368a12.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457217; x=1736062017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTxvGFISXS09RDJWJfWcPbX5LopumkcLdvr0lAAgjX4=;
 b=lNGvG5NA/MZaDCugYUOIHTBUK1ih4PPMrXH2A/Y6gLCa0wLAt0o0Zq+lYIx+tQKn7B
 fUkhgiw/NjZoqU93u7mIPPArPkwL9FdmsGfvIFFpL7d4OFSlmwUq37lpMSzP1wqKjPgM
 nfbqyE/ypff6gPc+mNAruQTv8Q/gw47/P7rmbYCOkbQfVztApznDIfO5DZwI8fHt8YGB
 30ZZMUm6Ujk4Xb8oUISrXuMR4WNu4YQuleaLlzhX2aNelwK9AWmWEoHW6i0yujIIyOIn
 0Hdj2S5xuJMryrWpfsplPduS+WaswptC7TrWhKBeOXEoiIpGVb1GFfNzxrRgH2p9aZuQ
 i52A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEM1fBzDUCsCsihwxYSmWi7XEjJVfacgNknr4+F9WzzbU/3Pg+JhylDX3E6qUmwSybhVQ0pFkqDL/W@nongnu.org
X-Gm-Message-State: AOJu0YzV3g1lkoX36pF+YUzG4kX3rTTurn8UNhUdwvj6oFeGzrm4EwWG
 KX5BS2aMR7k9Zd3nK91aWArb06EXxn7zKWXqXFXONd10uh/GfR8H
X-Gm-Gg: ASbGncuS4TKlJZU0Ubvw3TSfiHVNFuNwtakTXfGKjwpLhCzIy+Qvr/jEzxzdo0AqEIi
 3CFI74ywB+A1VzXj/C+6mVELwxeHS1soDcEGFQMDOOdwSS8sMvpO++InnJ5JpL8ztjmpSNXMQ2l
 uF38KCynUsYTUaa1DZA2sNq0Nc3OSZEICi/JscOzIlXGsgBLJQOELCR3IDKqxQw1Ll6QGxlGUar
 cct0w8HM6/WIug3DNIYVOt/LxfTgYuEQQnSRazFEQd/dpJs3T9rw16l5/qhRFHN9r+IN+3uFbs8
 ZbA=
X-Google-Smtp-Source: AGHT+IFBNkft+S8TNz4Ra+uiSaz1qkNULRSlTIHRYGTktHozzSGBW89rABiQ9Q2gGHcCEu9TrbsZ9Q==
X-Received: by 2002:a05:6402:348d:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d81ddc09abmr74171444a12.18.1735457216965; 
 Sat, 28 Dec 2024 23:26:56 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:56 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 13/35] next-cube: move ESCC to be QOM child of next-pc device
Date: Sun, 29 Dec 2024 08:25:04 +0100
Message-ID: <20241229072526.166555-14-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.47; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f47.google.com
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

Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
of the next-pc device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 6ddd9ad0ec..9f49c33bdd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -124,6 +124,8 @@ struct NeXTPC {
     qemu_irq scsi_reset;
     qemu_irq scsi_dma;
 
+    ESCCState escc;
+
     NextRtc rtc;
 };
 
@@ -978,31 +980,6 @@ static const MemoryRegionOps next_floppy_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void next_escc_init(DeviceState *pcdev)
-{
-    NeXTPC *next_pc = NEXT_PC(pcdev);
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    dev = qdev_new(TYPE_ESCC);
-    qdev_prop_set_uint32(dev, "disabled", 0);
-    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
-    qdev_prop_set_uint32(dev, "it_shift", 0);
-    qdev_prop_set_bit(dev, "bit_swap", true);
-    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
-    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
-    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
-    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
-    sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
-
-    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
-                                sysbus_mmio_get_region(s, 0));
-}
-
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1043,6 +1020,28 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     /* Floppy */
     memory_region_add_subregion(&s->scrmem, 0x14108,
                                 &s->floppy_mem);
+
+    /* ESCC */
+    d = DEVICE(&s->escc);
+    qdev_prop_set_uint32(d, "disabled", 0);
+    qdev_prop_set_uint32(d, "frequency", 9600 * 384);
+    qdev_prop_set_uint32(d, "it_shift", 0);
+    qdev_prop_set_bit(d, "bit_swap", true);
+    qdev_prop_set_chr(d, "chrB", serial_hd(1));
+    qdev_prop_set_chr(d, "chrA", serial_hd(0));
+    qdev_prop_set_uint32(d, "chnBtype", escc_serial);
+    qdev_prop_set_uint32(d, "chnAtype", escc_serial);
+
+    sbd = SYS_BUS_DEVICE(d);
+    if (!sysbus_realize(sbd, errp)) {
+        return;
+    }
+    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
+    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
+
+    memory_region_add_subregion(&s->scrmem, 0x18000,
+                                sysbus_mmio_get_region(sbd, 0));
+
 }
 
 static void next_pc_init(Object *obj)
@@ -1064,6 +1063,8 @@ static void next_pc_init(Object *obj)
 
     memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
                           "next.floppy", 4);
+
+    object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
 }
 
 /*
@@ -1200,9 +1201,6 @@ static void next_cube_init(MachineState *machine)
         }
     }
 
-    /* Serial */
-    next_escc_init(pcdev);
-
     /* TODO: */
     /* Network */
 
-- 
2.47.1


