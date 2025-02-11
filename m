Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C70C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKu-0006Tl-7n; Tue, 11 Feb 2025 09:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKr-0006TB-3r
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKo-0001t8-PK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuZgyJJ6uzrMusuF8NKNoMLEnL5jN1exIdsO7K2P/NI=;
 b=aIPwXz9Pky2OVHaSLqTg/zGg8EsUOHNmBkT5IBrFLKZpxwHVkMkrW/fusx1N5IwNrwWO3+
 gfIMvejrFRfdWcZAXQxc6Q2yT+elCDEdGmZIDvvcl3GneAbpIxICfkrbIMUhBI/t36G+8c
 i42CYDMDq52FXBX6TlUZg0YNqXNVgTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-ieB-94FdPpOq7OQIHRLixQ-1; Tue,
 11 Feb 2025 09:33:56 -0500
X-MC-Unique: ieB-94FdPpOq7OQIHRLixQ-1
X-Mimecast-MFC-AGG-ID: ieB-94FdPpOq7OQIHRLixQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A99A91800360; Tue, 11 Feb 2025 14:33:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38F0E1800115; Tue, 11 Feb 2025 14:33:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/12] vfio/igd: use VFIOConfigMirrorQuirk for mirrored
 registers
Date: Tue, 11 Feb 2025 15:33:32 +0100
Message-ID: <20250211143340.787996-5-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tomita Moeko <tomitamoeko@gmail.com>

With the introduction of config_offset field, VFIOConfigMirrorQuirk can
now be used for those mirrored register in igd bar0. This eliminates
the need for the macro intoduced in 1a2623b5c9e7 ("vfio/igd: add macro
for declaring mirrored registers").

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20250104154219.7209-4-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 125 +++++++++++++-------------------------------------
 1 file changed, 31 insertions(+), 94 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b5303ea565d6a344d0a43273f288bbb4a7f48327..b1a237edd6608aab71c03036abef5c5d3cbcf12f 100644
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
2.48.1


