Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KtK-0001TI-3z; Mon, 29 Apr 2024 02:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtJ-0001SE-6p
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:33 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtH-0007m1-Iw
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373612; x=1745909612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7HNWMCNDysRciXtAF+rKvUr1gOZk/3AdCnrcTI8Umng=;
 b=c3rw0Fwck2Ba+/M3/280+PdeYUAAw1OySOpkKCrZD5uysnxi9Ggt3+kW
 5AZ1eN2BLLsIBULbdSxtxfIhp5G7iWqaBxhQO7Z5tbx43+BzYLQkVSPJj
 14sAEDlnl7Hlg6V56cV2d20DZqVAQB1juONtY/tcHFzvmlbV8Ly0uDhV/
 dUC50G7fz1nE48GRLEizGr43aOnhpvaMFvMae6KxHh3RE6hDxWyjN5Bkx
 JKPnJx7Clm1jpfDT6A1ffwpSaYaVkGmONji+wRj2fPPFqTvrqwsXW1J1V
 OBacE4wPAbaLFif/eex+M/Y4LsSBr7ctXem1kdSXN3eiSa0NDmPkKbOCn Q==;
X-CSE-ConnectionGUID: ev0boci5Q7WVVrMYDotemQ==
X-CSE-MsgGUID: iH0pdsvPTe2q3M1/gaj9tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560668"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:30 -0700
X-CSE-ConnectionGUID: taf2hIqGQt2UTZBWUvtJGw==
X-CSE-MsgGUID: kibbwi5WSy+FD9AB19/OyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63487957"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:27 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 02/19] vfio/container: Introduce HostIOMMUDeviceLegacyVFIO
 device
Date: Mon, 29 Apr 2024 14:50:29 +0800
Message-Id: <20240429065046.3688701-3-zhenzhong.duan@intel.com>
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

HostIOMMUDeviceLegacyVFIO represents a host IOMMU device under VFIO
legacy container backend.

It includes a link to VFIODevice.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 12 ++++++++++++
 hw/vfio/container.c           |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..aa3abe0a18 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/host_iommu_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -147,6 +148,17 @@ typedef struct VFIOGroup {
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
+#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+OBJECT_DECLARE_SIMPLE_TYPE(HostIOMMUDeviceLegacyVFIO,
+                           HOST_IOMMU_DEVICE_LEGACY_VFIO)
+
+/* Abstract of host IOMMU device with VFIO legacy container backend */
+struct HostIOMMUDeviceLegacyVFIO {
+    HostIOMMUDevice parent_obj;
+
+    VFIODevice *vdev;
+};
+
 typedef struct VFIODMABuf {
     QemuDmaBuf buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77bdec276e..3b6826996a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1148,7 +1148,11 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_legacy_class_init,
-    },
+    }, {
+        .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HostIOMMUDeviceLegacyVFIO),
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


