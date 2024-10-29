Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3285D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ngP-0006E8-HI; Tue, 29 Oct 2024 10:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t5ngM-0006Bw-6r
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:58:54 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t5ngJ-0004ey-Fs
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 10:58:53 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t5nfv-000000014CZ-38fu; Tue, 29 Oct 2024 15:58:27 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/4] vfio/migration: Add save_{iterate,
 complete_precopy}_started trace events
Date: Tue, 29 Oct 2024 15:58:13 +0100
Message-ID: <68f51cf0eb3daf448ae80219dded4b10984e32db.1730203967.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730203967.git.maciej.szmigiero@oracle.com>
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
index 992dc3b10257..1b1ddf527d69 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
         return -ENOMEM;
     }
 
+    migration->save_iterate_started = false;
+    migration->save_iterate_empty_hit = false;
+
     if (vfio_precopy_supported(vbasedev)) {
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
@@ -602,9 +605,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;
 
+    if (!migration->save_iterate_started) {
+        trace_vfio_save_iterate_started(vbasedev->name);
+        migration->save_iterate_started = true;
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
@@ -630,6 +641,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     int ret;
     Error *local_err = NULL;
 
+    trace_vfio_save_complete_precopy_started(vbasedev->name);
+
     /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
                                    VFIO_DEVICE_STATE_STOP, &local_err);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 29789e8d276d..e58deab232ed 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -159,8 +159,11 @@ vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
+vfio_save_complete_precopy_started(const char *name) " (%s)"
 vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
+vfio_save_iterate_empty_hit(const char *name) " (%s)"
+vfio_save_iterate_started(const char *name) " (%s)"
 vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
 vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fed499b199f0..997ee5af2d5b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -73,6 +73,9 @@ typedef struct VFIOMigration {
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
     bool initial_data_sent;
+
+    bool save_iterate_started;
+    bool save_iterate_empty_hit;
 } VFIOMigration;
 
 struct VFIOGroup;

