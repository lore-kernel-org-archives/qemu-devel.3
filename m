Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB7DE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 15:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSe2W-0001X8-0O; Tue, 31 Dec 2024 10:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2U-0001Vv-2K
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2S-0004QK-Dv
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2156e078563so117007755ad.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735658407; x=1736263207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVN2qd6MBYuGZQhfybJGo43q8ngHygDWwb5BKByun0A=;
 b=DEYEZxdoG4AhzO6zriaRBs7UeXcSWnDQiQ4mEtXPFAYnn5/Qi25VTRShfjV7gre9cb
 KzCktdl6kp8Kl89rW8hKzBKJ5k34VW6N15WRJlN/oXUPrX0yR676P3YHmRHlseyRvPG2
 McWIEdiSQw0k7jU+d8n59MkCy5f5lwfTtaLWl1dkLV0iXX66LMTk4uX91LCFqP8XbwuP
 ZaLa1KzzMirPbMs+43Dt1P7UpBwnlJkC/xtB7zjbOzSSHn/f51MMIuO/VWtAA1D0b6BB
 8/fBnVtexsH1p2a9BRFxmzVsnrFO+rR5jEe/kaZeoA1xuY2nLAIoZUC52o8h/LHv6D/n
 QLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735658407; x=1736263207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVN2qd6MBYuGZQhfybJGo43q8ngHygDWwb5BKByun0A=;
 b=g1wG2fCIhgP26n9DEroCB8riWiXEcat7MqGKIn0iPXCRkKf1FhQD8Cu+jUy8ROnnN7
 xZqr33smksembHA+t03GMt82o23Phgzejxyqbyufv1qbshsgQR/+6Jt/xC/XeZpTE/P0
 YZAQCvWMaKiF2L0lAr4C70/0Ft4j4HYH+K5NdzR2mwWJ05iKj6xPN9myWKg7gngZunpj
 ko8KbFMcMv/2bQCiFqc5Wn2ZWZFsauOkhMQqx2Yn7hts08U7h+I0U8FZkkt/nmhwcl5D
 YdU38cZKIK8AbDX7uFO93oLN7kuYxmyTW9i4IaBLqociW04D+zm92oLbUceEjwPuTIcB
 39Ng==
X-Gm-Message-State: AOJu0YxQkTrQqCz7tBIh3bMqTEF3428qIti9pSxcr2qZbfR7ylYyxf5V
 3CgIhEZDMJlGN4Xa0UivJjx9PL4kIevQRXv+WWF7qlkxmSsA0EU=
X-Gm-Gg: ASbGncseXmW0XEmrYNS79TOfb6J/faMYrxtJrawn25xoc0YRoSanvX3xisM/Nmsx6H2
 Wa1sJhNsfB9BKbtQOuYJJCQNsIlNZhLZheDKbaDx8tmWIhrS/SDWrwwK1EzEOtfEj7CSvNDMzfa
 P1wpRJ5kM3bpmF20TLsrdu7FfjeqN2ZpGynsKhrLVrERT98saPZi4khBvvvTstyjIgfekB30tMB
 XtwXXYI9CmwdVj1Pf31jVTRJJe7GjHA+3PXQ1UrhzDEYLeXrX1QmxPA79pjsk5J/+NzNQ==
X-Google-Smtp-Source: AGHT+IEVAKNXNn9JwJm4hD2zal5tswDcksS5BRGtbfLV0li4XDXV6Wo1/6qhcYv6n5JSSqD0dhdWEg==
X-Received: by 2002:a05:6a21:78aa:b0:1e1:aef4:9ce8 with SMTP id
 adf61e73a8af0-1e5e080c2femr61703095637.28.1735658406997; 
 Tue, 31 Dec 2024 07:20:06 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309e8sm20933481b3a.43.2024.12.31.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 07:20:06 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 3/3] vfio/igd: use VFIOConfigMirrorQuirk for mirrored registers
Date: Tue, 31 Dec 2024 23:19:53 +0800
Message-ID: <20241231151953.59992-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241231151953.59992-1-tomitamoeko@gmail.com>
References: <20241231151953.59992-1-tomitamoeko@gmail.com>
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

With the introduction of config_offset field, VFIOConfigMirrorQuirk can
now be used for those mirrored register in igd bar0. This eliminates
the need for the macro intoduced in 1a2623b5c9e7 ("vfio/igd: add macro
for declaring mirrored registers").

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 128 ++++++++++++++------------------------------------
 1 file changed, 36 insertions(+), 92 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f5414b0f8d..28a1d17f01 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
+#include "pci-quirks.h"
 #include "trace.h"
 
 /*
@@ -422,84 +423,21 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
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
 
+typedef struct VFIOIGDBAR0Quirk {
+    VFIOConfigMirrorQuirk ggc_mirror;
+    VFIOConfigMirrorQuirk bdsm_mirror;
+} VFIOIGDBAR0Quirk;
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *quirk;
+    VFIOIGDBAR0Quirk *bar0;
+    VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
+    uint32_t bdsm_reg_size;
 
     /*
      * This must be an Intel VGA device at address 00:02.0 for us to even
@@ -523,30 +461,36 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     quirk = vfio_quirk_alloc(2);
-    quirk->data = vdev;
-
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
-                          &vfio_igd_quirk_mirror_ggc, vdev,
+    bar0 = quirk->data = g_malloc0(sizeof(*bar0));
+
+    ggc_mirror = &bar0->ggc_mirror;
+    ggc_mirror->vdev = vdev;
+    ggc_mirror->mem = &quirk->mem[0];
+    ggc_mirror->bar = nr;
+    ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
+    ggc_mirror->config_offset = IGD_GMCH;
+
+    bdsm_mirror = &bar0->bdsm_mirror;
+    bdsm_mirror->mem = &quirk->mem[1];
+    bdsm_mirror->vdev = vdev;
+    bdsm_mirror->offset = IGD_BDSM_MMIO_OFFSET;
+    bdsm_mirror->config_offset = (gen < 11) ? IGD_BDSM : IGD_BDSM_GEN11;
+    bdsm_mirror->bar = nr;
+    bdsm_reg_size = (gen < 11) ? 4 : 8;
+
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
+    memory_region_init_io(bdsm_mirror->mem, OBJECT(vdev),
+                          &vfio_generic_mirror_quirk, bdsm_mirror,
+                          "vfio-igd-bdsm-quirk", bdsm_reg_size);
+    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                        bdsm_mirror->offset, bdsm_mirror->mem,
+                                        1);
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
-- 
2.45.2


