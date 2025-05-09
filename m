Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C10C3ABCC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNaE-0004XJ-Qd; Fri, 09 May 2025 09:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNZ1-0002Pe-OE
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYw-0007EN-Tz
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNkOj8OQpBDthVO+0t/oNssdHasHoaIWKjOmrWA2SGc=;
 b=Ax50KoUTfBNUV8RwGbKCMvxC6twtS6GuoXUpX+snaqXUJ28fsyz2+FsszQDbqQzgca4wwg
 yA4PX/hKn6pQ2vjlJq+ainMFgHRnbOc4w0GNzsWwqJ8bJO+ek88F3RAJefS7DHEj6IiyUl
 i262a9M7YdblOq807eLfK3v7r4Mm0lg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-k5Q-Ne1ENP-vMIScules5w-1; Fri,
 09 May 2025 09:14:46 -0400
X-MC-Unique: k5Q-Ne1ENP-vMIScules5w-1
X-Mimecast-MFC-AGG-ID: k5Q-Ne1ENP-vMIScules5w_1746796485
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7C40195608B; Fri,  9 May 2025 13:14:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BE9918003FD; Fri,  9 May 2025 13:14:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/28] vfio: add region info cache
Date: Fri,  9 May 2025 15:13:14 +0200
Message-ID: <20250509131317.164235-26-clg@redhat.com>
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

Instead of requesting region information on demand with
VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
necessary for performance for vfio-user, where this call becomes a
message over the control socket, so is of higher overhead than the
traditional path.

We will also need it to generalize region accesses, as that means we
can't use ->config_offset for configuration space accesses, but must
look up the region offset (if relevant) each time.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-12-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/device.c              | 25 +++++++++++++++++++++----
 hw/vfio/igd.c                 | 10 +++++-----
 hw/vfio/pci.c                 |  6 +++---
 hw/vfio/region.c              |  2 +-
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 7e1e81e76bd2b484108282f7147ff7a0793360cf..4fff3dcee3b4a2a3c8a4bd6fa017cf822a16668e 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -83,6 +83,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    struct vfio_region_info **reginfo;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ab3fabf991c35abb6c40d925f526c2a2d8955aef..cea9d6e00562c241832184cafe862005fcdc992b 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -504,7 +504,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
-    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -517,7 +516,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
-        g_free(info);
     }
 
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -530,7 +528,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
-        g_free(info);
     }
 
     ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
@@ -544,7 +541,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
-        g_free(info);
     }
 
     return true;
@@ -554,7 +550,6 @@ out_err:
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-    g_free(info);
     return false;
 }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 40a196bfb9a86656610863d4f064db383c7072e0..77b0675abe7b4f4155ea79cf3fd0e3ab4b21f8ea 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -202,6 +202,12 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
     size_t argsz = sizeof(struct vfio_region_info);
     int ret;
 
+    /* check cache */
+    if (vbasedev->reginfo[index] != NULL) {
+        *info = vbasedev->reginfo[index];
+        return 0;
+    }
+
     *info = g_malloc0(argsz);
 
     (*info)->index = index;
@@ -222,6 +228,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->reginfo[index] = *info;
+
     return 0;
 }
 
@@ -240,7 +249,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -252,8 +260,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -262,7 +268,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_device_get_region_info(vbasedev, region, &info)) {
@@ -435,10 +441,21 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    vbasedev->reginfo = g_new0(struct vfio_region_info *,
+                               vbasedev->num_regions);
 }
 
 void vfio_device_unprepare(VFIODevice *vbasedev)
 {
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        g_free(vbasedev->reginfo[i]);
+    }
+    g_free(vbasedev->reginfo);
+    vbasedev->reginfo = NULL;
+
     QLIST_REMOVE(vbasedev, container_next);
     QLIST_REMOVE(vbasedev, global_next);
     vbasedev->bcontainer = NULL;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 3ee1a73b57c57563f661a246e6dd7e505231be91..e7952d15a014f28fe302cab312ab8e60a414c679 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -349,8 +349,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
 
 static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
     int ret;
 
@@ -510,7 +510,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *opregion = NULL;
     int ret, gen;
     uint64_t gms_size = 0;
     uint64_t *bdsm_size;
@@ -551,7 +551,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * - OpRegion
          * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
          */
-        g_autofree struct vfio_region_info *rom = NULL;
+        struct vfio_region_info *rom = NULL;
 
         legacy_mode_enabled = true;
         info_report("IGD legacy mode enabled, "
@@ -681,7 +681,7 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *opregion = NULL;
     int gen;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index da2ffc9bf36778fb61a7decf345391caee528b2a..9136cf52c82711939db01c09a8a1277327bc484f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -883,8 +883,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    g_autofree struct vfio_region_info *reg_info = NULL;
     VFIODevice *vbasedev = &vdev->vbasedev;
+    struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -2710,7 +2710,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2775,7 +2775,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info;
     int i, ret = -1;
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 04bf9eb0987c0ac460e0a1c3ba5abdf4a87f7499..ef2630cac3924fef200b2ece1be0dbad219dd67d 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -182,7 +182,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, index, &info);
-- 
2.49.0


