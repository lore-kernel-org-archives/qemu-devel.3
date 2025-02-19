Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58B5C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPZ-0005SL-Cd; Wed, 19 Feb 2025 03:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPW-0005S2-UN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:27 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPU-0004Zq-2F
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953584; x=1771489584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y3if1GlQNkp7W4HQVB5jdhNRUVirRmci7xxwosuRS/Y=;
 b=ZF/mcAERzRkU1WmNjOM8mCC+bCgrlkDp42UqTvfHgX/9k8m9HuxvePZ3
 X22SyvXFaHIL4Vwfkex7CSM5zkbsu7/EWsbkvKRcmHL1Xk9X99jT70L3M
 T7jCJ53BxHvL6yRUCx1Tn+Bc9c/lMP1N16FeF3rcebxDylke/fFgDQecv
 VbnKTmYJOqJA1FWqCtl64DURBBSChZthP7SJ6hdqmPs/vJhi65Wa3N7Ps
 MEKFwmGZ6uZm4uWQj962A3R+rxrbrRRKbfRa/5WiyIhoGcGUB1fUUti0D
 8Nkv2U7hLh7NGIxZtUYP3gjv28cmB0s1PDMfI45ySKese9bZpjGzn7sns A==;
X-CSE-ConnectionGUID: POQMg3NwS5yeU00AkcL27g==
X-CSE-MsgGUID: J5y/9BuiTkuKitiERF+DAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544086"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:23 -0800
X-CSE-ConnectionGUID: 4lcLPtHAQSiWyV/wGuxT8Q==
X-CSE-MsgGUID: tB+6zdv7QI2UEqyiJCSk9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119850973"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:18 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 04/20] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize_late() handler
Date: Wed, 19 Feb 2025 16:22:12 +0800
Message-Id: <20250219082228.3303163-5-zhenzhong.duan@intel.com>
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

There are three iommufd related elements iommufd handle, devid and
hwpt_id. hwpt_id is ready only after VFIO device attachment. Device
id and iommufd handle are ready before attachment, but they are all
iommufd related stuff, initialize them together with hwpt_id.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df61edffc0..53639bf88b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -828,6 +828,19 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static bool hiod_iommufd_vfio_realize_late(HostIOMMUDevice *hiod, void *opaque,
+                                           Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
+
+    idev->iommufd = vdev->iommufd;
+    idev->devid = vdev->devid;
+    idev->hwpt_id = vdev->hwpt->hwpt_id;
+
+    return true;
+}
+
 static GList *
 hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
 {
@@ -852,6 +865,7 @@ static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
+    hiodc->realize_late = hiod_iommufd_vfio_realize_late;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
 };
-- 
2.34.1


