Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBDAC19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuK-0002QK-Kv; Mon, 29 Apr 2024 02:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Kty-00022m-Cz
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:18 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktw-0007m1-Sa
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373653; x=1745909653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tNWXwVxKYnbq18V5ZGGMj3ymFLapPOH/53H7AuNgrB0=;
 b=AIu2d9N3EfPDI/fLk5/cPZwM2IGjXf2zZri/oHv6ibN6AArxr9/2Vo/6
 FY/1hDbCR9zfidpRIv2xHLobMpW9BUXRRlv2Dtbtda0FPPSyfem5knien
 cqO8h6hcDoY82VmCCjldN1XsUsnOXQ1M8N/KUT0Hhr/NypyeiF+wSkavz
 +lzNTTfdIKLWFyx5dlKg72Q/8aepbOTAXZ6rr221WUu0uEOEPYJqSifqZ
 95hneUHwPhDPgAhxleub7AFFJmSZahyPnGOwBmz7OAMJQ+tYMUoKBCxq6
 S3KucEuDm0fuFKDwNOaW4vcHwC7vA86g/1g18ackjOyFfKPVU/PAQNYIZ Q==;
X-CSE-ConnectionGUID: ckpWjJ2GRn2x3VJOBigV7w==
X-CSE-MsgGUID: B/vGsIgaTWye89kg6TmwmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560739"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560739"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:12 -0700
X-CSE-ConnectionGUID: OvsfKsnFSZ2Nyany9KFSJQ==
X-CSE-MsgGUID: RsfFQLVMQaqH23lu0Us5Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488273"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 13/19] vfio: Create host IOMMU device instance
Date: Mon, 29 Apr 2024 14:50:40 +0800
Message-Id: <20240429065046.3688701-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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
 hw/vfio/common.c              | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 0943add3bc..b204b93a55 100644
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
index 8f9cbdc026..0be8b70ebd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1497,6 +1497,8 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDevice *hiod;
+    int ret;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1504,7 +1506,20 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-    return ops->attach_device(name, vbasedev, as, errp);
+    ret = ops->attach_device(name, vbasedev, as, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        object_unref(hiod);
+        ops->detach_device(vbasedev);
+        return -EINVAL;
+    }
+    vbasedev->hiod = hiod;
+
+    return 0;
 }
 
 void vfio_detach_device(VFIODevice *vbasedev)
@@ -1512,5 +1527,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
+    object_unref(vbasedev->hiod);
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
-- 
2.34.1


