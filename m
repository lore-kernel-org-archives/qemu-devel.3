Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AA9C25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dHX-0001Dx-DS; Wed, 08 May 2024 05:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHJ-0000Hp-0O
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:59 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHG-0005S1-Kv
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159275; x=1746695275;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3evy5Fn1NeUvF8A+wdco68VIVay91RZK5fR/tL35KqQ=;
 b=Up5EM6RshJkQreGIsOa3bEiQSuc6uKH6JRoKcGDPzkyZg7oRBDiIfH6c
 8ECe+0b3Yt+kbE8HSfNx4IzubiwErKFwABC7l9JX4Dm1O7kH3K9UU9mMf
 ixcnbAwxxtElW+qk5UB8STHYUqcmzrCh/uIE4LyYaujDSecECmo7Ln0ml
 JwpF+AjOIY+/yx3aLM37+HSRWxfk0d0uCCk8cZYE2/n6ZqDzpcBA1xcdr
 R6ykzXyq1jdJn5ZKDPcjzdanQpJJKx5n1Zu8g7xStbJpVT6y3n3DfT9DV
 cUrG9hHk4GhbtwzJmw4zqwiVpcv4HFiqpB7uLZ9pEPUprvFPhCtyV1wQV g==;
X-CSE-ConnectionGUID: /PbniVtQRy2zXZbP1QbjxA==
X-CSE-MsgGUID: huqD/+RZSFCjZReahWiRJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11161043"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11161043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:54 -0700
X-CSE-ConnectionGUID: ISsGmb5SQRKQrUIr8V/pzg==
X-CSE-MsgGUID: Rywo4QF+TPuWPx/ENFZlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226650"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:07:50 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 13/19] vfio: Create host IOMMU device instance
Date: Wed,  8 May 2024 17:03:48 +0800
Message-Id: <20240508090354.1815561-14-zhenzhong.duan@intel.com>
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

Create host IOMMU device instance in vfio_attach_device() and call
.realize() to initialize it further.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index affb73f209..94428abcf4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -126,6 +126,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
 } VFIODevice;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9f1f2e19f7..970c9e3a5f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1497,6 +1497,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDevice *hiod;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1504,7 +1505,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
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
@@ -1512,5 +1525,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
+    object_unref(vbasedev->hiod);
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
-- 
2.34.1


