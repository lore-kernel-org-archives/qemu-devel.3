Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399ADC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuL-0002VW-AL; Mon, 29 Apr 2024 02:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktu-00021C-JS
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:12 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Kts-0007m1-Vz
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373649; x=1745909649;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m69yZNJX8vIlEkfx1HmXx5BZ4w4yJlcbcqajEL/8fmU=;
 b=LAFH+wRYFD6sAwoSXsfcWuzHNpGNisJeyzWZxU8+I+2JcFUoPsLWnmfn
 cYIbOzrvSIdQUNIYPlAtX+uwweFTzVi4dT8A7WLH6R3toEh/by8f0XFUU
 KfrwIZS+xTKdUSJB7igT8nIQNAU8ZfDZrBEaT7VUSTGp78bj7yWf/GYJ/
 jaaz9xwoDd8PrTvDAjoTrZ5GK7nWhxFUlCBZs+MzBribw79TlPuzVfEIz
 7Zf/aXCF1ci/GlAC4q7pxNOj6nq7udsFqcYedfO3facg0E0+4h77awvE5
 wehnXA/hN1eGF8r3wx8EeWWJxazYrMGpJ+lR/U2KoYOQjhDC71WJLCm1A g==;
X-CSE-ConnectionGUID: Sia90hH/R/KtaAUdM3xIig==
X-CSE-MsgGUID: Rx16AZEiQnW4NeiVqA+4Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560734"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560734"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:08 -0700
X-CSE-ConnectionGUID: pG0YilI6SJyW2eN6bXgnlw==
X-CSE-MsgGUID: fxUesF3tQQCSHDHpnY4MNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488204"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:05 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 12/19] vfio: Introduce VFIOIOMMUClass::hiod_typename
 attribute
Date: Mon, 29 Apr 2024 14:50:39 +0800
Message-Id: <20240429065046.3688701-13-zhenzhong.duan@intel.com>
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

Initialize attribute VFIOIOMMUClass::hiod_typename based on
VFIO backend type.

This attribute will facilitate HostIOMMUDevice creation in
vfio_attach_device().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 3 +++
 hw/vfio/container.c                   | 2 ++
 hw/vfio/iommufd.c                     | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3582d5f97a..c387f0d8a4 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -110,6 +110,9 @@ DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
 struct VFIOIOMMUClass {
     InterfaceClass parent_class;
 
+    /* Properties */
+    const char *hiod_typename;
+
     /* basic feature */
     int (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3683487605..57c814fcd5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1133,6 +1133,8 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO;
+
     vioc->setup = vfio_legacy_setup;
     vioc->dma_map = vfio_legacy_dma_map;
     vioc->dma_unmap = vfio_legacy_dma_unmap;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6bc2dc68f6..1ac7dea789 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -628,6 +628,8 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
+    vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
+
     vioc->dma_map = iommufd_cdev_map;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
-- 
2.34.1


