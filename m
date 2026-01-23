Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220F1D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFq-0006PW-E5; Fri, 23 Jan 2026 14:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFo-0006BB-2x
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:36 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFk-0003qI-8y
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBD1233866;
 Fri, 23 Jan 2026 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IATb0QqTzYKzS4rL9V/BnPc4x3MZhFA20VoNYqecfc=;
 b=JjR7PR6SQUybDHXiIr9g0hK7jJnAVi0Pu+7m+keDCoyQHqy8UFVg9i52Fh3WBDrhaeNP3l
 1oHsvEcJ2h+0vP7Nd2pB4zMc04luD9S/s7Ujc+cfB83/Oks8Yn3MOr2vMmvj6shUAjwC1l
 rWBHGOusP6UNXRytJqF1HSUax72KUdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IATb0QqTzYKzS4rL9V/BnPc4x3MZhFA20VoNYqecfc=;
 b=4tSyvFkFngRFR2Bv2GIzGUU5rrUUqS+Tmb0KGnQCHaDIz7UmOhpKYHLOc1Xk5psJbQDIMM
 UnENLKwhNGHV6ADA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JjR7PR6S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4tSyvFkF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IATb0QqTzYKzS4rL9V/BnPc4x3MZhFA20VoNYqecfc=;
 b=JjR7PR6SQUybDHXiIr9g0hK7jJnAVi0Pu+7m+keDCoyQHqy8UFVg9i52Fh3WBDrhaeNP3l
 1oHsvEcJ2h+0vP7Nd2pB4zMc04luD9S/s7Ujc+cfB83/Oks8Yn3MOr2vMmvj6shUAjwC1l
 rWBHGOusP6UNXRytJqF1HSUax72KUdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IATb0QqTzYKzS4rL9V/BnPc4x3MZhFA20VoNYqecfc=;
 b=4tSyvFkFngRFR2Bv2GIzGUU5rrUUqS+Tmb0KGnQCHaDIz7UmOhpKYHLOc1Xk5psJbQDIMM
 UnENLKwhNGHV6ADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7758E1395E;
 Fri, 23 Jan 2026 19:54:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHwCDgrSc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 31/36] migration: Move channel parsing to channel.c
Date: Fri, 23 Jan 2026 16:53:46 -0300
Message-ID: <20260123195352.12850-32-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CBD1233866
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Encapsulate the MigrationChannelList parsing in a new
migrate_channels_parse() located at channel.c.

This also makes the memory management of the MigrationAddress more
uniform. Previously, half the parsing code (uri parsing) would
allocate memory for the address while the other half (channel parsing)
would instead pass the original QAPI object along. After this patch,
the MigrationAddress is always QAPI_CLONEd, so the callers can use
g_autoptr(MigrationAddress) in all cases.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-21-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 49 +++++++++++++++++++++++++++++++++++++++
 migration/channel.h   |  5 ++++
 migration/migration.c | 53 +++++++++++--------------------------------
 3 files changed, 67 insertions(+), 40 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 56c80b5cdf..433d67fba0 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "channel.h"
 #include "exec.h"
 #include "fd.h"
@@ -20,7 +21,9 @@
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
 #include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/error.h"
 #include "qemu-file.h"
 #include "qemu/yank.h"
@@ -280,3 +283,49 @@ int migration_channel_read_peek(QIOChannel *ioc,
 
     return 0;
 }
+
+bool migrate_channels_parse(MigrationChannelList *channels,
+                            MigrationChannel **main_channelp,
+                            MigrationChannel **cpr_channelp,
+                            Error **errp)
+{
+    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
+
+    if (!cpr_channelp && channels->next) {
+        error_setg(errp, "Channel list must have only one entry, "
+                   "for type 'main'");
+        return false;
+    }
+
+    for ( ; channels; channels = channels->next) {
+        MigrationChannelType type;
+
+        type = channels->value->channel_type;
+        if (channelv[type]) {
+            error_setg(errp, "Channel list has more than one %s entry",
+                       MigrationChannelType_str(type));
+            return false;
+        }
+        channelv[type] = channels->value;
+    }
+
+    if (cpr_channelp) {
+        *cpr_channelp = QAPI_CLONE(MigrationChannel,
+                                   channelv[MIGRATION_CHANNEL_TYPE_CPR]);
+
+        if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !*cpr_channelp) {
+            error_setg(errp, "missing 'cpr' migration channel");
+            return false;
+        }
+    }
+
+    *main_channelp = QAPI_CLONE(MigrationChannel,
+                                channelv[MIGRATION_CHANNEL_TYPE_MAIN]);
+
+    if (!(*main_channelp)->addr) {
+        error_setg(errp, "Channel list has no main entry");
+        return false;
+    }
+
+    return true;
+}
diff --git a/migration/channel.h b/migration/channel.h
index 8264fe327d..5110fb45a4 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -42,4 +42,9 @@ bool migration_has_all_channels(void);
 void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp);
 void migration_connect_incoming(MigrationAddress *addr, Error **errp);
+
+bool migrate_channels_parse(MigrationChannelList *channels,
+                            MigrationChannel **main_channelp,
+                            MigrationChannel **cpr_channelp,
+                            Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 8226a6e557..f823bf2584 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -740,8 +740,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationChannel) channel = NULL;
-    MigrationAddress *addr = NULL;
+    g_autoptr(MigrationChannel) main_ch = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     /*
@@ -753,25 +752,20 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
     }
 
     if (channels) {
-        /* To verify that Migrate channel list has only item */
-        if (channels->next) {
-            error_setg(errp, "Channel list must have only one entry, "
-                             "for type 'main'");
+        if (!migrate_channels_parse(channels, &main_ch, NULL, errp)) {
             return;
         }
-        addr = channels->value->addr;
     }
 
     if (uri) {
         /* caller uses the old URI syntax */
-        if (!migrate_uri_parse(uri, &channel, errp)) {
+        if (!migrate_uri_parse(uri, &main_ch, errp)) {
             return;
         }
-        addr = channel->addr;
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(main_ch->addr, errp)) {
         return;
     }
 
@@ -779,7 +773,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    migration_connect_incoming(addr, errp);
+    migration_connect_incoming(main_ch->addr, errp);
 
     /* Close cpr socket to tell source that we are listening */
     cpr_state_close();
@@ -2113,10 +2107,8 @@ void qmp_migrate(const char *uri, bool has_channels,
                  bool has_resume, bool resume, Error **errp)
 {
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationChannel) channel = NULL;
-    MigrationAddress *addr = NULL;
-    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
-    MigrationChannel *cpr_channel = NULL;
+    g_autoptr(MigrationChannel) main_ch = NULL;
+    g_autoptr(MigrationChannel) cpr_ch = NULL;
 
     /*
      * Having preliminary checks for uri and channel
@@ -2127,39 +2119,20 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     if (channels) {
-        for ( ; channels; channels = channels->next) {
-            MigrationChannelType type = channels->value->channel_type;
-
-            if (channelv[type]) {
-                error_setg(errp, "Channel list has more than one %s entry",
-                           MigrationChannelType_str(type));
-                return;
-            }
-            channelv[type] = channels->value;
-        }
-        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
-        addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
-        if (!addr) {
-            error_setg(errp, "Channel list has no main entry");
+        if (!migrate_channels_parse(channels, &main_ch, &cpr_ch, errp)) {
             return;
         }
     }
 
     if (uri) {
         /* caller uses the old URI syntax */
-        if (!migrate_uri_parse(uri, &channel, errp)) {
+        if (!migrate_uri_parse(uri, &main_ch, errp)) {
             return;
         }
-        addr = channel->addr;
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_transport_compatible(addr, errp)) {
-        return;
-    }
-
-    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
-        error_setg(errp, "missing 'cpr' migration channel");
+    if (!migration_transport_compatible(main_ch->addr, errp)) {
         return;
     }
 
@@ -2175,7 +2148,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     Error *local_err = NULL;
 
-    if (!cpr_state_save(cpr_channel, &local_err)) {
+    if (!cpr_state_save(cpr_ch, &local_err)) {
         goto out;
     }
 
@@ -2191,10 +2164,10 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
-                        QAPI_CLONE(MigrationAddress, addr));
+                        QAPI_CLONE(MigrationAddress, main_ch->addr));
 
     } else {
-        qmp_migrate_finish(addr, errp);
+        qmp_migrate_finish(main_ch->addr, errp);
     }
 
 out:
-- 
2.51.0


