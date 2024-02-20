Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC21FC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYpZ-0005tM-6W; Tue, 20 Feb 2024 17:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpI-0005Sq-CR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:43:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpG-0006Ql-Ip
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:43:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F66D22260;
 Tue, 20 Feb 2024 22:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5C9w2KATBwTJIbNr5Ug7RH1uQzsJk6+jTIElw4CtlY=;
 b=hoSCAQ2fDSZEzM9sOa8+hNde47bWCSpkBQyXaukT/h/WMLWEhkSzsubmHI8Iodwo8x1N25
 NvK1hUX62yqsIVO5MkNLtGU/ERmy1s5wHkbF4+ST+Mmz83cT1TTyrnafSCh8meunPXE8xg
 Q+0KAp2JXlosSJK/GScvSE04DHzLwEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5C9w2KATBwTJIbNr5Ug7RH1uQzsJk6+jTIElw4CtlY=;
 b=rLbkNN5mYFjx2MvLTNNQY33lMKp2YcxY8Fi6ZoSwWTRxU42yntKlza0MLbkjPszM8waOTD
 wTiw9UD6LkpMJrBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5C9w2KATBwTJIbNr5Ug7RH1uQzsJk6+jTIElw4CtlY=;
 b=hoSCAQ2fDSZEzM9sOa8+hNde47bWCSpkBQyXaukT/h/WMLWEhkSzsubmHI8Iodwo8x1N25
 NvK1hUX62yqsIVO5MkNLtGU/ERmy1s5wHkbF4+ST+Mmz83cT1TTyrnafSCh8meunPXE8xg
 Q+0KAp2JXlosSJK/GScvSE04DHzLwEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5C9w2KATBwTJIbNr5Ug7RH1uQzsJk6+jTIElw4CtlY=;
 b=rLbkNN5mYFjx2MvLTNNQY33lMKp2YcxY8Fi6ZoSwWTRxU42yntKlza0MLbkjPszM8waOTD
 wTiw9UD6LkpMJrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AED88139D0;
 Tue, 20 Feb 2024 22:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KEZbHe8q1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 33/34] migration: Add support for fdset with multifd + file
Date: Tue, 20 Feb 2024 19:41:37 -0300
Message-Id: <20240220224138.24759-34-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hoSCAQ2f;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rLbkNN5m
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
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 4F66D22260
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

Allow multifd to use an fdset when migrating to a file. This is useful
for the scenario where the management layer wants to have control over
the migration file.

By receiving the file descriptors directly, QEMU can delegate some
high level operating system operations to the management layer (such
as mandatory access control). The management layer might also want to
add its own headers before the migration stream.

Enable the "file:/dev/fdset/#" syntax for the multifd migration with
fixed-ram. The requirements for the fdset mechanism are:

On the migration source side:

- the fdset must contain two fds that are not duplicates between
  themselves;
- if direct-io is to be used, exactly one of the fds must have the
  O_DIRECT flag set;
- the file must be opened with WRONLY both times.

On the migration destination side:

- the fdset must contain one fd;
- the file must be opened with RDONLY.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/main.rst | 18 +++++++
 migration/file.c              | 97 +++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 8024275d6d..ac6b6a8eb0 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -46,6 +46,24 @@ over any transport.
   application to add its own metadata to the start of the file without
   QEMU interference.
 
+  The file migration also supports using a file that has already been
+  opened. A set of file descriptors is passed to QEMU via an "fdset"
+  (see add-fd QMP command documentation). This method allows a
+  management application to have control over the migration file
+  opening operation. There are, however, strict requirements to this
+  interface:
+
+  On the migration source side:
+    - the fdset must contain two file descriptors that are not
+      duplicates between themselves;
+    - if the direct-io capability is to be used, exactly one of the
+      file descriptors must have the O_DIRECT flag set;
+    - the file must be opened with WRONLY both times.
+
+  On the migration destination side:
+    - the fdset must contain one file descriptor;
+    - the file must be opened with RDONLY.
+
 In addition, support is included for migration using RDMA, which
 transports the page data using ``RDMA``, where the hardware takes care of
 transporting the pages, and the load on the CPU is much lower.  While the
diff --git a/migration/file.c b/migration/file.c
index f1c7615fb6..95f3210faf 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -10,12 +10,14 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
 #include "channel.h"
 #include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "monitor/monitor.h"
 #include "options.h"
 #include "trace.h"
 
@@ -23,6 +25,7 @@
 
 static struct FileOutgoingArgs {
     char *fname;
+    int64_t fdset_id;
 } outgoing_args;
 
 /* Remove the offset option from @filespec and return it in @offsetp. */
@@ -44,6 +47,84 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+/*
+ * If the open flags and file status flags from the file descriptors
+ * in the fdset don't match what QEMU expects, errno gets set to
+ * EACCES. Let's provide a more user-friendly message.
+ */
+static void file_fdset_error(int flags, Error **errp)
+{
+    ERRP_GUARD();
+
+    if (errno == EACCES) {
+        /* ditch the previous error */
+        error_free(*errp);
+        *errp = NULL;
+
+        error_setg(errp, "Fdset is missing a file descriptor with flags: 0x%x",
+                   flags);
+    }
+}
+
+static void file_remove_fdset(void)
+{
+    if (outgoing_args.fdset_id != -1) {
+        qmp_remove_fd(outgoing_args.fdset_id, false, -1, NULL);
+        outgoing_args.fdset_id = -1;
+    }
+}
+
+/*
+ * Due to the behavior of the dup() system call, we need the fdset to
+ * have two non-duplicate fds so we can enable direct IO in the
+ * secondary channels without affecting the main channel.
+ */
+static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
+                             Error **errp)
+{
+    FdsetInfoList *fds_info;
+    FdsetFdInfoList *fd_info;
+    const char *fdset_id_str;
+    int nfds = 0;
+
+    *fdset_id = -1;
+
+    if (!strstart(filename, "/dev/fdset/", &fdset_id_str)) {
+        return true;
+    }
+
+    if (!migrate_multifd()) {
+        error_setg(errp, "fdset is only supported with multifd");
+        return false;
+    }
+
+    *fdset_id = qemu_parse_fd(fdset_id_str);
+
+    for (fds_info = qmp_query_fdsets(NULL); fds_info;
+         fds_info = fds_info->next) {
+
+        if (*fdset_id != fds_info->value->fdset_id) {
+            continue;
+        }
+
+        for (fd_info = fds_info->value->fds; fd_info; fd_info = fd_info->next) {
+            if (nfds++ > 2) {
+                break;
+            }
+        }
+    }
+
+    if (nfds != 2) {
+        error_setg(errp, "Outgoing migration needs two fds in the fdset, "
+                   "got %d", nfds);
+        qmp_remove_fd(*fdset_id, false, -1, NULL);
+        *fdset_id = -1;
+        return false;
+    }
+
+    return true;
+}
+
 int file_send_channel_destroy(QIOChannel *ioc)
 {
     if (ioc) {
@@ -52,6 +133,7 @@ int file_send_channel_destroy(QIOChannel *ioc)
     g_free(outgoing_args.fname);
     outgoing_args.fname = NULL;
 
+    file_remove_fdset();
     return 0;
 }
 
@@ -82,6 +164,7 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
     } else {
         ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
         if (!ioc) {
+            file_fdset_error(flags, errp);
             return false;
         }
     }
@@ -105,13 +188,18 @@ void file_start_outgoing_migration(MigrationState *s,
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
-    if (!fioc) {
+    if (!file_parse_fdset(filename, &outgoing_args.fdset_id, errp)) {
         return;
     }
 
     outgoing_args.fname = g_strdup(filename);
 
+    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
+    if (!fioc) {
+        file_fdset_error(flags, errp);
+        return;
+    }
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
@@ -135,12 +223,13 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
     int channels = 1;
-    int i = 0, fd;
+    int i = 0, fd, flags = O_RDONLY;
 
     trace_migration_file_incoming(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
+    fioc = qio_channel_file_new_path(filename, flags, 0, errp);
     if (!fioc) {
+        file_fdset_error(flags, errp);
         return;
     }
 
-- 
2.35.3


