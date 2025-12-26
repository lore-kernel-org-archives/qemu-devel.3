Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55562E8FDB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFEt-0001lk-Db; Fri, 26 Dec 2025 16:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEq-0001ch-Or
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:44 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEo-0004I1-KC
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B1FF35BCE1;
 Fri, 26 Dec 2025 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZJOtMOEZAVo7vbMwFj3ucTsVaUW3dpHV0sKC1MhhQI=;
 b=zciHotFpdrmLqF+38DwGCXcx+CEmIrFQ+4cRVi5Qg5QfN1bV8sVeDnglmKuO/jbUmgrpRr
 cXAJtP1TTUpzetvz66UyheJOw8gmtr57HFzbne5v5nbSUMIVTGDy+5OPECb6HyNHMCF/Jf
 5GDWQJm1AN28IAGm0GSJJwsbOCmOdAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZJOtMOEZAVo7vbMwFj3ucTsVaUW3dpHV0sKC1MhhQI=;
 b=P79Zuds//NMxrOIrhiM1FGkDQs4zk5keWab9dvBB6INhMRaxn0yzAN2OaMCCzrET8BMbXR
 FqLVYq/hN2c3OzDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cq6JbR+b;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GOP6ckQZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZJOtMOEZAVo7vbMwFj3ucTsVaUW3dpHV0sKC1MhhQI=;
 b=cq6JbR+bu6nrexpHv65Yr6XWYR9pEONa59Vekqw7m8S/c/TcMB3yvjHheogvYky//veNqH
 FPrXoDNYdSUntOk23DEemCq6LQJ3Fo0qlz+CNsAy/h4U5tWCW7deeDFr8quTMW3BGcxOuz
 NieGrjLx/mV0Gvxvz39E3mDBxgr4F+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZJOtMOEZAVo7vbMwFj3ucTsVaUW3dpHV0sKC1MhhQI=;
 b=GOP6ckQZO+0nemFs+hdHFjhMiwA3qBeJWU/sRX4t1nvGS09+qvztHvVN9hbYWtIuwOB3zJ
 LxTJCmrLtXx9uvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C0023EA63;
 Fri, 26 Dec 2025 21:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SGpRCwH8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH 17/25] migration: Move channel code to channel.c
Date: Fri, 26 Dec 2025 18:19:19 -0300
Message-ID: <20251226211930.27565-18-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B1FF35BCE1
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Move the code responsible for the various channels connection into
channel.c. This is all executed before the migration_thread and
process_incoming_migration_co are running, so it helps the reasoning
to have them out of migration.c.

migration_ioc_process_incoming becomes migration_channel_identify
which is more in line with what the function does.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 99 ++++++++++++++++++++++++++++++++++++++++++-
 migration/channel.h   | 12 ++++++
 migration/migration.c | 98 ------------------------------------------
 migration/migration.h |  5 +--
 migration/rdma.c      |  1 +
 5 files changed, 113 insertions(+), 102 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index c5bd89576a..a9ac3711b5 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -14,13 +14,110 @@
 #include "channel.h"
 #include "tls.h"
 #include "migration.h"
+#include "multifd.h"
+#include "savevm.h"
 #include "trace.h"
+#include "options.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
 #include "io/channel-socket.h"
 #include "qemu/yank.h"
 #include "yank_functions.h"
 
+bool migration_has_main_and_multifd_channels(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    if (!mis->from_src_file) {
+        /* main channel not established */
+        return false;
+    }
+
+    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
+        return false;
+    }
+
+    /* main and all multifd channels are established */
+    return true;
+}
+
+/**
+ * @migration_has_all_channels: We have received all channels that we need
+ *
+ * Returns true when we have got connections to all the channels that
+ * we need for migration.
+ */
+bool migration_has_all_channels(void)
+{
+    if (!migration_has_main_and_multifd_channels()) {
+        return false;
+    }
+
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
+        return false;
+    }
+
+    return true;
+}
+
+static int migration_channel_identify(MigrationIncomingState *mis,
+                                      QIOChannel *ioc, Error **errp)
+{
+    int channel = CH_NONE;
+    uint32_t channel_magic = 0;
+    int ret = 0;
+
+    if (!migration_has_main_and_multifd_channels()) {
+        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+            /*
+             * With multiple channels, it is possible that we receive channels
+             * out of order on destination side, causing incorrect mapping of
+             * source channels on destination side. Check channel MAGIC to
+             * decide type of channel. Please note this is best effort,
+             * postcopy preempt channel does not send any magic number so
+             * avoid it for postcopy live migration. Also tls live migration
+             * already does tls handshake while initializing main channel so
+             * with tls this issue is not possible.
+             */
+            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
+                                              sizeof(channel_magic), errp);
+            if (ret != 0) {
+                goto out;
+            }
+
+            channel_magic = be32_to_cpu(channel_magic);
+            if (channel_magic == QEMU_VM_FILE_MAGIC) {
+                channel = CH_MAIN;
+            } else if (channel_magic == MULTIFD_MAGIC) {
+                assert(migrate_multifd());
+                channel = CH_MULTIFD;
+            } else if (!mis->from_src_file &&
+                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+                /* reconnect main channel for postcopy recovery */
+                channel = CH_MAIN;
+            } else {
+                error_setg(errp, "unknown channel magic: %u", channel_magic);
+            }
+        } else if (mis->from_src_file && migrate_multifd()) {
+            /*
+             * Non-peekable channels like tls/file are processed as
+             * multifd channels when multifd is enabled.
+             */
+            channel = CH_MULTIFD;
+        } else if (!mis->from_src_file) {
+            channel = CH_MAIN;
+        } else {
+            error_setg(errp, "non-peekable channel used without multifd");
+        }
+    } else {
+        assert(migrate_postcopy_preempt());
+        channel = CH_POSTCOPY;
+    }
+
+out:
+    return channel;
+}
+
 /**
  * @migration_channel_process_incoming - Create new incoming migration channel
  *
@@ -42,7 +139,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
         migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
         migration_ioc_register_yank(ioc);
-        ch = migration_ioc_process_incoming(ioc, &local_err);
+        ch = migration_channel_identify(mis, ioc, &local_err);
         if (!ch) {
             goto out;
         }
diff --git a/migration/channel.h b/migration/channel.h
index 7d3457271d..59d169e095 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -18,6 +18,14 @@
 
 #include "io/channel.h"
 
+/* Migration channel types */
+enum {
+    CH_NONE,
+    CH_MAIN,
+    CH_MULTIFD,
+    CH_POSTCOPY
+};
+
 void migration_channel_process_incoming(QIOChannel *ioc);
 
 void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc);
@@ -26,4 +34,8 @@ int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
                                 const size_t buflen,
                                 Error **errp);
+
+bool migration_has_main_and_multifd_channels(void);
+bool migration_has_all_channels(void);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 42adee5695..e0aee17317 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -91,9 +91,6 @@ enum mig_rp_message_type {
     MIG_RP_MSG_MAX
 };
 
-/* Migration channel types */
-enum { CH_NONE, CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
-
 /* When we add fault tolerance, we could have several
    migrations at once.  For now we don't need to add
    dynamic creation of migration */
@@ -934,8 +931,6 @@ out:
     migrate_incoming_unref_outgoing_state();
 }
 
-static bool migration_has_main_and_multifd_channels(void);
-
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -1021,99 +1016,6 @@ void migration_start_incoming(void)
     qemu_coroutine_enter(co);
 }
 
-static bool migration_has_main_and_multifd_channels(void)
-{
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    if (!mis->from_src_file) {
-        /* main channel not established */
-        return false;
-    }
-
-    if (migrate_multifd() && !multifd_recv_all_channels_created()) {
-        return false;
-    }
-
-    /* main and all multifd channels are established */
-    return true;
-}
-
-uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
-{
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    uint8_t channel = CH_NONE;
-    uint32_t channel_magic = 0;
-    int ret = 0;
-
-    if (!migration_has_main_and_multifd_channels()) {
-        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
-            /*
-             * With multiple channels, it is possible that we receive channels
-             * out of order on destination side, causing incorrect mapping of
-             * source channels on destination side. Check channel MAGIC to
-             * decide type of channel. Please note this is best effort,
-             * postcopy preempt channel does not send any magic number so
-             * avoid it for postcopy live migration. Also tls live migration
-             * already does tls handshake while initializing main channel so
-             * with tls this issue is not possible.
-             */
-            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                              sizeof(channel_magic), errp);
-            if (ret != 0) {
-                goto out;
-            }
-
-            channel_magic = be32_to_cpu(channel_magic);
-            if (channel_magic == QEMU_VM_FILE_MAGIC) {
-                channel = CH_MAIN;
-            } else if (channel_magic == MULTIFD_MAGIC) {
-                assert(migrate_multifd());
-                channel = CH_MULTIFD;
-            } else if (!mis->from_src_file &&
-                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
-                /* reconnect main channel for postcopy recovery */
-                channel = CH_MAIN;
-            } else {
-                error_setg(errp, "unknown channel magic: %u", channel_magic);
-            }
-        } else if (mis->from_src_file && migrate_multifd()) {
-            /*
-             * Non-peekable channels like tls/file are processed as
-             * multifd channels when multifd is enabled.
-             */
-            channel = CH_MULTIFD;
-        } else if (!mis->from_src_file) {
-            channel = CH_MAIN;
-        } else {
-            error_setg(errp, "non-peekable channel used without multifd");
-        }
-    } else {
-        assert(migrate_postcopy_preempt());
-        channel = CH_POSTCOPY;
-    }
-out:
-    return channel;
-}
-
-/**
- * @migration_has_all_channels: We have received all channels that we need
- *
- * Returns true when we have got connections to all the channels that
- * we need for migration.
- */
-bool migration_has_all_channels(void)
-{
-    if (!migration_has_main_and_multifd_channels()) {
-        return false;
-    }
-
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    if (migrate_postcopy_preempt() && !mis->postcopy_qemufile_dst) {
-        return false;
-    }
-
-    return true;
-}
-
 int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
 {
     return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
diff --git a/migration/migration.h b/migration/migration.h
index cbe90471c2..138831d7d9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -529,13 +529,12 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
 void migration_outgoing_setup(QIOChannel *ioc);
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
 
-bool  migration_has_all_channels(void);
-
 void migration_connect_error_propagate(MigrationState *s, Error *error);
 void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
 
-void migration_start_outgoing(MigrationState *s, QEMUFile *file);
+void migration_start_outgoing(MigrationState *s);
+void migration_start_incoming(void);
 
 int migration_call_notifiers(MigrationState *s, MigrationEventType type,
                              Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index 788120a0b1..6e9ca5f5f6 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "channel.h"
 #include "exec/target_page.h"
 #include "rdma.h"
 #include "migration.h"
-- 
2.51.0


