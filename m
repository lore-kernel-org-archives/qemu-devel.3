Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF684C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFXp-00038M-UL; Thu, 06 Mar 2025 13:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXf-00033y-D1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:57 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXW-00007F-9n
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:51 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-223fd89d036so20056785ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284105; x=1741888905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stCgZpQtE1zFYYbrS3BPR9VSrLJmwkhXSnn+AFxTDO4=;
 b=VlMLqKnNBbcjuIgr0eeNQOz2CN+oduGE1htLN9GVZ3VEf9KJ2b01pkrtKaZmzJ4Tla
 RZLZUyMpJgbSreDmU/0hQwzKYsn0gHIoDz/NRKO5GkJq3htWQph9gdB2wh5Vlh0TisVH
 tU/ZnWkTeGkRp0MbA8FjzfI1vXQ3DtfUc+qKeNy3AjzJ9EZRVXTULtYragwb6y9YyPiC
 +6VnrntpiNufSXLKWcikv/wIp2sQUadqcUpSoC4aUZUSbbJi05y9tfCvWPpe9gbzyyGB
 UMFfdiab2/xRHgqoPRv6HwS/2u+rvW1CAbjY06AB5NZrY5mikYDtUxQBcIPP+/N3FpSW
 mr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284105; x=1741888905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stCgZpQtE1zFYYbrS3BPR9VSrLJmwkhXSnn+AFxTDO4=;
 b=F70GTNyAOq4M6aZ26qwDcQjnMFPjF00+3R3mA/qFumKqDHDO93SyT145MA13oeFDAS
 47u1Vq9ClXDf7ogp+xvf9u7/RuDnxeCQEfAcz52P4rXZl8m1nCWqqiGJLGPu+2Sgyb0l
 gGaVirVqmp9xo6c+X9wzSVlVBhv+LFoB20IXLgtgqRwfDVkx3ohQO0rcWdhLEVaG2eLB
 Wfo2KMJsij+hH8q62W78Dy0HVvJhtUa/p5JOEjA0vCoBsBpNEr0d+weMgkl2Wv6bJafZ
 6ykD2asV2Xbjy0wZ7nbWKK+Vyj1/7MaV+Jq0os7pNBFZGTrMe0gqV5s88JoPXPFwNpAe
 Vcxg==
X-Gm-Message-State: AOJu0YySUQAxniLjEJluIwrEQmdWjIsdQ6fwjoPPusA469d16u8LnApx
 DRK/zqwz1WwSBub4cTlI2XuxTWtQDP47rGt78u4Y5Uh2Au7wsJly47+rRXyOEA==
X-Gm-Gg: ASbGncsAAk1MViZOKLq9h3hKHd0Ycgh4CS4nrZ5JtGhSqCfpCP4P1fb+eHrkKOYgssO
 uAPBoAagjVlmUzbbrzcWllkTQr9Bb4kwFDX0dElXo3YzCyXcYS6ljDzly0C/ErBrNiNIKQ7P60u
 MC7+nYQzZzTIaAmhpo7qaNaq0uknszQjHoJ4/xVZQ8jLudRGRREuS8iTUw7KNf7VbQ1Uu/udsfx
 9JANjRnH60RFdI03kZV8aHwnyWjUlz3ulFt+lee+hLT1s1lA09XZZHFo2Ub+zoRvJn0mpB2BIwp
 6z06LgZGXtasq/rgqqKYb9NmDb6Up7xWFEteatjMnA6xBIareEOFFsAWAw==
X-Google-Smtp-Source: AGHT+IG4JYNyfyeJViWCRhuaHcaPArr2NIPJdALGhMWAQM4oDSuzOb4yeNW4Fr/HLYT0S9dGrpSv7A==
X-Received: by 2002:a05:6a21:497:b0:1f1:2a5:1667 with SMTP id
 adf61e73a8af0-1f544c381e0mr822134637.32.1741284104552; 
 Thu, 06 Mar 2025 10:01:44 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:44 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 03/10] vfio/igd: Consolidate OpRegion initialization into a
 single function
Date: Fri,  7 Mar 2025 02:01:23 +0800
Message-ID: <20250306180131.32970-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180131.32970-1-tomitamoeko@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
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

Both x-igd-opregion option and legacy mode require identical steps to
set up OpRegion for IGD devices. Consolidate these steps into a single
vfio_pci_igd_setup_opregion function.

The function call in pci.c is wrapped with ifdef temporarily to prevent
build error for non-x86 archs, it will be removed after we decouple it
from legacy mode.

Additionally, move vfio_pci_igd_opregion_init to igd.c to prevent it
from being compiled in non-x86 builds.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 101 +++++++++++++++++++++++++++++++++++--------
 hw/vfio/pci-quirks.c |  50 ---------------------
 hw/vfio/pci.c        |  22 ++--------
 hw/vfio/pci.h        |   4 +-
 4 files changed, 88 insertions(+), 89 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index dda4c7bb5d..50e4007abe 100644
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
+    /* Hotplugging is not supprted for opregion access */
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
index fbe43b0a79..cac0aa1910 100644
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
index 89d900e9cf..098d17b866 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3132,30 +3132,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680a..4763f14415 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -228,9 +228,7 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                                struct vfio_region_info *info,
-                                Error **errp);
+bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
-- 
2.47.2


