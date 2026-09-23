Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B221C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9FUC-0006VB-0S; Wed, 23 Sep 2026 01:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x9FU8-0006Us-6q
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:25:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x9FU2-0004nA-Rp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790141131; x=1821677131;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GzdQ80VZCVhN3GNc9qsUbkA22r7r/Fl0uUBh6XnR5Lc=;
 b=Bocp47/PHsr4E2ArNsRFR5A/stf5ynZxiT1AOOTqpM+e7MH5qJySsiHf
 MvRTJxhQ8rqYkH71Pgj5VQQgtJNW009XgSe6AS4ozGm/u5xYQ/bhtczmO
 OHAfh5Hl2p2CDpt59rmS4e3ZQbt1ffoQ0YxchmCJZiX0uYzQGcmtKx61k
 Dn5AbdCzAsTmBrafah1PnkGHJaT8Hw3I52QFmhSa3oXCXHrb0B3pawEHs
 PKCxa9emKlbPmg6gU+l1EkH/QKId5fi0Xm6HeruFm8qAKKYUTjdw3hxMN
 WuXnJiyYLlGXeRLPrp7a7wYCH2Ef8iRIVUca9ORvhukgo8Q2aTYsh0Cb6 g==;
X-CSE-ConnectionGUID: buuO3wfERn+o1uLg3bZrFg==
X-CSE-MsgGUID: BK/gcwJHTaC/ADMeUHWYuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78354572"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="78354572"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 22:25:18 -0700
X-CSE-ConnectionGUID: gVN6XDQWSJ6JA/OLsYBCZg==
X-CSE-MsgGUID: y99kgHvyQBe5eh0l2J1P4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="273629384"
Received: from qat-wangyuan-17e.sh.intel.com ([10.239.92.81])
 by fmviesa008.fm.intel.com with ESMTP; 22 Sep 2026 22:25:14 -0700
From: Yuan Wang <yuan1.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, tomitamoeko@gmail.com,
 bosheng.xue@intel.com, junjie.cao@intel.com,
 Yuan Wang <yuan1.wang@intel.com>
Subject: [PATCH v5] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
Date: Wed, 23 Sep 2026 13:25:11 +0800
Message-Id: <20260923052511.2842596-1-yuan1.wang@intel.com>
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
v5:
- Rebased on top of Cédric's vfio-next branch to resolve conflicts
  with Mike's commit.

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
index 5e6160763c..4c7d654592 100644
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
 
@@ -452,8 +454,30 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
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
 
 /*
  * IGD BAR0 DBUF_CTL sanitize quirk.
@@ -547,7 +571,7 @@ static const MemoryRegionOps igd_dbuf_ctl_ops = {
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    VFIOQuirk *ggc_quirk, *bdsm_quirk;
+    VFIOQuirk *ggc_quirk, *bdsm_quirk, *pcode_stolen_access_quirk;
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
@@ -562,6 +586,25 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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


