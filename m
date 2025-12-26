Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D42E8FDB8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFF3-0002kO-7f; Fri, 26 Dec 2025 16:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFF1-0002cw-Nw
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFF0-0004Jz-3z
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD3875BCCB;
 Fri, 26 Dec 2025 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75a4TyoA3rRR37hGhXR6deLXcglP7r0pSbFa+frOItI=;
 b=VOWiZMJRTJ/QQD4lTTUtLEKhDFQ+1w5Tv233R9wxldOhiE5Z/jk8f88ytchc2EUaLqHzjp
 xXnolaCYNRxhBBV43/ahUowmiOSTNdAt43IvzIRupbjoDA+EkAnqFTw93BXtwyB6VCWgN2
 r+88aj7TGmvfFbiqZ7U4tHjf9+v+tB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75a4TyoA3rRR37hGhXR6deLXcglP7r0pSbFa+frOItI=;
 b=TL2uwRy+6yBxNyBF88aiPF37aGage8FhTOjnDJgT5JqAuu2voEgHD3pAN3uRJcCZkG7T7P
 gelAMHkFUkTX/bDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VOWiZMJR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TL2uwRy+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766784007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75a4TyoA3rRR37hGhXR6deLXcglP7r0pSbFa+frOItI=;
 b=VOWiZMJRTJ/QQD4lTTUtLEKhDFQ+1w5Tv233R9wxldOhiE5Z/jk8f88ytchc2EUaLqHzjp
 xXnolaCYNRxhBBV43/ahUowmiOSTNdAt43IvzIRupbjoDA+EkAnqFTw93BXtwyB6VCWgN2
 r+88aj7TGmvfFbiqZ7U4tHjf9+v+tB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766784007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75a4TyoA3rRR37hGhXR6deLXcglP7r0pSbFa+frOItI=;
 b=TL2uwRy+6yBxNyBF88aiPF37aGage8FhTOjnDJgT5JqAuu2voEgHD3pAN3uRJcCZkG7T7P
 gelAMHkFUkTX/bDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1E953EA63;
 Fri, 26 Dec 2025 21:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFwOJAb8TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:20:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 20/25] migration/channel: Use switch statements in
 outgoing code
Date: Fri, 26 Dec 2025 18:19:22 -0300
Message-ID: <20251226211930.27565-21-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD3875BCCB
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
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Make this code easier on the eyes and remove all the visual
clutter. There will be more lines added here in next patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/channel.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 205f8a26d1..2f33cb2653 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -35,31 +35,49 @@ bool migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp)
 {
     g_autoptr(QIOChannel) ioc = NULL;
+    SocketAddress *saddr;
 
-    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &addr->u.socket;
-        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
-            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
-            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+    switch (addr->transport) {
+    case MIGRATION_ADDRESS_TYPE_SOCKET:
+        saddr = &addr->u.socket;
+
+        switch (saddr->type) {
+        case SOCKET_ADDRESS_TYPE_INET:
+        case SOCKET_ADDRESS_TYPE_UNIX:
+        case SOCKET_ADDRESS_TYPE_VSOCK:
             socket_connect_outgoing(s, saddr, errp);
             /*
              * async: after the socket is connected, calls
              * migration_channel_connect_outgoing() directly.
              */
             return true;
-        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            break;
+        case SOCKET_ADDRESS_TYPE_FD:
             ioc = fd_connect_outgoing(s, saddr->u.fd.str, errp);
+            break;
+        default:
+            g_assert_not_reached();
         }
+
+        break;
+
 #ifdef CONFIG_RDMA
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+    case MIGRATION_ADDRESS_TYPE_RDMA:
         ioc = rdma_connect_outgoing(s, &addr->u.rdma, errp);
+        break;
 #endif
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+
+    case MIGRATION_ADDRESS_TYPE_EXEC:
         ioc = exec_connect_outgoing(s, addr->u.exec.args, errp);
-    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
+        break;
+
+    case MIGRATION_ADDRESS_TYPE_FILE:
         ioc = file_connect_outgoing(s, &addr->u.file, errp);
-    } else {
+        break;
+
+    default:
         error_setg(errp, "uri is not a valid migration protocol");
+        break;
     }
 
     if (!ioc) {
-- 
2.51.0


