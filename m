Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752F8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8I-0002sE-Ep; Sun, 03 Mar 2024 20:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx84-0002cG-65
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx81-0002Rv-SD
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYRu32m8uCs0jJp9EUvwDMLyBwy80EolLkVwNY9f+rI=;
 b=JxtltQZt7Qj6HtohZFAPoYbA0nViVIFkO4KMIeFJkaCH0zRqP856YCt82Lm5MiTUcRD+Jq
 X8xESRcGNry5Xb4M98/PPfkHiq7oKtJQtGjvQEI8eL3+R9lpLZvLKZ7DxEnhFxIimPj0lU
 oqyocqK3FMeJKcYC9IRpi5e4liPiXXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-mJug5pXLP8mhXOovYyW63g-1; Sun, 03 Mar 2024 20:28:25 -0500
X-MC-Unique: mJug5pXLP8mhXOovYyW63g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7600A8820C3;
 Mon,  4 Mar 2024 01:28:25 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 157FD40C6EBA;
 Mon,  4 Mar 2024 01:28:21 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 24/27] migration/multifd: Support incoming mapped-ram stream
 format
Date: Mon,  4 Mar 2024 09:26:31 +0800
Message-ID: <20240304012634.95520-25-peterx@redhat.com>
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

For the incoming mapped-ram migration we need to read the ramblock
headers, get the pages bitmap and send the host address of each
non-zero page to the multifd channel thread for writing.

Usage on HMP is:

(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability mapped-ram on
(qemu) migrate_incoming file:migfile

(the ram.h include needs to move because we've been previously relying
on it being included from migration.c. Now file.h will start including
multifd.h before migration.o is processed)

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-22-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/file.h    |  2 ++
 migration/multifd.h |  2 ++
 migration/file.c    | 18 +++++++++++++++++-
 migration/multifd.c | 31 ++++++++++++++++++++++++++++---
 migration/ram.c     | 26 ++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/migration/file.h b/migration/file.h
index 01a338cac7..9f71e87f74 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -11,6 +11,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "io/task.h"
 #include "channel.h"
+#include "multifd.h"
 
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
 
@@ -21,4 +22,5 @@ void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
+int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
 #endif
diff --git a/migration/multifd.h b/migration/multifd.h
index db8887f088..7447c2bea3 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
+#include "ram.h"
+
 typedef struct MultiFDRecvData MultiFDRecvData;
 
 bool multifd_send_setup(void);
diff --git a/migration/file.c b/migration/file.c
index d949a941d0..499d2782fe 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -13,7 +13,6 @@
 #include "channel.h"
 #include "file.h"
 #include "migration.h"
-#include "multifd.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
 #include "options.h"
@@ -204,3 +203,20 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
     return (ret < 0) ? ret : 0;
 }
+
+int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDRecvData *data = p->data;
+    size_t ret;
+
+    ret = qio_channel_pread(p->c, (char *) data->opaque,
+                            data->size, data->file_offset, errp);
+    if (ret != data->size) {
+        error_prepend(errp,
+                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
+                      p->id, ret, data->size);
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/migration/multifd.c b/migration/multifd.c
index 8118145428..419feb7df1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -18,7 +18,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "file.h"
-#include "ram.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "socket.h"
@@ -251,7 +250,7 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
     uint32_t flags;
 
     if (!multifd_use_packets()) {
-        return 0;
+        return multifd_file_recv_data(p, errp);
     }
 
     flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
@@ -1331,22 +1330,48 @@ void multifd_recv_cleanup(void)
 void multifd_recv_sync_main(void)
 {
     int thread_count = migrate_multifd_channels();
+    bool file_based = !multifd_use_packets();
     int i;
 
-    if (!migrate_multifd() || !multifd_use_packets()) {
+    if (!migrate_multifd()) {
         return;
     }
 
+    /*
+     * File-based channels don't use packets and therefore need to
+     * wait for more work. Release them to start the sync.
+     */
+    if (file_based) {
+        for (i = 0; i < thread_count; i++) {
+            MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+            trace_multifd_recv_sync_main_signal(p->id);
+            qemu_sem_post(&p->sem);
+        }
+    }
+
     /*
      * Initiate the synchronization by waiting for all channels.
+     *
      * For socket-based migration this means each channel has received
      * the SYNC packet on the stream.
+     *
+     * For file-based migration this means each channel is done with
+     * the work (pending_job=false).
      */
     for (i = 0; i < thread_count; i++) {
         trace_multifd_recv_sync_main_wait(i);
         qemu_sem_wait(&multifd_recv_state->sem_sync);
     }
 
+    if (file_based) {
+        /*
+         * For file-based loading is done in one iteration. We're
+         * done.
+         */
+        return;
+    }
+
     /*
      * Sync done. Release the channels for the next iteration.
      */
diff --git a/migration/ram.c b/migration/ram.c
index 87cb73fd76..1f1b5297cf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3952,6 +3952,22 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static size_t ram_load_multifd_pages(void *host_addr, size_t size,
+                                     uint64_t offset)
+{
+    MultiFDRecvData *data = multifd_get_recv_data();
+
+    data->opaque = host_addr;
+    data->file_offset = offset;
+    data->size = size;
+
+    if (!multifd_recv()) {
+        return 0;
+    }
+
+    return size;
+}
+
 static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                      long num_pages, unsigned long *bitmap,
                                      Error **errp)
@@ -3981,8 +3997,14 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
 
             size = MIN(unread, MAPPED_RAM_LOAD_BUF_SIZE);
 
-            read = qemu_get_buffer_at(f, host, size,
-                                      block->pages_offset + offset);
+            if (migrate_multifd()) {
+                read = ram_load_multifd_pages(host, size,
+                                              block->pages_offset + offset);
+            } else {
+                read = qemu_get_buffer_at(f, host, size,
+                                          block->pages_offset + offset);
+            }
+
             if (!read) {
                 goto err;
             }
-- 
2.44.0


