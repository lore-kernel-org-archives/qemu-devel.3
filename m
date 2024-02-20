Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYot-00045T-28; Tue, 20 Feb 2024 17:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYor-0003vY-JO
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYop-0006Mc-Tl
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1D9322260;
 Tue, 20 Feb 2024 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NW4wBImTHg6GaLO/Ipo8LiOt/sZO9kIS4jSjTP4QKw=;
 b=sy0I7eevI9diJZn5aYenYTJ08qfJQiGLd0UpiuGLU9ayWURtHTnMxio+CL0Xgd+YkNV9DT
 r9ifzmi+0K72zjDS5ZVFLCYL9T9BpsMRBTATrQUMYOEZSMj8FmVFAhxKroRzw59cLXCOfi
 iIshB1yB9+4E4Nnjt7gqSl+oPXRNlFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NW4wBImTHg6GaLO/Ipo8LiOt/sZO9kIS4jSjTP4QKw=;
 b=bShqVBcW1vp1H0Wc6u+/w2w9UYSscXzXOiAM/MP0E9Y0FYTpmHkBCl0mWvzAr6CdUwpP4c
 bIhwPBTIV9XQ8TBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NW4wBImTHg6GaLO/Ipo8LiOt/sZO9kIS4jSjTP4QKw=;
 b=sy0I7eevI9diJZn5aYenYTJ08qfJQiGLd0UpiuGLU9ayWURtHTnMxio+CL0Xgd+YkNV9DT
 r9ifzmi+0K72zjDS5ZVFLCYL9T9BpsMRBTATrQUMYOEZSMj8FmVFAhxKroRzw59cLXCOfi
 iIshB1yB9+4E4Nnjt7gqSl+oPXRNlFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NW4wBImTHg6GaLO/Ipo8LiOt/sZO9kIS4jSjTP4QKw=;
 b=bShqVBcW1vp1H0Wc6u+/w2w9UYSscXzXOiAM/MP0E9Y0FYTpmHkBCl0mWvzAr6CdUwpP4c
 bIhwPBTIV9XQ8TBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09EF1139D0;
 Tue, 20 Feb 2024 22:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QIauMNQq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 21/34] migration/multifd: Add incoming QIOChannelFile
 support
Date: Tue, 20 Feb 2024 19:41:25 -0300
Message-Id: <20240220224138.24759-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
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

On the receiving side we don't need to differentiate between main
channel and threads, so whichever channel is defined first gets to be
the main one. And since there are no packets, use the atomic channel
count to index into the params array.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c      | 34 ++++++++++++++++++++++++++--------
 migration/migration.c |  3 ++-
 migration/multifd.c   |  3 +--
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index ac9f6ae40a..a186dc592a 100644
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
@@ -111,7 +113,8 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
     g_autofree char *filename = g_strdup(file_args->filename);
     QIOChannelFile *fioc = NULL;
     uint64_t offset = file_args->offset;
-    QIOChannel *ioc;
+    int channels = 1;
+    int i = 0, fd;
 
     trace_migration_file_incoming(filename);
 
@@ -120,13 +123,28 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
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
+    fd = fioc->fd;
+
+    do {
+        QIOChannel *ioc = QIO_CHANNEL(fioc);
+
+        qio_channel_set_name(ioc, "migration-file-incoming");
+        qio_channel_add_watch_full(ioc, G_IO_IN,
+                                   file_accept_incoming_migration,
+                                   NULL, NULL,
+                                   g_main_context_get_thread_default());
+    } while (++i < channels && (fioc = qio_channel_file_new_fd(fd)));
+
+    if (!fioc) {
+        error_setg(errp, "Error creating migration incoming channel");
+    }
 }
diff --git a/migration/migration.c b/migration/migration.c
index 16da269847..e2218b9de7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -896,7 +896,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (migrate_multifd() && !migrate_postcopy_ram() &&
+    if (migrate_multifd() && !migrate_fixed_ram() &&
+        !migrate_postcopy_ram() &&
         qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
         /*
          * With multiple channels, it is possible that we receive channels
diff --git a/migration/multifd.c b/migration/multifd.c
index 507b497d52..cb5f4fb3e0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1520,8 +1520,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
         }
         trace_multifd_recv_new_channel(id);
     } else {
-        /* next patch gives this a meaningful value */
-        id = 0;
+        id = qatomic_read(&multifd_recv_state->count);
     }
 
     p = &multifd_recv_state->params[id];
-- 
2.35.3


