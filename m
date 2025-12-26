Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5C6E8FDBA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFEY-0001XF-M5; Fri, 26 Dec 2025 16:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEU-0001SN-4T
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:22 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFES-00047x-Fp
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91762336A8;
 Fri, 26 Dec 2025 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUyCvyJIWhl+/SpTLRotM1zYCsp+lUHnfmiZRYJQwZA=;
 b=eO0l++jsbXsChOFfr/dYJtCogMcWNecVDVG0G6hwgU4E1h4MBNt1rjnZf7y/uLWrPBOZ/Q
 FDVu2qELn7PZIt4lpwqBMdbs1YJJ0ffd8fKZEy/FudBmoyl7th5WlnttvEKO4g4Qi0WOS2
 as1kiontTUs//qY1+DgdS2NgN93qSvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUyCvyJIWhl+/SpTLRotM1zYCsp+lUHnfmiZRYJQwZA=;
 b=NGtN5PgORLyCqkxZNWrwzAMCWZsuGF6CtDwRdCI4LcT4uGk5mvqsl17fZtJKs4y9t/Ni+f
 FPidLX/86qsk+sBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eO0l++js;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NGtN5PgO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUyCvyJIWhl+/SpTLRotM1zYCsp+lUHnfmiZRYJQwZA=;
 b=eO0l++jsbXsChOFfr/dYJtCogMcWNecVDVG0G6hwgU4E1h4MBNt1rjnZf7y/uLWrPBOZ/Q
 FDVu2qELn7PZIt4lpwqBMdbs1YJJ0ffd8fKZEy/FudBmoyl7th5WlnttvEKO4g4Qi0WOS2
 as1kiontTUs//qY1+DgdS2NgN93qSvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUyCvyJIWhl+/SpTLRotM1zYCsp+lUHnfmiZRYJQwZA=;
 b=NGtN5PgORLyCqkxZNWrwzAMCWZsuGF6CtDwRdCI4LcT4uGk5mvqsl17fZtJKs4y9t/Ni+f
 FPidLX/86qsk+sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C9F33EA65;
 Fri, 26 Dec 2025 21:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AApLDwr8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 22/25] migration/channel: Merge both sides of the
 connection initiation code
Date: Fri, 26 Dec 2025 18:19:24 -0300
Message-ID: <20251226211930.27565-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91762336A8
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Now that everything is in channel.c, it's easier to browse this code
if it's all in the same place. It's also easier to grasp what the
connection flow is if both sides of the connection are close together.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 86 +++++++++++++++++++++++----------------------
 migration/channel.h | 14 ++++++--
 2 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 042e01b224..ba9aa1c58b 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -31,10 +31,11 @@
 #include "trace.h"
 #include "yank_functions.h"
 
-bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
+bool migration_connect(MigrationAddress *addr, bool out, Error **errp)
 {
     g_autoptr(QIOChannel) ioc = NULL;
     SocketAddress *saddr;
+    ERRP_GUARD();
 
     switch (addr->transport) {
     case MIGRATION_ADDRESS_TYPE_SOCKET:
@@ -44,15 +45,24 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
         case SOCKET_ADDRESS_TYPE_INET:
         case SOCKET_ADDRESS_TYPE_UNIX:
         case SOCKET_ADDRESS_TYPE_VSOCK:
-            socket_connect_outgoing(saddr, errp);
-            /*
-             * async: after the socket is connected, calls
-             * migration_channel_connect_outgoing() directly.
-             */
-            return true;
+            if (out) {
+                socket_connect_outgoing(saddr, errp);
+                /*
+                 * async: after the socket is connected, calls
+                 * migration_channel_connect_outgoing() directly.
+                 */
+                return true;
+            } else {
+                socket_connect_incoming(saddr, errp);
+            }
+
             break;
         case SOCKET_ADDRESS_TYPE_FD:
-            ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
+            if (out) {
+                ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
+            } else {
+                fd_connect_incoming(saddr->u.fd.str, errp);
+            }
             break;
         default:
             g_assert_not_reached();
@@ -62,16 +72,28 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
 
 #ifdef CONFIG_RDMA
     case MIGRATION_ADDRESS_TYPE_RDMA:
-        ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
+        if (out) {
+            ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
+        } else {
+            rdma_connect_incoming(&addr->u.rdma, errp);
+        }
         break;
 #endif
 
     case MIGRATION_ADDRESS_TYPE_EXEC:
-        ioc = exec_connect_outgoing(addr->u.exec.args, errp);
+        if (out) {
+            ioc = exec_connect_outgoing(addr->u.exec.args, errp);
+        } else {
+            exec_connect_incoming(addr->u.exec.args, errp);
+        }
         break;
 
     case MIGRATION_ADDRESS_TYPE_FILE:
-        ioc = file_connect_outgoing(&addr->u.file, errp);
+        if (out) {
+            ioc = file_connect_outgoing(&addr->u.file, errp);
+        } else {
+            file_connect_incoming(&addr->u.file, errp);
+        }
         break;
 
     default:
@@ -79,42 +101,22 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
         break;
     }
 
-    if (!ioc) {
-        return false;
-    }
-
-    migration_channel_connect_outgoing(ioc);
-    return true;
-}
-
-void migration_connect_incoming(MigrationAddress *addr, Error **errp)
-{
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &addr->u.socket;
-        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
-            socket_connect_incoming(saddr, errp);
-        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
-            fd_connect_incoming(saddr->u.fd.str, errp);
+    if (out) {
+        if (!ioc) {
+            return false;
         }
-#ifdef CONFIG_RDMA
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_connect_incoming(&addr->u.rdma, errp);
-#endif
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_connect_incoming(addr->u.exec.args, errp);
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
-        file_connect_incoming(&addr->u.file, errp);
-    } else {
-        error_setg(errp, "unknown migration protocol");
+
+        migration_channel_connect_outgoing(ioc);
+        return true;
     }
 
     /*
-     * async: the above routines all wait for the incoming connection
-     * and call back to migration_channel_process_incoming() to start
-     * the migration.
+     * async: on the incoming side all of the transport routines above
+     * wait for the incoming connection and call back to
+     * migration_channel_process_incoming() to start the migration.
      */
+
+    return !*errp;
 }
 
 bool migration_has_main_and_multifd_channels(void)
diff --git a/migration/channel.h b/migration/channel.h
index 8cf16bfda9..86934fee38 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -39,6 +39,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
 bool migration_has_main_and_multifd_channels(void);
 bool migration_has_all_channels(void);
 
-bool migration_connect_outgoing(MigrationAddress *addr, Error **errp);
-void migration_connect_incoming(MigrationAddress *addr, Error **errp);
+bool migration_connect(MigrationAddress *addr, bool out, Error **errp);
+static inline bool migration_connect_outgoing(MigrationAddress *addr,
+                                              Error **errp)
+{
+    return migration_connect(addr, true, errp);
+}
+
+static inline bool migration_connect_incoming(MigrationAddress *addr,
+                                              Error **errp)
+{
+    return migration_connect(addr, false, errp);
+}
 #endif
-- 
2.51.0


