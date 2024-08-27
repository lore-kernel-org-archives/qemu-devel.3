Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08627C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0R1-0001Cw-T4; Tue, 27 Aug 2024 13:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QW-0007gx-Aw
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:21 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QM-0001cn-Tf
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:18 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Q8-0002Oq-A6; Tue, 27 Aug 2024 19:55:56 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 12/17] migration/multifd: Device state transfer support -
 send side
Date: Tue, 27 Aug 2024 19:54:31 +0200
Message-ID: <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

A new function multifd_queue_device_state() is provided for device to queue
its state for transmission via a multifd channel.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h         |  4 ++
 migration/meson.build            |  1 +
 migration/multifd-device-state.c | 99 ++++++++++++++++++++++++++++++++
 migration/multifd-nocomp.c       |  6 +-
 migration/multifd-qpl.c          |  2 +-
 migration/multifd-uadk.c         |  2 +-
 migration/multifd-zlib.c         |  2 +-
 migration/multifd-zstd.c         |  2 +-
 migration/multifd.c              | 65 +++++++++++++++------
 migration/multifd.h              | 29 +++++++++-
 10 files changed, 184 insertions(+), 28 deletions(-)
 create mode 100644 migration/multifd-device-state.c

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bfadc5613bac..7266b1b77d1f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -111,4 +111,8 @@ bool migration_in_bg_snapshot(void);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* migration/multifd-device-state.c */
+bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                                char *data, size_t len);
+
 #endif
diff --git a/migration/meson.build b/migration/meson.build
index 77f3abf08eb1..00853595894f 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -21,6 +21,7 @@ system_ss.add(files(
   'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
+  'multifd-device-state.c',
   'multifd-nocomp.c',
   'multifd-zlib.c',
   'multifd-zero-page.c',
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
new file mode 100644
index 000000000000..c9b44f0b5ab9
--- /dev/null
+++ b/migration/multifd-device-state.c
@@ -0,0 +1,99 @@
+/*
+ * Multifd device state migration
+ *
+ * Copyright (C) 2024 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/lockable.h"
+#include "migration/misc.h"
+#include "multifd.h"
+
+static QemuMutex queue_job_mutex;
+
+static MultiFDSendData *device_state_send;
+
+size_t multifd_device_state_payload_size(void)
+{
+    return sizeof(MultiFDDeviceState_t);
+}
+
+void multifd_device_state_save_setup(void)
+{
+    qemu_mutex_init(&queue_job_mutex);
+
+    device_state_send = multifd_send_data_alloc();
+}
+
+void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
+{
+    g_clear_pointer(&device_state->idstr, g_free);
+    g_clear_pointer(&device_state->buf, g_free);
+}
+
+void multifd_device_state_save_cleanup(void)
+{
+    g_clear_pointer(&device_state_send, multifd_send_data_free);
+
+    qemu_mutex_destroy(&queue_job_mutex);
+}
+
+static void multifd_device_state_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
+    MultiFDPacketDeviceState_t *packet = p->packet_device_state;
+
+    packet->hdr.flags = cpu_to_be32(p->flags);
+    strncpy(packet->idstr, device_state->idstr, sizeof(packet->idstr));
+    packet->instance_id = cpu_to_be32(device_state->instance_id);
+    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
+}
+
+void multifd_device_state_send_prepare(MultiFDSendParams *p)
+{
+    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
+
+    assert(multifd_payload_device_state(p->data));
+
+    multifd_send_prepare_header_device_state(p);
+
+    assert(!(p->flags & MULTIFD_FLAG_SYNC));
+
+    p->next_packet_size = device_state->buf_len;
+    if (p->next_packet_size > 0) {
+        p->iov[p->iovs_num].iov_base = device_state->buf;
+        p->iov[p->iovs_num].iov_len = p->next_packet_size;
+        p->iovs_num++;
+    }
+
+    p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
+
+    multifd_device_state_fill_packet(p);
+}
+
+bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                                char *data, size_t len)
+{
+    /* Device state submissions can come from multiple threads */
+    QEMU_LOCK_GUARD(&queue_job_mutex);
+    MultiFDDeviceState_t *device_state;
+
+    assert(multifd_payload_empty(device_state_send));
+
+    multifd_set_payload_type(device_state_send, MULTIFD_PAYLOAD_DEVICE_STATE);
+    device_state = &device_state_send->u.device_state;
+    device_state->idstr = g_strdup(idstr);
+    device_state->instance_id = instance_id;
+    device_state->buf = g_memdup2(data, len);
+    device_state->buf_len = len;
+
+    if (!multifd_send(&device_state_send)) {
+        multifd_send_data_clear(device_state_send);
+        return false;
+    }
+
+    return true;
+}
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 39eb77c9b3b7..0b7b543f44db 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -116,13 +116,13 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
          * Only !zerocopy needs the header in IOV; zerocopy will
          * send it separately.
          */
-        multifd_send_prepare_header(p);
+        multifd_send_prepare_header_ram(p);
     }
 
     multifd_send_prepare_iovs(p);
     p->flags |= MULTIFD_FLAG_NOCOMP;
 
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
 
     if (use_zero_copy_send) {
         /* Send header first, without zerocopy */
@@ -371,7 +371,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
         return false;
     }
 
-    multifd_send_prepare_header(p);
+    multifd_send_prepare_header_ram(p);
 
     return true;
 }
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 75041a4c4dfe..bd6b5b6a3868 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -490,7 +490,7 @@ static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
 
 out:
     p->flags |= MULTIFD_FLAG_QPL;
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
     return 0;
 }
 
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index db2549f59bfe..6e2d26010742 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -198,7 +198,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
     }
 out:
     p->flags |= MULTIFD_FLAG_UADK;
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
     return 0;
 }
 
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 6787538762d2..62a1fe59ad3e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -156,7 +156,7 @@ static int multifd_zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 
 out:
     p->flags |= MULTIFD_FLAG_ZLIB;
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
     return 0;
 }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 1576b1e2adc6..f98b07e7f9f5 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -143,7 +143,7 @@ static int multifd_zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 
 out:
     p->flags |= MULTIFD_FLAG_ZSTD;
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
     return 0;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index a74e8a5cc891..bebe5b5a9b9c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -19,6 +20,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "file.h"
+#include "migration/misc.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "savevm.h"
@@ -107,7 +109,9 @@ MultiFDSendData *multifd_send_data_alloc(void)
      * added to the union in the future are larger than
      * (MultiFDPages_t + flex array).
      */
-    max_payload_size = MAX(multifd_ram_payload_size(), sizeof(MultiFDPayload));
+    max_payload_size = MAX(multifd_ram_payload_size(),
+                           multifd_device_state_payload_size());
+    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
 
     /*
      * Account for any holes the compiler might insert. We can't pack
@@ -126,6 +130,9 @@ void multifd_send_data_clear(MultiFDSendData *data)
     }
 
     switch (data->type) {
+    case MULTIFD_PAYLOAD_DEVICE_STATE:
+        multifd_device_state_clear(&data->u.device_state);
+        break;
     default:
         /* Nothing to do */
         break;
@@ -228,7 +235,7 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
-void multifd_send_fill_packet(MultiFDSendParams *p)
+void multifd_send_fill_packet_ram(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     uint64_t packet_num;
@@ -397,20 +404,16 @@ bool multifd_send(MultiFDSendData **send_data)
 
         p = &multifd_send_state->params[i];
         /*
-         * Lockless read to p->pending_job is safe, because only multifd
-         * sender thread can clear it.
+         * Lockless RMW on p->pending_job_preparing is safe, because only multifd
+         * sender thread can clear it after it had seen p->pending_job being set.
+         *
+         * Pairs with qatomic_store_release() in multifd_send_thread().
          */
-        if (qatomic_read(&p->pending_job) == false) {
+        if (qatomic_cmpxchg(&p->pending_job_preparing, false, true) == false) {
             break;
         }
     }
 
-    /*
-     * Make sure we read p->pending_job before all the rest.  Pairs with
-     * qatomic_store_release() in multifd_send_thread().
-     */
-    smp_mb_acquire();
-
     assert(multifd_payload_empty(p->data));
 
     /*
@@ -534,6 +537,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->name = NULL;
     g_clear_pointer(&p->data, multifd_send_data_free);
     p->packet_len = 0;
+    g_clear_pointer(&p->packet_device_state, g_free);
     g_free(p->packet);
     p->packet = NULL;
     multifd_send_state->ops->send_cleanup(p, errp);
@@ -545,6 +549,7 @@ static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
     socket_cleanup_outgoing_migration();
+    multifd_device_state_save_cleanup();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
@@ -670,19 +675,29 @@ static void *multifd_send_thread(void *opaque)
          * qatomic_store_release() in multifd_send().
          */
         if (qatomic_load_acquire(&p->pending_job)) {
+            bool is_device_state = multifd_payload_device_state(p->data);
+            size_t total_size;
+
             p->flags = 0;
             p->iovs_num = 0;
             assert(!multifd_payload_empty(p->data));
 
-            ret = multifd_send_state->ops->send_prepare(p, &local_err);
-            if (ret != 0) {
-                break;
+            if (is_device_state) {
+                multifd_device_state_send_prepare(p);
+            } else {
+                ret = multifd_send_state->ops->send_prepare(p, &local_err);
+                if (ret != 0) {
+                    break;
+                }
             }
 
             if (migrate_mapped_ram()) {
+                assert(!is_device_state);
+
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
                                               &p->data->u.ram, &local_err);
             } else {
+                total_size = iov_size(p->iov, p->iovs_num);
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
                                                   NULL, 0, p->write_flags,
                                                   &local_err);
@@ -692,18 +707,27 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes,
-                       p->next_packet_size + p->packet_len);
+            if (is_device_state) {
+                stat64_add(&mig_stats.multifd_bytes, total_size);
+            } else {
+                /*
+                 * Can't just always add total_size since IOVs do not include
+                 * packet header in the zerocopy RAM case.
+                 */
+                stat64_add(&mig_stats.multifd_bytes,
+                           p->next_packet_size + p->packet_len);
+            }
 
             p->next_packet_size = 0;
             multifd_send_data_clear(p->data);
 
             /*
              * Making sure p->data is published before saying "we're
-             * free".  Pairs with the smp_mb_acquire() in
+             * free".  Pairs with the qatomic_cmpxchg() in
              * multifd_send().
              */
             qatomic_store_release(&p->pending_job, false);
+            qatomic_store_release(&p->pending_job_preparing, false);
         } else {
             /*
              * If not a normal job, must be a sync request.  Note that
@@ -714,7 +738,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (use_packets) {
                 p->flags = MULTIFD_FLAG_SYNC;
-                multifd_send_fill_packet(p);
+                multifd_send_fill_packet_ram(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
                                             p->packet_len, &local_err);
                 if (ret != 0) {
@@ -910,6 +934,9 @@ bool multifd_send_setup(void)
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+            p->packet_device_state = g_malloc0(sizeof(*p->packet_device_state));
+            p->packet_device_state->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
+            p->packet_device_state->hdr.version = cpu_to_be32(MULTIFD_VERSION);
         }
         p->name = g_strdup_printf("mig/src/send_%d", i);
         p->write_flags = 0;
@@ -944,6 +971,8 @@ bool multifd_send_setup(void)
         }
     }
 
+    multifd_device_state_save_setup();
+
     return true;
 
 err:
diff --git a/migration/multifd.h b/migration/multifd.h
index a0853622153e..c15c83104c8b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -120,10 +120,12 @@ typedef struct {
 typedef enum {
     MULTIFD_PAYLOAD_NONE,
     MULTIFD_PAYLOAD_RAM,
+    MULTIFD_PAYLOAD_DEVICE_STATE,
 } MultiFDPayloadType;
 
 typedef union MultiFDPayload {
     MultiFDPages_t ram;
+    MultiFDDeviceState_t device_state;
 } MultiFDPayload;
 
 struct MultiFDSendData {
@@ -136,6 +138,11 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
     return data->type == MULTIFD_PAYLOAD_NONE;
 }
 
+static inline bool multifd_payload_device_state(MultiFDSendData *data)
+{
+    return data->type == MULTIFD_PAYLOAD_DEVICE_STATE;
+}
+
 static inline void multifd_set_payload_type(MultiFDSendData *data,
                                             MultiFDPayloadType type)
 {
@@ -182,13 +189,15 @@ typedef struct {
      * cleared by the multifd sender threads.
      */
     bool pending_job;
+    bool pending_job_preparing;
     bool pending_sync;
     MultiFDSendData *data;
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_device_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets sent through this channel */
@@ -276,18 +285,25 @@ typedef struct {
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
-void multifd_send_fill_packet(MultiFDSendParams *p);
+void multifd_send_fill_packet_ram(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
 void multifd_recv_zero_page_process(MultiFDRecvParams *p);
 
-static inline void multifd_send_prepare_header(MultiFDSendParams *p)
+static inline void multifd_send_prepare_header_ram(MultiFDSendParams *p)
 {
     p->iov[0].iov_len = p->packet_len;
     p->iov[0].iov_base = p->packet;
     p->iovs_num++;
 }
 
+static inline void multifd_send_prepare_header_device_state(MultiFDSendParams *p)
+{
+    p->iov[0].iov_len = sizeof(*p->packet_device_state);
+    p->iov[0].iov_base = p->packet_device_state;
+    p->iovs_num++;
+}
+
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 bool multifd_send(MultiFDSendData **send_data);
 MultiFDSendData *multifd_send_data_alloc(void);
@@ -310,4 +326,11 @@ int multifd_ram_flush_and_sync(void);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
+
+size_t multifd_device_state_payload_size(void);
+void multifd_device_state_save_setup(void);
+void multifd_device_state_clear(MultiFDDeviceState_t *device_state);
+void multifd_device_state_save_cleanup(void);
+void multifd_device_state_send_prepare(MultiFDSendParams *p);
+
 #endif

