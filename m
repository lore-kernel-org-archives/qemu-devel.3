Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E8EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KtR-0001WU-V7; Mon, 29 Apr 2024 02:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtQ-0001WL-79
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:40 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtO-0007m1-FH
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373619; x=1745909619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GvsglZRWX7Mc9Tpe1YncfB5mZdiKkib9QiFdUW3jodM=;
 b=h0A9cv+Szug71q0FUKkBu74/ttd/vUQSb7mCm7qH1rwmduxLtRmIYqZp
 k2g3Q0ptkuxaCettTy+m0EuzNWGVF588RNHFdmGcsZFXtCyJD60X6aZ12
 sDBbIk1pMYa+w8RxbbMrtQ2s6W5xXF8J/rs9XLAxAYXxaDjh4w5tlcozH
 gyo4ZrO+KCFYEibHCLFBfRzt/YWGAcFCl3LVkhdn/zCjJ12U8ILfRjkco
 SNvy6tox0gUIsqHDRvAstAD3jTJXADmx8x2UTdmyOis4E6Aql2axxcs1A
 0XtWK3SEFZ5V2EITJ/Rrxk1tnJO7eqamzTUOeLckw7AaSwAn//jLnafHw w==;
X-CSE-ConnectionGUID: 80YPEuvuQ8qcccPf6boUVw==
X-CSE-MsgGUID: FQcph7DtT7aUo7g2Smq17A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560678"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:38 -0700
X-CSE-ConnectionGUID: GVoLP+6TRRSCfzcFxy/U3Q==
X-CSE-MsgGUID: RTBeVHBZSyioz1x7zCUuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63487982"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 04/19] vfio/iommufd: Introduce HostIOMMUDeviceIOMMUFDVFIO
 device
Date: Mon, 29 Apr 2024 14:50:31 +0800
Message-Id: <20240429065046.3688701-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

HostIOMMUDeviceIOMMUFDVFIO represents a host IOMMU device under VFIO
iommufd backend. It will be created during VFIO device attaching and
passed to vIOMMU.

It includes a link to VFIODevice so that we can do VFIO device
specific operations, i.e., [at/de]taching hwpt, etc.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 13 +++++++++++++
 hw/vfio/iommufd.c             |  6 +++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index aa3abe0a18..0943add3bc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "sysemu/host_iommu_device.h"
+#include "sysemu/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -159,6 +160,18 @@ struct HostIOMMUDeviceLegacyVFIO {
     VFIODevice *vdev;
 };
 
+#define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
+            TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
+OBJECT_DECLARE_SIMPLE_TYPE(HostIOMMUDeviceIOMMUFDVFIO,
+                           HOST_IOMMU_DEVICE_IOMMUFD_VFIO)
+
+/* Abstraction of host IOMMU device with VFIO IOMMUFD backend */
+struct HostIOMMUDeviceIOMMUFDVFIO {
+    HostIOMMUDeviceIOMMUFD parent;
+
+    VFIODevice *vdev;
+};
+
 typedef struct VFIODMABuf {
     QemuDmaBuf buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8827ffe636..997f4ac43e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -639,7 +639,11 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_iommufd_class_init,
-    },
+    }, {
+        .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
+        .instance_size = sizeof(HostIOMMUDeviceIOMMUFDVFIO),
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


