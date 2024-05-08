Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AF4C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dH9-0000B4-0H; Wed, 08 May 2024 05:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGr-00007O-An
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:30 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGn-0005S1-GA
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159246; x=1746695246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=15cgjyTdq3RQ+ajo/M6kOTL4pynkB+V+xA7Xu9sIZ9U=;
 b=R6VUGTGhDVndBHzYi5ume9wH6kR224O1ORGOjF20W4Ek9TzD3aboqfl1
 MCdB7U+P5dyM2vq/ihu0PeLVzv6Ck1LxqwnWpkCsfDtLfjFbNP0Kwd+jr
 tRdr6ld/bbqjqHEOitHgvFqLqXAYuJzGur8q3I2dlwdAn3gTXpK33ma7o
 8KurqgBVoigA+xqBDaNQCBFVxFm4Y+1kwORjUFYuM1ROPNv2FaJyVzjUp
 iBQ+1E+5hrHeLat6xhZ9mTu1bTrzHOLb92Ne6thx4n0ntgFtnVxZFnUDe
 Xugct58lc8WuEisEqrOKnYSOthLiSRDjNIj2HGpJ0gZ7qWmQJVOES+s7W A==;
X-CSE-ConnectionGUID: /U1O6P4PSpShqlo8lJyeFA==
X-CSE-MsgGUID: DFNRx/OcSmqcFdrdaN9dYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11160947"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11160947"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:21 -0700
X-CSE-ConnectionGUID: JGXo3fisRwynItDYLpvNFw==
X-CSE-MsgGUID: O4KNJgGBQCSNgm8wuvihUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226479"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 05/19] backends/host_iommu_device: Introduce
 HostIOMMUDeviceCaps
Date: Wed,  8 May 2024 17:03:40 +0800
Message-Id: <20240508090354.1815561-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 include/sysemu/host_iommu_device.h | 40 ++++++++++++++++++++++++++++++
 backends/host_iommu_device.c       | 12 +++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 2b58a94d62..ed4cbc967a 100644
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
@@ -47,5 +61,31 @@ struct HostIOMMUDeviceClass {
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


