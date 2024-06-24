Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E8AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCs-0005Yt-Gg; Mon, 24 Jun 2024 17:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCg-0004bf-Vk
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCe-0006m9-R0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2qATLNcNBu0tdZy+mmIA1IhZk80F7fErwBqOXKDazE=;
 b=YJ/dvULnlhyxAKs3fYvJKnFlIKfH/f4LJ9Mv0ZZ6NRjzN3q29Spav5b4blKP2Q3EvMBV41
 SI5qDRy/FoNzWUPd0sSEFADVk9R6R+xxOvEWF80V7FfeeYoO1yCcBOUvYxflvRJWnA10uE
 rGWgCPnmw3EoHhtzHt1PUXAlwhBGcB0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-4Te833OYOTSj5AgJ_HkCHQ-1; Mon,
 24 Jun 2024 17:26:18 -0400
X-MC-Unique: 4Te833OYOTSj5AgJ_HkCHQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7627319560BD; Mon, 24 Jun 2024 21:26:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F9281956051; Mon, 24 Jun 2024 21:26:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 30/42] vfio/container: Introduce vfio_address_space_insert()
Date: Mon, 24 Jun 2024 23:24:44 +0200
Message-ID: <20240624212456.350919-31-clg@redhat.com>
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

It prepares ground for a future change initializing the 'space' pointer
of VFIOContainerBase. The goal is to replace vfio_container_init() by
an .instance_init() handler when VFIOContainerBase is QOMified.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h | 2 ++
 hw/vfio/common.c              | 6 ++++++
 hw/vfio/container.c           | 2 +-
 hw/vfio/iommufd.c             | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c19572f90b277193491020af28e8b5587f15bfd1..825d80130bd435fe50830c8ae5b7905d18104dd6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -206,6 +206,8 @@ typedef struct VFIODisplay {
 
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
+void vfio_address_space_insert(VFIOAddressSpace *space,
+                               VFIOContainerBase *bcontainer);
 
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f28641bad5cf4b71fcdc0a6c9d42b24c8d786248..8cdf26c6f5a490cfa02bdf1087a91948709aaa33 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1508,6 +1508,12 @@ void vfio_put_address_space(VFIOAddressSpace *space)
     }
 }
 
+void vfio_address_space_insert(VFIOAddressSpace *space,
+                               VFIOContainerBase *bcontainer)
+{
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+}
+
 struct vfio_device_info *vfio_get_device_info(int fd)
 {
     struct vfio_device_info *info;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c48749c089a67ee4d0e6b8dd975562e2938500cd..0237c216987ff64a6d11bef8688bb000d93a7f09 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -637,7 +637,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     vfio_kvm_device_add_group(group);
 
     QLIST_INIT(&container->group_list);
-    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+    vfio_address_space_insert(space, bcontainer);
 
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e502081c2ad9eda31769176f875fef60a77e2b43..9f8f33e383a38827ceca0f73cb77f5ca6b123198 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -358,7 +358,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, iommufd_vioc);
-    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+    vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
         goto err_attach_container;
-- 
2.45.2


