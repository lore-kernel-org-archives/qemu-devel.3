Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787E3C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYp1-0004lz-S3; Tue, 20 Feb 2024 17:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYp0-0004eX-5j
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:42 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoy-0006P4-Iu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 140CE1FB53;
 Tue, 20 Feb 2024 22:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=087pFkDPQX1LVXFotOh4QCXvp5YTxQZVjf2xUD+QFvM=;
 b=s8QSInhartax+2OgLzD8+SSn07+gd2mLy8q9Uw2VY4N3xFCIL2FvWZ2cdeLfNNhve9fRxg
 Zf2OyfhM9RDSdU4Img4mUCFu1PLhPOtOa2xUNX+2FZ5wBhE6jIBZBbfFiFAOkuyET/IOV/
 pT0OwDm4VyDAYSvi2ILxkZSi6HZdH2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=087pFkDPQX1LVXFotOh4QCXvp5YTxQZVjf2xUD+QFvM=;
 b=clhNsi7360tSL5xPGEVrZDjHQ0V5mBBoMFFGL7EIIbDofNqvN60o6YR6fakTMwg/cCX/xH
 L2mr7WwTfZkyJ1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=087pFkDPQX1LVXFotOh4QCXvp5YTxQZVjf2xUD+QFvM=;
 b=s8QSInhartax+2OgLzD8+SSn07+gd2mLy8q9Uw2VY4N3xFCIL2FvWZ2cdeLfNNhve9fRxg
 Zf2OyfhM9RDSdU4Img4mUCFu1PLhPOtOa2xUNX+2FZ5wBhE6jIBZBbfFiFAOkuyET/IOV/
 pT0OwDm4VyDAYSvi2ILxkZSi6HZdH2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=087pFkDPQX1LVXFotOh4QCXvp5YTxQZVjf2xUD+QFvM=;
 b=clhNsi7360tSL5xPGEVrZDjHQ0V5mBBoMFFGL7EIIbDofNqvN60o6YR6fakTMwg/cCX/xH
 L2mr7WwTfZkyJ1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E247139D0;
 Tue, 20 Feb 2024 22:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KAU0Dd0q1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 25/34] migration/multifd: Add fixed-ram support to fd: URI
Date: Tue, 20 Feb 2024 19:41:29 -0300
Message-Id: <20240220224138.24759-26-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s8QSInha;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=clhNsi73
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
X-Rspamd-Queue-Id: 140CE1FB53
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

If we receive a file descriptor that points to a regular file, there's
nothing stopping us from doing multifd migration with fixed-ram to
that file.

Enable the fd: URI to work with multifd + fixed-ram.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c        | 30 ++++++++++++++++++++++++++++++
 migration/fd.h        |  1 +
 migration/file.c      | 12 +++++++++---
 migration/migration.c |  4 ++++
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 0eb677dcae..b7e4d071a4 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -19,14 +19,28 @@
 #include "fd.h"
 #include "migration.h"
 #include "monitor/monitor.h"
+#include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "options.h"
 #include "trace.h"
 
 
+static struct FdOutgoingArgs {
+    int fd;
+} outgoing_args;
+
+int fd_args_get_fd(void)
+{
+    return outgoing_args.fd;
+}
+
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
+
+    outgoing_args.fd = -1;
+
     if (fd == -1) {
         return;
     }
@@ -38,6 +52,8 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
+    outgoing_args.fd = fd;
+
     qio_channel_set_name(ioc, "migration-fd-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
@@ -73,4 +89,18 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
                                fd_accept_incoming_migration,
                                NULL, NULL,
                                g_main_context_get_thread_default());
+
+    if (migrate_multifd()) {
+        int channels = migrate_multifd_channels();
+
+        while (channels--) {
+            ioc = QIO_CHANNEL(qio_channel_file_new_fd(fd));
+
+            qio_channel_set_name(ioc, "migration-fd-incoming");
+            qio_channel_add_watch_full(ioc, G_IO_IN,
+                                       fd_accept_incoming_migration,
+                                       NULL, NULL,
+                                       g_main_context_get_thread_default());
+        }
+    }
 }
diff --git a/migration/fd.h b/migration/fd.h
index b901bc014e..1be980c130 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -20,4 +20,5 @@ void fd_start_incoming_migration(const char *fdname, Error **errp);
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
                                  Error **errp);
+int fd_args_get_fd(void);
 #endif
diff --git a/migration/file.c b/migration/file.c
index 1a18e608fc..27ccfc6a1d 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
+#include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
@@ -58,10 +59,15 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
 {
     QIOChannelFile *ioc;
     int flags = O_WRONLY;
+    int fd = fd_args_get_fd();
 
-    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-    if (!ioc) {
-        return false;
+    if (fd && fd != -1) {
+        ioc = qio_channel_file_new_fd(fd);
+    } else {
+        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
+        if (!ioc) {
+            return false;
+        }
     }
 
     if (!multifd_channel_connect(opaque, QIO_CHANNEL(ioc), errp)) {
diff --git a/migration/migration.c b/migration/migration.c
index 32b291a282..ce7e6f5065 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -134,6 +134,10 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
 
+        if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            return migrate_fixed_ram();
+        }
+
         return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
                 saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
                 saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
-- 
2.35.3


