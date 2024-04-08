Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F206C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkAY-0003Nh-RB; Mon, 08 Apr 2024 04:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkA7-0003Gz-Ku
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:31 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkA5-00089q-SB
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564130; x=1744100130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RajnNcVKs+6ypzH6WcL3+uFvOHZi+tCP/jt2sxffnkU=;
 b=Cc8/KOWif++x1+v7k0r0xmFmvWabN3dCPADo09HvqeWoaw0nnkx8wFnB
 FfdiW7LI4i2cW+0nx1YT12xImMlD4jO1vdPxraPGsWXnspLxetjUiwSKB
 MVcUUIypcCP+SQfhR4tXS5VaMBsd/zCW3IS8P0+GOnbF25ZIKFW1yU3Mb
 eSOG+wdZX/vtG67QvBaeKD7ZrMMUH419PVnNleMq+iHyhlMwVlsEkyVxx
 heJ8HD8cY1uofZqCTI4rmeTp/Lx707kjxPkgqbisry8Rhkvaliwiyu6nh
 j5r1UANhCgLE3eSQGcfD9nNsIuO/I7t285HsgJw9w8/jhyUEqbY0ppMa0 w==;
X-CSE-ConnectionGUID: hqIRHT3DT32Sx+7Ct/CIKw==
X-CSE-MsgGUID: ahDLwpJITZ2afy+t+nQ4qA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199736"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199736"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:29 -0700
X-CSE-ConnectionGUID: 13QfKuu2QaiwI0B/e4f+Jg==
X-CSE-MsgGUID: Mr0nPNFWTk2LC9ThWK5AZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845213"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 07/10] backends/iommufd: Implement get_host_iommu_info()
 callback
Date: Mon,  8 Apr 2024 16:12:27 +0800
Message-Id: <20240408081230.1030078-8-zhenzhong.duan@intel.com>
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

It calls iommufd_backend_get_device_info() to get host IOMMU
related information.

Define a common structure HIOD_IOMMUFD_INFO to describe the info
returned from kernel. Currently only vtd, but easy to add arm smmu
when kernel supports.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  7 +++++++
 backends/iommufd.c       | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index fa1a866237..44ec1335b2 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -39,6 +39,13 @@ int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                     enum iommu_hw_info_type *type,
                                     void *data, uint32_t len, Error **errp);
 
+typedef struct HIOD_IOMMUFD_INFO {
+    enum iommu_hw_info_type type;
+    union {
+        struct iommu_hw_info_vtd vtd;
+    } data;
+} HIOD_IOMMUFD_INFO;
+
 #define TYPE_HIOD_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 OBJECT_DECLARE_TYPE(HIODIOMMUFD, HIODIOMMUFDClass, HIOD_IOMMUFD)
 
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 559affa9ec..1e9c469e65 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -240,8 +240,25 @@ void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
     idev->devid = devid;
 }
 
+static int hiod_iommufd_get_host_iommu_info(HostIOMMUDevice *hiod,
+                                            void *data, uint32_t len,
+                                            Error **errp)
+{
+    HIODIOMMUFD *idev = HIOD_IOMMUFD(hiod);
+    HIOD_IOMMUFD_INFO *info = data;
+
+    assert(sizeof(HIOD_IOMMUFD_INFO) <= len);
+
+    return iommufd_backend_get_device_info(idev->iommufd, idev->devid,
+                                           &info->type, &info->data,
+                                           sizeof(info->data), errp);
+}
+
 static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
 {
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hiodc->get_host_iommu_info = hiod_iommufd_get_host_iommu_info;
 }
 
 static const TypeInfo types[] = {
-- 
2.34.1


