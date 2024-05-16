Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2849CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7aWK-00035K-Lb; Thu, 16 May 2024 08:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aW1-0002tx-Q6
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aVz-0001An-Bl
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715863633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0q59f6Gye49P2SBCRv+Qdw0sKe13CLuK1wW5L3QBhc=;
 b=faWGNoPy9pi0njTRPImdEYQvtn2xP4vEgjv6qcJxKxQBdoJ2dzsoDa1Uu8BybYcNosrJyg
 TbLQjX6LnvFrS+MNA2HlmWxKYHt5/BnX0WShGrwI3logX8Y4bhAWDK/qD5bJJE0tJmepGo
 NQQoe4rQDFQYxhvfe1URAwb3MBDndPM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-2kGhkap1O_GbeyHz7-_nag-1; Thu,
 16 May 2024 08:47:10 -0400
X-MC-Unique: 2kGhkap1O_GbeyHz7-_nag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B3153C025BE;
 Thu, 16 May 2024 12:47:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 652DD21EE56C;
 Thu, 16 May 2024 12:47:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 1/9] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
Date: Thu, 16 May 2024 14:46:50 +0200
Message-ID: <20240516124658.850504-2-clg@redhat.com>
In-Reply-To: <20240516124658.850504-1-clg@redhat.com>
References: <20240516124658.850504-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

We will use the Error object to improve error reporting in the
.log_global*() handlers of VFIO. Add documentation while at it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
 hw/vfio/common.c                      |  4 ++--
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  6 +++---
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
 void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
-                                           bool start);
+                                           bool start, Error **errp);
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
                                       hwaddr iova, hwaddr size);
@@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
     int (*attach_device)(const char *name, VFIODevice *vbasedev,
                          AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
+
     /* migration feature */
+
+    /**
+     * @set_dirty_page_tracking
+     *
+     * Start or stop dirty pages tracking on VFIO container
+     *
+     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
+     *              page tracking
+     * @start: indicates whether to start or stop dirty pages tracking
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
-                                   bool start);
+                                   bool start, Error **errp);
     int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
                               VFIOBitmap *vbmap,
                               hwaddr iova, hwaddr size);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         ret = vfio_devices_dma_logging_start(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
     }
 
     if (ret) {
@@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
     }
 
     if (ret) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
 }
 
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
-                                           bool start)
+                                           bool start, Error **errp)
 {
     if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
     g_assert(bcontainer->ops->set_dirty_page_tracking);
-    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
+    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
 }
 
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
-                                    bool start)
+                                    bool start, Error **errp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
     ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
     if (ret) {
         ret = -errno;
-        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
-                     dirty.flags, errno);
+        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
+                         dirty.flags);
     }
 
     return ret;
-- 
2.45.0


