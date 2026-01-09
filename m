Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC9CD1A618
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBoU-0005Tg-Bv; Fri, 09 Jan 2026 07:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoS-0005PR-VP
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:57 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoQ-0007NI-N0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0155D5BCE7;
 Fri,  9 Jan 2026 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXDLmk9wvX2ylogkwQAW9169g8AFr/89eCMogpDIvik=;
 b=pMA1ZbQPs7KgWAIKefDgs5dj2d4sjOcPeFGimbLPtWt8jriY/QrNmkEjSb5Z/LIUtzanfT
 a5hOJg9LDz3uevFUQeAqvl1ThOi7R4b0XpbnR+hAC/j9xq36s3nl4HitWpswb2/qHznAej
 cuqKZImb+xdVnwZHXNqP42RnBTigZ9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXDLmk9wvX2ylogkwQAW9169g8AFr/89eCMogpDIvik=;
 b=49YbprRWRDXBIYuz1bLRIHid52GZxWcMLmWIkJQeotvfcxTcbxElqcl/wSBfvL+jGVM3T9
 H2YLWMFJ9UWbR6CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXDLmk9wvX2ylogkwQAW9169g8AFr/89eCMogpDIvik=;
 b=pMA1ZbQPs7KgWAIKefDgs5dj2d4sjOcPeFGimbLPtWt8jriY/QrNmkEjSb5Z/LIUtzanfT
 a5hOJg9LDz3uevFUQeAqvl1ThOi7R4b0XpbnR+hAC/j9xq36s3nl4HitWpswb2/qHznAej
 cuqKZImb+xdVnwZHXNqP42RnBTigZ9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXDLmk9wvX2ylogkwQAW9169g8AFr/89eCMogpDIvik=;
 b=49YbprRWRDXBIYuz1bLRIHid52GZxWcMLmWIkJQeotvfcxTcbxElqcl/wSBfvL+jGVM3T9
 H2YLWMFJ9UWbR6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6869F3EA63;
 Fri,  9 Jan 2026 12:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0HsECoH3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 25/25] migration/channel: Centralize calling
 migration_channel_connect_outgoing
Date: Fri,  9 Jan 2026 09:40:41 -0300
Message-ID: <20260109124043.25019-26-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
migration_channel_connect_outgoing() in the transport code. Have those
functions return and call the function at the upper level.

This helps with navigation: the transport code returns the ioc,
there's no need to look into them when browsing the code.

It also allows RDMA in the source side to use the same path as the
rest of the transports.

While here, document the async calls which are the exception.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 28 ++++++++++++++++++++++++----
 migration/exec.c    |  8 ++++----
 migration/exec.h    |  5 ++++-
 migration/fd.c      | 13 +++++++------
 migration/fd.h      |  7 +++++--
 migration/file.c    | 18 ++++++++++--------
 migration/file.h    |  5 +++--
 migration/rdma.c    | 11 +++++------
 migration/rdma.h    |  4 ++--
 9 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index cee78532ea..589a5520fe 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -37,26 +37,40 @@
 void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
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
+            return;
+
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
+    if (ioc) {
+        migration_channel_connect_outgoing(s, ioc);
+    }
+
+    return;
 }
 
 void migration_connect_incoming(MigrationAddress *addr, Error **errp)
@@ -81,6 +95,12 @@ void migration_connect_incoming(MigrationAddress *addr, Error **errp)
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
diff --git a/migration/rdma.c b/migration/rdma.c
index b726392097..5d78c1827a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3934,8 +3934,8 @@ err:
     g_free(rdma);
 }
 
-void rdma_connect_outgoing(void *opaque,
-                           InetSocketAddress *host_port, Error **errp)
+QIOChannel *rdma_connect_outgoing(void *opaque,
+                                  InetSocketAddress *host_port, Error **errp)
 {
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
@@ -3945,7 +3945,7 @@ void rdma_connect_outgoing(void *opaque,
     /* Avoid ram_block_discard_disable(), cannot change during migration. */
     if (ram_block_discard_is_required()) {
         error_setg(errp, "RDMA: cannot disable RAM discard");
-        return;
+        return NULL;
     }
 
     rdma = qemu_rdma_data_init(host_port, errp);
@@ -3995,12 +3995,11 @@ void rdma_connect_outgoing(void *opaque,
     trace_rdma_connect_outgoing_after_rdma_connect();
 
     s->rdma_migration = true;
-    migration_outgoing_setup(rdma_new_output(rdma));
-    migration_start_outgoing(s);
-    return;
+    return rdma_new_output(rdma);
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


