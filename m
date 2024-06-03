Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F179C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0wl-0004fy-Qn; Mon, 03 Jun 2024 02:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wk-0004fO-IH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:30 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wi-0000uQ-VY
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395209; x=1748931209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bH6SQfIKjpaHcGKH1cmtCIfWr1G+1rJOreNMbQzeZZo=;
 b=HEYsg6wEf0W0ljZUIj58XgwfpqKw4qtLyJdcgfCu6y94nc3Pa+JX/Q9n
 fiTfNMxqSJ8073yqystVOSvlefH8CzN6z4ZTjqOYY1gPQKqO63nqN85YL
 Ou3r83IN/cW7iaET9pVZULSUSw2StSRk27ORWpcTXKKmOJ1Gb7DQw2tRu
 tKHPZPfselVJwNnRcuoAy3GG9W4Xhvqqsc9SactVP2syymiZGaTs0EG0M
 7aQPNQ9peOxME9gJymwtRqhXCofyQVzTNKTNUP2aO8wnwzywFFDxcx6I2
 fQl3/u/3JkookHKmnwcd3CKsCbMZj5/K555rs2Lq9M7LtsMhkmG5EYvCd w==;
X-CSE-ConnectionGUID: msOBqklZSNuBLPp/vj1kew==
X-CSE-MsgGUID: xn9Ub902QtiWUjxK7lPXVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277640"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277640"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:28 -0700
X-CSE-ConnectionGUID: 3ECPSxN/Tb2dEEGN/Bd7MA==
X-CSE-MsgGUID: 7WAopsgYRzSdZW/PMDL4xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855852"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 04/19] vfio/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
Date: Mon,  3 Jun 2024 14:10:08 +0800
Message-Id: <20240603061023.269738-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
index 75b167979a..56d1717211 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "sysemu/host_iommu_device.h"
+#include "sysemu/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -173,6 +174,8 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 typedef struct VFIODMABuf {
     QemuDmaBuf *buf;
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


