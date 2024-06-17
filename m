Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ECEC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5xN-0003a8-KA; Mon, 17 Jun 2024 02:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5xA-0002zJ-Pe
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ5x9-0004P6-9J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718606094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQ03fDex+vcLSTu4ScySL5pRDCdGampzP8xDSdhzxUc=;
 b=d3SM2HdwybacW5CZ4bw6NkKWKzmKxmYrMkwnNXeYrgGNOb+Ct3GcKRw8Wql9H+0kDAxlP5
 6Yf469C/BOAV8A5LIreltp7Omv4Zo/p7StEPLhXHMBWN9m6rIPNgHCHPsnc258nUfjSd3j
 ffTi/LcDQmtWRSkB4OfTLmZre7n5/Hc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-QzeBSKlYONejMyk6g0ff6A-1; Mon,
 17 Jun 2024 02:34:52 -0400
X-MC-Unique: QzeBSKlYONejMyk6g0ff6A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E66E195608A; Mon, 17 Jun 2024 06:34:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D063F3000220; Mon, 17 Jun 2024 06:34:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 15/17] vfio/container: Remove vfio_container_init()
Date: Mon, 17 Jun 2024 08:34:07 +0200
Message-ID: <20240617063409.34393-16-clg@redhat.com>
In-Reply-To: <20240617063409.34393-1-clg@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

It's now empty.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 2 --
 hw/vfio/container-base.c              | 5 -----
 hw/vfio/container.c                   | 3 ---
 hw/vfio/iommufd.c                     | 1 -
 4 files changed, 11 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 6b57cd8e7f5d7d2817f6e3b96ce4566d2630bb12..6242a62771caa8cf19440a53ad6f4db862ca12d7 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -86,8 +86,6 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 
-void vfio_container_init(VFIOContainerBase *bcontainer,
-                         const VFIOIOMMUClass *ops);
 void vfio_container_destroy(VFIOContainerBase *bcontainer);
 
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 24669d4d7472f49ac3adf2618a32bf7d82c5c344..970ae2356a92f87df44e1dd58ff8c67045a24ef1 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -83,11 +83,6 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                                errp);
 }
 
-void vfio_container_init(VFIOContainerBase *bcontainer,
-                         const VFIOIOMMUClass *ops)
-{
-}
-
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
 {
     VFIOGuestIOMMU *giommu, *tmp;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a2f5fbad00cd228e27a47df5cd683dbb34296113..3f2032d5c496de078c277ebacc49d7db89f4cc65 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -419,7 +419,6 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
                                             Error **errp)
 {
     int iommu_type;
-    const VFIOIOMMUClass *vioc;
     const char *vioc_name;
     VFIOContainer *container;
 
@@ -433,12 +432,10 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
     }
 
     vioc_name = vfio_get_iommu_class_name(iommu_type);
-    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
 
     container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
     container->fd = fd;
     container->iommu_type = iommu_type;
-    vfio_container_init(&container->bcontainer, vioc);
     return container;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7bc76f80b48ea5422e68fd4d4cb3f5bca90993f6..09b71a6617807c621275c74b924cfd39eb643961 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -357,7 +357,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     container->ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
-    vfio_container_init(bcontainer, iommufd_vioc);
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
-- 
2.45.2


