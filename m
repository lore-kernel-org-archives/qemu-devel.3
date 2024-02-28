Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE99BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB8o-0005hp-5G; Tue, 27 Feb 2024 23:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8j-0005Zq-I9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:53 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8T-0000kD-8m
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092897; x=1740628897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kK5GveDjiGIDtpRZDuuTtvD+hLljT6hrvvuILu4Z11U=;
 b=Fb5N9IqW9nccqbL9IU5LpZSmvhi8+rQbfnt4PD1xTTlQUBEcM6ShWkNQ
 rg6s1FsWBN7+d8PBfrUtUnDL1Rxyz5X9m32VtNXz+dA3bypL6BOmsJ9oy
 uygNzCcOKWCalAQqwJyMlpV9CFBm/xN8m/eUl07UcYXwCXlLJYXxhlQqI
 Pa/+Pam4IZke4lBYr7RqDym3Y0GoaJykDMXJ/YbFgMrOGwxjZuFHS4xfr
 c/vM+/+MdK3e8+vCgNWEaA4rz8lF8w7wNWNcCuibql7rdlYob9GYaCEhn
 9xA6Sw9hzqzDMrRcd7ayPHNYwmC95AU0m51A7/1K5LrWjkPxahBaUq1WV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342461"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342461"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917209"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:25 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Date: Wed, 28 Feb 2024 11:58:54 +0800
Message-Id: <20240228035900.1085727-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Introduce host_iommu_device_create callback and a wrapper for it.

This callback is used to allocate a host iommu device instance and
initialize it based on type.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 1 +
 include/hw/vfio/vfio-container-base.h | 1 +
 hw/vfio/common.c                      | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b6676c9f79..9fefea4b89 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -208,6 +208,7 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_attach_device(char *name, VFIODevice *vbasedev,
                        AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
+void host_iommu_device_create(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b2813b0c11..dc003f6eb2 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -120,6 +120,7 @@ struct VFIOIOMMUClass {
     int (*attach_device)(const char *name, VFIODevice *vbasedev,
                          AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
+    void (*host_iommu_device_create)(VFIODevice *vbasedev);
     /* migration feature */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
                                    bool start);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc07a..41e9031c59 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1521,3 +1521,11 @@ void vfio_detach_device(VFIODevice *vbasedev)
     }
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
+
+void host_iommu_device_create(VFIODevice *vbasedev)
+{
+    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
+
+    assert(ops->host_iommu_device_create);
+    ops->host_iommu_device_create(vbasedev);
+}
-- 
2.34.1


