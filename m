Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7163DC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrSH-0002uC-BY; Wed, 06 Mar 2024 08:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRo-0001uh-5d
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:45 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRl-0006Yl-Ht
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYPH1qsTz4x0q;
 Thu,  7 Mar 2024 00:36:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYPD0Sdqz4wbh;
 Thu,  7 Mar 2024 00:36:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 25/25] vfio: Extend vfio_set_migration_error() with Error*
 argument
Date: Wed,  6 Mar 2024 14:34:40 +0100
Message-ID: <20240306133441.2351700-26-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
stream, if a migration is progress.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Dropped log_global_stop() and log_global_sync() changes
   
 hw/vfio/common.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 65a11dc088524647541db97b7b8d6f07e5044728..e26574617e5ef75c27a84dc9bb13c8f040353b6c 100644
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
 
@@ -304,9 +306,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
 
@@ -339,11 +342,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
@@ -1125,8 +1129,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     if (ret) {
         error_prepend(&local_err,
                       "vfio: Could not stop dirty page tracking - ");
-        error_report_err(local_err);
-        vfio_set_migration_error(ret);
+        vfio_set_migration_error(ret, local_err);
     }
 }
 
@@ -1243,14 +1246,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
         goto out_lock;
     }
 
@@ -1261,7 +1264,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
                       "0x%"HWADDR_PRIx") failed :", bcontainer, iova,
                       iotlb->addr_mask + 1);
-        error_report_err(local_err);
     }
 
 out_lock:
@@ -1269,7 +1271,7 @@ out_lock:
 
 out:
     if (ret) {
-        vfio_set_migration_error(ret);
+        vfio_set_migration_error(ret, local_err);
     }
 }
 
@@ -1389,8 +1391,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     if (vfio_devices_all_dirty_tracking(bcontainer)) {
         ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
-            error_report_err(local_err);
-            vfio_set_migration_error(ret);
+            vfio_set_migration_error(ret, local_err);
         }
     }
 }
-- 
2.44.0


