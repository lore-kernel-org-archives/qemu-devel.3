Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDD5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EiQ-0002lO-N1; Fri, 25 Apr 2025 04:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiB-0002hS-RW
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ei9-0003BR-4P
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znzbnhlbGLkfVH7d+2fBAjEPlohi/FMDzJbg3Om2RCE=;
 b=DdWwGdLwHmSbpy7OFGLI5LCHrzVq7mZ3G5dPUrSi3nadOZ5gU/59Gsr7O2t3bfgw198nLV
 ZFs2dl4B93jJ1EVnTZrbBJkTgOa0RNhfPe7RZPgFUePIkuWfhoG0CluYvf6Ra02FSFYlaT
 kHKX44XUno5hSBXR+p8Xi5OPAuw9Uuw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-WGqepQzdNWmKIsDLy2wRuw-1; Fri,
 25 Apr 2025 04:47:00 -0400
X-MC-Unique: WGqepQzdNWmKIsDLy2wRuw-1
X-Mimecast-MFC-AGG-ID: WGqepQzdNWmKIsDLy2wRuw_1745570819
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 430FA1800EC9; Fri, 25 Apr 2025 08:46:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 392E130001A2; Fri, 25 Apr 2025 08:46:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 02/50] vfio: Open code vfio_migration_set_error()
Date: Fri, 25 Apr 2025 10:45:55 +0200
Message-ID: <20250425084644.102196-3-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250324123315.637827-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9b493451c5e9b2b1388b42607984b0b2b1b1bede..5ef14931cd2dea6407999e6ef825c7376f212678 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -145,13 +145,6 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
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
@@ -287,9 +280,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
 
@@ -322,11 +320,16 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
@@ -1108,8 +1111,11 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
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
 
@@ -1225,14 +1231,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
 
@@ -1243,7 +1249,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
                       "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
                       iotlb->addr_mask + 1);
-        error_report_err(local_err);
     }
 
 out_unlock:
@@ -1251,7 +1256,11 @@ out_unlock:
 
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
 
@@ -1384,8 +1393,11 @@ static void vfio_listener_log_sync(MemoryListener *listener,
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


