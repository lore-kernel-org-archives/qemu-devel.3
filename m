Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8428C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Q2-0005c0-E7; Tue, 27 Aug 2024 13:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Q1-0005X3-Au
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:49 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pz-0001bG-Kb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:49 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pn-0002NS-G0; Tue, 27 Aug 2024 19:55:35 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 08/17] migration: Add load_finish handler and associated
 functions
Date: Tue, 27 Aug 2024 19:54:27 +0200
Message-ID: <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
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

load_finish SaveVMHandler allows migration code to poll whether
a device-specific asynchronous device state loading operation had finished.

In order to avoid calling this handler needlessly the device is supposed
to notify the migration code of its possible readiness via a call to
qemu_loadvm_load_finish_ready_broadcast() while holding
qemu_loadvm_load_finish_ready_lock.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 21 +++++++++++++++
 migration/migration.c        |  6 +++++
 migration/migration.h        |  3 +++
 migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
 migration/savevm.h           |  4 +++
 5 files changed, 86 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 4a578f140713..44d8cf5192ae 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
     int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
                              Error **errp);
 
+    /**
+     * @load_finish
+     *
+     * Poll whether all asynchronous device state loading had finished.
+     * Not called on the load failure path.
+     *
+     * Called while holding the qemu_loadvm_load_finish_ready_lock.
+     *
+     * If this method signals "not ready" then it might not be called
+     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
+     * while holding qemu_loadvm_load_finish_ready_lock.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @is_finished: whether the loading had finished (output parameter)
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
+     * It's not an error that the loading still hasn't finished.
+     */
+    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
+
     /**
      * @load_setup
      *
diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d57732..d61e7b055e07 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -259,6 +259,9 @@ void migration_object_init(void)
 
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
+    qemu_mutex_init(&current_incoming->load_finish_ready_mutex);
+    qemu_cond_init(&current_incoming->load_finish_ready_cond);
+
     migration_object_check(current_migration, &error_fatal);
 
     ram_mig_init();
@@ -410,6 +413,9 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_qemufile_dst = NULL;
     }
 
+    qemu_mutex_destroy(&mis->load_finish_ready_mutex);
+    qemu_cond_destroy(&mis->load_finish_ready_cond);
+
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
diff --git a/migration/migration.h b/migration/migration.h
index 38aa1402d516..4e2443e6c8ec 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -230,6 +230,9 @@ struct MigrationIncomingState {
 
     /* Do exit on incoming migration failure */
     bool exit_on_error;
+
+    QemuCond load_finish_ready_cond;
+    QemuMutex load_finish_ready_mutex;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 3fde5ca8c26b..33c9200d1e78 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3022,6 +3022,37 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
+    qemu_loadvm_load_finish_ready_lock();
+    while (!ret) { /* Don't call load_finish() handlers on the load failure path */
+        bool all_ready = true;
+        SaveStateEntry *se = NULL;
+
+        QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+            bool this_ready;
+
+            if (!se->ops || !se->ops->load_finish) {
+                continue;
+            }
+
+            ret = se->ops->load_finish(se->opaque, &this_ready, &local_err);
+            if (ret) {
+                error_report_err(local_err);
+
+                qemu_loadvm_load_finish_ready_unlock();
+                return -EINVAL;
+            } else if (!this_ready) {
+                all_ready = false;
+            }
+        }
+
+        if (all_ready) {
+            break;
+        }
+
+        qemu_cond_wait(&mis->load_finish_ready_cond, &mis->load_finish_ready_mutex);
+    }
+    qemu_loadvm_load_finish_ready_unlock();
+
     if (ret == 0) {
         ret = qemu_file_get_error(f);
     }
@@ -3126,6 +3157,27 @@ int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
     return 0;
 }
 
+void qemu_loadvm_load_finish_ready_lock(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    qemu_mutex_lock(&mis->load_finish_ready_mutex);
+}
+
+void qemu_loadvm_load_finish_ready_unlock(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    qemu_mutex_unlock(&mis->load_finish_ready_mutex);
+}
+
+void qemu_loadvm_load_finish_ready_broadcast(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    qemu_cond_broadcast(&mis->load_finish_ready_cond);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index d388f1bfca98..69ae22cded7a 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -73,4 +73,8 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                   char *buf, size_t len, Error **errp);
 
+void qemu_loadvm_load_finish_ready_lock(void);
+void qemu_loadvm_load_finish_ready_unlock(void);
+void qemu_loadvm_load_finish_ready_broadcast(void);
+
 #endif

