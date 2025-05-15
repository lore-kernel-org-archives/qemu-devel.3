Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B1AC54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 22:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFgwS-0006cS-Cl; Thu, 15 May 2025 18:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwQ-0006c6-TA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:38 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwP-0000ZR-0N
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D36B2218E2;
 Thu, 15 May 2025 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIo+ntTCrjCNM2uWShUmgqItoiCZwXsjCUhwgX50soo=;
 b=XTe9eMwfbHXh4jcto5yqmLpJMo4qislZrNrMMD2zQ2d9U+XKtvkivobyJ/QbNrzEkzm2rW
 I5DTsWo8MN7t/cf2qAn5kWoTEjioWMNpemzKvPc/aYLc4yoUUazYn8dj9/0+U4QAdSujUe
 kBYENgH/K7yZ6qZAUNggbZbfvPOmrlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIo+ntTCrjCNM2uWShUmgqItoiCZwXsjCUhwgX50soo=;
 b=DXKS/hVZFeSrstqaUAlX3enDYs3KmfY7DThafX/l3OydnraVl6FBJjvwNNihpa2nYlePL1
 aXUCZpBYctnlxRAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p1RxOvLd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ax8iAdMR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIo+ntTCrjCNM2uWShUmgqItoiCZwXsjCUhwgX50soo=;
 b=p1RxOvLdSIYCzBVsHjr/bVTPDVBGGcXGI3ZdY9tTTsMLzBPDHof0HhEuiFiuaUUTjubyYg
 aQ57HqSXI3JzU1A8lIKsh+R0ZFEqeR/X6zYOXnwHZhrNPUcK3qumuzo0nwuzJV2Sy8gfka
 rw0pcCuaxGZVkuwafEUIHiR9Jxq47Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIo+ntTCrjCNM2uWShUmgqItoiCZwXsjCUhwgX50soo=;
 b=ax8iAdMRm+0+FtzqUm2M5KEOHyDTjd2tU+nzMU2BcWVrYZSIBfwJgBBGlVb/bkMWUT6mMP
 2cAZMJW0COSigPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9DC137E8;
 Thu, 15 May 2025 22:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CK3xOqdoJmhUNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 May 2025 22:20:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH 3/4] chardev: Consolidate yank registration
Date: Thu, 15 May 2025 19:20:13 -0300
Message-Id: <20250515222014.4161-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250515222014.4161-1-farosas@suse.de>
References: <20250515222014.4161-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D36B2218E2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
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

There's currently five places where the yank function is being
registered and they all come right before tcp_chr_new_client(). Fold
them into it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 chardev/char-socket.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 8ae225d953..d16608f1ed 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -904,6 +904,12 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
     s->sioc = sioc;
     object_ref(OBJECT(sioc));
 
+    if (s->registered_yank) {
+        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
+                               char_socket_yank_iochannel,
+                               QIO_CHANNEL(sioc));
+    }
+
     qio_channel_set_blocking(s->ioc, false, NULL);
 
     if (s->do_nodelay) {
@@ -944,11 +950,6 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
     }
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, sioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     ret = tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return ret;
@@ -963,11 +964,6 @@ static void tcp_chr_accept(QIONetListener *listener,
 
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     tcp_chr_set_client_ioc_name(chr, cioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(cioc));
-    }
     tcp_chr_new_client(chr, cioc);
 }
 
@@ -983,11 +979,6 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
         object_unref(OBJECT(sioc));
         return -1;
     }
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return 0;
@@ -1003,11 +994,6 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc = qio_net_listener_wait_client(s->listener);
     tcp_chr_set_client_ioc_name(chr, sioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
 }
@@ -1181,11 +1167,6 @@ static void tcp_chr_connect_client_async(Chardev *chr)
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_CONNECTING);
     sioc = qio_channel_socket_new();
     tcp_chr_set_client_ioc_name(chr, sioc);
-    if (s->registered_yank) {
-        yank_register_function(CHARDEV_YANK_INSTANCE(chr->label),
-                               char_socket_yank_iochannel,
-                               QIO_CHANNEL(sioc));
-    }
     /*
      * Normally code would use the qio_channel_socket_connect_async
      * method which uses a QIOTask + qio_task_set_error internally
-- 
2.35.3


