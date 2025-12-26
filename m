Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3B4E8FDBA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFF9-0003BS-Pj; Fri, 26 Dec 2025 16:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFF8-00036C-4R
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:21:02 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFF5-0004Kb-EW
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:21:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E907B5BCE9;
 Fri, 26 Dec 2025 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jflGzj1VlA3/aYurEwO1N3ZJH8+WAr4qnfdqpovhE/c=;
 b=tBNSfkeb7nMpeW2CvuwDIAB0GMiEY3cCst7ndSQiO+YFAmI5+9y+jG9vDRKDqpzZqQdSND
 fipq4azF6C3AoWb2V9Z/efyZwlmyEj12acxfvVxpHxOVLsG+ipwrdxchSijaixibzNCadi
 yL3NbO6rHojvZYDNXhbXjolMoA91Bso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jflGzj1VlA3/aYurEwO1N3ZJH8+WAr4qnfdqpovhE/c=;
 b=wOMLW15WA6kcaOPsfRO3gWJFn+YNLY/0jtdRt1yys/83UyjULM+senVuiYPmc7yE5jL7gH
 h2Ikn7iONuSN4zCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H2AV6mwA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vvRvfmei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jflGzj1VlA3/aYurEwO1N3ZJH8+WAr4qnfdqpovhE/c=;
 b=H2AV6mwA4fRxgZ68jTp7/ZR4dr6VdHbb5mwLpaXfWeRy2tloe14NgDlVwhin+YTV+ZlVQe
 YRpULoU7at0n/1Rg04tesIBWz/wvS04VXLgwyT2k/2iAiphq3Lmz3+NS2hMeVwwJoXC0U8
 xV37agExkP5Gp11J8DUpOw2J9A2j6Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jflGzj1VlA3/aYurEwO1N3ZJH8+WAr4qnfdqpovhE/c=;
 b=vvRvfmeiTwsdmkzZsj/CB8ltSnFzWH/6JqG+5XLVcaYw08cdOJ6XfZwint3wSOkmvO3vH8
 nlV8YMx9OjFajkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F7793EA63;
 Fri, 26 Dec 2025 21:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WOzfFwj8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH 21/25] migration/channel: Cleanup early passing of
 MigrationState
Date: Fri, 26 Dec 2025 18:19:23 -0300
Message-ID: <20251226211930.27565-22-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E907B5BCE9
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

MigrationState is being passed around quite a lot, but there are not
many actual users. Reduce the passing around by converting some key
functions to use migrate_get_current(). Although this goes against the
general direction of not using migrate_get_current(), doing this helps
to isolate the places that actually need MigrationState and could
facilitate future cleanups.

In the early connection code, qmp_migrate() needs MigrationState only
to make sure it reaches:

  migrate_prepare()
  migrate_hup_add()
  migration_start_outgoing()
  migration_connect_error_propagate()

The first two are at the top level, so are trivial to change. The last
two actually require passing 's' around between several functions,
making the code way more complex than it needs to be.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 21 +++++++++----------
 migration/channel.h   |  5 ++---
 migration/exec.c      |  3 +--
 migration/exec.h      |  3 +--
 migration/fd.c        |  3 +--
 migration/fd.h        |  3 +--
 migration/file.c      |  3 +--
 migration/file.h      |  3 +--
 migration/migration.c | 49 +++++++++++++++++++++++--------------------
 migration/migration.h |  4 ++--
 migration/rdma.c      |  5 ++---
 migration/rdma.h      |  3 +--
 migration/socket.c    | 32 +++++++---------------------
 migration/socket.h    |  3 +--
 migration/tls.c       | 11 +++++-----
 migration/tls.h       |  2 +-
 16 files changed, 63 insertions(+), 90 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 2f33cb2653..042e01b224 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -31,8 +31,7 @@
 #include "trace.h"
 #include "yank_functions.h"
 
-bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
-                                Error **errp)
+bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
 {
     g_autoptr(QIOChannel) ioc = NULL;
     SocketAddress *saddr;
@@ -45,7 +44,7 @@ bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
         case SOCKET_ADDRESS_TYPE_INET:
         case SOCKET_ADDRESS_TYPE_UNIX:
         case SOCKET_ADDRESS_TYPE_VSOCK:
-            socket_connect_outgoing(s, saddr, errp);
+            socket_connect_outgoing(saddr, errp);
             /*
              * async: after the socket is connected, calls
              * migration_channel_connect_outgoing() directly.
@@ -53,7 +52,7 @@ bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
             return true;
             break;
         case SOCKET_ADDRESS_TYPE_FD:
-            ioc = fd_connect_outgoing(s, saddr->u.fd.str, errp);
+            ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
             break;
         default:
             g_assert_not_reached();
@@ -63,16 +62,16 @@ bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
 
 #ifdef CONFIG_RDMA
     case MIGRATION_ADDRESS_TYPE_RDMA:
-        ioc = rdma_connect_outgoing(s, &addr->u.rdma, errp);
+        ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
         break;
 #endif
 
     case MIGRATION_ADDRESS_TYPE_EXEC:
-        ioc = exec_connect_outgoing(s, addr->u.exec.args, errp);
+        ioc = exec_connect_outgoing(addr->u.exec.args, errp);
         break;
 
     case MIGRATION_ADDRESS_TYPE_FILE:
-        ioc = file_connect_outgoing(s, &addr->u.file, errp);
+        ioc = file_connect_outgoing(&addr->u.file, errp);
         break;
 
     default:
@@ -84,7 +83,7 @@ bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
         return false;
     }
 
-    migration_channel_connect_outgoing(s, ioc);
+    migration_channel_connect_outgoing(ioc);
     return true;
 }
 
@@ -252,12 +251,12 @@ out:
     }
 }
 
-void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
+void migration_channel_connect_outgoing(QIOChannel *ioc)
 {
     trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
-        migration_tls_channel_connect(s, ioc);
+        migration_tls_channel_connect(ioc);
 
         /*
          * async: the above will call back to this function after
@@ -268,7 +267,7 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
 
     migration_ioc_register_yank(ioc);
     migration_outgoing_setup(ioc);
-    migration_start_outgoing(s);
+    migration_start_outgoing();
 }
 
 
diff --git a/migration/channel.h b/migration/channel.h
index 4851179ae6..8cf16bfda9 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -29,7 +29,7 @@ enum {
 
 void migration_channel_process_incoming(QIOChannel *ioc);
 
-void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc);
+void migration_channel_connect_outgoing(QIOChannel *ioc);
 
 int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
@@ -39,7 +39,6 @@ int migration_channel_read_peek(QIOChannel *ioc,
 bool migration_has_main_and_multifd_channels(void);
 bool migration_has_all_channels(void);
 
-bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
-                                Error **errp);
+bool migration_connect_outgoing(MigrationAddress *addr, Error **errp);
 void migration_connect_incoming(MigrationAddress *addr, Error **errp);
 #endif
diff --git a/migration/exec.c b/migration/exec.c
index a1a7ede3b4..a62fc0d00b 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -40,8 +40,7 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-QIOChannel *exec_connect_outgoing(MigrationState *s, strList *command,
-                                  Error **errp)
+QIOChannel *exec_connect_outgoing(strList *command, Error **errp)
 {
     QIOChannel *ioc = NULL;
     g_auto(GStrv) argv = strv_from_str_list(command);
diff --git a/migration/exec.h b/migration/exec.h
index 3e39270dce..03c494b73c 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -27,6 +27,5 @@ const char *exec_get_cmd_path(void);
 #endif
 void exec_connect_incoming(strList *host_port, Error **errp);
 
-QIOChannel *exec_connect_outgoing(MigrationState *s, strList *host_port,
-                                  Error **errp);
+QIOChannel *exec_connect_outgoing(strList *host_port, Error **errp);
 #endif
diff --git a/migration/fd.c b/migration/fd.c
index bbf380d1a0..2480f48f2b 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,8 +49,7 @@ static bool migration_fd_valid(int fd)
     return false;
 }
 
-QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
-                                Error **errp)
+QIOChannel *fd_connect_outgoing(const char *fdname, Error **errp)
 {
     QIOChannel *ioc = NULL;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
diff --git a/migration/fd.h b/migration/fd.h
index ce0b751273..dfadbf4cc5 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -21,6 +21,5 @@
 
 void fd_connect_incoming(const char *fdname, Error **errp);
 
-QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
-                                Error **errp);
+QIOChannel *fd_connect_outgoing(const char *fdname, Error **errp);
 #endif
diff --git a/migration/file.c b/migration/file.c
index 5618aced49..9cdb55d94e 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -93,8 +93,7 @@ out:
     return ret;
 }
 
-QIOChannel *file_connect_outgoing(MigrationState *s,
-                                  FileMigrationArgs *file_args, Error **errp)
+QIOChannel *file_connect_outgoing(FileMigrationArgs *file_args, Error **errp)
 {
     QIOChannelFile *fioc = NULL;
     g_autofree char *filename = g_strdup(file_args->filename);
diff --git a/migration/file.h b/migration/file.h
index 5936c64fea..74efd48abf 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -16,8 +16,7 @@
 
 void file_connect_incoming(FileMigrationArgs *file_args, Error **errp);
 
-QIOChannel *file_connect_outgoing(MigrationState *s,
-                                  FileMigrationArgs *file_args, Error **errp);
+QIOChannel *file_connect_outgoing(FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index c75c2c7e52..c11cd4ebf6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -101,7 +101,7 @@ static bool migration_object_check(MigrationState *ms, Error **errp);
 static bool migration_switchover_start(MigrationState *s, Error **errp);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
-static void migrate_hup_delete(MigrationState *s);
+static void migrate_hup_delete(void);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -1372,7 +1372,7 @@ static void migration_cleanup(MigrationState *s)
 
     qemu_savevm_state_cleanup();
     cpr_state_close();
-    migrate_hup_delete(s);
+    migrate_hup_delete();
 
     close_return_path_on_source(s);
 
@@ -1454,8 +1454,9 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-void migration_connect_error_propagate(MigrationState *s, Error *error)
+void migration_connect_error_propagate(Error *error)
 {
+    MigrationState *s = migrate_get_current();
     MigrationStatus current = s->state;
     MigrationStatus next = MIGRATION_STATUS_NONE;
     bool resume = false;
@@ -1555,7 +1556,7 @@ void migration_cancel(void)
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                           MIGRATION_STATUS_CANCELLED);
         cpr_state_close();
-        migrate_hup_delete(s);
+        migrate_hup_delete();
     }
 }
 
@@ -1961,8 +1962,10 @@ bool migration_is_blocked(Error **errp)
 }
 
 /* Returns true if continue to migrate, or false if error detected */
-static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
+static bool migrate_prepare(bool resume, Error **errp)
 {
+    MigrationState *s = migrate_get_current();
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
@@ -2080,16 +2083,19 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
 
 static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
 
-static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
-                            void *opaque)
+static void migrate_hup_add(QIOChannel *ioc, GSourceFunc cb, void *opaque)
 {
-        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
-        g_source_set_callback(s->hup_source, cb, opaque, NULL);
-        g_source_attach(s->hup_source, NULL);
+    MigrationState *s = migrate_get_current();
+
+    s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
+    g_source_set_callback(s->hup_source, cb, opaque, NULL);
+    g_source_attach(s->hup_source, NULL);
 }
 
-static void migrate_hup_delete(MigrationState *s)
+static void migrate_hup_delete(void)
 {
+    MigrationState *s = migrate_get_current();
+
     if (s->hup_source) {
         g_source_destroy(s->hup_source);
         g_source_unref(s->hup_source);
@@ -2101,19 +2107,18 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
                                       GIOCondition cond,
                                       void *opaque)
 {
-    MigrationState *s = migrate_get_current();
     MigrationAddress *addr = opaque;
     Error *local_err = NULL;
 
     qmp_migrate_finish(addr, &local_err);
 
     if (local_err) {
-        migration_connect_error_propagate(s, local_err);
+        migration_connect_error_propagate(local_err);
     }
 
 
     cpr_state_close();
-    migrate_hup_delete(s);
+    migrate_hup_delete();
     qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
@@ -2122,7 +2127,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
-    MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
@@ -2173,7 +2177,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (!migrate_prepare(s, has_resume && resume, errp)) {
+    if (!migrate_prepare(has_resume && resume, errp)) {
         /* Error detected, put into errp */
         return;
     }
@@ -2200,7 +2204,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
-        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
+        migrate_hup_add(cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
                         QAPI_CLONE(MigrationAddress, addr));
 
     } else {
@@ -2209,16 +2213,14 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        migration_connect_error_propagate(s, error_copy(local_err));
+        migration_connect_error_propagate(error_copy(local_err));
         error_propagate(errp, local_err);
     }
 }
 
 static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
 {
-    MigrationState *s = migrate_get_current();
-
-    migration_connect_outgoing(s, addr, errp);
+    migration_connect_outgoing(addr, errp);
 }
 
 void qmp_migrate_cancel(Error **errp)
@@ -3895,8 +3897,9 @@ fail_setup:
     return NULL;
 }
 
-void migration_start_outgoing(MigrationState *s)
+void migration_start_outgoing(void)
 {
+    MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
@@ -3975,7 +3978,7 @@ void migration_start_outgoing(MigrationState *s)
     return;
 
 fail:
-    migration_connect_error_propagate(s, local_err);
+    migration_connect_error_propagate(local_err);
     if (s->error) {
         error_report_err(error_copy(s->error));
     }
diff --git a/migration/migration.h b/migration/migration.h
index 138831d7d9..1292c1ee3a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -529,11 +529,11 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
 void migration_outgoing_setup(QIOChannel *ioc);
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
 
-void migration_connect_error_propagate(MigrationState *s, Error *error);
+void migration_connect_error_propagate(Error *error);
 void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
 
-void migration_start_outgoing(MigrationState *s);
+void migration_start_outgoing(void);
 void migration_start_incoming(void);
 
 int migration_call_notifiers(MigrationState *s, MigrationEventType type,
diff --git a/migration/rdma.c b/migration/rdma.c
index 3db3a89bdb..56e0ee8aa9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3923,10 +3923,9 @@ err:
     g_free(rdma);
 }
 
-QIOChannel *rdma_connect_outgoing(void *opaque,
-                                  InetSocketAddress *host_port, Error **errp)
+QIOChannel *rdma_connect_outgoing(InetSocketAddress *host_port, Error **errp)
 {
-    MigrationState *s = opaque;
+    MigrationState *s = migrate_get_current();
     RDMAContext *rdma_return_path = NULL;
     RDMAContext *rdma;
     int ret;
diff --git a/migration/rdma.h b/migration/rdma.h
index 8a6515f130..205184f244 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -21,8 +21,7 @@
 
 #include "system/memory.h"
 
-QIOChannel *rdma_connect_outgoing(void *opaque, InetSocketAddress *host_port,
-                                  Error **errp);
+QIOChannel *rdma_connect_outgoing(InetSocketAddress *host_port, Error **errp);
 
 void rdma_connect_incoming(InetSocketAddress *host_port, Error **errp);
 
diff --git a/migration/socket.c b/migration/socket.c
index ac3183d5d5..34ce7abbd3 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -42,23 +42,8 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
                                      f, data, NULL, NULL);
 }
 
-struct SocketConnectData {
-    MigrationState *s;
-};
-
-static void socket_connect_data_free(void *opaque)
+static void socket_outgoing_migration(QIOTask *task, gpointer opaque)
 {
-    struct SocketConnectData *data = opaque;
-    if (!data) {
-        return;
-    }
-    g_free(data);
-}
-
-static void socket_outgoing_migration(QIOTask *task,
-                                      gpointer opaque)
-{
-    struct SocketConnectData *data = opaque;
     g_autoptr(QIOChannel) sioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
@@ -73,22 +58,19 @@ static void socket_outgoing_migration(QIOTask *task,
     }
 
     trace_migration_socket_outgoing_connected();
-    migration_channel_connect_outgoing(data->s, sioc);
+    migration_channel_connect_outgoing(sioc);
     return;
 err:
     trace_migration_socket_outgoing_error(error_get_pretty(err));
-    migration_connect_error_propagate(data->s, err);
+    migration_connect_error_propagate(err);
 }
 
-void socket_connect_outgoing(MigrationState *s, SocketAddress *saddr,
-                             Error **errp)
+void socket_connect_outgoing(SocketAddress *saddr, Error **errp)
 {
+    MigrationState *s = migrate_get_current();
     QIOChannelSocket *sioc = qio_channel_socket_new();
-    struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
     SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
-    data->s = s;
-
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
     outgoing_args.saddr = addr;
@@ -101,8 +83,8 @@ void socket_connect_outgoing(MigrationState *s, SocketAddress *saddr,
     qio_channel_socket_connect_async(sioc,
                                      saddr,
                                      socket_outgoing_migration,
-                                     data,
-                                     socket_connect_data_free,
+                                     NULL,
+                                     NULL,
                                      NULL);
 }
 
diff --git a/migration/socket.h b/migration/socket.h
index f0c89b64c7..0ddff7e9df 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -25,8 +25,7 @@ void socket_send_channel_create(QIOTaskFunc f, void *data);
 
 void socket_connect_incoming(SocketAddress *saddr, Error **errp);
 
-void socket_connect_outgoing(MigrationState *s,
-                             SocketAddress *saddr, Error **errp);
+void socket_connect_outgoing(SocketAddress *saddr, Error **errp);
 void socket_cleanup_outgoing_migration(void);
 
 #endif
diff --git a/migration/tls.c b/migration/tls.c
index f68e6a533b..d71d3f9ea6 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -103,18 +103,17 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp)
 static void migration_tls_outgoing_handshake(QIOTask *task,
                                              gpointer opaque)
 {
-    MigrationState *s = opaque;
     g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
-        migration_connect_error_propagate(s, err);
+        migration_connect_error_propagate(err);
         return;
     }
 
     trace_migration_tls_outgoing_handshake_complete();
-    migration_channel_connect_outgoing(s, ioc);
+    migration_channel_connect_outgoing(ioc);
 }
 
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
@@ -130,14 +129,14 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
 }
 
-void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc)
+void migration_tls_channel_connect(QIOChannel *ioc)
 {
     QIOChannelTLS *tioc;
     Error *local_err = NULL;
 
     tioc = migration_tls_client_create(ioc, &local_err);
     if (!tioc) {
-        migration_connect_error_propagate(s, local_err);
+        migration_connect_error_propagate(local_err);
         return;
     }
 
@@ -150,7 +149,7 @@ void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc)
     }
     qio_channel_tls_handshake(tioc,
                               migration_tls_outgoing_handshake,
-                              s,
+                              NULL,
                               NULL,
                               NULL);
 }
diff --git a/migration/tls.h b/migration/tls.h
index 7399c42edf..7ccd495f81 100644
--- a/migration/tls.h
+++ b/migration/tls.h
@@ -29,7 +29,7 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
 QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
                                            Error **errp);
 
-void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc);
+void migration_tls_channel_connect(QIOChannel *ioc);
 void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
 /* Whether the QIO channel requires further TLS handshake? */
 bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
-- 
2.51.0


