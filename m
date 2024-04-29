Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3968AC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KtV-0001XF-Q1; Mon, 29 Apr 2024 02:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtT-0001Wq-V2
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:43 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtS-0007m1-6g
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373622; x=1745909622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FX29BWfSJ5th0EheL5Ks2a0B1BRSPTJ17MVEKJPsvS8=;
 b=DJfoskpajZ2ut/hQIMiJJE4gxpQKSqdLmZOj+b5hodqzvwUdD9puda/R
 5mvIWWc7g837bJCbrsw1xFNbtm+Z5ni03CYrEGAZHOWBQC2UNq9d8ZjY1
 8RE9kM5QjTOxyN94YHz4ctvh9A8u4pzYx3ValasRVFDWT8DyX1JCWvkQF
 PkwBfPE6TcUFHDLoG+csNUDexqPwnDqjeOypts7lIZZd1L7V0VJkYn5aJ
 a0vl07+vIBYqU0HsnT0LrmyjXy3qcScIaAjEppv5xRsNoTGe9G+dw5muZ
 tXgXLrwNuDyPHXu6t3VdCfQk7KhwolV93FMCSQXiGw8FFtZP6xjJjn8xM A==;
X-CSE-ConnectionGUID: JaAvL3WRQ1mKFSgo8BpFTg==
X-CSE-MsgGUID: wiyE7otvSNyUBQ3EKLpirQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560683"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:42 -0700
X-CSE-ConnectionGUID: faXnbBcOQECHSTPap0XbHg==
X-CSE-MsgGUID: FNqbtvvgRp23VEEIkaVcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63487994"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Date: Mon, 29 Apr 2024 14:50:32 +0800
Message-Id: <20240429065046.3688701-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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

Introduce .check_cap() handler to check if HOST_IOMMU_DEVICE_CAP_XXX
is supported.

Introduce a HostIOMMUDevice API host_iommu_device_check_cap() which
is a wrapper of .check_cap().

Introduce a HostIOMMUDevice API host_iommu_device_check_cap_common()
to check common capabalities of different host platform IOMMUs.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/host_iommu_device.h | 44 ++++++++++++++++++++++++++++++
 backends/host_iommu_device.c       | 29 ++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 2b58a94d62..12b6afb463 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -14,12 +14,27 @@
 
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "linux/iommufd.h"
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
@@ -47,5 +62,34 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
+    /**
+     * @check_cap: check if a host IOMMU device capability is supported.
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
+    int (*check_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
 };
+
+/*
+ * Host IOMMU device capability list.
+ */
+#define HOST_IOMMU_DEVICE_CAP_IOMMUFD       0
+#define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    1
+#define HOST_IOMMU_DEVICE_CAP_AW_BITS       2
+
+
+int host_iommu_device_check_cap(HostIOMMUDevice *hiod, int cap, Error **errp);
+int host_iommu_device_check_cap_common(HostIOMMUDevice *hiod, int cap,
+                                       Error **errp);
 #endif
diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
index 41f2fdce20..b97d008cc7 100644
--- a/backends/host_iommu_device.c
+++ b/backends/host_iommu_device.c
@@ -28,3 +28,32 @@ static void host_iommu_device_init(Object *obj)
 static void host_iommu_device_finalize(Object *obj)
 {
 }
+
+/* Wrapper of HostIOMMUDeviceClass:check_cap */
+int host_iommu_device_check_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
+{
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc->check_cap) {
+        error_setg(errp, ".check_cap() not implemented");
+        return -EINVAL;
+    }
+
+    return hiodc->check_cap(hiod, cap, errp);
+}
+
+/* Implement check on common IOMMU capabilities */
+int host_iommu_device_check_cap_common(HostIOMMUDevice *hiod, int cap,
+                                       Error **errp)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
+        return caps->type;
+    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
+        return caps->aw_bits;
+    default:
+        error_setg(errp, "Not support query cap %x", cap);
+        return -EINVAL;
+    }
+}
-- 
2.34.1


