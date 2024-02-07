Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECD1C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4M-0006n1-0j; Wed, 07 Feb 2024 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4J-0006mp-1Z
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:27 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4H-0008TV-0c
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgf6m2cz4x1d;
 Thu,  8 Feb 2024 00:34:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgd18t2z4x1H;
 Thu,  8 Feb 2024 00:34:20 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 11/14] vfio: Extend vfio_set_migration_error() with Error*
 argument
Date: Wed,  7 Feb 2024 14:33:44 +0100
Message-ID: <20240207133347.1115903-12-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

vfio_set_migration_error() sets the 'return' error on the migration
stream if a migration is in progress. To improve error reporting, add
a new Error* argument to also set the Error object on the migration
stream.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 50 +++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 82173b039c47150f5edd05d329192c5b9c8a9a0f..afe8b6bd294fd5904f394a5db48aae3fd718b14e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -148,16 +148,18 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
     return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
-static void vfio_set_migration_error(int err)
+static void vfio_set_migration_error(int ret, Error *err)
 {
     MigrationState *ms = migrate_get_current();
 
     if (migration_is_setup_or_active(ms->state)) {
         WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
             if (ms->to_dst_file) {
-                qemu_file_set_error(ms->to_dst_file, err);
+                qemu_file_set_error_obj(ms->to_dst_file, ret, err);
             }
         }
+    } else {
+        error_report_err(err);
     }
 }
 
@@ -296,15 +298,17 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     void *vaddr;
+    Error *local_err = NULL;
     int ret;
 
     trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
                                 iova, iova + iotlb->addr_mask);
 
     if (iotlb->target_as != &address_space_memory) {
-        error_report("Wrong target AS \"%s\", only system memory is allowed",
-                     iotlb->target_as->name ? iotlb->target_as->name : "none");
-        vfio_set_migration_error(-EINVAL);
+        error_setg(&local_err,
+                   "Wrong target AS \"%s\", only system memory is allowed",
+                   iotlb->target_as->name ? iotlb->target_as->name : "none");
+        vfio_set_migration_error(-EINVAL, local_err);
         return;
     }
 
@@ -336,11 +340,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
+            vfio_set_migration_error(ret, local_err);
         }
     }
 out:
@@ -1224,13 +1229,15 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     ram_addr_t translated_addr;
+    Error *local_err = NULL;
     int ret = -EINVAL;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
     if (iotlb->target_as != &address_space_memory) {
-        error_report("Wrong target AS \"%s\", only system memory is allowed",
-                     iotlb->target_as->name ? iotlb->target_as->name : "none");
+        error_setg(&local_err,
+                   "Wrong target AS \"%s\", only system memory is allowed",
+                   iotlb->target_as->name ? iotlb->target_as->name : "none");
         goto out;
     }
 
@@ -1239,17 +1246,18 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                     translated_addr);
         if (ret) {
-            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
-                         "0x%"HWADDR_PRIx") = %d (%s)",
-                         bcontainer, iova, iotlb->addr_mask + 1, ret,
-                         strerror(-ret));
+            error_setg(&local_err,
+                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
+                       "0x%"HWADDR_PRIx") = %d (%s)",
+                       bcontainer, iova, iotlb->addr_mask + 1, ret,
+                       strerror(-ret));
         }
     }
     rcu_read_unlock();
 
 out:
     if (ret) {
-        vfio_set_migration_error(ret);
+        vfio_set_migration_error(ret, local_err);
     }
 }
 
@@ -1345,6 +1353,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    Error *local_err = NULL;
     int ret;
 
     if (vfio_listener_skipped_section(section)) {
@@ -1354,9 +1363,10 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     if (vfio_devices_all_dirty_tracking(bcontainer)) {
         ret = vfio_sync_dirty_bitmap(bcontainer, section);
         if (ret) {
-            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
-                         strerror(-ret));
-            vfio_set_migration_error(ret);
+            error_setg(&local_err,
+                       "vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
+                       strerror(-ret));
+            vfio_set_migration_error(ret, local_err);
         }
     }
 }
-- 
2.43.0


