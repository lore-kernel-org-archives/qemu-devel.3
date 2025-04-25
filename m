Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA623C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EkF-0006Ym-28; Fri, 25 Apr 2025 04:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ek2-0006D5-KD
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ek0-0003Kt-AM
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm7vGpZP5EoeI30V0/xpiSTroCenQJrmqRZLViECxjc=;
 b=G3/08KC7uuOFIbhMrqNrbYpDO6Fw5E8QsobM6DkaD4zIklRPAwhBkopTEvj5SyjWVZ1M2J
 ELrFcIJod/xDwuqZws6w0oWFNBSDMLkwHtu8TgNAZg6c6mNryKSkjE+D6elmewI2JjPnPf
 dDyQz9v5WdWHc21XDoW/WBOiHYBo/S0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-03q7kRizMYeWtN6HRuTAfw-1; Fri,
 25 Apr 2025 04:48:55 -0400
X-MC-Unique: 03q7kRizMYeWtN6HRuTAfw-1
X-Mimecast-MFC-AGG-ID: 03q7kRizMYeWtN6HRuTAfw_1745570934
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 839BB180099F; Fri, 25 Apr 2025 08:48:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BEE130001AB; Fri, 25 Apr 2025 08:48:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 38/50] vfio: Introduce vfio_listener_un/register() routines
Date: Fri, 25 Apr 2025 10:46:31 +0200
Message-ID: <20250425084644.102196-39-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-35-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-listener.h |  3 ++-
 hw/vfio/container.c     | 11 +++--------
 hw/vfio/iommufd.c       |  9 ++-------
 hw/vfio/listener.c      | 22 +++++++++++++++++++++-
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/vfio-listener.h b/hw/vfio/vfio-listener.h
index 93af6747b28955f038454a335b361787f8364a3a..eb69ddd374fa20683007cfc4e9a7bf6fe707f27d 100644
--- a/hw/vfio/vfio-listener.h
+++ b/hw/vfio/vfio-listener.h
@@ -9,6 +9,7 @@
 #ifndef HW_VFIO_VFIO_LISTENER_H
 #define HW_VFIO_VFIO_LISTENER_H
 
-extern const MemoryListener vfio_memory_listener;
+bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp);
+void vfio_listener_unregister(VFIOContainerBase *bcontainer);
 
 #endif /* HW_VFIO_VFIO_LISTENER_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ff540e1c598b2b6390bdd9e26655a905c8388669..e4fcb1ad8bee80136fedcdc07cd68d56b5eeae04 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -616,12 +616,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
 
-    bcontainer->listener = vfio_memory_listener;
-    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-
-    if (bcontainer->error) {
-        error_propagate_prepend(errp, bcontainer->error,
-            "memory listener initialization failed: ");
+    if (!vfio_listener_register(bcontainer, errp)) {
         goto listener_release_exit;
     }
 
@@ -631,7 +626,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
     vfio_kvm_device_del_group(group);
-    memory_listener_unregister(&bcontainer->listener);
+    vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
@@ -669,7 +664,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
      * group.
      */
     if (QLIST_EMPTY(&container->group_list)) {
-        memory_listener_unregister(&bcontainer->listener);
+        vfio_listener_unregister(bcontainer);
         if (vioc->release) {
             vioc->release(bcontainer);
         }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7488d21215b6eee78c9c51cfb227d9c8c59c4978..e47720247d6acfd6ea0e5a2e2a2eecabfa62dce3 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -410,7 +410,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
-    memory_listener_unregister(&bcontainer->listener);
+    vfio_listener_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
 }
@@ -562,12 +562,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         bcontainer->pgsizes = qemu_real_host_page_size();
     }
 
-    bcontainer->listener = vfio_memory_listener;
-    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-
-    if (bcontainer->error) {
-        error_propagate_prepend(errp, bcontainer->error,
-                                "memory listener initialization failed: ");
+    if (!vfio_listener_register(bcontainer, errp)) {
         goto err_listener_register;
     }
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 70bdeb3ce743088306f0941d63e51bddb242a697..d19674503c5dfc6b61671db316a186d18ae6f865 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -45,6 +45,7 @@
 #include "system/tpm.h"
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
+#include "vfio-listener.h"
 
 /*
  * Device state interfaces
@@ -1162,7 +1163,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     }
 }
 
-const MemoryListener vfio_memory_listener = {
+static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
@@ -1170,3 +1171,22 @@ const MemoryListener vfio_memory_listener = {
     .log_global_stop = vfio_listener_log_global_stop,
     .log_sync = vfio_listener_log_sync,
 };
+
+bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp)
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
+void vfio_listener_unregister(VFIOContainerBase *bcontainer)
+{
+    memory_listener_unregister(&bcontainer->listener);
+}
-- 
2.49.0


