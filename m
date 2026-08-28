Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DFDC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyzA-0001Ne-Ev; Fri, 28 Aug 2026 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz8-0001N0-7T
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:18 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz0-0008Ga-Cx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DEFD622197;
 Fri, 28 Aug 2026 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBaiBj8RrIFlHoMR68yaE7kUmPAVZMY+pnjc1+jCVHI=;
 b=fLgADZggmyzrxjqWuTHyb0F2CdKp6QoLWYeyTtX1RL9YC9BIE73Em4CY0k2CRQzuoH+mrY
 6JVN9cWpoamKKQO4sWX6e4whttLX+vTzcWDcnYqvcdFNz6Sa62LR5VnSliwpWDUUEC70Wr
 WoP3q0Zv7zg/q4ebAXWNGsNUtF3LE9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBaiBj8RrIFlHoMR68yaE7kUmPAVZMY+pnjc1+jCVHI=;
 b=MPxxjW+UkoakReg90i/bvyYjqro48/isRCmWlBN6W6YqKZQnMHuAgGLKXvjJ5TvC40it7S
 oxJsfn3sXRdvUhDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBaiBj8RrIFlHoMR68yaE7kUmPAVZMY+pnjc1+jCVHI=;
 b=gcRUtD8d/iFF/zFrjf4i+Pdc1MuPswYntPUiqsXqzt6lsjJmeyz4fXu+CIrox4MxNkVCGd
 sriZlSmNVfwSJ9S48mELok63q4LtPBUjWUGuLGvE2GOd2+FbUS+/VEOhH5QfF5sITcBBCf
 jhKCwL4r+tmyKmQECLD6JzqoHlembp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBaiBj8RrIFlHoMR68yaE7kUmPAVZMY+pnjc1+jCVHI=;
 b=L1jMonTPrzrLC+wz4qvoevjMVPPF8w28PuAyjjuhgsikWcRuhJLJdxLxdDnVw0YSVMRg7l
 IasmcoUIaff8QdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A897C13674;
 Fri, 28 Aug 2026 15:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eGoxHkOwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:58:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL v2 08/30] migration: add eager load thread and setup for fast
 snapshot load
Date: Fri, 28 Aug 2026 12:58:23 -0300
Message-ID: <20260828155845.2874508-9-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aadeshveer Singh <aadeshveer07@gmail.com>

In fast snapshot load a thread is needed for actively loading in pages
along with the fault path so that the guest is not dependent on fault
thread indefinitely. Considering the difference from usual network
postcopy where major chunk of RAM is already loaded here entire RAM
needs to be loaded later. Existance of background pages which are not
really accessed by the guest might never be loaded and system will be
locked in migration for indefinite time. As there should be no
assumption about how guest accesses memory, the load times can be
indefinite.

Add postcopy_ram_eager_load_thread(), for the eager thread which
iterates over all non ignored blocks calling ram_block_load_eager()
on each. ram_block_load_eager then iterates to load in all pages using
postcopy_mapped_ram_load_page(), with a different channel, which takes
care of not loading in pages already loaded by fault thread. On
completion the thread schedules postcopy_incoming_complete_bh() to
destroy the incoming migration state.

Add postcopy_ram_eager_load_setup() to create the thread. Added joining
logic in postcopy_incoming_cleanup().

Add tracepoints for entry and exit to eager load thread.

When both mapped-ram and postcopy-ram are set, divert from
qemu_loadvm_state to run fast snapshot load

Initialize postcopy RAM state and register RAM Blocks with userfaultfd
via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup() in
process_incoming_migration_co(). Fault thread needs to be launched
before VM to serve faults for some hardwares emulation that need to read
RAM (like vapic devices). Populate bitmaps and offset tables while
reading file in qemu_loadvm_state_main.

Add function qemu_loadvm_run_fast_snapshot_load() which starts the VM
using loadvm_postcopy_handle_run_bh() and launches eager load thread.

Skip scheduling process_incoming_migration_bh() in
process_incoming_migration_co(), for fast snapshot load as the state
cleanup is managed by eager load thread on completion.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c    | 36 +++++++++++++++++--
 migration/migration.h    |  5 +++
 migration/postcopy-ram.c | 76 ++++++++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.h |  2 ++
 migration/savevm.c       | 16 +++++++++
 migration/savevm.h       |  2 ++
 migration/trace-events   |  2 ++
 7 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a30779f37c8..59cdc1a169f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -710,6 +710,11 @@ static void process_incoming_migration_bh(void *opaque)
     migration_incoming_state_destroy();
 }
 
+static bool migration_incoming_has_postcopy_thread(MigrationIncomingState *mis)
+{
+    return mis->have_listen_thread || mis->have_eager_load_thread;
+}
+
 static void coroutine_fn
 process_incoming_migration_co(void *opaque)
 {
@@ -739,17 +744,44 @@ process_incoming_migration_co(void *opaque)
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
+    /*
+     * When loading snapshot with postcopy enabled, setup the postcopy
+     * infrastructure before loading the major part of device states.
+     * It's required because qemu_loadvm_state() may access guest memory
+     * while loading device states, which can cause page faults already.
+     */
+    if (migrate_postcopy_ram() && migrate_mapped_ram()) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_POSTCOPY_DEVICE);
+
+        if (ram_postcopy_incoming_init(mis, &local_err)) {
+            goto fail;
+        }
+
+        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
+        if (postcopy_ram_incoming_setup(mis, &local_err)) {
+            goto fail;
+        }
+    }
+
     mis->loadvm_co = qemu_coroutine_self();
     ret = qemu_loadvm_state(mis->from_src_file, &local_err);
     mis->loadvm_co = NULL;
+    if (ret < 0) {
+        goto fail;
+    }
+
+    if (migrate_postcopy_ram() && migrate_mapped_ram()) {
+        qemu_loadvm_run_fast_snapshot_load(mis->from_src_file, mis);
+    }
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
 
     trace_process_incoming_migration_co_end(ret);
-    if (mis->have_listen_thread) {
+    if (migration_incoming_has_postcopy_thread(mis)) {
         /*
          * Postcopy was started, cleanup should happen at the end of the
-         * postcopy listen thread.
+         * postcopy listen thread or eager load thread.
          */
         trace_process_incoming_migration_co_postcopy_end_main();
         goto out;
diff --git a/migration/migration.h b/migration/migration.h
index 631421c784b..e47ff4e3d11 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,6 +42,7 @@
 #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
+#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapshot_load"
 
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
@@ -120,6 +121,10 @@ struct MigrationIncomingState {
     bool           have_listen_thread;
     QemuThread     listen_thread;
 
+    /* Thread to load pages eagerly in fast snapshot load case */
+    bool have_eager_load_thread;
+    QemuThread eager_load_thread;
+
     /* For the kernel to send us notifications */
     int       userfault_fd;
     /* To notify the fault_thread to wake, e.g., when need to quit */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 430b5f24e1a..3b66c1f6d42 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -39,6 +39,8 @@
 #include "qemu/mmap-alloc.h"
 #include "options.h"
 
+static void postcopy_incoming_complete_bh(void *opaque);
+
 /* Arbitrary limit on size of each discard command,
  * keeps them around ~200 bytes
  */
@@ -1867,6 +1869,70 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
     }
 }
 
+/*
+ * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
+ * pending pages of given ram block
+ */
+static int ram_block_load_eager(RAMBlock *rb, void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    MigrationState *s = migrate_get_current();
+    Error *errp = NULL;
+    void *host = qemu_ram_get_host_addr(rb);
+    void *target;
+
+    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
+         page_loc += qemu_ram_pagesize(rb)) {
+        target = (uint8_t *)host + page_loc;
+        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
+                                           RAM_CHANNEL_PRECOPY, &errp)) {
+            migrate_error_propagate(s, errp);
+            return -1;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
+ * cleanup after entire RAM is loaded
+ */
+static void *postcopy_ram_eager_load_thread(void *opaque)
+{
+    MigrationIncomingState *mis = opaque;
+    MigrationStatus next_state;
+
+    trace_postcopy_ram_eager_load_thread_entry();
+    rcu_register_thread();
+    qemu_event_set(&mis->thread_sync_event);
+
+    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
+        next_state = MIGRATION_STATUS_FAILED;
+    } else {
+        next_state = MIGRATION_STATUS_COMPLETED;
+    }
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      next_state);
+
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
+
+    rcu_unregister_thread();
+    trace_postcopy_ram_eager_load_thread_exit();
+    return NULL;
+}
+
+/*
+ * Create thread for eager loading in fast snapshot load case
+ */
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
+{
+    postcopy_thread_create(
+        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD,
+        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
+    mis->have_eager_load_thread = true;
+}
+
 #else
 /* No target OS support, stubs just fail */
 void fill_destination_postcopy_migration_info(MigrationInfo *info)
@@ -1937,6 +2003,11 @@ bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
     g_assert_not_reached();
     return false;
 }
+
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
@@ -2410,6 +2481,11 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
         mis->have_listen_thread = false;
     }
 
+    if (mis->have_eager_load_thread) {
+        qemu_thread_join(&mis->eager_load_thread);
+        mis->have_eager_load_thread = false;
+    }
+
     if (migrate_postcopy_ram()) {
         rc = postcopy_ram_incoming_cleanup(mis);
     }
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ea879f0bc6f..c58a60bc8ae 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -205,4 +205,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
 int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
 int postcopy_incoming_cleanup(MigrationIncomingState *mis);
 
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 34dd06f9f73..161a9d090fa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3004,6 +3004,22 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
+/*
+ * Starts the VM and launches the eager thread for fast snapshot load
+ */
+void qemu_loadvm_run_fast_snapshot_load(QEMUFile *f,
+                                        MigrationIncomingState *mis)
+{
+    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
+
+    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
+
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
+    postcopy_ram_eager_load_setup(mis);
+}
+
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index f7dcdd7d1b6..9988dd4b8a4 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -70,6 +70,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
 int qemu_save_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
+void qemu_loadvm_run_fast_snapshot_load(QEMUFile *f,
+                                        MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
diff --git a/migration/trace-events b/migration/trace-events
index af0e7845354..4ae1c226f90 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -315,6 +315,8 @@ postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
 postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
 postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
+postcopy_ram_eager_load_thread_entry(void) ""
+postcopy_ram_eager_load_thread_exit(void) ""
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.53.0


