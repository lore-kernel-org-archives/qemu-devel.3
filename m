Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AC6E8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFEU-0001Sf-Qw; Fri, 26 Dec 2025 16:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEO-0001RU-SP
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEL-00047E-P0
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 583163368B;
 Fri, 26 Dec 2025 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i/DLae2OO2ZVdC7i6O7sLm4eKDHTytV8OmukLC/6es=;
 b=Rp9O1F40umf/taLwpX775TNvuXgfQhKViJODeCyZWL6VVDzmbImfUtlj0Bu3VeEqZnETY1
 gLnn6u/aBfFtUB0vnumytSl1ayyC5Npag/p93A1GGXQGc71HnUBH49BOnF+UqfluZRbLIW
 wz0aMgtVIhmqmGCCQvVKqc0R31UCqBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i/DLae2OO2ZVdC7i6O7sLm4eKDHTytV8OmukLC/6es=;
 b=4BLrPMqcJDGlxK8hu9e0ypCvORqSKdz/bfZ7FTAEsPwa549qAET7QXtKATi2M3VyrZHBX9
 lpALMmtEIrmWUHCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i/DLae2OO2ZVdC7i6O7sLm4eKDHTytV8OmukLC/6es=;
 b=Rp9O1F40umf/taLwpX775TNvuXgfQhKViJODeCyZWL6VVDzmbImfUtlj0Bu3VeEqZnETY1
 gLnn6u/aBfFtUB0vnumytSl1ayyC5Npag/p93A1GGXQGc71HnUBH49BOnF+UqfluZRbLIW
 wz0aMgtVIhmqmGCCQvVKqc0R31UCqBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i/DLae2OO2ZVdC7i6O7sLm4eKDHTytV8OmukLC/6es=;
 b=4BLrPMqcJDGlxK8hu9e0ypCvORqSKdz/bfZ7FTAEsPwa549qAET7QXtKATi2M3VyrZHBX9
 lpALMmtEIrmWUHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 067583EA63;
 Fri, 26 Dec 2025 21:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Lv3LAT8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH 19/25] migration/channel: Make synchronous calls evident
Date: Fri, 26 Dec 2025 18:19:21 -0300
Message-ID: <20251226211930.27565-20-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.988];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Make the synchronous calls evident by not hiding the call to
migration_channel_connect_outgoing in the transport code. Have those
functions return and call the migration_connect_outgoing() at the
upper level.

This helps with navigation: the transport code returns the ioc,
there's no need to look into them when browsing the code.

It also allows RDMA in the source side to use the same path as the
rest of the transports.

While here, document the async calls which are the exception.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 30 +++++++++++++++++++++++++-----
 migration/channel.h   |  2 +-
 migration/exec.c      |  8 ++++----
 migration/exec.h      |  5 ++++-
 migration/fd.c        | 13 +++++++------
 migration/fd.h        |  7 +++++--
 migration/file.c      | 18 ++++++++++--------
 migration/file.h      |  5 +++--
 migration/migration.c |  3 +--
 migration/rdma.c      | 11 +++++------
 migration/rdma.h      |  4 ++--
 11 files changed, 67 insertions(+), 39 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index a06aa8189c..205f8a26d1 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -31,29 +31,43 @@
 #include "trace.h"
 #include "yank_functions.h"
 
-void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
+bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp)
 {
+    g_autoptr(QIOChannel) ioc = NULL;
+
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
             socket_connect_outgoing(s, saddr, errp);
+            /*
+             * async: after the socket is connected, calls
+             * migration_channel_connect_outgoing() directly.
+             */
+            return true;
         } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_connect_outgoing(s, saddr->u.fd.str, errp);
+            ioc = fd_connect_outgoing(s, saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_connect_outgoing(s, &addr->u.rdma, errp);
+        ioc = rdma_connect_outgoing(s, &addr->u.rdma, errp);
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_connect_outgoing(s, addr->u.exec.args, errp);
+        ioc = exec_connect_outgoing(s, addr->u.exec.args, errp);
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_connect_outgoing(s, &addr->u.file, errp);
+        ioc = file_connect_outgoing(s, &addr->u.file, errp);
     } else {
         error_setg(errp, "uri is not a valid migration protocol");
     }
+
+    if (!ioc) {
+        return false;
+    }
+
+    migration_channel_connect_outgoing(s, ioc);
+    return true;
 }
 
 void migration_connect_incoming(MigrationAddress *addr, Error **errp)
@@ -78,6 +92,12 @@ void migration_connect_incoming(MigrationAddress *addr, Error **errp)
     } else {
         error_setg(errp, "unknown migration protocol");
     }
+
+    /*
+     * async: the above routines all wait for the incoming connection
+     * and call back to migration_channel_process_incoming() to start
+     * the migration.
+     */
 }
 
 bool migration_has_main_and_multifd_channels(void)
diff --git a/migration/channel.h b/migration/channel.h
index 727eabf16c..4851179ae6 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -39,7 +39,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
 bool migration_has_main_and_multifd_channels(void);
 bool migration_has_all_channels(void);
 
-void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
+bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp);
 void migration_connect_incoming(MigrationAddress *addr, Error **errp);
 #endif
diff --git a/migration/exec.c b/migration/exec.c
index c3085e803e..a1a7ede3b4 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -40,7 +40,8 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_connect_outgoing(MigrationState *s, strList *command, Error **errp)
+QIOChannel *exec_connect_outgoing(MigrationState *s, strList *command,
+                                  Error **errp)
 {
     QIOChannel *ioc = NULL;
     g_auto(GStrv) argv = strv_from_str_list(command);
@@ -50,12 +51,11 @@ void exec_connect_outgoing(MigrationState *s, strList *command, Error **errp)
     trace_migration_exec_outgoing(new_command);
     ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
-        return;
+        return NULL;
     }
 
     qio_channel_set_name(ioc, "migration-exec-outgoing");
-    migration_channel_connect_outgoing(s, ioc);
-    object_unref(OBJECT(ioc));
+    return ioc;
 }
 
 static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/exec.h b/migration/exec.h
index e7e8e475ac..3e39270dce 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -20,10 +20,13 @@
 #ifndef QEMU_MIGRATION_EXEC_H
 #define QEMU_MIGRATION_EXEC_H
 
+#include "io/channel.h"
+
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
 void exec_connect_incoming(strList *host_port, Error **errp);
 
-void exec_connect_outgoing(MigrationState *s, strList *host_port, Error **errp);
+QIOChannel *exec_connect_outgoing(MigrationState *s, strList *host_port,
+                                  Error **errp);
 #endif
diff --git a/migration/fd.c b/migration/fd.c
index b689426ad4..bbf380d1a0 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,12 +49,13 @@ static bool migration_fd_valid(int fd)
     return false;
 }
 
-void fd_connect_outgoing(MigrationState *s, const char *fdname, Error **errp)
+QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
+                                Error **errp)
 {
-    QIOChannel *ioc;
+    QIOChannel *ioc = NULL;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
     if (fd == -1) {
-        return;
+        goto out;
     }
 
     if (!migration_fd_valid(fd)) {
@@ -66,12 +67,12 @@ void fd_connect_outgoing(MigrationState *s, const char *fdname, Error **errp)
     ioc = qio_channel_new_fd(fd, errp);
     if (!ioc) {
         close(fd);
-        return;
+        goto out;
     }
 
     qio_channel_set_name(ioc, "migration-fd-outgoing");
-    migration_channel_connect_outgoing(s, ioc);
-    object_unref(OBJECT(ioc));
+out:
+    return ioc;
 }
 
 static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/fd.h b/migration/fd.h
index 7211629270..ce0b751273 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -16,8 +16,11 @@
 
 #ifndef QEMU_MIGRATION_FD_H
 #define QEMU_MIGRATION_FD_H
+
+#include "io/channel.h"
+
 void fd_connect_incoming(const char *fdname, Error **errp);
 
-void fd_connect_outgoing(MigrationState *s, const char *fdname,
-                         Error **errp);
+QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
+                                Error **errp);
 #endif
diff --git a/migration/file.c b/migration/file.c
index b7b0fb5194..5618aced49 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -93,36 +93,38 @@ out:
     return ret;
 }
 
-void file_connect_outgoing(MigrationState *s,
-                           FileMigrationArgs *file_args, Error **errp)
+QIOChannel *file_connect_outgoing(MigrationState *s,
+                                  FileMigrationArgs *file_args, Error **errp)
 {
-    g_autoptr(QIOChannelFile) fioc = NULL;
+    QIOChannelFile *fioc = NULL;
     g_autofree char *filename = g_strdup(file_args->filename);
     uint64_t offset = file_args->offset;
-    QIOChannel *ioc;
+    QIOChannel *ioc = NULL;
 
     trace_migration_file_outgoing(filename);
 
     fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY, 0600, errp);
     if (!fioc) {
-        return;
+        goto out;
     }
 
     if (ftruncate(fioc->fd, offset)) {
         error_setg_errno(errp, errno,
                          "failed to truncate migration file to offset %" PRIx64,
                          offset);
-        return;
+        goto out;
     }
 
     outgoing_args.fname = g_strdup(filename);
 
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
-        return;
+        ioc = NULL;
+        goto out;
     }
     qio_channel_set_name(ioc, "migration-file-outgoing");
-    migration_channel_connect_outgoing(s, ioc);
+out:
+    return ioc;
 }
 
 static gboolean file_accept_incoming_migration(QIOChannel *ioc,
diff --git a/migration/file.h b/migration/file.h
index 9b1e874bb7..5936c64fea 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -9,14 +9,15 @@
 #define QEMU_MIGRATION_FILE_H
 
 #include "qapi/qapi-types-migration.h"
+#include "io/channel.h"
 #include "io/task.h"
 #include "channel.h"
 #include "multifd.h"
 
 void file_connect_incoming(FileMigrationArgs *file_args, Error **errp);
 
-void file_connect_outgoing(MigrationState *s,
-                           FileMigrationArgs *file_args, Error **errp);
+QIOChannel *file_connect_outgoing(MigrationState *s,
+                                  FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
diff --git a/migration/migration.c b/migration/migration.c
index 9e69141e86..c75c2c7e52 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2217,9 +2217,8 @@ out:
 static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    Error *local_err = NULL;
 
-    migration_connect_outgoing(s, addr, &local_err);
+    migration_connect_outgoing(s, addr, errp);
 }
 
 void qmp_migrate_cancel(Error **errp)
diff --git a/migration/rdma.c b/migration/rdma.c
index 6e9ca5f5f6..3db3a89bdb 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3923,8 +3923,8 @@ err:
     g_free(rdma);
 }
 
-void rdma_connect_outgoing(void *opaque,
-                           InetSocketAddress *host_port, Error **errp)
+QIOChannel *rdma_connect_outgoing(void *opaque,
+                                  InetSocketAddress *host_port, Error **errp)
 {
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
@@ -3934,7 +3934,7 @@ void rdma_connect_outgoing(void *opaque,
     /* Avoid ram_block_discard_disable(), cannot change during migration. */
     if (ram_block_discard_is_required()) {
         error_setg(errp, "RDMA: cannot disable RAM discard");
-        return;
+        return NULL;
     }
 
     rdma = qemu_rdma_data_init(host_port, errp);
@@ -3984,12 +3984,11 @@ void rdma_connect_outgoing(void *opaque,
     trace_rdma_connect_outgoing_after_rdma_connect();
 
     s->rdma_migration = true;
-    migration_outgoing_setup(rdma_new_ioc(rdma));
-    migration_start_outgoing(s);
-    return;
+    return rdma_new_ioc(rdma);
 return_path_err:
     qemu_rdma_cleanup(rdma);
 err:
     g_free(rdma);
     g_free(rdma_return_path);
+    return NULL;
 }
diff --git a/migration/rdma.h b/migration/rdma.h
index 170c25cf44..8a6515f130 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -21,8 +21,8 @@
 
 #include "system/memory.h"
 
-void rdma_connect_outgoing(void *opaque, InetSocketAddress *host_port,
-                           Error **errp);
+QIOChannel *rdma_connect_outgoing(void *opaque, InetSocketAddress *host_port,
+                                  Error **errp);
 
 void rdma_connect_incoming(InetSocketAddress *host_port, Error **errp);
 
-- 
2.51.0


