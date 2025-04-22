Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B58C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GAF-0004bd-JW; Tue, 22 Apr 2025 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6N-0008Qd-K2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G6L-00059K-G8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qHdONrKVBhonIWQs3WP2A/7n7fosRUhbWc1hKpQJX5k=;
 b=CZOTNmi5MRYdg7wCyqKPjZ8IW1m0UJnH8RfdzfseRGAQHfOkE4NyF9Y0ZJW/XaWZsN1Ex7
 9Z04U28PvcbPoCxz0Ka/wvUfDRs5LYheRd8h+fpiyub3ER2MnyNQt1nXnNOlFNfJPc/aE4
 bAm3coi3zJAQMLYcoNduoZiIwuTtNpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-Y8b-jWg2MfWUJ_AZayqATg-1; Tue,
 22 Apr 2025 12:03:55 -0400
X-MC-Unique: Y8b-jWg2MfWUJ_AZayqATg-1
X-Mimecast-MFC-AGG-ID: Y8b-jWg2MfWUJ_AZayqATg_1745337834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DF601955E87; Tue, 22 Apr 2025 16:03:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8E5F180010A; Tue, 22 Apr 2025 16:03:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 24/37] vfio: Move vfio_de/attach_device() into device.c
Date: Tue, 22 Apr 2025 18:02:11 +0200
Message-ID: <20250422160224.199714-25-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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
index f16d679e71244e225b831b2cc39c49ee2b1cd940..a4052526ece5fdee0e690ad133416d1dc4eb1815 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1319,40 +1319,3 @@ void vfio_reset_handler(void *opaque)
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


