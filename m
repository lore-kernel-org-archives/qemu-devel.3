Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42FCC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggXM-0005Z0-LO; Tue, 29 Jul 2025 05:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWg-0004rO-B1
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:42 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggWe-0002cE-9i
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780896; x=1785316896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nzqQ5VR40rluhIOv+CGq1GjKJXz0vEMcuNbkwrxfyd4=;
 b=GBtd4aYHKn65fx56mpwZGig0Qp70gX818oYocq72F4rsslRQUhaHM46O
 1Vs/6wIoM0F+x2nEEhhba4ojzkhcMOyDKEDMyx5gQRvfNbCN5c1+j+OaT
 2CcsqTXNAXMLCb14DLKFMaAavFJkZmSunBhvTJLjZaZ5tRbpjBwRUNj8u
 mkRaz34/Q2gM58M7wrty+s0T4Py+GJ1NUiAfVQqUpRAcWJ0qUx0fgcBX9
 GcU89EVk0Ry1xId5pUk4+9iOzBd0V6ni04DyFwPRqOEV55OsGYekOvEIT
 TvDTGmybvnSykqxA5XpCAAGZG837YZE5/2KG/RF0u6sByFxOtFKubRcOR Q==;
X-CSE-ConnectionGUID: iCQepgC9Rlyxf5k4pLKk5w==
X-CSE-MsgGUID: qEiUtLnFTXuXe9lT3OtCHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981921"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981921"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:33 -0700
X-CSE-ConnectionGUID: s+XqSS4QQxm/O7XBRwTivg==
X-CSE-MsgGUID: fhvhjo6WQ7uH42gu+2hV7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691256"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 08/20] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Date: Tue, 29 Jul 2025 05:20:30 -0400
Message-ID: <20250729092043.785836-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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

Currently we don't support nested translation for passthrough device with
emulated device under same PCI bridge, because they require different address
space when x-flts=on.

In theory, we do support if devices under same PCI bridge are all passthrough
devices. But emulated device can be hotplugged under same bridge. To simplify,
just forbid passthrough device under PCI bridge no matter if there is, or will
be emulated devices under same bridge. This is acceptable because PCIE bridge
is more popular than PCI bridge now.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 33e498b3bd..1410ddd65e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4338,9 +4338,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
-static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                            Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     int ret;
 
@@ -4367,6 +4368,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
 #ifdef CONFIG_IOMMUFD
     struct HostIOMMUDeviceCaps *caps = &hiod->caps;
     struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+    PCIBus *bus = vtd_hiod->bus;
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), vtd_hiod->devfn);
 
     /* Remaining checks are all stage-1 translation specific */
     if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
@@ -4389,6 +4392,12 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
         return false;
     }
+
+    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
+        error_setg(errp, "Host device under PCI bridge is unsupported "
+                   "when x-flts=on");
+        return false;
+    }
 #endif
 
     error_setg(errp, "host IOMMU is incompatible with stage-1 translation");
@@ -4422,7 +4431,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
 
-    if (!vtd_check_hiod(s, hiod, errp)) {
+    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
         g_free(vtd_hiod);
         vtd_iommu_unlock(s);
         return false;
-- 
2.47.1


