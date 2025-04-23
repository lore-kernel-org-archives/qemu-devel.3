Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF0CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uau-0006yD-KC; Wed, 23 Apr 2025 03:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Ual-0006lL-Oo
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:24 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uaj-0002Yx-St
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745393542; x=1776929542;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NFHIgO7COkrKD1Ir5wbN+MQuN1OrvqmikKrinbhohkE=;
 b=Fy9TbsHwq64xKO7DI7t+sT6wmeB5A40a7qS6uJnRjYJ/nuRawo+bBsMr
 kkecxnxPvH5FgC4Pt71prU732UY5r5djFrbpMT2S/mpYih0w6WI8BSl27
 VY/VyPSdU4QbGfPfBqF/4L9TW5dL6bXTGKUNtdXDAksWU1YSgXEvfWV1e
 JRBZ2ebXGwyiC+dGJFMFimlEIt0QyAO8CZXiz5Hj9j/VQPJ+yssi4vu0o
 dbSsReW0viFJMfgfy56sWc2e/u2UhZUfRjZ4Z94xcvJ2ibrelPZBCCHr6
 TQ9DXC5FGof62a0qZ4Je+D1J4LcVyY7MPtzXWaCO7uxUTycJwHLtqufFO g==;
X-CSE-ConnectionGUID: /hl6OFgERSGc7UImhIsNQw==
X-CSE-MsgGUID: SnoobnMRT5yf/GFmdQdYIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57959284"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57959284"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:21 -0700
X-CSE-ConnectionGUID: I+e0wi8QRdCKAJyAMt0czg==
X-CSE-MsgGUID: kL0uStl0Te+NP8HCLbtJAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137025400"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 5/5] vfio: Remove hiod_typename property
Date: Wed, 23 Apr 2025 15:28:24 +0800
Message-Id: <20250423072824.3647952-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

Because we handle host IOMMU device creation in each container backend,
we know which type name to use, so hiod_typename property is useless
now, just remove it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ---
 hw/vfio/container.c                   | 2 --
 hw/vfio/iommufd.c                     | 2 --
 3 files changed, 7 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index a441932be7..d9f3468f6b 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -115,9 +115,6 @@ OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-    /* Properties */
-    const char *hiod_typename;
-
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2de20692d1..a28f0668db 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1103,8 +1103,6 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
-    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO;
-
     vioc->setup = vfio_legacy_setup;
     vioc->dma_map = vfio_legacy_dma_map;
     vioc->dma_unmap = vfio_legacy_dma_unmap;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8a010a51ea..f24054a6a5 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -795,8 +795,6 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
-    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
-
     vioc->dma_map = iommufd_cdev_map;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
-- 
2.34.1


