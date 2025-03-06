Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167DEC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFXz-0003AH-E3; Thu, 06 Mar 2025 13:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXn-00036K-Dy
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:03 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXg-00009L-1d
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:02:03 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2240b4de12bso24739285ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284113; x=1741888913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEzBw2eiAZv/edrA+dgMo//vRMLgwdY1/zctaB1iA3M=;
 b=kgM0rYOO/EenzGrH/IAfHbl6cLe2F/eFq+PlbUA/Y6dtzElS2HQ4cPmagXD27QhMSl
 5db7EzgT8pwTAl9FlLKA/c/jMuPXWY1mMyGQboV1rfJ1QlwjtAZieffhoyved91sduli
 pQky0wXGqee0xsUJA8xKt9odSMPYeokEqHxoyaWwvZ47MBc2TeTw5F1WlbglaK3pEEpV
 wMOo/gCdo9NNvwtarXwuuEeoSBa4re5YafLIAIiI+3YJFM+0tEtRTWLdnP6QQlZ5Ke2C
 sgTUxsZa4jBmxa1Dew4etW4nRe7nUzbZQMrF01zFeWNQxx4h2fV0LEUyBpQDgbzQ2Oyq
 x0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284113; x=1741888913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEzBw2eiAZv/edrA+dgMo//vRMLgwdY1/zctaB1iA3M=;
 b=pb5Y2f0kjUKrk04QfYBOJk6CO64nR5jC+gAz6FGNtISxopR29nShkmYmBmjGFnvCv4
 OTA2O87TvfbN1t4G+JkttBPnb+ob1ZVNuTO8Q0RN/sK6bOfuh7PIrLzcHohlVW2Yo/7R
 p9HYC3ubBysTaXKxdoIlAQ7IdhNMmOcElpEmqKCZDffJHue4BoztG9KwBmpZ8pFHY9Wl
 fppZrADPkvvGFbf06YBO64obm2YkaIlWFkY7B12fggv9c6sN8qRAD6JopqFIRyEz3AIq
 R75VbPYoaq8ikZ4LfcBIt/H9iFpVlg6W6ck1Cu5zdEYFQ8Vk3o6C8vYbg2weiTYHC2JV
 YSvQ==
X-Gm-Message-State: AOJu0YyAYVZZJecmn5EYaUAJScGim7jDz3JGKqB+lb8HQVUr975AjMKj
 OGuWmzRDLYfFTYqR/YtN6aSwf6xAl93nHODX+cDXBVVhw+rRRlA=
X-Gm-Gg: ASbGncso86D+84+DyA15lWSxaT9h0rFFJKL0d4tuczoWhgrN2anG542L8iuOPFK+Hj2
 Sxb9GrP2QbF9aXjlAjeu6BRYdI7JZvTCKE5HyekV4anaDVj0EVpYS0NjWnwFem8I5lTfmq6sgoo
 Yrx9oCBNvc0FfRuPfnvZ11AIeyJGRSvzvIpxeFlt3RnmPnbaSai+ElzFCYNJwxhyPxzuKxbgylv
 GISTygZxrny+Y/D1wkECHvakEKfkfT0adpOlgZgGV5zUAgtB4nwPKua+6LzECSJ+j0enH1N+CYJ
 cwwM1XoHTASepudvEG2W+4vKR1aPptrltq2kGfgPngzTfvNdbRlrn307AA==
X-Google-Smtp-Source: AGHT+IFu1mUXgHQDMjUHRZ2EOapE+Rk1wuT3ctevIZQQUOaG1F6EM8jl4VGMDc8otg2vr+k+clBBZA==
X-Received: by 2002:a05:6a21:2d08:b0:1f3:47d6:aa05 with SMTP id
 adf61e73a8af0-1f5449336e0mr967761637.0.1741284113065; 
 Thu, 06 Mar 2025 10:01:53 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:52 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 07/10] vfio/igd: Decouple common quirks from legacy mode
Date: Fri,  7 Mar 2025 02:01:27 +0800
Message-ID: <20250306180131.32970-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 hw/vfio/igd.c | 127 +++++++++++++++++++++++++++++---------------------
 hw/vfio/pci.c |   2 +
 hw/vfio/pci.h |   1 +
 3 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index f5e19f1241..ac096e2eb5 100644
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
index a58d555934..d5ff8c1ea8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
+                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2e81f9eb19..aa67ceb346 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -158,6 +158,7 @@ struct VFIOPCIDevice {
     uint32_t display_xres;
     uint32_t display_yres;
     int32_t bootindex;
+    OnOffAuto igd_legacy_mode;
     uint32_t igd_gms;
     OffAutoPCIBAR msix_relo;
     uint8_t pm_cap;
-- 
2.47.2


