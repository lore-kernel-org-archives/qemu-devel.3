Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB05C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8ElA-00084A-Nj; Fri, 25 Apr 2025 04:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkV-00077t-Ku
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EkT-0003Nq-Ul
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+aoCmiHdt5aSTQt6vuKxlPA0N2D0f+F6ijAi7/To8Y=;
 b=Tb5hhDA/445upQEf2MSlH+RZXqTOrapsWW3eOrDGr6KTSwy3ghhEIUQE74hxuH25ynnWpq
 iux4Er7ZlWNIg7Wy5sJcFZ/SEjvh0ctElnDHtQr4CXZlvERWHiQsrR4H6EkFrLaxLGCdCa
 LvNbLwaMT0mo/yfsFVB6obRXjbsoaKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-ceS8g4ydPjC0-VDgJUJmLw-1; Fri,
 25 Apr 2025 04:49:25 -0400
X-MC-Unique: ceS8g4ydPjC0-VDgJUJmLw-1
X-Mimecast-MFC-AGG-ID: ceS8g4ydPjC0-VDgJUJmLw_1745570964
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC759180034E; Fri, 25 Apr 2025 08:49:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 036CC30001A2; Fri, 25 Apr 2025 08:49:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 48/50] vfio: Register/unregister container for CPR only once
 for each container
Date: Fri, 25 Apr 2025 10:46:41 +0200
Message-ID: <20250425084644.102196-49-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

vfio_cpr_register_container and vfio_cpr_unregister_container are container
scoped function. Calling them for each device attaching/detaching would
corrupt CPR reboot notifier list, i.e., when two VFIO devices are attached
to same container and have same notifier registered twice.

Fixes: d9fa4223b30a ("vfio: register container for cpr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250424063355.3855174-1-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f24054a6a5467e3b3436f106bf764c7de8019b0c..b2f72dc8c3687190f2c9d0f1d0a8bc80200930c3 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -416,6 +416,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
+    vfio_cpr_unregister_container(bcontainer);
     vfio_listener_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
@@ -561,6 +562,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_listener_register;
     }
 
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto err_listener_register;
+    }
+
     bcontainer->initialized = true;
 
 found_container:
@@ -570,13 +575,9 @@ found_container:
         goto err_listener_register;
     }
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto err_listener_register;
-    }
-
     if (!vfio_device_hiod_create_and_realize(vbasedev,
                      TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
-        goto err_hiod_realize;
+        goto err_listener_register;
     }
 
     /*
@@ -600,8 +601,6 @@ found_container:
                                    vbasedev->num_regions, vbasedev->flags);
     return true;
 
-err_hiod_realize:
-    vfio_cpr_unregister_container(bcontainer);
 err_listener_register:
     iommufd_cdev_ram_block_discard_disable(false);
 err_discard_disable:
@@ -632,7 +631,6 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     }
 
     object_unref(vbasedev->hiod);
-    vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
     vfio_address_space_put(space);
-- 
2.49.0


