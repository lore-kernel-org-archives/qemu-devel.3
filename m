Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5BEC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doL-0001Lq-VE; Wed, 22 May 2024 00:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doK-0001LA-Ko
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:44 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doH-0005sg-A0
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352962; x=1747888962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nR3/N81fP2lWYnCwoqeFQ8UTmXCJcw0lSyoNyVGiKWY=;
 b=gE+RCA5GIxsbvvJh5PRSK2nDC0FhtXbTZjsN4XjqxmmpQvKUp/I9WdV3
 MZWrrdTgGCwUe2c2FlWCai1LUlMcABgBZAAg7BccaITLf1rg2zaOD6rWM
 rs2g9Ex7LALKiHJNEVTmXg6rn+3t2HHS/AFGP19Kphu6VWwQgRzEk6yi6
 a8bZlQ6wnju2pDC+OeZPfBoodugDiczh09txXVGUTIaDNHA2Xp01xXIMC
 R9BWTTxmB8WqNnkGiJ301nixDxxjT7slkUqdqQT1ZPtKFfKSDAnYuis3Z
 5WE8MeodIiYvBaGNSGv+uVHtoFyA8+VzhuwT+97pitRwwcLwKXODuNtMA Q==;
X-CSE-ConnectionGUID: t3ogDDf2RrSBvQl/UgRH9Q==
X-CSE-MsgGUID: Qb4J5aNASISGXC9/h3N5kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994119"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994119"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:39 -0700
X-CSE-ConnectionGUID: 1HjOn4ARQRumKJwJ2rjyiw==
X-CSE-MsgGUID: Wa/jqcmkT/OZswNCmxboRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683620"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 02/20] vfio/display: Make vfio_display_*() return bool
Date: Wed, 22 May 2024 12:39:57 +0800
Message-Id: <20240522044015.412951-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h     |  2 +-
 hw/vfio/display.c | 20 ++++++++++----------
 hw/vfio/pci.c     |  3 +--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 92cd62d115..a5ac9efd4b 100644
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
index d28b724102..661e921616 100644
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
index c1adef5cf8..a447013a1d 100644
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
2.34.1


