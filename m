Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC96C25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihG-0003i9-16; Wed, 22 May 2024 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih9-0003cc-R7
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih8-0001kr-8h
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MK7K8BRp1eb4ATPYy85ppbWOHv6VwOzA0avlScVc0/4=;
 b=QkomxB7k7nEFs/lS2Sy+gq7L/ifc2rfh8tbemmj2re1/lBiSgwHqHSXe1U8dHLEmFi1fl6
 S3lGz5AbEVRwZdY8Q+PPBwRxbboioAnTLnQAUrt0c6dCE5zenxsACUrRpRPMfRezqk51pD
 X1tUoMf06EKh26AkQ4ekYw/J6xaOvTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-mrdypOdFOduDmMsgojTCGw-1; Wed, 22 May 2024 05:55:34 -0400
X-MC-Unique: mrdypOdFOduDmMsgojTCGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 343AB185AD2D;
 Wed, 22 May 2024 09:55:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07D9228E2;
 Wed, 22 May 2024 09:55:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/47] vfio/display: Make vfio_display_*() return bool
Date: Wed, 22 May 2024 11:54:26 +0200
Message-ID: <20240522095442.195243-32-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h     |  2 +-
 hw/vfio/display.c | 20 ++++++++++----------
 hw/vfio/pci.c     |  3 +--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 92cd62d1159dbd47d878454f201f9c18112a7692..a5ac9efd4bb6d4070cac02f3eeb156d1018cd20f 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -232,7 +232,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
-int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
 extern const VMStateDescription vfio_display_vmstate;
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index d28b724102d5970cb2b9dc7464dc7575b6f441d9..661e921616f4b85613d5f6053c30348a4ee6cbd2 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -348,11 +348,11 @@ static const GraphicHwOps vfio_display_dmabuf_ops = {
     .ui_info    = vfio_display_edid_ui_info,
 };
 
-static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
 {
     if (!display_opengl) {
         error_setg(errp, "vfio-display-dmabuf: opengl not available");
-        return -1;
+        return false;
     }
 
     vdev->dpy = g_new0(VFIODisplay, 1);
@@ -362,11 +362,11 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
         if (!vdev->dpy->ramfb) {
-            return -EINVAL;
+            return false;
         }
     }
     vfio_display_edid_init(vdev);
-    return 0;
+    return true;
 }
 
 static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
@@ -483,7 +483,7 @@ static const GraphicHwOps vfio_display_region_ops = {
     .gfx_update = vfio_display_region_update,
 };
 
-static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
 {
     vdev->dpy = g_new0(VFIODisplay, 1);
     vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
@@ -492,10 +492,10 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
         if (!vdev->dpy->ramfb) {
-            return -EINVAL;
+            return false;
         }
     }
-    return 0;
+    return true;
 }
 
 static void vfio_display_region_exit(VFIODisplay *dpy)
@@ -510,7 +510,7 @@ static void vfio_display_region_exit(VFIODisplay *dpy)
 
 /* ---------------------------------------------------------------------- */
 
-int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_device_gfx_plane_info probe;
     int ret;
@@ -533,11 +533,11 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
 
     if (vdev->display == ON_OFF_AUTO_AUTO) {
         /* not an error in automatic mode */
-        return 0;
+        return true;
     }
 
     error_setg(errp, "vfio: device doesn't support any (known) display method");
-    return -1;
+    return false;
 }
 
 void vfio_display_finalize(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c1adef5cf8fb241df510514610f05c8a0d51a9f9..a447013a1da90f534ab07409c6ca39263f7f6f88 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3200,8 +3200,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     }
 
     if (vdev->display != ON_OFF_AUTO_OFF) {
-        ret = vfio_display_probe(vdev, errp);
-        if (ret) {
+        if (!vfio_display_probe(vdev, errp)) {
             goto out_deregister;
         }
     }
-- 
2.45.1


