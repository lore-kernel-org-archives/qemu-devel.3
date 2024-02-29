Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2556C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiNt-000643-Vt; Thu, 29 Feb 2024 10:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiNN-0005ou-1Y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:31:16 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiNK-00062f-2R
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:31:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B62F2221DA;
 Thu, 29 Feb 2024 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fD/HXDO1b8/aMgcouZjCisas/RNDxS5v50/bTMkCGs=;
 b=vpBzBBVnCZF3MNxAC/dTge+REJ5Lpzj5LFyQznCFe6e+vjg8Fqa2amHRjYLt5H1sMiNj7c
 J4KofXJXA6JdH3KqRn3VbBPS2E3g4aFZ2ickYSgF6XC8GEQAC/WH5v2NoMP/vCXHXQCQVZ
 XclfTF30I4ZTXVkCA2leifp9Q40GWMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fD/HXDO1b8/aMgcouZjCisas/RNDxS5v50/bTMkCGs=;
 b=kp/EtSB5Cpsf3pHFyApXPNCDW/Q8AyKWRV+Na3Yjv8XT+bKm2YBhTOZuFqcHABvDO94EMc
 boWjtuRtXphlhIBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fD/HXDO1b8/aMgcouZjCisas/RNDxS5v50/bTMkCGs=;
 b=vpBzBBVnCZF3MNxAC/dTge+REJ5Lpzj5LFyQznCFe6e+vjg8Fqa2amHRjYLt5H1sMiNj7c
 J4KofXJXA6JdH3KqRn3VbBPS2E3g4aFZ2ickYSgF6XC8GEQAC/WH5v2NoMP/vCXHXQCQVZ
 XclfTF30I4ZTXVkCA2leifp9Q40GWMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fD/HXDO1b8/aMgcouZjCisas/RNDxS5v50/bTMkCGs=;
 b=kp/EtSB5Cpsf3pHFyApXPNCDW/Q8AyKWRV+Na3Yjv8XT+bKm2YBhTOZuFqcHABvDO94EMc
 boWjtuRtXphlhIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A05B13503;
 Thu, 29 Feb 2024 15:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDmoNDqj4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:31:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6 21/23] migration/multifd: Support incoming mapped-ram
 stream format
Date: Thu, 29 Feb 2024 12:30:15 -0300
Message-Id: <20240229153017.2221-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
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
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
---
 migration/file.c    | 18 +++++++++++++++++-
 migration/file.h    |  2 ++
 migration/multifd.c | 31 ++++++++++++++++++++++++++++---
 migration/multifd.h |  2 ++
 migration/ram.c     | 26 ++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 6 deletions(-)

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
2.35.3


