Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD3BC3ABA0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPc-0005Sm-A1; Wed, 19 Feb 2025 03:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPY-0005SK-KZ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:28 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPS-0004Za-9F
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953582; x=1771489582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XVdv5gWUOU2aVOqYrjh81efF2mZVpI8Jj4EkhPdEab8=;
 b=DaIcN+ZjxsaL0MEyS2RwGQW8L8jWsYnlS4FIuizK5a6v8+YSvkDFIYRO
 Lt/kCeJtj4Pim/LNwtSH/YaS5XihFj+HHlVdDDXny3TqydGn/jBhv2ya1
 4uYG0AdAPG5BjFkHCIbNM0oa2xDdyuBeGELGYXdLWnSpMw/JYoASKPMcl
 PvWUL4WFl3D+jRjWy7GPiUlk2a2LDrYjC/LAlaSt/iyDcO6IPNuQW3U9o
 AEioAKyUicF4jtRxpCJJhpVyR+Ijej6JAzHn0vB+rsETZ3q6Fv7U0tNWk
 3qwU7FjDHW1L2sx/nZAku9Hxq5UDAi1HzL2w3zdHQi2892viX0jsFCmQq w==;
X-CSE-ConnectionGUID: KzBuC2lBTbmCz/KWWDlfjw==
X-CSE-MsgGUID: Wq1qZlXOSDqGLAGjtjsw9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544064"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:14 -0800
X-CSE-ConnectionGUID: pipGzqtCR76Z9rAxOAnUvw==
X-CSE-MsgGUID: L0b805NbSMmHlrDb1/kuIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119850861"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:10 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 02/20] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Date: Wed, 19 Feb 2025 16:22:10 +0800
Message-Id: <20250219082228.3303163-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

New added properties include IOMMUFD handle, devid and hwpt_id.
IOMMUFD handle and devid are used to allocate/free ioas and hwpt.
hwpt_id is used to re-attach IOMMUFD backed device to its default
VFIO sub-system created hwpt, i.e., when vIOMMU is disabled by
guest. These properties are initialized in .realize_late() handler.

New added handlers include [at|de]tach_hwpt. They are used to
attach/detach hwpt. VFIO and VDPA have different way to attach
and detach, so implementation will be in sub-class instead of
HostIOMMUDeviceIOMMUFD.

Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to
wrap the two handlers.

This is a prerequisite patch for following ones.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h | 50 ++++++++++++++++++++++++++++++++++++++++
 backends/iommufd.c       | 22 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 5d02e9d148..a871601df5 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -66,4 +66,54 @@ int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
                                      uint32_t *entry_num, void *data_ptr);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
+                    HOST_IOMMU_DEVICE_IOMMUFD)
+
+/* Abstract of host IOMMU device with iommufd backend */
+struct HostIOMMUDeviceIOMMUFD {
+    HostIOMMUDevice parent_obj;
+
+    IOMMUFDBackend *iommufd;
+    uint32_t devid;
+    uint32_t hwpt_id;
+};
+
+struct HostIOMMUDeviceIOMMUFDClass {
+    HostIOMMUDeviceClass parent_class;
+
+    /**
+     * @attach_hwpt: attach host IOMMU device to IOMMUFD hardware page table.
+     * VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @hwpt_id: ID of IOMMUFD hardware page table.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
+                        Error **errp);
+    /**
+     * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
+     * VFIO and VDPA device can have different implementation.
+     *
+     * Mandatory callback.
+     *
+     * @idev: host IOMMU device backed by IOMMUFD backend.
+     *
+     * @errp: pass an Error out when attachment fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+};
+
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp);
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index fc32aad5cb..574f330c27 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -341,6 +341,26 @@ int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
     return ret;
 }
 
+bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->attach_hwpt);
+    return idevc->attach_hwpt(idev, hwpt_id, errp);
+}
+
+bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    HostIOMMUDeviceIOMMUFDClass *idevc =
+        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
+
+    g_assert(idevc->detach_hwpt);
+    return idevc->detach_hwpt(idev, errp);
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
@@ -379,6 +399,8 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
+        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
         .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
-- 
2.34.1


