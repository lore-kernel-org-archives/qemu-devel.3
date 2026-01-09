Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C29D1A616
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBp3-0006bd-N7; Fri, 09 Jan 2026 07:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBom-0006QW-Ml
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:42:19 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBok-0007OY-Oz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:42:16 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0B03337E0;
 Fri,  9 Jan 2026 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iX8khRyd67IY+/lzUJlDAoAUTCKpl9uRkYwJv3FEI9k=;
 b=xkWNAyy2UAZ6DDgZh9bgcSdGHabb2vfFscVnrpjxyN+5XZiYYoRPfQpbTKdl8sj4QMOh7n
 WfYi9TTL6aMoOBTDHojVojgGSLln3Qwl7ISkE5VRDIcMY3GU6o7bWYjP1BNe/fLr4XNj7T
 nL57znb5ZjWkcSJFsXjHaOy056CdGwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iX8khRyd67IY+/lzUJlDAoAUTCKpl9uRkYwJv3FEI9k=;
 b=AH1EDxoYcVx5Ef1KmhIElxrpPmgigWS83VI1jTfrhEltzl7+r53tHRAWcMkVmr7sebLlGk
 WAJOgzybbNLV3tDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xkWNAyy2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AH1EDxoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iX8khRyd67IY+/lzUJlDAoAUTCKpl9uRkYwJv3FEI9k=;
 b=xkWNAyy2UAZ6DDgZh9bgcSdGHabb2vfFscVnrpjxyN+5XZiYYoRPfQpbTKdl8sj4QMOh7n
 WfYi9TTL6aMoOBTDHojVojgGSLln3Qwl7ISkE5VRDIcMY3GU6o7bWYjP1BNe/fLr4XNj7T
 nL57znb5ZjWkcSJFsXjHaOy056CdGwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iX8khRyd67IY+/lzUJlDAoAUTCKpl9uRkYwJv3FEI9k=;
 b=AH1EDxoYcVx5Ef1KmhIElxrpPmgigWS83VI1jTfrhEltzl7+r53tHRAWcMkVmr7sebLlGk
 WAJOgzybbNLV3tDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 387563EA63;
 Fri,  9 Jan 2026 12:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJyxOHf3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:41:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 21/25] migration: Move URI parsing to channel.c
Date: Fri,  9 Jan 2026 09:40:37 -0300
Message-ID: <20260109124043.25019-22-farosas@suse.de>
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
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C0B03337E0
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

The migrate_uri_parse function is responsible for converting the URI
string into a MigrationChannel for consumption by the rest of the
code. Move it to channel.c and add a wrapper that calls both URI and
channels parsing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 82 +++++++++++++++++++++++++++++++++++--
 migration/channel.h   |  9 ++--
 migration/migration.c | 95 ++-----------------------------------------
 3 files changed, 86 insertions(+), 100 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 8b71b3f430..cee78532ea 100644
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
     bool single_channel = cpr_channelp ? false : true;
@@ -325,3 +325,77 @@ bool migrate_channels_parse(MigrationChannelList *channels,
 
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
index 98c1f38e8e..52c1bb5da2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -15,7 +15,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
-#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
@@ -659,61 +658,6 @@ bool migrate_is_uri(const char *uri)
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
@@ -744,27 +688,10 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
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
@@ -2113,27 +2040,11 @@ void qmp_migrate(const char *uri, bool has_channels,
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


