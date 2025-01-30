Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6AEC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRVu-0005Xf-IG; Thu, 30 Jan 2025 05:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVf-0005BI-EG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:06 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVd-0007Ly-AI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:10:55 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVY-00000006Tzp-3IJb; Thu, 30 Jan 2025 11:10:48 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 19/33] migration: Add save_live_complete_precopy_thread
 handler
Date: Thu, 30 Jan 2025 11:08:40 +0100
Message-ID: <7561a5d67e113e166c7d43246d52feec6ca06fb5.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This SaveVMHandler helps device provide its own asynchronous transmission
of the remaining data at the end of a precopy phase via multifd channels,
in parallel with the transfer done by save_live_complete_precopy handlers.

These threads are launched only when multifd device state transfer is
supported.

Management of these threads in done in the multifd migration code,
wrapping them in the generic thread pool.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h         |  8 +++
 include/migration/register.h     | 21 ++++++++
 include/qemu/typedefs.h          |  4 ++
 migration/multifd-device-state.c | 83 ++++++++++++++++++++++++++++++++
 migration/savevm.c               | 37 +++++++++++++-
 5 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index cc987e6e97af..008d22df8e72 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -116,4 +116,12 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
 bool multifd_device_state_supported(void);
 
+void
+multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+                                       char *idstr, uint32_t instance_id,
+                                       void *opaque);
+
+void multifd_abort_device_state_save_threads(void);
+int multifd_join_device_state_save_threads(void);
+
 #endif
diff --git a/include/migration/register.h b/include/migration/register.h
index 58891aa54b76..f63b3ca3fd44 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -105,6 +105,27 @@ typedef struct SaveVMHandlers {
      */
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
 
+    /**
+     * @save_live_complete_precopy_thread (invoked in a separate thread)
+     *
+     * Called at the end of a precopy phase from a separate worker thread
+     * in configurations where multifd device state transfer is supported
+     * in order to perform asynchronous transmission of the remaining data in
+     * parallel with @save_live_complete_precopy handlers.
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
index fd23ff7771b1..76578dee8fd3 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -133,5 +133,9 @@ typedef struct IRQState *qemu_irq;
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
 typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
                                     Error **errp);
+typedef int (*SaveLiveCompletePrecopyThreadHandler)(char *idstr,
+                                                    uint32_t instance_id,
+                                                    bool *abort_flag,
+                                                    void *opaque);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index cee3c44bcf2a..fb09e6a48df9 100644
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
 
+static ThreadPool *send_threads;
+static int send_threads_ret;
+static bool send_threads_abort;
+
 static MultiFDSendData *device_state_send;
 
 void multifd_device_state_send_setup(void)
@@ -23,10 +28,16 @@ void multifd_device_state_send_setup(void)
 
     assert(!device_state_send);
     device_state_send = multifd_send_data_alloc();
+
+    assert(!send_threads);
+    send_threads = thread_pool_new();
+    send_threads_ret = 0;
+    send_threads_abort = false;
 }
 
 void multifd_device_state_send_cleanup(void)
 {
+    g_clear_pointer(&send_threads, thread_pool_free);
     g_clear_pointer(&device_state_send, multifd_send_data_free);
 
     qemu_mutex_destroy(&queue_job_mutex);
@@ -107,3 +118,75 @@ bool multifd_device_state_supported(void)
     return migrate_multifd() && !migrate_mapped_ram() &&
         migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
 }
+
+struct MultiFDDSSaveThreadData {
+    SaveLiveCompletePrecopyThreadHandler hdlr;
+    char *idstr;
+    uint32_t instance_id;
+    void *handler_opaque;
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
+    int ret;
+
+    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
+                     data->handler_opaque);
+    if (ret && !qatomic_read(&send_threads_ret)) {
+        /*
+         * Racy with the above read but that's okay - which thread error
+         * return we report is purely arbitrary anyway.
+         */
+        qatomic_set(&send_threads_ret, ret);
+    }
+
+    return 0;
+}
+
+void
+multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+                                       char *idstr, uint32_t instance_id,
+                                       void *opaque)
+{
+    struct MultiFDDSSaveThreadData *data;
+
+    assert(multifd_device_state_supported());
+
+    assert(!qatomic_read(&send_threads_abort));
+
+    data = g_new(struct MultiFDDSSaveThreadData, 1);
+    data->hdlr = hdlr;
+    data->idstr = g_strdup(idstr);
+    data->instance_id = instance_id;
+    data->handler_opaque = opaque;
+
+    thread_pool_submit_immediate(send_threads,
+                                 multifd_device_state_save_thread,
+                                 data,
+                                 multifd_device_state_save_thread_data_free);
+}
+
+void multifd_abort_device_state_save_threads(void)
+{
+    assert(multifd_device_state_supported());
+
+    qatomic_set(&send_threads_abort, true);
+}
+
+int multifd_join_device_state_save_threads(void)
+{
+    assert(multifd_device_state_supported());
+
+    thread_pool_wait(send_threads);
+
+    return send_threads_ret;
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index 74d1960de3c6..e47c6c92fe50 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -37,6 +37,7 @@
 #include "migration/register.h"
 #include "migration/global_state.h"
 #include "migration/channel-block.h"
+#include "multifd.h"
 #include "ram.h"
 #include "qemu-file.h"
 #include "savevm.h"
@@ -1521,6 +1522,24 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
     int ret;
+    bool multifd_device_state = multifd_device_state_supported();
+
+    if (multifd_device_state) {
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
+        }
+    }
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
@@ -1546,16 +1565,32 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
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

