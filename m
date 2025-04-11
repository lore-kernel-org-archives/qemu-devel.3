Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4873EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVt-0002zY-Im; Fri, 11 Apr 2025 06:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVh-0002fF-JS
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:21 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVe-0005Nr-Fb
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366878; x=1775902878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a1rqJgngFJ3/FyQqDL1AmQI5pB8InAlZ+NX9kWvKC+w=;
 b=FJOtqGhZO1eP1jM2G8DjupddGiZTWMKq5/uXM6Jmxfql2pNtkbUKDzD2
 AfZa+9ZUk1OC1uHCa6Blr2uy8BCndy3lDcTGPyzQnL3u5HLyHlFuS1uQ/
 i24RUF+hAm6TH0WABknkz+6b+dxXG48L0L3pv5g/8WBAK1XsZjI9o4pyu
 ERcB1tL8JIh8HID+8WSIbcD5elg28YFsIziS5Sjsu7OXGGYFZVoMsGsAE
 SfmP1Izfizn3zGBtaWHpW5XQuaBqQLku9UMAw3bX/Zh3VweA3V8K3/8dd
 DhRCXjIMgWu2FEvzqB0xArk0rvoHLQVru7bB88v94s7lR4fYLwKzjT5yo g==;
X-CSE-ConnectionGUID: YM9D1xBhRzKu7Ls317bVtw==
X-CSE-MsgGUID: QaYg1I8XQ0S676d/EJsRfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49566820"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49566820"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:58 -0700
X-CSE-ConnectionGUID: 9/SwKHS4R6S3cgX0EKKMHQ==
X-CSE-MsgGUID: oq4zwjX/S1+O/UgIkox3UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="133917424"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:57 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 5/5] vfio/iommufd: Drop HostIOMMUDeviceCaps from
 HostIOMMUDevice
Date: Fri, 11 Apr 2025 18:17:07 +0800
Message-Id: <20250411101707.3460429-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

Because hiod_iommufd_get_cap() was dropped, HostIOMMUDeviceCaps is not
useful any more, drop it.

This also hides HostIOMMUDeviceCaps from vIOMMU so the only way to check
cap is through .get_cap() interface. This makes HostIOMMUDevice exposing
data to vIOMMU as small as possible.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 14 --------------
 hw/vfio/iommufd.c                  | 15 ---------------
 2 files changed, 29 deletions(-)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba..6f10bea25f 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -15,19 +15,6 @@
 #include "qom/object.h"
 #include "qapi/error.h"
 
-/**
- * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
- *
- * @type: host platform IOMMU type.
- *
- * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
- *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
- */
-typedef struct HostIOMMUDeviceCaps {
-    uint32_t type;
-    uint64_t hw_caps;
-} HostIOMMUDeviceCaps;
-
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
 
@@ -38,7 +25,6 @@ struct HostIOMMUDevice {
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     PCIBus *aliased_bus;
     int aliased_devfn;
-    HostIOMMUDeviceCaps caps;
 };
 
 /**
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e7ca92f81f..947c5456d8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -811,24 +811,9 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
     VFIODevice *vdev = opaque;
-    HostIOMMUDeviceCaps *caps = &hiod->caps;
-    enum iommu_hw_info_type type;
-    union {
-        struct iommu_hw_info_vtd vtd;
-    } data;
-    uint64_t hw_caps;
 
     hiod->agent = opaque;
-
-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data),
-                                         &hw_caps, errp)) {
-        return false;
-    }
-
     hiod->name = g_strdup(vdev->name);
-    caps->type = type;
-    caps->hw_caps = hw_caps;
 
     return true;
 }
-- 
2.34.1


