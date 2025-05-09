Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B8AC3ABCE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNaN-0005CJ-7a; Fri, 09 May 2025 09:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYf-0001wv-5J
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYc-0007BO-0M
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGkPGUSZMhIMr4dT/QB+Dd0huVnEKb4u0dhAGyLD1bs=;
 b=Lfb/FCO1AcBlYlQ42KOvY9an/yj6wvOkP2FdszWLit5A2sPLyUDE2PQa7RWgW4gPt3paJB
 KTx08jZ2cOBa2PJYQL8gKwuCg7F1rM4NnTPNnTKTvwbJHslvpjXyeyNr6gN+u8DoUWTqw1
 PA0Fgi6wfPvJCz3W9pC61OwRJVZssdE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-zcDR27mUMkeavKly0y1qow-1; Fri,
 09 May 2025 09:14:22 -0400
X-MC-Unique: zcDR27mUMkeavKly0y1qow-1
X-Mimecast-MFC-AGG-ID: zcDR27mUMkeavKly0y1qow_1746796462
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F20AB1956069; Fri,  9 May 2025 13:14:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36CA418003FD; Fri,  9 May 2025 13:14:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/28] vfio: add vfio_device_get_irq_info() helper
Date: Fri,  9 May 2025 15:13:07 +0200
Message-ID: <20250509131317.164235-19-clg@redhat.com>
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

Add a helper similar to vfio_device_get_region_info() and use it
everywhere.

Replace a couple of needless allocations with stack variables.

As a side-effect, this fixes a minor error reporting issue in the call
from vfio_msix_early_setup().

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-5-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  3 +++
 hw/vfio/ap.c                  | 19 ++++++++++---------
 hw/vfio/ccw.c                 | 20 +++++++++++---------
 hw/vfio/device.c              | 15 +++++++++++++++
 hw/vfio/pci.c                 | 23 +++++++++++------------
 hw/vfio/platform.c            |  6 +++---
 6 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8b1437ba6654d08f65740f42dc3a50775d7f5cc1..a7eaaa31e7e98a1ec73eefde0d935842ef9da401 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -147,6 +147,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info);
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
+
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                                struct vfio_irq_info *info);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 1207c08d8d94dc6b9004725f8e266c2ec4d04105..785c0a019754a436c59357cf957c4dc6f81ba578 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -74,10 +74,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
     int fd;
-    size_t argsz;
+    int ret;
     IOHandler *fd_read;
     EventNotifier *notifier;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
+    struct vfio_irq_info irq_info;
     VFIODevice *vdev = &vapdev->vdev;
 
     switch (irq) {
@@ -96,14 +96,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
 
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    if (irq_info.count < 1) {
+        error_setg(errp, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index fde0c3fbef3ca2204381c8ee6d07b502d2160e63..ab3fabf991c35abb6c40d925f526c2a2d8955aef 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
-    size_t argsz;
+    struct vfio_irq_info irq_info;
+    int ret;
     int fd;
     EventNotifier *notifier;
     IOHandler *fd_read;
@@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
+
+    if (irq_info.count < 1) {
+        error_setg(errp, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9673b0717ead435e117d8084720fde4ba3a13dd8..5d837092cba2c35ad17d93dd5c3627d83defc818 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     return false;
 }
 
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                             struct vfio_irq_info *info)
+{
+    int ret;
+
+    memset(info, 0, sizeof(*info));
+
+    info->argsz = sizeof(*info);
+    info->index = index;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e1fab21b47adb4df9b011b3efb6d7c15c84bc8c2..5ccfc67aef6e1653dcf47c88d53265072c7a95c6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint16_t ctrl;
     uint32_t table, pba;
     int ret, fd = vdev->vbasedev.fd;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
@@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
@@ -2736,7 +2736,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     g_autofree struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2797,12 +2797,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
-
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
+        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2911,17 +2909,18 @@ static void vfio_req_notifier_handler(void *opaque)
 
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     Error *err = NULL;
     int32_t fd;
+    int ret;
 
     if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
         return;
     }
 
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
+                                   &irq_info);
+    if (ret < 0 || irq_info.count < 1) {
         return;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ffb3681607e2816ff0c07e2b5cfd255b46500b10..9a21f2e50a2945a6658b9be4fdec1bc1c98d0f20 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -474,10 +474,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
     QSIMPLEQ_INIT(&vdev->pending_intp_queue);
 
     for (i = 0; i < vbasedev->num_irqs; i++) {
-        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
+        struct vfio_irq_info irq;
+
+        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
 
-        irq.index = i;
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
         if (ret) {
             error_setg_errno(errp, -ret, "failed to get device irq info");
             goto irq_err;
-- 
2.49.0


