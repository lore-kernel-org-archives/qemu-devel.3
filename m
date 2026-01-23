Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A125D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFv-0006wm-VB; Fri, 23 Jan 2026 14:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFu-0006nQ-7E
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:42 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFr-0003rJ-U0
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BB6A33869;
 Fri, 23 Jan 2026 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zDqLxoYlwVjgUAFNvnbMOjocAY9p1izeH2cO3nsfxA=;
 b=qi3q/ogOfsVFBhDMHR2PT2QiW8ocrOU57oF0Jac73g2qkWWEabedGsulUp6iyp9wpTno8Z
 +2QERTXAIllKUE+17yh8zthWiaMqXx/BhVpFnAWmpufwhrKZjlU+6AqrukbnDFnTZZ17xa
 ugFjb1Z1Vf5N80hGDtAo4bu5BbaogsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zDqLxoYlwVjgUAFNvnbMOjocAY9p1izeH2cO3nsfxA=;
 b=4B1MhfZOkljJTfUxhsoRDgZ6acg4TzhAtQb1e4Rt9N603XTdymMacf5RbJe6yzaUXEoOt+
 IrcPx5XkCfaOCLBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qi3q/ogO";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4B1MhfZO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zDqLxoYlwVjgUAFNvnbMOjocAY9p1izeH2cO3nsfxA=;
 b=qi3q/ogOfsVFBhDMHR2PT2QiW8ocrOU57oF0Jac73g2qkWWEabedGsulUp6iyp9wpTno8Z
 +2QERTXAIllKUE+17yh8zthWiaMqXx/BhVpFnAWmpufwhrKZjlU+6AqrukbnDFnTZZ17xa
 ugFjb1Z1Vf5N80hGDtAo4bu5BbaogsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zDqLxoYlwVjgUAFNvnbMOjocAY9p1izeH2cO3nsfxA=;
 b=4B1MhfZOkljJTfUxhsoRDgZ6acg4TzhAtQb1e4Rt9N603XTdymMacf5RbJe6yzaUXEoOt+
 IrcPx5XkCfaOCLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 458ED1395E;
 Fri, 23 Jan 2026 19:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OATWAQzSc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 32/36] migration: Move URI parsing to channel.c
Date: Fri, 23 Jan 2026 16:53:47 -0300
Message-ID: <20260123195352.12850-33-farosas@suse.de>
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
X-Rspamd-Queue-Id: 9BB6A33869
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

The migrate_uri_parse function is responsible for converting the URI
string into a MigrationChannel for consumption by the rest of the
code. Move it to channel.c and add a wrapper that calls both URI and
channels parsing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-22-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 82 +++++++++++++++++++++++++++++++++++--
 migration/channel.h   |  9 ++--
 migration/migration.c | 95 ++-----------------------------------------
 3 files changed, 86 insertions(+), 100 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 433d67fba0..1e4778455d 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -284,10 +284,10 @@ int migration_channel_read_peek(QIOChannel *ioc,
     return 0;
 }
 
-bool migrate_channels_parse(MigrationChannelList *channels,
-                            MigrationChannel **main_channelp,
-                            MigrationChannel **cpr_channelp,
-                            Error **errp)
+static bool migrate_channels_parse(MigrationChannelList *channels,
+                                   MigrationChannel **main_channelp,
+                                   MigrationChannel **cpr_channelp,
+                                   Error **errp)
 {
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
 
@@ -329,3 +329,77 @@ bool migrate_channels_parse(MigrationChannelList *channels,
 
     return true;
 }
+
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp)
+{
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
+    InetSocketAddress *isock = &addr->u.rdma;
+    strList **tail = &addr->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
+#ifdef WIN32
+        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
+        QAPI_LIST_APPEND(tail, g_strdup("/c"));
+#else
+        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
+        QAPI_LIST_APPEND(tail, g_strdup("-c"));
+#endif
+        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
+    } else if (strstart(uri, "rdma:", NULL)) {
+        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
+            qapi_free_InetSocketAddress(isock);
+            return false;
+        }
+        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
+    } else if (strstart(uri, "tcp:", NULL) ||
+                strstart(uri, "unix:", NULL) ||
+                strstart(uri, "vsock:", NULL) ||
+                strstart(uri, "fd:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+        SocketAddress *saddr = socket_parse(uri, errp);
+        if (!saddr) {
+            return false;
+        }
+        addr->u.socket.type = saddr->type;
+        addr->u.socket.u = saddr->u;
+        /* Don't free the objects inside; their ownership moved to "addr" */
+        g_free(saddr);
+    } else if (strstart(uri, "file:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
+        addr->u.file.filename = g_strdup(uri + strlen("file:"));
+        if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
+                              errp)) {
+            return false;
+        }
+    } else {
+        error_setg(errp, "unknown migration protocol: %s", uri);
+        return false;
+    }
+
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = g_steal_pointer(&addr);
+    *channel = g_steal_pointer(&val);
+    return true;
+}
+
+bool migration_channel_parse_input(const char *uri,
+                                   MigrationChannelList *channels,
+                                   MigrationChannel **main_channelp,
+                                   MigrationChannel **cpr_channelp,
+                                   Error **errp)
+{
+    if (!uri == !channels) {
+        error_setg(errp, "need either 'uri' or 'channels' argument");
+        return false;
+    }
+
+    if (channels) {
+        return migrate_channels_parse(channels, main_channelp, cpr_channelp,
+                                      errp);
+    } else {
+        return migrate_uri_parse(uri, main_channelp, errp);
+    }
+}
diff --git a/migration/channel.h b/migration/channel.h
index 5110fb45a4..a7d0d29058 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -43,8 +43,9 @@ void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp);
 void migration_connect_incoming(MigrationAddress *addr, Error **errp);
 
-bool migrate_channels_parse(MigrationChannelList *channels,
-                            MigrationChannel **main_channelp,
-                            MigrationChannel **cpr_channelp,
-                            Error **errp);
+bool migration_channel_parse_input(const char *uri,
+                                   MigrationChannelList *channels,
+                                   MigrationChannel **main_channelp,
+                                   MigrationChannel **cpr_channelp,
+                                   Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index f823bf2584..336d5df3b2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -15,7 +15,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
@@ -658,61 +657,6 @@ bool migrate_is_uri(const char *uri)
     return *uri == ':';
 }
 
-bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
-                       Error **errp)
-{
-    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
-    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
-    InetSocketAddress *isock = &addr->u.rdma;
-    strList **tail = &addr->u.exec.args;
-
-    if (strstart(uri, "exec:", NULL)) {
-        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
-#ifdef WIN32
-        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
-        QAPI_LIST_APPEND(tail, g_strdup("/c"));
-#else
-        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
-        QAPI_LIST_APPEND(tail, g_strdup("-c"));
-#endif
-        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
-    } else if (strstart(uri, "rdma:", NULL)) {
-        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
-            qapi_free_InetSocketAddress(isock);
-            return false;
-        }
-        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
-    } else if (strstart(uri, "tcp:", NULL) ||
-                strstart(uri, "unix:", NULL) ||
-                strstart(uri, "vsock:", NULL) ||
-                strstart(uri, "fd:", NULL)) {
-        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
-        SocketAddress *saddr = socket_parse(uri, errp);
-        if (!saddr) {
-            return false;
-        }
-        addr->u.socket.type = saddr->type;
-        addr->u.socket.u = saddr->u;
-        /* Don't free the objects inside; their ownership moved to "addr" */
-        g_free(saddr);
-    } else if (strstart(uri, "file:", NULL)) {
-        addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
-        addr->u.file.filename = g_strdup(uri + strlen("file:"));
-        if (file_parse_offset(addr->u.file.filename, &addr->u.file.offset,
-                              errp)) {
-            return false;
-        }
-    } else {
-        error_setg(errp, "unknown migration protocol: %s", uri);
-        return false;
-    }
-
-    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
-    val->addr = g_steal_pointer(&addr);
-    *channel = g_steal_pointer(&val);
-    return true;
-}
-
 static bool
 migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
 {
@@ -743,27 +687,10 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
     g_autoptr(MigrationChannel) main_ch = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    /*
-     * Having preliminary checks for uri and channel
-     */
-    if (!uri == !channels) {
-        error_setg(errp, "need either 'uri' or 'channels' argument");
+    if (!migration_channel_parse_input(uri, channels, &main_ch, NULL, errp)) {
         return;
     }
 
-    if (channels) {
-        if (!migrate_channels_parse(channels, &main_ch, NULL, errp)) {
-            return;
-        }
-    }
-
-    if (uri) {
-        /* caller uses the old URI syntax */
-        if (!migrate_uri_parse(uri, &main_ch, errp)) {
-            return;
-        }
-    }
-
     /* transport mechanism not suitable for migration? */
     if (!migration_transport_compatible(main_ch->addr, errp)) {
         return;
@@ -2110,27 +2037,11 @@ void qmp_migrate(const char *uri, bool has_channels,
     g_autoptr(MigrationChannel) main_ch = NULL;
     g_autoptr(MigrationChannel) cpr_ch = NULL;
 
-    /*
-     * Having preliminary checks for uri and channel
-     */
-    if (!uri == !channels) {
-        error_setg(errp, "need either 'uri' or 'channels' argument");
+    if (!migration_channel_parse_input(uri, channels, &main_ch, &cpr_ch,
+                                       errp)) {
         return;
     }
 
-    if (channels) {
-        if (!migrate_channels_parse(channels, &main_ch, &cpr_ch, errp)) {
-            return;
-        }
-    }
-
-    if (uri) {
-        /* caller uses the old URI syntax */
-        if (!migrate_uri_parse(uri, &main_ch, errp)) {
-            return;
-        }
-    }
-
     /* transport mechanism not suitable for migration? */
     if (!migration_transport_compatible(main_ch->addr, errp)) {
         return;
-- 
2.51.0


