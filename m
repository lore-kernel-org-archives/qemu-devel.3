Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB2EC3600D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLat-00046Y-DT; Wed, 26 Mar 2025 03:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLa8-0002BL-2P
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLa6-0006OP-8j
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lld9Q74bpn3EN/UpGvKG5u/N5iLFSTuKTDjNkrkKkR4=;
 b=ZzttBFvEgOSdkJRAT7q+/Xg2x5HLaPPl/qMOFW0WSxVF7YBTIAiDwelLVOuVcN46SpRy70
 H2nmIaWVj0ulQY+9UVerAdCIskQB9jHGyNbUTJ4nHVwRkuNCFIIqRfmfD1L30ptS41OzDW
 V04zbv4VVUC6TmUa7sbmImxtIcYtlBo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540--o5PBWxcOvivVoqNOa2tWg-1; Wed,
 26 Mar 2025 03:53:40 -0400
X-MC-Unique: -o5PBWxcOvivVoqNOa2tWg-1
X-Mimecast-MFC-AGG-ID: -o5PBWxcOvivVoqNOa2tWg_1742975618
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCBF019560BC; Wed, 26 Mar 2025 07:53:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D81C19560AB; Wed, 26 Mar 2025 07:53:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 34/37] vfio: Introduce vfio_listener_un/register()
 routines
Date: Wed, 26 Mar 2025 08:51:19 +0100
Message-ID: <20250326075122.1299361-35-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index acebb53dcb1b829d31cc31d9f7f2cc9599f952eb..f086e5c802f058c01ca740de338538106874fb03 100644
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
index 07c8dc6ce343510dea20c5946e64a23a57c0f91b..324dc47183be82933197017f473f67cce6d7ec56 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -46,6 +46,7 @@
 #include "system/tpm.h"
 #include "vfio-migration-internal.h"
 #include "vfio-helpers.h"
+#include "vfio-listener.h"
 
 /*
  * Device state interfaces
@@ -1163,7 +1164,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     }
 }
 
-const MemoryListener vfio_memory_listener = {
+static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
@@ -1171,3 +1172,22 @@ const MemoryListener vfio_memory_listener = {
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


