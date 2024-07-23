Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F624C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4M-0008A2-5z; Tue, 23 Jul 2024 10:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4D-0007ui-D5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4B-0003e4-TN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7JeG/z75pZEebOULs7RZpwQuNEdlxYi3rdtOf5IBtU=;
 b=OIZgywq2Pn/fpdrzctUcebEFEtG9jmbPuuzqZU4zSvdHY18TT8vNp/8eDPqM+xLXAgIunU
 rzqTWsqB9oD2FdYsrZc8jM+GVnVR4TRcj7okk5Aew/IKPEZG//W7sn0VAKl27iYsU37q54
 yv89jThOglE3sFx71tQZNqwUwWI4qXg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-vrMqPp0xPJW0pU2-BtKONw-1; Tue,
 23 Jul 2024 10:00:32 -0400
X-MC-Unique: vrMqPp0xPJW0pU2-BtKONw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DECF01955D47; Tue, 23 Jul 2024 14:00:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC20C1955D4B; Tue, 23 Jul 2024 14:00:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 03/16] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
Date: Tue, 23 Jul 2024 16:00:06 +0200
Message-ID: <20240723140019.387786-4-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joao Martins <joao.m.martins@oracle.com>

mdevs aren't "physical" devices and when asking for backing IOMMU info, it
fails the entire provisioning of the guest. Fix that by skipping
HostIOMMUDevice initialization in the presence of mdevs, and skip setting
an iommu device when it is known to be an mdev.

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c |  4 ++++
 hw/vfio/pci.c    | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6d15b36e0bbbdaeb9437725167e61fdf5502555a..d7f02be595b5e71558d7e2d75d21d28f05968252 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1548,6 +1548,10 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
         return false;
     }
 
+    if (vbasedev->mdev) {
+        return true;
+    }
+
     hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
     if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
         object_unref(hiod);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b34e91468a533ab4d550bf2392e940b867f7b34c..265d3cb82ffc2a6ada02547c0d8e306318442ef7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3115,7 +3115,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+    if (!vbasedev->mdev &&
+        !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
@@ -3238,7 +3239,9 @@ out_deregister:
         timer_free(vdev->intx.mmap_timer);
     }
 out_unset_idev:
-    pci_device_unset_iommu_device(pdev);
+    if (!vbasedev->mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3283,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
-    pci_device_unset_iommu_device(pdev);
+    if (!vbasedev->mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 }
 
 static void vfio_pci_reset(DeviceState *dev)
-- 
2.45.2


