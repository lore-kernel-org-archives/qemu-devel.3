Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA34EC79FB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpw5-00082T-6c; Mon, 05 Jan 2026 14:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvf-0007ri-Hj
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvc-0005Wd-H3
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CC7C33767;
 Mon,  5 Jan 2026 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Hl/L3HrVf/3rE5M+8zvDGNNqrWVgAJar0eEqntxcP8=;
 b=Lc12Kg8IpSYhMaClXnYGU4J6DtENah6BYKyGWjKNuvmwqE+y4pkIKaU48NApgQHLxBKWWM
 KGnpbej6/2TW7mBBYxB+zNFrSQp4+Kgcnxjg5v3DmtDzHnTkPmddlpUZjM13/ZqIOzGPDL
 bAQFCkOFYJYfFQzAWqOxhVfoLyWR+eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640032;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Hl/L3HrVf/3rE5M+8zvDGNNqrWVgAJar0eEqntxcP8=;
 b=YCwrqGuHGNSiYT0+R+g6muv8WeIPY6q8uQ3mUUUHALg+W4r/ZiJKdm73t3qrIFyezLwIbq
 rV4HKHGEXoRHhnDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Hl/L3HrVf/3rE5M+8zvDGNNqrWVgAJar0eEqntxcP8=;
 b=Lc12Kg8IpSYhMaClXnYGU4J6DtENah6BYKyGWjKNuvmwqE+y4pkIKaU48NApgQHLxBKWWM
 KGnpbej6/2TW7mBBYxB+zNFrSQp4+Kgcnxjg5v3DmtDzHnTkPmddlpUZjM13/ZqIOzGPDL
 bAQFCkOFYJYfFQzAWqOxhVfoLyWR+eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640032;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Hl/L3HrVf/3rE5M+8zvDGNNqrWVgAJar0eEqntxcP8=;
 b=YCwrqGuHGNSiYT0+R+g6muv8WeIPY6q8uQ3mUUUHALg+W4r/ZiJKdm73t3qrIFyezLwIbq
 rV4HKHGEXoRHhnDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC1D013964;
 Mon,  5 Jan 2026 19:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YHG8Jt4LXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 12/25] migration: Handle error in the early async paths
Date: Mon,  5 Jan 2026 16:06:29 -0300
Message-ID: <20260105190644.14072-13-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
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

Simplify migration_channel_connect() and migration_connect() to not
take an error as input. Move the error handling into the paths that
generate the error.

To achieve this, call migration_connect_error_propagate() from
socket.c and tls.c, which are the async paths.

For the sync paths, the handling is done as normal by returning all
the way to qmp_migrate_finish(), except that now the sync paths don't
pass the error forward into migration_connect() anymore.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c    | 49 ++++++++++++++++++++----------------------
 migration/channel.h    |  4 +---
 migration/exec.c       |  2 +-
 migration/fd.c         |  2 +-
 migration/file.c       |  2 +-
 migration/migration.c  | 11 ++--------
 migration/migration.h  |  3 ++-
 migration/rdma.c       |  2 +-
 migration/socket.c     | 17 ++++++++-------
 migration/tls.c        | 14 ++++++------
 migration/tls.h        |  3 +--
 migration/trace-events |  2 +-
 12 files changed, 50 insertions(+), 61 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index ba14f66d85..26cb7bf059 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -60,38 +60,35 @@ void migration_channel_process_incoming(QIOChannel *ioc)
  *
  * @s: Current migration state
  * @ioc: Channel to which we are connecting
- * @error: Error indicating failure to connect, free'd here
  */
-void migration_channel_connect(MigrationState *s,
-                               QIOChannel *ioc,
-                               Error *error)
+void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
 {
-    trace_migration_set_outgoing_channel(
-        ioc, object_get_typename(OBJECT(ioc)), error);
+    trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
 
-    if (!error) {
-        if (migrate_channel_requires_tls_upgrade(ioc)) {
-            migration_tls_channel_connect(s, ioc, &error);
+    if (migrate_channel_requires_tls_upgrade(ioc)) {
+        Error *local_err = NULL;
 
-            if (!error) {
-                /* tls_channel_connect will call back to this
-                 * function after the TLS handshake,
-                 * so we mustn't call migration_connect until then
-                 */
-
-                return;
-            }
-        } else {
-            QEMUFile *f = qemu_file_new_output(ioc);
-
-            migration_ioc_register_yank(ioc);
-
-            qemu_mutex_lock(&s->qemu_file_lock);
-            s->to_dst_file = f;
-            qemu_mutex_unlock(&s->qemu_file_lock);
+        migration_tls_channel_connect(s, ioc, &local_err);
+        if (local_err) {
+            migration_connect_error_propagate(s, local_err);
         }
+
+        /*
+         * async: the above will call back to this function after
+         * the TLS handshake is successfully completed.
+         */
+        return;
     }
-    migration_connect(s, error);
+
+    QEMUFile *f = qemu_file_new_output(ioc);
+
+    migration_ioc_register_yank(ioc);
+
+    qemu_mutex_lock(&s->qemu_file_lock);
+    s->to_dst_file = f;
+    qemu_mutex_unlock(&s->qemu_file_lock);
+
+    migration_connect(s);
 }
 
 
diff --git a/migration/channel.h b/migration/channel.h
index 2215091323..ccfeaaef18 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -20,9 +20,7 @@
 
 void migration_channel_process_incoming(QIOChannel *ioc);
 
-void migration_channel_connect(MigrationState *s,
-                               QIOChannel *ioc,
-                               Error *error_in);
+void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
 
 int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
diff --git a/migration/exec.c b/migration/exec.c
index 78fe0fff13..d83a07435a 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
     }
 
     qio_channel_set_name(ioc, "migration-exec-outgoing");
-    migration_channel_connect(s, ioc, NULL);
+    migration_channel_connect(s, ioc);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index c956b260a4..0144a70742 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
-    migration_channel_connect(s, ioc, NULL);
+    migration_channel_connect(s, ioc);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/file.c b/migration/file.c
index c490f2b219..7bb9c1c79f 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
         return;
     }
     qio_channel_set_name(ioc, "migration-file-outgoing");
-    migration_channel_connect(s, ioc, NULL);
+    migration_channel_connect(s, ioc);
 }
 
 static gboolean file_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/migration.c b/migration/migration.c
index d57cc2dc3b..1ea6125454 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1572,7 +1572,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-static void migration_connect_error_propagate(MigrationState *s, Error *error)
+void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next = MIGRATION_STATUS_NONE;
@@ -4028,7 +4028,7 @@ fail_setup:
     return NULL;
 }
 
-void migration_connect(MigrationState *s, Error *error_in)
+void migration_connect(MigrationState *s)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
@@ -4036,13 +4036,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     int ret;
 
     s->expected_downtime = migrate_downtime_limit();
-    if (error_in) {
-        migration_connect_error_propagate(s, error_in);
-        if (s->error) {
-            error_report_err(error_copy(s->error));
-        }
-        return;
-    }
 
     if (resume) {
         /* This is a resumed migration */
diff --git a/migration/migration.h b/migration/migration.h
index 8b55d4741a..d134881eaf 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -533,10 +533,11 @@ void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
 
+void migration_connect_error_propagate(MigrationState *s, Error *error);
 void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
 
-void migration_connect(MigrationState *s, Error *error_in);
+void migration_connect(MigrationState *s);
 
 int migration_call_notifiers(MigrationEventType type, Error **errp);
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 337b415889..596a1aba0b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3997,7 +3997,7 @@ void rdma_start_outgoing_migration(void *opaque,
 
     s->to_dst_file = rdma_new_output(rdma);
     s->rdma_migration = true;
-    migration_connect(s, NULL);
+    migration_connect(s);
     return;
 return_path_err:
     qemu_rdma_cleanup(rdma);
diff --git a/migration/socket.c b/migration/socket.c
index 426f363b99..298bac30cc 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -59,24 +59,25 @@ static void socket_outgoing_migration(QIOTask *task,
                                       gpointer opaque)
 {
     struct SocketConnectData *data = opaque;
-    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
+    g_autoptr(QIOChannel) sioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        trace_migration_socket_outgoing_error(error_get_pretty(err));
-           goto out;
+        goto err;
     }
 
-    trace_migration_socket_outgoing_connected();
-
     if (migrate_zero_copy_send() &&
         !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
         error_setg(&err, "Zero copy send feature not detected in host kernel");
+        goto err;
     }
 
-out:
-    migration_channel_connect(data->s, sioc, err);
-    object_unref(OBJECT(sioc));
+    trace_migration_socket_outgoing_connected();
+    migration_channel_connect(data->s, sioc);
+    return;
+err:
+    trace_migration_socket_outgoing_error(error_get_pretty(err));
+    migration_connect_error_propagate(data->s, err);
 }
 
 void socket_start_outgoing_migration(MigrationState *s,
diff --git a/migration/tls.c b/migration/tls.c
index 82f58cbc78..837b08294f 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -104,16 +104,17 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
                                              gpointer opaque)
 {
     MigrationState *s = opaque;
-    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
-    } else {
-        trace_migration_tls_outgoing_handshake_complete();
+        migration_connect_error_propagate(s, err);
+        return;
     }
-    migration_channel_connect(s, ioc, err);
-    object_unref(OBJECT(ioc));
+
+    trace_migration_tls_outgoing_handshake_complete();
+    migration_channel_connect(s, ioc);
 }
 
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
@@ -129,8 +130,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
 }
 
-void migration_tls_channel_connect(MigrationState *s,
-                                   QIOChannel *ioc,
+void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc,
                                    Error **errp)
 {
     QIOChannelTLS *tioc;
diff --git a/migration/tls.h b/migration/tls.h
index 7cd9c76013..0e86d38862 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -29,8 +29,7 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            Error **errp);
 
-void migration_tls_channel_connect(MigrationState *s,
-                                   QIOChannel *ioc,
+void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc,
                                    Error **errp);
 void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
 /* Whether the QIO channel requires further TLS handshake? */
diff --git a/migration/trace-events b/migration/trace-events
index da8f909cac..cbf10d0b63 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 
 # channel.c
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
+migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
 # global_state.c
 migrate_state_too_big(void) ""
-- 
2.51.0


