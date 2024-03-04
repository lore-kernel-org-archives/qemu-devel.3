Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33FEC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8X-0004Z6-O7; Sun, 03 Mar 2024 20:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7q-0002Jf-M6
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7l-0002QI-SU
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+igvX/FEW4XM2C5h7L1n5XNwdEdJ5+LsMvBKmyx/Jk=;
 b=VkJaMhy4PxR/c4jHG2fj4KUATSkU7tuyVVL4eUTwqLQS7T6WnnDTynh7QWauSnTUSY9w9s
 D04YcgmC6qjp0ce8c7Z7pUYhw66NTBy9fVrmYsgGhLgBgRhNNAg6Vy+D8ZQ1Iya1tZ5ka9
 ANL1rJ3r2c4Cjh/fBiWAZHIE8/iE0Zk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-aHqFX1WeNiG1A71714MvQQ-1; Sun, 03 Mar 2024 20:28:09 -0500
X-MC-Unique: aHqFX1WeNiG1A71714MvQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A97A11064DA3;
 Mon,  4 Mar 2024 01:28:08 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EBDF40C6EBA;
 Mon,  4 Mar 2024 01:28:04 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 20/27] migration/multifd: Add outgoing QIOChannelFile support
Date: Mon,  4 Mar 2024 09:26:27 +0800
Message-ID: <20240304012634.95520-21-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Allow multifd to open file-backed channels. This will be used when
enabling the mapped-ram migration stream format which expects a
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240229153017.2221-18-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/file.h    |  4 ++++
 migration/multifd.h |  1 +
 migration/file.c    | 37 +++++++++++++++++++++++++++++++++++++
 migration/multifd.c | 18 +++++++++++++++---
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/migration/file.h b/migration/file.h
index 37d6a08bfc..4577f9efdd 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -9,10 +9,14 @@
 #define QEMU_MIGRATION_FILE_H
 
 #include "qapi/qapi-types-migration.h"
+#include "io/task.h"
+#include "channel.h"
 
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
 
 void file_start_outgoing_migration(MigrationState *s,
                                    FileMigrationArgs *file_args, Error **errp);
 int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
+void file_cleanup_outgoing_migration(void);
+bool file_send_channel_create(gpointer opaque, Error **errp);
 #endif
diff --git a/migration/multifd.h b/migration/multifd.h
index 1d8bbaf96b..db8887f088 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -227,5 +227,6 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
     p->iovs_num++;
 }
 
+void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 
 #endif
diff --git a/migration/file.c b/migration/file.c
index 22d052a71f..a350dd61f0 100644
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
@@ -37,6 +42,36 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
     return 0;
 }
 
+void file_cleanup_outgoing_migration(void)
+{
+    g_free(outgoing_args.fname);
+    outgoing_args.fname = NULL;
+}
+
+bool file_send_channel_create(gpointer opaque, Error **errp)
+{
+    QIOChannelFile *ioc;
+    int flags = O_WRONLY;
+    bool ret = true;
+
+    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
+    if (!ioc) {
+        ret = false;
+        goto out;
+    }
+
+    multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
+
+out:
+    /*
+     * File channel creation is synchronous. However posting this
+     * semaphore here is simpler than adding a special case.
+     */
+    multifd_send_channel_created();
+
+    return ret;
+}
+
 void file_start_outgoing_migration(MigrationState *s,
                                    FileMigrationArgs *file_args, Error **errp)
 {
@@ -53,6 +88,8 @@ void file_start_outgoing_migration(MigrationState *s,
         return;
     }
 
+    outgoing_args.fname = g_strdup(filename);
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
diff --git a/migration/multifd.c b/migration/multifd.c
index 3574fd3953..caef1076ca 100644
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
 
@@ -694,6 +696,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
+        qio_channel_close(p->c, &error_abort);
         object_unref(OBJECT(p->c));
         p->c = NULL;
     }
@@ -715,6 +718,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 
 static void multifd_send_cleanup_state(void)
 {
+    file_cleanup_outgoing_migration();
     socket_cleanup_outgoing_migration();
     qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
@@ -977,7 +981,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     return true;
 }
 
-static void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
+void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
 {
     qio_channel_set_delay(ioc, false);
 
@@ -1045,9 +1049,14 @@ out:
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
@@ -1096,7 +1105,10 @@ bool multifd_send_setup(void)
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
-        multifd_new_send_channel_create(p);
+
+        if (!multifd_new_send_channel_create(p, &local_err)) {
+            return false;
+        }
     }
 
     /*
-- 
2.44.0


