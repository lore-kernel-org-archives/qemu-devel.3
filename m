Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0336C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPa-0005SX-9b; Wed, 19 Feb 2025 03:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPW-0005S1-UG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:27 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPS-0004ZM-R7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953583; x=1771489583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H45ctgYIUrvH9KPj2VkTio9PfTeWbUSQHoamcNdQlrs=;
 b=EW/u+OCvHEa390I4IRsI/8aiLLXLJQ78A/uV8be4pgtZW6D569vqpKne
 H+JZUTb4JCgQlH9jHWRTDLAZaqpb6VXeb6W6jecZJSmcnHr5+GM0Pfl/6
 IkJV4XCtuNAY6iT7SIWhqJTTmcR0VaWcYXGfy/kPPxPP/x3AkgvHixShH
 /Qug9kPn3Gl6+fyJ5hMKf7KC+Wz9f5UQcIF+xYdTFDk/nhmJhTovDQEZ0
 HjcDWlgse18iGsXsvvwaSRUbj7b8dXf7ldsP05SWaqyqhmAI1UdQ+MZhS
 ye/+ST1ZdON5ozwkn4jCUCGa5LbvKTd6c7UBtnrLJCFvP1RuJZlnoOasv Q==;
X-CSE-ConnectionGUID: QVlOIY0KTgiAyX3SF6i9ag==
X-CSE-MsgGUID: XBIl4ZI3R7W+wE92cTffOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544076"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544076"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:18 -0800
X-CSE-ConnectionGUID: ryudde52TiSc6eS/a4d2lw==
X-CSE-MsgGUID: 8NtVIyRkQN+n9KvOZB0gCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119850916"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:14 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late callback
Date: Wed, 19 Feb 2025 16:22:11 +0800
Message-Id: <20250219082228.3303163-4-zhenzhong.duan@intel.com>
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

Currently we have realize() callback which is called before attachment.
But there are still some elements e.g., hwpt_id is not ready before
attachment. So we need a realize_late() callback to further initialize
them.

Currently, this callback is only useful for iommufd backend. For legacy
backend nothing needs to be initialized after attachment.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 17 +++++++++++++++++
 hw/vfio/common.c                   | 17 ++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba..df782598f2 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -66,6 +66,23 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
+    /**
+     * @realize_late: initialize host IOMMU device instance after attachment,
+     *                some elements e.g., ioas are ready only after attachment.
+     *                This callback initialize them.
+     *
+     * Optional callback.
+     *
+     * @hiod: pointer to a host IOMMU device instance.
+     *
+     * @opaque: pointer to agent device of this host IOMMU device,
+     *          e.g., VFIO base device or VDPA device.
+     *
+     * @errp: pass an Error out when realize fails.
+     *
+     * Returns: true on success, false on failure.
+     */
+    bool (*realize_late)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
     /**
      * @get_cap: check if a host IOMMU device capability is supported.
      *
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index abbdc56b6d..e198b1e5a2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1550,6 +1550,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
     HostIOMMUDevice *hiod = NULL;
+    HostIOMMUDeviceClass *hiod_ops = NULL;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1560,16 +1561,26 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     if (!vbasedev->mdev) {
         hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+        hiod_ops = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
         vbasedev->hiod = hiod;
     }
 
     if (!ops->attach_device(name, vbasedev, as, errp)) {
-        object_unref(hiod);
-        vbasedev->hiod = NULL;
-        return false;
+        goto err_attach;
+    }
+
+    if (hiod_ops && hiod_ops->realize_late &&
+        !hiod_ops->realize_late(hiod, vbasedev, errp)) {
+        ops->detach_device(vbasedev);
+        goto err_attach;
     }
 
     return true;
+
+err_attach:
+    object_unref(hiod);
+    vbasedev->hiod = NULL;
+    return false;
 }
 
 void vfio_detach_device(VFIODevice *vbasedev)
-- 
2.34.1


