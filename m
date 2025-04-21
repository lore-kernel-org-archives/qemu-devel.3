Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761ACC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u5n-0000uw-Rs; Mon, 21 Apr 2025 12:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4T-0008Di-RS
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4R-0003Kg-Kt
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:37 -0400
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-af590aea813so4859162a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253154; x=1745857954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1vNRoqzehudYEI0Q2G8mTJwn1LELvD7FXG1VA4lp34=;
 b=Umpz73WN17a1NsWzoPLlMuRhfcMEpLAqshlBoWyueQJPBnQxdpAaWXtgEfj7UzEghz
 e9xDkaWNyNYvbA1Ct0zVRJnF5bOi94wjcuLbJAi7VlV/dJxMQVpdBHiL4KkwBgN5o8cC
 1KComj68dnF0AZ30IxvSnHoK5rQ1CErB2z6ccRUJbjCSVWNhqENvklGLrkPMG3NSdl0d
 cCYkaJr0Kx4PVmDmC+maMGzSxmUJfhstlALnEcS5KzyerOCKGBc2zR5olktsBba2qCfk
 wEwcvT+WR1o3SOE2Tae3AKa4Te2IL8KjQGqEa5O1/lG4/ayeo9scyZ0+Wi2fCmg51zeG
 mULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253154; x=1745857954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J1vNRoqzehudYEI0Q2G8mTJwn1LELvD7FXG1VA4lp34=;
 b=iOBVfZAYRizkRQEzisvv/iyIiVdA3cukIz2S48mvcix3e8nlBVpg5jMKgaJpEngd5t
 hRA60Gg+drGaZUMIe/L2htWAViKg/CFxefc/D6RK4xbg5av5oENvRDkCl9+YEbVVf1jC
 PFdtOv3xg1OmhTQ0q2+jxC3ddbOzcAD4j5gQxfC51ujH84RkBsCkxlft1CwUGDvpaV5m
 Kt8PYKSgdb4R14qamnD2Lqe69Q53Z6uhLkshCt3UkWfnZJqV3Bw+lQlBz0Fq4sFWsxz7
 S+6FdTCiGuNE1c5gqePeX+BEMu+mAYxlLa+RTEv8cfEfOK3gPDHmxIPvyJkInhm12zgF
 SlhQ==
X-Gm-Message-State: AOJu0YzW/oAuhb9VbFOy68KVnXe26AmJRxnGII97WDbkBN3anawb79WY
 wjRXfLYZLLIGycPhUrgqATSzpzQbb9a0CKGc4A5qmGE2H6xowhgRPJZcCJJUdw==
X-Gm-Gg: ASbGncv2b12kHzVtxUz99tW85rabmXmIomQ0BXTd0veasOIWsF4ouvEV7L8hWF3XGjp
 TD5JRqwSyfb19rYHgysNMoIYRdHW0wB8muc+8vEZ16IfkHWo9fJ2LF2Kg/vluKOS3grrd3ChO0u
 Bb367BJzRGM9VoXaY6daOb97Y/FnkK4uWkH6z/ILfobWdQ1KvBIqwOmKFMX/jQoGtYt8VTz9c0i
 wq6uX6eN7Wo0Okc0LnHmqHAcyNA4CbWMClRL6AV6UpjDvP3lsIKP6jed3DPsTbLeBcYoEboC/ER
 6QjWCrQ8XLVyLLq6zA1IFW6kr/oQa1lhOndlDiUYMlPXmAVAL8fiOw==
X-Google-Smtp-Source: AGHT+IGSEVKkBuEueWU7f5Vj1M05pw0lJFM2nSDbbzrlrbrW9A5r1Ii2+1m4doUKBMdM83DNMqXIaA==
X-Received: by 2002:a17:90a:fc46:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-3087c1c120dmr18123052a91.0.1745253153757; 
 Mon, 21 Apr 2025 09:32:33 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:33 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 10/11] vfio/igd: Remove generation limitation for IGD
 passthrough
Date: Tue, 22 Apr 2025 00:31:10 +0800
Message-ID: <20250421163112.21316-11-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x541.google.com
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

Starting from Intel Core Ultra Series (Meteor Lake), Data Stolen Memory
has became a part of LMEMBAR (MMIO BAR2) [1][2], meaning that BDSM and
GGC register quirks are no longer needed on these platforms.

To support Meteor/Arrow/Lunar Lake and future IGD devices, remove the
generation limitation in IGD passthrough, and apply BDSM and GGC quirks
only to known Gen6-12 devices.

[1] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gem/i915_gem_stolen.c?h=v6.14#n142

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 58 +++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index bc4c79837d..5b888616f0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -103,6 +103,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
     /*
      * Unfortunately, Intel changes it's specification quite often. This makes
      * it impossible to use a suitable default value for unknown devices.
+     * Return -1 for not applying any generation-specific quirks.
      */
     return -1;
 }
@@ -434,20 +435,12 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode. Some driver have dependencies on the PCI
-     * bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
         !vfio_is_vga(vdev) || nr != 0) {
         return;
     }
 
-    /*
-     * Only on IGD devices of gen 11 and above, the BDSM register is mirrored
-     * into MMIO space and read from MMIO space by the Windows driver.
-     */
+    /* Only on IGD Gen6-12 device needs quirks in BAR 0 */
     gen = igd_gen(vdev);
     if (gen < 6) {
         return;
@@ -494,7 +487,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
-    uint64_t gms_size;
+    uint64_t gms_size = 0;
     uint64_t *bdsm_size;
     uint32_t gmch;
     bool legacy_mode_enabled = false;
@@ -514,18 +507,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     }
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
 
-    /*
-     * IGD is not a standard, they like to change their specs often.  We
-     * only attempt to support back to SandBridge and we hope that newer
-     * devices maintain compatibility with generation 8.
-     */
     gen = igd_gen(vdev);
-    if (gen == -1) {
-        error_report("IGD device %s is unsupported in legacy mode, "
-                     "try SandyBridge or newer", vdev->vbasedev.name);
-        return true;
-    }
-
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
 
     /*
@@ -624,32 +606,34 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    gms_size = igd_stolen_memory_size(gen, gmch);
+    if (gen > 0) {
+        gms_size = igd_stolen_memory_size(gen, gmch);
+
+        /* BDSM is read-write, emulated. BIOS needs to be able to write it */
+        if (gen < 11) {
+            pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
+            pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+            pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+        } else {
+            pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
+            pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+            pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
+        }
+    }
 
     /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
      * must allocate a 1MB aligned reserved memory region below 4GB with
-     * the requested size (in bytes) for use by the Intel PCI class VGA
-     * device at VM address 00:02.0.  The base address of this reserved
-     * memory region must be written to the device BDSM register at PCI
-     * config offset 0x5C.
+     * the requested size (in bytes) for use by the IGD device. The base
+     * address of this reserved memory region must be written to the
+     * device BDSM register.
+     * For newer device without BDSM register, this fw_cfg item is 0.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
     *bdsm_size = cpu_to_le64(gms_size);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
-    /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
-    if (gen < 11) {
-        pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-        pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
-        pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
-    } else {
-        pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
-        pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
-        pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
-    }
-
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
 
     return true;
-- 
2.47.2


