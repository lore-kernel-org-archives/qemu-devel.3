Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEA8C27C7B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5xM-0003TV-3o; Mon, 17 Jun 2024 02:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5x3-0002vR-Td
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5x2-0004MP-Fd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718606087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDxXHtaojtyXbbx4CzGZnxL4Ol0JclFopDWBLWsp7Js=;
 b=X8qaWAgUTTy6/gtsPHE4ttK7iNJAEz2e9aWwcrFU8Pcuq9UM+gr6Pyq1HL0pS3R/+4wWRx
 AVo+cDco84p8YEfeYTNL9BPDir4mdRfGniXFgK13FIqEduGk00BwYDl9EY7kNyDh80FUCh
 qs1NU+AgMfJYN0/7jlLUj4l4sxUuopk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-qFlfE1tON7-L7QT4NJeftA-1; Mon,
 17 Jun 2024 02:34:45 -0400
X-MC-Unique: qFlfE1tON7-L7QT4NJeftA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1384195609F; Mon, 17 Jun 2024 06:34:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2DE53000218; Mon, 17 Jun 2024 06:34:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 12/17] vfio/container: Switch to QOM
Date: Mon, 17 Jun 2024 08:34:04 +0200
Message-ID: <20240617063409.34393-13-clg@redhat.com>
In-Reply-To: <20240617063409.34393-1-clg@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 6 +++---
 hw/vfio/iommufd.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3ae52530a9b500bd53ec9f9e66c73253d97c9aba..ff3a6831da83c0fe11060cd57918c4d87b10197c 100644
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
index 3e9d642034c2d2234ea701952c94a78ab32e9147..d59df858407f3cadb9405386ad673c99cdad61d0 100644
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


