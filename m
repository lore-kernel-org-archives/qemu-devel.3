Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF30C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNaD-0004TH-G7; Fri, 09 May 2025 09:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYn-0002A4-4C
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYi-0007Ca-Ku
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bvk84yl/FmZPDL6jOhBGgTvG2RSzwdYW1YladsMdMaU=;
 b=LnhUhBQX0NDOR6yIjaHRSuxTxfWTIS3XTaEn5ymAne24zvPCJjMRKkvTK8MbD4Ss3225P0
 Y8Ozl67A7udC1qBO751Vi6JNtutVMCSkSReChClj2AGPnxDeeexyq9gsewgOylNhM6LFcd
 qALajpBtJY55WemOT6rL7Wom0CBIUyY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-Nlt35tPuNXevhPMQsIuZLA-1; Fri,
 09 May 2025 09:14:32 -0400
X-MC-Unique: Nlt35tPuNXevhPMQsIuZLA-1
X-Mimecast-MFC-AGG-ID: Nlt35tPuNXevhPMQsIuZLA_1746796471
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F17B1800446; Fri,  9 May 2025 13:14:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47CD71800EC9; Fri,  9 May 2025 13:14:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/28] vfio: add vfio_pci_config_space_read/write()
Date: Fri,  9 May 2025 15:13:10 +0200
Message-ID: <20250509131317.164235-22-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

Add these helpers that access config space and return an -errno style
return.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-8-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 123 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 866cf58d04600cdd5394a52e0ebe9dd7bb41a1c6..f65c9463ce0350e6a1962309da21e96d1aa6cfdd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -967,6 +967,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     }
 }
 
+/* "Raw" read of underlying config space. */
+static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                                      uint32_t size, void *data)
+{
+    ssize_t ret;
+
+    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
+
+    return ret < 0 ? -errno : (int)ret;
+}
+
+/* "Raw" write of underlying config space. */
+static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                       uint32_t size, void *data)
+{
+    ssize_t ret;
+
+    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
+
+    return ret < 0 ? -errno : (int)ret;
+}
+
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 {
     VFIOPCIDevice *vdev = opaque;
@@ -1019,10 +1041,9 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
     char *name;
-    int fd = vdev->vbasedev.fd;
 
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
@@ -1039,11 +1060,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
      * Use the same size ROM BAR as the physical device.  The contents
      * will get filled in later when the guest tries to read it.
      */
-    if (pread(fd, &orig, 4, offset) != 4 ||
-        pwrite(fd, &size, 4, offset) != 4 ||
-        pread(fd, &size, 4, offset) != 4 ||
-        pwrite(fd, &orig, 4, offset) != 4) {
-        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
+    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
+
+        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
         return;
     }
 
@@ -1223,6 +1245,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1235,12 +1258,12 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
         ssize_t ret;
 
-        ret = pread(vdev->vbasedev.fd, &phys_val, len,
-                    vdev->config_offset + addr);
+        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
         if (ret != len) {
-            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
-                         __func__, vdev->vbasedev.name, addr, len);
-            return -errno;
+            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
+                         __func__, vbasedev->name, addr, len,
+                         strreaderror(ret));
+            return -1;
         }
         phys_val = le32_to_cpu(phys_val);
     }
@@ -1256,15 +1279,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
+    int ret;
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
 
     /* Write everything to VFIO, let it filter out what we can't write */
-    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
-                != len) {
-        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
-                     __func__, vdev->vbasedev.name, addr, val, len);
+    ret = vfio_pci_config_space_write(vdev, addr, len, &val_le);
+    if (ret != len) {
+        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
+                     __func__, vbasedev->name, addr, val, len,
+                    strwriteerror(ret));
     }
 
     /* MSI/MSI-X Enabling/Disabling */
@@ -1352,9 +1378,11 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret, entries;
     Error *err = NULL;
 
-    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_CAP_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS: %s",
+                   strreaderror(ret));
         return false;
     }
     ctrl = le16_to_cpu(ctrl);
@@ -1561,30 +1589,35 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
-    int ret, fd = vdev->vbasedev.fd;
     struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
+    int ret;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
 
-    if (pread(fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        error_setg(errp, "failed to read PCI MSIX FLAGS: %s",
+                   strreaderror(ret));
         return false;
     }
 
-    if (pread(fd, &table, sizeof(table),
-              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_TABLE,
+                                     sizeof(table), &table);
+    if (ret != sizeof(table)) {
+        error_setg(errp, "failed to read PCI MSIX TABLE: %s",
+                   strreaderror(ret));
         return false;
     }
 
-    if (pread(fd, &pba, sizeof(pba),
-              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_PBA,
+                                     sizeof(pba), &pba);
+    if (ret != sizeof(pba)) {
+        error_setg(errp, "failed to read PCI MSIX PBA: %s", strreaderror(ret));
         return false;
     }
 
@@ -1744,10 +1777,10 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Determine what type of BAR this is for registration */
-    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
-                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
+    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
+                                     sizeof(pci_bar), &pci_bar);
     if (ret != sizeof(pci_bar)) {
-        error_report("vfio: Failed to read BAR %d (%m)", nr);
+        error_report("vfio: Failed to read BAR %d: %s", nr, strreaderror(ret));
         return;
     }
 
@@ -2450,21 +2483,23 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
 void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     Error *err = NULL;
-    int nr;
+    int ret, nr;
 
     if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
-        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
+        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
         uint32_t val = 0;
         uint32_t len = sizeof(val);
 
-        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
-            error_report("%s(%s) reset bar %d failed: %m", __func__,
-                         vdev->vbasedev.name, nr);
+        ret = vfio_pci_config_space_write(vdev, addr, len, &val);
+        if (ret != len) {
+            error_report("%s(%s) reset bar %d failed: %s", __func__,
+                         vbasedev->name, nr, strwriteerror(ret));
         }
     }
 
@@ -3101,6 +3136,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     int i, ret;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
+    uint32_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3155,13 +3191,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+
     /* Get a copy of config space */
-    ret = pread(vbasedev->fd, vdev->pdev.config,
-                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
-                vdev->config_offset);
-    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
-        ret = ret < 0 ? -errno : -EFAULT;
-        error_setg_errno(errp, -ret, "failed to read device config space");
+    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
+                                     vdev->pdev.config);
+    if (ret < (int)config_space_size) {
+        ret = ret < 0 ? -ret : EFAULT;
+        error_setg_errno(errp, ret, "failed to read device config space");
         goto error;
     }
 
-- 
2.49.0


