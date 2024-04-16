Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E87C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk4O-0007Uo-8l; Tue, 16 Apr 2024 10:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3z-0006oE-Rk
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:36 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3w-0002eM-67
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:35 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3d-0002jb-Tv; Tue, 16 Apr 2024 16:45:13 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 23/26] migration/multifd: Device state transfer support -
 send side
Date: Tue, 16 Apr 2024 16:43:02 +0200
Message-ID: <ec2f88766178ab461f19ff4fa1414ce828e9862f.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 migration/multifd.c      | 244 ++++++++++++++++++++++++++++++++++-----
 migration/multifd.h      |  30 +++--
 5 files changed, 244 insertions(+), 38 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c9e200f4eb8f..25968e31247b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -117,4 +117,8 @@ bool migration_in_bg_snapshot(void);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* migration/multifd.c */
+int multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                               char *data, size_t len);
+
 #endif
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 99821cd4d5ef..e20c1de6033d 100644
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
index 02112255adcc..37cebd006921 100644
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
index 878ff7d9f9f0..d8ce01539a05 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -20,6 +21,7 @@
 #include "qapi/error.h"
 #include "channel.h"
 #include "file.h"
+#include "migration/misc.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "savevm.h"
@@ -50,9 +52,17 @@ typedef struct {
 } __attribute__((packed)) MultiFDInit_t;
 
 struct {
+    /*
+     * Are there some device state dedicated channels (true) or
+     * should device state be sent via any available channel (false)?
+     */
+    bool device_state_dedicated_channels;
+    GMutex queue_job_mutex;
+
     MultiFDSendParams *params;
-    /* array of pages to sent */
+    /* array of pages or device state to be sent */
     MultiFDPages_t *pages;
+    MultiFDDeviceState_t *device_state;
     /*
      * Global number of generated multifd packets.
      *
@@ -169,7 +179,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 }
 
 /**
- * nocomp_send_prepare: prepare date to be able to send
+ * nocomp_send_prepare_ram: prepare RAM data for sending
  *
  * For no compression we just have to calculate the size of the
  * packet.
@@ -179,7 +189,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
-static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
+static int nocomp_send_prepare_ram(MultiFDSendParams *p, Error **errp)
 {
     bool use_zero_copy_send = migrate_zero_copy_send();
     int ret;
@@ -198,13 +208,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
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
@@ -218,6 +228,59 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
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
+    assert(!multifd_send_state->device_state_dedicated_channels ||
+           p->is_device_state_dedicated);
+
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
@@ -397,7 +460,18 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
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
@@ -585,7 +659,8 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
 }
 
 /*
- * How we use multifd_send_state->pages and channel->pages?
+ * How we use multifd_send_state->pages + channel->pages
+ * and multifd_send_state->device_state + channel->device_state?
  *
  * We create a pages for each channel, and a main one.  Each time that
  * we need to send a batch of pages we interchange the ones between
@@ -601,14 +676,15 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
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
@@ -632,7 +708,9 @@ static bool multifd_send_pages(void)
          * Lockless read to p->pending_job is safe, because only multifd
          * sender thread can clear it.
          */
-        if (qatomic_read(&p->pending_job) == false) {
+        if ((!multifd_send_state->device_state_dedicated_channels ||
+             p->is_device_state_dedicated == is_device_state) &&
+            qatomic_read(&p->pending_job) == false) {
             qatomic_store_release(&next_channel,
                                   (i + 1) % migrate_multifd_channels());
             break;
@@ -644,12 +722,30 @@ static bool multifd_send_pages(void)
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
@@ -673,7 +769,7 @@ static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
 }
 
 /* Returns true if enqueue successful, false otherwise */
-bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+static bool multifd_queue_page_locked(RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages;
 
@@ -696,7 +792,7 @@ retry:
      * After flush, always retry.
      */
     if (pages->block != block || multifd_queue_full(pages)) {
-        if (!multifd_send_pages()) {
+        if (!multifd_send_queue_job(false)) {
             return false;
         }
         goto retry;
@@ -707,6 +803,45 @@ retry:
     return true;
 }
 
+bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+{
+    g_autoptr(GMutexLocker) locker = NULL;
+
+    /*
+     * Device state submissions for shared channels can come
+     * from multiple threads and conflict with page submissions
+     * with respect to multifd_send_state access.
+     */
+    if (!multifd_send_state->device_state_dedicated_channels) {
+        locker = g_mutex_locker_new(&multifd_send_state->queue_job_mutex);
+    }
+
+    return multifd_queue_page_locked(block, offset);
+}
+
+int multifd_queue_device_state(char *idstr, uint32_t instance_id,
+                               char *data, size_t len)
+{
+    /* Device state submissions can came from multiple threads */
+    g_autoptr(GMutexLocker) locker =
+        g_mutex_locker_new(&multifd_send_state->queue_job_mutex);
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
@@ -811,10 +946,12 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
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
@@ -829,7 +966,9 @@ static void multifd_send_cleanup_state(void)
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
     multifd_pages_clear(multifd_send_state->pages);
+    g_clear_pointer(&multifd_send_state->device_state, multifd_device_state_free);
     multifd_send_state->pages = NULL;
+    g_mutex_clear(&multifd_send_state->queue_job_mutex);
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -876,17 +1015,28 @@ static int multifd_zero_copy_flush(QIOChannel *c)
 
 int multifd_send_sync_main(void)
 {
+    g_autoptr(GMutexLocker) locker = NULL;
     int i;
     bool flush_zero_copy;
 
     if (!migrate_multifd()) {
         return 0;
     }
+
+    /*
+     * Page SYNC can conflict with device state submissions for shared channels
+     * with respect to multifd_send_state access.
+     */
+    if (!multifd_send_state->device_state_dedicated_channels) {
+        locker = g_mutex_locker_new(&multifd_send_state->queue_job_mutex);
+    }
+
     if (multifd_send_state->pages->num) {
-        if (!multifd_send_pages()) {
+        if (!multifd_send_queue_job(false)) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
         }
+        assert(!multifd_send_state->pages->num);
     }
 
     flush_zero_copy = migrate_zero_copy_send();
@@ -898,6 +1048,11 @@ int multifd_send_sync_main(void)
             return -1;
         }
 
+        if (p->is_device_state_dedicated) {
+            assert(multifd_send_state->device_state_dedicated_channels);
+            continue;
+        }
+
         trace_multifd_send_sync_main_signal(p->id);
 
         /*
@@ -915,6 +1070,10 @@ int multifd_send_sync_main(void)
             return -1;
         }
 
+        if (p->is_device_state_dedicated) {
+            continue;
+        }
+
         qemu_sem_wait(&multifd_send_state->channels_ready);
         trace_multifd_send_sync_main_wait(p->id);
         qemu_sem_wait(&p->sem_sync);
@@ -962,17 +1121,22 @@ static void *multifd_send_thread(void *opaque)
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
@@ -985,12 +1149,18 @@ static void *multifd_send_thread(void *opaque)
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
@@ -1009,7 +1179,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (use_packets) {
                 p->flags = MULTIFD_FLAG_SYNC;
-                multifd_send_fill_packet(p);
+                multifd_send_fill_packet_ram(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
                                             p->packet_len, &local_err);
                 if (ret != 0) {
@@ -1223,7 +1393,12 @@ static bool multifd_new_send_channel_create(MultiFDSendParams *p, Error **errp)
     g_autoptr(MFDSendChannelConnectData) data = NULL;
     MigChannelHeader header = {};
 
-    header.channel_type = MIG_CHANNEL_TYPE_MULTIFD;
+    if (!p->is_device_state_dedicated) {
+        header.channel_type = MIG_CHANNEL_TYPE_MULTIFD;
+    } else {
+        header.channel_type = MIG_CHANNEL_TYPE_MULTIFD_DEVICE_STATE;
+    }
+
     data = mfd_send_channel_connect_data_new(p, &header);
 
     if (!multifd_use_packets()) {
@@ -1239,7 +1414,7 @@ bool multifd_send_setup(void)
 {
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
-    int thread_count, ret = 0;
+    int thread_count, device_state_thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
@@ -1249,10 +1424,16 @@ bool multifd_send_setup(void)
     }
 
     thread_count = migrate_multifd_channels();
+    device_state_thread_count = migrate_multifd_channels_device_state();
+    assert(device_state_thread_count < thread_count);
+
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
+    multifd_send_state->device_state_dedicated_channels = device_state_thread_count >= 1;
+    g_mutex_init(&multifd_send_state->queue_job_mutex);
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_created, 0);
+    multifd_send_state->device_state = g_malloc0(sizeof(*multifd_send_state->device_state));
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
@@ -1260,21 +1441,28 @@ bool multifd_send_setup(void)
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        p->is_device_state_dedicated = i >= thread_count - device_state_thread_count;
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
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
         } else {
+            assert(!p->is_device_state_dedicated);
+
             p->iov = g_new0(struct iovec, page_count);
         }
         p->name = g_strdup_printf("multifdsend_%d", i);
@@ -1858,7 +2046,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
         return false;
     }
 
-    multifd_send_prepare_header(p);
+    multifd_send_prepare_header_ram(p);
 
     return true;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index b5fa56b791af..53cf80c66f98 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -138,6 +138,7 @@ typedef struct {
     uint32_t page_count;
     /* multifd flags for sending ram */
     int write_flags;
+    bool is_device_state_dedicated;
 
     /* sem where to wait for more work */
     QemuSemaphore sem;
@@ -157,17 +158,23 @@ typedef struct {
      */
     bool pending_job;
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
@@ -268,20 +275,27 @@ typedef struct {
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
-void multifd_send_fill_packet(MultiFDSendParams *p);
+void multifd_send_fill_packet_ram(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
 void multifd_recv_zero_page_process(MultiFDRecvParams *p);
 
-static inline void multifd_send_prepare_header(MultiFDSendParams *p)
+struct MFDSendChannelConnectData;
+typedef struct MFDSendChannelConnectData MFDSendChannelConnectData;
+bool multifd_channel_connect(MFDSendChannelConnectData *data, QIOChannel *ioc, Error **errp);
+
+static inline void multifd_send_prepare_header_ram(MultiFDSendParams *p)
 {
     p->iov[0].iov_len = p->packet_len;
     p->iov[0].iov_base = p->packet;
     p->iovs_num++;
 }
 
-struct MFDSendChannelConnectData;
-typedef struct MFDSendChannelConnectData MFDSendChannelConnectData;
-bool multifd_channel_connect(MFDSendChannelConnectData *data, QIOChannel *ioc, Error **errp);
+static inline void multifd_send_prepare_header_device_state(MultiFDSendParams *p)
+{
+    p->iov[0].iov_len = sizeof(*p->packet_device_state);
+    p->iov[0].iov_base = p->packet_device_state;
+    p->iovs_num++;
+}
 
 #endif

