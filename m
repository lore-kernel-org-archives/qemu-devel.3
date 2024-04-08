Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F6DC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkAv-0003jy-3f; Mon, 08 Apr 2024 04:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkAC-0003N9-CJ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkA9-00089q-JL
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564134; x=1744100134;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DVXEQ9yLYmU2ztZd49QkuJi4eo9VDVlNfFqfrJ3+k7g=;
 b=GSTDpJDXkwkBRm5ZgtjybBWLh1js5xg1Oc6IudeCVkv6qRfQq4FD1Kqo
 ckoYCi+vK+wepGEbLS+RY4ON/GIvF1g8rd+NDZKNexAnfv/3Wxlxa6TzS
 Ot7EGTZ1IdZLB4TtWuGbh9okGF8kwN2a5c5+6cJ78dw8SSXmRCgwDU5Vs
 qLSXdHXSF1qADDz7T0g3QPA/hbdLrhAJeWkKopZuUy/B7NG5c9OkdOedE
 LpsHHZu1YSfo82kABpxXB13GeoPplw+o3DeP8djfF9sniFGL6Y2LHzJ1p
 gGjhfiAfj99UK6dsxs2Zqnakb69uXA+YcVJpGqbfy1A5rndTGR0m0xhIt g==;
X-CSE-ConnectionGUID: UgUpGAStRW2WiKo/+U31FQ==
X-CSE-MsgGUID: fjvCROubSta6N+jMskoFhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199743"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199743"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:33 -0700
X-CSE-ConnectionGUID: nRXBpU6nSUqBwRBd1UeG5Q==
X-CSE-MsgGUID: RcHR3eY3ThaPjkYeyG39Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845216"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 08/10] vfio: Create host IOMMU device instance
Date: Mon,  8 Apr 2024 16:12:28 +0800
Message-Id: <20240408081230.1030078-9-zhenzhong.duan@intel.com>
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

Create host IOMMU device instance and initialize it based on backend.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/container.c           | 5 +++++
 hw/vfio/iommufd.c             | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d382b12ec1..4fbba85018 100644
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
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ba0ad4a41b..fc0c027501 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -915,6 +915,7 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     VFIOContainerBase *bcontainer;
+    HIODLegacyVFIO *hiod_vfio;
     int ret;
 
     if (groupid < 0) {
@@ -945,6 +946,9 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     vbasedev->bcontainer = bcontainer;
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    hiod_vfio = HIOD_LEGACY_VFIO(object_new(TYPE_HIOD_LEGACY_VFIO));
+    hiod_vfio->vdev = vbasedev;
+    vbasedev->hiod = HOST_IOMMU_DEVICE(hiod_vfio);
 
     return ret;
 }
@@ -959,6 +963,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     trace_vfio_detach_device(vbasedev->name, group->groupid);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
+    object_unref(vbasedev->hiod);
 }
 
 static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 115b9f8e7f..b6d058339b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -308,6 +308,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     VFIOIOMMUFDContainer *container;
     VFIOAddressSpace *space;
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
+    HIODIOMMUFDVFIO *hiod_vfio;
     int ret, devfd;
     uint32_t ioas_id;
     Error *err = NULL;
@@ -431,6 +432,12 @@ found_container:
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
+    hiod_vfio = HIOD_IOMMUFD_VFIO(object_new(TYPE_HIOD_IOMMUFD_VFIO));
+    hiod_iommufd_init(HIOD_IOMMUFD(hiod_vfio), vbasedev->iommufd,
+                      vbasedev->devid);
+    hiod_vfio->vdev = vbasedev;
+    vbasedev->hiod = HOST_IOMMU_DEVICE(hiod_vfio);
+
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
     return 0;
@@ -468,6 +475,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
+    object_unref(vbasedev->hiod);
 
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
-- 
2.34.1


