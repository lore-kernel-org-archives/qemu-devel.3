Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D324EE8FDB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFEy-0002MQ-0J; Fri, 26 Dec 2025 16:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEw-00026q-8b
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:50 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEu-0004Jb-BG
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5106B5BCED;
 Fri, 26 Dec 2025 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwBWQAOlWWAwfAr8E79zLNObl5hWx2bTa1SjZ/6nAOU=;
 b=zQzYxS9N8RAxDs2g5dCl79q79fJ51Eckd7IL3kowCRjhkOKJnbt1cSKzdtlL5ehEOUmfe1
 v1N/YF/PNgnAgzcdvOxNuz7Lh8XpOsOpcxQl5D5hrdVZ4kkGAyyQpK2r2vEQ0eaH5XPiTY
 oo3SpVK6qLqEYKcPyPuBkre9BhUyzkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwBWQAOlWWAwfAr8E79zLNObl5hWx2bTa1SjZ/6nAOU=;
 b=26SSICtPj2mOOHZ37MKuRoCV7O6qhdYMa7f/0VgwcJee/eygdSmo1hoHQv7cDLj5KLoD2N
 t/HRIZ0l+RxnoPDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zQzYxS9N;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=26SSICtP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwBWQAOlWWAwfAr8E79zLNObl5hWx2bTa1SjZ/6nAOU=;
 b=zQzYxS9N8RAxDs2g5dCl79q79fJ51Eckd7IL3kowCRjhkOKJnbt1cSKzdtlL5ehEOUmfe1
 v1N/YF/PNgnAgzcdvOxNuz7Lh8XpOsOpcxQl5D5hrdVZ4kkGAyyQpK2r2vEQ0eaH5XPiTY
 oo3SpVK6qLqEYKcPyPuBkre9BhUyzkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwBWQAOlWWAwfAr8E79zLNObl5hWx2bTa1SjZ/6nAOU=;
 b=26SSICtPj2mOOHZ37MKuRoCV7O6qhdYMa7f/0VgwcJee/eygdSmo1hoHQv7cDLj5KLoD2N
 t/HRIZ0l+RxnoPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 487CF3EA65;
 Fri, 26 Dec 2025 21:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QF+QAgP8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 18/25] migration: Move transport connection code into
 channel.c
Date: Fri, 26 Dec 2025 18:19:20 -0300
Message-ID: <20251226211930.27565-19-farosas@suse.de>
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
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5106B5BCED
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

Move the <transport>_connect_incoming|outgoing functions to channel.c.
It leaves migration.c to deal with the established connection only.

(I sorted the includes)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c   | 66 +++++++++++++++++++++++++++++++++++++++----
 migration/channel.h   |  4 +++
 migration/migration.c | 45 ++---------------------------
 3 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index a9ac3711b5..a06aa8189c 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -12,18 +12,74 @@
 
 #include "qemu/osdep.h"
 #include "channel.h"
-#include "tls.h"
+#include "exec.h"
+#include "fd.h"
+#include "file.h"
+#include "io/channel-socket.h"
+#include "io/channel-tls.h"
 #include "migration.h"
 #include "multifd.h"
-#include "savevm.h"
-#include "trace.h"
 #include "options.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/error.h"
-#include "io/channel-tls.h"
-#include "io/channel-socket.h"
+#include "qemu-file.h"
 #include "qemu/yank.h"
+#include "rdma.h"
+#include "savevm.h"
+#include "socket.h"
+#include "tls.h"
+#include "trace.h"
 #include "yank_functions.h"
 
+void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
+                                Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_connect_outgoing(s, saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_connect_outgoing(s, saddr->u.fd.str, errp);
+        }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_connect_outgoing(s, &addr->u.rdma, errp);
+#endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_connect_outgoing(s, addr->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_connect_outgoing(s, &addr->u.file, errp);
+    } else {
+        error_setg(errp, "uri is not a valid migration protocol");
+    }
+}
+
+void migration_connect_incoming(MigrationAddress *addr, Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_connect_incoming(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_connect_incoming(saddr->u.fd.str, errp);
+        }
+#ifdef CONFIG_RDMA
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_connect_incoming(&addr->u.rdma, errp);
+#endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_connect_incoming(addr->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        file_connect_incoming(&addr->u.file, errp);
+    } else {
+        error_setg(errp, "unknown migration protocol");
+    }
+}
+
 bool migration_has_main_and_multifd_channels(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
diff --git a/migration/channel.h b/migration/channel.h
index 59d169e095..727eabf16c 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -17,6 +17,7 @@
 #define QEMU_MIGRATION_CHANNEL_H
 
 #include "io/channel.h"
+#include "qapi/qapi-types-migration.h"
 
 /* Migration channel types */
 enum {
@@ -38,4 +39,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
 bool migration_has_main_and_multifd_channels(void);
 bool migration_has_all_channels(void);
 
+void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
+                                Error **errp);
+void migration_connect_incoming(MigrationAddress *addr, Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index e0aee17317..9e69141e86 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -20,13 +20,10 @@
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
 #include "exec.h"
-#include "fd.h"
 #include "file.h"
-#include "socket.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/cpu-throttle.h"
-#include "rdma.h"
 #include "ram.h"
 #include "migration/cpr.h"
 #include "migration/global_state.h"
@@ -787,26 +784,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &addr->u.socket;
-        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_connect_incoming(saddr, errp);
-        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_connect_incoming(saddr->u.fd.str, errp);
-        }
-#ifdef CONFIG_RDMA
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_connect_incoming(&addr->u.rdma, errp);
-#endif
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_connect_incoming(addr->u.exec.args, errp);
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_connect_incoming(&addr->u.file, errp);
-    } else {
-        error_setg(errp, "unknown migration protocol: %s", uri);
-    }
+    migration_connect_incoming(addr, errp);
 
     /* Close cpr socket to tell source that we are listening */
     cpr_state_close();
@@ -2241,26 +2219,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
 
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &addr->u.socket;
-        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_connect_outgoing(s, saddr, &local_err);
-        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_connect_outgoing(s, saddr->u.fd.str, &local_err);
-        }
-#ifdef CONFIG_RDMA
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_connect_outgoing(s, &addr->u.rdma, &local_err);
-#endif
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_connect_outgoing(s, addr->u.exec.args, &local_err);
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_connect_outgoing(s, &addr->u.file, &local_err);
-    } else {
-        error_setg(&local_err, "uri is not a valid migration protocol");
-    }
+    migration_connect_outgoing(s, addr, &local_err);
 }
 
 void qmp_migrate_cancel(Error **errp)
-- 
2.51.0


