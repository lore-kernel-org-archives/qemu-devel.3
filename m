Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBDC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H2p-0000Ih-Gf; Tue, 07 May 2024 05:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2k-0000Gv-0B
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:26 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2g-00008K-Oc
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073802; x=1746609802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RX2fAFEu8NLNPJBGUTeGn0McGuribAHcX7nCTvynIQI=;
 b=Vldtuv+39HTyf4jln5DqQAHg9I9BYG0LeCIPFeKyCK3XyrRwE+y2p3N6
 VwEEfMJ94hgUeCra9JGZ9QUOtz/XxGx8DwnMEgT1u2/8BFtxj+CLSCLPM
 sKHyNj7TAsuW2qb8t2W9UQjrYtlo1qw6EKVtKHQ9WBOu+3W/w5SBRdjZ5
 0qys5BHW/1CgcmsP3F0OiyuQYgHM6yZFhXvozlcVFx6xvz/KZM6OxOACH
 FigbfLiFlqDNAGn7XlfrU9nC+NdzlIqTUsPN+VEdTBM6ad3nuabyRk/Fw
 6kYGGdRpV1KOe6SZ7XTwMMmO8dgOnauld5/YEx+dF09pIf132mfbTxXSs w==;
X-CSE-ConnectionGUID: rrgYcp3aSy20hAB/bPr8dA==
X-CSE-MsgGUID: uNeXxF+5SXSMxqvYBw7B3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785209"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:21 -0700
X-CSE-ConnectionGUID: ruIMzTQOQOepKpPXCORZcQ==
X-CSE-MsgGUID: iN4k08EeTtyx+Z0l4o34uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553270"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Date: Tue,  7 May 2024 17:20:29 +0800
Message-Id: <20240507092043.1172717-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

HostIOMMUDeviceCaps's elements map to the host IOMMU's capabilities.
Different platform IOMMU can support different elements.

Currently only two elements, type and aw_bits, type hints the host
platform IOMMU type, i.e., INTEL vtd, ARM smmu, etc; aw_bits hints
host IOMMU address width.

Introduce .get_cap() handler to check if HOST_IOMMU_DEVICE_CAP_XXX
is supported.

Introduce a HostIOMMUDevice API host_iommu_device_get_cap() which
is a wrapper of .get_cap().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/host_iommu_device.h | 41 ++++++++++++++++++++++++++++++
 backends/host_iommu_device.c       | 12 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 2b58a94d62..680c2a311a 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -14,12 +14,27 @@
 
 #include "qom/object.h"
 #include "qapi/error.h"
+#include <linux/iommufd.h>
+
+/**
+ * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
+ *
+ * @type: host platform IOMMU type.
+ *
+ * @aw_bits: host IOMMU address width. 0xff if no limitation.
+ */
+typedef struct HostIOMMUDeviceCaps {
+    enum iommu_hw_info_type type;
+    uint8_t aw_bits;
+} HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
 
 struct HostIOMMUDevice {
     Object parent_obj;
+
+    HostIOMMUDeviceCaps caps;
 };
 
 /**
@@ -47,5 +62,31 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
+    /**
+     * @get_cap: check if a host IOMMU device capability is supported.
+     *
+     * Optional callback, if not implemented, hint not supporting query
+     * of @cap.
+     *
+     * @hiod: pointer to a host IOMMU device instance.
+     *
+     * @cap: capability to check.
+     *
+     * @errp: pass an Error out when fails to query capability.
+     *
+     * Returns: <0 on failure, 0 if a @cap is unsupported, or else
+     * 1 or some positive value for some special @cap,
+     * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
+     */
+    int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
 };
+
+/*
+ * Host IOMMU device capability list.
+ */
+#define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    0
+#define HOST_IOMMU_DEVICE_CAP_AW_BITS       1
+
+
+int host_iommu_device_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp);
 #endif
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
index 41f2fdce20..0fcc201af3 100644
--- a/backends/host_iommu_device.c
+++ b/backends/host_iommu_device.c
@@ -28,3 +28,15 @@ static void host_iommu_device_init(Object *obj)
 static void host_iommu_device_finalize(Object *obj)
 {
 }
+
+/* Wrapper of HostIOMMUDeviceClass:get_cap */
+int host_iommu_device_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
+{
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc->get_cap) {
+        error_setg(errp, ".get_cap() not implemented");
+        return -EINVAL;
+    }
+
+    return hiodc->get_cap(hiod, cap, errp);
+}
-- 
2.34.1


