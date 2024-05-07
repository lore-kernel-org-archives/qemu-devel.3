Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93284C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZy-0003OH-CJ; Tue, 07 May 2024 02:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZw-0003Nh-Ef
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:32 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZu-0005Ee-Lm
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064330; x=1746600330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8uhN4/mEpj2+F2/bXHdbPWxUB6o5pfA6i0tofvxnefU=;
 b=aBqM0PG9xt44gdUI7/e0CRdegEzPiJQ4kGcntA2zs1rpJ76/i7x4GzXd
 9UHzYOV4PA7nSfsEfHmwwNVT1a9SBQzPbKfbCaX4vqLveKdXbdyxacGG6
 KM3dtkH6T0ViQjMr7XpD+4Fcq7drhq5co2vwp3n8NZTKc5lTwgLTCcx8w
 eH+QUK2xQzTDUJn/nMO9hCISseE6KyjRVUqHPuItqLd1bHOcqIMLPfDN2
 y2PiNLd6g4ItBV7n0x8ouNh9QhmxWJGWIjtngdMZ401gAuSMobXxlaRHA
 24YcRtnD7z66PCY63aveCxvKAaFxt/HTBkriHw2NcrxolHuK+m6DtDHzj A==;
X-CSE-ConnectionGUID: bfWfwt8xTyK3LInTwFZ4yQ==
X-CSE-MsgGUID: zBew0Vk0QdSHyaV/xGc8kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240259"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240259"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:30 -0700
X-CSE-ConnectionGUID: AKKcguHGSL6vB/sonc2ziQ==
X-CSE-MsgGUID: ng4yOO1iQeWpJWlJnFZ+pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407534"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:28 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 07/11] vfio/container: Make vfio_set_iommu() return bool
Date: Tue,  7 May 2024 14:42:48 +0800
Message-Id: <20240507064252.457884-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
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

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0a7edfcc43..5fb4bee082 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -391,21 +391,20 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
     return VFIO_IOMMU_CLASS(klass);
 }
 
-static int vfio_set_iommu(VFIOContainer *container, int group_fd,
-                          VFIOAddressSpace *space, Error **errp)
+static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
+                           VFIOAddressSpace *space, Error **errp)
 {
-    int iommu_type, ret;
+    int iommu_type;
     const VFIOIOMMUClass *vioc;
 
     iommu_type = vfio_get_iommu_type(container, errp);
     if (iommu_type < 0) {
-        return iommu_type;
+        return false;
     }
 
-    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
-    if (ret) {
+    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
         error_setg_errno(errp, errno, "Failed to set group container");
-        return -errno;
+        return false;
     }
 
     while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
@@ -420,7 +419,7 @@ static int vfio_set_iommu(VFIOContainer *container, int group_fd,
             continue;
         }
         error_setg_errno(errp, errno, "Failed to set iommu for container");
-        return -errno;
+        return false;
     }
 
     container->iommu_type = iommu_type;
@@ -428,11 +427,11 @@ static int vfio_set_iommu(VFIOContainer *container, int group_fd,
     vioc = vfio_get_iommu_class(iommu_type, errp);
     if (!vioc) {
         error_setg(errp, "No available IOMMU models");
-        return -EINVAL;
+        return false;
     }
 
     vfio_container_init(&container->bcontainer, space, vioc);
-    return 0;
+    return true;
 }
 
 static int vfio_get_iommu_info(VFIOContainer *container,
@@ -613,8 +612,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     bcontainer = &container->bcontainer;
 
-    ret = vfio_set_iommu(container, group->fd, space, errp);
-    if (ret) {
+    if (!vfio_set_iommu(container, group->fd, space, errp)) {
         goto free_container_exit;
     }
 
-- 
2.34.1


