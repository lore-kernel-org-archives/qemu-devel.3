Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336CDC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbTA-0005WE-1V; Tue, 18 Jun 2024 12:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbT0-0005Ix-Gd
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:56 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSx-0000uz-5M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:53 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSh-0001dB-Io; Tue, 18 Jun 2024 18:13:35 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v1 09/13] migration/multifd: Device state transfer support -
 send side
Date: Tue, 18 Jun 2024 18:12:27 +0200
Message-ID: <a70d15be5cb6fc2da659e58ce46fa2ced81f2635.1718717584.git.maciej.szmigiero@oracle.com>
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

A new function multifd_queue_device_state() is provided for device to queue
its state for transmission via a multifd channel.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h |   4 +
 migration/multifd-zlib.c |   2 +-
 migration/multifd-zstd.c |   2 +-
 migration/multifd.c      | 181 +++++++++++++++++++++++++++++++++------
 migration/multifd.h      |  26 ++++--
 5 files changed, 182 insertions(+), 33 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bfadc5613bac..abf6f33eeae8 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -111,4 +111,8 @@ bool migration_in_bg_snapshot(void);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* migration/multifd.c */
+int multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                               char *data, size_t len);
+
 #endif
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 737a9645d2fe..424547aa5be0 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -177,7 +177,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 
 out:
     p->flags |= MULTIFD_FLAG_ZLIB;
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
     return 0;
 }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 256858df0a0a..89ef21898485 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -166,7 +166,7 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 
 out:
     p->flags |= MULTIFD_FLAG_ZSTD;
-    multifd_send_fill_packet(p);
+    multifd_send_fill_packet_ram(p);
     return 0;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index daa34172bf24..6a7e5d659925 100644
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
@@ -49,9 +51,12 @@ typedef struct {
 } __attribute__((packed)) MultiFDInit_t;
 
 struct {
+    QemuMutex queue_job_mutex;
+
     MultiFDSendParams *params;
-    /* array of pages to sent */
+    /* array of pages or device state to be sent */
     MultiFDPages_t *pages;
+    MultiFDDeviceState_t *device_state;
     /*
      * Global number of generated multifd packets.
      *
@@ -168,7 +173,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 }
 
 /**
- * nocomp_send_prepare: prepare date to be able to send
+ * nocomp_send_prepare_ram: prepare RAM data for sending
  *
  * For no compression we just have to calculate the size of the
  * packet.
@@ -178,7 +183,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
-static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
+static int nocomp_send_prepare_ram(MultiFDSendParams *p, Error **errp)
 {
     bool use_zero_copy_send = migrate_zero_copy_send();
     int ret;
@@ -197,13 +202,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
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
@@ -217,6 +222,56 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
+static void multifd_send_fill_packet_device_state(MultiFDSendParams *p)
+{
+    MultiFDPacketDeviceState_t *packet = p->packet_device_state;
+
+    packet->hdr.flags = cpu_to_be32(p->flags);
+    strncpy(packet->idstr, p->device_state->idstr, sizeof(packet->idstr));
+    packet->instance_id = cpu_to_be32(p->device_state->instance_id);
+    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
+}
+
+/**
+ * nocomp_send_prepare_device_state: prepare device state data for sending
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int nocomp_send_prepare_device_state(MultiFDSendParams *p,
+                                            Error **errp)
+{
+    multifd_send_prepare_header_device_state(p);
+
+    assert(!(p->flags & MULTIFD_FLAG_SYNC));
+
+    p->next_packet_size = p->device_state->buf_len;
+    if (p->next_packet_size > 0) {
+        p->iov[p->iovs_num].iov_base = p->device_state->buf;
+        p->iov[p->iovs_num].iov_len = p->next_packet_size;
+        p->iovs_num++;
+    }
+
+    p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
+
+    multifd_send_fill_packet_device_state(p);
+
+    return 0;
+}
+
+static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    if (p->is_device_state_job) {
+        return nocomp_send_prepare_device_state(p, errp);
+    } else {
+        return nocomp_send_prepare_ram(p, errp);
+    }
+
+    g_assert_not_reached();
+}
+
 /**
  * nocomp_recv_setup: setup receive side
  *
@@ -397,7 +452,18 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     g_free(pages);
 }
 
-void multifd_send_fill_packet(MultiFDSendParams *p)
+static void multifd_device_state_free(MultiFDDeviceState_t *device_state)
+{
+    if (!device_state) {
+        return;
+    }
+
+    g_clear_pointer(&device_state->idstr, g_free);
+    g_clear_pointer(&device_state->buf, g_free);
+    g_free(device_state);
+}
+
+void multifd_send_fill_packet_ram(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     MultiFDPages_t *pages = p->pages;
@@ -585,7 +651,8 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
 }
 
 /*
- * How we use multifd_send_state->pages and channel->pages?
+ * How we use multifd_send_state->pages + channel->pages
+ * and multifd_send_state->device_state + channel->device_state?
  *
  * We create a pages for each channel, and a main one.  Each time that
  * we need to send a batch of pages we interchange the ones between
@@ -601,14 +668,15 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
  * have to had finish with its own, otherwise pending_job can't be
  * false.
  *
+ * 'device_state' struct has similar handling.
+ *
  * Returns true if succeed, false otherwise.
  */
-static bool multifd_send_pages(void)
+static bool multifd_send_queue_job(bool is_device_state)
 {
     int i;
     static int next_channel;
     MultiFDSendParams *p = NULL; /* make happy gcc */
-    MultiFDPages_t *pages = multifd_send_state->pages;
 
     if (multifd_send_should_exit()) {
         return false;
@@ -645,7 +713,7 @@ static bool multifd_send_pages(void)
          * Lockless read to p->pending_job is safe, because only multifd
          * sender thread can clear it.
          */
-        if (qatomic_read(&p->pending_job) == false) {
+        if (qatomic_cmpxchg(&p->pending_job_preparing, false, true) == false) {
             break;
         }
     }
@@ -655,12 +723,30 @@ static bool multifd_send_pages(void)
      * qatomic_store_release() in multifd_send_thread().
      */
     smp_mb_acquire();
-    assert(!p->pages->num);
-    multifd_send_state->pages = p->pages;
-    p->pages = pages;
+
+    if (!is_device_state) {
+        assert(!p->pages->num);
+    } else {
+        assert(!p->device_state->buf);
+    }
+
+    p->is_device_state_job = is_device_state;
+
+    if (!is_device_state) {
+        MultiFDPages_t *pages = multifd_send_state->pages;
+
+        multifd_send_state->pages = p->pages;
+        p->pages = pages;
+    } else {
+        MultiFDDeviceState_t *device_state = multifd_send_state->device_state;
+
+        multifd_send_state->device_state = p->device_state;
+        p->device_state = device_state;
+    }
+
     /*
-     * Making sure p->pages is setup before marking pending_job=true. Pairs
-     * with the qatomic_load_acquire() in multifd_send_thread().
+     * Making sure p->pages or p->device state is setup before marking
+     * pending_job=true. Pairs with the qatomic_load_acquire() in multifd_send_thread().
      */
     qatomic_store_release(&p->pending_job, true);
     qemu_sem_post(&p->sem);
@@ -707,7 +793,7 @@ retry:
      * After flush, always retry.
      */
     if (pages->block != block || multifd_queue_full(pages)) {
-        if (!multifd_send_pages()) {
+        if (!multifd_send_queue_job(false)) {
             return false;
         }
         goto retry;
@@ -718,6 +804,28 @@ retry:
     return true;
 }
 
+int multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                               char *data, size_t len)
+{
+    /* Device state submissions can come from multiple threads */
+    QEMU_LOCK_GUARD(&multifd_send_state->queue_job_mutex);
+    MultiFDDeviceState_t *device_state = multifd_send_state->device_state;
+
+    assert(!device_state->buf);
+    device_state->idstr = g_strdup(idstr);
+    device_state->instance_id = instance_id;
+    device_state->buf = g_memdup2(data, len);
+    device_state->buf_len = len;
+
+    if (!multifd_send_queue_job(true)) {
+        g_clear_pointer(&device_state->idstr, g_free);
+        g_clear_pointer(&device_state->buf, g_free);
+        return -1;
+    }
+
+    return 0;
+}
+
 /* Multifd send side hit an error; remember it and prepare to quit */
 static void multifd_send_set_error(Error *err)
 {
@@ -822,10 +930,12 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     multifd_pages_clear(p->pages);
     p->pages = NULL;
     p->packet_len = 0;
+    g_clear_pointer(&p->packet_device_state, g_free);
     g_free(p->packet);
     p->packet = NULL;
     g_free(p->iov);
     p->iov = NULL;
+    g_clear_pointer(&p->device_state, multifd_device_state_free);
     multifd_send_state->ops->send_cleanup(p, errp);
 
     return *errp == NULL;
@@ -840,7 +950,9 @@ static void multifd_send_cleanup_state(void)
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
     multifd_pages_clear(multifd_send_state->pages);
+    g_clear_pointer(&multifd_send_state->device_state, multifd_device_state_free);
     multifd_send_state->pages = NULL;
+    qemu_mutex_destroy(&multifd_send_state->queue_job_mutex);
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -894,10 +1006,11 @@ int multifd_send_sync_main(void)
         return 0;
     }
     if (multifd_send_state->pages->num) {
-        if (!multifd_send_pages()) {
+        if (!multifd_send_queue_job(false)) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
         }
+        assert(!multifd_send_state->pages->num);
     }
 
     flush_zero_copy = migrate_zero_copy_send();
@@ -973,17 +1086,22 @@ static void *multifd_send_thread(void *opaque)
          */
         if (qatomic_load_acquire(&p->pending_job)) {
             MultiFDPages_t *pages = p->pages;
+            bool is_device_state = p->is_device_state_job;
+            size_t total_size;
 
             p->flags = 0;
             p->iovs_num = 0;
-            assert(pages->num);
+            assert(is_device_state || pages->num);
 
             ret = multifd_send_state->ops->send_prepare(p, &local_err);
             if (ret != 0) {
                 break;
             }
 
+            total_size = iov_size(p->iov, p->iovs_num);
             if (migrate_mapped_ram()) {
+                assert(!is_device_state);
+
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
                                               p->pages->block, &local_err);
             } else {
@@ -996,12 +1114,18 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            stat64_add(&mig_stats.multifd_bytes,
-                       p->next_packet_size + p->packet_len);
-            stat64_add(&mig_stats.normal_pages, pages->normal_num);
-            stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
+            stat64_add(&mig_stats.multifd_bytes, total_size);
+            if (!is_device_state) {
+                stat64_add(&mig_stats.normal_pages, pages->normal_num);
+                stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
+            }
 
-            multifd_pages_reset(p->pages);
+            if (is_device_state) {
+                g_clear_pointer(&p->device_state->idstr, g_free);
+                g_clear_pointer(&p->device_state->buf, g_free);
+            } else {
+                multifd_pages_reset(p->pages);
+            }
             p->next_packet_size = 0;
 
             /*
@@ -1010,6 +1134,7 @@ static void *multifd_send_thread(void *opaque)
              * multifd_send_pages().
              */
             qatomic_store_release(&p->pending_job, false);
+            qatomic_store_release(&p->pending_job_preparing, false);
         } else {
             /*
              * If not a normal job, must be a sync request.  Note that
@@ -1020,7 +1145,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (use_packets) {
                 p->flags = MULTIFD_FLAG_SYNC;
-                multifd_send_fill_packet(p);
+                multifd_send_fill_packet_ram(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
                                             p->packet_len, &local_err);
                 if (ret != 0) {
@@ -1199,9 +1324,11 @@ bool multifd_send_setup(void)
 
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
+    qemu_mutex_init(&multifd_send_state->queue_job_mutex);
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_created, 0);
+    multifd_send_state->device_state = g_malloc0(sizeof(*multifd_send_state->device_state));
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
@@ -1215,11 +1342,15 @@ bool multifd_send_setup(void)
         p->pages = multifd_pages_init(page_count);
 
         if (use_packets) {
+            p->device_state = g_malloc0(sizeof(*p->device_state));
+
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
             p->packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
             p->packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
+            p->packet_device_state = g_malloc0(sizeof(*p->packet_device_state));
+            p->packet_device_state->hdr = p->packet->hdr;
 
             /* We need one extra place for the packet header */
             p->iov = g_new0(struct iovec, page_count + 1);
@@ -1786,7 +1917,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
         return false;
     }
 
-    multifd_send_prepare_header(p);
+    multifd_send_prepare_header_ram(p);
 
     return true;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index 40ee613dd88a..655bec110f87 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -156,18 +156,25 @@ typedef struct {
      * cleared by the multifd sender threads.
      */
     bool pending_job;
+    bool pending_job_preparing;
     bool pending_sync;
-    /* array of pages to sent.
-     * The owner of 'pages' depends of 'pending_job' value:
+
+    /* Whether the pending job is pages (false) or device state (true) */
+    bool is_device_state_job;
+
+    /* Array of pages or device state to be sent (depending on the flag above).
+     * The owner of these depends of 'pending_job' value:
      * pending_job == 0 -> migration_thread can use it.
      * pending_job != 0 -> multifd_channel can use it.
      */
     MultiFDPages_t *pages;
+    MultiFDDeviceState_t *device_state;
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_device_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets sent through this channel */
@@ -267,18 +274,25 @@ typedef struct {
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
-void multifd_send_fill_packet(MultiFDSendParams *p);
+void multifd_send_fill_packet_ram(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
 void multifd_recv_zero_page_process(MultiFDRecvParams *p);
 
-static inline void multifd_send_prepare_header(MultiFDSendParams *p)
+void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
+
+static inline void multifd_send_prepare_header_ram(MultiFDSendParams *p)
 {
     p->iov[0].iov_len = p->packet_len;
     p->iov[0].iov_base = p->packet;
     p->iovs_num++;
 }
 
-void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
+static inline void multifd_send_prepare_header_device_state(MultiFDSendParams *p)
+{
+    p->iov[0].iov_len = sizeof(*p->packet_device_state);
+    p->iov[0].iov_base = p->packet_device_state;
+    p->iovs_num++;
+}
 
 #endif

