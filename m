Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2AC30658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCy-0006DO-Fr; Mon, 24 Jun 2024 17:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCx-0006Bn-6J
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCv-0006ru-Hs
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSYD24a7WVbr1gt4gAk8qKAsjtEP1hsHj2HHhLHyt5U=;
 b=Gh1sVoChSwoGmZJRpNfTf0mVZXdorVcQqezj0RFPUd2b+IhFsyO4525eS7Qrpg1bd3lk2h
 xSxhogjzk64V/N5OUxdQ99YLg/mIa9eCive+FGKoDQaOA/Ywup8fUc+6KYD44NhhBD9pFp
 maGlfHnnZ6bnOpU3EMQ/nNXsTL0iX4E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-04yreZBrN8GxLmFm8wz_Tw-1; Mon,
 24 Jun 2024 17:26:33 -0400
X-MC-Unique: 04yreZBrN8GxLmFm8wz_Tw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1E171955F32; Mon, 24 Jun 2024 21:26:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2C781956051; Mon, 24 Jun 2024 21:26:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 37/42] vfio/container: Switch to QOM
Date: Mon, 24 Jun 2024 23:24:51 +0200
Message-ID: <20240624212456.350919-38-clg@redhat.com>
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

Instead of allocating the container struct, create a QOM object of the
appropriate type.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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


