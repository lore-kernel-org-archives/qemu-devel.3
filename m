Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C38BC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdH1-00020x-LJ; Mon, 24 Feb 2025 13:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDQ-0005oW-R2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:05 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDH-0003Na-1h
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:30:03 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-220e83d65e5so90760845ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421791; x=1741026591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXOjZtgFlfgDDzD85XnbBJ3mLhtlWv0xEfuhDPGRItM=;
 b=k/xWBeuQjXnKTUpFyLGm6Px0PcAoH4cGDpAMMfrjcmKP3aWaTicweKAV3EP5SepoKx
 XOKO9eIK8nqULxT4xyGVhXOJ5UhcitQ6S8DlhJvGq7fPLBqIvomO4+raMSymBJbmcPX0
 Lb0V1KVhuelEdporSIXtWVmtJd0c54bIDAcXQG3ph3CTQQ1Rgi6vnY4VcXLWbZPD5RLp
 qNjmaykFcamHmUVSWzfquOZZ8IP9L1hfFbZMkSWyJrq1XTTPHXw6PQRIJjqpEvAPu+dG
 fmEuSXIc7B47nuIKpet2wNurEq1z2TYdDqSY7VjayfDWReQd3JHlgkeWvRkStHoDnG8F
 V8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421791; x=1741026591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXOjZtgFlfgDDzD85XnbBJ3mLhtlWv0xEfuhDPGRItM=;
 b=PPRFbweH4bx+zy9rujhyzNHv15E3gZuMLkj2bydoTi/nfXXIaVzZfgGDf+QimFSmgz
 9SVZ5za4L5X39F1W52RdF7S3/56RgwhpyKShbpPrgyY2NTVWPWeohsUZVmJZg1XRW97F
 khgKziNpsbq5C02dQRUroB1MP+ApaXKEFtwiqFaneP5phduN4aEpxpri8hwW1KmttupF
 VKAw+cKcA4+rTfrtknVG46pDzsub0t5PdyNd9gBEDFnAxst3cxxvr14T44F1sdGXd29O
 5e/qMmSLWi5j1XzsMMYID5r3+hdYVgy07Twb4oBjNA5KwDYbcnSSAm6M697Esao2i87w
 HCgQ==
X-Gm-Message-State: AOJu0Yw7SptFA/N4M4+kh2X0Q0CWN0hwgrYIPxR2CWeL6T/Qy0bj7DFd
 3d9so9sjNAVpgVndcLXyio2vLt9KGoaDyI4Q2hsMP7T0JfxVE6Z97EU4OZSpJQ==
X-Gm-Gg: ASbGnctspFqWIlGm6azmpjUL3Z9SwvaiLLvkekrbNPNIsEeRD0ZtAzxtEhvAjrAf+UC
 nucXqRQ4Q1IwZwOUmlMG1DKi67vz+73imtXAcohM7Gy/KIcdVX/dod3FLrvGRQ8CbKPsMuWm8ld
 aYh+vgcaOFsz+ksedaMEFcYNb4OiQY56C40X4n0zFuYSGoWD+ywXWLdFYvfrsFnD6GlO/V0Skmd
 fgGkzlad5TjpXRB2R/1oMfL1RWzxhfmakilC1qh2ZkUc8y3k5LF1vhAph1gXZj3uqP53tVi5epg
 AClR8iio/grN4T5RSfz8iN+G5wHQ9P81A3hk8E8=
X-Google-Smtp-Source: AGHT+IGTn3BRGTjR7r7wbP4M2yQxBmC/WB48+TKjpAnD7zwO9xi61IzgvUOtwy2hQ1GnrbZAitLivw==
X-Received: by 2002:a17:902:f70d:b0:220:fae9:8a4 with SMTP id
 d9443c01a7336-2219ff31c0cmr229795855ad.6.1740421791022; 
 Mon, 24 Feb 2025 10:29:51 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:50 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 06/10] vfio/igd: Consolidate OpRegion initialization into a
 single function
Date: Tue, 25 Feb 2025 02:29:23 +0800
Message-ID: <20250224182927.31519-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
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
build error for non-x86 archs, it will be removed later after the
removal of legacy mode.

Additionally, move vfio_pci_igd_opregion_init to igd.c to prevent it
from being compiled in non-x86 builds.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 111 +++++++++++++++++++++++++++++++++----------
 hw/vfio/pci-quirks.c |  50 -------------------
 hw/vfio/pci.c        |  22 ++-------
 hw/vfio/pci.h        |   4 +-
 4 files changed, 89 insertions(+), 98 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 32ae263c23..7c7461e22d 100644
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
@@ -339,9 +416,9 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
+
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
     g_autofree struct vfio_region_info *host = NULL;
     g_autofree struct vfio_region_info *lpc = NULL;
     PCIDevice *lpc_bridge;
@@ -389,29 +466,11 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /*
-     * Ignore the hotplug corner case, we can't create the devices we
-     * need for legacy mode in the hotplug scenario.
-     */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_report("IGD device %s hotplugged, legacy mode disabled",
-                     vdev->vbasedev.name);
-        return;
-    }
 
     /*
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
@@ -430,6 +489,13 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -446,13 +512,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /* Setup OpRegion access */
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
-        error_append_hint(&err, "IGD legacy mode disabled\n");
-        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        return;
-    }
-
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
 
     /*
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
index 1c45e3987e..56d7097a7a 100644
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
index 75505af6a3..ca7c0415f0 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -226,9 +226,7 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 
-bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
-                                struct vfio_region_info *info,
-                                Error **errp);
+bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
-- 
2.47.2


