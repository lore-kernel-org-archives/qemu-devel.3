Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1DEC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNsG-00063K-5A; Mon, 28 Jul 2025 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ugMz4-00065Q-A8
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:29:38 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ugMz1-0002XC-HN
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753705776; x=1785241776;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Y045cRMYcy33/KIHJAMmZrd/TsvpU3q0DM/HumsQBo0=;
 b=iUy6as5K/3otVz6DrP2RjKrBbt4hJTMRJuZNu1Q40/dzThyuOepRhTrd
 EclTKy4c/Hf8ijaBxQXAzRgOi0OZEWDBGQoWA1pl4E7bq2LU+Ex9lbRjR
 wDzJTXrC3fm8qpFojKxUCcqamkLc6l38TjLkI7gmMkO4FCnfrDZ1Ntb9L
 CO6iOeWu+4Tmj8OJYiAKL+ZWvwimsQV8h0ItLf8x1RQqto0qggZB9itWP
 gEO4YPNSW+h4bGttvdZoz9VYpkMEsYViVPH2xfHozHvqiWGI9goJm8f5e
 B+08CZlPIwUZZ0UK7L/1pUg8BLVIu0zE2TRT62meCjgXPd38MKMn/CPip Q==;
X-CSE-ConnectionGUID: 4kIa61i9Q0iDlkxZ22/xlg==
X-CSE-MsgGUID: lwDwZk7yS6iO5v6bm7twjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55030527"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55030527"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:29:29 -0700
X-CSE-ConnectionGUID: cqGFErJYRrWygs5oNrh1uw==
X-CSE-MsgGUID: VNmSyISVSiOZWb96ud2u4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="167733322"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:29:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, slp@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, shahuang@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/pci: Fix regression due to unexisting property
 use-legacy-x86-rom
Date: Mon, 28 Jul 2025 08:29:06 -0400
Message-ID: <20250728122906.39703-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

TYPE_VFIO_PCI doesn't have property use-legacy-x86-rom, but
TYPE_VFIO_PCI_NOHOTPLUG has. The compatibility config leads to
SIGABRT on new QEMU.

The default value of element use_legacy_x86_rom for TYPE_VFIO_PCI is
already false, so no need extra processing.

Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/types.h   | 2 ++
 hw/core/machine.c | 2 +-
 hw/i386/microvm.c | 2 +-
 hw/i386/pc_piix.c | 2 +-
 hw/i386/pc_q35.c  | 2 +-
 hw/vfio/pci.c     | 2 --
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/types.h b/hw/vfio/types.h
index fa20c29b9f..c19334ff25 100644
--- a/hw/vfio/types.h
+++ b/hw/vfio/types.h
@@ -18,4 +18,6 @@
 #define TYPE_VFIO_PCI "vfio-pci"
 /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
 
+#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
+
 #endif /* HW_VFIO_VFIO_TYPES_H */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d6b2240fc2..bd47527479 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
     { "ramfb", "use-legacy-x86-rom", "true"},
-    { "vfio-pci", "use-legacy-x86-rom", "true" },
+    { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d90b69a162..94d22a232a 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -635,7 +635,7 @@ GlobalProperty microvm_properties[] = {
      */
     { "pcie-root-port", "io-reserve", "0" },
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
-    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
 };
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ad5caff3a5..c03324281b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -80,7 +80,7 @@ static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
 
 static GlobalProperty pc_piix_compat_defaults[] = {
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
-    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
 };
 static const size_t pc_piix_compat_defaults_len =
     G_N_ELEMENTS(pc_piix_compat_defaults);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9b9519fa02..b309b2b378 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -69,7 +69,7 @@
 static GlobalProperty pc_q35_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
     { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
-    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
+    { TYPE_VFIO_PCI_NOHOTPLUG, "use-legacy-x86-rom", "true" },
 };
 static const size_t pc_q35_compat_defaults_len =
     G_N_ELEMENTS(pc_q35_compat_defaults);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e72d514a4c..0c4606d9cb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -49,8 +49,6 @@
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
 
-#define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
-
 /* Protected by BQL */
 static KVMRouteChange vfio_route_change;
 
-- 
2.47.1


