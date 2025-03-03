Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C460C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zK-0002ie-9b; Mon, 03 Mar 2025 12:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y9-0001aA-MV
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:51 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9y7-0000K7-EC
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:45 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2234bec7192so71439275ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024362; x=1741629162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypBKTzocjelNd1zk+Kq7I1Qv1eqMSc9ppcbAV4fLn6U=;
 b=AI4zCAw85SNSV7bNJ6UX3RP4F887rOwjXg34wb+UYT7oou7rMUJRjqO4Nb3SUx7pzC
 v/iFDZhAb5aGyZPrKIAhvMOCyK50USRD0xcFeMI9j0+jiCc3TkeILAlPB3NR3mM3W7Du
 6AmmJffy1EJCfQJ5nx7iPbgYx0uTJt2hzpSoDGp6Wcc4GZB0BDSsVDS7EchmBQzGLHUZ
 nerofosU4AgV9yjaRT+MprUEDY/EBGizoZ62+N5yuI/4wp3QTVlkphZsbV8qe1OxWq3b
 jrx9enKtK/psoz92lgMjlp0Jw1gIisdmK6t4sjvzphfmVmxZMQmNkt23o7n6g8cD3wV1
 0njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024362; x=1741629162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypBKTzocjelNd1zk+Kq7I1Qv1eqMSc9ppcbAV4fLn6U=;
 b=NxV+ucydVn83Nq6tmzgYscspy0o2xzIAjTYBYD8SMOK5/CgULdnZ3FNEJqYO9ETbfp
 yERBCodUm5cCJCq9QWRrKG/80ckeU5FK7jmtdqa32yM1+bvdhMWMyOk4pCUtELMi2jS6
 d/AEZiFpqsTWXFaVAYawVg4KqarShrx8al0aKjO3YUnSvSDVSltwCpxMZ2h8LtBngAdA
 NFrJb1a0O8yi3jMlnN5NkI3VMlCVOLsJpxtEKAkLWAzN5AoCdu44q4VjRdgty0U1HpRm
 tFh58PtHYm76/5pH/ifFwNnAVzd+sq12l+96UThRrvVei8DftKw6zww+cRV6zp10xxlH
 zx5w==
X-Gm-Message-State: AOJu0YyTOI3nKEMOPlDglYo3nF70aoVcdVCw3a/HwcJARFM9n2V5lTht
 qH1VyXLRDeGRjjFx6acuuaMRE6xfcva7Ja0graLaf0lIabn/feQ=
X-Gm-Gg: ASbGncuTdBdJbk+ZBWVYvLgL6yALM0d8ZnU/KkT+/Kd9BrC2Cu3gZU2iYyN2n7CECHi
 eGOP7vpBS2xLVCNWAI7BJiEV9XIgUfA184I7sfV4Sx/IzAEQLB+xl4tE7/sphWchBjqroYXqYIw
 ZGWXds6eSKLUwkoY4fIpcwRigUeDtRRimVTZJ2cq86mqfYpPkO8XarzOaOXmLamqZVAf8pwp74G
 UbDBa3si1Lld8O/N7xUx042CMTiCvQfpVOFiU9ij7qzCLn3zydC1v3KA19fC6YT020OaE5bWNIv
 j5qvEjx0YgHPtsLlC4ZKIGDdYVkG0bmMQS/iF4SwyVCFZOqulFbm4CAz+w==
X-Google-Smtp-Source: AGHT+IHdB2eTDWixMyLLdhk2WhA3vX//+QRGtGh632k+IoYI7+y5yfrJVP5H1fxLJQcAoekVQU7i5g==
X-Received: by 2002:a17:903:1252:b0:223:26da:4b6f with SMTP id
 d9443c01a7336-22368f74891mr234558535ad.14.1741024361980; 
 Mon, 03 Mar 2025 09:52:41 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:41 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 7/9] vfio/igd: Decouple common quirks from legacy mode
Date: Tue,  4 Mar 2025 01:52:17 +0800
Message-ID: <20250303175220.74917-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303175220.74917-1-tomitamoeko@gmail.com>
References: <20250303175220.74917-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

So far, IGD-specific quirks all require enabling legacy mode, which is
toggled by assigning IGD to 00:02.0. However, some quirks, like the BDSM
and GGC register quirks, should be applied to all supported IGD devices.
A new feature bit, VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE, is introduced to
control the legacy mode only quirks.

To maintain backward compatibilty, this bit is set by default, but
legacy mode is only enabled when:
- Machine type is i440fx
- IGD device is at guest BDF 00:02.0
- Not manually disabled by x-igd-legacy-mode=off

Note that QEMU will now fail immediately if any error occurs when
setting up legacy mode, instead of simply continues like before. If
legacy mode is unwanted, it can be explicitly disabled by
x-igd-legacy-mode=off.

Additionally, the hotplug check in legacy mode is removed as it will be
checked when enabling the OpRegion quirk.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 108 +++++++++++++++++++++++++-------------------------
 hw/vfio/pci.c |   2 +
 hw/vfio/pci.h |   3 ++
 3 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f5e19f1241..40f5803be9 100644
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
 
@@ -482,15 +481,12 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
-    Error *err = NULL;
 
     /*
      * This must be an Intel VGA device at address 00:02.0 for us to even
@@ -498,9 +494,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
      * PCI bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+        !vfio_is_vga(vdev)) {
         return true;
     }
 
@@ -516,56 +510,62 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
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
+     * For backward compatibilty, enable legacy mode when
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
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE) &&
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
+        warn_report("IGD legacy mode enabled, "
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
+            error_setg(errp, "Device has no ROM");
+            return false;
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
+        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, errp)) {
+            error_setg(errp, "Unable to enable VGA access");
+            return false;
+        }
 
-    /* Setup LPC bridge / Host bridge PCI IDs */
-    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_report_err(err);
-        return true;
+        /* Setup OpRegion access */
+        if (!vfio_pci_igd_setup_opregion(vdev, errp)) {
+            return false;
+        }
+
+        /* Setup LPC bridge / Host bridge PCI IDs */
+        if (!vfio_pci_igd_setup_lpc_bridge(vdev, errp)) {
+            return false;
+        }
     }
 
     /*
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a58d555934..b0620a0ae8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BIT("x-igd-legacy-mode", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT, true),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2e81f9eb19..b7b07644a8 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -154,6 +154,9 @@ struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT 4
+#define VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE \
+                                (1 << VFIO_FEATURE_ENABLE_IGD_LEGACY_MODE_BIT)
     OnOffAuto display;
     uint32_t display_xres;
     uint32_t display_yres;
-- 
2.47.2


