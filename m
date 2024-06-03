Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD1C3DA40
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0x5-0004vd-NV; Mon, 03 Jun 2024 02:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0x3-0004t8-T9
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:49 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0x1-0000uQ-1W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395227; x=1748931227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SFnso2XJZnjcpe6vQEbV6q0DMy+GxluEI4QwMoNhpTQ=;
 b=QZ1TI99ICvKuZgRZPZ+Xc1moZ6pg1uWiRFNXF7o6WdVCbO2GCSMkeTae
 PL3D0luok9SRbHCFiME5bMObHFBtnD8BZOp91G/FiVrn7h639jtAEdcRj
 VQMPE6U/IuIXXXVQU3KWMBZG7P8PA1KifGcn6JrSf7NfNv/iHuHpwCJVl
 05w1khvt/cBpGnR5Qu3U5UAxKZplLotEVLAhmkQ/aBQ6nu3frHuQaaTiH
 QzotVOCdMa0mORdzHn3+SGFcC+mm74ddezlW37oK1Y0VdrnDzOqvh1SIG
 8ae9+o36mqCio/CDXVwPWM9iabAzEPeC14pELLj48SH5TD/tzpwcIDQhx A==;
X-CSE-ConnectionGUID: V+2B4XHkT0KIeJbm17L3CQ==
X-CSE-MsgGUID: my2/oMCWT3Wr/8WPLZBbDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277676"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:45 -0700
X-CSE-ConnectionGUID: tG3gFRyFR6iJNDdg+l46kg==
X-CSE-MsgGUID: mnNxojWCRwmfezZX02QXYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855889"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v6 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Date: Mon,  3 Jun 2024 14:10:12 +0800
Message-Id: <20240603061023.269738-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Introduce a helper function iommufd_backend_get_device_info() to get
host IOMMU related information through iommufd uAPI.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  3 +++
 backends/iommufd.c       | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index f6e6d6e1f9..9edfec6045 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -47,6 +47,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                     uint32_t *type, void *data, uint32_t len,
+                                     Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 012f18d8d8..c7e969d6f7 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -208,6 +208,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                     uint32_t *type, void *data, uint32_t len,
+                                     Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .dev_id = devid,
+        .data_len = len,
+        .data_uptr = (uintptr_t)data,
+    };
+
+    if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
+        error_setg_errno(errp, errno, "Failed to get hardware info");
+        return false;
+    }
+
+    g_assert(type);
+    *type = info.out_data_type;
+
+    return true;
+}
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
-- 
2.34.1


