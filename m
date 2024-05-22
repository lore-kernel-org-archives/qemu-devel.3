Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDFCC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihG-0003nJ-Nq; Wed, 22 May 2024 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih4-0003a4-31
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih2-0001jt-Bx
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRuuNZBzxypv/pnih3IuYyo3ywdxPulrg4+T5lQo/rM=;
 b=P6I9Q31DQlR1Ax57NapmT7HGqxSG8V9oTceFJHDLkxqO24BB2UNg0rzfbUt9kvBOuPaMW/
 yf+96w+YwUV2JoJEZK8xXL8+zx9IFL8CISBBf3kQdEIovSPWvbh3ZWR/ZKfipa7fbv6oQR
 HZvfmL8e4IyB9q/fe+kJ5HfVkmI7NWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-nJjsmpVfPEmlL6Kyq9Euxw-1; Wed, 22 May 2024 05:55:30 -0400
X-MC-Unique: nJjsmpVfPEmlL6Kyq9Euxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B65F5101A551;
 Wed, 22 May 2024 09:55:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95A257412;
 Wed, 22 May 2024 09:55:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/47] vfio/cpr: Make vfio_cpr_register_container() return bool
Date: Wed, 22 May 2024 11:54:23 +0200
Message-ID: <20240522095442.195243-29-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/container.c           | 3 +--
 hw/vfio/cpr.c                 | 4 ++--
 hw/vfio/iommufd.c             | 3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e85817e65e65317d08bc2b17b738449198784796..b7bb4f5304addcdb03c971f27f99e5350ad0940a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -229,7 +229,7 @@ void vfio_detach_device(VFIODevice *vbasedev);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
-int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
+bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
 extern const MemoryRegionOps vfio_region_ops;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 53649e397cab94f8a2b61e6d66f21d635556e04e..096cc972586df14a4a68074b7038a9661b1558e2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -618,8 +618,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
-    ret = vfio_cpr_register_container(bcontainer, errp);
-    if (ret) {
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto free_container_exit;
     }
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 392c2dd95d14664bade0ae74655e91bc839504c0..87e51fcee176fe1fa93349f08e9f9ca84b474729 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -25,12 +25,12 @@ static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
+bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
 {
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
                                 MIG_MODE_CPR_REBOOT);
-    return 0;
+    return true;
 }
 
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 84c86b970e756d34b202d5b18ae51c30c730e092..6a446b16dcd64838dc9ebb6150cd5ed85ec6fef3 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -396,8 +396,7 @@ found_container:
         goto err_listener_register;
     }
 
-    ret = vfio_cpr_register_container(bcontainer, errp);
-    if (ret) {
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto err_listener_register;
     }
 
-- 
2.45.1


