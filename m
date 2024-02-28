Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C11C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB8l-0005dv-Fu; Tue, 27 Feb 2024 23:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8j-0005Zr-I9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:53 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8T-0000ub-Du
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092897; x=1740628897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=icy4H9M8PojAQrFizVqgsDbF6SyIjp2lAf7GphYLMq4=;
 b=fj4T5nydECroKgy7S2NRgRcFenwAp/AmD+QehXyeILPhiVWNNHCOJe+3
 BZNvlSF9hwu9pRtVmL6XMnVAuVFxwJBNAk6VSI0uFzKf95hiCZqeYkhdH
 Sf9SiyajaQ5dMPunEVDDTbAGRhSChs6epXsUsvSBrRIFGWzg5OOR7ckAd
 W1tlWxhOtmtPO5uFMBF57F+AaBTAInyCWn+19XAf7C762QXaeb0I9h8Sj
 OPUFN5B6mJVBBTpPMeSuRKCH0z71Gay1pLKH+BC+daqMlUL2XFmT44ZpZ
 RfFbyvbjlVrUKubAuyPVpHMiepwyK+RdLt5m4XpZUbiGm1/lEcar5Jand w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342465"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342465"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917245"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:29 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 06/11] vfio/container: Implement host_iommu_device_create
 callback in legacy mode
Date: Wed, 28 Feb 2024 11:58:55 +0800
Message-Id: <20240228035900.1085727-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This callback will be used to initialize base and public elements in
IOMMULegacyDevice.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9fbad..2e8ff32284 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1120,6 +1120,14 @@ out_single:
     return ret;
 }
 
+static void vfio_legacy_host_iommu_device_create(VFIODevice *vbasedev)
+{
+    vbasedev->base_hdev = g_malloc0(sizeof(IOMMULegacyDevice));
+
+    host_iommu_base_device_init(vbasedev->base_hdev, HID_LEGACY,
+                                sizeof(IOMMULegacyDevice));
+}
+
 static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
@@ -1132,6 +1140,7 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
     vioc->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
+    vioc->host_iommu_device_create = vfio_legacy_host_iommu_device_create;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


