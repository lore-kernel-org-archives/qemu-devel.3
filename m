Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37C1C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H2X-0008Lr-UQ; Tue, 07 May 2024 05:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2W-0008Kr-Fy
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:12 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2U-00008K-Sx
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073790; x=1746609790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p7P8aFLeoc4zseIGlhl+TlPbNc3qYP0grqWyfXSUiLo=;
 b=UyjSdZQxAUl6YuxjED1m8+qGX41Y2d/sA40zbA3fbnGn++Bez9msdQgY
 qsYRQzmHEQIpskPNQ4gD1qUA8e0QAkMckQEwNsrpS8vx77P4wn2hQ8IYo
 MznDOsOPeAvsR/z0bxGDvFDYaTyIsA0gjrS4YLqGBr5HyreaxQqH6z3S5
 ZO4GEvd5Lqkm9qqqZsE+PhyvFiNPpaFy59CHwHYetB99zeO0RwwUV0yDW
 R8Cnh/99KCw1HiG5wC30ieOkpvX7KniDoj7nFw2/7yW8wNK8ka5d4cLtn
 t8HL1FC6EESnNV9NXzZnpPF2EjWJ6a+O+0NrZWA7uO774oaf5wF+Jtx74 A==;
X-CSE-ConnectionGUID: si6I/AfBRRKeGh2UppY0Kg==
X-CSE-MsgGUID: dTrOn2PlTd2GMQuXgcFSoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785185"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785185"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:09 -0700
X-CSE-ConnectionGUID: +eggQQB2RIeAkkyFRoHxDA==
X-CSE-MsgGUID: YDQtqEWPSSi1YX+a0gGm/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553249"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 02/19] vfio/container: Introduce
 TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
Date: Tue,  7 May 2024 17:20:26 +0800
Message-Id: <20240507092043.1172717-3-zhenzhong.duan@intel.com>
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

TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO represents a host IOMMU device under
VFIO legacy container backend.

It will have its own realize implementation.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 3 +++
 hw/vfio/container.c           | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e4c60374fa..05a199ce65 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/host_iommu_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -147,6 +148,8 @@ typedef struct VFIOGroup {
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
+#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+
 typedef struct VFIODMABuf {
     QemuDmaBuf buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 86266f3b83..1b4fc2f3e8 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1139,7 +1139,10 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_legacy_class_init,
-    },
+    }, {
+        .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
+        .parent = TYPE_HOST_IOMMU_DEVICE,
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


