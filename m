Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A42CC5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8X-0004Ym-KS; Sun, 03 Mar 2024 20:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx87-0002fx-2b
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx85-0002S8-9y
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epLuZtJ97aqUb1mDIYXVIAdIkCaOvXm81Z6JXpZJqf0=;
 b=HYeqWvtqVBXcA6zL7THIvZVg1lB1jAsoKy6uWSq/eHYeCGCQSjWS/MembqNL7T6XKchg7E
 5fUbgNzJxhxcJz1YLToeu7iEVhNEv5zWsVO0a6O+c2h8tzy2dL9Wsa617ryHM+jXLD3kq+
 WoXQi3nFwSK22DeNnkSnKNA+DjMwCD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-jQjm0ARKP-q1Z4nu_BInWA-1; Sun, 03 Mar 2024 20:28:29 -0500
X-MC-Unique: jQjm0ARKP-q1Z4nu_BInWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FF56185A785;
 Mon,  4 Mar 2024 01:28:29 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F2F84024860;
 Mon,  4 Mar 2024 01:28:25 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 25/27] migration/multifd: Add mapped-ram support to fd: URI
Date: Mon,  4 Mar 2024 09:26:32 +0800
Message-ID: <20240304012634.95520-26-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

If we receive a file descriptor that points to a regular file, there's
nothing stopping us from doing multifd migration with mapped-ram to
that file.

Enable the fd: URI to work with multifd + mapped-ram.

Note that the fds passed into multifd are duplicated because we want
to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
original fd doesn't need to be duplicated because monitor_get_fd()
transfers ownership to the caller.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240229153017.2221-23-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/fd.h        |  2 ++
 migration/fd.c        | 44 +++++++++++++++++++++++++++++++++++++++++++
 migration/file.c      | 18 ++++++++++++------
 migration/migration.c |  4 ++++
 migration/multifd.c   |  2 ++
 5 files changed, 64 insertions(+), 6 deletions(-)

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
-
-    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
-    if (!ioc) {
-        ret = false;
-        goto out;
+    bool ret = false;
+    int fd = fd_args_get_fd();
+
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
index b9baab543a..a49fcd53ee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -140,6 +140,10 @@ static bool transport_supports_multi_channels(MigrationAddress *addr)
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
2.44.0


