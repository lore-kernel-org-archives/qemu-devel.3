Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947DBC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ybk-0005rn-NZ; Mon, 21 Sep 2026 03:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8Ybi-0005rQ-DA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:38:34 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8Ybf-0005Ro-UA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789976312; x=1821512312;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aC10MtvSEReJa8/ZXreZ42tGkf3T2V/EMZN8IIGQ8fw=;
 b=FCz35LqMlnx326q9g/dBj2CyURX8Pj2GHvMplYJHXZ9dYW+4xRgaAjPN
 xYTfK8SmsNVgVAqui4SX7Nhloy3gAbURj2BlwuI2mBWteLr8LeHBUuFsS
 88cneorKpqhT5RJY8/9i/ysar+gjQkrW7x/VRbcYTNzo1c2glNpPMPv2M
 f0tJKistLCIqGvuRzut3tp0v+9BZVNjOpeojhJgIYYA/07Z/ABN0HVeAF
 GfjSlwIaIa+1T+grq89HZ+tYS8Ws1Xvi56ols1WA7vW6pLmqyy5kjr9hP
 P9L94jv6Uo5xBoUJzoX/2NQveWRxmx7mV6SZ53mBCbikUxy9CfOGratw2 A==;
X-CSE-ConnectionGUID: ENu1naoRS/S9Uyxft1OQtQ==
X-CSE-MsgGUID: s+LTOlFSQkS4LZqioK0huQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101067201"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="101067201"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 00:38:23 -0700
X-CSE-ConnectionGUID: 9ZJCUq2XQGqQkpELzY30fA==
X-CSE-MsgGUID: fkxeaPJES0iGIp5vmdPN3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="277334125"
Received: from qat-wangyuan-17e.sh.intel.com ([10.239.92.81])
 by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 00:38:21 -0700
From: Yuan Wang <yuan1.wang@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, tomitamoeko@gmail.com,
 bosheng.xue@intel.com, junjie.cao@intel.com,
 Yuan Wang <yuan1.wang@intel.com>
Subject: [PATCH v3] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
Date: Mon, 21 Sep 2026 15:38:09 +0800
Message-Id: <20260921073809.2658872-1-yuan1.wang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yuan1.wang@intel.com;
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
Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
---
Changes:
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
 hw/vfio/igd.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 413a49aae9..f6a2eab805 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x4C00:    /* Rocket Lake */
     case 0x4600:    /* Alder Lake */
     case 0xA700:    /* Raptor Lake */
+    case 0x7D00:    /* Meteor Lake / Arrow Lake */
+    case 0xB600:    /* Meteor Lake */
         return 12;
     }
 
@@ -454,10 +456,32 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
 
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
+#define IGD_BDSM_ACCESS         0x138914
+
+#define IGD_IS_MTL_OR_ARL(vdev) \
+    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
+     (((vdev)->device_id & 0xff00) == 0xb600))
+
+static uint64_t vfio_igd_bdsm_access_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    return 0;
+}
+
+static void vfio_igd_bdsm_access_write(void *opaque, hwaddr addr,
+                                       uint64_t data, unsigned size)
+{
+}
+
+static const MemoryRegionOps vfio_igd_bdsm_access_quirk = {
+    .read = vfio_igd_bdsm_access_read,
+    .write = vfio_igd_bdsm_access_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    VFIOQuirk *ggc_quirk, *bdsm_quirk;
+    VFIOQuirk *ggc_quirk, *bdsm_quirk, *bdsm_access_quirk;
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
@@ -472,6 +496,23 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
+    /*
+     * MTL/ARL guests must keep using the BAR-based framebuffer address.
+     * Return 0 at 0x138914 so GOP stays on the standard access path in the VM.
+     */
+    if (IGD_IS_MTL_OR_ARL(vdev)) {
+        bdsm_access_quirk = vfio_quirk_alloc(1);
+        memory_region_init_io(bdsm_access_quirk->mem, OBJECT(vdev),
+                              &vfio_igd_bdsm_access_quirk, vdev,
+                              "vfio-igd-bdsm-access-quirk", 4);
+        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                            IGD_BDSM_ACCESS,
+                                            bdsm_access_quirk->mem,
+                                            1);
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_access_quirk, next);
+    }
+
     if (vdev->igd_gms) {
         ggc_quirk = vfio_quirk_alloc(1);
         ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
-- 
2.34.1


