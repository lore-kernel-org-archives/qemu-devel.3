Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2068C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 12:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twgzq-0004HV-5r; Mon, 24 Mar 2025 08:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twgzk-0004Ge-VT
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 08:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twgzg-0000SP-LV
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 08:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742819604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G2JGI4YQ8kpY47siz/tqiZn/e9QgxXkGITbzhe3gYfo=;
 b=YH5+Ml2tjrDoNlnPKRVr8sZEeYzi1jA6rv+qsJwxI3EP5qNnXs0eAmUQFbqI9tb+RIPbCt
 g/tEdX3eP8JCi/gLgXVIhW/gEUG3w7z5ZnA353r6avoFIs9SWZRmRaWzbZZKgGvHfCCtp4
 y9gAGyKrCOjMeN0D47819UnESRSKeDY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-22gnzSrzO8O488OTirJZ7A-1; Mon,
 24 Mar 2025 08:33:23 -0400
X-MC-Unique: 22gnzSrzO8O488OTirJZ7A-1
X-Mimecast-MFC-AGG-ID: 22gnzSrzO8O488OTirJZ7A_1742819602
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2940196D2CD; Mon, 24 Mar 2025 12:33:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07515180A803; Mon, 24 Mar 2025 12:33:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] vfio: Open code vfio_migration_set_error()
Date: Mon, 24 Mar 2025 13:33:15 +0100
Message-ID: <20250324123315.637827-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

VFIO uses migration_file_set_error() in a couple of places where an
'Error **' parameter is not provided. In MemoryListener handlers :

  vfio_listener_region_add
  vfio_listener_log_global_stop
  vfio_listener_log_sync

and in callback routines for IOMMU notifiers :

  vfio_iommu_map_notify
  vfio_iommu_map_dirty_notify

Hopefully, one day, we will be able to extend these callbacks with an
'Error **' parameter and avoid setting the global migration error.
Until then, it seems sensible to clearly identify the use cases, which
are limited, and open code vfio_migration_set_error(). One other
benefit is an improved error reporting when migration is running.

While at it, slightly modify error reporting to only report errors
when migration is not active and not always as is currently done.

Cc: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1a0d9290f88c9774a98f65087a36b86922b21a73..a591ce5b97ff41cdc8249e9eeafc8dc347d45fac 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -149,13 +149,6 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
     return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
-static void vfio_set_migration_error(int ret)
-{
-    if (migration_is_running()) {
-        migration_file_set_error(ret, NULL);
-    }
-}
-
 bool vfio_device_state_is_running(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -291,9 +284,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                                 iova, iova + iotlb->addr_mask);
 
     if (iotlb->target_as != &address_space_memory) {
-        error_report("Wrong target AS \"%s\", only system memory is allowed",
-                     iotlb->target_as->name ? iotlb->target_as->name : "none");
-        vfio_set_migration_error(-EINVAL);
+        error_setg(&local_err,
+                   "Wrong target AS \"%s\", only system memory is allowed",
+                   iotlb->target_as->name ? iotlb->target_as->name : "none");
+        if (migration_is_running()) {
+            migration_file_set_error(-EINVAL, local_err);
+        } else {
+            error_report_err(local_err);
+        }
         return;
     }
 
@@ -326,11 +324,16 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         ret = vfio_container_dma_unmap(bcontainer, iova,
                                        iotlb->addr_mask + 1, iotlb);
         if (ret) {
-            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                         "0x%"HWADDR_PRIx") = %d (%s)",
-                         bcontainer, iova,
-                         iotlb->addr_mask + 1, ret, strerror(-ret));
-            vfio_set_migration_error(ret);
+            error_setg(&local_err,
+                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                       "0x%"HWADDR_PRIx") = %d (%s)",
+                       bcontainer, iova,
+                       iotlb->addr_mask + 1, ret, strerror(-ret));
+            if (migration_is_running()) {
+                migration_file_set_error(ret, local_err);
+            } else {
+                error_report_err(local_err);
+            }
         }
     }
 out:
@@ -1112,8 +1115,11 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (ret) {
         error_prepend(&local_err,
                       "vfio: Could not stop dirty page tracking - ");
-        error_report_err(local_err);
-        vfio_set_migration_error(ret);
+        if (migration_is_running()) {
+            migration_file_set_error(ret, local_err);
+        } else {
+            error_report_err(local_err);
+        }
     }
 }
 
@@ -1229,14 +1235,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
     if (iotlb->target_as != &address_space_memory) {
-        error_report("Wrong target AS \"%s\", only system memory is allowed",
-                     iotlb->target_as->name ? iotlb->target_as->name : "none");
+        error_setg(&local_err,
+                   "Wrong target AS \"%s\", only system memory is allowed",
+                   iotlb->target_as->name ? iotlb->target_as->name : "none");
         goto out;
     }
 
     rcu_read_lock();
     if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
-        error_report_err(local_err);
         goto out_unlock;
     }
 
@@ -1247,7 +1253,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
                       "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
                       iotlb->addr_mask + 1);
-        error_report_err(local_err);
     }
 
 out_unlock:
@@ -1255,7 +1260,11 @@ out_unlock:
 
 out:
     if (ret) {
-        vfio_set_migration_error(ret);
+        if (migration_is_running()) {
+            migration_file_set_error(ret, local_err);
+        } else {
+            error_report_err(local_err);
+        }
     }
 }
 
@@ -1388,8 +1397,11 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     if (vfio_log_sync_needed(bcontainer)) {
         ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
-            error_report_err(local_err);
-            vfio_set_migration_error(ret);
+            if (migration_is_running()) {
+                migration_file_set_error(ret, local_err);
+            } else {
+                error_report_err(local_err);
+            }
         }
     }
 }
-- 
2.49.0


