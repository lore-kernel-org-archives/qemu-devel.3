Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50422E64AA4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4k-00083a-RH; Tue, 03 Dec 2024 08:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4i-00082i-CY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:24 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4g-0001H8-Jj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:24 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-215a0390925so20946135ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232981; x=1733837781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpWNENhtDze8yzSa9nxZOuFXOnFwLl1CdxHyDNuyQqk=;
 b=coYLm85U/xjTULTqMu96IXt4S+UV00DzLfaDIf3FmJ7mlA2nj9xsawLeE4OxSv/5cw
 xr2a5i62m9eANC3fneuIx7r7mQGgruyE1DO7Du5rJJN2h4T3jJjr9y+Pywq+1MIRhiLu
 tSmJfWtG3g9s/Cvco//sv3p5edBIHpoMZ4ajd2ewsY1M2AVE7HPk6YBB5Cg9Iwzq/b/7
 33v8zYJL5sW5YpH4fSjqr4nP0/tImxSmOPPgsPhS5f5k7dC0cAQYzg2zZEnF5EAqyWVb
 GpD7KOtCWHvR1w07xndnp3TQR2pmConYtWljQPPWb6O6ZADwIoIeZnNs6Q/JPRrB3VBz
 Q89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232981; x=1733837781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpWNENhtDze8yzSa9nxZOuFXOnFwLl1CdxHyDNuyQqk=;
 b=tws9FPJFqgPbZBn59BYKjH1upos5tBFEvf9kM7p+uFv3O8UgrXlduwYo/AHP3BdIfc
 3Hy9d2qh9j9KB9YGwzUIkDK0jw9jg0HhMZBgFMX3zDTsWi4T2eCaS/h698MCZWBQb1sv
 J9T5zYxLy9HxMbTPWe65FL8px6LPL8woqpriaY1d6jlB1tzl5hrZNlI7NOsuzB1bwhiT
 hgTnLsYQdB/BmQAt3ud3q7R8dJj65mWK3O0bLuEN5QJCPSM+GFGcQhPiRGTdtEBz5mTw
 ekw0PR0MVp1pNBHRXUJ4K89H6pDdLcszEu0w/bKjYRToPnst2iPGTiV4i7aEV8s3mfoU
 C7SA==
X-Gm-Message-State: AOJu0Yy+yzh036STypqZBNAvttI7GS0T/+Lv+RvMzDAA2NEE8O+NUBbw
 HCB2hP32WrJMpxD2rGyErHzI5ewIWzvQzB7//nqjIb2fDA4Vs+7Zn5YHBwiJlQ==
X-Gm-Gg: ASbGnctOjVAFl6MzHHRqKj+veTqUh1QUdQwoy9bBgqdatoQ4QGSucTspAFoVTQzXbYp
 fYH2nGU6/QSx36fVEdvRW1Ad1elfpdoEMHc0AIyDP1hiEDL3KFJGXWxRQDuAG80su3ZPsUUdLRa
 eo+3OWRdLCE4nRIqbobtmVKkerKjNSnZDmKEyW/MY8gs4jDRZ/55EbRq0guYvWMtLshXjdM7imC
 ROCv3jcJxWGxsnex883RpVcKnJ8tWlL4g2eFVzevsITlslEgZ9CiUzczvw=
X-Google-Smtp-Source: AGHT+IGaUn0Zy2qbg9V4/N1nPp/lD3k/R44Ub7Bk+cBjKBElGANJisWInDwWItjS1Tm3jvdtqfO2SA==
X-Received: by 2002:a17:903:1c1:b0:215:6e28:8260 with SMTP id
 d9443c01a7336-215bd266031mr24705765ad.50.1733232981039; 
 Tue, 03 Dec 2024 05:36:21 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:20 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 6/9] vfio/igd: add macro for declaring mirrored registers
Date: Tue,  3 Dec 2024 21:35:45 +0800
Message-ID: <20241203133548.38252-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

igd devices have multipe registers mirroring mmio address and pci
config space, more than a single BDSM register. To support this,
the read/write functions are made common and a macro is defined to
simplify the declaration of MemoryRegionOps.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 60 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index fea9be0b2d..522845c509 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -418,16 +418,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define IGD_BDSM_MMIO_OFFSET 0x1080C0
-
-static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
-                                          hwaddr addr, unsigned size)
+static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
+                                         unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         return pci_get_byte(vdev->pdev.config + offset);
@@ -438,21 +431,17 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
     case 8:
         return pci_get_quad(vdev->pdev.config + offset);
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config read at %lx, size %u",
+                 offset, size);
         break;
     }
 
     return 0;
 }
 
-static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
+static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
+                                      uint64_t data, unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         pci_set_byte(vdev->pdev.config + offset, data);
@@ -467,17 +456,37 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
         pci_set_quad(vdev->pdev.config + offset, data);
         break;
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config write at %lx, size %u",
+                 offset, size);
         break;
     }
 }
 
-static const MemoryRegionOps vfio_igd_bdsm_quirk = {
-    .read = vfio_igd_quirk_bdsm_read,
-    .write = vfio_igd_quirk_bdsm_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
+static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
+                                           hwaddr addr, unsigned size)  \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
+}                                                                       \
+                                                                        \
+static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
+                                        uint64_t data, unsigned size)   \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
+}                                                                       \
+                                                                        \
+static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
+    .read = vfio_igd_quirk_read_##name,                                 \
+    .write = vfio_igd_quirk_write_##name,                               \
+    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+
+#define IGD_BDSM_MMIO_OFFSET    0x1080C0
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *quirk;
@@ -507,10 +516,11 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     quirk = vfio_quirk_alloc(1);
     quirk->data = vdev;
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
-                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_bdsm, vdev,
+                          "vfio-igd-bdsm-quirk", 8);
     memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
+                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
                                         1);
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
-- 
2.45.2


