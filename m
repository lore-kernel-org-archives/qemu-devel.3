Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09085CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9L-0007pu-O2; Mon, 08 Sep 2025 12:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9I-0007kb-OX
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf96-0001rI-PN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AUWhOBpLxOP0IIjacLsrZ3xebJZ3z7XCAI19qfRF2k=;
 b=GKW+lffbbVCtfP/wdNao/AXA7MBLtPI0Ep6uICbH+8LXaJHunnrZ5xWqmDJGEY0RS+ACtX
 aiYyeyHtLTm9PJ9242wh4b9b3oqfboD4VJPjpiKbp5/mEwI99v1A3zM55bymajkZGAGxrd
 NcDocEx4xEGhx6TMru/Px5DJrGcprew=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-W6IGJ274MUaWbJz82vUqLA-1; Mon,
 08 Sep 2025 12:55:08 -0400
X-MC-Unique: W6IGJ274MUaWbJz82vUqLA-1
X-Mimecast-MFC-AGG-ID: W6IGJ274MUaWbJz82vUqLA_1757350507
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB7E819560B0; Mon,  8 Sep 2025 16:55:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57F8530001A4; Mon,  8 Sep 2025 16:55:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/31] vfio/pci-quirks.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:49 +0200
Message-ID: <20250908165354.1731444-27-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-18-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci-quirks.c | 48 ++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 3f002252acfb7ac809107c99bdbdbaf66d56a50d..c97606dbf194d48c80b93acdd7a75bbbb475b8f2 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -113,6 +113,7 @@ static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
 {
     VFIOConfigWindowQuirk *window = opaque;
     VFIOPCIDevice *vdev = window->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint64_t data;
 
     /* Always read data reg, discard if window enabled */
@@ -120,7 +121,7 @@ static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
                             addr + window->data_offset, size);
 
     if (window->window_enabled) {
-        data = vfio_pci_read_config(&vdev->pdev, window->address_val, size);
+        data = vfio_pci_read_config(pdev, window->address_val, size);
         trace_vfio_quirk_generic_window_data_read(vdev->vbasedev.name,
                                     memory_region_name(window->data_mem), data);
     }
@@ -133,9 +134,10 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
 {
     VFIOConfigWindowQuirk *window = opaque;
     VFIOPCIDevice *vdev = window->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (window->window_enabled) {
-        vfio_pci_write_config(&vdev->pdev, window->address_val, data, size);
+        vfio_pci_write_config(pdev, window->address_val, data, size);
         trace_vfio_quirk_generic_window_data_write(vdev->vbasedev.name,
                                     memory_region_name(window->data_mem), data);
         return;
@@ -156,6 +158,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
 {
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint64_t data;
 
     /* Read and discard in case the hardware cares */
@@ -163,7 +166,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
                            addr + mirror->offset, size);
 
     addr += mirror->config_offset;
-    data = vfio_pci_read_config(&vdev->pdev, addr, size);
+    data = vfio_pci_read_config(pdev, addr, size);
     trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
                                          memory_region_name(mirror->mem),
                                          addr, data);
@@ -175,9 +178,10 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
 {
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     addr += mirror->config_offset;
-    vfio_pci_write_config(&vdev->pdev, addr, data, size);
+    vfio_pci_write_config(pdev, addr, data, size);
     trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
                                           memory_region_name(mirror->mem),
                                           addr, data);
@@ -211,7 +215,8 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
                                         hwaddr addr, unsigned size)
 {
     VFIOPCIDevice *vdev = opaque;
-    uint64_t data = vfio_pci_read_config(&vdev->pdev,
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint64_t data = vfio_pci_read_config(pdev,
                                          PCI_BASE_ADDRESS_4 + 1, size);
 
     trace_vfio_quirk_ati_3c3_read(vdev->vbasedev.name, data);
@@ -563,6 +568,7 @@ static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
 {
     VFIONvidia3d0Quirk *quirk = opaque;
     VFIOPCIDevice *vdev = quirk->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIONvidia3d0State old_state = quirk->state;
     uint64_t data = vfio_vga_read(&vdev->vga->region[QEMU_PCI_VGA_IO_HI],
                                   addr + 0x10, size);
@@ -573,7 +579,7 @@ static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
         (quirk->offset & ~(PCI_CONFIG_SPACE_SIZE - 1)) == 0x1800) {
         uint8_t offset = quirk->offset & (PCI_CONFIG_SPACE_SIZE - 1);
 
-        data = vfio_pci_read_config(&vdev->pdev, offset, size);
+        data = vfio_pci_read_config(pdev, offset, size);
         trace_vfio_quirk_nvidia_3d0_read(vdev->vbasedev.name,
                                          offset, size, data);
     }
@@ -586,6 +592,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
 {
     VFIONvidia3d0Quirk *quirk = opaque;
     VFIOPCIDevice *vdev = quirk->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIONvidia3d0State old_state = quirk->state;
 
     quirk->state = NONE;
@@ -599,7 +606,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
         if ((quirk->offset & ~(PCI_CONFIG_SPACE_SIZE - 1)) == 0x1800) {
             uint8_t offset = quirk->offset & (PCI_CONFIG_SPACE_SIZE - 1);
 
-            vfio_pci_write_config(&vdev->pdev, offset, data, size);
+            vfio_pci_write_config(pdev, offset, data, size);
             trace_vfio_quirk_nvidia_3d0_write(vdev->vbasedev.name,
                                               offset, data, size);
             return;
@@ -815,7 +822,7 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
 {
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     LastDataSet *last = (LastDataSet *)&mirror->data;
 
     vfio_generic_quirk_mirror_write(opaque, addr, data, size);
@@ -1005,6 +1012,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
 {
     VFIOrtl8168Quirk *rtl = opaque;
     VFIOPCIDevice *vdev = rtl->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     rtl->enabled = false;
 
@@ -1013,7 +1021,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
         rtl->addr = (uint32_t)data;
 
         if (data & 0x80000000U) { /* Do write */
-            if (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX) {
+            if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
                 hwaddr offset = data & 0xfff;
                 uint64_t val = rtl->data;
 
@@ -1021,7 +1029,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
                                                     (uint16_t)offset, val);
 
                 /* Write to the proper guest MSI-X table instead */
-                memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
+                memory_region_dispatch_write(&pdev->msix_table_mmio,
                                              offset, val,
                                              size_memop(size) | MO_LE,
                                              MEMTXATTRS_UNSPECIFIED);
@@ -1049,11 +1057,12 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
 {
     VFIOrtl8168Quirk *rtl = opaque;
     VFIOPCIDevice *vdev = rtl->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint64_t data = vfio_region_read(&vdev->bars[2].region, addr + 0x70, size);
 
-    if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
+    if (rtl->enabled && (pdev->cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
-        memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
+        memory_region_dispatch_read(&pdev->msix_table_mmio, offset,
                                     &data, size_memop(size) | MO_LE,
                                     MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
@@ -1297,7 +1306,7 @@ static void vfio_radeon_set_gfx_only_reset(VFIOPCIDevice *vdev)
 
 static int vfio_radeon_reset(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i, ret = 0;
     uint32_t data;
 
@@ -1454,7 +1463,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
 static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, pos;
     bool c8_conflict = false, d4_conflict = false;
     uint8_t tmp;
@@ -1547,6 +1556,7 @@ static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t membar_phys[16];
     int ret, pos = 0xE8;
 
@@ -1565,7 +1575,7 @@ static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
+    ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos,
                              VMD_SHADOW_CAP_LEN, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
@@ -1574,10 +1584,10 @@ static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 
     memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
     pos += PCI_CAP_FLAGS;
-    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_LEN);
-    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_VER);
-    pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
-    memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
+    pci_set_byte(pdev->config + pos++, VMD_SHADOW_CAP_LEN);
+    pci_set_byte(pdev->config + pos++, VMD_SHADOW_CAP_VER);
+    pci_set_long(pdev->config + pos, 0x53484457); /* SHDW */
+    memcpy(pdev->config + pos + 4, membar_phys, 16);
 
     return true;
 }
-- 
2.51.0


