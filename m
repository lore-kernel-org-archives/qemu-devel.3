Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E261C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNZx-0003D4-B0; Fri, 09 May 2025 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNZ1-0002PR-N2
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYy-0007Ec-SK
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HisD7F+n0YQRQAJHKMQy689CXMethJ5xHSYlbFgCquc=;
 b=DhR5qj73N9qFSQ2EQxRBVasOU//t0wF5NOVl9R08YMjCov6GZIXMuO5CouQQhcuLHkbRwT
 s0Ec8zoDwR8HR4mjmSASH3mg5x+DMLZbrQQeESwJzcq47M3f/yk/w+Y6GDLKP3ZufHDIgb
 mNbgXhFIy5hRqnurb5wci04AgcJO/V8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-qhEVWJynNXaLEXNI9MEY7g-1; Fri,
 09 May 2025 09:14:48 -0400
X-MC-Unique: qhEVWJynNXaLEXNI9MEY7g-1
X-Mimecast-MFC-AGG-ID: qhEVWJynNXaLEXNI9MEY7g_1746796487
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BDE180087F; Fri,  9 May 2025 13:14:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85663180045B; Fri,  9 May 2025 13:14:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/28] vfio: add read/write to device IO ops vector
Date: Fri,  9 May 2025 15:13:15 +0200
Message-ID: <20250509131317.164235-27-clg@redhat.com>
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

Now we have the region info cache, add ->region_read/write device I/O
operations instead of explicit pread()/pwrite() system calls.

Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-13-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 18 ++++++++++++++++++
 hw/vfio/device.c              | 34 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 28 ++++++++++++++--------------
 hw/vfio/region.c              | 17 +++++++++++------
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4fff3dcee3b4a2a3c8a4bd6fa017cf822a16668e..8bcb3c19f62b5a47c835e10149c04a9bd7536520 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -188,6 +188,24 @@ struct VFIODeviceIOOps {
      * Configure IRQs as defined by @irqs.
      */
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+
+    /**
+     * @region_read
+     *
+     * Read @size bytes from the region @nr at offset @off into the buffer
+     * @data.
+     */
+    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                       void *data);
+
+    /**
+     * @region_write
+     *
+     * Write @size bytes to the region @nr at offset @off from the buffer
+     * @data.
+     */
+    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                        void *data);
 };
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 77b0675abe7b4f4155ea79cf3fd0e3ab4b21f8ea..0b2cd90d64dc797bb2f20c60c57ff49706816aed 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -505,9 +505,43 @@ static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
     return ret < 0 ? -errno : ret;
 }
 
+static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                      off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, index, &info);
+    if (ret != 0) {
+        return ret;
+    }
+
+    ret = pread(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                       off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, index, &info);
+    if (ret != 0) {
+        return ret;
+    }
+
+    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
 static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
     .get_irq_info = vfio_device_io_get_irq_info,
     .set_irqs = vfio_device_io_set_irqs,
+    .region_read = vfio_device_io_region_read,
+    .region_write = vfio_device_io_region_write,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9136cf52c82711939db01c09a8a1277327bc484f..1236de315d1a73aa408c108e2e650a37b037b93e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -918,18 +918,22 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vbasedev->fd, vdev->rom + off,
-                      size, vdev->rom_offset + off);
+        bytes = vbasedev->io_ops->region_read(vbasedev,
+                                              VFIO_PCI_ROM_REGION_INDEX,
+                                              off, size, vdev->rom + off);
+
         if (bytes == 0) {
             break;
         } else if (bytes > 0) {
             off += bytes;
             size -= bytes;
         } else {
-            if (errno == EINTR || errno == EAGAIN) {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %m");
+            error_report("vfio: Error reading device ROM: %s",
+                         strreaderror(bytes));
+
             break;
         }
     }
@@ -969,22 +973,18 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
                                       uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
+                                              VFIO_PCI_CONFIG_REGION_INDEX,
+                                              offset, size, data);
 }
 
 /* "Raw" write of underlying config space. */
 static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
                                        uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
+                                               VFIO_PCI_CONFIG_REGION_INDEX,
+                                               offset, size, data);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ef2630cac3924fef200b2ece1be0dbad219dd67d..34752c3f65c4b43fc961754657b18f5269c01ef1 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -45,6 +45,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint32_t dword;
         uint64_t qword;
     } buf;
+    int ret;
 
     switch (size) {
     case 1:
@@ -64,11 +65,13 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
+                                         addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
+                     ",%d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, data, size);
+                     addr, data, size, strwriteerror(ret));
     }
 
     trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
@@ -96,11 +99,13 @@ uint64_t vfio_region_read(void *opaque,
         uint64_t qword;
     } buf;
     uint64_t data = 0;
+    int ret;
 
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+    ret = vbasedev->io_ops->region_read(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, size);
+                     addr, size, strreaderror(ret));
         return (uint64_t)-1;
     }
     switch (size) {
-- 
2.49.0


