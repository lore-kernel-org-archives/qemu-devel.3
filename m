Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D90C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoz-0004dm-5K; Tue, 20 Feb 2024 17:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoy-0004XV-0H
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYow-0006Oo-7t
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7D611FB40;
 Tue, 20 Feb 2024 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAg0vZ2AkAqEr9iarG65lBvVOz1QUC0pH+GKvCN79M4=;
 b=fznh/MI8nF1M01KkW7knTf9XEizn/b3lcyoDbvJWsziJ1ukW7v77t0oyt3X6Dhe1IOHtig
 l9aoMJeXd7BdQFipUjgjNSI0PDj+M1skBmB32O4SkYE9CU76wHZAkOg4AqRInrAppF9nRx
 6BDT6oJBgg+aQS5W5oxZlbt3BZQtaOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAg0vZ2AkAqEr9iarG65lBvVOz1QUC0pH+GKvCN79M4=;
 b=LcAEDRSLqSsYmOEwbNq031QSM27Xq3zmzW1kZBJe44O/XVcLZDA5Z+vDN3GB/0qLww7pYM
 CDW60A8hY+IJluAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAg0vZ2AkAqEr9iarG65lBvVOz1QUC0pH+GKvCN79M4=;
 b=PvnZZ7jPlIFUoFgEY67J0QztD79ninGYzjcNOJiGBXkavq2t54H12MwmeOhvOOOcuVGAT8
 rBK8bAEMoN/nOiv3lfxGWPTxvV6CFILTtWWcYI9xmIqOeaWfy6kllFMz0IngTM2W9vZxEJ
 xOR7fbNCucWv1ab6gnGGs8/brpd33mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAg0vZ2AkAqEr9iarG65lBvVOz1QUC0pH+GKvCN79M4=;
 b=AjeS7jBFQJUscLqZ9pkKAYj6LeJ0i6JOM2HDM6nTwJppXJ9uCM2pY3W1I+X/4uyGUmx6iI
 ZNZ/9YAHY18sDcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5530B139D0;
 Tue, 20 Feb 2024 22:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKlyB9sq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 24/34] migration/multifd: Support incoming fixed-ram stream
 format
Date: Tue, 20 Feb 2024 19:41:28 -0300
Message-Id: <20240220224138.24759-25-farosas@suse.de>
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

For the incoming fixed-ram migration we need to read the ramblock
headers, get the pages bitmap and send the host address of each
non-zero page to the multifd channel thread for writing.

Usage on HMP is:

(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability fixed-ram on
(qemu) migrate_incoming file:migfile

(the ram.h include needs to move because we've been previously relying
on it being included from migration.c. Now file.h will start including
multifd.h before migration.o is processed)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c    | 25 ++++++++++++++++++++++++-
 migration/file.h    |  2 ++
 migration/multifd.c | 34 ++++++++++++++++++++++++++++++----
 migration/multifd.h |  2 ++
 migration/ram.c     | 36 +++++++++++++++++++++++++++++++++---
 5 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 94e8e08363..1a18e608fc 100644
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
@@ -195,3 +194,27 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
 
     return (ret < 0) ? -1 : 0;
 }
+
+int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDRecvData *data = p->data;
+    size_t ret;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (flags != MULTIFD_FLAG_NOCOMP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_NOCOMP);
+        return -1;
+    }
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
index 390dcc6821..9fe8af73fc 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -11,6 +11,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "io/task.h"
 #include "channel.h"
+#include "multifd.h"
 
 void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
 
@@ -22,4 +23,5 @@ bool file_send_channel_create(gpointer opaque, Error **errp);
 int file_send_channel_destroy(QIOChannel *ioc);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, RAMBlock *block, Error **errp);
+int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index b251c58ec2..a0202b5661 100644
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
@@ -251,9 +250,9 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
             p->iov[i].iov_len = p->page_size;
         }
         return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+    } else {
+        return multifd_file_recv_data(p, errp);
     }
-
-    return 0;
 }
 
 static MultiFDMethods multifd_nocomp_ops = {
@@ -1317,13 +1316,40 @@ void multifd_recv_cleanup(void)
     multifd_recv_cleanup_state();
 }
 
+
+/*
+ * Wait until all channels have finished receiving data. Once this
+ * function returns, cleanup routines are safe to run.
+ */
+static void multifd_file_recv_sync(void)
+{
+    int i;
+
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDRecvParams *p = &multifd_recv_state->params[i];
+
+        trace_multifd_recv_sync_main_wait(p->id);
+
+        qemu_sem_post(&p->sem);
+
+        trace_multifd_recv_sync_main_signal(p->id);
+        qemu_sem_wait(&p->sem_sync);
+    }
+    return;
+}
+
 void multifd_recv_sync_main(void)
 {
     int i;
 
-    if (!migrate_multifd() || !multifd_use_packets()) {
+    if (!migrate_multifd()) {
         return;
     }
+
+    if (!multifd_use_packets()) {
+        return multifd_file_recv_sync();
+    }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 135f6ed098..8f89199721 100644
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
index ad540ae9ce..826ac745a0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -111,6 +111,7 @@
  * pages region in the migration file at a time.
  */
 #define FIXED_RAM_LOAD_BUF_SIZE 0x100000
+#define FIXED_RAM_MULTIFD_LOAD_BUF_SIZE 0x100000
 
 XBZRLECacheStats xbzrle_counters;
 
@@ -3950,6 +3951,27 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static size_t ram_load_multifd_pages(void *host_addr, size_t size,
+                                     uint64_t offset)
+{
+    MultiFDRecvData *data = multifd_get_recv_data();
+
+    /*
+     * Pointing the opaque directly to the host buffer, no
+     * preprocessing needed.
+     */
+    data->opaque = host_addr;
+
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
 static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
                                     long num_pages, unsigned long *bitmap,
                                     Error **errp)
@@ -3959,6 +3981,8 @@ static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
     ram_addr_t offset;
     void *host;
     size_t read, unread, size;
+    size_t buf_size = (migrate_multifd() ? FIXED_RAM_MULTIFD_LOAD_BUF_SIZE :
+                       FIXED_RAM_LOAD_BUF_SIZE);
 
     for (set_bit_idx = find_first_bit(bitmap, num_pages);
          set_bit_idx < num_pages;
@@ -3977,10 +4001,16 @@ static bool read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
                 return false;
             }
 
-            size = MIN(unread, FIXED_RAM_LOAD_BUF_SIZE);
+            size = MIN(unread, buf_size);
+
+            if (migrate_multifd()) {
+                read = ram_load_multifd_pages(host, size,
+                                              block->pages_offset + offset);
+            } else {
+                read = qemu_get_buffer_at(f, host, size,
+                                          block->pages_offset + offset);
+            }
 
-            read = qemu_get_buffer_at(f, host, size,
-                                      block->pages_offset + offset);
             if (!read) {
                 goto err;
             }
-- 
2.35.3


