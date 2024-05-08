Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E822C25B77
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dGc-0008Vk-4s; Wed, 08 May 2024 05:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGY-0008Ud-Fs
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:11 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dGW-0005QH-SL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159229; x=1746695229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p7P8aFLeoc4zseIGlhl+TlPbNc3qYP0grqWyfXSUiLo=;
 b=BavdJXULHaVFunCCi5d6gzpay1jcf+67PBborRmGwhNx3l7S845ebJg5
 q298eO6j3uqSpXyZIu1/eE7cWaw8qkEYsroqatZMObPls++296E/n0XiV
 le5CIE/39WNF7t7rzDT+tryZQKSXRUjXoHSj+6V82aW3z+5PPwyCivnsn
 pZ4nI6CDgodRIi2LfeU4eqsJPuXnpEmac5nM8veK4pJRivRkPQRMeqAG6
 tKto56BzWqA3vtRrrOkvqCS7M8SwMvMl5kh4k7tGduHgYZLSIZzhwh1gG
 3LgNSMnixoPVFG3yTSgCR17S74i1p6Kbfl/bbmYavyBabFvl+bKwVV0F4 g==;
X-CSE-ConnectionGUID: jPZqHAmXTICY08JxHntfSg==
X-CSE-MsgGUID: xqpMtRcrRl20IqPPHuqoSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11160880"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11160880"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:08 -0700
X-CSE-ConnectionGUID: RSq4WfkyTkORrXUGLzPYbA==
X-CSE-MsgGUID: zLEC3WQjTCCCe7xLrD7z4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226462"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 02/19] vfio/container: Introduce
 TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
Date: Wed,  8 May 2024 17:03:37 +0800
Message-Id: <20240508090354.1815561-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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


