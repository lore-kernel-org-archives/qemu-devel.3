Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A3FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgb-0007Fd-2Y; Tue, 18 Mar 2025 05:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgX-0006xt-DJ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgR-0002Wj-0K
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jn7Wpxp3egWv8e1XApzRVujIa5ZY3w6CO8Lc0pPukPc=;
 b=arwPpyvaIj9HfXXFpYwMPMFZNO5mFoKlD3FRSRQAVZNHRk0fLT7CbY2UobKYD5IBBdHypj
 Rk7mPZCldJPHbHsPD0F7zU/673AwuIWLG12/d3ZWs+Hr6Apt9DlRyVxNLvZRDXXcod8dwk
 pLq5pa0ZnSfaBVYEqO5vZi2zKvTZTlM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-Z0J4ViMBOhC9yNdCrMXH_g-1; Tue,
 18 Mar 2025 05:56:22 -0400
X-MC-Unique: Z0J4ViMBOhC9yNdCrMXH_g-1
X-Mimecast-MFC-AGG-ID: Z0J4ViMBOhC9yNdCrMXH_g_1742291781
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FF56180AF6A; Tue, 18 Mar 2025 09:56:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 809FE18001EF; Tue, 18 Mar 2025 09:56:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 31/32] vfio: Introduce
 vfio_dirty_tracking_un/register() routines
Date: Tue, 18 Mar 2025 10:54:14 +0100
Message-ID: <20250318095415.670319-32-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This hides the MemoryListener implementation and makes the code common
to both IOMMU backends, legacy and IOMMUFD.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/dirty-tracking.h |  4 ++--
 hw/vfio/container.c      | 11 +++--------
 hw/vfio/dirty-tracking.c | 21 ++++++++++++++++++++-
 hw/vfio/iommufd.c        |  9 ++-------
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
index db9494202a780108ce78b642950bfed78ba3f253..6d717f0e918e47e341114c82ffc2cf520fc7b079 100644
--- a/hw/vfio/dirty-tracking.h
+++ b/hw/vfio/dirty-tracking.h
@@ -9,11 +9,11 @@
 #ifndef HW_VFIO_DIRTY_TRACKING_H
 #define HW_VFIO_DIRTY_TRACKING_H
 
-extern const MemoryListener vfio_memory_listener;
-
 bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer);
 bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer);
 int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
+bool vfio_dirty_tracking_register(VFIOContainerBase *bcontainer, Error **errp);
+void vfio_dirty_tracking_unregister(VFIOContainerBase *bcontainer);
 
 #endif /* HW_VFIO_DIRTY_TRACKING_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 7b3ec798a77052b8cb0b47d3dceaca1428cb50bd..1fcca75caba19353ad3063ae97b20c15f61564e9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -616,12 +616,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-    bcontainer->listener = vfio_memory_listener;
-    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-
-    if (bcontainer->error) {
-        error_propagate_prepend(errp, bcontainer->error,
-            "memory listener initialization failed: ");
+    if (!vfio_dirty_tracking_register(bcontainer, errp)) {
         goto listener_release_exit;
     }
 
@@ -631,7 +626,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
     vfio_group_del_kvm_device(group);
-    memory_listener_unregister(&bcontainer->listener);
+    vfio_dirty_tracking_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
@@ -669,7 +664,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
      * group.
      */
     if (QLIST_EMPTY(&container->group_list)) {
-        memory_listener_unregister(&bcontainer->listener);
+        vfio_dirty_tracking_unregister(bcontainer);
         if (vioc->release) {
             vioc->release(bcontainer);
         }
diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
index 8e47ccbb9aea748e57271508ddcd10e394abf16c..d7827f7b64adf3e2b41fafd59aab71e0b28c1567 100644
--- a/hw/vfio/dirty-tracking.c
+++ b/hw/vfio/dirty-tracking.c
@@ -1267,7 +1267,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     }
 }
 
-const MemoryListener vfio_memory_listener = {
+static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
@@ -1275,3 +1275,22 @@ const MemoryListener vfio_memory_listener = {
     .log_global_stop = vfio_listener_log_global_stop,
     .log_sync = vfio_listener_log_sync,
 };
+
+bool vfio_dirty_tracking_register(VFIOContainerBase *bcontainer, Error **errp)
+{
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+
+    if (bcontainer->error) {
+        error_propagate_prepend(errp, bcontainer->error,
+                                "memory listener initialization failed: ");
+        return false;
+    }
+
+    return true;
+}
+
+void vfio_dirty_tracking_unregister(VFIOContainerBase *bcontainer)
+{
+    memory_listener_unregister(&bcontainer->listener);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7f354d86cd14270a70dc990860ad5b69f0310719..7737d552f310c54ae2e035198a1a83da8c3199dd 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -411,7 +411,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
-    memory_listener_unregister(&bcontainer->listener);
+    vfio_dirty_tracking_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
 }
@@ -563,12 +563,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         bcontainer->pgsizes = qemu_real_host_page_size();
     }
 
-    bcontainer->listener = vfio_memory_listener;
-    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-
-    if (bcontainer->error) {
-        error_propagate_prepend(errp, bcontainer->error,
-                                "memory listener initialization failed: ");
+    if (!vfio_dirty_tracking_register(bcontainer, errp)) {
         goto err_listener_register;
     }
 
-- 
2.48.1


