Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADE8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgQ-0006Kg-Ki; Tue, 18 Mar 2025 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTg8-0005GR-T8
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTg6-0002Rk-O9
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QqoA6+JyVgr1ZqvcS+QyNNuqcubQ/ozwRd0+cXS21k=;
 b=QFKVwAdr3QolO+ANKelGoa2KJ++0nbhXUp55e2sV9Mf97qfSWZ/sDxlZaOhvrvienB/zru
 DsregsMjTNYeAjHujZJt26ozhnDsI5xn7exkkpiLI1ppZe0BUcVcsHbp042HFRAOqQuk4n
 b2v82X/pFvQCDsFqztuUhhG1gahrMRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-HegeJVmvNOqyLf-AC2pdhQ-1; Tue,
 18 Mar 2025 05:56:01 -0400
X-MC-Unique: HegeJVmvNOqyLf-AC2pdhQ-1
X-Mimecast-MFC-AGG-ID: HegeJVmvNOqyLf-AC2pdhQ_1742291760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C08691828B71; Tue, 18 Mar 2025 09:55:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 467911828A80; Tue, 18 Mar 2025 09:55:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 25/32] vfio: Move vfio_set_migration_error() into
 migration.c
Date: Tue, 18 Mar 2025 10:54:08 +0100
Message-ID: <20250318095415.670319-26-clg@redhat.com>
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

This routine is related to VFIO migration. It belongs to "migration.c".
While at it, rename it to better reflect the namespace it belongs to.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.h      |  1 +
 hw/vfio/dirty-tracking.c | 19 +++++--------------
 hw/vfio/migration.c      |  7 +++++++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/migration.h b/hw/vfio/migration.h
index 7ad2141d06a7c97f034db908f9ce19fd06f415b9..9b57d7dc1a6c6143c19e1ee85807d036b1363624 100644
--- a/hw/vfio/migration.h
+++ b/hw/vfio/migration.h
@@ -68,5 +68,6 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
                              enum vfio_device_mig_state recover_state,
                              Error **errp);
 #endif
+void vfio_migration_set_error(int ret);
 
 #endif /* HW_VFIO_MIGRATION_H */
diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
index 441f9d9a08c06a88dda44ef143dcee5f0a89a900..447e09ed84993e3fbe1ed9b27a8269a9f0f46339 100644
--- a/hw/vfio/dirty-tracking.c
+++ b/hw/vfio/dirty-tracking.c
@@ -35,8 +35,6 @@
 #include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "migration/misc.h"
-#include "migration/qemu-file.h"
 #include "system/tcg.h"
 #include "system/tpm.h"
 #include "migration.h"
@@ -47,13 +45,6 @@
  * Device state interfaces
  */
 
-static void vfio_set_migration_error(int ret)
-{
-    if (migration_is_running()) {
-        migration_file_set_error(ret, NULL);
-    }
-}
-
 static bool vfio_devices_all_device_dirty_tracking_started(
     const VFIOContainerBase *bcontainer)
 {
@@ -175,7 +166,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
                      iotlb->target_as->name ? iotlb->target_as->name : "none");
-        vfio_set_migration_error(-EINVAL);
+        vfio_migration_set_error(-EINVAL);
         return;
     }
 
@@ -212,7 +203,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
                          "0x%"HWADDR_PRIx") = %d (%s)",
                          bcontainer, iova,
                          iotlb->addr_mask + 1, ret, strerror(-ret));
-            vfio_set_migration_error(ret);
+            vfio_migration_set_error(ret);
         }
     }
 out:
@@ -995,7 +986,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
         error_prepend(&local_err,
                       "vfio: Could not stop dirty page tracking - ");
         error_report_err(local_err);
-        vfio_set_migration_error(ret);
+        vfio_migration_set_error(ret);
     }
 }
 
@@ -1137,7 +1128,7 @@ out_unlock:
 
 out:
     if (ret) {
-        vfio_set_migration_error(ret);
+        vfio_migration_set_error(ret);
     }
 }
 
@@ -1271,7 +1262,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
         ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
             error_report_err(local_err);
-            vfio_set_migration_error(ret);
+            vfio_migration_set_error(ret);
         }
     }
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 46c4cfecce25ba1146a1d8f2de0d7c51425afe8e..6fd825e435bde96d1008ec03dfaba25db3b616fc 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1239,3 +1239,10 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
     return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ||
            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
 }
+
+void vfio_migration_set_error(int ret)
+{
+    if (migration_is_running()) {
+        migration_file_set_error(ret, NULL);
+    }
+}
-- 
2.48.1


