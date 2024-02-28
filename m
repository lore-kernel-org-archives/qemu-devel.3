Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B36C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB8f-0005Z2-Jf; Tue, 27 Feb 2024 23:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8d-0005Yb-RF
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:47 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8c-0000uR-En
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092907; x=1740628907;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q7ZLZEg0dJgeXq8Fhcp4By04/sUyu5XmxNwoPYw8P94=;
 b=BdvHVTWjQHeWG0GVX1mD7lrQDbY8FOuw41Zk4CnuVlINE7yeOYrUkg8D
 dXTq0+bYBVNfO+3u9O6bjIRbACvl7DdtKJc51jXbI78ihlMi6lMc2fGZL
 vQvObzuOliLrkOh0um+9el2WsriZNKfc+A/4mH41HTjpW7DKYWaWE22nY
 FNQ/zC2BlwsNjrtPl+ICbwF/EHc/usM/RTIjrJVoJzMzaf8SDVEVmNmnb
 OFL3/MwmLuSHjUVK4K7uHCCyRmc2MclHrOFgPqnw4zSVtnO5h6MZWzAKU
 SFDamWtpy/QL3gqd5GTMc9qr/ev0vbAiO8uYEuR9aqu1ad6n1WasmNQcm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342478"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917296"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:38 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 08/11] vfio/pci: Allocate and initialize HostIOMMUDevice
 after attachment
Date: Wed, 28 Feb 2024 11:58:57 +0800
Message-Id: <20240228035900.1085727-9-zhenzhong.duan@intel.com>
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f043..6cc7de5d10 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3006,6 +3006,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    /* Allocate and initialize HostIOMMUDevice after attachment succeed */
+    host_iommu_device_create(vbasedev);
+
     vfio_populate_device(vdev, &err);
     if (err) {
         error_propagate(errp, err);
@@ -3244,6 +3247,7 @@ static void vfio_instance_finalize(Object *obj)
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
+    g_free(vdev->vbasedev.base_hdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
     /*
-- 
2.34.1


