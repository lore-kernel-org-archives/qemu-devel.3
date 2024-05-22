Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25586C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihZ-0005dz-7E; Wed, 22 May 2024 05:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihV-0005LN-I9
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihT-0001wn-NJ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bI8EFdfj0J9kzuJuVZ6pxe0myBd7KeFUuEsMYCohD7w=;
 b=RgnPb2+owFArqCQLuar6fQg+E+nr7m+AW7x2z5xX/iBF0RnY2HPNsSc6b1MUomK1QQHgqb
 FpQJKW52I9L0Aerk8Kfz+a2pR2uw97b5ZHrRYKbSel5hbt83EBV7vOVjNoyuS/0QsanjWp
 bOdxZfDFM0rHkbZXshME9ZQD0IG3nsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-In4WNdwxMkmTp_leCLrxiw-1; Wed, 22 May 2024 05:55:54 -0400
X-MC-Unique: In4WNdwxMkmTp_leCLrxiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94FA5101A52C;
 Wed, 22 May 2024 09:55:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7420551BF;
 Wed, 22 May 2024 09:55:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 46/47] vfio: Use g_autofree in all call site of
 vfio_get_region_info()
Date: Wed, 22 May 2024 11:54:41 +0200
Message-ID: <20240522095442.195243-47-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

There are some exceptions when pointer to vfio_region_info is reused.
In that case, the pointed memory is freed manually.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.c |  7 ++-----
 hw/vfio/igd.c     |  5 ++---
 hw/vfio/pci.c     | 13 +++----------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4b079dc383683a71d1d96507a0fb66a4bc3ba923..27ea26aa48f67e6518f871ac651ab8d2703cc611 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -343,7 +343,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    struct vfio_region_info *info;
+    g_autofree struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, index, &info);
@@ -376,8 +376,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
         }
     }
 
-    g_free(info);
-
     trace_vfio_region_setup(vbasedev->name, index, name,
                             region->flags, region->fd_offset, region->size);
     return 0;
@@ -594,14 +592,13 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    struct vfio_region_info *info = NULL;
+    g_autofree struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_get_region_info(vbasedev, region, &info)) {
         if (vfio_get_region_info_cap(info, cap_type)) {
             ret = true;
         }
-        g_free(info);
     }
 
     return ret;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 402fc5ce1da966fda1340f328e0611cb1a2a0635..1e79202f2bd136b0bafd4f08c2f1407e467e0d65 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -367,8 +367,8 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    struct vfio_region_info *rom = NULL, *opregion = NULL,
-                            *host = NULL, *lpc = NULL;
+    g_autofree struct vfio_region_info *rom = NULL;
+    struct vfio_region_info *opregion = NULL, *host = NULL, *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
@@ -609,7 +609,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
 
 out:
-    g_free(rom);
     g_free(opregion);
     g_free(host);
     g_free(lpc);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 35ad9b582f6b99510a812edab5c2855c697a1da2..74a79bdf61f9aeb4860d532b6c076dd3491dd0ab 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    struct vfio_region_info *reg_info;
+    g_autofree struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -897,8 +897,6 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     vdev->rom_size = size = reg_info->size;
     vdev->rom_offset = reg_info->offset;
 
-    g_free(reg_info);
-
     if (!vdev->rom_size) {
         vdev->rom_read_failed = true;
         error_report("vfio-pci: Cannot read device rom at "
@@ -2668,7 +2666,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    struct vfio_region_info *reg_info;
+    g_autofree struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2685,7 +2683,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
         error_setg(errp, "unexpected VGA info, flags 0x%lx, size 0x%lx",
                    (unsigned long)reg_info->flags,
                    (unsigned long)reg_info->size);
-        g_free(reg_info);
         return false;
     }
 
@@ -2694,8 +2691,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     vdev->vga->fd_offset = reg_info->offset;
     vdev->vga->fd = vdev->vbasedev.fd;
 
-    g_free(reg_info);
-
     vdev->vga->region[QEMU_PCI_VGA_MEM].offset = QEMU_PCI_VGA_MEM_BASE;
     vdev->vga->region[QEMU_PCI_VGA_MEM].nr = QEMU_PCI_VGA_MEM;
     QLIST_INIT(&vdev->vga->region[QEMU_PCI_VGA_MEM].quirks);
@@ -2736,7 +2731,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    struct vfio_region_info *reg_info;
+    g_autofree struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
     int i, ret = -1;
 
@@ -2790,8 +2785,6 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     }
     vdev->config_offset = reg_info->offset;
 
-    g_free(reg_info);
-
     if (vdev->features & VFIO_FEATURE_ENABLE_VGA) {
         if (!vfio_populate_vga(vdev, errp)) {
             error_append_hint(errp, "device does not support "
-- 
2.45.1


