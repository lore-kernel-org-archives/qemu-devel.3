Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055E9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC2K-0001wv-TJ; Thu, 06 Mar 2025 09:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC12-0008JR-6a
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0z-0001tM-Qc
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7lprOMmLSeSMFwax8dV7y5sGDyWfHydF1R9GGLiQ90=;
 b=FkstkCDvB58BSangxzIiIyeEx/wAuEoLTpChakgQrXgCO7kToOHUY3i2B0ONqZLAlc9LhD
 dYj59vtZbtUm4NxDmzNFNUsYkbzls8YspELSWcJjmJ/IDNLccCDzUjYQvKDpRO17RyGHY1
 lCtYV5ztkNYZMf6EXvO/u5NuRk0XFjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-ID13grh_Oyue_d_OYy_96A-1; Thu,
 06 Mar 2025 09:15:47 -0500
X-MC-Unique: ID13grh_Oyue_d_OYy_96A-1
X-Mimecast-MFC-AGG-ID: ID13grh_Oyue_d_OYy_96A_1741270547
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12110180025B; Thu,  6 Mar 2025 14:15:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93F261801748; Thu,  6 Mar 2025 14:15:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/42] migration: Add save_live_complete_precopy_thread handler
Date: Thu,  6 Mar 2025 15:14:02 +0100
Message-ID: <20250306141419.2015340-27-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This SaveVMHandler helps device provide its own asynchronous transmission
of the remaining data at the end of a precopy phase via multifd channels,
in parallel with the transfer done by save_live_complete_precopy handlers.

These threads are launched only when multifd device state transfer is
supported.

Management of these threads in done in the multifd migration code,
wrapping them in the generic thread pool.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/eac74a4ca7edd8968bbf72aa07b9041c76364a16.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/misc.h         | 17 ++++++
 include/migration/register.h     | 19 +++++++
 include/qemu/typedefs.h          |  3 ++
 migration/multifd-device-state.c | 92 ++++++++++++++++++++++++++++++++
 migration/savevm.c               | 40 +++++++++++++-
 5 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 273ebfca6256265507cd6aa28a104a3db1ac106b..8fd36eba1da72004bbc01cf18043180b21e10e41 100644
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
index 58891aa54b76cccdea9e442be9bf528a41593e26..c041ce32f2fcf0e0a102ee5a5d69ec0a84c5feac 100644
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
index fd23ff7771b1bd6cd51f48bbc5be86aa57982307..42ed4e6be150acc39c842e1158cb87f3a8f5662d 100644
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
index 3097ffa31025971bb9b893c53dad352d517148d9..94222d0eb0d8f4dd0de0f5e5d6d742e9b3b6edf5 100644
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
index 1abc365570e324dd85f8a95adeb1a95f57b73264..5c4fdfd95eebf8d52fa02f2343090e4bac6c2d73 100644
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
-- 
2.48.1


