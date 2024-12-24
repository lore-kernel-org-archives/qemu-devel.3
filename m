Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587E7E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6e7-0007jb-MC; Tue, 24 Dec 2024 10:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e3-0007NH-2D
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6e0-00045b-Bl
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bs/aFUrZ8wbjvHaRoKXd0EGyk9aLkCzj1babD8hMHsI=;
 b=A24Fv/YjGg7kHg0ImqTqpDJ3EO3ltBjXhkweE9rho4BYR5iGLPNvHzSbV0SEhmdt++Ke5N
 cbd4iAvCzEdDd+tXOtWWXlWrvWO2tVz38yXErh6hzJARa/On5ZuLcR9X+ZMwev3qnR0MMF
 gyRXAYEvUr1kGfDA5GUIDz3bdJ1cuAc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-FhuQZByDN1CdCYZ_QAInWQ-1; Tue,
 24 Dec 2024 10:16:20 -0500
X-MC-Unique: FhuQZByDN1CdCYZ_QAInWQ-1
X-Mimecast-MFC-AGG-ID: FhuQZByDN1CdCYZ_QAInWQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65D1D1956086; Tue, 24 Dec 2024 15:16:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABA16300F9B5; Tue, 24 Dec 2024 15:16:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/17] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
Date: Tue, 24 Dec 2024 16:15:43 +0100
Message-ID: <20241224151547.386529-14-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
is used to check whether a dirty page log sync of the unmapped pages is
required. Such log sync is needed during migration pre-copy phase, and
the current logic detects it by checking if migration is active and if
the VFIO devices are running.

However, recently there has been an effort to simplify the migration
status API and reduce it to a single migration_is_running() function.

To accommodate this, refactor vfio_devices_all_running_and_mig_active()
logic so it won't use migration_is_active(). Do it by simply checking if
dirty tracking has been started using internal VFIO flags.

This should be equivalent to the previous logic as during migration
dirty tracking is active and when the guest is stopped there shouldn't
be DMA unmaps coming from it.

As a side effect, now that migration status is no longer used, DMA unmap
log syncs are untied from migration. This will make calc-dirty-rate more
accurate as now it will also include VFIO dirty pages that were DMA
unmapped.

Also rename the function to properly reflect its new logic and extract
common code from vfio_devices_all_dirty_tracking().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20241218134022.21264-4-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  4 ++--
 hw/vfio/common.c              | 40 +++++++----------------------------
 hw/vfio/container.c           |  2 +-
 3 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a9a68e3fd9a2a570856193cb290cc252b46093de..0c60be5b15c70168f4f94ad7054d9bd750a162d3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -296,8 +296,8 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
-bool
-vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer);
 bool
 vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fd24b7ced83d241445c0b3dbd014b125b41a0927..9b5524377ce01a0a982157b314ad60add371bac6 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -184,12 +184,18 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+           bcontainer->dirty_pages_started;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
-          bcontainer->dirty_pages_started)) {
+    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
         return false;
     }
 
@@ -225,36 +231,6 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-/*
- * Check if all VFIO devices are running and migration is active, which is
- * essentially equivalent to the migration being in pre-copy phase.
- */
-bool
-vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
-{
-    VFIODevice *vbasedev;
-
-    if (!migration_is_active()) {
-        return false;
-    }
-
-    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        VFIOMigration *migration = vbasedev->migration;
-
-        if (!migration) {
-            return false;
-        }
-
-        if (vfio_device_state_is_running(vbasedev) ||
-            vfio_device_state_is_precopy(vbasedev)) {
-            continue;
-        } else {
-            return false;
-        }
-    }
-    return true;
-}
-
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 {
     return (!memory_region_is_ram(section->mr) &&
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 78a3c2d55fcd0f53c9b679167ad8d1b557f72358..4ebb5268088d0a2006e0ed04afec0ee746ed2c1d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
+    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
-- 
2.47.1


