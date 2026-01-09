Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2A2D1A616
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBoN-0004kG-R4; Fri, 09 Jan 2026 07:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoI-00046D-79
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:46 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoG-0007MG-0j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE6EC5BD06;
 Fri,  9 Jan 2026 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZPihHWFyip5uOxm6/TbbjlBT/W6JzxYArQR6lBeqCU=;
 b=XudIzf+fYZdFDndCo2sIJ+6Kq4b0Ij9Ni8xfQaQuuriv+c8onEK7H1aB2DL2BdQTGlG63C
 hM+ysv8dhlwad128MWcwyCPMG53MRsgXBxmIIt36wmPX3pHfMNXv3EvGyAitSe4jEBaTmx
 tII6qdQ5TUS46tH+RnjrGZjBmcVwfpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZPihHWFyip5uOxm6/TbbjlBT/W6JzxYArQR6lBeqCU=;
 b=VDdeAP8bX/+3loj+zY6F0oLIFH4lYBrGwpO0EfNqKbK8WkxirpG4qoowLF4U1ti9LYR9wN
 bxOJ9a3LZMRyxnAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZDFumSqH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ndv6dLX9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZPihHWFyip5uOxm6/TbbjlBT/W6JzxYArQR6lBeqCU=;
 b=ZDFumSqHgJXw0E8vsIYYjq6al1lDl87AGE9KjTtIBige8MDl4tcm4GcPtsNsTH0fi3dhE6
 ccU2kyVvv88qM9Nkei4s0ipU9zromNWixA6+gRhxJt/FOWv9OjkZMufk0lkmUlUmVsBZt5
 lq/IxVPipMqOz42TzgnLo8pFqauFlXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZPihHWFyip5uOxm6/TbbjlBT/W6JzxYArQR6lBeqCU=;
 b=Ndv6dLX9N5Q0+1Xxij4lL2fr/v4VxVnEmnffUPgPQAgWYWYd6kWGQG9HswtOMN6vr0Ozro
 C2DpzIpkGUPO6jBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C2E63EA63;
 Fri,  9 Jan 2026 12:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mGrAMnz3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v3 23/25] migration: Move CPR HUP watch to cpr-transfer.c
Date: Fri,  9 Jan 2026 09:40:39 -0300
Message-ID: <20260109124043.25019-24-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE6EC5BD06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move this CPR-specific code into a cpr file. While here, give the
functions more significant names.

This makes the new idea (after cpr-transfer) of having two parts to
qmp_migrate slightly more obvious: either wait for the hangup or
continue directly.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h  |  5 +++++
 migration/cpr-transfer.c | 23 +++++++++++++++++++++++
 migration/migration.c    | 27 +++------------------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 027cb98073..5850fd1788 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -9,6 +9,7 @@
 #define MIGRATION_CPR_H
 
 #include "qapi/qapi-types-migration.h"
+#include "io/channel.h"
 #include "qemu/queue.h"
 
 #define MIG_MODE_NONE           -1
@@ -53,6 +54,10 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
 QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
 QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
 
+void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
+                                void *opaque);
+void cpr_transfer_source_destroy(MigrationState *s);
+
 void cpr_exec_init(void);
 QEMUFile *cpr_exec_output(Error **errp);
 QEMUFile *cpr_exec_input(Error **errp);
diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
index 00371d17c3..61d5c9dce2 100644
--- a/migration/cpr-transfer.c
+++ b/migration/cpr-transfer.c
@@ -6,7 +6,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/clone-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-migration.h"
+#include "io/channel.h"
 #include "io/channel-file.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
@@ -72,3 +75,23 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
         return NULL;
     }
 }
+
+void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
+                                void *opaque)
+{
+    s->hup_source = qio_channel_create_watch(cpr_state_ioc(), G_IO_HUP);
+    g_source_set_callback(s->hup_source,
+                          (GSourceFunc)func,
+                          QAPI_CLONE(MigrationAddress, opaque),
+                          (GDestroyNotify)qapi_free_MigrationAddress);
+    g_source_attach(s->hup_source, NULL);
+}
+
+void cpr_transfer_source_destroy(MigrationState *s)
+{
+    if (s->hup_source) {
+        g_source_destroy(s->hup_source);
+        g_source_unref(s->hup_source);
+        s->hup_source = NULL;
+    }
+}
diff --git a/migration/migration.c b/migration/migration.c
index 5167233f76..6be2849326 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -100,7 +100,6 @@ static bool migration_object_check(MigrationState *ms, Error **errp);
 static bool migration_switchover_start(MigrationState *s, Error **errp);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
-static void migrate_hup_delete(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -1297,7 +1296,7 @@ static void migration_cleanup(MigrationState *s)
 
     qemu_savevm_state_cleanup();
     cpr_state_close();
-    migrate_hup_delete(s);
+    cpr_transfer_source_destroy(s);
 
     close_return_path_on_source(s);
 
@@ -1480,7 +1479,7 @@ void migration_cancel(void)
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                           MIGRATION_STATUS_CANCELLED);
         cpr_state_close();
-        migrate_hup_delete(s);
+        cpr_transfer_source_destroy(s);
     }
 }
 
@@ -2004,25 +2003,6 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
 
 static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
 
-static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
-                            void *opaque)
-{
-    s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
-    g_source_set_callback(s->hup_source, cb,
-                          QAPI_CLONE(MigrationAddress, opaque),
-                          (GDestroyNotify)qapi_free_MigrationAddress);
-    g_source_attach(s->hup_source, NULL);
-}
-
-static void migrate_hup_delete(MigrationState *s)
-{
-    if (s->hup_source) {
-        g_source_destroy(s->hup_source);
-        g_source_unref(s->hup_source);
-        s->hup_source = NULL;
-    }
-}
-
 static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
                                       GIOCondition cond,
                                       void *opaque)
@@ -2083,8 +2063,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
-        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
-                        main_ch->addr);
+        cpr_transfer_add_hup_watch(s, qmp_migrate_finish_cb, main_ch->addr);
 
     } else {
         qmp_migrate_finish(main_ch->addr, errp);
-- 
2.51.0


