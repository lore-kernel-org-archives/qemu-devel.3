Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F78C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2n-0005LD-Jv; Wed, 11 Jun 2025 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2j-00050j-Fs
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2h-000794-OC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMxtlPE7B4sju9qdm8kTdFAlyAtykB3GEclaldZ3V9E=;
 b=OT3QqEijA5dko6cT8madOLui5lb7dOymihivy4DFGJ22eb4iG5xm994YFWa/3x/PMqLZj2
 RBI2VJHt07iZ2UwUhhFz6y7FCDOQ/PHrL6KYl882EGke8s+/2YryQ8qqwae+Vv6Os+afpu
 a1eFBO3fyk26o+DW44bjkBMN/UOdUoI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-AlfbAGqcP3SavgiyDn12Eg-1; Wed,
 11 Jun 2025 11:07:05 -0400
X-MC-Unique: AlfbAGqcP3SavgiyDn12Eg-1
X-Mimecast-MFC-AGG-ID: AlfbAGqcP3SavgiyDn12Eg_1749654424
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8831195608F; Wed, 11 Jun 2025 15:07:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31EC1180045C; Wed, 11 Jun 2025 15:07:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/27] vfio/container: mdev cpr blocker
Date: Wed, 11 Jun 2025 17:06:08 +0200
Message-ID: <20250611150620.701903-17-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

During CPR, after VFIO_DMA_UNMAP_FLAG_VADDR, the vaddr is temporarily
invalid, so mediated devices cannot be supported.  Add a blocker for them.
This restriction will not apply to iommufd containers when CPR is added
for them in a future patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-8-git-send-email-steven.sistare@oracle.com
[ clg: Fixed context change in VFIODevice ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h    | 3 +++
 include/hw/vfio/vfio-device.h | 2 ++
 hw/vfio/container.c           | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 04624475f87361954a09ba3c9a47cf1d8e7cc5b3..b83dd4275183595aa31071d99099ad746931c66a 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -22,6 +22,9 @@ typedef struct VFIOContainerCPR {
                          void *vaddr, bool readonly, MemoryRegion *mr);
 } VFIOContainerCPR;
 
+typedef struct VFIODeviceCPR {
+    Error *mdev_blocker;
+} VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 9793b2dba0ced9e87b1641ae783867ce1b41e71a..f39259406bdd7b4577c4c54cfb3ac0dbbcedccb2 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -28,6 +28,7 @@
 #endif
 #include "system/system.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "system/host_iommu_device.h"
 #include "system/iommufd.h"
 
@@ -86,6 +87,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
     int *region_fds;
+    VFIODeviceCPR cpr;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 936ce37f190686b0875ed934ee277d9e4ff8cb2f..3e8d645ebbd7b13c55625f38f4250670a63df124 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -987,6 +987,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto device_put_exit;
     }
 
+    if (vbasedev->mdev) {
+        error_setg(&vbasedev->cpr.mdev_blocker,
+                   "CPR does not support vfio mdev %s", vbasedev->name);
+        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
+                                  MIG_MODE_CPR_TRANSFER, -1);
+    }
+
     return true;
 
 device_put_exit:
@@ -1004,6 +1011,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 
     vfio_device_unprepare(vbasedev);
 
+    migrate_del_blocker(&vbasedev->cpr.mdev_blocker);
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
-- 
2.49.0


