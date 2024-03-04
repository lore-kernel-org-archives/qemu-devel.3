Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614DCC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8N-0002wK-Lx; Sun, 03 Mar 2024 20:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7t-0002Mv-Tf
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7n-0002QS-Ur
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ar+ofp36XyBqOk9XaHO6Ma1s1jc9ExRp4Vy0jSeUQA=;
 b=Ss5Se2gmzxUhA811zC9aFVX9vY/OS4+ZxmCrqCzZpFqz2fmRdoA2nSaeYWexVvamBjZQSt
 S4sokvh6p1Q4tfNOx+yMaC4qEcoJv8SBJky6dtnjNxqYLGastMD2NLlD79Xjp5LRxV36ir
 7AUSkRVw98GH3X1ZbLAHZ4cuqVe6UNw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-pcD6Vw-hMTCCyyHau2mTog-1; Sun, 03 Mar 2024 20:28:13 -0500
X-MC-Unique: pcD6Vw-hMTCCyyHau2mTog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1246185A785;
 Mon,  4 Mar 2024 01:28:12 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 780E440C6EBA;
 Mon,  4 Mar 2024 01:28:09 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 21/27] migration/multifd: Add incoming QIOChannelFile support
Date: Mon,  4 Mar 2024 09:26:28 +0800
Message-ID: <20240304012634.95520-22-peterx@redhat.com>
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

On the receiving side we don't need to differentiate between main
channel and threads, so whichever channel is defined first gets to be
the main one. And since there are no packets, use the atomic channel
count to index into the params array.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-19-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/file.c      | 35 +++++++++++++++++++++++++++--------
 migration/migration.c |  3 ++-
 migration/multifd.c   |  3 +--
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index a350dd61f0..2f8b626b27 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "exec/ramblock.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
 #include "file.h"
@@ -15,6 +16,7 @@
 #include "multifd.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
+#include "options.h"
 #include "trace.h"
 
 #define OFFSET_OPTION ",offset="
@@ -112,7 +114,8 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
-    QIOChannel *ioc;
+    int channels = 1;
+    int i = 0;
 
     trace_migration_file_incoming(filename);
 
@@ -121,13 +124,29 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
         return;
     }
 
-    ioc = QIO_CHANNEL(fioc);
-    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
+    if (offset &&
+        qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
         return;
     }
-    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
-    qio_channel_add_watch_full(ioc, G_IO_IN,
-                               file_accept_incoming_migration,
-                               NULL, NULL,
-                               g_main_context_get_thread_default());
+
+    if (migrate_multifd()) {
+        channels += migrate_multifd_channels();
+    }
+
+    do {
+        QIOChannel *ioc = QIO_CHANNEL(fioc);
+
+        qio_channel_set_name(ioc, "migration-file-incoming");
+        qio_channel_add_watch_full(ioc, G_IO_IN,
+                                   file_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
+
+        fioc = qio_channel_file_new_fd(dup(fioc->fd));
+
+        if (!fioc || fioc->fd == -1) {
+            error_setg(errp, "Error creating migration incoming channel");
+            break;
+        }
+    } while (++i < channels);
 }
diff --git a/migration/migration.c b/migration/migration.c
index 2669600d25..faeb75a59b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -910,7 +910,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_postcopy_ram() &&
+    if (migrate_multifd() && !migrate_mapped_ram() &&
+        !migrate_postcopy_ram() &&
         qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
         /*
          * With multiple channels, it is possible that we receive channels
diff --git a/migration/multifd.c b/migration/multifd.c
index caef1076ca..ea08f1aa9e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1545,8 +1545,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
         }
         trace_multifd_recv_new_channel(id);
     } else {
-        /* next patch gives this a meaningful value */
-        id = 0;
+        id = qatomic_read(&multifd_recv_state->count);
     }
 
     p = &multifd_recv_state->params[id];
-- 
2.44.0


