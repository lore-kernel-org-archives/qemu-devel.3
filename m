Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AF9C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5K-0001En-Cy; Wed, 05 Jun 2024 04:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5I-0001E2-Oz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:28 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5H-000610-3w
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576408; x=1749112408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3+HbQHpf7tkUVGYjKSReUsjXGStIlnO1OjBBru6PBeU=;
 b=FLMpAhzu8PM47DgWJ0wmrWxcH4bVu3Bm1hKkfrhQlaW5+4h6x9S7HDQO
 WKhXdo7Old/+SH81DrhsgQRhl17k542ppF02BdPHgAYYayCgkOtgtOHHf
 hELJJ9K2cgZGbLFHUEDa1hm93BG3gFabU9hgC/a/6+8da7Jb1MKIw+C5K
 PrQG2R1QdN9aFDAhCivyjtyaWL5vUA3vk5/tLyiVolwSq/v81b8mHkU3v
 8xHM8uKDTe0An9xva1Am4u600UyZH5HYJaLMSeVaahPtg4UqLlGUjsnGM
 0fxo09y1eZ+/M+ZkhUGXB7nsVaf/63SsCRpaETJkxjnBjdlNcq8M7GnK5 g==;
X-CSE-ConnectionGUID: y6BOA5VXT6SJyx12d+t0qg==
X-CSE-MsgGUID: 3rd4dRGUR3iymXQiSQV1JQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575314"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575314"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:26 -0700
X-CSE-ConnectionGUID: ry5HB9pNS0ibKkkGjLOayw==
X-CSE-MsgGUID: 9/5H4OlsTG2XLBmMttpmyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954764"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 03/17] vfio/container: Introduce
 TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
Date: Wed,  5 Jun 2024 16:30:29 +0800
Message-Id: <20240605083043.317831-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 4cb1ab8645..75b167979a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/host_iommu_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -171,6 +172,8 @@ typedef struct VFIOGroup {
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
+#define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
+
 typedef struct VFIODMABuf {
     QemuDmaBuf *buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 096cc97258..c4fca2dfca 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1141,7 +1141,10 @@ static const TypeInfo types[] = {
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


