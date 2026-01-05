Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B17C79FBB
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcpws-0001Er-49; Mon, 05 Jan 2026 14:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvx-0007zv-Jr
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:07 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vcpvv-0005bL-Ja
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:08:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AF4133769;
 Mon,  5 Jan 2026 19:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2b9JEsbabxQXPEjgwCwHEO0tBtofIMWlZReL6Obrk0=;
 b=a3u1Xzu0BS4olpgedjUyt754IXAhhzdZ35W2I3Vgg5Uip5oLyeB8LVTJ63ZMGUJUCyAdnu
 3Kx96g7IojYLzKje3WVmezh2i0/0qId6MU59IDXjAHeJhpChD+WB7PEab6QHQz5FUiNudD
 lSZMwkdwjC82OCwLkUGphsM/15eshVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2b9JEsbabxQXPEjgwCwHEO0tBtofIMWlZReL6Obrk0=;
 b=vk7mrxj9XuRqMbB08/SCgyQvmlBfis31Mp3i/XHHjn9yrj9Ov0m/rBRTAg9y2avosgbDSu
 YjyzQN2z8YEbljCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767640044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2b9JEsbabxQXPEjgwCwHEO0tBtofIMWlZReL6Obrk0=;
 b=a3u1Xzu0BS4olpgedjUyt754IXAhhzdZ35W2I3Vgg5Uip5oLyeB8LVTJ63ZMGUJUCyAdnu
 3Kx96g7IojYLzKje3WVmezh2i0/0qId6MU59IDXjAHeJhpChD+WB7PEab6QHQz5FUiNudD
 lSZMwkdwjC82OCwLkUGphsM/15eshVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767640044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2b9JEsbabxQXPEjgwCwHEO0tBtofIMWlZReL6Obrk0=;
 b=vk7mrxj9XuRqMbB08/SCgyQvmlBfis31Mp3i/XHHjn9yrj9Ov0m/rBRTAg9y2avosgbDSu
 YjyzQN2z8YEbljCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A3813964;
 Mon,  5 Jan 2026 19:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mBgnMuoLXGmSOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Jan 2026 19:07:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 18/25] migration: Move channel code to channel.c
Date: Mon,  5 Jan 2026 16:06:35 -0300
Message-ID: <20260105190644.14072-19-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105190644.14072-1-farosas@suse.de>
References: <20260105190644.14072-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Move the code responsible for the various channels connection into
channel.c. This is all executed before the migration_thread and
process_incoming_migration_co are running, so it helps the reasoning
to have them out of migration.c.

migration_ioc_process_incoming becomes migration_channel_identify
which is more in line with what the function does.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 99 ++++++++++++++++++++++++++++++++++++++++++-
 migration/channel.h   |  4 ++
 migration/migration.c | 96 -----------------------------------------
 migration/migration.h |  2 -
 migration/rdma.c      |  1 +
 5 files changed, 103 insertions(+), 99 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 8abcb54447..a6608c5f08 100644
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
index 0e189c4325..59d169e095 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -34,4 +34,8 @@ int migration_channel_read_peek(QIOChannel *ioc,
                                 const char *buf,
                                 const size_t buflen,
                                 Error **errp);
+
+bool migration_has_main_and_multifd_channels(void);
+bool migration_has_all_channels(void);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 5f444958ef..540b419cda 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -927,8 +927,6 @@ out:
     migrate_incoming_unref_outgoing_state();
 }
 
-static bool migration_has_main_and_multifd_channels(void);
-
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -1018,100 +1016,6 @@ void migration_start_incoming(void)
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
-
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
index b852464197..7689c97051 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -532,8 +532,6 @@ void migration_incoming_process(void);
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
 void migration_outgoing_setup(QIOChannel *ioc);
 
-bool  migration_has_all_channels(void);
-
 void migration_connect_error_propagate(MigrationState *s, Error *error);
 void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
diff --git a/migration/rdma.c b/migration/rdma.c
index ef95ce440d..582e0651d4 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -18,6 +18,7 @@
 #include "channel.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "channel.h"
 #include "exec/target_page.h"
 #include "rdma.h"
 #include "migration.h"
-- 
2.51.0


