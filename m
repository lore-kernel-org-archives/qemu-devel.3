Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB201C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts487-0007rb-6q; Tue, 11 Mar 2025 14:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47M-000749-5a
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts472-0006gk-MC
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmxe4zEHf+6DdKmQyCBAmbo4wTWL3oyJnFN/u0a7nyo=;
 b=Du2bXRryXvne5EyHey4SP+JSJWUPtc0vKKA+8NOnQTmYKHNHnuEDiTSSDDTsigeO4Mte9C
 fV+b7QjyATfr+gQtREebm88O0QaIJwF9zfgNmrZ1YHqOUVk6DQRaJkMvKQOcbyyrD+5jKP
 7jOsKqXWT/EsZHe3Jzk3wFTAZOEkauo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-AZNU2OzhPd-ES8N87KZyRw-1; Tue,
 11 Mar 2025 14:13:50 -0400
X-MC-Unique: AZNU2OzhPd-ES8N87KZyRw-1
X-Mimecast-MFC-AGG-ID: AZNU2OzhPd-ES8N87KZyRw_1741716829
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C74F1800259; Tue, 11 Mar 2025 18:13:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B07018001EF; Tue, 11 Mar 2025 18:13:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/21] vfio/igd: Move LPC bridge initialization to a separate
 function
Date: Tue, 11 Mar 2025 19:13:11 +0100
Message-ID: <20250311181328.1200431-5-clg@redhat.com>
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

A new option will soon be introduced to decouple the LPC bridge/Host
bridge ID quirk from legacy mode. To prepare for this, move the LPC
bridge initialization into a separate function.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-5-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 122 +++++++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 52 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 113ad56ad4206e29198717d944ffe944e1c2e27c..7feed7dfa920725d1d550b9225c7075453bf7b88 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -351,6 +351,72 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
     return ret;
 }
 
+static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
+{
+    g_autofree struct vfio_region_info *host = NULL;
+    g_autofree struct vfio_region_info *lpc = NULL;
+    PCIDevice *lpc_bridge;
+    int ret;
+
+    /*
+     * Copying IDs or creating new devices are not supported on hotplug
+     */
+    if (vdev->pdev.qdev.hotplugged) {
+        error_setg(errp, "IGD LPC is not supported on hotplugged device");
+        return false;
+    }
+
+    /*
+     * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
+     * can stuff host values into, so if there's already one there and it's not
+     * one we can hack on, this quirk is no-go.  Sorry Q35.
+     */
+    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
+                                 0, PCI_DEVFN(0x1f, 0));
+    if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
+                                           "vfio-pci-igd-lpc-bridge")) {
+        error_setg(errp,
+                   "Cannot create LPC bridge due to existing device at 1f.0");
+        return false;
+    }
+
+    /*
+     * Check whether we have all the vfio device specific regions to
+     * support LPC quirk (added in Linux v4.6).
+     */
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                        VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG, &lpc);
+    if (ret) {
+        error_setg(errp, "IGD LPC bridge access is not supported by kernel");
+        return false;
+    }
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                        VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
+    if (ret) {
+        error_setg(errp, "IGD host bridge access is not supported by kernel");
+        return false;
+    }
+
+    /* Create/modify LPC bridge */
+    ret = vfio_pci_igd_lpc_init(vdev, lpc);
+    if (ret) {
+        error_setg(errp, "Failed to create/modify LPC bridge for IGD");
+        return false;
+    }
+
+    /* Stuff some host values into the VM PCI host bridge */
+    ret = vfio_pci_igd_host_init(vdev, host);
+    if (ret) {
+        error_setg(errp, "Failed to modify host bridge for IGD");
+        return false;
+    }
+
+    return true;
+}
+
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
@@ -419,9 +485,6 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
-    PCIDevice *lpc_bridge;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
@@ -440,20 +503,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /*
-     * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
-     * can stuff host values into, so if there's already one there and it's not
-     * one we can hack on, legacy mode is no-go.  Sorry Q35.
-     */
-    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                 0, PCI_DEVFN(0x1f, 0));
-    if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
-                                           "vfio-pci-igd-lpc-bridge")) {
-        error_report("IGD device %s cannot support legacy mode due to existing "
-                     "devices at address 1f.0", vdev->vbasedev.name);
-        return;
-    }
-
     /*
      * IGD is not a standard, they like to change their specs often.  We
      * only attempt to support back to SandBridge and we hope that newer
@@ -490,28 +539,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /*
-     * Check whether we have all the vfio device specific regions to
-     * support legacy mode (added in Linux v4.6).  If not, bail.
-     */
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
-    if (ret) {
-        error_report("IGD device %s does not support host bridge access,"
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
-    ret = vfio_get_dev_region_info(&vdev->vbasedev,
-                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                        VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG, &lpc);
-    if (ret) {
-        error_report("IGD device %s does not support LPC bridge access,"
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
 
     /*
@@ -533,19 +560,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /* Create our LPC/ISA bridge */
-    ret = vfio_pci_igd_lpc_init(vdev, lpc);
-    if (ret) {
-        error_report("IGD device %s failed to create LPC bridge, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return;
-    }
-
-    /* Stuff some host values into the VM PCI host bridge */
-    ret = vfio_pci_igd_host_init(vdev, host);
-    if (ret) {
-        error_report("IGD device %s failed to modify host bridge, "
-                     "legacy mode disabled", vdev->vbasedev.name);
+    /* Setup LPC bridge / Host bridge PCI IDs */
+    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
+        error_append_hint(&err, "IGD legacy mode disabled\n");
+        error_report_err(err);
         return;
     }
 
-- 
2.48.1


