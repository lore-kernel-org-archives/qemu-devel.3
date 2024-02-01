Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47644C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRXf-0005xi-2Z; Thu, 01 Feb 2024 02:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXc-0005up-GZ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:21 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXT-0001hD-8C
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772671; x=1738308671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sw26yu89PSA3YDAaJKd7N9dsi9pYZXg/gUW5kOZpYbQ=;
 b=QdrX89KJM1sTXC29x4Ee7LGZw5CJSAtzYe7Q3tDGPGjppduGAiWfcrUm
 8GzZ/eLoCMmjJ7IbCR3j2xmehcNEdYkTA2jUMVAy/QCO0NVRjxGhGfQvc
 wveWrMAeZ0wcO1GJJS1cf/wk0zzsTvyZ1OQA2CB+8VHkJVxXPKgmd23t5
 NQQ3OuF8P9XNWsT1CdbVCEXcp9tiC3imB9Oe7RrbEmoe6Avnxb/XOlMcZ
 r6lG+3Pi+7gpuegxeo1+zHnv0iLH2fchA2/LjvDyYtxSapc3XsWmHtjk7
 pxfHM0+2h3uHrNsCZ8obaqSsi17Rhbf2+GjOGg47ji9+JQr50WtH3g9w3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676746"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676746"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443278"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:57 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 09/18] vfio/pci: Initialize host iommu device instance
 after attachment
Date: Thu,  1 Feb 2024 15:28:09 +0800
Message-Id: <20240201072818.327930-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d1e1b8cb89..dedb64fc08 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3006,6 +3006,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    /* Initialize host iommu device after attachment succeed */
+    host_iommu_device_init(vbasedev);
+
     vfio_populate_device(vdev, &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.34.1


