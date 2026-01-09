Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00699D1A616
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBoM-0004cd-S9; Fri, 09 Jan 2026 07:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoA-0003uD-Df
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBo8-0007Kj-5u
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:37 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F6FA5BCE7;
 Fri,  9 Jan 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivwXwIkvjOm0smjHDsnACFt7oN8qCf3a7Ve8f0KmueA=;
 b=Cagw1y9CJ0yR7zl8rtL6SpJB20Iz2YPjh/EbDEdDytmgt12JZLDnzLyLkylGxUpQoWf+o9
 mfaYEOu4EtR1wu5LLKVZmBV4dtAbUMzjepZJRr45xaS1fO7+pNyWJowKyJFtzjcLrQzuYe
 dKgwQRyWMLhdwcbZ4Hx6zhDG5zPIbGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivwXwIkvjOm0smjHDsnACFt7oN8qCf3a7Ve8f0KmueA=;
 b=G1uSF1WEnexJvDD0NgIdYZfWl3Mbe/N81C75C99VARC4Fl20jnIqnO4X/F4mxQKSiPMocs
 uv46pH+j1IYahEAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivwXwIkvjOm0smjHDsnACFt7oN8qCf3a7Ve8f0KmueA=;
 b=Cagw1y9CJ0yR7zl8rtL6SpJB20Iz2YPjh/EbDEdDytmgt12JZLDnzLyLkylGxUpQoWf+o9
 mfaYEOu4EtR1wu5LLKVZmBV4dtAbUMzjepZJRr45xaS1fO7+pNyWJowKyJFtzjcLrQzuYe
 dKgwQRyWMLhdwcbZ4Hx6zhDG5zPIbGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivwXwIkvjOm0smjHDsnACFt7oN8qCf3a7Ve8f0KmueA=;
 b=G1uSF1WEnexJvDD0NgIdYZfWl3Mbe/N81C75C99VARC4Fl20jnIqnO4X/F4mxQKSiPMocs
 uv46pH+j1IYahEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D853EA63;
 Fri,  9 Jan 2026 12:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJhwBGz3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 15/25] migration: Start incoming from channel.c
Date: Fri,  9 Jan 2026 09:40:31 -0300
Message-ID: <20260109124043.25019-16-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Leave migration_ioc_process_incoming to do only the channel
identification process and move the migration start into
channel.c. Both routines will be renamed in the next patches to better
reflect their usage.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 12 ++++++++++--
 migration/channel.h   |  5 +++--
 migration/migration.c | 13 +++++--------
 migration/migration.h |  3 ++-
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 6acce7b2a2..b8d757c17b 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -33,6 +33,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
+    MigChannelType ch;
 
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
@@ -41,9 +42,16 @@ void migration_channel_process_incoming(QIOChannel *ioc)
         migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
         migration_ioc_register_yank(ioc);
-        migration_ioc_process_incoming(ioc, &local_err);
-    }
+        ch = migration_ioc_process_incoming(ioc, &local_err);
+        if (!ch) {
+            goto out;
+        }
 
+        if (migration_incoming_setup(ioc, ch, &local_err)) {
+            migration_incoming_process();
+        }
+    }
+out:
     if (local_err) {
         error_report_err(local_err);
         migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
diff --git a/migration/channel.h b/migration/channel.h
index 93dedbf52b..b361e1c838 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -19,11 +19,12 @@
 #include "io/channel.h"
 
 /* Migration channel types */
-enum {
+typedef enum {
+    CH_NONE,
     CH_MAIN,
     CH_MULTIFD,
     CH_POSTCOPY
-};
+} MigChannelType;
 
 void migration_channel_process_incoming(QIOChannel *ioc);
 
diff --git a/migration/migration.c b/migration/migration.c
index 7d56d73769..a052b99a19 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1038,10 +1038,10 @@ static bool migration_has_main_and_multifd_channels(void)
     return true;
 }
 
-void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
+MigChannelType migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    uint8_t channel;
+    MigChannelType channel = CH_NONE;
     uint32_t channel_magic = 0;
     int ret = 0;
 
@@ -1060,7 +1060,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
             ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
                                               sizeof(channel_magic), errp);
             if (ret != 0) {
-                return;
+                goto out;
             }
 
             channel_magic = be32_to_cpu(channel_magic);
@@ -1075,7 +1075,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
                 channel = CH_MAIN;
             } else {
                 error_setg(errp, "unknown channel magic: %u", channel_magic);
-                return;
             }
         } else if (mis->from_src_file && migrate_multifd()) {
             /*
@@ -1087,16 +1086,14 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
             channel = CH_MAIN;
         } else {
             error_setg(errp, "non-peekable channel used without multifd");
-            return;
         }
     } else {
         assert(migrate_postcopy_preempt());
         channel = CH_POSTCOPY;
     }
 
-    if (migration_incoming_setup(ioc, channel, errp)) {
-        migration_incoming_process();
-    }
+out:
+    return channel;
 }
 
 /**
diff --git a/migration/migration.h b/migration/migration.h
index cd6cfd62ba..b55cc40613 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -28,6 +28,7 @@
 #include "postcopy-ram.h"
 #include "system/runstate.h"
 #include "migration/misc.h"
+#include "channel.h"
 
 #define  MIGRATION_THREAD_SNAPSHOT          "mig/snapshot"
 #define  MIGRATION_THREAD_DIRTY_RATE        "mig/dirtyrate"
@@ -527,7 +528,7 @@ struct MigrationState {
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
                        MigrationStatus new_state);
 
-void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
+MigChannelType migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
 void migration_outgoing_setup(QIOChannel *ioc);
-- 
2.51.0


