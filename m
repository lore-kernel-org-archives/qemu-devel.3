Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E636EC79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpwG-0008Ov-Hx; Mon, 05 Jan 2026 14:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvR-0007lI-JN
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:35 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvP-0005Kp-LM
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:07:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D5785BCC1;
 Mon,  5 Jan 2026 19:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdSVKkOhMeoe+3N1SHq1rMNlthaKrheMju2yClidvs=;
 b=cSO3gVnroXsrmQsJW2fWyd59RB1EqgUxp4/jbjPf40e9ZRgv4+QWeO9bg6hI3P33oNhnPS
 8dpd3qCFGOemgZzSLgTX6duab/kor/pTACrJwbiSULrSB0X+lrzBORgTtmeD1iqtqydUfJ
 ZKG8SFbkh34mnl1gQUF+oLlpfzWdZjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdSVKkOhMeoe+3N1SHq1rMNlthaKrheMju2yClidvs=;
 b=+jlNqVn3g0IaVRP8QIunzumT+hJNVOPOgui4kVmc+1/FafO7AkRBl78x45TaPKFp9PpDYp
 WgxnriP9XRtVrJCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cSO3gVnr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+jlNqVn3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdSVKkOhMeoe+3N1SHq1rMNlthaKrheMju2yClidvs=;
 b=cSO3gVnroXsrmQsJW2fWyd59RB1EqgUxp4/jbjPf40e9ZRgv4+QWeO9bg6hI3P33oNhnPS
 8dpd3qCFGOemgZzSLgTX6duab/kor/pTACrJwbiSULrSB0X+lrzBORgTtmeD1iqtqydUfJ
 ZKG8SFbkh34mnl1gQUF+oLlpfzWdZjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIdSVKkOhMeoe+3N1SHq1rMNlthaKrheMju2yClidvs=;
 b=+jlNqVn3g0IaVRP8QIunzumT+hJNVOPOgui4kVmc+1/FafO7AkRBl78x45TaPKFp9PpDYp
 WgxnriP9XRtVrJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 091B413964;
 Mon,  5 Jan 2026 19:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UEfLLuALXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 13/25] migration: Move setting of QEMUFile into
 migration_outgoing|incoming_setup
Date: Mon,  5 Jan 2026 16:06:30 -0300
Message-ID: <20260105190644.14072-14-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D5785BCC1
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Centralize, on both sides of migration, the setting of the to_src_file
and from_dst_file QEMUFiles. This will clean up the interface with
channel.c and rdma.c, allowing those files to stop dealing with
QEMUFile themselves.

(multifd_recv_new_channel was changed to return bool+errp for
convenience)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   |  9 +----
 migration/migration.c | 82 ++++++++++++++++++++++++++-----------------
 migration/migration.h |  2 ++
 migration/multifd.c   |  8 +++--
 migration/multifd.h   |  2 +-
 5 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 26cb7bf059..6acce7b2a2 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -14,7 +14,6 @@
 #include "channel.h"
 #include "tls.h"
 #include "migration.h"
-#include "qemu-file.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
@@ -80,14 +79,8 @@ void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
         return;
     }
 
-    QEMUFile *f = qemu_file_new_output(ioc);
-
     migration_ioc_register_yank(ioc);
-
-    qemu_mutex_lock(&s->qemu_file_lock);
-    s->to_dst_file = f;
-    qemu_mutex_unlock(&s->qemu_file_lock);
-
+    migration_outgoing_setup(ioc);
     migration_connect(s);
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 1ea6125454..dc8fe80cf8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -930,17 +930,52 @@ out:
     migrate_incoming_unref_outgoing_state();
 }
 
-/**
- * migration_incoming_setup: Setup incoming migration
- * @f: file for main migration channel
- */
-static void migration_incoming_setup(QEMUFile *f)
+static bool migration_has_main_and_multifd_channels(void);
+
+bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
+    QEMUFile *f;
 
-    assert(!mis->from_src_file);
-    mis->from_src_file = f;
-    qemu_file_set_blocking(f, false, &error_abort);
+    if (multifd_recv_setup(errp) != 0) {
+        return false;
+    }
+
+    switch (channel) {
+    case CH_MAIN:
+        f = qemu_file_new_input(ioc);
+        assert(!mis->from_src_file);
+        mis->from_src_file = f;
+        qemu_file_set_blocking(f, false, &error_abort);
+        break;
+
+    case CH_MULTIFD:
+        if (!multifd_recv_new_channel(ioc, errp)) {
+            return false;
+        }
+        break;
+
+    case CH_POSTCOPY:
+        assert(!mis->postcopy_qemufile_dst);
+        f = qemu_file_new_input(ioc);
+        postcopy_preempt_new_channel(mis, f);
+        return false;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return migration_has_main_and_multifd_channels();
+}
+
+void migration_outgoing_setup(QIOChannel *ioc)
+{
+    MigrationState *s = migrate_get_current();
+    QEMUFile *f = qemu_file_new_output(ioc);
+
+    qemu_mutex_lock(&s->qemu_file_lock);
+    s->to_dst_file = f;
+    qemu_mutex_unlock(&s->qemu_file_lock);
 }
 
 /* Returns true if recovered from a paused migration, otherwise false */
@@ -988,7 +1023,11 @@ void migration_incoming_process(void)
 
 void migration_fd_process_incoming(QEMUFile *f)
 {
-    migration_incoming_setup(f);
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    assert(!mis->from_src_file);
+    mis->from_src_file = f;
+    qemu_file_set_blocking(f, false, &error_abort);
     migration_incoming_process();
 }
 
@@ -1011,8 +1050,6 @@ static bool migration_has_main_and_multifd_channels(void)
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    Error *local_err = NULL;
-    QEMUFile *f;
     uint8_t channel;
     uint32_t channel_magic = 0;
     int ret = 0;
@@ -1066,28 +1103,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         channel = CH_POSTCOPY;
     }
 
-    if (multifd_recv_setup(errp) != 0) {
-        return;
-    }
-
-    if (channel == CH_MAIN) {
-        f = qemu_file_new_input(ioc);
-        migration_incoming_setup(f);
-    } else if (channel == CH_MULTIFD) {
-        /* Multiple connections */
-        multifd_recv_new_channel(ioc, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    } else if (channel == CH_POSTCOPY) {
-        assert(!mis->postcopy_qemufile_dst);
-        f = qemu_file_new_input(ioc);
-        postcopy_preempt_new_channel(mis, f);
-        return;
-    }
-
-    if (migration_has_main_and_multifd_channels()) {
+    if (migration_incoming_setup(ioc, channel, errp)) {
         migration_incoming_process();
     }
 }
diff --git a/migration/migration.h b/migration/migration.h
index d134881eaf..4dcf299719 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -530,6 +530,8 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
+bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
+void migration_outgoing_setup(QIOChannel *ioc);
 
 bool  migration_has_all_channels(void);
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 3fb1a07ba9..4980ed4f04 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1521,7 +1521,7 @@ bool multifd_recv_all_channels_created(void)
  * Try to receive all multifd channels to get ready for the migration.
  * Sets @errp when failing to receive the current channel.
  */
-void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
@@ -1536,7 +1536,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
                                     "failed to receive packet"
                                     " via multifd channel %d: ",
                                     qatomic_read(&multifd_recv_state->count));
-            return;
+            return false;
         }
         trace_multifd_recv_new_channel(id);
     } else {
@@ -1549,7 +1549,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
                    id);
         multifd_recv_terminate_threads(error_copy(local_err));
         error_propagate(errp, local_err);
-        return;
+        return false;
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
@@ -1558,4 +1558,6 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
+
+    return true;
 }
diff --git a/migration/multifd.h b/migration/multifd.h
index 9b6d81e7ed..89a395aef2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -42,7 +42,7 @@ int multifd_recv_setup(Error **errp);
 void multifd_recv_cleanup(void);
 void multifd_recv_shutdown(void);
 bool multifd_recv_all_channels_created(void);
-void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
 int multifd_send_sync_main(MultiFDSyncReq req);
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
-- 
2.51.0


