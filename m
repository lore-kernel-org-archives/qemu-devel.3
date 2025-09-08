Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F7DCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9X-0008HV-4O; Mon, 08 Sep 2025 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9R-00080T-Dn
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9E-0001sx-FZ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zg/jfyUQaksIu0iHJ/vbO+gVCj0KWB4I+W4rrQbdjW0=;
 b=axGcjA47KPyKqcSAKW7TUdGJS62nVIdQIxRx2I8mH3Ygx9sD0i7qb1qyl2IHvIXZg4YUYb
 z5lfPs3a64LE+O9dIMJFDV+LefkZYEKjVrSZ7ClBEasjjRsHevbrIG3WJaLtunPKy0ZX7b
 pOG/k7JoQg1nRYZeRRvE4g2YCy99i6U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-xIrKqsX2MtOkMTkX8XkDgg-1; Mon,
 08 Sep 2025 12:55:14 -0400
X-MC-Unique: xIrKqsX2MtOkMTkX8XkDgg-1
X-Mimecast-MFC-AGG-ID: xIrKqsX2MtOkMTkX8XkDgg_1757350513
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00EEB18002C7; Mon,  8 Sep 2025 16:55:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56B1C300018D; Mon,  8 Sep 2025 16:55:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/31] vfio/igd.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:51 +0200
Message-ID: <20250908165354.1731444-29-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-20-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f116c40ccd933c8e6e7fd99d599c6372c26973e1..4bfa2e0fcd22a811c9dcf2b1c2357ad34c9e4a68 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -200,7 +200,7 @@ static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
     }
 
     /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
+    if (DEVICE(vdev)->hotplugged) {
         warn_report("IGD device detected, but OpRegion is not supported "
                     "on hotplugged device.");
         return false;
@@ -260,11 +260,12 @@ static int vfio_pci_igd_copy(VFIOPCIDevice *vdev, PCIDevice *pdev,
 static int vfio_pci_igd_host_init(VFIOPCIDevice *vdev,
                                   struct vfio_region_info *info)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     PCIBus *bus;
     PCIDevice *host_bridge;
     int ret;
 
-    bus = pci_device_root_bus(&vdev->pdev);
+    bus = pci_device_root_bus(pdev);
     host_bridge = pci_find_device(bus, 0, PCI_DEVFN(0, 0));
 
     if (!host_bridge) {
@@ -327,13 +328,14 @@ type_init(vfio_pci_igd_register_types)
 static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
                                  struct vfio_region_info *info)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     PCIDevice *lpc_bridge;
     int ret;
 
-    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
+    lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
                                  0, PCI_DEVFN(0x1f, 0));
     if (!lpc_bridge) {
-        lpc_bridge = pci_create_simple(pci_device_root_bus(&vdev->pdev),
+        lpc_bridge = pci_create_simple(pci_device_root_bus(pdev),
                                  PCI_DEVFN(0x1f, 0), "vfio-pci-igd-lpc-bridge");
     }
 
@@ -350,13 +352,14 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_region_info *host = NULL;
     struct vfio_region_info *lpc = NULL;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     PCIDevice *lpc_bridge;
     int ret;
 
     /*
      * Copying IDs or creating new devices are not supported on hotplug
      */
-    if (vdev->pdev.qdev.hotplugged) {
+    if (DEVICE(vdev)->hotplugged) {
         error_setg(errp, "IGD LPC is not supported on hotplugged device");
         return false;
     }
@@ -366,7 +369,7 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
      * can stuff host values into, so if there's already one there and it's not
      * one we can hack on, this quirk is no-go.  Sorry Q35.
      */
-    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
+    lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
                                  0, PCI_DEVFN(0x1f, 0));
     if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
                                            "vfio-pci-igd-lpc-bridge")) {
@@ -510,6 +513,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_region_info *opregion = NULL;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, gen;
     uint64_t gms_size = 0;
     uint64_t *bdsm_size;
@@ -529,7 +533,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
 
     gen = igd_gen(vdev);
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
+    gmch = vfio_pci_read_config(pdev, IGD_GMCH, 4);
 
     /*
      * For backward compatibility, enable legacy mode when
@@ -544,7 +548,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         (gen >= 6 && gen <= 9) &&
         !(gmch & IGD_GMCH_VGA_DISABLE) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
-        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
+        (pdev == pci_find_device(pci_device_root_bus(pdev),
         0, PCI_DEVFN(0x2, 0)))) {
         /*
          * IGD legacy mode requires:
@@ -566,7 +570,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          */
         ret = vfio_device_get_region_info(&vdev->vbasedev,
                                           VFIO_PCI_ROM_REGION_INDEX, &rom);
-        if ((ret || !rom->size) && !vdev->pdev.romfile) {
+        if ((ret || !rom->size) && !pdev->romfile) {
             error_setg(&err, "Device has no ROM");
             goto error;
         }
@@ -611,8 +615,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * ASLS (OpRegion address) is read-only, emulated
      * It contains HPA, guest firmware need to reprogram it with GPA.
      */
-    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
+    pci_set_long(pdev->config + IGD_ASLS, 0);
+    pci_set_long(pdev->wmask + IGD_ASLS, ~0);
     pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
 
     /*
@@ -626,8 +630,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         }
 
         /* GMCH is read-only, emulated */
-        pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
-        pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
+        pci_set_long(pdev->config + IGD_GMCH, gmch);
+        pci_set_long(pdev->wmask + IGD_GMCH, 0);
         pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
     }
 
@@ -636,12 +640,12 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
         /* BDSM is read-write, emulated. BIOS needs to be able to write it */
         if (gen < 11) {
-            pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-            pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+            pci_set_long(pdev->config + IGD_BDSM, 0);
+            pci_set_long(pdev->wmask + IGD_BDSM, ~0);
             pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
         } else {
-            pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
-            pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+            pci_set_quad(pdev->config + IGD_BDSM_GEN11, 0);
+            pci_set_quad(pdev->wmask + IGD_BDSM_GEN11, ~0);
             pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
         }
     }
-- 
2.51.0


