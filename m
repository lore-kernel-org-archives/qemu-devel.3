Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F58C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzJq-0001sA-8R; Tue, 07 Jul 2026 02:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJn-0001hl-Vr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgzJl-0007Ag-9d
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783405804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VPifjRv5xHUPc53gqToCUkVHVOxByVu5PyMZz6oKZA=;
 b=idjOqNnKd0Tb0/TYGXytKXN16DIfAKTZZ9ShuP9s0V81RaM2zxzj89HrIJVFR5YWZe2nXX
 ozC8dXHTJeDM+heHU4ru3+CJ5JY1I+zKNHn+u+jibBDUjLNNi3+JOtH4OM7vXz/PAkpk8t
 tKawfl90wsja+/FPGmFK/WRZPo0mWKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-7oroddmMNgGJF_ZPijIwsA-1; Tue,
 07 Jul 2026 02:30:01 -0400
X-MC-Unique: 7oroddmMNgGJF_ZPijIwsA-1
X-Mimecast-MFC-AGG-ID: 7oroddmMNgGJF_ZPijIwsA_1783405800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71C6A1954B17; Tue,  7 Jul 2026 06:30:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBD2B1800678; Tue,  7 Jul 2026 06:29:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/27] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Date: Tue,  7 Jul 2026 08:29:10 +0200
Message-ID: <20260707062920.317302-18-clg@redhat.com>
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

According to VFIO uAPI, precopy initial_bytes is considered as critical
data that should be transferred and loaded prior to moving to STOP_COPY
state to ensure precopy phase would be effective.

As currently defined, initial_bytes can only decrease as it's being read
from the data fd. However, there are cases where a new chunk of
initial_bytes should be transferred during precopy.

The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
reporting a new value for initial_bytes regardless of any previously
reported values.

Implement VFIO_PRECOPY_INFO_REINIT feature:
1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
   VFIO_PRECOPY_INFO_REINIT available.
2. Request a new switchover ACK if initial_bytes increases post of a
   previous switchover ACK. This ensures the device is not moved to
   STOP_COPY before initial_bytes has reached zero again.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20260706085211.13905-13-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst     | 14 +++++++
 hw/vfio/vfio-migration-internal.h |  1 +
 hw/vfio/migration.c               | 68 ++++++++++++++++++++++++++++---
 hw/vfio/trace-events              |  4 +-
 4 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 854277b11ce64672f998ce1728bf8b5ddf1c129a..f235c2d4f9d1bae5aa8bdcc2701340780d558f89 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -23,6 +23,20 @@ and recommends that the initial bytes are sent and loaded in the destination
 before stopping the source VM. Enabling this migration capability will
 guarantee that and thus, can potentially reduce downtime even further.
 
+For example, in mlx5 devices, the initial bytes hold metadata used for time
+consuming pre-allocations of resources on the destination. Although init bytes
+may be small in size and sending them may take little time, loading them in the
+destination can take a significant amount of time. Switchover-ack guarantees
+that this pre-allocation doesn't happen during downtime.
+
+Initial bytes was originally defined to be monotonically decreasing, however
+there are cases where a new chunk of initial bytes should be transferred during
+precopy, e.g., due to a device reconfiguration, etc. The
+VFIO_PRECOPY_INFO_REINIT feature addresses this and when supported, allows to
+report a new initial bytes value regardless of any previously reported values.
+In this case, a new switchover ACK will be requested to make sure the new
+initial bytes are loaded in the destination before switching over.
+
 To support migration of multiple devices that might do P2P transactions between
 themselves, VFIO migration uAPI defines an intermediate P2P quiescent state.
 While in the P2P quiescent state, P2P DMA transactions cannot be initiated by
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index dc741e51421eec6d4ad4d9ce0f9c0c2f6199788d..a1c58b112685d868c6f942d6225b553d44bb6613 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -45,6 +45,7 @@ typedef struct VFIOMigration {
     void *data_buffer;
     size_t data_buffer_size;
     uint64_t mig_flags;
+    bool precopy_info_v2_used;
     /*
      * NOTE: all three sizes cached are reported from VFIO's uAPI, which
      * are defined as estimate only.  QEMU should not trust these values
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index ebe2eafded50cdc3c1518a2f1e768fdfe6722c5a..1e172dd10bfc3561741aa90bf1e237cd6847eb63 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -373,9 +373,11 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
 
 static int vfio_query_precopy_size(VFIOMigration *migration)
 {
+    VFIODevice *vbasedev = migration->vbasedev;
     struct vfio_precopy_info precopy = {
         .argsz = sizeof(precopy),
     };
+    bool reinit = false;
     int ret = 0;
 
     if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
@@ -383,25 +385,43 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
         migration->precopy_dirty_size = 0;
         ret = -errno;
         warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
-                         "failed (%d)", migration->vbasedev->name, ret);
+                         "failed (%d)", vbasedev->name, ret);
     } else {
         bool overflow;
 
         migration->precopy_init_size = precopy.initial_bytes;
         migration->precopy_dirty_size = precopy.dirty_bytes;
+        /*
+         * struct vfio_precopy_info.flags is valid only if
+         * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 is used.
+         */
+         if (migration->precopy_info_v2_used) {
+            reinit = precopy.flags & VFIO_PRECOPY_INFO_REINIT;
+        }
 
-        overflow  = vfio_migration_check_overflow(migration->vbasedev,
+        overflow  = vfio_migration_check_overflow(vbasedev,
                          migration->precopy_init_size,  "precopy init size");
-        overflow |= vfio_migration_check_overflow(migration->vbasedev,
+        overflow |= vfio_migration_check_overflow(vbasedev,
                          migration->precopy_dirty_size, "precopy dirty size");
         if (overflow) {
             ret = -ERANGE;
         }
     }
 
-    trace_vfio_query_precopy_size(migration->vbasedev->name,
-                                  migration->precopy_init_size,
-                                  migration->precopy_dirty_size, ret);
+    trace_vfio_query_precopy_size(vbasedev->name, migration->precopy_init_size,
+                                  migration->precopy_dirty_size, reinit, ret);
+
+    /*
+     * If we got new initial_bytes after previous initial_bytes were
+     * transferred, request a new switchover ACK. Don't request if legacy
+     * switchover-ack is used.
+     */
+    if (reinit && migration->initial_data_sent &&
+        !migrate_switchover_ack_legacy()) {
+        migration->initial_data_sent = false;
+        migration->request_switchover_ack = true;
+        trace_vfio_query_precopy_size_request_switchover_ack(vbasedev->name);
+    }
 
     return ret;
 }
@@ -1054,6 +1074,27 @@ static int vfio_migration_query_flags(VFIODevice *vbasedev, uint64_t *mig_flags)
     return 0;
 }
 
+/* Returns 1 on success, 0 if not supported and negative errno on failure */
+static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
+{
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
+                              sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+
+    feature->argsz = sizeof(buf);
+    feature->flags =
+        VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        if (errno == ENOTTY) {
+            return 0;
+        }
+
+        return -errno;
+    }
+
+    return 1;
+}
+
 static bool vfio_dma_logging_supported(VFIODevice *vbasedev)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
@@ -1075,6 +1116,7 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
+    bool precopy_info_v2_used = false;
     VMChangeStateHandler *prepare_cb;
 
     if (!vbasedev->ops->vfio_get_object) {
@@ -1106,12 +1148,22 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
         return false;
     }
 
+    if (mig_flags & VFIO_MIGRATION_PRE_COPY) {
+        ret = vfio_migration_set_precopy_info_v2(vbasedev);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set precopy info v2");
+            return false;
+        }
+        precopy_info_v2_used = ret;
+    }
+
     vbasedev->migration = g_new0(VFIOMigration, 1);
     migration = vbasedev->migration;
     migration->vbasedev = vbasedev;
     migration->device_state = VFIO_DEVICE_STATE_RUNNING;
     migration->data_fd = -1;
     migration->mig_flags = mig_flags;
+    migration->precopy_info_v2_used = precopy_info_v2_used;
 
     vbasedev->dirty_pages_supported = vfio_dma_logging_supported(vbasedev);
 
@@ -1134,6 +1186,10 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
+    trace_vfio_migration_init(vbasedev->name, migration->mig_flags,
+                              migration->precopy_info_v2_used,
+                              vbasedev->dirty_pages_supported);
+
     return true;
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index c9d143826d38d77048ecf179cbda19a7184989a4..f71d0bbc0a5440e4ccd374fac4733af08438e7be 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -159,11 +159,13 @@ vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx
 vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_load_state_device_buffer_end(const char *name) " (%s)"
+vfio_migration_init(const char *name, uint64_t mig_flags, bool precopy_info_v2_used, bool dirty_pages_supported) " (%s) mig_flags 0x%"PRIx64", precopy_info_v2_used %d, dirty_pages_supported %d"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
-vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
+vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, bool reinit, int ret) " (%s) init %"PRIu64", dirty %"PRIu64", reinit %d, ret %d"
+vfio_query_precopy_size_request_switchover_ack(const char *name) " (%s)"
 vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
-- 
2.54.0


