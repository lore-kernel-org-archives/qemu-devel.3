Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCECC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk9r-0002rL-1u; Mon, 08 Apr 2024 04:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9p-0002p5-MT
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:13 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9n-00081z-9C
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564111; x=1744100111;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nvxHeLmjV4rkU7CI9wa3Pysp6fP4cvCvnf1CbZdvW5U=;
 b=Z1bImBPqbQ7LVibhmVH0M2CEkC0wVWb1es9+zjthD2pgnQXPSCbdgjk9
 XhJz3HG7ZPKGug19wPROsS74JEcgmLBn9PPE/mXAriUa/10j2t0sTSIKh
 rvpvIHCH/sRzc5k8ncBQSEaJhvYiZgUpPuPECA3b/n9wqj376i17lKYp4
 7xw1jxbtS8CbqmsGVkBqRsP1P3Fs25shCqCplf7w8MvuOnAsnz4yp3dk5
 /A89vLIM4ZKzG0+uHpBMVp1NHzNRPhclH/0mQ3ysUT9RXOVnkBuMLfzap
 CUwqVNZiDdx+XcyxbZq0dNisx1D5u3AoksHgBCn5GHTSIeVQJMD+lMjjc g==;
X-CSE-ConnectionGUID: Dts6YZpmSyyEtXe7VvJDng==
X-CSE-MsgGUID: ZchQYIrfSLGoVmQKrvO50Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199666"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:11 -0700
X-CSE-ConnectionGUID: GAlrNFepRhe8+MfiBHG8dw==
X-CSE-MsgGUID: TwAZU6QrSj+g917OTWRCiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845177"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Date: Mon,  8 Apr 2024 16:12:22 +0800
Message-Id: <20240408081230.1030078-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

HIODLegacyVFIO represents a host IOMMU device under VFIO legacy
container backend.

It includes a link to VFIODevice.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 11 +++++++++++
 hw/vfio/container.c           | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..f30772f534 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/host_iommu_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -147,6 +148,16 @@ typedef struct VFIOGroup {
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
+#define TYPE_HIOD_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+OBJECT_DECLARE_SIMPLE_TYPE(HIODLegacyVFIO, HIOD_LEGACY_VFIO)
+
+/* Abstraction of VFIO legacy host IOMMU device */
+struct HIODLegacyVFIO {
+    /*< private >*/
+    HostIOMMUDevice parent;
+    VFIODevice *vdev;
+};
+
 typedef struct VFIODMABuf {
     QemuDmaBuf buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77bdec276e..44018ef085 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1143,12 +1143,21 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
+{
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_legacy_class_init,
-    },
+    }, {
+        .name = TYPE_HIOD_LEGACY_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE,
+        .instance_size = sizeof(HIODLegacyVFIO),
+        .class_init = hiod_legacy_vfio_class_init,
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


