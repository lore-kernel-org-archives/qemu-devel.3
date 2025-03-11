Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE8FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts47r-0007FD-K7; Tue, 11 Mar 2025 14:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47J-00073s-Fh
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts474-0006hm-Eo
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuReeu8PoK2Noa7YJrOaKSP3dWj5daa8BOsYBEpyFPA=;
 b=FbjM/JL/iwA2Bq0w7DSWV2A+xLDG54IKKh9BwaFqpYasSr9QlELNvREEkqjegzYrCVj2l6
 b2XrXjgPSj6CRoKOtSjiTBi5kfKvkcsGF6lbqvKZnHAYNcfC7CtcOzYKs6J0Uhkt/SO+0+
 q98QHES7hZP6uWYMTDSn2cOhSo+tU9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-wylvVGI3OHSOFpUzmMhKcw-1; Tue,
 11 Mar 2025 14:13:52 -0400
X-MC-Unique: wylvVGI3OHSOFpUzmMhKcw-1
X-Mimecast-MFC-AGG-ID: wylvVGI3OHSOFpUzmMhKcw_1741716831
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E77819560B0; Tue, 11 Mar 2025 18:13:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B27D818001EF; Tue, 11 Mar 2025 18:13:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/21] vfio/igd: Decouple common quirks from legacy mode
Date: Tue, 11 Mar 2025 19:13:14 +0100
Message-ID: <20250311181328.1200431-8-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

So far, IGD-specific quirks all require enabling legacy mode, which is
toggled by assigning IGD to 00:02.0. However, some quirks, like the BDSM
and GGC register quirks, should be applied to all supported IGD devices.
A new config option, x-igd-legacy-mode=[on|off|auto], is introduced to
control the legacy mode only quirks. The default value is "auto", which
keeps current behavior that enables legacy mode implicitly and continues
on error when all following conditions are met.
* Machine type is i440fx
* IGD device is at guest BDF 00:02.0

If any one of the conditions above is not met, the default behavior is
equivalent to "off", QEMU will fail immediately if any error occurs.

Users can also use "on" to force enabling legacy mode. It checks if all
the conditions above are met and set up legacy mode. QEMU will also fail
immediately on error in this case.

Additionally, the hotplug check in legacy mode is removed as hotplugging
IGD device is never supported, and it will be checked when enabling the
OpRegion quirk.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-8-tomitamoeko@gmail.com
[ clg: - Changed warn_report() by info_report() in
         vfio_probe_igd_config_quirk() as suggested by Alex W.
       - Fixed spelling in vfio_probe_igd_config_quirk () ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |   1 +
 hw/vfio/igd.c | 127 +++++++++++++++++++++++++++++---------------------
 hw/vfio/pci.c |   2 +
 3 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index fc7ead7727b37ed57f159416bb73698a44a38348..3e66b19d8f24fd8c0f44ca26d63e511edbc4318a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -158,6 +158,7 @@ struct VFIOPCIDevice {
     uint32_t display_xres;
     uint32_t display_yres;
     int32_t bootindex;
+    OnOffAuto igd_legacy_mode;
     uint32_t igd_gms;
     OffAutoPCIBAR msix_relo;
     uint8_t nv_gpudirect_clique;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 65a3dbb5afd073404a960d3eed309368e1448950..ee36875310b4728ac0049327a1f71021d5e6f770 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -15,6 +15,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "hw/boards.h"
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
@@ -432,9 +433,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 0 ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+        !vfio_is_vga(vdev) || nr != 0) {
         return;
     }
 
@@ -482,14 +481,13 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
-                                 Error **errp G_GNUC_UNUSED)
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
-    g_autofree struct vfio_region_info *rom = NULL;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
+    bool legacy_mode_enabled = false;
     Error *err = NULL;
 
     /*
@@ -498,9 +496,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
      * PCI bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+        !vfio_is_vga(vdev)) {
         return true;
     }
 
@@ -516,56 +512,67 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
         return true;
     }
 
-    /*
-     * Most of what we're doing here is to enable the ROM to run, so if
-     * there's no ROM, there's no point in setting up this quirk.
-     * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
-     */
-    ret = vfio_get_region_info(&vdev->vbasedev,
-                               VFIO_PCI_ROM_REGION_INDEX, &rom);
-    if ((ret || !rom->size) && !vdev->pdev.romfile) {
-        error_report("IGD device %s has no ROM, legacy mode disabled",
-                     vdev->vbasedev.name);
-        return true;
-    }
-
-    /*
-     * Ignore the hotplug corner case, mark the ROM failed, we can't
-     * create the devices we need for legacy mode in the hotplug scenario.
-     */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_report("IGD device %s hotplugged, ROM disabled, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        vdev->rom_read_failed = true;
-        return true;
-    }
-
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
 
     /*
-     * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
-     * try to enable it.  Probably shouldn't be using legacy mode without VGA,
-     * but also no point in us enabling VGA if disabled in hardware.
+     * For backward compatibility, enable legacy mode when
+     * - Machine type is i440fx (pc_piix)
+     * - IGD device is at guest BDF 00:02.0
+     * - Not manually disabled by x-igd-legacy-mode=off
      */
-    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
-        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        error_report("IGD device %s failed to enable VGA access, "
-                     "legacy mode disabled", vdev->vbasedev.name);
-        return true;
-    }
+    if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
+        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
+        0, PCI_DEVFN(0x2, 0)))) {
+        /*
+         * IGD legacy mode requires:
+         * - VBIOS in ROM BAR or file
+         * - VGA IO/MMIO ranges are claimed by IGD
+         * - OpRegion
+         * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
+         */
+        g_autofree struct vfio_region_info *rom = NULL;
+
+        legacy_mode_enabled = true;
+        info_report("IGD legacy mode enabled, "
+                    "use x-igd-legacy-mode=off to disable it if unwanted.");
+
+        /*
+         * Most of what we're doing here is to enable the ROM to run, so if
+         * there's no ROM, there's no point in setting up this quirk.
+         * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
+         */
+        ret = vfio_get_region_info(&vdev->vbasedev,
+                                   VFIO_PCI_ROM_REGION_INDEX, &rom);
+        if ((ret || !rom->size) && !vdev->pdev.romfile) {
+            error_setg(&err, "Device has no ROM");
+            goto error;
+        }
 
-    /* Setup OpRegion access */
-    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_report_err(err);
-        return true;
-    }
+        /*
+         * If IGD VGA Disable is clear (expected) and VGA is not already
+         * enabled, try to enable it. Probably shouldn't be using legacy mode
+         * without VGA, but also no point in us enabling VGA if disabled in
+         * hardware.
+         */
+        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
+            error_setg(&err, "Unable to enable VGA access");
+            goto error;
+        }
 
-    /* Setup LPC bridge / Host bridge PCI IDs */
-    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_report_err(err);
-        return true;
+        /* Setup OpRegion access */
+        if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
+            goto error;
+        }
+
+        /* Setup LPC bridge / Host bridge PCI IDs */
+        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
+            goto error;
+        }
+    } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
+        error_setg(&err,
+                   "Machine is not i440fx or assigned BDF is not 00:02.0");
+        goto error;
     }
 
     /*
@@ -627,4 +634,18 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 
     return true;
+
+error:
+    /*
+     * When legacy mode is implicity enabled, continue on error,
+     * to keep compatibility
+     */
+    if (legacy_mode_enabled && (vdev->igd_legacy_mode == ON_OFF_AUTO_AUTO)) {
+        error_report_err(err);
+        error_report("IGD legacy mode disabled");
+        return true;
+    }
+
+    error_propagate(errp, err);
+    return false;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ff1e720dbadc2251d76e4c71c026757e2cef1a8c..444a33d94b7ee56311e828f69f29c724b91812c3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3369,6 +3369,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
+                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
-- 
2.48.1


