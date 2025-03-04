Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A761C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaPG-0002II-Fj; Tue, 04 Mar 2025 17:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaP7-0001nm-GE
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:24 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaP4-0001Ip-Es
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:20 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaP0-00000000LZA-1siR; Tue, 04 Mar 2025 23:06:14 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 17/36] migration: Add save_live_complete_precopy_thread
 handler
Date: Tue,  4 Mar 2025 23:03:44 +0100
Message-ID: <eac74a4ca7edd8968bbf72aa07b9041c76364a16.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 include/migration/misc.h         | 17 ++++++
 include/migration/register.h     | 19 +++++++
 include/qemu/typedefs.h          |  3 ++
 migration/multifd-device-state.c | 92 ++++++++++++++++++++++++++++++++
 migration/savevm.c               | 40 +++++++++++++-
 5 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 273ebfca6256..8fd36eba1da7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -119,8 +119,25 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
                        Error **errp);
 
 /* migration/multifd-device-state.c */
+typedef struct SaveLiveCompletePrecopyThreadData {
+    SaveLiveCompletePrecopyThreadHandler hdlr;
+    char *idstr;
+    uint32_t instance_id;
+    void *handler_opaque;
+} SaveLiveCompletePrecopyThreadData;
+
 bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
                                 char *data, size_t len);
 bool multifd_device_state_supported(void);
 
+void
+multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+                                       char *idstr, uint32_t instance_id,
+                                       void *opaque);
+
+bool multifd_device_state_save_thread_should_exit(void);
+
+void multifd_abort_device_state_save_threads(void);
+bool multifd_join_device_state_save_threads(void);
+
 #endif
diff --git a/include/migration/register.h b/include/migration/register.h
index 58891aa54b76..c041ce32f2fc 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -105,6 +105,25 @@ typedef struct SaveVMHandlers {
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
+     * @d: a #SaveLiveCompletePrecopyThreadData containing parameters that the
+     * handler may need, including this device section idstr and instance_id,
+     * and opaque data pointer passed to register_savevm_live().
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for errors.
+     */
+    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
+
     /* This runs both outside and inside the BQL.  */
 
     /**
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index fd23ff7771b1..42ed4e6be150 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -108,6 +108,7 @@ typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct ReservedRegion ReservedRegion;
+typedef struct SaveLiveCompletePrecopyThreadData SaveLiveCompletePrecopyThreadData;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct TCGCPUOps TCGCPUOps;
@@ -133,5 +134,7 @@ typedef struct IRQState *qemu_irq;
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
 typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
                                     Error **errp);
+typedef bool (*SaveLiveCompletePrecopyThreadHandler)(SaveLiveCompletePrecopyThreadData *d,
+                                                     Error **errp);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 3097ffa31025..94222d0eb0d8 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -10,7 +10,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/lockable.h"
+#include "block/thread-pool.h"
+#include "migration.h"
 #include "migration/misc.h"
 #include "multifd.h"
 #include "options.h"
@@ -19,6 +22,9 @@ static struct {
     QemuMutex queue_job_mutex;
 
     MultiFDSendData *send_data;
+
+    ThreadPool *threads;
+    bool threads_abort;
 } *multifd_send_device_state;
 
 void multifd_device_state_send_setup(void)
@@ -29,10 +35,14 @@ void multifd_device_state_send_setup(void)
     qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
 
     multifd_send_device_state->send_data = multifd_send_data_alloc();
+
+    multifd_send_device_state->threads = thread_pool_new();
+    multifd_send_device_state->threads_abort = false;
 }
 
 void multifd_device_state_send_cleanup(void)
 {
+    g_clear_pointer(&multifd_send_device_state->threads, thread_pool_free);
     g_clear_pointer(&multifd_send_device_state->send_data,
                     multifd_send_data_free);
 
@@ -118,3 +128,85 @@ bool multifd_device_state_supported(void)
     return migrate_multifd() && !migrate_mapped_ram() &&
         migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
 }
+
+static void multifd_device_state_save_thread_data_free(void *opaque)
+{
+    SaveLiveCompletePrecopyThreadData *data = opaque;
+
+    g_clear_pointer(&data->idstr, g_free);
+    g_free(data);
+}
+
+static int multifd_device_state_save_thread(void *opaque)
+{
+    SaveLiveCompletePrecopyThreadData *data = opaque;
+    g_autoptr(Error) local_err = NULL;
+
+    if (!data->hdlr(data, &local_err)) {
+        MigrationState *s = migrate_get_current();
+
+        /*
+         * Can't call abort_device_state_save_threads() here since new
+         * save threads could still be in process of being launched
+         * (if, for example, the very first save thread launched exited
+         * with an error very quickly).
+         */
+
+        assert(local_err);
+
+        /*
+         * In case of multiple save threads failing which thread error
+         * return we end setting is purely arbitrary.
+         */
+        migrate_set_error(s, local_err);
+    }
+
+    return 0;
+}
+
+bool multifd_device_state_save_thread_should_exit(void)
+{
+    return qatomic_read(&multifd_send_device_state->threads_abort);
+}
+
+void
+multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
+                                       char *idstr, uint32_t instance_id,
+                                       void *opaque)
+{
+    SaveLiveCompletePrecopyThreadData *data;
+
+    assert(multifd_device_state_supported());
+    assert(multifd_send_device_state);
+
+    assert(!qatomic_read(&multifd_send_device_state->threads_abort));
+
+    data = g_new(SaveLiveCompletePrecopyThreadData, 1);
+    data->hdlr = hdlr;
+    data->idstr = g_strdup(idstr);
+    data->instance_id = instance_id;
+    data->handler_opaque = opaque;
+
+    thread_pool_submit_immediate(multifd_send_device_state->threads,
+                                 multifd_device_state_save_thread,
+                                 data,
+                                 multifd_device_state_save_thread_data_free);
+}
+
+void multifd_abort_device_state_save_threads(void)
+{
+    assert(multifd_device_state_supported());
+
+    qatomic_set(&multifd_send_device_state->threads_abort, true);
+}
+
+bool multifd_join_device_state_save_threads(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    assert(multifd_device_state_supported());
+
+    thread_pool_wait(multifd_send_device_state->threads);
+
+    return !migrate_has_error(s);
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index 1abc365570e3..5c4fdfd95eeb 100644
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
@@ -1527,6 +1528,24 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
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
@@ -1552,16 +1571,35 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
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
+        if (migrate_has_error(migrate_get_current())) {
+            multifd_abort_device_state_save_threads();
+        }
+
+        if (!multifd_join_device_state_save_threads()) {
+            qemu_file_set_error(f, -EINVAL);
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

