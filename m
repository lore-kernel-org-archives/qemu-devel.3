Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF13E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU6Ia-00035G-2d; Sat, 04 Jan 2025 10:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IR-00033d-FD
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:41 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IO-0000se-IC
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:38 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2164b662090so162170115ad.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736005354; x=1736610154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJfWWZqSXpOdGQmS7KBN222EjjfAcfYazkf7PC9ywok=;
 b=NPv8WNqvnvQqpAioGbpPBApO10Z+KmVe9hKLPMvTY1dGWJAiSNaMmi+iR5wOXJm6Vo
 JdfDYJtE5LBrsR3QQkBLRLHQYs1pV04Lrgu/TmwbzJnwji+W6jVnopYLNY/IjcM0govt
 rplE8vqhPQOvYTrIk+jDB1jZ0DvTHtE71N0Ff6fIXRdaogZZyM/WK3DQxoxdsHy2hS/S
 DWnvCaxR09lZugMJd5a+P7SjZ0ACqsv602ffRCaNsEl/+iu2tXz5ORQzgFFunGGQIgAh
 7WaOWRC9LTZo0h6oio96ZUk+2js7XAuCx1FIlL3e5P8h18V5FmTNdU+PtaUYLP1dLbbY
 rq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736005354; x=1736610154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJfWWZqSXpOdGQmS7KBN222EjjfAcfYazkf7PC9ywok=;
 b=oJIH6bf83umKFnMFVqKTqYpar1v759VpSYmoYvos3vl7PE5MpaEdXuZsOtSdNlNKt5
 ys5HUb2f4bMWOEK4knXRDUz/DpO4JpLnHkKQjxWRrbP5kds7/SFfwDJ9JkrMwI+MV0gl
 rs0sF8DYO9UN80Y6+rtQrjR+OmeOYScxiUPsJmKvSMEo148fNiAZIOmBxrgsesFy6mt1
 Ccnr4ybXYCJ9yiXm3j7f8BddHb9sWdEAB7UWwfL5NiGlccJYQSm/oGg/VdNbelk7KuYf
 OOCJrDsLj1G9/Sm+v8cDjks8kSqxqlTgI7jvyUo68t6DIpPi+ifphM/ZaRCtq7qGdpBa
 WzbA==
X-Gm-Message-State: AOJu0YyU7RhZRNvoxwjkoCq0JZHo5EKSX6uhmhIuwiYqB62o2p0wmwbN
 bTxgUYaIwE1IJczseaNqN7r683UsbDJEpZJXHKjaR5DnYv3pHaY=
X-Gm-Gg: ASbGncvjuS4S2hQTiMlD6YW5Ezq/Tx5dIDSrk1LQIs1owkOZuCz31Xy4pYWmat74GC/
 TzCioxQKaFZ2QYeLnkUbchzWquBxnqa8kXU5I6NVXM3zg4AnYl+dToBUiUe+2e3I93hdoQr39WO
 nca7k5nLUoGhR6Qjft/44zKmrlvlQE/hAh0mUfll3BE3Wqg+Zmb2vPSg9Oqq+B49dy90+vohJ80
 RSfsP72GvqriGAdzF7GLHnKAPxIqC8WwOoIW/DbNxg3hrlwd85RYI69GxNO1LdX1almpA==
X-Google-Smtp-Source: AGHT+IG0l+iGZerOA5g3zmMw14L0XwjLiaum9ie8Si2KeUyAcbislEK9rfWwYUbZ99mMFteaYSci5g==
X-Received: by 2002:a05:6a00:4485:b0:725:c8ea:b320 with SMTP id
 d2e1a72fcca58-72abde0f951mr72748123b3a.14.1736005353950; 
 Sat, 04 Jan 2025 07:42:33 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8162d0sm28113388b3a.12.2025.01.04.07.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2025 07:42:33 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 3/3] vfio/igd: use VFIOConfigMirrorQuirk for mirrored
 registers
Date: Sat,  4 Jan 2025 23:42:18 +0800
Message-ID: <20250104154219.7209-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250104154219.7209-1-tomitamoeko@gmail.com>
References: <20250104154219.7209-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

With the introduction of config_offset field, VFIOConfigMirrorQuirk can
now be used for those mirrored register in igd bar0. This eliminates
the need for the macro intoduced in 1a2623b5c9e7 ("vfio/igd: add macro
for declaring mirrored registers").

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 125 +++++++++++++-------------------------------------
 1 file changed, 31 insertions(+), 94 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f5414b0f8d..703e795715 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
+#include "pci-quirks.h"
 #include "trace.h"
 
 /*
@@ -422,83 +423,13 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
-                                         unsigned size)
-{
-    switch (size) {
-    case 1:
-        return pci_get_byte(vdev->pdev.config + offset);
-    case 2:
-        return pci_get_word(vdev->pdev.config + offset);
-    case 4:
-        return pci_get_long(vdev->pdev.config + offset);
-    case 8:
-        return pci_get_quad(vdev->pdev.config + offset);
-    default:
-        hw_error("igd: unsupported pci config read at %"PRIx64", size %u",
-                 offset, size);
-        break;
-    }
-
-    return 0;
-}
-
-static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
-                                      uint64_t data, unsigned size)
-{
-    switch (size) {
-    case 1:
-        pci_set_byte(vdev->pdev.config + offset, data);
-        break;
-    case 2:
-        pci_set_word(vdev->pdev.config + offset, data);
-        break;
-    case 4:
-        pci_set_long(vdev->pdev.config + offset, data);
-        break;
-    case 8:
-        pci_set_quad(vdev->pdev.config + offset, data);
-        break;
-    default:
-        hw_error("igd: unsupported pci config write at %"PRIx64", size %u",
-                 offset, size);
-        break;
-    }
-}
-
-#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
-static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
-                                           hwaddr addr, unsigned size)  \
-{                                                                       \
-    VFIOPCIDevice *vdev = opaque;                                       \
-                                                                        \
-    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
-}                                                                       \
-                                                                        \
-static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
-                                        uint64_t data, unsigned size)   \
-{                                                                       \
-    VFIOPCIDevice *vdev = opaque;                                       \
-                                                                        \
-    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
-}                                                                       \
-                                                                        \
-static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
-    .read = vfio_igd_quirk_read_##name,                                 \
-    .write = vfio_igd_quirk_write_##name,                               \
-    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
-};
-
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
-
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    VFIOQuirk *quirk;
+    VFIOQuirk *ggc_quirk, *bdsm_quirk;
+    VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
     /*
@@ -522,33 +453,39 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = vfio_quirk_alloc(2);
-    quirk->data = vdev;
+    ggc_quirk = vfio_quirk_alloc(1);
+    ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
+    ggc_mirror->mem = ggc_quirk->mem;
+    ggc_mirror->vdev = vdev;
+    ggc_mirror->bar = nr;
+    ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
+    ggc_mirror->config_offset = IGD_GMCH;
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
-                          &vfio_igd_quirk_mirror_ggc, vdev,
+    memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
+                          &vfio_generic_mirror_quirk, ggc_mirror,
                           "vfio-igd-ggc-quirk", 2);
-    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
+    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                        ggc_mirror->offset, ggc_mirror->mem,
                                         1);
 
-    if (gen < 11) {
-        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
-                              &vfio_igd_quirk_mirror_bdsm, vdev,
-                              "vfio-igd-bdsm-quirk", 4);
-        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                            IGD_BDSM_MMIO_OFFSET,
-                                            &quirk->mem[1], 1);
-    } else {
-        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
-                              &vfio_igd_quirk_mirror_bdsm64, vdev,
-                              "vfio-igd-bdsm-quirk", 8);
-        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                            IGD_BDSM_MMIO_OFFSET,
-                                            &quirk->mem[1], 1);
-    }
+    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
 
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
+    bdsm_quirk = vfio_quirk_alloc(1);
+    bdsm_mirror = bdsm_quirk->data = g_malloc0(sizeof(*bdsm_mirror));
+    bdsm_mirror->mem = bdsm_quirk->mem;
+    bdsm_mirror->vdev = vdev;
+    bdsm_mirror->bar = nr;
+    bdsm_mirror->offset = IGD_BDSM_MMIO_OFFSET;
+    bdsm_mirror->config_offset = (gen < 11) ? IGD_BDSM : IGD_BDSM_GEN11;
+
+    memory_region_init_io(bdsm_mirror->mem, OBJECT(vdev),
+                          &vfio_generic_mirror_quirk, bdsm_mirror,
+                          "vfio-igd-bdsm-quirk", (gen < 11) ? 4 : 8);
+    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                        bdsm_mirror->offset, bdsm_mirror->mem,
+                                        1);
+
+    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
-- 
2.45.2


