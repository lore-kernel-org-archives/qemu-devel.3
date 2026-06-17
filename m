Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963EDCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnAy-0003sy-E1; Wed, 17 Jun 2026 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAp-0003q3-TR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:08 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAn-0008PP-VZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:07 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30bb7d20ad9so2298042eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690824; x=1782295624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUMwvDssIR3uYg8o+wKDHFXkUTtBwn3FtTnPNCop7jI=;
 b=ZDr6iSKCgAWrxJg0r6IOckPcYilkiIIulQgyZsAkDYfz8MzUvi4U9wymhfbDIuUYIc
 VqZK4jeaA68THHwnN2qpOMudkygVprk1jEpZeMbuSpqzhAxpluPFRLzfV7KjkfEWmoKC
 nRWv2r256PRDRjuFKrMJJpBqgrFUvCXG8GHBWP7fF+oP8eOwV7J9vAReB+CkUn4LcJq/
 10WlgwyBnrz6L/eHBC4O9lj8aFkBD0iY1axdt5Rzet6QzMph2QxmdOk1hiEcNuoknM76
 FjMFgpXeT8PeDijL5I3jhX6WvBPeElNnxVnQxf1nLh7/g3Hb38IBWIk3qi7MVyx8GgP3
 EZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690824; x=1782295624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUMwvDssIR3uYg8o+wKDHFXkUTtBwn3FtTnPNCop7jI=;
 b=U/QCB41YeE1cNapI9fcC+nzMAspawmJPyUDDQ7nzufuQBHd5z3amhB8hGzKV3ONojz
 wvdYxQJI+9h5Wi8EswuUXG4k+zMZ7T864Nk13Zgsdq9rnJ0X4VEvzA/AOFeUTk2DirqS
 2B7YwUH+3GRec6sOuuBx6bXB9/aYFE0oTvqJd73a2smUrAZNrfSYSOJE0oEaS2BeWyrc
 obHx85UDuLb0MwIPxDMqRdv96HeQeHYDN/EhDbhTsSHiw9dnYjZ605eZKoQ7Lgqx0/mZ
 q0iu9trcJrjg/cfbdKONIzuiAn1YEJKo8wT0e8keLpJKwbEvino7j3R28+rVfZhMkyMg
 xpiQ==
X-Gm-Message-State: AOJu0YzZU7afzz0YrUwbzMeNivlmtreZXBNM5nbYuGJCrNYGvZAO/qJO
 4ZcwKLe7XbSCLqHFxB9SXMX3rjqw0629V+MSg+J3DocQmTXtP1xQzjk5iwoR0FOPdQ==
X-Gm-Gg: AfdE7cnxtdJ0/3L6ZcGW0HYXO9z4e6YZVv0p/LGw2ilW8KdG/7lG+IuGDh1rYkGYKT/
 fshW6T3nxDrt/Eb7Cr8F5LKRFJzeNqNfP8WzxcfhGKL9HywkQP1m/LXn7m6caIC+4DnttiYM7g9
 ptD5bDrl6IeQcDq5X3aUWNQQpgNcCx3lDBWJRlZEBLiQ1N8ouGroP7mBE4M15QwpLejAn3qhgtc
 EZ34dIYhiiwOmnWv8KuqHf+Aqu4ewzqMVP5L98SG7dj25GEIN7tSoinYtwRK2xRGul40JLUk77k
 jLHX9JNSv6qj/moHgDZHH9sen8PklmpnWk8P+5p5nrUsbDKeTjHZbmFaU2Lluddrw5KeaI8JoOz
 E4O/oEeF2Go6s5cSW+SINxJHDzkUKZ/MuSu3PRiL+QgGw+8PLrPXV2LfYpfufOrkqMOKsKDVhSv
 g10bs7p9u4jJS4vtZHOyJE
X-Received: by 2002:a05:7301:1e4c:b0:2ed:6f94:9d96 with SMTP id
 5a478bee46e88-30bc9f39f47mr1464576eec.19.1781690824165; 
 Wed, 17 Jun 2026 03:07:04 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:07:03 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 3/7] hw/pci: Introduce rom_need_patch_id flag in PCIDevice
Date: Wed, 17 Jun 2026 18:06:40 +0800
Message-ID: <20260617100646.28326-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow external code (e.g., VFIO IGD passthrough) to request PCI ID
patching for a custom romfile, replacing the existing is_default_rom
flag for this purpose.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c                | 14 ++++++--------
 include/hw/pci/pci_device.h |  1 +
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8e7872523a..b4235834a0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -352,7 +352,7 @@ static const TypeInfo cxl_bus_info = {
 
 static void pci_update_mappings(PCIDevice *d);
 static void pci_irq_handler(void *opaque, int irq_num, int level);
-static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, Error **);
+static void pci_add_option_rom(PCIDevice *pdev, Error **);
 static void pci_del_option_rom(PCIDevice *pdev);
 
 static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
@@ -2257,7 +2257,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     ObjectClass *klass = OBJECT_CLASS(pc);
     Error *local_err = NULL;
-    bool is_default_rom;
     uint16_t class_id;
 
     /*
@@ -2370,13 +2369,13 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     /* rom loading */
-    is_default_rom = false;
     if (pci_dev->romfile == NULL && pc->romfile != NULL) {
+        /* using a built-in default rom */
         pci_dev->romfile = g_strdup(pc->romfile);
-        is_default_rom = true;
+        pci_dev->rom_need_patch_id = true;
     }
 
-    pci_add_option_rom(pci_dev, is_default_rom, &local_err);
+    pci_add_option_rom(pci_dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         pci_qdev_unrealize(DEVICE(pci_dev));
@@ -2555,8 +2554,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 }
 
 /* Add an option rom for the device */
-static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
-                               Error **errp)
+static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
 {
     int64_t size = 0;
     g_autofree char *path = NULL;
@@ -2654,7 +2652,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
             return;
         }
 
-        if (is_default_rom) {
+        if (pdev->rom_need_patch_id) {
             /* Only the default rom images will be patched (if needed). */
             pci_patch_ids(pdev, ptr, size);
         }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..8b9b6470e9 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -157,6 +157,7 @@ struct PCIDevice {
     char *romfile;
     uint32_t romsize;
     bool has_rom;
+    bool rom_need_patch_id;
     MemoryRegion rom;
     int32_t rom_bar;
 
-- 
2.53.0


