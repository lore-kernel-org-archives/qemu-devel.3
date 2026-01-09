Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DA4D1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBor-0006Qn-5d; Fri, 09 Jan 2026 07:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBog-0006It-VY
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:42:11 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBoe-0007O3-Ry
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:42:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9701533A1D;
 Fri,  9 Jan 2026 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcmSyHB43deUahwSZW6lzq1LJs9toIb0Ne+XSt4duUc=;
 b=SlfLRXNNUKJ+uDdUEBD4pTblAyGHjO03PfqEQMA1+LCV1mldPkeMgJALEYRKXcNsrYBk+d
 02S85/GlQvSRwizPPwcaST/BAdstfza0V8z8Bt5XamoEqdeiTzD82truJZUxV7YZWSa5CF
 t5qnReWKn9V7KidYOTa3/qo+KyXvoBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcmSyHB43deUahwSZW6lzq1LJs9toIb0Ne+XSt4duUc=;
 b=z2yI/RwGgl6Y8fTT7ZKZ4q5AVD4nbuo51hmHI4KATamUuJ6QW7c8UO9lhlJcZbsqj638TH
 QVnWRM9uYzwP4dCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SlfLRXNN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="z2yI/RwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcmSyHB43deUahwSZW6lzq1LJs9toIb0Ne+XSt4duUc=;
 b=SlfLRXNNUKJ+uDdUEBD4pTblAyGHjO03PfqEQMA1+LCV1mldPkeMgJALEYRKXcNsrYBk+d
 02S85/GlQvSRwizPPwcaST/BAdstfza0V8z8Bt5XamoEqdeiTzD82truJZUxV7YZWSa5CF
 t5qnReWKn9V7KidYOTa3/qo+KyXvoBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcmSyHB43deUahwSZW6lzq1LJs9toIb0Ne+XSt4duUc=;
 b=z2yI/RwGgl6Y8fTT7ZKZ4q5AVD4nbuo51hmHI4KATamUuJ6QW7c8UO9lhlJcZbsqj638TH
 QVnWRM9uYzwP4dCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47D693EA63;
 Fri,  9 Jan 2026 12:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJkzAnb3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 20/25] migration: Move channel parsing to channel.c
Date: Fri,  9 Jan 2026 09:40:36 -0300
Message-ID: <20260109124043.25019-21-farosas@suse.de>
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
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9701533A1D
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

Encapsulate the MigrationChannelList parsing in a new
migrate_channels_parse() located at channel.c.

This also makes the memory management of the MigrationAddress more
uniform. Previously, half the parsing code (uri parsing) would
allocate memory for the address while the other half (channel parsing)
would instead pass the original QAPI object along. After this patch,
the MigrationAddress is always QAPI_CLONEd, so the callers can use
g_autoptr(MigrationAddress) in all cases.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 45 ++++++++++++++++++++++++++++++++++++++
 migration/channel.h   |  5 +++++
 migration/migration.c | 50 ++++++++++++-------------------------------
 3 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 56c80b5cdf..8b71b3f430 100644
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
@@ -280,3 +283,45 @@ int migration_channel_read_peek(QIOChannel *ioc,
 
     return 0;
 }
+
+bool migrate_channels_parse(MigrationChannelList *channels,
+                            MigrationChannel **main_channelp,
+                            MigrationChannel **cpr_channelp,
+                            Error **errp)
+{
+    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
+    bool single_channel = cpr_channelp ? false : true;
+
+    if (single_channel && channels->next) {
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
index 3c93fb23cc..98c1f38e8e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -741,8 +741,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationChannel) channel = NULL;
-    MigrationAddress *addr = NULL;
+    g_autoptr(MigrationChannel) main_ch = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     /*
@@ -754,25 +753,20 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
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
 
@@ -780,7 +774,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    migration_connect_incoming(addr, errp);
+    migration_connect_incoming(main_ch->addr, errp);
 
     /* Close cpr socket to tell source that we are listening */
     cpr_state_close();
@@ -2116,10 +2110,8 @@ void qmp_migrate(const char *uri, bool has_channels,
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
@@ -2130,38 +2122,24 @@ void qmp_migrate(const char *uri, bool has_channels,
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
+    if (!migration_transport_compatible(main_ch->addr, errp)) {
         return;
     }
 
-    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_ch) {
         error_setg(errp, "missing 'cpr' migration channel");
         return;
     }
@@ -2178,7 +2156,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      */
     Error *local_err = NULL;
 
-    if (!cpr_state_save(cpr_channel, &local_err)) {
+    if (!cpr_state_save(cpr_ch, &local_err)) {
         goto out;
     }
 
@@ -2194,10 +2172,10 @@ void qmp_migrate(const char *uri, bool has_channels,
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


