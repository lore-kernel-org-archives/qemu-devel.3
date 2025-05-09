Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BE0C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNa9-00049j-0Z; Fri, 09 May 2025 09:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYe-0001ws-UB
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYb-0007As-8I
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8A8+KNUoabK6pQMh0GdBRZj24kITmDWlYavmbgCcywM=;
 b=FANvqPDK6BQ+3/u+kCXj4ZZI1XE+1Z0JG2zxepJqLB1xa++G7Fh4aghde3UA0O1Euau2Qw
 hiZnGm+kgACG3gg/aD6UqMg++3l0YPNCzByZVr9bTuw4f8F1M3HHst6CAje1c2bm+BjpRD
 UWOAw2WutF54H4AnKVRRO7FGdRVGo8U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-GYFhTKAsMVCynKLx5YiUxg-1; Fri,
 09 May 2025 09:14:26 -0400
X-MC-Unique: GYFhTKAsMVCynKLx5YiUxg-1
X-Mimecast-MFC-AGG-ID: GYFhTKAsMVCynKLx5YiUxg_1746796465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F6D31800370; Fri,  9 May 2025 13:14:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B50218003FD; Fri,  9 May 2025 13:14:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/28] vfio: consistently handle return value for helpers
Date: Fri,  9 May 2025 15:13:08 +0200
Message-ID: <20250509131317.164235-20-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Various bits of code that call vfio device APIs should consistently use
the "return -errno" approach for passing errors back, rather than
presuming errno is (still) set correctly.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-6-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5ccfc67aef6e1653dcf47c88d53265072c7a95c6..866cf58d04600cdd5394a52e0ebe9dd7bb41a1c6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -398,7 +398,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -459,7 +459,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 
     g_free(irq_set);
 
-    return ret;
+    return ret < 0 ? -errno : ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
@@ -581,7 +581,8 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
             if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
+                error_report("vfio: failed to enable vectors, %s",
+                             strerror(-ret));
             }
         } else {
             Error *err = NULL;
@@ -695,7 +696,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     if (vdev->nr_vectors) {
         ret = vfio_enable_vectors(vdev, true);
         if (ret) {
-            error_report("vfio: failed to enable vectors, %d", ret);
+            error_report("vfio: failed to enable vectors, %s",
+                         strerror(-ret));
         }
     } else {
         /*
@@ -712,7 +714,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
          */
         ret = vfio_enable_msix_no_vec(vdev);
         if (ret) {
-            error_report("vfio: failed to enable MSI-X, %d", ret);
+            error_report("vfio: failed to enable MSI-X, %s",
+                         strerror(-ret));
         }
     }
 
@@ -765,7 +768,8 @@ retry:
     ret = vfio_enable_vectors(vdev, false);
     if (ret) {
         if (ret < 0) {
-            error_report("vfio: Error: Failed to setup MSI fds: %m");
+            error_report("vfio: Error: Failed to setup MSI fds: %s",
+                         strerror(-ret));
         } else {
             error_report("vfio: Error: Failed to enable %d "
                          "MSI vectors, retry with %d", vdev->nr_vectors, ret);
@@ -882,17 +886,21 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_region_info *reg_info = NULL;
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
+                                      &reg_info);
 
-    if (vfio_device_get_region_info(&vdev->vbasedev,
-                                    VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
-        error_report("vfio: Error getting ROM info: %m");
+    if (ret != 0) {
+        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
         return;
     }
 
-    trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
+    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
                             (unsigned long)reg_info->offset,
                             (unsigned long)reg_info->flags);
 
@@ -901,8 +909,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 
     if (!vdev->rom_size) {
         vdev->rom_read_failed = true;
-        error_report("vfio-pci: Cannot read device rom at "
-                    "%s", vdev->vbasedev.name);
+        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
         error_printf("Device option ROM contents are probably invalid "
                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
                     "or load from file with romfile=\n");
@@ -913,7 +920,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
+        bytes = pread(vbasedev->fd, vdev->rom + off,
                       size, vdev->rom_offset + off);
         if (bytes == 0) {
             break;
-- 
2.49.0


