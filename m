Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52507C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5N-0004dx-1x; Fri, 20 Jun 2025 03:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5L-0004dM-9Q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:51 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5I-0008IS-9b
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404168; x=1781940168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eXIY1EEbF1RfbgIJIQePt6T9VT6r816CRDXV+6DEzYs=;
 b=ZF7syC4SfZ2ibu4iRVlVBsATnMiMWPCTgWHOkoiZKStfTycCIvlq4bls
 aHevGhPqsqy/Yi3mdG41xcQzArMqHH8L7OURKKQpVj/XMLm3yZ+ednz8+
 lVR9HGZa7VZfolqnAGWOTs5uCZk7g0VcdJEpDX8j4zi7fToM9QKdy6tHd
 nqpYsffEaMPN7j5v2v3+Ozi8IHiweoIQxSIJnfweOqIggWsqqUAqVXDWs
 7kbfVreZIu9IB2atYcwKPlakZ2o2oKXzwUzc+EU9KTo1bCrGobvEJ9kQe
 vmHMmJMPXv7BTAcdD6P6WO9ah4JJQPsO7z4Ad4mwayTPAwfXAvwJJzLM5 Q==;
X-CSE-ConnectionGUID: t9Jz5NaTQO2UN/BtNp4Rlg==
X-CSE-MsgGUID: LSYsXCPcR96zqI+gJJCpQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532366"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532366"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:48 -0700
X-CSE-ConnectionGUID: BIL3ePNtS0aqS3G74NoEhQ==
X-CSE-MsgGUID: CEXQSQkZSzG+Z1nnzxt69g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863140"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 08/19] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Date: Fri, 20 Jun 2025 15:18:02 +0800
Message-Id: <20250620071813.55571-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently we don't support nested translation for passthrough device
with emulated device under same PCI bridge.

Reason is for emulated devices, AS should switch to iommu MR, while for
passthrough devices, it needs the AS stick with the system MR hence be
able to keep the VFIO container IOAS as a GPA IOAS. To support this, let
AS switch to iommu MR and have a separate GPA IOAS is needed, but that
brings a new memory listener which duplicates with VFIO memory listener.

For trade off, we choose to not support this special scenario because
PCIE bridge is more popular than PCI bridge now.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1c79efc1cb..9d4adc9458 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4330,9 +4330,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
-static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
+static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                            Error **errp)
 {
+    HostIOMMUDevice *hiod = vtd_hiod->hiod;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     int ret;
 
@@ -4359,6 +4360,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
 #ifdef CONFIG_IOMMUFD
     struct HostIOMMUDeviceCaps *caps = &hiod->caps;
     struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+    PCIBus *bus = vtd_hiod->bus;
+    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), vtd_hiod->devfn);
 
     /* Remaining checks are all stage-1 translation specific */
     if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
@@ -4381,6 +4384,12 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
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
 
     error_setg(errp, "host device is uncompatible with stage-1 translation");
@@ -4414,7 +4423,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hiod->iommu_state = s;
     vtd_hiod->hiod = hiod;
 
-    if (!vtd_check_hiod(s, hiod, errp)) {
+    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
         g_free(vtd_hiod);
         vtd_iommu_unlock(s);
         return false;
-- 
2.34.1


