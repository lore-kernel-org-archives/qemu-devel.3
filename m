Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6450AC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 06:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMhZ2-00035k-Lm; Wed, 04 Jun 2025 02:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMhYy-000355-5i
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:25:24 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMhYv-0001aH-0z
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749018321; x=1780554321;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W3Hqst10fcVe2qgp7lyjnm5hovjnEqZj1rQWjxRsRx4=;
 b=dPnmDstWRSdzoj01wP/H3i4o+2DdFfWPxlI96p6u2sbBzpWTgIAros+U
 vAmSzhMSzm1BfPgj+3f0Cr7vxDSlwCYoNWZohTYQciI2GeZWHVcLHMCOY
 ns5ORPC8He1KiRRhB9uCqhADLubRFVecdYEsnYK/Ua2BvJ7vZ0M1+n6Mc
 Sm4r0ul9DgSpxtUaC6BiAjMy3LEZFGwTCHN26YpcEo52ZLhzntbdckJg8
 thMMyGgaFU9hsqS+Eozv5kPOICfx6ZhZcKWnoEZ4Sto/9duPKFnLwjJQ4
 6UaRT0igAhdB0IaTivFSneKxvxI75JnsV+hqI7x2yyJg0YANDjftlI1Mh w==;
X-CSE-ConnectionGUID: sd5q7ww+Q8KsDtxQRokxvw==
X-CSE-MsgGUID: CCRfIYOKR/al9RyIpUpplA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="73614549"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="73614549"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 23:25:20 -0700
X-CSE-ConnectionGUID: INJEJGBhQIWSkwncdrsDyg==
X-CSE-MsgGUID: OVWi4p8fR1q62doAXgYdEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145693580"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 23:25:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Date: Wed,  4 Jun 2025 14:21:14 +0800
Message-Id: <20250604062115.4004200-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
References: <20250604062115.4004200-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
utilizes them to attach to or detach from hwpt on host side.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 82fcd5c6a5..3910b4b2b9 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -815,6 +815,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
 };
 
+static bool
+host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           uint32_t hwpt_id, Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+
+    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+}
+
+static bool
+host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                           Error **errp)
+{
+    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
+
+    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
+}
+
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
                                       Error **errp)
 {
@@ -869,10 +887,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
     hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
     hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
+
+    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
+    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


