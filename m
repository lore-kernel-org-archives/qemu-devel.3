Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0B9D49779
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmep-0006ER-57; Sun, 01 Dec 2024 11:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWJ-0004i5-Tq
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:04 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWH-0000QS-MS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:03 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso2908600b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069400; x=1733674200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xHPgrr8qcitMTkySx0BnFAYVdeofMUqMuEPagNjjfQ=;
 b=eyH7pv+TBTnDK/EJHCMoFYAe3ZCpYu/xx/AF2sOFvYTEG7aRzDUE9h5cnE/6YjTWyK
 R9iBMiV3UD5cXqHhmjZb17+enml5S1FowWlIKb+8VZonE6wTKoz9c1tun7wW3Mk8chZE
 EOJXJM4bWc1RXrgFaw45RuU6sTaDoxSSBLWjnjBwsUI1hpzIJILWL7Cv+8Osef3t2aaj
 bFYXWxqN3koEqDapfQrCBrpKEPumsNILcuwKswLuGovegqjyMsdrGmLhDyGoKGQdXjRN
 o1jWCIrNatQDqSHFwxZSOMQz1g9yfaTK4mfp0yLM8q95i4P3WBjx7l+qCTQ0jtVhUKzh
 TdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069400; x=1733674200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xHPgrr8qcitMTkySx0BnFAYVdeofMUqMuEPagNjjfQ=;
 b=NmJc41dpd1C0umi1i84TSPPSxDpCqevyNrLZjJvTj4DD3EV0ONIVkw6CqFTMlp6P0t
 DioVBhBip+8rJ80/xEkDGW7OjBaD4cC1RvcXcL2aYUT6sT4EytD4YPmpWxXQVY1Opu0Y
 CmQcAmEvgKbvbzGTRsvmuYPZay6t0pYJ6xKTb6l5IPeieXimwkAhevHkD66ptX8PSUXq
 MBR3iIEQ877KVHDpezH+kwdX7Md4d+w2sLpU5Q8y6aBczpgohQp1AEVR7ShH53UVHezE
 R5kFjLrDVt7+9qSraDSSb65LFHvHhTnKEL3T0YZw3N56Ftz5E6mECDjFtBDbetBmZL7u
 v9jQ==
X-Gm-Message-State: AOJu0YygFCsRfPv4R9ytfpysIFWYhT57t15yN5wrIS/YWtrSrSUIZSyo
 AJifC/55fMBtkVMfxq8ScxkvLodiR/EONhGF/aMiKoLwObxto5/bq+HnhcOe8DLX
X-Gm-Gg: ASbGncsQqj1au/wUBO3X9+wbAufN7TihH74JYVhv2t5meokCJNI3kSXcEErCxC9h3pC
 SeolS0SdkNff/xTi16AE3/x1OJS6+H7SvR8n+MKN12R7lArDW2qZP7TFHB6XptEqbGNAK5ELEKc
 j1fuVtxEWrJbwOGZyLHk3yKNeosS6tWIt3AfWKMhyTET7rmuNPXKR/IbWxJWjFA+RwlcIbqy3d8
 riQMViYAhxcW5b0ToHHrnMqtsYQDm0X/sqBBMEq2HntnKwyhw3Mys37ocQ=
X-Google-Smtp-Source: AGHT+IHjOAA4j0Pi/YpwJJaynPCMGXCs9Ny5HGgb8kAtO0HfmxM6BLAtmn2DOuyNLriDf3bogRHxiA==
X-Received: by 2002:a05:6a00:3d0f:b0:724:46eb:c38f with SMTP id
 d2e1a72fcca58-7253017776fmr26437912b3a.25.1733069399648; 
 Sun, 01 Dec 2024 08:09:59 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:59 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 6/8] vfio/igd: emulate GGC register in mmio bar0
Date: Mon,  2 Dec 2024 00:09:36 +0800
Message-ID: <20241201160938.44355-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:42 -0500
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

The GGC register at 0x50 of pci config space is a mirror of the same
register at 0x108040 of mmio bar0 [1]. i915 driver also reads that
register from mmio bar0 instead of config space. As GGC is programmed
and emulated by qemu, the mmio address should also be emulated, in the
same way of BDSM register.

A macro is defined to simplify the declaration of MemoryRegionOps for
a register mirrored to pcie config space.

[1] 4.1.28, 12th Generation Intel Core Processors Datasheet Volume 2
    https://www.intel.com/content/www/us/en/content-details/655259

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 67 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index a86faf2fa9..07700dce30 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -415,16 +415,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
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
@@ -442,14 +435,12 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
     return 0;
 }
 
-static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
-{
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
+#define IGD_GGC_MMIO_OFFSET     0x108040
+#define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
+static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
+                                      uint64_t data, unsigned size)
+{
     switch (size) {
     case 1:
         pci_set_byte(vdev->pdev.config + offset, data);
@@ -464,17 +455,35 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
         pci_set_quad(vdev->pdev.config + offset, data);
         break;
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported write size, %u bytes", size);
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
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *quirk;
@@ -501,13 +510,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = vfio_quirk_alloc(1);
+    quirk = vfio_quirk_alloc(2);
     quirk->data = vdev;
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
-                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_ggc, vdev,
+                          "vfio-igd-ggc-quirk", 2);
+    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
+                                        1);
+
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


