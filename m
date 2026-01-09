Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AEDD1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBnf-0003Mf-7f; Fri, 09 Jan 2026 07:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnd-0003MB-C2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:05 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnb-0007F2-1i
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:05 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB8CD5BD06;
 Fri,  9 Jan 2026 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgz9YTAwzwBE/+gB4R5d3V4PEvGgqQ4qvQjF6rEGz3M=;
 b=GWTSY9b3VL8xFvHF70HXLO7wTQuVS6oe98hYrqnnMgQxCIXzKms+UugoXD1H1YLLsZrUrM
 1adVXqC75XjXk1zvgwH7rIOjgXHqOQ/szneRSd4xdiqSGvZWdeQ3UKfvPWm3VY4QsPsoQ2
 bsbWWT1ntV6p5ddW82wu0/VGQZf198A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgz9YTAwzwBE/+gB4R5d3V4PEvGgqQ4qvQjF6rEGz3M=;
 b=3vpthjdP+hI7xXKFudiRZI3BuqSBbfujDoSe66HEM8ZJgkAZKJUBCvRiyfwnxIwKMXlfwS
 wjZAArKpg4ECWZAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GWTSY9b3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3vpthjdP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgz9YTAwzwBE/+gB4R5d3V4PEvGgqQ4qvQjF6rEGz3M=;
 b=GWTSY9b3VL8xFvHF70HXLO7wTQuVS6oe98hYrqnnMgQxCIXzKms+UugoXD1H1YLLsZrUrM
 1adVXqC75XjXk1zvgwH7rIOjgXHqOQ/szneRSd4xdiqSGvZWdeQ3UKfvPWm3VY4QsPsoQ2
 bsbWWT1ntV6p5ddW82wu0/VGQZf198A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgz9YTAwzwBE/+gB4R5d3V4PEvGgqQ4qvQjF6rEGz3M=;
 b=3vpthjdP+hI7xXKFudiRZI3BuqSBbfujDoSe66HEM8ZJgkAZKJUBCvRiyfwnxIwKMXlfwS
 wjZAArKpg4ECWZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AAFD3EA63;
 Fri,  9 Jan 2026 12:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0KtrNlX3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:40:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 04/25] migration: Cleanup TLS handshake hostname passing
Date: Fri,  9 Jan 2026 09:40:20 -0300
Message-ID: <20260109124043.25019-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CB8CD5BD06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The TLS hostname is doing a tour around the world just to be cached
into s->hostname. We're already abusing MigrationState by doing that,
so incorporate the s->hostname into migration_tls_hostname() and stop
passing the string around.

The old route was roughly:

 -transport code (socket.c, fd.c, etc):
    if (SOCKET_ADDRESS_TYPE_INET)
        hostname = saddr->u.inet.host
    else
        hostname = NULL
    migration_channel_connect(..., hostname)
      s->hostname = hostname;
      migration_tls_client_create(..., hostname)
        if (migrate_tls_hostname())
            qio_channel_tls_new_client(migrate_tls_hostname())
        else
            qio_channel_tls_new_client(hostname)

 -postcopy_preempt_setup:
    postcopy_preempt_send_channel_new
      migration_tls_client_create(..., s->hostname)

New route is:

 -socket.c only:
   if SOCKET_ADDRESS_TYPE_INET
       s->hostname = saddr->u.inet.host
   migration_channel_connect()
     migration_tls_client_create()
       qio_channel_tls_new_client(migrate_tls_hostname())

 -postcopy_preempt_setup:
    postcopy_preempt_send_channel_new
      migration_tls_client_create()
        qio_channel_tls_new_client(migrate_tls_hostname())

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c      |  6 ++----
 migration/channel.h      |  1 -
 migration/exec.c         |  2 +-
 migration/fd.c           |  2 +-
 migration/file.c         |  2 +-
 migration/multifd.c      |  9 +++------
 migration/options.c      |  5 +++++
 migration/postcopy-ram.c |  2 +-
 migration/socket.c       |  9 +++------
 migration/tls.c          | 17 ++++-------------
 migration/tls.h          |  2 --
 migration/trace-events   | 10 +++++-----
 12 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index b4ab676048..ba14f66d85 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -60,20 +60,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
  *
  * @s: Current migration state
  * @ioc: Channel to which we are connecting
- * @hostname: Where we want to connect
  * @error: Error indicating failure to connect, free'd here
  */
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
-                               const char *hostname,
                                Error *error)
 {
     trace_migration_set_outgoing_channel(
-        ioc, object_get_typename(OBJECT(ioc)), hostname, error);
+        ioc, object_get_typename(OBJECT(ioc)), error);
 
     if (!error) {
         if (migrate_channel_requires_tls_upgrade(ioc)) {
-            migration_tls_channel_connect(s, ioc, hostname, &error);
+            migration_tls_channel_connect(s, ioc, &error);
 
             if (!error) {
                 /* tls_channel_connect will call back to this
diff --git a/migration/channel.h b/migration/channel.h
index 5bdb8208a7..2215091323 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -22,7 +22,6 @@ void migration_channel_process_incoming(QIOChannel *ioc);
 
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
-                               const char *hostname,
                                Error *error_in);
 
 int migration_channel_read_peek(QIOChannel *ioc,
diff --git a/migration/exec.c b/migration/exec.c
index 20e6cccf8c..78fe0fff13 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
     }
 
     qio_channel_set_name(ioc, "migration-exec-outgoing");
-    migration_channel_connect(s, ioc, NULL, NULL);
+    migration_channel_connect(s, ioc, NULL);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/fd.c b/migration/fd.c
index 9bf9be6acb..c956b260a4 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
     }
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
-    migration_channel_connect(s, ioc, NULL, NULL);
+    migration_channel_connect(s, ioc, NULL);
     object_unref(OBJECT(ioc));
 }
 
diff --git a/migration/file.c b/migration/file.c
index bb8031e3c7..c490f2b219 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
         return;
     }
     qio_channel_set_name(ioc, "migration-file-outgoing");
-    migration_channel_connect(s, ioc, NULL, NULL);
+    migration_channel_connect(s, ioc, NULL);
 }
 
 static gboolean file_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/multifd.c b/migration/multifd.c
index bf6da85af8..3fb1a07ba9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -814,12 +814,10 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
                                         QIOChannel *ioc,
                                         Error **errp)
 {
-    MigrationState *s = migrate_get_current();
-    const char *hostname = s->hostname;
     MultiFDTLSThreadArgs *args;
     QIOChannelTLS *tioc;
 
-    tioc = migration_tls_client_create(ioc, hostname, errp);
+    tioc = migration_tls_client_create(ioc, errp);
     if (!tioc) {
         return false;
     }
@@ -829,7 +827,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
      * created TLS channel, which has already taken a reference.
      */
     object_unref(OBJECT(ioc));
-    trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
+    trace_multifd_tls_outgoing_handshake_start(ioc, tioc);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
 
     args = g_new0(MultiFDTLSThreadArgs, 1);
@@ -876,8 +874,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         goto out;
     }
 
-    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
-                                       migrate_get_current()->hostname);
+    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         ret = multifd_tls_channel_connect(p, ioc, &local_err);
diff --git a/migration/options.c b/migration/options.c
index 9a5a39c886..881034c289 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -956,6 +956,11 @@ const char *migrate_tls_hostname(void)
         return s->parameters.tls_hostname->u.s;
     }
 
+    /* hostname saved from a previously connected channel */
+    if (s->hostname) {
+        return s->hostname;
+    }
+
     return NULL;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 98a98138be..7afb42bd27 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1966,7 +1966,7 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
     }
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
-        tioc = migration_tls_client_create(ioc, s->hostname, &local_err);
+        tioc = migration_tls_client_create(ioc, &local_err);
         if (!tioc) {
             goto out;
         }
diff --git a/migration/socket.c b/migration/socket.c
index 9e379bf56f..426f363b99 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -44,7 +44,6 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
 
 struct SocketConnectData {
     MigrationState *s;
-    char *hostname;
 };
 
 static void socket_connect_data_free(void *opaque)
@@ -53,7 +52,6 @@ static void socket_connect_data_free(void *opaque)
     if (!data) {
         return;
     }
-    g_free(data->hostname);
     g_free(data);
 }
 
@@ -69,7 +67,7 @@ static void socket_outgoing_migration(QIOTask *task,
            goto out;
     }
 
-    trace_migration_socket_outgoing_connected(data->hostname);
+    trace_migration_socket_outgoing_connected();
 
     if (migrate_zero_copy_send() &&
         !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
@@ -77,7 +75,7 @@ static void socket_outgoing_migration(QIOTask *task,
     }
 
 out:
-    migration_channel_connect(data->s, sioc, data->hostname, err);
+    migration_channel_connect(data->s, sioc, err);
     object_unref(OBJECT(sioc));
 }
 
@@ -96,7 +94,7 @@ void socket_start_outgoing_migration(MigrationState *s,
     outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
-        data->hostname = g_strdup(saddr->u.inet.host);
+        s->hostname = g_strdup(saddr->u.inet.host);
     }
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-outgoing");
@@ -180,4 +178,3 @@ void socket_start_incoming_migration(SocketAddress *saddr,
         qapi_free_SocketAddress(address);
     }
 }
-
diff --git a/migration/tls.c b/migration/tls.c
index 1df31bdcbb..82f58cbc78 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -112,12 +112,11 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
     } else {
         trace_migration_tls_outgoing_handshake_complete();
     }
-    migration_channel_connect(s, ioc, NULL, err);
+    migration_channel_connect(s, ioc, err);
     object_unref(OBJECT(ioc));
 }
 
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
-                                           const char *hostname,
                                            Error **errp)
 {
     QCryptoTLSCreds *creds;
@@ -127,29 +126,21 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
         return NULL;
     }
 
-    const char *tls_hostname = migrate_tls_hostname();
-    if (tls_hostname) {
-        hostname = tls_hostname;
-    }
-
-    return qio_channel_tls_new_client(ioc, creds, hostname, errp);
+    return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
 }
 
 void migration_tls_channel_connect(MigrationState *s,
                                    QIOChannel *ioc,
-                                   const char *hostname,
                                    Error **errp)
 {
     QIOChannelTLS *tioc;
 
-    tioc = migration_tls_client_create(ioc, hostname, errp);
+    tioc = migration_tls_client_create(ioc, errp);
     if (!tioc) {
         return;
     }
 
-    /* Save hostname into MigrationState for handshake */
-    s->hostname = g_strdup(hostname);
-    trace_migration_tls_outgoing_handshake_start(hostname);
+    trace_migration_tls_outgoing_handshake_start();
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
 
     if (migrate_postcopy_ram() || migrate_return_path()) {
diff --git a/migration/tls.h b/migration/tls.h
index 7607cfe803..7cd9c76013 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -27,12 +27,10 @@
 void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
 
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
-                                           const char *hostname,
                                            Error **errp);
 
 void migration_tls_channel_connect(MigrationState *s,
                                    QIOChannel *ioc,
-                                   const char *hostname,
                                    Error **errp);
 void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
 /* Whether the QIO channel requires further TLS handshake? */
diff --git a/migration/trace-events b/migration/trace-events
index bf11b62b17..da8f909cac 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -149,10 +149,10 @@ multifd_send_sync_main_wait(uint8_t id) "channel %u"
 multifd_send_terminate_threads(void) ""
 multifd_send_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
-multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
+multifd_tls_outgoing_handshake_start(void *ioc, void *tioc) "ioc=%p tioc=%p"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
 multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
-multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
+multifd_set_outgoing_channel(void *ioc, const char *ioctype)  "ioc=%p ioctype=%s"
 
 # migration.c
 migrate_set_state(const char *new_state) "new state %s"
@@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 
 # channel.c
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
+migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
 
 # global_state.c
 migrate_state_too_big(void) ""
@@ -328,11 +328,11 @@ migration_file_incoming(const char *filename) "filename=%s"
 
 # socket.c
 migration_socket_incoming_accepted(void) ""
-migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
+migration_socket_outgoing_connected(void) ""
 migration_socket_outgoing_error(const char *err) "error=%s"
 
 # tls.c
-migration_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
+migration_tls_outgoing_handshake_start(void) ""
 migration_tls_outgoing_handshake_error(const char *err) "err=%s"
 migration_tls_outgoing_handshake_complete(void) ""
 migration_tls_incoming_handshake_start(void) ""
-- 
2.51.0


