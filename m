Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29579C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H4j-0003XO-P3; Tue, 07 May 2024 05:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3r-0001DV-Aj
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:35 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3k-0000Bi-93
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073868; x=1746609868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3/+z84KmMKFWfq3QNUgQrXw0OJL3z4Glfwf5rFi/pZE=;
 b=QqDSArtfCSA2UiRQtJNE4xX+xSmcThM6FGVs9oT9pGqDDf76EEbIRLbZ
 RjHo/8e7Zc4UryF3fOoGlc3SB8ayi6Lu6YqNvsdyL9xxscVwh0wmQKkAr
 A+yOk71s+K1UFRgiEEsnXcKSZTPjMFW22rS6vRFD6/+n2w0JoWu9QIhlQ
 /7FQIbZKFLIJBlh5sg0i/yI2BuQgtp5X8IOSLlsH+RaOCsRmmZtGnFOa9
 k2s0TDZLB639qkVWK16KEYkNuX/48rnd2A7lcPJ8Csvh/YFVFQNF68UcQ
 qzpZqKZqQsc8e0UOO1WgL3lXy96taCjXR9B2SZnK1B6Fvm5/xiUlNZPVu A==;
X-CSE-ConnectionGUID: gxDPmfikTTm0E0L5Srd5Bw==
X-CSE-MsgGUID: Cu/JfiaLS0Oc5nUMrRCyfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785367"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785367"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:24:22 -0700
X-CSE-ConnectionGUID: 8WBviFWnSQWDIpz86d+rQw==
X-CSE-MsgGUID: B0srRDbxT1mR+ToAgplihw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553563"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:24:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Date: Tue,  7 May 2024 17:20:43 +0800
Message-Id: <20240507092043.1172717-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

If check fails, host device (either VFIO or VDPA device) is not
compatible with current vIOMMU config and should not be passed to
guest.

Only aw_bits is checked for now, we don't care other capabilities
before scalable modern mode is introduced.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 747c988bc4..146fde23fc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/host_iommu_device.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
@@ -3819,6 +3820,25 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
+                           Error **errp)
+{
+    HostIOMMUDevice *hiod = vtd_hdev->dev;
+    int ret;
+
+    /* Common checks */
+    ret = host_iommu_device_get_cap(hiod, HOST_IOMMU_DEVICE_CAP_AW_BITS, errp);
+    if (ret < 0) {
+        return false;
+    }
+    if (s->aw_bits > ret) {
+        error_setg(errp, "aw-bits %d > host aw-bits %d", s->aw_bits, ret);
+        return false;
+    }
+
+    return true;
+}
+
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
@@ -3848,6 +3868,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hdev->iommu_state = s;
     vtd_hdev->dev = hiod;
 
+    if (!vtd_check_hdev(s, vtd_hdev, errp)) {
+        g_free(vtd_hdev);
+        vtd_iommu_unlock(s);
+        return false;
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
-- 
2.34.1


