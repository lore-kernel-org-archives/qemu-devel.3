Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3906FD10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqn-00032u-BI; Sun, 17 Nov 2024 14:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqj-0002wf-Pf
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:21 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqh-0005vj-I2
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:21 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqd-00000002GUx-2phQ; Sun, 17 Nov 2024 20:22:15 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 13/24] migration/multifd: Device state transfer support -
 send side
Date: Sun, 17 Nov 2024 20:20:08 +0100
Message-ID: <dbff60e022ada2f072300559bd24d9e0939be21a.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
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

A new function multifd_queue_device_state() is provided for device to queue
its state for transmission via a multifd channel.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h         |   4 ++
 migration/meson.build            |   1 +
 migration/multifd-device-state.c | 106 +++++++++++++++++++++++++++++++
 migration/multifd-nocomp.c       |  11 +++-
 migration/multifd.c              |  43 +++++++++++--
 migration/multifd.h              |  24 ++++---
 6 files changed, 173 insertions(+), 16 deletions(-)
 create mode 100644 migration/multifd-device-state.c

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c92ca018ab3b..118e205bbcc6 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -109,4 +109,8 @@ bool migration_incoming_postcopy_advised(void);
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
+/* migration/multifd-device-state.c */
+bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                                char *data, size_t len);
+
 #endif
diff --git a/migration/meson.build b/migration/meson.build
index d53cf3417ab8..9788c47bb56e 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -22,6 +22,7 @@ system_ss.add(files(
   'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
+  'multifd-device-state.c',
   'multifd-nocomp.c',
   'multifd-zlib.c',
   'multifd-zero-page.c',
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
new file mode 100644
index 000000000000..7741a64fbd4d
--- /dev/null
+++ b/migration/multifd-device-state.c
@@ -0,0 +1,106 @@
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
+void multifd_device_state_send_setup(void)
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
+void multifd_device_state_send_cleanup(void)
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
+static void multifd_prepare_header_device_state(MultiFDSendParams *p)
+{
+    p->iov[0].iov_len = sizeof(*p->packet_device_state);
+    p->iov[0].iov_base = p->packet_device_state;
+    p->iovs_num++;
+}
+
+void multifd_device_state_send_prepare(MultiFDSendParams *p)
+{
+    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
+
+    assert(multifd_payload_device_state(p->data));
+
+    multifd_prepare_header_device_state(p);
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
index fa0fd0289eca..23564ce9aea9 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -84,6 +84,13 @@ static void multifd_nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
     return;
 }
 
+static void multifd_ram_prepare_header(MultiFDSendParams *p)
+{
+    p->iov[0].iov_len = p->packet_len;
+    p->iov[0].iov_base = p->packet;
+    p->iovs_num++;
+}
+
 static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = &p->data->u.ram;
@@ -117,7 +124,7 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
          * Only !zerocopy needs the header in IOV; zerocopy will
          * send it separately.
          */
-        multifd_send_prepare_header(p);
+        multifd_ram_prepare_header(p);
     }
 
     multifd_send_prepare_iovs(p);
@@ -368,7 +375,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
         return false;
     }
 
-    multifd_send_prepare_header(p);
+    multifd_ram_prepare_header(p);
 
     return true;
 }
diff --git a/migration/multifd.c b/migration/multifd.c
index 730acf55cfad..56419af417cc 100644
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
@@ -111,7 +113,9 @@ MultiFDSendData *multifd_send_data_alloc(void)
      * added to the union in the future are larger than
      * (MultiFDPages_t + flex array).
      */
-    max_payload_size = MAX(multifd_ram_payload_size(), sizeof(MultiFDPayload));
+    max_payload_size = MAX(multifd_ram_payload_size(),
+                           multifd_device_state_payload_size());
+    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
 
     /*
      * Account for any holes the compiler might insert. We can't pack
@@ -130,6 +134,9 @@ void multifd_send_data_clear(MultiFDSendData *data)
     }
 
     switch (data->type) {
+    case MULTIFD_PAYLOAD_DEVICE_STATE:
+        multifd_device_state_clear(&data->u.device_state);
+        break;
     default:
         /* Nothing to do */
         break;
@@ -232,6 +239,7 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
+/* Fills a RAM multifd packet */
 void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
@@ -524,6 +532,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->name = NULL;
     g_clear_pointer(&p->data, multifd_send_data_free);
     p->packet_len = 0;
+    g_clear_pointer(&p->packet_device_state, g_free);
     g_free(p->packet);
     p->packet = NULL;
     multifd_send_state->ops->send_cleanup(p, errp);
@@ -536,6 +545,7 @@ static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
     socket_cleanup_outgoing_migration();
+    multifd_device_state_send_cleanup();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     qemu_mutex_destroy(&multifd_send_state->multifd_send_mutex);
@@ -662,16 +672,33 @@ static void *multifd_send_thread(void *opaque)
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
+
+                total_size = iov_size(p->iov, p->iovs_num);
+            } else {
+                ret = multifd_send_state->ops->send_prepare(p, &local_err);
+                if (ret != 0) {
+                    break;
+                }
+
+                /*
+                 * Can't just always measure IOVs since these do not include
+                 * packet header in the zerocopy RAM case.
+                 */
+                total_size = (uint64_t)p->next_packet_size + p->packet_len;
             }
 
             if (migrate_mapped_ram()) {
+                assert(!is_device_state);
+
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
                                               &p->data->u.ram, &local_err);
             } else {
@@ -684,8 +711,7 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes,
-                       (uint64_t)p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.multifd_bytes, total_size);
 
             p->next_packet_size = 0;
             multifd_send_data_clear(p->data);
@@ -903,6 +929,9 @@ bool multifd_send_setup(void)
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+            p->packet_device_state = g_malloc0(sizeof(*p->packet_device_state));
+            p->packet_device_state->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
+            p->packet_device_state->hdr.version = cpu_to_be32(MULTIFD_VERSION);
         }
         p->name = g_strdup_printf(MIGRATION_THREAD_SRC_MULTIFD, i);
         p->write_flags = 0;
@@ -938,6 +967,8 @@ bool multifd_send_setup(void)
         assert(p->iov);
     }
 
+    multifd_device_state_send_setup();
+
     return true;
 
 err:
diff --git a/migration/multifd.h b/migration/multifd.h
index d2f1d0d74da7..dec7d9404434 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -121,10 +121,12 @@ typedef struct {
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
@@ -137,6 +139,11 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
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
@@ -188,8 +195,9 @@ typedef struct {
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_device_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets sent through this channel */
@@ -346,13 +354,6 @@ bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
 void multifd_recv_zero_page_process(MultiFDRecvParams *p);
 
-static inline void multifd_send_prepare_header(MultiFDSendParams *p)
-{
-    p->iov[0].iov_len = p->packet_len;
-    p->iov[0].iov_base = p->packet;
-    p->iovs_num++;
-}
-
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 bool multifd_send(MultiFDSendData **send_data);
 MultiFDSendData *multifd_send_data_alloc(void);
@@ -375,4 +376,11 @@ int multifd_ram_flush_and_sync(void);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
+
+size_t multifd_device_state_payload_size(void);
+void multifd_device_state_send_setup(void);
+void multifd_device_state_clear(MultiFDDeviceState_t *device_state);
+void multifd_device_state_send_cleanup(void);
+void multifd_device_state_send_prepare(MultiFDSendParams *p);
+
 #endif

