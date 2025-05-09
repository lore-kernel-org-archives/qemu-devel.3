Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70126C3ABCC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNYo-0001xc-C9; Fri, 09 May 2025 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYI-0001o6-DA
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYG-00074N-5R
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5p/ESlZX+Zto3qw0RZkUh6LhqGtBlv90UkPLwIviJCA=;
 b=ZGxYNLc6C+yasOD1/rOQDUYREeveK3liE4CiDhzm8w0vxbsU3SRrUc8FsfMxb+OPxJ+qt6
 dgim5uZYe2NxCBn8AYhhQHA4nU1gGWcXOw1MpLk6VYw7/e93pOudL5DBfN0a4ytiCG6V6+
 pBxKtV5aMl8Kiy5KCqu5WECbGVgN3ag=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-Ia2eYU_gMSikrnYay6YTJg-1; Fri,
 09 May 2025 09:14:04 -0400
X-MC-Unique: Ia2eYU_gMSikrnYay6YTJg-1
X-Mimecast-MFC-AGG-ID: Ia2eYU_gMSikrnYay6YTJg_1746796443
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B12501956089; Fri,  9 May 2025 13:14:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3532180175D; Fri,  9 May 2025 13:13:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/28] vfio/igd: Remove generation limitation for IGD
 passthrough
Date: Fri,  9 May 2025 15:13:01 +0200
Message-ID: <20250509131317.164235-13-clg@redhat.com>
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

From: Tomita Moeko <tomitamoeko@gmail.com>

Starting from Intel Core Ultra Series (Meteor Lake), Data Stolen Memory
has became a part of LMEMBAR (MMIO BAR2) [1][2], meaning that BDSM and
GGC register quirks are no longer needed on these platforms.

To support Meteor/Arrow/Lunar Lake and future IGD devices, remove the
generation limitation in IGD passthrough, and apply BDSM and GGC quirks
only to known Gen6-12 devices.

[1] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gem/i915_gem_stolen.c?h=v6.14#n142

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-10-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/igd-assign.txt |  6 +++++
 hw/vfio/igd.c       | 58 ++++++++++++++++-----------------------------
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index fc444503ff310a317d5d6724b4656c29c4a7dc87..af4e8391fc25898906b0b8bf123e1ec44e45efc0 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -157,6 +157,12 @@ fw_cfg requirements on the VM firmware:
    it's expected that this fw_cfg file is only relevant to a single PCI
    class VGA device with Intel vendor ID, appearing at PCI bus address 00:02.0.
 
+   Starting from Meteor Lake, IGD devices access stolen memory via its MMIO
+   BAR2 (LMEMBAR) and removed the BDSM register in config space. There is
+   no need for guest firmware to allocate data stolen memory in guest address
+   space and write it to BDSM register. Value of this fw_cfg file is 0 in
+   such case.
+
 Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) support.
 However, the support is not accepted by upstream EDK2/OVMF. A recommended
 solution is to create a virtual OpRom with following DXE drivers:
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 886d44f017f415d5f82c892e630ae2de1637677c..3ee1a73b57c57563f661a246e6dd7e505231be91 100644
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
@@ -459,20 +460,12 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -519,7 +512,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
-    uint64_t gms_size;
+    uint64_t gms_size = 0;
     uint64_t *bdsm_size;
     uint32_t gmch;
     bool legacy_mode_enabled = false;
@@ -536,18 +529,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
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
@@ -645,32 +627,34 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
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
2.49.0


