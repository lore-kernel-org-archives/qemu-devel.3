Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7650EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H2h-00009x-6B; Tue, 07 May 2024 05:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2e-00006f-CT
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:20 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2c-00008K-PF
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073798; x=1746609798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zEb4sLTc/j+SaohFZy7OiH9RZU/pHjGFuDFgJP18iPQ=;
 b=oKGrvcfG7/9yhnqWl4swhcHjEv32C7P1wWWxAPwmeDOodWQgt9xNaoJQ
 LEqdegXuQirWFygbNILyaxr+HUXrhlGcaVcu+yKkypCR/7fjys7O/Ts2i
 cW/Zi5Zjz3UpsGeXac7lhqHBqEpew5Pp2OwpRTedwzwWjZB5dz9/qvYf+
 V7P5yYmS/t4HXgA/f6FQ/Vsremmk3+VE4K4cnrSM7lXlrYC+jbAvYPEka
 tVEkHBQ92hRwYE4QqdsUxthba7ufHvTVbMOqgGRP07RIm0JDwb4/heVjy
 Era+12L4hLG2TDE2zPooujaHOSrDYg5UA1KwCjNRqQ+QZg7XBUilDn+oB g==;
X-CSE-ConnectionGUID: Yrovxu8DRPW8v2znKNZmhg==
X-CSE-MsgGUID: i79qrIVTTCuZKtr+zQZ5QQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785197"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:17 -0700
X-CSE-ConnectionGUID: m+vMcL2vQ2ipHLylCNCSWw==
X-CSE-MsgGUID: 81q08A7yTM2DHt0JW5fFhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553265"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 04/19] vfio/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
Date: Tue,  7 May 2024 17:20:28 +0800
Message-Id: <20240507092043.1172717-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO represents a host IOMMU device under
VFIO iommufd backend. It will be created during VFIO device attaching
and passed to vIOMMU.

It will have its own .realize() implementation.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 3 +++
 hw/vfio/iommufd.c             | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 05a199ce65..affb73f209 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "sysemu/host_iommu_device.h"
+#include "sysemu/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -149,6 +150,8 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 typedef struct VFIODMABuf {
     QemuDmaBuf buf;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 554f9a6292..e4a507d55c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -624,7 +624,10 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_iommufd_class_init,
-    },
+    }, {
+        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


