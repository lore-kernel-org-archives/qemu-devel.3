Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5BFC982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tBt-0007w9-JA; Tue, 22 Sep 2026 01:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8tBr-0007vh-7F
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:37:15 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8tBo-0007uG-8l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790055432; x=1821591432;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=16GSDUfnCzoWmPo/ZEZ2Onmp82IVxzOOqISR2OG7tdY=;
 b=EVotYV404cbBpawDBUE6Y0MbtOQQfNTsnVWLtpTHSkWO9ZHjsB4ESnHa
 jYuQ26Gg+JqIGNFCCJaeCh6bZplcLmJ+66A9JfI/nwS/+QKeKAyEHps9v
 Oc60fk5ELgNFkceRwgFghE5ZCFIomWK+TQ/z3rtweT5THGizKs3kn/N9h
 9+kRafRK9HgXWI9FrExc1kxTG/m7DB1ytaLgyws6ExaF5P2MNJjZ8KbrR
 69L9bUc6ydmq+d6PtA49LQ4sdle3J5bEPyIfe1ZyV+0KYjYxbcqEULsD1
 WPMhxnwwpQVutrso/LhwyXnG8kjLbpe8jh2B0/0wh2JzAOR1h6t+rlBQr g==;
X-CSE-ConnectionGUID: hEKAP3gDQ86pGfj892z/Ow==
X-CSE-MsgGUID: /Xl5g8o6SHGnXUEZakG2ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="78181598"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="78181598"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 22:37:08 -0700
X-CSE-ConnectionGUID: 10u07CziQhayCDCGoNBMiw==
X-CSE-MsgGUID: mlJCyYVhSGKWEO4OrOdZvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="281037310"
Received: from qat-wangyuan-17e.sh.intel.com ([10.239.92.81])
 by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2026 22:37:06 -0700
From: Yuan Wang <yuan1.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, tomitamoeko@gmail.com,
 bosheng.xue@intel.com, junjie.cao@intel.com,
 Yuan Wang <yuan1.wang@intel.com>
Subject: [PATCH v4] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
Date: Tue, 22 Sep 2026 13:36:58 +0800
Message-Id: <20260922053658.2758332-1-yuan1.wang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
detect whether direct framebuffer access via DSM is available.

In a VFIO passthrough VM, the guest cannot access the host DSM memory
region via such a pointer. If the guest GOP enables that path, it may
hand off a DSM-based framebuffer address that the guest cannot actually
use.

Intercept reads from the detection register and return 0 so the guest
does not enable the DSM-based path and instead keeps using the standard
BAR-based framebuffer address.

Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
Changes:
v4:
- Address review comments from Tomita Moeko (update macro/variable
  names and comments).
- Pick up Reviewed-by tags from Tomita Moeko and Cédric Le Goater.

v3:
- Emulated register 0x138914 to return 0x0, which signals the guest
  GOP driver to fall back to BAR-based mapping since DSM is
  unavailable in the VM.

v2:
- Resending because the v1 patch was sent with an incorrect future
  system timestamp due to an unsynchronized local clock. No code
  changes.

Notes:
MTL/ARL device IDs remain in igd_gen().
This is required because vfio_probe_igd_bar0_quirk() checks the
generation before installing BAR0 quirks, and the 0x138914 quirk
is added afterward.
Meanwhile, we also plan to remove the bdsm-size check in the OVMF
offline patches.
---
 hw/vfio/igd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 413a49aae9..fe9ffc93c8 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x4C00:    /* Rocket Lake */
     case 0x4600:    /* Alder Lake */
     case 0xA700:    /* Raptor Lake */
+    case 0x7D00:    /* Meteor Lake / Arrow Lake */
+    case 0xB600:    /* Arrow Lake */
         return 12;
     }
 
@@ -452,12 +454,34 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
     return ret;
 }
 
-#define IGD_GGC_MMIO_OFFSET     0x108040
-#define IGD_BDSM_MMIO_OFFSET    0x1080C0
+#define IGD_GGC_MMIO_OFFSET         0x108040
+#define IGD_BDSM_MMIO_OFFSET        0x1080C0
+#define IGD_MTL_PCODE_STOLEN_ACCESS 0x138914
+
+#define IGD_IS_MTL_OR_ARL(vdev) \
+    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
+     (((vdev)->device_id & 0xff00) == 0xb600))
+
+static uint64_t vfio_igd_pcode_stolen_access_read(void *opaque, hwaddr addr,
+                                                  unsigned size)
+{
+    return 0;
+}
+
+static void vfio_igd_pcode_stolen_access_write(void *opaque, hwaddr addr,
+                                               uint64_t data, unsigned size)
+{
+}
+
+static const MemoryRegionOps vfio_igd_pcode_stolen_access_quirk = {
+    .read = vfio_igd_pcode_stolen_access_read,
+    .write = vfio_igd_pcode_stolen_access_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    VFIOQuirk *ggc_quirk, *bdsm_quirk;
+    VFIOQuirk *ggc_quirk, *bdsm_quirk, *pcode_stolen_access_quirk;
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
@@ -472,6 +496,25 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
+    /*
+     * MTL/ARL guests must keep using the BAR-based framebuffer address.
+     * Return 0 for PCODE stolen memory access detection (0x138914) so GOP
+     * stays on the standard access path in the VM.
+     */
+    if (IGD_IS_MTL_OR_ARL(vdev)) {
+        pcode_stolen_access_quirk = vfio_quirk_alloc(1);
+        memory_region_init_io(pcode_stolen_access_quirk->mem, OBJECT(vdev),
+                              &vfio_igd_pcode_stolen_access_quirk, vdev,
+                              "vfio-igd-pcode-stolen-access-quirk", 4);
+        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                            IGD_MTL_PCODE_STOLEN_ACCESS,
+                                            pcode_stolen_access_quirk->mem,
+                                            1);
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks,
+                          pcode_stolen_access_quirk, next);
+    }
+
     if (vdev->igd_gms) {
         ggc_quirk = vfio_quirk_alloc(1);
         ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
-- 
2.34.1


