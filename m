Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDEAC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrDA-0007Ee-79; Mon, 24 Jun 2024 17:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrD8-0006wo-9p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrD6-0006tX-I8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DrEuWiPrw/PMDyqHgo8yeVZ2t0F/mjW3fBpCaHvBzM=;
 b=b55DaX+8LfrtRE3U5vrPLo1ZZWgvyXdFTSn6CNczOW5/QTW6cNOWSOuXs+Qm9KB/SptVvX
 EVP5Zw9yLCE541Wc+ZW/bT53oSIczPdg/RlHGAPxcVpoElWzd5xFTYirS5T4x+0olxIxO9
 X9KBfBS4T40aV6IhmCOfEKHJFuDs3gc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-HCJ6pUX3NoKnKxyQnrkCiw-1; Mon,
 24 Jun 2024 17:26:44 -0400
X-MC-Unique: HCJ6pUX3NoKnKxyQnrkCiw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE7E1956087; Mon, 24 Jun 2024 21:26:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5FDCD1956051; Mon, 24 Jun 2024 21:26:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 42/42] vfio/container: Move vfio_container_destroy() to an
 instance_finalize() handler
Date: Mon, 24 Jun 2024 23:24:56 +0200
Message-ID: <20240624212456.350919-43-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

vfio_container_destroy() clears the resources allocated
VFIOContainerBase object. Now that VFIOContainerBase is a QOM object,
add an instance_finalize() handler to do the cleanup. It will be
called through object_unref().

Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ---
 hw/vfio/container-base.c              | 4 +++-
 hw/vfio/container.c                   | 2 --
 hw/vfio/iommufd.c                     | 1 -
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 6242a62771caa8cf19440a53ad6f4db862ca12d7..419e45ee7a5ac960dae4a993127fc9ee66d48db2 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -86,9 +86,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 
-void vfio_container_destroy(VFIOContainerBase *bcontainer);
-
-
 #define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 970ae2356a92f87df44e1dd58ff8c67045a24ef1..50b1664f89a8192cf4021498e59f2a92cd2f6e89 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -83,8 +83,9 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                                errp);
 }
 
-void vfio_container_destroy(VFIOContainerBase *bcontainer)
+static void vfio_container_instance_finalize(Object *obj)
 {
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
     VFIOGuestIOMMU *giommu, *tmp;
 
     QLIST_REMOVE(bcontainer, next);
@@ -116,6 +117,7 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU,
         .parent = TYPE_OBJECT,
         .instance_init = vfio_container_instance_init,
+        .instance_finalize = vfio_container_instance_finalize,
         .instance_size = sizeof(VFIOContainerBase),
         .class_size = sizeof(VFIOIOMMUClass),
         .abstract = true,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 45123acbdd6a681f4ce7cae7aa2509100ea225ab..2e7ecdf10edc4d84963a45ae9507096965da64fc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -712,8 +712,6 @@ static void vfio_disconnect_container(VFIOGroup *group)
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = bcontainer->space;
 
-        vfio_container_destroy(bcontainer);
-
         trace_vfio_disconnect_container(container->fd);
         vfio_cpr_unregister_container(bcontainer);
         close(container->fd);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 09b71a6617807c621275c74b924cfd39eb643961..c2f158e60386502eef267769ac9bce1effb67033 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -237,7 +237,6 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
         return;
     }
     memory_listener_unregister(&bcontainer->listener);
-    vfio_container_destroy(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
 }
-- 
2.45.2


