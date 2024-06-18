Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA0BC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbSQ-0002q0-2K; Tue, 18 Jun 2024 12:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSO-0002ml-N3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:16 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSN-0000ou-6L
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:16 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbS1-0001aT-BC; Tue, 18 Jun 2024 18:12:53 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v1 01/13] vfio/migration: Add save_{iterate,
 complete_precopy}_started trace events
Date: Tue, 18 Jun 2024 18:12:19 +0200
Message-ID: <8a5b0ed0530bfbecdc1a1a908da7dd7b2eb2687a.1718717584.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718717584.git.maciej.szmigiero@oracle.com>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This way both the start and end points of migrating a particular VFIO
device are known.

Add also a vfio_save_iterate_empty_hit trace event so it is known when
there's no more data to send for that device.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 13 +++++++++++++
 hw/vfio/trace-events          |  3 +++
 include/hw/vfio/vfio-common.h |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 34d4be2ce1b1..93f767e3c2dd 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
         return -ENOMEM;
     }
 
+    migration->save_iterate_run = false;
+    migration->save_iterate_empty_hit = false;
+
     if (vfio_precopy_supported(vbasedev)) {
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
@@ -605,9 +608,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;
 
+    if (!migration->save_iterate_run) {
+        trace_vfio_save_iterate_started(vbasedev->name);
+        migration->save_iterate_run = true;
+    }
+
     data_size = vfio_save_block(f, migration);
     if (data_size < 0) {
         return data_size;
+    } else if (data_size == 0 && !migration->save_iterate_empty_hit) {
+        trace_vfio_save_iterate_empty_hit(vbasedev->name);
+        migration->save_iterate_empty_hit = true;
     }
 
     vfio_update_estimated_pending_data(migration, data_size);
@@ -633,6 +644,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     int ret;
     Error *local_err = NULL;
 
+    trace_vfio_save_complete_precopy_started(vbasedev->name);
+
     /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
                                    VFIO_DEVICE_STATE_STOP, &local_err);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 64161bf6f44c..814000796687 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -158,8 +158,11 @@ vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
+vfio_save_complete_precopy_started(const char *name) " (%s)"
 vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
+vfio_save_iterate_started(const char *name) " (%s)"
+vfio_save_iterate_empty_hit(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
 vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4cb1ab8645dc..510818f4dae3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -71,6 +71,9 @@ typedef struct VFIOMigration {
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
     bool initial_data_sent;
+
+    bool save_iterate_run;
+    bool save_iterate_empty_hit;
 } VFIOMigration;
 
 struct VFIOGroup;

