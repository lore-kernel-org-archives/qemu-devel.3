Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9E4C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dID-0003yH-K4; Wed, 08 May 2024 05:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHy-0003gk-54
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:08:40 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHu-0006As-HI
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159315; x=1746695315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hekfpiha/Rj7V7KVBExc5NCKEYWksRlYB1K0ySsENCU=;
 b=QEcuNHq+z5QbbzQjUxm5VNcq1Hh82VJ5ixnuq4XEpylX/R6LYFf+2ZXj
 oSax6IFsO2R/pD6PHRk7I3OfhIb1CujCpyXNMUacZQ1d57VFtVK+6/JLX
 YSFWwn6dQrC+1YwgJo9UFyE0NQJGFaubCsuGp+wVBY9VP80EVI+7I8duw
 lU+qFrmdO4JuOaFeTtuMUE4PekpYpLSauNEkC5WaMGLq1yGTahxxNF300
 poufUvUM9J9Asb6mHWFMi2DYWcnqkFk4qwY/l9kfFKhkgq5x5ILExtNI2
 1Ytet1f+I05YMGEOR71/2h3gobamR6+/lDwQbEaWhSVCXYmWrte5mWH6j A==;
X-CSE-ConnectionGUID: 0GscNwmAQyWnEQ7L/e14dA==
X-CSE-MsgGUID: oinWrxCASx+Jze2vPrTsmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11161138"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11161138"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:08:22 -0700
X-CSE-ConnectionGUID: pVLPV03DT3ObTmfDQA6aUw==
X-CSE-MsgGUID: Dhg9q+PtRSuMz670DFobpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226732"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:08:17 -0700
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
Subject: [PATCH v5 19/19] intel_iommu: Check compatibility with host IOMMU
 capabilities
Date: Wed,  8 May 2024 17:03:54 +0800
Message-Id: <20240508090354.1815561-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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
 hw/i386/intel_iommu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 747c988bc4..07bfd4f99e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_HOST_IOMMU_DEVICE */
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
@@ -3819,6 +3820,26 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
+                           Error **errp)
+{
+#ifdef CONFIG_HOST_IOMMU_DEVICE
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
+#endif
+    return true;
+}
+
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
@@ -3848,6 +3869,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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


