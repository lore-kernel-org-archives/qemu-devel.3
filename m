Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4CFC79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpwE-0008N3-Qa; Mon, 05 Jan 2026 14:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvq-0007vj-6j
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:58 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvk-0005ZY-Az
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78F0333750;
 Mon,  5 Jan 2026 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmziOtypueCQmAd8eHRTEdVg5MNBrfuKjCAGKpDC4Yw=;
 b=H5qprJ7AuSp13Q47zqhj+NLYqCb8jJ5dXKY6azPrn3Mlow6PTI0y0euvFX0YAuAdCP7tGH
 0EThmzLbyvc2PATWjZzTOkpeWtm9RzEVHAJg94WZNTgo+Pz2U3V4zm5+pG6JsgR3umSJ3P
 0ePEokWzhpfjpTTBZ8NvYfycJAhMf4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmziOtypueCQmAd8eHRTEdVg5MNBrfuKjCAGKpDC4Yw=;
 b=SfgGKTj7zYe6x96lHAh5d2dtEzGE0Cyl1utXG5t2yZQINngYmEcwPg0xh3J956CPdUsmnV
 oeAj4+XlEuRlmYCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmziOtypueCQmAd8eHRTEdVg5MNBrfuKjCAGKpDC4Yw=;
 b=H5qprJ7AuSp13Q47zqhj+NLYqCb8jJ5dXKY6azPrn3Mlow6PTI0y0euvFX0YAuAdCP7tGH
 0EThmzLbyvc2PATWjZzTOkpeWtm9RzEVHAJg94WZNTgo+Pz2U3V4zm5+pG6JsgR3umSJ3P
 0ePEokWzhpfjpTTBZ8NvYfycJAhMf4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmziOtypueCQmAd8eHRTEdVg5MNBrfuKjCAGKpDC4Yw=;
 b=SfgGKTj7zYe6x96lHAh5d2dtEzGE0Cyl1utXG5t2yZQINngYmEcwPg0xh3J956CPdUsmnV
 oeAj4+XlEuRlmYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E835813964;
 Mon,  5 Jan 2026 19:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aJQgKegLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 17/25] migration: Rename instances of start
Date: Mon,  5 Jan 2026 16:06:34 -0300
Message-ID: <20260105190644.14072-18-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

To make it easier to follow the code, rename the functions that start
the migration thread and migration coroutine to contain the word
"start".

This will give new contributors the chance of seeing the word start
and reaching the actual migration code, instead of twists and turns of
qio_channel_add_watch and qio_task_run_in_thread.

Remove all other instances of "start" and use wording more suitable to
what the current migration stage is. The transport code such as
fd_start_migration_outgoing becomes fd_connect_outgoing, the early
setup code such as qemu_start_incoming_migration becomes
qemu_setup_incoming_migration and so on.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c    |  4 ++--
 migration/exec.c       |  5 ++---
 migration/exec.h       |  5 ++---
 migration/fd.c         |  4 ++--
 migration/fd.h         |  6 +++---
 migration/file.c       |  6 +++---
 migration/file.h       |  6 +++---
 migration/migration.c  | 30 +++++++++++++++---------------
 migration/migration.h  |  3 ++-
 migration/rdma.c       | 21 ++++++++++-----------
 migration/rdma.h       |  6 +++---
 migration/socket.c     |  8 +++-----
 migration/socket.h     |  6 +++---
 migration/trace-events | 10 +++++-----
 14 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 94dea03812..8abcb54447 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -48,7 +48,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
         }
 
         if (migration_incoming_setup(ioc, ch, &local_err)) {
-            migration_incoming_process();
+            migration_start_incoming();
         }
     }
 out:
@@ -82,7 +82,7 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
 
     migration_ioc_register_yank(ioc);
     migration_outgoing_setup(ioc);
-    migration_connect(s);
+    migration_start_outgoing(s);
 }
 
 
diff --git a/migration/exec.c b/migration/exec.c
index d1629944dc..c3085e803e 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -40,8 +40,7 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, strList *command,
-                                   Error **errp)
+void exec_connect_outgoing(MigrationState *s, strList *command, Error **errp)
 {
     QIOChannel *ioc = NULL;
     g_auto(GStrv) argv = strv_from_str_list(command);
@@ -68,7 +67,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(strList *command, Error **errp)
+void exec_connect_incoming(strList *command, Error **errp)
 {
     QIOChannel *ioc;
     g_auto(GStrv) argv = strv_from_str_list(command);
diff --git a/migration/exec.h b/migration/exec.h
index 3107f205e3..e7e8e475ac 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -23,8 +23,7 @@
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
-void exec_start_incoming_migration(strList *host_port, Error **errp);
+void exec_connect_incoming(strList *host_port, Error **errp);
 
-void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
-                                   Error **errp);
+void exec_connect_outgoing(MigrationState *s, strList *host_port, Error **errp);
 #endif
diff --git a/migration/fd.c b/migration/fd.c
index 150b236fbf..b689426ad4 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,7 +49,7 @@ static bool migration_fd_valid(int fd)
     return false;
 }
 
-void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
+void fd_connect_outgoing(MigrationState *s, const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
@@ -83,7 +83,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void fd_start_incoming_migration(const char *fdname, Error **errp)
+void fd_connect_incoming(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
     int fd = monitor_fd_param(monitor_cur(), fdname, errp);
diff --git a/migration/fd.h b/migration/fd.h
index b901bc014e..7211629270 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -16,8 +16,8 @@
 
 #ifndef QEMU_MIGRATION_FD_H
 #define QEMU_MIGRATION_FD_H
-void fd_start_incoming_migration(const char *fdname, Error **errp);
+void fd_connect_incoming(const char *fdname, Error **errp);
 
-void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
-                                 Error **errp);
+void fd_connect_outgoing(MigrationState *s, const char *fdname,
+                         Error **errp);
 #endif
diff --git a/migration/file.c b/migration/file.c
index 935402f36b..b7b0fb5194 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -93,8 +93,8 @@ out:
     return ret;
 }
 
-void file_start_outgoing_migration(MigrationState *s,
-                                   FileMigrationArgs *file_args, Error **errp)
+void file_connect_outgoing(MigrationState *s,
+                           FileMigrationArgs *file_args, Error **errp)
 {
     g_autoptr(QIOChannelFile) fioc = NULL;
     g_autofree char *filename = g_strdup(file_args->filename);
@@ -173,7 +173,7 @@ static void file_create_incoming_channels(QIOChannel *ioc, char *filename,
     }
 }
 
-void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
+void file_connect_incoming(FileMigrationArgs *file_args, Error **errp)
 {
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
diff --git a/migration/file.h b/migration/file.h
index 1a1115f7f1..9b1e874bb7 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -13,10 +13,10 @@
 #include "channel.h"
 #include "multifd.h"
 
-void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
+void file_connect_incoming(FileMigrationArgs *file_args, Error **errp);
 
-void file_start_outgoing_migration(MigrationState *s,
-                                   FileMigrationArgs *file_args, Error **errp);
+void file_connect_outgoing(MigrationState *s,
+                           FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 8117c74b52..5f444958ef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -740,7 +740,7 @@ migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
@@ -788,18 +788,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_start_incoming_migration(saddr, errp);
+            socket_connect_incoming(saddr, errp);
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_start_incoming_migration(saddr->u.fd.str, errp);
+            fd_connect_incoming(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&addr->u.rdma, errp);
+        rdma_connect_incoming(&addr->u.rdma, errp);
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(addr->u.exec.args, errp);
+        exec_connect_incoming(addr->u.exec.args, errp);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_start_incoming_migration(&addr->u.file, errp);
+        file_connect_incoming(&addr->u.file, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1008,7 +1008,7 @@ static bool postcopy_try_recover(void)
     return false;
 }
 
-void migration_incoming_process(void)
+void migration_start_incoming(void)
 {
     if (postcopy_try_recover()) {
         return;
@@ -1967,7 +1967,7 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
     mis->exit_on_error =
         has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
 
-    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
+    qemu_setup_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -2014,7 +2014,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, false, NULL, errp);
+    qemu_setup_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -2331,18 +2331,18 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_start_outgoing_migration(s, saddr, &local_err);
+            socket_connect_outgoing(s, saddr, &local_err);
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+            fd_connect_outgoing(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
+        rdma_connect_outgoing(s, &addr->u.rdma, &local_err);
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
+        exec_connect_outgoing(s, addr->u.exec.args, &local_err);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_start_outgoing_migration(s, &addr->u.file, &local_err);
+        file_connect_outgoing(s, &addr->u.file, &local_err);
     } else {
         error_setg(&local_err, "uri is not a valid migration protocol");
     }
@@ -4028,7 +4028,7 @@ fail_setup:
     return NULL;
 }
 
-void migration_connect(MigrationState *s)
+void migration_start_outgoing(MigrationState *s)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
diff --git a/migration/migration.h b/migration/migration.h
index c760349b07..b852464197 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -538,7 +538,8 @@ void migration_connect_error_propagate(MigrationState *s, Error *error);
 void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
 
-void migration_connect(MigrationState *s);
+void migration_start_outgoing(MigrationState *s);
+void migration_start_incoming(void);
 
 int migration_call_notifiers(MigrationEventType type, Error **errp);
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 788ae183c1..ef95ce440d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3882,17 +3882,16 @@ static void rdma_accept_incoming_migration(void *opaque)
 
     rdma->migration_started_on_destination = 1;
     migration_incoming_setup(ioc, CH_MAIN, NULL);
-    migration_incoming_process();
+    migration_start_incoming();
 }
 
-void rdma_start_incoming_migration(InetSocketAddress *host_port,
-                                   Error **errp)
+void rdma_connect_incoming(InetSocketAddress *host_port, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     int ret;
     RDMAContext *rdma;
 
-    trace_rdma_start_incoming_migration();
+    trace_rdma_connect_incoming();
 
     /* Avoid ram_block_discard_disable(), cannot change during migration. */
     if (ram_block_discard_is_required()) {
@@ -3910,7 +3909,7 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port,
         goto err;
     }
 
-    trace_rdma_start_incoming_migration_after_dest_init();
+    trace_rdma_connect_incoming_after_dest_init();
 
     ret = rdma_listen(rdma->listen_id, 5);
 
@@ -3919,7 +3918,7 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port,
         goto cleanup_rdma;
     }
 
-    trace_rdma_start_incoming_migration_after_rdma_listen();
+    trace_rdma_connect_incoming_after_rdma_listen();
     s->rdma_migration = true;
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                         NULL, (void *)(intptr_t)rdma);
@@ -3934,8 +3933,8 @@ err:
     g_free(rdma);
 }
 
-void rdma_start_outgoing_migration(void *opaque,
-                            InetSocketAddress *host_port, Error **errp)
+void rdma_connect_outgoing(void *opaque,
+                           InetSocketAddress *host_port, Error **errp)
 {
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
@@ -3959,7 +3958,7 @@ void rdma_start_outgoing_migration(void *opaque,
         goto err;
     }
 
-    trace_rdma_start_outgoing_migration_after_rdma_source_init();
+    trace_rdma_connect_outgoing_after_rdma_source_init();
     ret = qemu_rdma_connect(rdma, false, errp);
 
     if (ret < 0) {
@@ -3992,11 +3991,11 @@ void rdma_start_outgoing_migration(void *opaque,
         rdma_return_path->is_return_path = true;
     }
 
-    trace_rdma_start_outgoing_migration_after_rdma_connect();
+    trace_rdma_connect_outgoing_after_rdma_connect();
 
     s->rdma_migration = true;
     migration_outgoing_setup(rdma_new_output(rdma));
-    migration_connect(s);
+    migration_start_outgoing(s);
     return;
 return_path_err:
     qemu_rdma_cleanup(rdma);
diff --git a/migration/rdma.h b/migration/rdma.h
index f74f16a459..170c25cf44 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -21,10 +21,10 @@
 
 #include "system/memory.h"
 
-void rdma_start_outgoing_migration(void *opaque, InetSocketAddress *host_port,
-                                   Error **errp);
+void rdma_connect_outgoing(void *opaque, InetSocketAddress *host_port,
+                           Error **errp);
 
-void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
+void rdma_connect_incoming(InetSocketAddress *host_port, Error **errp);
 
 /*
  * Constants used by rdma return codes
diff --git a/migration/socket.c b/migration/socket.c
index 611915f84d..ac3183d5d5 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -80,9 +80,8 @@ err:
     migration_connect_error_propagate(data->s, err);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     SocketAddress *saddr,
-                                     Error **errp)
+void socket_connect_outgoing(MigrationState *s, SocketAddress *saddr,
+                             Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
@@ -140,8 +139,7 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-void socket_start_incoming_migration(SocketAddress *saddr,
-                                     Error **errp)
+void socket_connect_incoming(SocketAddress *saddr, Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
diff --git a/migration/socket.h b/migration/socket.h
index 04ebbe95a1..f0c89b64c7 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -23,10 +23,10 @@
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 
-void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
+void socket_connect_incoming(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     SocketAddress *saddr, Error **errp);
+void socket_connect_outgoing(MigrationState *s,
+                             SocketAddress *saddr, Error **errp);
 void socket_cleanup_outgoing_migration(void);
 
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index cbf10d0b63..91d7506634 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -271,11 +271,11 @@ rdma_registration_handle_wait(void) ""
 rdma_registration_start(uint64_t flags) "%" PRIu64
 rdma_registration_stop(uint64_t flags) "%" PRIu64
 rdma_registration_stop_ram(void) ""
-rdma_start_incoming_migration(void) ""
-rdma_start_incoming_migration_after_dest_init(void) ""
-rdma_start_incoming_migration_after_rdma_listen(void) ""
-rdma_start_outgoing_migration_after_rdma_connect(void) ""
-rdma_start_outgoing_migration_after_rdma_source_init(void) ""
+rdma_connect_incoming(void) ""
+rdma_connect_incoming_after_dest_init(void) ""
+rdma_connect_incoming_after_rdma_listen(void) ""
+rdma_connect_outgoing_after_rdma_connect(void) ""
+rdma_connect_outgoing_after_rdma_source_init(void) ""
 
 # postcopy-ram.c
 postcopy_discard_send_finish(const char *ramblock, int nwords, int ncmds) "%s mask words sent=%d in %d commands"
-- 
2.51.0


