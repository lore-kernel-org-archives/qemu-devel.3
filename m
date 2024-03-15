Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208FAC54E5D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rky7w-0003ya-SS; Thu, 14 Mar 2024 23:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7t-0003xx-Ax
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:20:57 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rky7n-0004IW-0s
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:20:56 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D62C721D94;
 Fri, 15 Mar 2024 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74RrPFY9zjw0wZcmCjd84GqQxrgaar52OmG+YS4MfCg=;
 b=T3AmefCsFJZn6A7+Ium+jlClDi9Mi8Q+y8m9HE+XYfxRuVKNVeY2bgjqGescdz59S4vAUR
 xa/h3jHmXWzn9eH9cSULjNsJO4Ucbca7Fl39QQ8lautB7oHrBJ8Qj+GtN+bzQ0dhfmTtbZ
 fSX3dMJ9hE7jDgUePe7lqUAwEt3TTZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74RrPFY9zjw0wZcmCjd84GqQxrgaar52OmG+YS4MfCg=;
 b=sWyHrU94irLQV6iv56gz4vBTWMRXd0a1t4ETR/qHhZawXZnNBu65odEJ5kbOZ6wv2q4nVw
 PdD8d39xyBeaZUDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710472849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74RrPFY9zjw0wZcmCjd84GqQxrgaar52OmG+YS4MfCg=;
 b=T3AmefCsFJZn6A7+Ium+jlClDi9Mi8Q+y8m9HE+XYfxRuVKNVeY2bgjqGescdz59S4vAUR
 xa/h3jHmXWzn9eH9cSULjNsJO4Ucbca7Fl39QQ8lautB7oHrBJ8Qj+GtN+bzQ0dhfmTtbZ
 fSX3dMJ9hE7jDgUePe7lqUAwEt3TTZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710472849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74RrPFY9zjw0wZcmCjd84GqQxrgaar52OmG+YS4MfCg=;
 b=sWyHrU94irLQV6iv56gz4vBTWMRXd0a1t4ETR/qHhZawXZnNBu65odEJ5kbOZ6wv2q4nVw
 PdD8d39xyBeaZUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EECA1368C;
 Fri, 15 Mar 2024 03:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wMj3AZC+82XZcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Mar 2024 03:20:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Date: Fri, 15 Mar 2024 00:20:40 -0300
Message-Id: <20240315032040.7974-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240315032040.7974-1-farosas@suse.de>
References: <20240315032040.7974-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T3AmefCs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sWyHrU94
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: D62C721D94
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The fd: URI has supported migration to a file or socket since before
QEMU 8.2. In 8.2 we added the file: URI that supported migration to a
file. So now we have two ways (three if you count exec:>cat) to
migrate to a file. Fine.

However,

In 8.2 we also added the new qmp_migrate API that uses a JSON channel
list instead of the URI. It added two migration transports SOCKET and
FILE. It was decided that the new API would classify the fd migration
as a type of socket migration, neglecting the fact that the fd.c code
also supported file migrations.

In 9.0 we're adding support for fd + multifd + mapped-ram, which is
tied to the file migration. This was implemented in fd.c, which is
only reachable when the SOCKET address type is used.

The result of this is that we're asking users of the new API to create   (1)
something called a "socket" to perform migration to a plain file. And
creating something called a "file" provides no way of passing in a
file descriptor. This is confusing.

The new API also parses the old-style URI into the new-style data
structures, so the old and correct fd:<filefd> now also considers fd:
to be socket-related only.

Unlike the other migration addresses, the fd comes already setup from
the user, it's not just a string that QEMU will use to start a
connection. We need to actually fetch the fd from the monitor before
even being able to poke at it to know if it is a socket.

Aside from the issue (1) above, the current approach of parsing the fd
into a SOCKET and only later deciding if it is file-backed doesn't
work well now that we're adding multifd support for fd: and file:
migration via the mapped-ram feature. With a larger number of
combinations, we need to be able to know upfront when an fd is backed
by a plain file vs. a socket.

We're currently using a trick of allowing socket channels to pass some   (2)
validation that they shouldn't, to only later verify if the fd was
indeed a socket.

To clean this up I'm proposing we start requiring users of the new API
to use the "file" structure when the migration stream will end up in a
file and use the "socket" structure when the fd points to an actual
socket. This improves (1).

To keep backward compatibility, I'm still accepting everything that
was accepted before and only changing the structures internally to
allow the rest of the code to rely on the MIGRATION_ADDRESS_TYPE. This
addresses (2).

We can then slowly deprecate the wrong way, i.e. using type socket for
fd + file migration.

In this patch you'll find:

- a new function migrate_resolve_fd() that fetches the fd from the
  monitor and converts the MigrationAddress into the correct type;

- the removal of the hacks for (2);

- a helper function to convert the resolved fd that's represented as a
  string for storage in the MigrationAddress back into an integer for
  consumption.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c        |  15 +------
 migration/file.c      |  14 +++---
 migration/migration.c | 100 ++++++++++++++++++++++++++++++++++++------
 migration/migration.h |   1 +
 qapi/migration.json   |  11 ++++-
 5 files changed, 107 insertions(+), 34 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index fe0d096abd..2d4414c7ea 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -20,9 +20,6 @@
 #include "fd.h"
 #include "file.h"
 #include "migration.h"
-#include "monitor/monitor.h"
-#include "io/channel-file.h"
-#include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "options.h"
 #include "trace.h"
@@ -48,8 +45,7 @@ void fd_cleanup_outgoing_migration(void)
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
-    int fd = monitor_get_fd(monitor_cur(), fdname, errp);
-    int newfd;
+    int newfd, fd = migrate_fd_str_to_int(fdname, errp);
 
     if (fd == -1) {
         return;
@@ -91,7 +87,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 void fd_start_incoming_migration(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
-    int fd = monitor_fd_param(monitor_cur(), fdname, errp);
+    int fd = migrate_fd_str_to_int(fdname, errp);
     if (fd == -1) {
         return;
     }
@@ -105,13 +101,6 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
     }
 
     if (migrate_multifd()) {
-        if (fd_is_socket(fd)) {
-            error_setg(errp,
-                       "Multifd migration to a socket FD is not supported");
-            object_unref(ioc);
-            return;
-        }
-
         file_create_incoming_channels(ioc, errp);
     } else {
         qio_channel_set_name(ioc, "migration-fd-incoming");
diff --git a/migration/file.c b/migration/file.c
index b6e8ba13f2..b29521ffa7 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -59,12 +59,6 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
     int fd = fd_args_get_fd();
 
     if (fd && fd != -1) {
-        if (fd_is_socket(fd)) {
-            error_setg(errp,
-                       "Multifd migration to a socket FD is not supported");
-            goto out;
-        }
-
         ioc = qio_channel_file_new_dupfd(fd, errp);
     } else {
         ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
@@ -95,6 +89,10 @@ void file_start_outgoing_migration(MigrationState *s,
     uint64_t offset = file_args->offset;
     QIOChannel *ioc;
 
+    if (file_args->fd) {
+        return fd_start_outgoing_migration(s, file_args->fd, errp);
+    }
+
     trace_migration_file_outgoing(filename);
 
     fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
@@ -163,6 +161,10 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
 
+    if (file_args->fd) {
+        return fd_start_incoming_migration(file_args->fd, errp);
+    }
+
     trace_migration_file_incoming(filename);
 
     fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
diff --git a/migration/migration.c b/migration/migration.c
index f60bd371e3..88162205a3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -140,10 +140,6 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
 
-        if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            return migrate_mapped_ram();
-        }
-
         return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
                 saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
                 saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
@@ -165,15 +161,6 @@ static bool transport_supports_seeking(MigrationAddress *addr)
         return true;
     }
 
-    /*
-     * At this point QEMU has not yet fetched the fd passed in by the
-     * user, so we cannot know for sure whether it refers to a plain
-     * file or a socket. Let it through anyway and check at fd.c.
-     */
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        return addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD;
-    }
-
     return false;
 }
 
@@ -608,6 +595,85 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
     return true;
 }
 
+/*
+ * Unlike other types of migration addresses, a file descriptor is not
+ * just a string that QEMU uses to initiate a connection. An fd has to
+ * be prepared in advance by the user or management app.  We only know
+ * whether a file descriptor refers to a socket or a file after
+ * retrieving it from the monitor.
+ *
+ * If the method being used to reference the fds for migration is the
+ * old "fd:" URI, migrate_uri_parse() always parses it into a
+ * MIGRATION_ADDRESS_TYPE_SOCKET.
+ *
+ * If the method is the new channels API, a file descriptor might come
+ * via either the MIGRATION_ADDRESS_TYPE_SOCKET or the
+ * MIGRATION_ADDRESS_TYPE_FILE. For backward compatibility with 8.2
+ * which allowed a file migration with MIGRATION_ADDRESS_TYPE_SOCKET,
+ * this is still allowed.
+ *
+ * This function converts all of the above into
+ * MIGRATION_ADDRESS_TYPE_FILE so the rest of code doesn't need to
+ * care about none of this.
+ */
+static bool migrate_resolve_fd(MigrationAddress *addr, Error **errp)
+{
+    int fd;
+
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        FileMigrationArgs *fargs = &addr->u.file;
+
+        if (fargs->fd) {
+            fd = monitor_fd_param(monitor_cur(), fargs->fd, errp);
+            if (fd == -1) {
+                return false;
+            }
+
+            if (!fd_is_socket(fd)) {
+                addr->u.file.fd = g_strdup_printf("%d", fd);
+            } else {
+                error_setg(errp,
+                           "Migration transport 'file' does not support socket file descriptors");
+                return false;
+            }
+        }
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+
+        if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd = monitor_fd_param(monitor_cur(), saddr->u.fd.str, errp);
+            if (fd == -1) {
+                return false;
+            }
+
+            g_free(saddr->u.fd.str);
+
+            if (!fd_is_socket(fd)) {
+                addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
+                addr->u.file.fd = g_strdup_printf("%d", fd);
+                addr->u.file.filename = NULL;
+                addr->u.file.offset = 0;
+            } else {
+                saddr->u.fd.str = g_strdup_printf("%d", fd);
+            }
+        }
+    }
+
+    return true;
+}
+
+int migrate_fd_str_to_int(const char *fdname, Error **errp)
+{
+    int err, fd;
+
+    err = qemu_strtoi(fdname, NULL, 0, &fd);
+    if (err) {
+        error_setg_errno(errp, err, "failed to convert fd");
+        return -1;
+    }
+    return fd;
+}
+
 static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
@@ -641,6 +707,10 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         addr = channel->addr;
     }
 
+    if (!migrate_resolve_fd(addr, errp)) {
+        return;
+    }
+
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
@@ -2086,6 +2156,10 @@ void qmp_migrate(const char *uri, bool has_channels,
         addr = channel->addr;
     }
 
+    if (!migrate_resolve_fd(addr, errp)) {
+        return;
+    }
+
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
diff --git a/migration/migration.h b/migration/migration.h
index 8045e39c26..e265d1732c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -543,5 +543,6 @@ int migration_rp_wait(MigrationState *s);
  * to remember the target is always the migration thread.
  */
 void migration_rp_kick(MigrationState *s);
+int migrate_fd_str_to_int(const char *fdname, Error **errp);
 
 #endif
diff --git a/qapi/migration.json b/qapi/migration.json
index aa1b39bce1..37f4b9c6fb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1656,13 +1656,20 @@
 #
 # @filename: The file to receive the migration stream
 #
+# @fd: A file descriptor name or number.  File descriptors must be
+#     first added with the 'getfd' command. (since 9.0).
+#
 # @offset: The file offset where the migration stream will start
 #
+# Since 9.0, all members are optional, but at least one of @filename
+# or @fd are required.
+#
 # Since: 8.2
 ##
 { 'struct': 'FileMigrationArgs',
-  'data': { 'filename': 'str',
-            'offset': 'uint64' } }
+  'data': { '*filename': 'str',
+            '*fd': 'str',
+            '*offset': 'uint64' } }
 
 ##
 # @MigrationExecCommand:
-- 
2.35.3


