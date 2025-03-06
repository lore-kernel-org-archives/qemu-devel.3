Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B2EC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC1C-0008WO-Ki; Thu, 06 Mar 2025 09:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0t-0007nV-F8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0q-0001qz-Ms
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsq6RYHJYPgz1FwPZzTCEp8H4G4mPxLoeIS+HZrZY9M=;
 b=b7YdexGIonNxm9evzmQvKHnhUx+r2hv1fW4ajrSjek1U0mNM/Pbpkvaa/Dq0xtboe8nihV
 W9+3kvjPiY7upYkI3EheL12YTt0MtU7byRQ4L5j+erwGRQrT0hhLJnbJk1twUPt//mH0ff
 6STfThK7Tv1Vtzyl+2dJQ7GIZMXCcik=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-7yv6TTKWPJ6rSg0oXmIU4w-1; Thu,
 06 Mar 2025 09:15:39 -0500
X-MC-Unique: 7yv6TTKWPJ6rSg0oXmIU4w-1
X-Mimecast-MFC-AGG-ID: 7yv6TTKWPJ6rSg0oXmIU4w_1741270538
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BCFA19560B8; Thu,  6 Mar 2025 14:15:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95E701801753; Thu,  6 Mar 2025 14:15:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/42] migration/multifd: Device state transfer support - send
 side
Date: Thu,  6 Mar 2025 15:13:59 +0100
Message-ID: <20250306141419.2015340-24-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

A new function multifd_queue_device_state() is provided for device to queue
its state for transmission via a multifd channel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/ebd55768d3e5fecb5eb3f197bad9c0c07e5bc084.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h         |   4 ++
 migration/multifd.h              |  34 ++++++---
 migration/multifd-device-state.c | 118 +++++++++++++++++++++++++++++++
 migration/multifd-nocomp.c       |  14 +++-
 migration/multifd.c              |  42 +++++++++--
 migration/meson.build            |   1 +
 6 files changed, 197 insertions(+), 16 deletions(-)
 create mode 100644 migration/multifd-device-state.c

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4c171f4e897e2bea9016a1559bef3e89c165b176..bd3b725fa0b7efc4551aa19d2ac540f24bde4763 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -118,4 +118,8 @@ bool migrate_is_uri(const char *uri);
 bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                        Error **errp);
 
+/* migration/multifd-device-state.c */
+bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                                char *data, size_t len);
+
 #endif
diff --git a/migration/multifd.h b/migration/multifd.h
index 8d639eec69fecc4cf393abeb9d987be854db2242..aa679d8bbe8358e5cbab0add9c4bf007fa55961b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -127,13 +127,22 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
+typedef struct {
+    char *idstr;
+    uint32_t instance_id;
+    char *buf;
+    size_t buf_len;
+} MultiFDDeviceState_t;
+
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
@@ -146,6 +155,11 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
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
@@ -198,8 +212,9 @@ typedef struct {
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_device_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets sent through this channel */
@@ -358,13 +373,6 @@ bool multifd_send_prepare_common(MultiFDSendParams *p);
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
@@ -389,4 +397,14 @@ bool multifd_ram_sync_per_section(void);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
+
+size_t multifd_device_state_payload_size(void);
+
+void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state);
+
+void multifd_device_state_send_setup(void);
+void multifd_device_state_send_cleanup(void);
+
+void multifd_device_state_send_prepare(MultiFDSendParams *p);
+
 #endif
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
new file mode 100644
index 0000000000000000000000000000000000000000..e383e75b1a024c1885b41bcc3aee034fd6f71f9d
--- /dev/null
+++ b/migration/multifd-device-state.c
@@ -0,0 +1,118 @@
+/*
+ * Multifd device state migration
+ *
+ * Copyright (C) 2024,2025 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/lockable.h"
+#include "migration/misc.h"
+#include "multifd.h"
+
+static struct {
+    QemuMutex queue_job_mutex;
+
+    MultiFDSendData *send_data;
+} *multifd_send_device_state;
+
+size_t multifd_device_state_payload_size(void)
+{
+    return sizeof(MultiFDDeviceState_t);
+}
+
+void multifd_device_state_send_setup(void)
+{
+    assert(!multifd_send_device_state);
+    multifd_send_device_state = g_malloc(sizeof(*multifd_send_device_state));
+
+    qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
+
+    multifd_send_device_state->send_data = multifd_send_data_alloc();
+}
+
+void multifd_device_state_send_cleanup(void)
+{
+    g_clear_pointer(&multifd_send_device_state->send_data,
+                    multifd_send_data_free);
+
+    qemu_mutex_destroy(&multifd_send_device_state->queue_job_mutex);
+
+    g_clear_pointer(&multifd_send_device_state, g_free);
+}
+
+void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state)
+{
+    g_clear_pointer(&device_state->idstr, g_free);
+    g_clear_pointer(&device_state->buf, g_free);
+}
+
+static void multifd_device_state_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
+    MultiFDPacketDeviceState_t *packet = p->packet_device_state;
+
+    packet->hdr.flags = cpu_to_be32(p->flags);
+    strncpy(packet->idstr, device_state->idstr, sizeof(packet->idstr) - 1);
+    packet->idstr[sizeof(packet->idstr) - 1] = 0;
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
+    QEMU_LOCK_GUARD(&multifd_send_device_state->queue_job_mutex);
+    MultiFDDeviceState_t *device_state;
+
+    assert(multifd_payload_empty(multifd_send_device_state->send_data));
+
+    multifd_set_payload_type(multifd_send_device_state->send_data,
+                             MULTIFD_PAYLOAD_DEVICE_STATE);
+    device_state = &multifd_send_device_state->send_data->u.device_state;
+    device_state->idstr = g_strdup(idstr);
+    device_state->instance_id = instance_id;
+    device_state->buf = g_memdup2(data, len);
+    device_state->buf_len = len;
+
+    if (!multifd_send(&multifd_send_device_state->send_data)) {
+        multifd_send_data_clear(multifd_send_device_state->send_data);
+        return false;
+    }
+
+    return true;
+}
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index e46e79d8b272122c210bb895387dfa133d218d46..c00804652383ed0496769c134ea2c10e0ae91f18 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -14,6 +14,7 @@
 #include "exec/ramblock.h"
 #include "exec/target_page.h"
 #include "file.h"
+#include "migration-stats.h"
 #include "multifd.h"
 #include "options.h"
 #include "qapi/error.h"
@@ -85,6 +86,13 @@ static void multifd_nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
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
@@ -118,7 +126,7 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
          * Only !zerocopy needs the header in IOV; zerocopy will
          * send it separately.
          */
-        multifd_send_prepare_header(p);
+        multifd_ram_prepare_header(p);
     }
 
     multifd_send_prepare_iovs(p);
@@ -133,6 +141,8 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
         if (ret != 0) {
             return -1;
         }
+
+        stat64_add(&mig_stats.multifd_bytes, p->packet_len);
     }
 
     return 0;
@@ -431,7 +441,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
 bool multifd_send_prepare_common(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = &p->data->u.ram;
-    multifd_send_prepare_header(p);
+    multifd_ram_prepare_header(p);
     multifd_send_zero_page_detect(p);
 
     if (!pages->normal_num) {
diff --git a/migration/multifd.c b/migration/multifd.c
index c8508cadab2d00c5c7f3e26766038e9f5a287dcc..3625c9a37c0e046b7a851dfe3d94fefa6887534d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "system/system.h"
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
+        multifd_send_data_clear_device_state(&data->u.device_state);
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
@@ -694,16 +704,32 @@ static void *multifd_send_thread(void *opaque)
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
 
+            /*
+             * The packet header in the zerocopy RAM case is accounted for
+             * in multifd_nocomp_send_prepare() - where it is actually
+             * being sent.
+             */
+            total_size = iov_size(p->iov, p->iovs_num);
+
             if (migrate_mapped_ram()) {
+                assert(!is_device_state);
+
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
                                               &p->data->u.ram, &local_err);
             } else {
@@ -716,8 +742,7 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes,
-                       (uint64_t)p->next_packet_size + p->packet_len);
+            stat64_add(&mig_stats.multifd_bytes, total_size);
 
             p->next_packet_size = 0;
             multifd_send_data_clear(p->data);
@@ -938,6 +963,9 @@ bool multifd_send_setup(void)
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+            p->packet_device_state = g_malloc0(sizeof(*p->packet_device_state));
+            p->packet_device_state->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
+            p->packet_device_state->hdr.version = cpu_to_be32(MULTIFD_VERSION);
         }
         p->name = g_strdup_printf(MIGRATION_THREAD_SRC_MULTIFD, i);
         p->write_flags = 0;
@@ -973,6 +1001,8 @@ bool multifd_send_setup(void)
         assert(p->iov);
     }
 
+    multifd_device_state_send_setup();
+
     return true;
 
 err:
diff --git a/migration/meson.build b/migration/meson.build
index d3bfe84d62045e757ee4cca3f5d0db9a87d3450c..9aa48b290e2a58533bcabdf3efd67313471fbd48 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -25,6 +25,7 @@ system_ss.add(files(
   'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
+  'multifd-device-state.c',
   'multifd-nocomp.c',
   'multifd-zlib.c',
   'multifd-zero-page.c',
-- 
2.48.1


