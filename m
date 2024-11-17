Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC223D10F28
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqJ-0002ij-UD; Sun, 17 Nov 2024 14:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqJ-0002iZ-5S
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:55 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqH-0005tl-IQ
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:54 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqD-00000002GU4-40YE; Sun, 17 Nov 2024 20:21:49 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 08/24] migration: Add thread pool of optional load threads
Date: Sun, 17 Nov 2024 20:20:03 +0100
Message-ID: <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
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

Some drivers might want to make use of auxiliary helper threads during VM
state loading, for example to make sure that their blocking (sync) I/O
operations don't block the rest of the migration process.

Add a migration core managed thread pool to facilitate this use case.

The migration core will wait for these threads to finish before
(re)starting the VM at destination.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/misc.h |  3 ++
 include/qemu/typedefs.h  |  1 +
 migration/savevm.c       | 77 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23c0607..c92ca018ab3b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
 /* migration/block.c */
 
 AnnounceParameters *migrate_announce_params(void);
+
 /* migration/savevm.c */
 
 void dump_vmstate_json_to_file(FILE *out_fp);
+void qemu_loadvm_start_load_thread(MigrationLoadThread function,
+                                   void *opaque);
 
 /* migration/migration.c */
 void migration_object_init(void);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3d84efcac47a..8c8ea5c2840d 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
  * Function types
  */
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/migration/savevm.c b/migration/savevm.c
index 1f58a2fa54ae..6ea9054c4083 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,7 @@
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "block/snapshot.h"
+#include "block/thread-pool.h"
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
@@ -71,6 +72,10 @@
 
 const unsigned int postcopy_ram_discard_version;
 
+static ThreadPool *load_threads;
+static int load_threads_ret;
+static bool load_threads_abort;
+
 /* Subcommands for QEMU_VM_COMMAND */
 enum qemu_vm_cmd {
     MIG_CMD_INVALID = 0,   /* Must be 0 */
@@ -2788,6 +2793,12 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
     int ret;
 
     trace_loadvm_state_setup();
+
+    assert(!load_threads);
+    load_threads = thread_pool_new();
+    load_threads_ret = 0;
+    load_threads_abort = false;
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->load_setup) {
             continue;
@@ -2806,19 +2817,72 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
             return ret;
         }
     }
+
+    return 0;
+}
+
+struct LoadThreadData {
+    MigrationLoadThread function;
+    void *opaque;
+};
+
+static int qemu_loadvm_load_thread(void *thread_opaque)
+{
+    struct LoadThreadData *data = thread_opaque;
+    int ret;
+
+    ret = data->function(&load_threads_abort, data->opaque);
+    if (ret && !qatomic_read(&load_threads_ret)) {
+        /*
+         * Racy with the above read but that's okay - which thread error
+         * return we report is purely arbitrary anyway.
+         */
+        qatomic_set(&load_threads_ret, ret);
+    }
+
     return 0;
 }
 
+void qemu_loadvm_start_load_thread(MigrationLoadThread function,
+                                   void *opaque)
+{
+    struct LoadThreadData *data;
+
+    /* We only set it from this thread so it's okay to read it directly */
+    assert(!load_threads_abort);
+
+    data = g_new(struct LoadThreadData, 1);
+    data->function = function;
+    data->opaque = opaque;
+
+    thread_pool_submit(load_threads, qemu_loadvm_load_thread,
+                       data, g_free);
+    thread_pool_adjust_max_threads_to_work(load_threads);
+}
+
 void qemu_loadvm_state_cleanup(void)
 {
     SaveStateEntry *se;
 
     trace_loadvm_state_cleanup();
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->ops && se->ops->load_cleanup) {
             se->ops->load_cleanup(se->opaque);
         }
     }
+
+    /*
+     * We might be called even without earlier qemu_loadvm_state_setup()
+     * call if qemu_loadvm_state() fails very early.
+     */
+    if (load_threads) {
+        qatomic_set(&load_threads_abort, true);
+        bql_unlock(); /* Load threads might be waiting for BQL */
+        thread_pool_wait(load_threads);
+        bql_lock();
+        g_clear_pointer(&load_threads, thread_pool_free);
+    }
 }
 
 /* Return true if we should continue the migration, or false. */
@@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
         return ret;
     }
 
+    if (ret == 0) {
+        bql_unlock(); /* Let load threads do work requiring BQL */
+        thread_pool_wait(load_threads);
+        bql_lock();
+
+        ret = load_threads_ret;
+    }
+    /*
+     * Set this flag unconditionally so we'll catch further attempts to
+     * start additional threads via an appropriate assert()
+     */
+    qatomic_set(&load_threads_abort, true);
+
     if (ret == 0) {
         ret = qemu_file_get_error(f);
     }

