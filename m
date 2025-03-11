Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07509C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts473-0006jB-2t; Tue, 11 Mar 2025 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts471-0006ie-FS
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts46w-0006el-GG
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJVU7zKDQwrIGXChyvIVk8D81GQ12K58uZrqppjprfo=;
 b=QhEbyAORr2tR10eURGTY7HjQ1x3fVH+tUn7x6Lv2y+eHPKLtKaXI66jcnX8orGJ4ovQrvG
 ZkxPrHPwuh0onaybJ2HuQNxrmbofSxbGgJ59Pp4/nlAQCA1DP2fozH/xlWTJe3JU5xusa5
 +/+fHQTCFBzc0ywSGYPgvA/ZzCdWpuQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-H7-G36FfMoCZavdq7eNu_Q-1; Tue,
 11 Mar 2025 14:13:42 -0400
X-MC-Unique: H7-G36FfMoCZavdq7eNu_Q-1
X-Mimecast-MFC-AGG-ID: H7-G36FfMoCZavdq7eNu_Q_1741716821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2ACC18001FC; Tue, 11 Mar 2025 18:13:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8D1318001E9; Tue, 11 Mar 2025 18:13:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/21] vfio/igd: Consolidate OpRegion initialization into a
 single function
Date: Tue, 11 Mar 2025 19:13:10 +0100
Message-ID: <20250311181328.1200431-4-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

Both x-igd-opregion option and legacy mode require identical steps to
set up OpRegion for IGD devices. Consolidate these steps into a single
vfio_pci_igd_setup_opregion function.

The function call in pci.c is wrapped with ifdef temporarily to prevent
build error for non-x86 archs, it will be removed after we decouple it
from legacy mode.

Additionally, move vfio_pci_igd_opregion_init to igd.c to prevent it
from being compiled in non-x86 builds.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-4-tomitamoeko@gmail.com
[ clg: Fixed spelling in vfio_pci_igd_setup_opregion() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |   4 +-
 hw/vfio/igd.c        | 101 +++++++++++++++++++++++++++++++++++--------
 hw/vfio/pci-quirks.c |  50 ---------------------
 hw/vfio/pci.c        |  22 ++--------
 4 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d638c781f6f168a71d3a44b48ba0c4edfd334f44..f660b0d80fcfcb81129d443732fe887b084d7a52 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -227,9 +227,7 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                                struct vfio_region_info *info,
-                                Error **errp);
+bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index dda4c7bb5df8bd056c3e06eae38533da7586c6c9..113ad56ad4206e29198717d944ffe944e1c2e27c 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
     return -1;
 }
 
+#define IGD_ASLS 0xfc /* ASL Storage Register */
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
@@ -138,6 +139,82 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
     return 0;
 }
 
+/*
+ * The OpRegion includes the Video BIOS Table, which seems important for
+ * telling the driver what sort of outputs it has.  Without this, the device
+ * may work in the guest, but we may not get output.  This also requires BIOS
+ * support to reserve and populate a section of guest memory sufficient for
+ * the table and to write the base address of that memory to the ASLS register
+ * of the IGD device.
+ */
+static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
+                                       struct vfio_region_info *info,
+                                       Error **errp)
+{
+    int ret;
+
+    vdev->igd_opregion = g_malloc0(info->size);
+    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
+                info->size, info->offset);
+    if (ret != info->size) {
+        error_setg(errp, "failed to read IGD OpRegion");
+        g_free(vdev->igd_opregion);
+        vdev->igd_opregion = NULL;
+        return false;
+    }
+
+    /*
+     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
+     * allocate 32bit reserved memory for, copy these contents into, and write
+     * the reserved memory base address to the device ASLS register at 0xFC.
+     * Alignment of this reserved region seems flexible, but using a 4k page
+     * alignment seems to work well.  This interface assumes a single IGD
+     * device, which may be at VM address 00:02.0 in legacy mode or another
+     * address in UPT mode.
+     *
+     * NB, there may be future use cases discovered where the VM should have
+     * direct interaction with the host OpRegion, in which case the write to
+     * the ASLS register would trigger MemoryRegion setup to enable that.
+     */
+    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
+                    vdev->igd_opregion, info->size);
+
+    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
+
+    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
+    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
+
+    return true;
+}
+
+bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
+{
+    g_autofree struct vfio_region_info *opregion = NULL;
+    int ret;
+
+    /* Hotplugging is not supported for opregion access */
+    if (vdev->pdev.qdev.hotplugged) {
+        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
+        return false;
+    }
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "Device does not supports IGD OpRegion feature");
+        return false;
+    }
+
+    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * The rather short list of registers that we copy from the host devices.
  * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
@@ -342,7 +419,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *opregion = NULL;
     g_autofree struct vfio_region_info *host = NULL;
     g_autofree struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
@@ -418,15 +494,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * Check whether we have all the vfio device specific regions to
      * support legacy mode (added in Linux v4.6).  If not, bail.
      */
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
-    if (ret) {
-        error_report("IGD device %s does not support OpRegion access,"
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
                         VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                         VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
@@ -459,6 +526,13 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
+    /* Setup OpRegion access */
+    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
+        error_append_hint(&err, "IGD legacy mode disabled\n");
+        error_report_err(err);
+        return;
+    }
+
     /* Create our LPC/ISA bridge */
     ret = vfio_pci_igd_lpc_init(vdev, lpc);
     if (ret) {
@@ -475,13 +549,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /* Setup OpRegion access */
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        return;
-    }
-
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c53591fe2ba5f71364befb7c916ae4f7abde4cbf..37966e17f0178bbf2d82b2d84da40ba2e261d9f3 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1114,56 +1114,6 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
     trace_vfio_quirk_rtl8168_probe(vdev->vbasedev.name);
 }
 
-#define IGD_ASLS 0xfc /* ASL Storage Register */
-
-/*
- * The OpRegion includes the Video BIOS Table, which seems important for
- * telling the driver what sort of outputs it has.  Without this, the device
- * may work in the guest, but we may not get output.  This also requires BIOS
- * support to reserve and populate a section of guest memory sufficient for
- * the table and to write the base address of that memory to the ASLS register
- * of the IGD device.
- */
-bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                                struct vfio_region_info *info, Error **errp)
-{
-    int ret;
-
-    vdev->igd_opregion = g_malloc0(info->size);
-    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
-                info->size, info->offset);
-    if (ret != info->size) {
-        error_setg(errp, "failed to read IGD OpRegion");
-        g_free(vdev->igd_opregion);
-        vdev->igd_opregion = NULL;
-        return false;
-    }
-
-    /*
-     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
-     * allocate 32bit reserved memory for, copy these contents into, and write
-     * the reserved memory base address to the device ASLS register at 0xFC.
-     * Alignment of this reserved region seems flexible, but using a 4k page
-     * alignment seems to work well.  This interface assumes a single IGD
-     * device, which may be at VM address 00:02.0 in legacy mode or another
-     * address in UPT mode.
-     *
-     * NB, there may be future use cases discovered where the VM should have
-     * direct interaction with the host OpRegion, in which case the write to
-     * the ASLS register would trigger MemoryRegion setup to enable that.
-     */
-    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
-                    vdev->igd_opregion, info->size);
-
-    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
-
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
-
-    return true;
-}
-
 /*
  * Common quirk probe entry points.
  */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fdbc15885d442ee20343e6b7127d54a70b1688ce..419dc2c4c85ffeed3b794e65f8040e11ba58bb0e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3136,30 +3136,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
+#ifdef CONFIG_VFIO_IGD
     if (!vdev->igd_opregion &&
         vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        g_autofree struct vfio_region_info *opregion = NULL;
-
-        if (vdev->pdev.qdev.hotplugged) {
-            error_setg(errp,
-                       "cannot support IGD OpRegion feature on hotplugged "
-                       "device");
-            goto out_unset_idev;
-        }
-
-        ret = vfio_get_dev_region_info(vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
-        if (ret) {
-            error_setg_errno(errp, -ret,
-                             "does not support requested IGD OpRegion feature");
-            goto out_unset_idev;
-        }
-
-        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
+        if (!vfio_pci_igd_setup_opregion(vdev, errp)) {
             goto out_unset_idev;
         }
     }
+#endif
 
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
-- 
2.48.1


