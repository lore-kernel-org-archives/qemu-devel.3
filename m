Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343BC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYos-0003y3-1y; Tue, 20 Feb 2024 17:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYop-0003lc-Vw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYon-0006MW-VP
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 892771FD64;
 Tue, 20 Feb 2024 22:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohuWdlJcu0dwg63rQ3ay7lscIVfrPEECXbytyXa4Byw=;
 b=vzSJjL7oaYezfUeGKKsClcvWOsdX4jPOKFZcGDSLkvxq/qED2+dCHp1sWgMZc6dzedKteU
 GNWQ34ChppQKAESkGQTpTdXvO1xa8GO44EBFBM/NCD+2a3cjzw8xu55Lb6O98AAOYzV47m
 53Kva+3gx68c4mLvbFFd1PL86iP2xsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohuWdlJcu0dwg63rQ3ay7lscIVfrPEECXbytyXa4Byw=;
 b=Z0VGOhAK6eyxeDnqW8ZogkQWNrqwP8wD8q3pWGPITYZToMX74wgN6XYfgWh4Ibl7cOOGnc
 /WpkuN0G09KOqKDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohuWdlJcu0dwg63rQ3ay7lscIVfrPEECXbytyXa4Byw=;
 b=vzSJjL7oaYezfUeGKKsClcvWOsdX4jPOKFZcGDSLkvxq/qED2+dCHp1sWgMZc6dzedKteU
 GNWQ34ChppQKAESkGQTpTdXvO1xa8GO44EBFBM/NCD+2a3cjzw8xu55Lb6O98AAOYzV47m
 53Kva+3gx68c4mLvbFFd1PL86iP2xsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohuWdlJcu0dwg63rQ3ay7lscIVfrPEECXbytyXa4Byw=;
 b=Z0VGOhAK6eyxeDnqW8ZogkQWNrqwP8wD8q3pWGPITYZToMX74wgN6XYfgWh4Ibl7cOOGnc
 /WpkuN0G09KOqKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9814139D0;
 Tue, 20 Feb 2024 22:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uPRjK9Iq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 20/34] migration/multifd: Add outgoing QIOChannelFile
 support
Date: Tue, 20 Feb 2024 19:41:24 -0300
Message-Id: <20240220224138.24759-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Allow multifd to open file-backed channels. This will be used when
enabling the fixed-ram migration stream format which expects a
seekable transport.

The QIOChannel read and write methods will use the preadv/pwritev
versions which don't update the file offset at each call so we can
reuse the fd without re-opening for every channel.

Contrary to the socket migration, the file migration doesn't need an
asynchronous channel creation process, so expose
multifd_channel_connect() and call it directly.

Note that this is just setup code and multifd cannot yet make use of
the file channels.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c    | 40 ++++++++++++++++++++++++++++++++++++++--
 migration/file.h    |  5 +++++
 migration/multifd.c | 27 ++++++++++++++++++++++-----
 migration/multifd.h |  2 ++
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 22d052a71f..ac9f6ae40a 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -12,12 +12,17 @@
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
+#include "multifd.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
 #include "trace.h"
 
 #define OFFSET_OPTION ",offset="
 
+static struct FileOutgoingArgs {
+    char *fname;
+} outgoing_args;
+
 /* Remove the offset option from @filespec and return it in @offsetp. */
 
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
@@ -37,6 +42,34 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+int file_send_channel_destroy(QIOChannel *ioc)
+{
+    if (ioc) {
+        qio_channel_close(ioc, NULL);
+    }
+    g_free(outgoing_args.fname);
+    outgoing_args.fname = NULL;
+
+    return 0;
+}
+
+bool file_send_channel_create(gpointer opaque, Error **errp)
+{
+    QIOChannelFile *ioc;
+    int flags = O_WRONLY;
+
+    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
+    if (!ioc) {
+        return false;
+    }
+
+    if (!multifd_channel_connect(opaque, QIO_CHANNEL(ioc), errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 void file_start_outgoing_migration(MigrationState *s,
                                    FileMigrationArgs *file_args, Error **errp)
 {
@@ -44,15 +77,18 @@ void file_start_outgoing_migration(MigrationState *s,
     g_autofree char *filename = g_strdup(file_args->filename);
     uint64_t offset = file_args->offset;
     QIOChannel *ioc;
+    int flags = O_CREAT | O_TRUNC | O_WRONLY;
+    mode_t mode = 0660;
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
-                                     0600, errp);
+    fioc = qio_channel_file_new_path(filename, flags, mode, errp);
     if (!fioc) {
         return;
     }
 
+    outgoing_args.fname = g_strdup(filename);
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
diff --git a/migration/file.h b/migration/file.h
index 37d6a08bfc..90794b494b 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -9,10 +9,15 @@
 #define QEMU_MIGRATION_FILE_H
 
 #include "qapi/qapi-types-migration.h"
+#include "io/task.h"
+#include "channel.h"
 
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
 
 void file_start_outgoing_migration(MigrationState *s,
                                    FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
+
+bool file_send_channel_create(gpointer opaque, Error **errp);
+int file_send_channel_destroy(QIOChannel *ioc);
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index 45a0c7aaa8..507b497d52 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -17,6 +17,7 @@
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "file.h"
 #include "ram.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -28,6 +29,7 @@
 #include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
+#include "io/channel-file.h"
 #include "io/channel-socket.h"
 #include "yank_functions.h"
 
@@ -680,6 +682,9 @@ static void multifd_send_terminate_threads(void)
 
 static int multifd_send_channel_destroy(QIOChannel *send)
 {
+    if (!multifd_use_packets()) {
+        return file_send_channel_destroy(send);
+    }
     return socket_send_channel_destroy(send);
 }
 
@@ -959,9 +964,8 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     return true;
 }
 
-static bool multifd_channel_connect(MultiFDSendParams *p,
-                                    QIOChannel *ioc,
-                                    Error **errp)
+bool multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc,
+                             Error **errp)
 {
     qio_channel_set_delay(ioc, false);
 
@@ -1031,9 +1035,14 @@ out:
     error_free(local_err);
 }
 
-static void multifd_new_send_channel_create(gpointer opaque)
+static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
 {
+    if (!multifd_use_packets()) {
+        return file_send_channel_create(opaque, errp);
+    }
+
     socket_send_channel_create(multifd_new_send_channel_async, opaque);
+    return true;
 }
 
 bool multifd_send_setup(void)
@@ -1082,7 +1091,15 @@ bool multifd_send_setup(void)
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
-        multifd_new_send_channel_create(p);
+
+        if (!multifd_new_send_channel_create(p, &local_err)) {
+            /*
+             * File channel creation is synchronous, we don't need the
+             * semaphore below, it's safe to return now.
+             */
+            assert(migrate_fixed_ram());
+            return -1;
+        }
     }
 
     if (use_packets) {
diff --git a/migration/multifd.h b/migration/multifd.h
index 19188815a3..135f6ed098 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -228,5 +228,7 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
     p->iovs_num++;
 }
 
+bool multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc,
+                             Error **errp);
 
 #endif
-- 
2.35.3


