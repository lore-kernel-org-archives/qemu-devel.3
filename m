Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C0BC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzJt-0004Cf-ET; Fri, 28 Feb 2025 07:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJo-0004Bu-6G
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJl-0001GL-O8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQGZ+HC/OVwWaheXEX5ZIeSt5B4zBEPgqTFgyQhqQ+I=;
 b=RRAJTvPOFFGJGB6LDO58Uwmt9FVaaO7LSQyLxjbEHdkqI0y/nd9NwxgN1b555fluBKu7m5
 qON0eAiTEathaBWcCRmL9BKiye+jNo9IEjaPWa1fZrRoBws3czI6PUOlOOBNHGYttVhthM
 49mq4zlY1tjscPsJyL1isQaW/9uJGso=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-1AWUMTiVNVac5MlXsAqvsA-1; Fri,
 28 Feb 2025 07:18:11 -0500
X-MC-Unique: 1AWUMTiVNVac5MlXsAqvsA-1
X-Mimecast-MFC-AGG-ID: 1AWUMTiVNVac5MlXsAqvsA_1740745090
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79A6919540EE; Fri, 28 Feb 2025 12:18:10 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.175])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF60E180087F; Fri, 28 Feb 2025 12:18:06 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v7 2/5] migration: enable multifd and postcopy together
Date: Fri, 28 Feb 2025 17:47:46 +0530
Message-ID: <20250228121749.553184-3-ppandit@redhat.com>
In-Reply-To: <20250228121749.553184-1-ppandit@redhat.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Enable Multifd and Postcopy migration together.
The migration_ioc_process_incoming() routine
checks magic value sent on each channel and
helps to properly setup multifd and postcopy
channels.

The Precopy and Multifd threads work during the
initial guest RAM transfer. When migration moves
to the Postcopy phase, the multifd threads are
shutdown and Postcopy threads on the destination
request/pull data from the source side.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/migration.c      | 133 +++++++++++++++++++++----------------
 migration/multifd-nocomp.c |   3 +-
 migration/multifd.c        |  11 ++-
 migration/options.c        |   5 --
 migration/ram.c            |   7 +-
 5 files changed, 89 insertions(+), 70 deletions(-)

v6: update channel discovery part in migration_ioc_process_incoming()
- https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t

diff --git a/migration/migration.c b/migration/migration.c
index c597aa707e..5db9e18272 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -95,6 +95,9 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
+/* Migration channel types */
+enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
+
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -947,28 +950,19 @@ void migration_fd_process_incoming(QEMUFile *f)
     migration_incoming_process();
 }
 
-/*
- * Returns true when we want to start a new incoming migration process,
- * false otherwise.
- */
-static bool migration_should_start_incoming(bool main_channel)
+static bool migration_has_main_and_multifd_channels(void)
 {
-    /* Multifd doesn't start unless all channels are established */
-    if (migrate_multifd()) {
-        return migration_has_all_channels();
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    if (!mis->from_src_file) {
+        /* main channel not established */
+        return false;
     }
 
-    /* Preempt channel only starts when the main channel is created */
-    if (migrate_postcopy_preempt()) {
-        return main_channel;
+    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
+        return false;
     }
 
-    /*
-     * For all the rest types of migration, we should only reach here when
-     * it's the main channel that's being created, and we should always
-     * proceed with this channel.
-     */
-    assert(main_channel);
+    /* main channel and all multifd channels are established */
     return true;
 }
 
@@ -977,59 +971,84 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
     QEMUFile *f;
-    bool default_channel = true;
+    uint8_t channel;
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_mapped_ram() &&
-        !migrate_postcopy_ram() &&
-        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
-        /*
-         * With multiple channels, it is possible that we receive channels
-         * out of order on destination side, causing incorrect mapping of
-         * source channels on destination side. Check channel MAGIC to
-         * decide type of channel. Please note this is best effort, postcopy
-         * preempt channel does not send any magic number so avoid it for
-         * postcopy live migration. Also tls live migration already does
-         * tls handshake while initializing main channel so with tls this
-         * issue is not possible.
-         */
-        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), errp);
+    if (!migration_has_main_and_multifd_channels()) {
+        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+            /*
+             * With multiple channels, it is possible that we receive channels
+             * out of order on destination side, causing incorrect mapping of
+             * source channels on destination side. Check channel MAGIC to
+             * decide type of channel. Please note this is best effort,
+             * postcopy preempt channel does not send any magic number so
+             * avoid it for postcopy live migration. Also tls live migration
+             * already does tls handshake while initializing main channel so
+             * with tls this issue is not possible.
+             */
+            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
+                                              sizeof(channel_magic), errp);
+            if (ret != 0) {
+                return;
+            }
 
-        if (ret != 0) {
+            channel_magic = be32_to_cpu(channel_magic);
+            if (channel_magic == QEMU_VM_FILE_MAGIC) {
+                channel = CH_MAIN;
+            } else if (channel_magic == MULTIFD_MAGIC) {
+                channel = CH_MULTIFD;
+            } else if (!mis->from_src_file &&
+                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+                /* reconnect main channel for postcopy recovery */
+                channel = CH_MAIN;
+            } else {
+                error_setg(errp, "unknown channel magic: %u", channel_magic);
+                return;
+            }
+        } else if (mis->from_src_file && migrate_multifd()) {
+            /*
+             * Non-peekable channels like tls/file are processed as
+             * multifd channels when multifd is enabled.
+             */
+            channel = CH_MULTIFD;
+        } else if (!mis->from_src_file) {
+            channel = CH_MAIN;
+        } else {
+            error_setg(errp, "non-peekable channel used without multifd");
             return;
         }
-
-        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
+    } else if (mis->from_src_file) {
+        channel = CH_POSTCOPY;
     } else {
-        default_channel = !mis->from_src_file;
+        channel = CH_MAIN;
     }
 
     if (multifd_recv_setup(errp) != 0) {
         return;
     }
 
-    if (default_channel) {
+    if (channel == CH_MAIN) {
         f = qemu_file_new_input(ioc);
         migration_incoming_setup(f);
-    } else {
+    } else if (channel == CH_MULTIFD) {
         /* Multiple connections */
-        assert(migration_needs_multiple_sockets());
         if (migrate_multifd()) {
             multifd_recv_new_channel(ioc, &local_err);
-        } else {
-            assert(migrate_postcopy_preempt());
-            f = qemu_file_new_input(ioc);
-            postcopy_preempt_new_channel(mis, f);
         }
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (channel == CH_POSTCOPY) {
+        assert(migrate_postcopy_preempt());
+        assert(!mis->postcopy_qemufile_dst);
+        f = qemu_file_new_input(ioc);
+        postcopy_preempt_new_channel(mis, f);
+        return;
     }
 
-    if (migration_should_start_incoming(default_channel)) {
+    if (migration_has_main_and_multifd_channels()) {
         /* If it's a recovery, we're done */
         if (postcopy_try_recover()) {
             return;
@@ -1046,20 +1065,15 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
  */
 bool migration_has_all_channels(void)
 {
+    if (!migration_has_main_and_multifd_channels()) {
+        return false;
+    }
+
     MigrationIncomingState *mis = migration_incoming_get_current();
-
-    if (!mis->from_src_file) {
+    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
         return false;
     }
 
-    if (migrate_multifd()) {
-        return multifd_recv_all_channels_created();
-    }
-
-    if (migrate_postcopy_preempt()) {
-        return mis->postcopy_qemufile_dst != NULL;
-    }
-
     return true;
 }
 
@@ -1470,6 +1484,8 @@ static void migration_cleanup(MigrationState *s)
 
     assert(!migration_is_active());
 
+    file_cleanup_outgoing_migration();
+    socket_cleanup_outgoing_migration();
     if (s->state == MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                           MIGRATION_STATUS_CANCELLED);
@@ -3382,8 +3398,11 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     }
 
     /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
-        qatomic_read(&s->start_postcopy)) {
+    if (!in_postcopy && must_precopy <= s->threshold_size
+        && can_switchover && qatomic_read(&s->start_postcopy)) {
+        if (migrate_multifd()) {
+            multifd_send_shutdown();
+        }
         if (postcopy_start(s, &local_err)) {
             migrate_set_error(s, local_err);
             error_report_err(local_err);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 1325dba97c..d0edec7cd1 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -16,6 +16,7 @@
 #include "file.h"
 #include "multifd.h"
 #include "options.h"
+#include "migration.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -391,7 +392,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
     MultiFDSyncReq req;
     int ret;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || migration_in_postcopy()) {
         return 0;
     }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 30e514785f..2bd8604ca1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -467,8 +467,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 
 static void multifd_send_cleanup_state(void)
 {
-    file_cleanup_outgoing_migration();
-    socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
@@ -481,7 +479,7 @@ void multifd_send_shutdown(void)
 {
     int i;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || !multifd_send_state) {
         return;
     }
 
@@ -1231,6 +1229,13 @@ static void *multifd_recv_thread(void *opaque)
         }
 
         if (has_data) {
+            /*
+             * multifd thread should not be active and receive data
+             * when migration is in the Postcopy phase. Two threads
+             * writing the same memory area could easily corrupt
+             * the guest state.
+             */
+            assert(!migration_in_postcopy());
             ret = multifd_recv_state->ops->recv(p, &local_err);
             if (ret != 0) {
                 break;
diff --git a/migration/options.c b/migration/options.c
index bb259d192a..5d56591f9e 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -482,11 +482,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             error_setg(errp, "Postcopy is not compatible with ignore-shared");
             return false;
         }
-
-        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-            error_setg(errp, "Postcopy is not yet compatible with multifd");
-            return false;
-        }
     }
 
     if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
diff --git a/migration/ram.c b/migration/ram.c
index 589b6505eb..2d8e593c90 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1297,7 +1297,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (multifd_ram_sync_per_round()) {
+            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
@@ -1971,9 +1971,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         }
     }
 
-    if (migrate_multifd()) {
-        RAMBlock *block = pss->block;
-        return ram_save_multifd_page(block, offset);
+    if (migrate_multifd() && !migration_in_postcopy()) {
+        return ram_save_multifd_page(pss->block, offset);
     }
 
     if (control_save_page(pss, offset, &res)) {
-- 
2.48.1


