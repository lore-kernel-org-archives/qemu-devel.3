Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF31BD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84df-0002bg-Rr; Mon, 04 Nov 2024 16:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t84dd-0002bP-UN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:29:29 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t84dc-0007Oc-En
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:29:29 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1t84dY-00000001NDp-1eR4; Mon, 04 Nov 2024 22:29:24 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] vfio/migration: Add vfio_save_block_precopy_empty_hit
 trace event
Date: Mon,  4 Nov 2024 22:29:07 +0100
Message-ID: <44a769267d406e10fd122786f0153b5fa2697500.1730750959.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730750959.git.maciej.szmigiero@oracle.com>
References: <cover.1730750959.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

This way it is clearly known when there's no more data to send for that
device.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 8 ++++++++
 hw/vfio/trace-events          | 1 +
 include/hw/vfio/vfio-common.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 87ddc210578f..01aa11013e42 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -370,6 +370,10 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
          * please refer to the Linux kernel VFIO uAPI.
          */
         if (errno == ENOMSG) {
+            if (!migration->event_precopy_empty_hit) {
+                trace_vfio_save_block_precopy_empty_hit(migration->vbasedev->name);
+                migration->event_precopy_empty_hit = true;
+            }
             return 0;
         }
 
@@ -379,6 +383,9 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
         return 0;
     }
 
+    /* Non-empty read: re-arm the trace event */
+    migration->event_precopy_empty_hit = false;
+
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
     qemu_put_be64(f, data_size);
     qemu_put_buffer(f, migration->data_buffer, data_size);
@@ -473,6 +480,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     migration->event_save_iterate_started = false;
+    migration->event_precopy_empty_hit = false;
 
     if (vfio_precopy_supported(vbasedev)) {
         switch (migration->device_state) {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 032a51a10592..cab1cf1de0a2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -157,6 +157,7 @@ vfio_migration_set_device_state(const char *name, const char *state) " (%s) stat
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
+vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_complete_precopy_start(const char *name) " (%s)"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 282eadf4ebf5..e0ce6ec3a9b3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -75,6 +75,7 @@ typedef struct VFIOMigration {
     bool initial_data_sent;
 
     bool event_save_iterate_started;
+    bool event_precopy_empty_hit;
 } VFIOMigration;
 
 struct VFIOGroup;

