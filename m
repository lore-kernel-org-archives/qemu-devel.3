Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE1C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0xO-0005Om-QM; Mon, 03 Jun 2024 02:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xM-0005FI-HR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:08 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xK-0000xl-Sx
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395247; x=1748931247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BMSIUgLa5Y1OsVlKLzI0+ljLIY7H18OPFG5Alyk5isg=;
 b=G4DKlBCSaxcOUo4nJtR8qrU86PbyFQ5mK0GKWzdyJ0rqwBvXugsNEyWS
 QDbhXzmn8lfrf78rJOqP+Xgsmtxb9N284SY6zYo2nQXvvqY5iM7lIft3T
 6GwtE1eNfnxnmPgCb88wBeJF5oRAH856mvaSc6dxCQ/+BHynNUY2wsr/f
 TlRbMYukQIkVKrV5FRwB1gizzTiuC6820IxzUkIneLDlHGAI/IISkvsyE
 lziJ9MWpQEfzuGTt2BFSMrI1ts7d4cv288RCvMOKsU+CFkxlpxzwJi+Ua
 J7TUUTsyfQIaMfCfzjkFgHkAzCVpZnijP7oMabKqnAk8dEMDDxW9KY86/ w==;
X-CSE-ConnectionGUID: d0aBiSHOQAakJIWubOyaXg==
X-CSE-MsgGUID: iN0C+ZmPSeu3kax9tlszzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277732"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277732"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:06 -0700
X-CSE-ConnectionGUID: 2v3kfL2wQTCdIlOSECSkmQ==
X-CSE-MsgGUID: Ol2gW2CsQDyDx7wd7+Xuag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855960"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 13/19] vfio: Create host IOMMU device instance
Date: Mon,  3 Jun 2024 14:10:17 +0800
Message-Id: <20240603061023.269738-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Create host IOMMU device instance in vfio_attach_device() and call
.realize() to initialize it further.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 56d1717211..c0851e83bb 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -127,6 +127,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
 } VFIODevice;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f9619a1dfb..f20a7b5bba 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1528,6 +1528,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDevice *hiod;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1535,7 +1536,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-    return ops->attach_device(name, vbasedev, as, errp);
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
+        return false;
+    }
+
+    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        object_unref(hiod);
+        ops->detach_device(vbasedev);
+        return false;
+    }
+    vbasedev->hiod = hiod;
+
+    return true;
 }
 
 void vfio_detach_device(VFIODevice *vbasedev)
@@ -1543,5 +1556,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
+    object_unref(vbasedev->hiod);
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
-- 
2.34.1


