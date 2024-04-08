Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71DCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk9z-0003AI-PX; Mon, 08 Apr 2024 04:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9x-00039u-Q7
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9v-00089q-Vi
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564120; x=1744100120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bvbdJgRIGiY6OBmpA+3MhD5hfFd6dTo8QUt8PrlDTNk=;
 b=g/LSajqI7ZP0rk5rChsq3f/StY+wBYeCY8BCR5QvQgIL7Ued9PiicDr7
 jbbXczSb3p0w0DJ3+FjPayp5/dISCgQdqFUt+9pmjWngS39TXpYRgagtM
 izO6iTjBURVtWwifFuiufdCsNzeL2ADkcofCexYUd4wu9hTOQ1gv0XF1e
 ZHA3TbY4zrNM4GdFVBzo8hdKeGHNEVtgrZGw4iRWHa6W+WYupEfCEZ9bt
 IYLbpNvLxUZsycIUnQ2LotkwnauXudSDub3MwwzWfO7bqSbXP7YTGc/s/
 qHyYoiNDYWy+zMRP98k7kGqPdVjuR01i08tb0dZqJDLlBILG0ew3ZiRpa Q==;
X-CSE-ConnectionGUID: h/gQGqHNR6yfTBzVxD5oiA==
X-CSE-MsgGUID: mkg0Ugg+Q32PAUu9lItMgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199701"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199701"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:18 -0700
X-CSE-ConnectionGUID: aNHqgbzrS4K5rg6x79zEfw==
X-CSE-MsgGUID: jvOGt1H/RoqGyMJE75LTKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845198"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 04/10] vfio/iommufd: Introduce HIODIOMMUFDVFIO device
Date: Mon,  8 Apr 2024 16:12:24 +0800
Message-Id: <20240408081230.1030078-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

HIODIOMMUFDVFIO represents a host IOMMU device under VFIO iommufd
backend. It will be created during VFIO device attaching and passed
to vIOMMU.

It includes a link to VFIODevice so that we can do VFIO device
specific hwpt attaching/detaching.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 11 +++++++++++
 hw/vfio/iommufd.c             | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f30772f534..d382b12ec1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "sysemu/host_iommu_device.h"
+#include "sysemu/iommufd.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -158,6 +159,16 @@ struct HIODLegacyVFIO {
     VFIODevice *vdev;
 };
 
+#define TYPE_HIOD_IOMMUFD_VFIO TYPE_HIOD_IOMMUFD "-vfio"
+OBJECT_DECLARE_SIMPLE_TYPE(HIODIOMMUFDVFIO, HIOD_IOMMUFD_VFIO)
+
+/* Abstraction of VFIO IOMMUFD host IOMMU device */
+struct HIODIOMMUFDVFIO {
+    /*< private >*/
+    HIODIOMMUFD parent;
+    VFIODevice *vdev;
+};
+
 typedef struct VFIODMABuf {
     QemuDmaBuf buf;
     uint32_t pos_x, pos_y, pos_updates;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8827ffe636..115b9f8e7f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -634,12 +634,21 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
 };
 
+static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
+{
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_IOMMUFD,
         .parent = TYPE_VFIO_IOMMU,
         .class_init = vfio_iommu_iommufd_class_init,
-    },
+    }, {
+        .name = TYPE_HIOD_IOMMUFD_VFIO,
+        .parent = TYPE_HIOD_IOMMUFD,
+        .instance_size = sizeof(HIODIOMMUFDVFIO),
+        .class_init = hiod_iommufd_vfio_class_init,
+    }
 };
 
 DEFINE_TYPES(types)
-- 
2.34.1


