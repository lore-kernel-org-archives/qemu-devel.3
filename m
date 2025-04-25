Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E2EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejk-0004k2-D3; Fri, 25 Apr 2025 04:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjV-0003jn-Fp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjT-0003IS-EA
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saVfaofs99sOvnyICh6ln/o6vjtI9t3VHofWTVv66AY=;
 b=KiC5wh+LC+yDnfnwiqmtUp6V8h+H7QP918KD/oUrFRs4lEZSGrbzStJ/umw+OpIgH12569
 Uak3gadaw6qeGT3uBZMSl9c8i3MduCU2XlkU/GaPL8RaZHqNmuEGnvh2tk3Ib01ny78+XG
 aXTXo/ZtPLW6YMTIqDJiVRP5Cd3y58o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-YwO7L9KnNIWGtEpOJrO2ig-1; Fri,
 25 Apr 2025 04:48:24 -0400
X-MC-Unique: YwO7L9KnNIWGtEpOJrO2ig-1
X-Mimecast-MFC-AGG-ID: YwO7L9KnNIWGtEpOJrO2ig_1745570903
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78CAD1955DC5; Fri, 25 Apr 2025 08:48:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95CFD30001A2; Fri, 25 Apr 2025 08:48:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 28/50] vfio: Move vfio_de/attach_device() into device.c
Date: Fri, 25 Apr 2025 10:46:21 +0200
Message-ID: <20250425084644.102196-29-clg@redhat.com>
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

These routines are VFIODevice related. Move their definitions into
"device.c".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-24-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-25-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 37 -------------------------------------
 hw/vfio/device.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4e7d8e83ac72050f874e56143a9a4bc4527b0bda..a85ed364090f6676cbbc9b513f6afbf26b5a894b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1318,40 +1318,3 @@ void vfio_reset_handler(void *opaque)
         }
     }
 }
-
-bool vfio_attach_device(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
-{
-    const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-    HostIOMMUDevice *hiod = NULL;
-
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
-
-    assert(ops);
-
-
-    if (!vbasedev->mdev) {
-        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
-        vbasedev->hiod = hiod;
-    }
-
-    if (!ops->attach_device(name, vbasedev, as, errp)) {
-        object_unref(hiod);
-        vbasedev->hiod = NULL;
-        return false;
-    }
-
-    return true;
-}
-
-void vfio_detach_device(VFIODevice *vbasedev)
-{
-    if (!vbasedev->bcontainer) {
-        return;
-    }
-    object_unref(vbasedev->hiod);
-    VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
-}
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 25fdba10a882e35392f26a107509f80e4b1c880a..179c9fb8decc42dcd8d1b4fe10e7acaa2a6f2c7c 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -331,3 +331,40 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
         return NULL;
     }
 }
+
+bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp)
+{
+    const VFIOIOMMUClass *ops =
+        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDevice *hiod = NULL;
+
+    if (vbasedev->iommufd) {
+        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
+    }
+
+    assert(ops);
+
+
+    if (!vbasedev->mdev) {
+        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+        vbasedev->hiod = hiod;
+    }
+
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
+        object_unref(hiod);
+        vbasedev->hiod = NULL;
+        return false;
+    }
+
+    return true;
+}
+
+void vfio_detach_device(VFIODevice *vbasedev)
+{
+    if (!vbasedev->bcontainer) {
+        return;
+    }
+    object_unref(vbasedev->hiod);
+    VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
+}
-- 
2.49.0


