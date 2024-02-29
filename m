Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99582C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiOC-0006Rh-38; Thu, 29 Feb 2024 10:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiNQ-0005r0-2K
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:31:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiNN-00062q-AZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:31:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 009451F7F6;
 Thu, 29 Feb 2024 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUtdlKAOtKcRc3pkRXeHZkfdr3XY95D5qn0B7Js5PC4=;
 b=Od7yFM75/BWZfaivjDk/DcqgEI2P+y9/aJ2HM4FV1MCt5IPrKV/J4YKOdKZv6LXOOLPqsj
 BFDeThQOwIApgsXu8dv+CcvO919QtcEm8fxhdTwxMerPvofEKTMgH6WtlZZph93WF4BYK7
 wfQFcTCivSalznDvSEaQSo58Or3Xy5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUtdlKAOtKcRc3pkRXeHZkfdr3XY95D5qn0B7Js5PC4=;
 b=/BkAOHElzOECsNoE7QDniuOX5UKybtplgP0PucsDt5WNxbquEi6nEF2APnIHSuzYQsuhj9
 0QVBxwYvgCPQVJCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUtdlKAOtKcRc3pkRXeHZkfdr3XY95D5qn0B7Js5PC4=;
 b=Od7yFM75/BWZfaivjDk/DcqgEI2P+y9/aJ2HM4FV1MCt5IPrKV/J4YKOdKZv6LXOOLPqsj
 BFDeThQOwIApgsXu8dv+CcvO919QtcEm8fxhdTwxMerPvofEKTMgH6WtlZZph93WF4BYK7
 wfQFcTCivSalznDvSEaQSo58Or3Xy5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUtdlKAOtKcRc3pkRXeHZkfdr3XY95D5qn0B7Js5PC4=;
 b=/BkAOHElzOECsNoE7QDniuOX5UKybtplgP0PucsDt5WNxbquEi6nEF2APnIHSuzYQsuhj9
 0QVBxwYvgCPQVJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39ADC13503;
 Thu, 29 Feb 2024 15:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qBtfAD2j4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:31:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6 22/23] migration/multifd: Add mapped-ram support to fd: URI
Date: Thu, 29 Feb 2024 12:30:16 -0300
Message-Id: <20240229153017.2221-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
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

If we receive a file descriptor that points to a regular file, there's
nothing stopping us from doing multifd migration with mapped-ram to
that file.

Enable the fd: URI to work with multifd + mapped-ram.

Note that the fds passed into multifd are duplicated because we want
to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
original fd doesn't need to be duplicated because monitor_get_fd()
transfers ownership to the caller.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/fd.c        | 44 +++++++++++++++++++++++++++++++++++++++++++
 migration/fd.h        |  2 ++
 migration/file.c      | 16 +++++++++++-----
 migration/migration.c |  4 ++++
 migration/multifd.c   |  2 ++
 5 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 0eb677dcae..d4ae72d132 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,18 +15,41 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "channel.h"
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
+void fd_cleanup_outgoing_migration(void)
+{
+    if (outgoing_args.fd > 0) {
+        close(outgoing_args.fd);
+        outgoing_args.fd = -1;
+    }
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
@@ -38,6 +61,8 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
+    outgoing_args.fd = fd;
+
     qio_channel_set_name(ioc, "migration-fd-outgoing");
     migration_channel_connect(s, ioc, NULL, NULL);
     object_unref(OBJECT(ioc));
@@ -73,4 +98,23 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
                                fd_accept_incoming_migration,
                                NULL, NULL,
                                g_main_context_get_thread_default());
+
+    if (migrate_multifd()) {
+        int channels = migrate_multifd_channels();
+
+        while (channels--) {
+            ioc = QIO_CHANNEL(qio_channel_file_new_fd(dup(fd)));
+
+            if (QIO_CHANNEL_FILE(ioc)->fd == -1) {
+                error_setg(errp, "Failed to duplicate fd %d", fd);
+                return;
+            }
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
index b901bc014e..0c0a18d9e7 100644
--- a/migration/fd.h
+++ b/migration/fd.h
@@ -20,4 +20,6 @@ void fd_start_incoming_migration(const char *fdname, Error **errp);
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
                                  Error **errp);
+void fd_cleanup_outgoing_migration(void);
+int fd_args_get_fd(void);
 #endif
diff --git a/migration/file.c b/migration/file.c
index 499d2782fe..164b079966 100644
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
@@ -53,15 +54,20 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
 {
     QIOChannelFile *ioc;
     int flags = O_WRONLY;
-    bool ret = true;
+    bool ret = false;
+    int fd = fd_args_get_fd();
 
-    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-    if (!ioc) {
-        ret = false;
-        goto out;
+    if (fd && fd != -1) {
+        ioc = qio_channel_file_new_fd(dup(fd));
+    } else {
+        ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
+        if (!ioc) {
+            goto out;
+        }
     }
 
     multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
+    ret = true;
 
 out:
     /*
diff --git a/migration/migration.c b/migration/migration.c
index 957d2890b7..0f1c044707 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -139,6 +139,10 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
 
+        if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            return migrate_mapped_ram();
+        }
+
         return (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
                 saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
                 saddr->type == SOCKET_ADDRESS_TYPE_VSOCK);
diff --git a/migration/multifd.c b/migration/multifd.c
index 419feb7df1..b4e5a9dfcc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -17,6 +17,7 @@
 #include "exec/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "fd.h"
 #include "file.h"
 #include "migration.h"
 #include "migration-stats.h"
@@ -731,6 +732,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 static void multifd_send_cleanup_state(void)
 {
     file_cleanup_outgoing_migration();
+    fd_cleanup_outgoing_migration();
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
-- 
2.35.3


