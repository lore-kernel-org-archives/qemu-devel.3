Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F97BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0wr-0004jr-70; Mon, 03 Jun 2024 02:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wo-0004iY-Tf
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wn-0000uQ-4x
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395213; x=1748931213;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DzFkETpqsyCUSo4mpTVuvp6zaJicWw8iv9n76ZkukHM=;
 b=FX5C1DAsMocLJItY9l9EyoajCghR59koUSZmwB9sPp0BCBJSrBP8r5gJ
 CSz54bkaV1q0HBPROs4JWwSPKXCRvSg0uVts+Gd1Dxu89oTEHRAeroYYF
 BhjQxg24f1RGk5xTl+udhfxk/uvKkXfd3/lx3Q2uO0fKqO0/W1JO23pia
 EHjPCeDu/pVMIwmvbJ+OoOvPoSvXW+Nz1zhInXcrpene60UYwrJt7vydQ
 +5vxmFuNZU8S9dRlj5tltnpHYZ+TIXF2jKUwRESeQPnAyzoRUjEw0XvDK
 DNnDpsT7+O7wVxD8Unl+F7qEJ9+4KAtFkgFZQ7g+Ats4fwHxO/njoETK2 Q==;
X-CSE-ConnectionGUID: 0Hr9kC3zSnCGoRsTgB0bew==
X-CSE-MsgGUID: LxZldkP5QfO5N9iJ8oOLQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277648"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277648"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:32 -0700
X-CSE-ConnectionGUID: APkEOgYsTTe5TQ7XV1sb2w==
X-CSE-MsgGUID: NBPqAnmERL+4ku9Qqeaw0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855857"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Date: Mon,  3 Jun 2024 14:10:09 +0800
Message-Id: <20240603061023.269738-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/host_iommu_device.h | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 2b58a94d62..d47d1034b1 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -15,11 +15,25 @@
 #include "qom/object.h"
 #include "qapi/error.h"
 
+/**
+ * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
+ *
+ * @type: host platform IOMMU type.
+ *
+ * @aw_bits: host IOMMU address width. 0xff if no limitation.
+ */
+typedef struct HostIOMMUDeviceCaps {
+    uint32_t type;
+    uint8_t aw_bits;
+} HostIOMMUDeviceCaps;
+
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
 
 struct HostIOMMUDevice {
     Object parent_obj;
+
+    HostIOMMUDeviceCaps caps;
 };
 
 /**
@@ -47,5 +61,28 @@ struct HostIOMMUDeviceClass {
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
 #endif
-- 
2.34.1


