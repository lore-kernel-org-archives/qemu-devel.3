Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E24C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNc5-00039Y-6h; Wed, 12 Jun 2024 09:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNc1-00038i-5o
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sHNby-0007zm-7i
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAFSvPlmfqnTJEUUtuHv/7KBJ58vK70XthaPf9rN1VY=;
 b=Dz9grMY6mbiF6WpWEPSAm6hIYXaENIAT7yxXDcxs8wAYrUuZuohs7tuiNMOwXNYY6OLMV8
 OYerJQmnGB/CZUkrppuYC9pIxQtxgXT94qKvBEupRLCHlCcJnCygcfjFkqEwN3rrh56WSS
 lOLzSCjU++QkDki63X5m16U7uj6aEdA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-AYLpDI9ZMmCbP8zEj6Us-A-1; Wed,
 12 Jun 2024 09:01:55 -0400
X-MC-Unique: AYLpDI9ZMmCbP8zEj6Us-A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB1F9195607B; Wed, 12 Jun 2024 13:01:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04EC51956053; Wed, 12 Jun 2024 13:01:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 12/16] vfio/container: Switch to QOM
Date: Wed, 12 Jun 2024 15:01:18 +0200
Message-ID: <20240612130122.813935-13-clg@redhat.com>
In-Reply-To: <20240612130122.813935-1-clg@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of allocating the container struct, create a QOM object of the
appropriate type.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 6 +++---
 hw/vfio/iommufd.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index f1519518d0b7efd2a6086f07bc497596a5236abf..f8bde76cfdba41f3d6da8a7c852624485bd933a0 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -435,7 +435,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
     vioc_name = vfio_get_iommu_class_name(iommu_type);
     vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
 
-    container = g_malloc0(sizeof(*container));
+    container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
     container->fd = fd;
     container->iommu_type = iommu_type;
     vfio_container_init(&container->bcontainer, vioc);
@@ -674,7 +674,7 @@ unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
 free_container_exit:
-    g_free(container);
+    object_unref(container);
 
 close_fd_exit:
     close(fd);
@@ -718,7 +718,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         trace_vfio_disconnect_container(container->fd);
         vfio_cpr_unregister_container(bcontainer);
         close(container->fd);
-        g_free(container);
+        object_unref(container);
 
         vfio_put_address_space(space);
     }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 80ba09b859a02bb89823460064a9f099fd98cff0..5daf9c1ea268e7b4ab0dbfe9e55a176b23aaa62b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -239,7 +239,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     memory_listener_unregister(&bcontainer->listener);
     vfio_container_destroy(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
-    g_free(container);
+    object_unref(container);
 }
 
 static int iommufd_cdev_ram_block_discard_disable(bool state)
@@ -352,7 +352,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
 
-    container = g_malloc0(sizeof(*container));
+    container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
 
-- 
2.45.2


