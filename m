Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7938FC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgiX-000147-No; Tue, 19 Mar 2024 17:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmgiV-00013X-QK
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:09:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmgiT-0007Qz-IN
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:09:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF9CC1FEE1;
 Tue, 19 Mar 2024 21:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710882587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wtNzFoxPx1Gwgj2CJVn2lt2PiLmw3tl0BlFgi++pfBc=;
 b=gx+yVCfcbLrll9Jp4KpeRnXsxMWUxMkX9YjMddzte/to2tqMwLbz6ap9mgEWMGTjuWRlqI
 mnCYgochs29dzGdN2tLR09UIs2CLkXZkoRPqivyaAdKmzAMgq1fchCB04Y6zXfg+VowwAi
 FpcwpaMqPqNg1KaLabZL5rmOM5iAFW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710882587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wtNzFoxPx1Gwgj2CJVn2lt2PiLmw3tl0BlFgi++pfBc=;
 b=BHRuF1H/buY07FZ82yxjQRzJCUFjyWFley+EZwHyQEGH5nrhdSz8GeFeUq7uYznJ+G5u32
 R7dbtRsvlsDMGNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710882585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wtNzFoxPx1Gwgj2CJVn2lt2PiLmw3tl0BlFgi++pfBc=;
 b=Z7KI8cKC7gSjc4Ef2t/iWZ7quSUr3ae7kyiy8hC5OZxmp0cw+XehrLCEhIDFwtSw+xP6h1
 6eh3UikkaxKh84vbLd9eLIFRAlOijxyqOKukrAfEOqB9LQ8grbK8lW2ClON84spM48UNdW
 /8S5jTb47LyilgpcdTS86uwfhTiNyPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710882585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wtNzFoxPx1Gwgj2CJVn2lt2PiLmw3tl0BlFgi++pfBc=;
 b=jlkIu2yYQxfP+AzMIYQGZo9lhvux8JwzVqhxz2c75cHGcqM8/NMORq7J9/xXPzOwmlRq4/
 tHEpNFVNgli8CFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2281136A5;
 Tue, 19 Mar 2024 21:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rt/NKRf/+WXZfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Mar 2024 21:09:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] Revert mapped-ram multifd support to fd: URI
Date: Tue, 19 Mar 2024 18:09:41 -0300
Message-Id: <20240319210941.1907-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.982]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
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

This reverts commit decdc76772c453ff1444612e910caa0d45cd8eac in full
and also the relevant migration-tests from
7a09f092834641b7a793d50a3a261073bbb404a6.

After the addition of the new QAPI-based migration address API in 8.2
we've been converting an "fd:" URI into a SocketAddress, missing the
fact that the "fd:" syntax could also be used for a plain file instead
of a socket. This is a problem because the SocketAddress is part of
the API, so we're effectively asking users to create a "socket"
channel to pass in a plain file.

The easiest way to fix this situation is to deprecate the usage of
both SocketAddress and "fd:" when used with a plain file for
migration. Since this has been possible since 8.2, we can wait until
9.1 to deprecate it.

For 9.0, however, we should avoid adding further support to migration
to a plain file using the old "fd:" syntax or the new SocketAddress
API, and instead require the usage of either the old-style "file:" URI
or the FileMigrationArgs::filename field of the new API with the
"/dev/fdset/NN" syntax, both of which are already supported.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
CI run: https://gitlab.com/farosas/qemu/-/pipelines/1219876558
---
 migration/fd.c               | 56 ++++--------------------------------
 migration/fd.h               |  2 --
 migration/file.c             | 19 ++----------
 migration/migration.c        | 13 ---------
 migration/multifd.c          |  2 --
 tests/qtest/migration-test.c | 43 ---------------------------
 6 files changed, 8 insertions(+), 127 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index fe0d096abd..449adaa2de 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,42 +15,19 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "monitor/monitor.h"
-#include "io/channel-file.h"
-#include "io/channel-socket.h"
 #include "io/channel-util.h"
-#include "options.h"
 #include "trace.h"
 
 
-static struct FdOutgoingArgs {
-    int fd;
-} outgoing_args;
-
-int fd_args_get_fd(void)
-{
-    return outgoing_args.fd;
-}
-
-void fd_cleanup_outgoing_migration(void)
-{
-    if (outgoing_args.fd > 0) {
-        close(outgoing_args.fd);
-        outgoing_args.fd = -1;
-    }
-}
-
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
     QIOChannel *ioc;
     int fd = monitor_get_fd(monitor_cur(), fdname, errp);
-    int newfd;
-
     if (fd == -1) {
         return;
     }
@@ -62,18 +39,6 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    /*
-     * This is dup()ed just to avoid referencing an fd that might
-     * be already closed by the iochannel.
-     */
-    newfd = dup(fd);
-    if (newfd == -1) {
-        error_setg_errno(errp, errno, "Could not dup FD %d", fd);
-        object_unref(ioc);
-        return;
-    }
-    outgoing_args.fd = newfd;
-
     qio_channel_set_name(ioc, "migration-fd-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
@@ -104,20 +69,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    if (migrate_multifd()) {
-        if (fd_is_socket(fd)) {
-            error_setg(errp,
-                       "Multifd migration to a socket FD is not supported");
-            object_unref(ioc);
-            return;
-        }
-
-        file_create_incoming_channels(ioc, errp);
-    } else {
-        qio_channel_set_name(ioc, "migration-fd-incoming");
-        qio_channel_add_watch_full(ioc, G_IO_IN,
-                                   fd_accept_incoming_migration,
-                                   NULL, NULL,
-                                   g_main_context_get_thread_default());
-    }
+    qio_channel_set_name(ioc, "migration-fd-incoming");
+    qio_channel_add_watch_full(ioc, G_IO_IN,
+                               fd_accept_incoming_migration,
+                               NULL, NULL,
+                               g_main_context_get_thread_default());
 }
diff --git a/migration/fd.h b/migration/fd.h
index 0c0a18d9e7..b901bc014e 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -20,6 +20,4 @@ void fd_start_incoming_migration(const char *fdname, Error **errp);
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
                                  Error **errp);
-void fd_cleanup_outgoing_migration(void);
-int fd_args_get_fd(void);
 #endif
diff --git a/migration/file.c b/migration/file.c
index b6e8ba13f2..ab18ba505a 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -11,7 +11,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
-#include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "io/channel-file.h"
@@ -55,27 +54,15 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
 {
     QIOChannelFile *ioc;
     int flags = O_WRONLY;
-    bool ret = false;
-    int fd = fd_args_get_fd();
-
-    if (fd && fd != -1) {
-        if (fd_is_socket(fd)) {
-            error_setg(errp,
-                       "Multifd migration to a socket FD is not supported");
-            goto out;
-        }
-
-        ioc = qio_channel_file_new_dupfd(fd, errp);
-    } else {
-        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-    }
+    bool ret = true;
 
+    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
     if (!ioc) {
+        ret = false;
         goto out;
     }
 
     multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
-    ret = true;
 
 out:
     /*
diff --git a/migration/migration.c b/migration/migration.c
index f60bd371e3..047b6b49cf 100644
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
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 0179422f6d..d2f0238f70 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -18,7 +18,6 @@
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -794,7 +793,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
-    fd_cleanup_outgoing_migration();
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 71895abb7f..1d2cee87ea 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2536,13 +2536,6 @@ static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void *migrate_fd_file_mapped_ram_start(QTestState *from, QTestState *to)
-{
-    migrate_mapped_ram_start(from, to);
-
-    return migrate_precopy_fd_file_start(from, to);
-}
-
 static void test_migrate_precopy_fd_file(void)
 {
     MigrateCommon args = {
@@ -2553,36 +2546,6 @@ static void test_migrate_precopy_fd_file(void)
     };
     test_file_common(&args, true);
 }
-
-static void test_migrate_precopy_fd_file_mapped_ram(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_fd_file_mapped_ram_start,
-        .finish_hook = test_migrate_fd_finish_hook
-    };
-    test_file_common(&args, true);
-}
-
-static void *migrate_multifd_fd_mapped_ram_start(QTestState *from,
-                                                QTestState *to)
-{
-    migrate_multifd_mapped_ram_start(from, to);
-    return migrate_precopy_fd_file_start(from, to);
-}
-
-static void test_multifd_fd_mapped_ram(void)
-{
-    MigrateCommon args = {
-        .connect_uri = "fd:fd-mig",
-        .listen_uri = "defer",
-        .start_hook = migrate_multifd_fd_mapped_ram_start,
-        .finish_hook = test_migrate_fd_finish_hook
-    };
-
-    test_file_common(&args, true);
-}
 #endif /* _WIN32 */
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
@@ -3687,10 +3650,6 @@ int main(int argc, char **argv)
                        test_multifd_file_mapped_ram);
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
-#ifndef _WIN32
-    migration_test_add("/migration/multifd/fd/mapped-ram",
-                       test_multifd_fd_mapped_ram);
-#endif
 
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
@@ -3753,8 +3712,6 @@ int main(int argc, char **argv)
                        test_migrate_precopy_fd_socket);
     migration_test_add("/migration/precopy/fd/file",
                        test_migrate_precopy_fd_file);
-    migration_test_add("/migration/precopy/fd/file/mapped-ram",
-                       test_migrate_precopy_fd_file_mapped_ram);
 #endif
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
-- 
2.35.3


