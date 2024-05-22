Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F64AC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ih1-0003Yk-W2; Wed, 22 May 2024 05:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igy-0003WI-VI
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igw-0001iU-RW
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aiaEkCxG//DdU0IUGAS4mKXWBN7H5W5sSyTxn3jxbw=;
 b=EGHEBdu2UD5h92b9W5D7AqM78WGfaY+JiZCxXYKmbJVaKFkpy3r09pEhcbUYuNKnVM18Iu
 I18esY4APTSLtL656ms6EfkgM5sfI/FNUqCOVroxA8GEM0ftfJqKmiaWYnOrF5dKANvCRK
 HDjOJxy/ruhlN9zmHl1cKmr2oL1cJCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-7w3DL21MO-aB4m2YhnapCA-1; Wed, 22 May 2024 05:55:21 -0400
X-MC-Unique: 7w3DL21MO-aB4m2YhnapCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96CCC8058D4;
 Wed, 22 May 2024 09:55:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76AEF7412;
 Wed, 22 May 2024 09:55:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/47] vfio: Make VFIOIOMMUClass::setup() return bool
Date: Wed, 22 May 2024 11:54:17 +0200
Message-ID: <20240522095442.195243-23-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  2 +-
 hw/vfio/container.c                   | 10 +++++-----
 hw/vfio/spapr.c                       | 12 +++++-------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 44927ca8c3583246145defe043ac34da604d39bf..202e23cb6b800983b036bf3808c0ec38b1c363d0 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -110,7 +110,7 @@ struct VFIOIOMMUClass {
     InterfaceClass parent_class;
 
     /* basic feature */
-    int (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e7c416774791d506cc7c4696fb6a6d94dc809c8e..f2e9560a1906c4151535260e3488ee80ca90e78b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -507,7 +507,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
-static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
+static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
@@ -517,7 +517,7 @@ static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     ret = vfio_get_iommu_info(container, &info);
     if (ret) {
         error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
-        return ret;
+        return false;
     }
 
     if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
@@ -533,7 +533,7 @@ static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     vfio_get_info_iova_range(info, bcontainer);
 
     vfio_get_iommu_info_migration(container, info);
-    return 0;
+    return true;
 }
 
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
@@ -635,8 +635,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     assert(bcontainer->ops->setup);
 
-    ret = bcontainer->ops->setup(bcontainer, errp);
-    if (ret) {
+    if (!bcontainer->ops->setup(bcontainer, errp)) {
+        ret = -EINVAL;
         goto enable_discards_exit;
     }
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 0d949bb728212534a7e2296e491aa8d95f45945d..148b257c9ca6a0f957115f8060ddb50e377dfcb8 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -458,8 +458,8 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
     }
 }
 
-static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
-                                      Error **errp)
+static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
+                                       Error **errp)
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
@@ -480,7 +480,7 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         ret = ioctl(fd, VFIO_IOMMU_ENABLE);
         if (ret) {
             error_setg_errno(errp, errno, "failed to enable container");
-            return -errno;
+            return false;
         }
     } else {
         scontainer->prereg_listener = vfio_prereg_listener;
@@ -488,7 +488,6 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         memory_listener_register(&scontainer->prereg_listener,
                                  &address_space_memory);
         if (bcontainer->error) {
-            ret = -1;
             error_propagate_prepend(errp, bcontainer->error,
                     "RAM memory listener initialization failed: ");
             goto listener_unregister_exit;
@@ -500,7 +499,6 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
     if (ret) {
         error_setg_errno(errp, errno,
                          "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
-        ret = -errno;
         goto listener_unregister_exit;
     }
 
@@ -527,13 +525,13 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                           0x1000);
     }
 
-    return 0;
+    return true;
 
 listener_unregister_exit:
     if (v2) {
         memory_listener_unregister(&scontainer->prereg_listener);
     }
-    return ret;
+    return false;
 }
 
 static void vfio_iommu_spapr_class_init(ObjectClass *klass, void *data)
-- 
2.45.1


