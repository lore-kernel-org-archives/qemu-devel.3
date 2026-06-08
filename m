Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2261DCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJC-0001fc-A7; Mon, 08 Jun 2026 09:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJ7-0001er-QS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:27 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJ6-0001nF-91
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:25 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-138129a622dso294001c88.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926383; x=1781531183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsRz8Y6G16FABvT4pO5G4JPM/Kif2MGsulppFYVI0J8=;
 b=Xu8lCmY4z4R2SO+KMxJGwEdtWC8EEe9WaqUecah/fvGoQPa6OnNU4JnKHdr9H53L1k
 TFquLhAH/4I1DDO+4+zb1aV+/gVX5HbB4SbgI8bW34oLddkRXszc5B0EAlJaxryXP9Mn
 D4AORMPGRdReKWpWYxCtEvGS6UCD9UK0VWcMnOyJZRQRzRML4qWDhnfiVTkBaUh67zvY
 9Cwf0l09EKbo3KRa17A6m1zt8ZlsxFs/DaSjUBswnP9Kx4zzNRMKmiwGTW/7SS3ciEwE
 rIjo/7U+CmigGZWZlq13FyLt05EAHyluDU2yt02GWm/N5aaMxIhN6ol2511DfTvCHerH
 JlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926383; x=1781531183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jsRz8Y6G16FABvT4pO5G4JPM/Kif2MGsulppFYVI0J8=;
 b=GFVZu8alfNZ5HmIH45gUWnu6s4iSPZvH8E87WJ0jRt4SILm3KHkAM9KBtMjUgmdzWq
 V5t5j19HUdpjP8wABmw30xJdLcNV1bmm6KyIv3tl/j5RtmHthCIaEJOor/kzwsgbg/CK
 kb5+PV0FIhFmAyJiR62Hg0VuW05iBoJ3MFrd8XDhYjquIAgRhkrfy1gDhPgxHEaBP6/o
 pnKHy94TtSah+RkIfKIkUL0uqDIGPtP1CLduLvktu+3ArqlSnLvhxdMM/N42KxqbPIxg
 AhNKoKGMgm4hu07J2+h2GtqaJfJHqDXuN9fTOR1gPo/sw1Txj9HlQ3eG02j6wyxEy29Y
 L59A==
X-Gm-Message-State: AOJu0Yw0xDQCYOL39n87otIG2kdQLIRUiifHxX5l5svG2mb5X4+GTk8L
 x+LDzsqWXg/FYxvmajO0QpttsLcynShe2+Z0kOHNBsZ9+ytQgNvJn9PAVD1Uy6fsZw==
X-Gm-Gg: Acq92OEWr20AY5e+FmMHxrsfccJMOrVpGD/JM/YY+X9lzBl71azzMCGHpAGpvXwRJjG
 s2QzV114ZJHmWlHdcogVE0ncnQR06T9Ts9NOIDX9wtnuAnqazICx0HgmbDfFV4uum6dpaUVJ+mt
 LiVz2uGfegkF3/eV8ZVEEXttzfJm2dwnSpGWmAQ60W1JeYHu7dkWE5eFCzVJ/mk9+4qsjNP8vhW
 I+xYVW2LckwW7YoHm8oxBVH2g2SjYxSmJXfXqzs4GMmuyCdVq64Ec1jUcBpLOervk/Hggff5YHl
 N+KOG8GZim7AxNs/M5hBo2Z2h3I6WYoWSeHkwYAB/r42XedehGjWdbNV6gL0YbkTbPvOwxbjeds
 bmOqdpuZN5SS6iPnJ9+Jp9EB/2eHBKPr8Ly8ElA5tGqPw5V7nyQipIv+nq78lcf6/RuytsrCpGz
 eiJHtMv7pe050FNxd1N238utlUKU9FQ6W9xEMkUpkWYg==
X-Received: by 2002:a05:7022:1005:b0:134:d708:1a24 with SMTP id
 a92af1059eb24-138066cd622mr7919942c88.17.1780926382726; 
 Mon, 08 Jun 2026 06:46:22 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:21 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 3/7] hw/pci: Introduce rom_need_patch_id flag in PCIDevice
Date: Mon,  8 Jun 2026 21:45:54 +0800
Message-ID: <20260608134559.23971-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1244.google.com
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
index eb10e586d5..0facc05aed 100644
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
@@ -2558,8 +2557,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 }
 
 /* Add an option rom for the device */
-static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
-                               Error **errp)
+static void pci_add_option_rom(PCIDevice *pdev, Error **errp)
 {
     int64_t size = 0;
     g_autofree char *path = NULL;
@@ -2657,7 +2655,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
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


