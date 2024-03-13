Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AA3C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkW9P-0007Qs-AA; Wed, 13 Mar 2024 17:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkW9O-0007Qh-G1
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:28:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkW9J-0006p6-AG
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:28:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C28D61F7F1;
 Wed, 13 Mar 2024 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710365311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cX6bB0KFmqQRRvMEhyeCMzPVc0iaic9MJrea1Qqjbo=;
 b=BFUz0umQwmYX6W9v515VFQvpxL6YOPdqOL/0i+xzusfRfcJcXeQoeLyg7AV61sKhcCA90X
 96GpTn95l7Dfv/Kj9d9l1Mvp5YEph2MPKPoDrBs6NHt1lG1TohVyAn5n8WMIFL/f072EWG
 HRgKwxOrZTIR5sQJA2obJxY+TD31x6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710365311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cX6bB0KFmqQRRvMEhyeCMzPVc0iaic9MJrea1Qqjbo=;
 b=hCprlf2+6GX0mjSYwhzSz7+Tm//844Q4ZXPKfxI3Nt+v4/fL8NNYflUY3XUc9RbveT6q0M
 MbvJDqkXkoGbg5DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710365310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cX6bB0KFmqQRRvMEhyeCMzPVc0iaic9MJrea1Qqjbo=;
 b=arLz/xxJZybcqviND+40rXYir7hmbwOl+SPNP55UR7N3W7KGOpDUyi46vVzn0euXtA95QV
 DLc/TJyse7aXnHkKM1UFk9GoArXX6rYAzjf89k6a7BdjWKnjKAU8SLmJnVMXxZqWqWJXYK
 9ou5iUrjxDZO3ocMTDGBvOAFWmd5Kj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710365310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cX6bB0KFmqQRRvMEhyeCMzPVc0iaic9MJrea1Qqjbo=;
 b=j+zqssmpsk/hmpLE4JeUKXRji9EKlMycg1mVTaZMMGHRRMRtVitY3FjlfFl1FSvDjVMmNy
 x17CgWo6xh2bUaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A12D13977;
 Wed, 13 Mar 2024 21:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2MZDGH0a8mX/ZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Mar 2024 21:28:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 1/2] migration: Fix iocs leaks during file and fd migration
Date: Wed, 13 Mar 2024 18:28:23 -0300
Message-Id: <20240313212824.16974-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313212824.16974-1-farosas@suse.de>
References: <20240313212824.16974-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="arLz/xxJ";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j+zqssmp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: C28D61F7F1
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

The memory for the io channels is being leaked in three different ways
during file migration:

1) if the offset check fails we never drop the ioc reference;

2) we allocate an extra channel for no reason;

3) if multifd is enabled but channel creation fails when calling
   dup(), we leave the previous channels around along with the glib
   polling;

Fix all issues by restructuring the code to first allocate the
channels and only register the watches when all channels have been
created.

For multifd, the file and fd migrations can share code because both
are backed by a QIOChannelFile. For the non-multifd case, the fd needs
to be separate because it is backed by a QIOChannelSocket.

Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c   | 29 +++++++-----------------
 migration/file.c | 58 ++++++++++++++++++++++++++++++------------------
 migration/file.h |  1 +
 3 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 4e2a63a73d..39a52e5c90 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
+#include "file.h"
 #include "migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-file.h"
@@ -80,7 +81,6 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 void fd_start_incoming_migration(const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
-    QIOChannelFile *fioc;
     int fd = monitor_fd_param(monitor_cur(), fdname, errp);
     if (fd == -1) {
         return;
@@ -94,26 +94,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    qio_channel_set_name(ioc, "migration-fd-incoming");
-    qio_channel_add_watch_full(ioc, G_IO_IN,
-                               fd_accept_incoming_migration,
-                               NULL, NULL,
-                               g_main_context_get_thread_default());
-
     if (migrate_multifd()) {
-        int channels = migrate_multifd_channels();
-
-        while (channels--) {
-            fioc = qio_channel_file_new_dupfd(fd, errp);
-            if (!fioc) {
-                return;
-            }
-
-            qio_channel_set_name(ioc, "migration-fd-incoming");
-            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
-                                       fd_accept_incoming_migration,
-                                       NULL, NULL,
-                                       g_main_context_get_thread_default());
-        }
+        file_create_incoming_channels(ioc, errp);
+    } else {
+        qio_channel_set_name(ioc, "migration-fd-incoming");
+        qio_channel_add_watch_full(ioc, G_IO_IN,
+                                   fd_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
     }
 }
diff --git a/migration/file.c b/migration/file.c
index e56c5eb0a5..ddde0ca818 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -115,13 +115,46 @@ static gboolean file_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
+void file_create_incoming_channels(QIOChannel *ioc, Error **errp)
+{
+    int i, fd, channels = 1;
+    g_autofree QIOChannel **iocs = NULL;
+
+    if (migrate_multifd()) {
+        channels += migrate_multifd_channels();
+    }
+
+    iocs = g_new0(QIOChannel *, channels);
+    fd = QIO_CHANNEL_FILE(ioc)->fd;
+    iocs[0] = ioc;
+
+    for (i = 1; i < channels; i++) {
+        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
+
+        if (!fioc) {
+            while (i) {
+                object_unref(iocs[--i]);
+            }
+            return;
+        }
+
+        iocs[i] = QIO_CHANNEL(fioc);
+    }
+
+    for (i = 0; i < channels; i++) {
+        qio_channel_set_name(iocs[i], "migration-file-incoming");
+        qio_channel_add_watch_full(iocs[i], G_IO_IN,
+                                   file_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
+    }
+}
+
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 {
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
-    int channels = 1;
-    int i = 0;
 
     trace_migration_file_incoming(filename);
 
@@ -132,28 +165,11 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 
     if (offset &&
         qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
+        object_unref(OBJECT(fioc));
         return;
     }
 
-    if (migrate_multifd()) {
-        channels += migrate_multifd_channels();
-    }
-
-    do {
-        QIOChannel *ioc = QIO_CHANNEL(fioc);
-
-        qio_channel_set_name(ioc, "migration-file-incoming");
-        qio_channel_add_watch_full(ioc, G_IO_IN,
-                                   file_accept_incoming_migration,
-                                   NULL, NULL,
-                                   g_main_context_get_thread_default());
-
-        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
-
-        if (!fioc) {
-            break;
-        }
-    } while (++i < channels);
+    file_create_incoming_channels(QIO_CHANNEL(fioc), errp);
 }
 
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
diff --git a/migration/file.h b/migration/file.h
index 9f71e87f74..7699c04677 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -20,6 +20,7 @@ void file_start_outgoing_migration(MigrationState *s,
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
+void file_create_incoming_channels(QIOChannel *ioc, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
-- 
2.35.3


