Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262ECC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLlA-0006he-1v; Wed, 28 Feb 2024 10:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLl8-0006h1-HR
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLl5-0005FY-Hb
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C9EA225B3;
 Wed, 28 Feb 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI3Tb8uWM2nLjUJUHNjIXziUNX7jkPt9f9rYzwY+NgM=;
 b=Kf9rABt1RmOqiXJuM9JAUEKzIkPceTbNN8NHreqOBrqo1qHaKczAQAU6S6BH1hryE1Xc2K
 k9k6/SFObBPV+5jHahpR3dd0McVjaZedsF1rujaPMVIdzsLebeNfjAoM8fynRuSa6hq461
 BBp30HJa9fJzXtFnGxaujLH/2YRgKPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI3Tb8uWM2nLjUJUHNjIXziUNX7jkPt9f9rYzwY+NgM=;
 b=lhoAQRTufmaVzzNuI7m/eQlRhTPuww43oPxXDWJ+VeKGjswUH4UiXtJeDOrspEPqSHvKqE
 +6egwk4523w4p0BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI3Tb8uWM2nLjUJUHNjIXziUNX7jkPt9f9rYzwY+NgM=;
 b=Kf9rABt1RmOqiXJuM9JAUEKzIkPceTbNN8NHreqOBrqo1qHaKczAQAU6S6BH1hryE1Xc2K
 k9k6/SFObBPV+5jHahpR3dd0McVjaZedsF1rujaPMVIdzsLebeNfjAoM8fynRuSa6hq461
 BBp30HJa9fJzXtFnGxaujLH/2YRgKPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oI3Tb8uWM2nLjUJUHNjIXziUNX7jkPt9f9rYzwY+NgM=;
 b=lhoAQRTufmaVzzNuI7m/eQlRhTPuww43oPxXDWJ+VeKGjswUH4UiXtJeDOrspEPqSHvKqE
 +6egwk4523w4p0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD76D13A5D;
 Wed, 28 Feb 2024 15:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IILYIKBP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:22:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 17/23] migration/multifd: Add outgoing QIOChannelFile
 support
Date: Wed, 28 Feb 2024 12:21:21 -0300
Message-Id: <20240228152127.18769-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kf9rABt1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lhoAQRTu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
X-Rspamd-Queue-Id: 5C9EA225B3
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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
---
- moved flags change to another patch
- removed channels_created assert
---
 migration/file.c    | 41 +++++++++++++++++++++++++++++++++++++++--
 migration/file.h    |  4 ++++
 migration/multifd.c | 18 +++++++++++++++---
 migration/multifd.h |  1 +
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 22d052a71f..83328a7a1b 100644
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
@@ -47,12 +82,14 @@ void file_start_outgoing_migration(MigrationState *s,
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
-                                     0600, errp);
+    fioc = qio_channel_file_new_path(filename, O_CREAT | O_TRUNC | O_WRONLY,
+                                     0660, errp);
     if (!fioc) {
         return;
     }
 
+    outgoing_args.fname = g_strdup(filename);
+
     ioc = QIO_CHANNEL(fioc);
     if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
         return;
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
diff --git a/migration/multifd.c b/migration/multifd.c
index 3574fd3953..f155223303 100644
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
+        qio_channel_close(p->c, NULL);
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
+            return -1;
+        }
     }
 
     /*
diff --git a/migration/multifd.h b/migration/multifd.h
index 1d8bbaf96b..db8887f088 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -227,5 +227,6 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
     p->iovs_num++;
 }
 
+void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 
 #endif
-- 
2.35.3


