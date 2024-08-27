Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7FDC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Qk-0008QX-0F; Tue, 27 Aug 2024 13:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QU-0007YF-3k
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:21 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QR-0001cy-3o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:17 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QI-0002PY-NN; Tue, 27 Aug 2024 19:56:06 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] migration: Add save_live_complete_precopy_thread
 handler
Date: Tue, 27 Aug 2024 19:54:33 +0200
Message-ID: <e980c922e6e13a269b5202a2c06efc2fc9a2ff9b.1724701542.git.maciej.szmigiero@oracle.com>
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

This SaveVMHandler helps device provide its own asynchronous transmission
of the remaining data at the end of a precopy phase via multifd channels,
in parallel with the transfer done by save_live_complete_precopy handlers.

These threads are launched only when multifd device state transfer is
supported, after all save_live_complete_precopy_begin handlers have
already finished (for stream synchronization purposes).

Management of these threads in done in the multifd migration code,
wrapping them in the generic thread pool.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h         | 10 ++++
 include/migration/register.h     | 25 +++++++++
 include/qemu/typedefs.h          |  4 ++
 migration/multifd-device-state.c | 87 ++++++++++++++++++++++++++++++++
 migration/savevm.c               | 40 ++++++++++++++-
 5 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 189de6d02ad6..26f7f3140f03 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -116,4 +116,14 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
 bool migration_has_device_state_support(void);
 
+void
+multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+                                       char *idstr, uint32_t instance_id,
+                                       void *opaque);
+
+void multifd_launch_device_state_save_threads(int max_count);
+
+void multifd_abort_device_state_save_threads(void);
+int multifd_join_device_state_save_threads(void);
+
 #endif
diff --git a/include/migration/register.h b/include/migration/register.h
index 44d8cf5192ae..ace2cfc0f75e 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -139,6 +139,31 @@ typedef struct SaveVMHandlers {
      */
     int (*save_live_complete_precopy_end)(QEMUFile *f, void *opaque);
 
+    /* This runs in a separate thread. */
+
+    /**
+     * @save_live_complete_precopy_thread
+     *
+     * Called at the end of a precopy phase from a separate worker thread
+     * in configurations where multifd device state transfer is supported
+     * in order to perform asynchronous transmission of the remaining data in
+     * parallel with @save_live_complete_precopy handlers.
+     * The call happens after all @save_live_complete_precopy_begin handlers
+     * have finished.
+     * When postcopy is enabled, devices that support postcopy will skip this
+     * step.
+     *
+     * @idstr: this device section idstr
+     * @instance_id: this device section instance_id
+     * @abort_flag: flag indicating that the migration core wants to abort
+     * the transmission and so the handler should exit ASAP. To be read by
+     * qatomic_read() or similar.
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
+
     /* This runs both outside and inside the BQL.  */
 
     /**
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9d222dc37628..edd6e7b9c116 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -130,5 +130,9 @@ typedef struct IRQState *qemu_irq;
  * Function types
  */
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+typedef int (*SaveLiveCompletePrecopyThreadHandler)(char *idstr,
+                                                    uint32_t instance_id,
+                                                    bool *abort_flag,
+                                                    void *opaque);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 7b34fe736c7f..9b364e8ef33c 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -9,12 +9,17 @@
 
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
+#include "block/thread-pool.h"
 #include "migration/misc.h"
 #include "multifd.h"
 #include "options.h"
 
 static QemuMutex queue_job_mutex;
 
+ThreadPool *send_threads;
+int send_threads_ret;
+bool send_threads_abort;
+
 static MultiFDSendData *device_state_send;
 
 size_t multifd_device_state_payload_size(void)
@@ -27,6 +32,10 @@ void multifd_device_state_save_setup(void)
     qemu_mutex_init(&queue_job_mutex);
 
     device_state_send = multifd_send_data_alloc();
+
+    send_threads = thread_pool_new(NULL);
+    send_threads_ret = 0;
+    send_threads_abort = false;
 }
 
 void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
@@ -37,6 +46,7 @@ void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
 
 void multifd_device_state_save_cleanup(void)
 {
+    g_clear_pointer(&send_threads, thread_pool_free);
     g_clear_pointer(&device_state_send, multifd_send_data_free);
 
     qemu_mutex_destroy(&queue_job_mutex);
@@ -104,3 +114,80 @@ bool migration_has_device_state_support(void)
     return migrate_multifd() && !migrate_mapped_ram() &&
         migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
 }
+
+static void multifd_device_state_save_thread_complete(void *opaque, int ret)
+{
+    if (ret && !send_threads_ret) {
+        send_threads_ret = ret;
+    }
+}
+
+struct MultiFDDSSaveThreadData {
+    SaveLiveCompletePrecopyThreadHandler hdlr;
+    char *idstr;
+    uint32_t instance_id;
+    void *opaque;
+};
+
+static void multifd_device_state_save_thread_data_free(void *opaque)
+{
+    struct MultiFDDSSaveThreadData *data = opaque;
+
+    g_clear_pointer(&data->idstr, g_free);
+    g_free(data);
+}
+
+static int multifd_device_state_save_thread(void *opaque)
+{
+    struct MultiFDDSSaveThreadData *data = opaque;
+
+    return data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
+                      data->opaque);
+}
+
+void
+multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+                                       char *idstr, uint32_t instance_id,
+                                       void *opaque)
+{
+    struct MultiFDDSSaveThreadData *data;
+
+    assert(migration_has_device_state_support());
+
+    data = g_new(struct MultiFDDSSaveThreadData, 1);
+    data->hdlr = hdlr;
+    data->idstr = g_strdup(idstr);
+    data->instance_id = instance_id;
+    data->opaque = opaque;
+
+    thread_pool_submit(send_threads,
+                       multifd_device_state_save_thread,
+                       data, multifd_device_state_save_thread_data_free,
+                       multifd_device_state_save_thread_complete, NULL);
+}
+
+void multifd_launch_device_state_save_threads(int max_count)
+{
+    assert(migration_has_device_state_support());
+
+    thread_pool_set_minmax_threads(send_threads,
+                                   0, max_count);
+
+    thread_pool_poll(send_threads);
+}
+
+void multifd_abort_device_state_save_threads(void)
+{
+    assert(migration_has_device_state_support());
+
+    qatomic_set(&send_threads_abort, true);
+}
+
+int multifd_join_device_state_save_threads(void)
+{
+    assert(migration_has_device_state_support());
+
+    thread_pool_join(send_threads);
+
+    return send_threads_ret;
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index 33c9200d1e78..a70f6ed006f2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1495,6 +1495,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
     int ret;
+    bool multifd_device_state = migration_has_device_state_support();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
@@ -1517,6 +1518,27 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
         }
     }
 
+    if (multifd_device_state) {
+        int thread_count = 0;
+
+        QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+            SaveLiveCompletePrecopyThreadHandler hdlr;
+
+            if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
+                             se->ops->has_postcopy(se->opaque)) ||
+                !se->ops->save_live_complete_precopy_thread) {
+                continue;
+            }
+
+            hdlr = se->ops->save_live_complete_precopy_thread;
+            multifd_spawn_device_state_save_thread(hdlr,
+                                                   se->idstr, se->instance_id,
+                                                   se->opaque);
+            thread_count++;
+        }
+        multifd_launch_device_state_save_threads(thread_count);
+    }
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
@@ -1541,13 +1563,21 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
         save_section_footer(f, se);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
-            return -1;
+            goto ret_fail_abort_threads;
         }
         end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
                                     end_ts_each - start_ts_each);
     }
 
+    if (multifd_device_state) {
+        ret = multifd_join_device_state_save_threads();
+        if (ret) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
@@ -1565,6 +1595,14 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     trace_vmstate_downtime_checkpoint("src-iterable-saved");
 
     return 0;
+
+ret_fail_abort_threads:
+    if (multifd_device_state) {
+        multifd_abort_device_state_save_threads();
+        multifd_join_device_state_save_threads();
+    }
+
+    return -1;
 }
 
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

