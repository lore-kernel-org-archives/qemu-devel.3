Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76ACC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 22:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFgwa-0006e5-VD; Thu, 15 May 2025 18:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwZ-0006dn-Rq
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:48 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwV-0000Zv-4p
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10927218F6;
 Thu, 15 May 2025 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+FtgAybI9Vd1EfTpc5OhWxRtKJ7xl2YTXon2FoOVu4=;
 b=YlsjgzkzAgpUHdSo8CrYPeMqOcLhnCz4W2ffSRbRg+QkkqsqYxUJYCbD3n7ZmU/se+vdec
 2tVaFBDBII82t7tfDmjG0E/X6WOJGWFAeeSodnqLHSfv3qODdm8nUs+vzzETL6wP4zJTSP
 cW1sdKLR5qZCXZYmwt6TgUiHYGaHXhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+FtgAybI9Vd1EfTpc5OhWxRtKJ7xl2YTXon2FoOVu4=;
 b=k+dX7vl6dFFJKrNlI5KmAMEtzIu+G2OKGJZUSQTiiRKYMny0Kr+FgAoEo+o8T2PuSPsSN7
 2l59f0RCsK6PLKDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ylsjgzkz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k+dX7vl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+FtgAybI9Vd1EfTpc5OhWxRtKJ7xl2YTXon2FoOVu4=;
 b=YlsjgzkzAgpUHdSo8CrYPeMqOcLhnCz4W2ffSRbRg+QkkqsqYxUJYCbD3n7ZmU/se+vdec
 2tVaFBDBII82t7tfDmjG0E/X6WOJGWFAeeSodnqLHSfv3qODdm8nUs+vzzETL6wP4zJTSP
 cW1sdKLR5qZCXZYmwt6TgUiHYGaHXhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+FtgAybI9Vd1EfTpc5OhWxRtKJ7xl2YTXon2FoOVu4=;
 b=k+dX7vl6dFFJKrNlI5KmAMEtzIu+G2OKGJZUSQTiiRKYMny0Kr+FgAoEo+o8T2PuSPsSN7
 2l59f0RCsK6PLKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6618C137E8;
 Thu, 15 May 2025 22:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sNItCapoJmhUNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 May 2025 22:20:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH 4/4] chardev: Introduce a lock for hup_source
Date: Thu, 15 May 2025 19:20:14 -0300
Message-Id: <20250515222014.4161-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250515222014.4161-1-farosas@suse.de>
References: <20250515222014.4161-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 10927218F6
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
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

It's possible for the hup_source to have its reference decremented by
remove_hup_source() while it's still being added to the context,
leading to asserts in glib:

g_source_set_callback_indirect: assertion 'g_atomic_int_get
(&source->ref_count) > 0'

g_source_attach: assertion 'g_atomic_int_get (&source->ref_count) > 0'
failed

Add a lock to serialize removal and creation.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 chardev/char-socket.c  | 4 ++++
 chardev/char.c         | 2 ++
 include/chardev/char.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index d16608f1ed..88db9acd0d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -374,7 +374,9 @@ static void tcp_chr_free_connection(Chardev *chr)
         s->read_msgfds_num = 0;
     }
 
+    qemu_mutex_lock(&chr->hup_source_lock);
     remove_hup_source(s);
+    qemu_mutex_unlock(&chr->hup_source_lock);
 
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
@@ -613,6 +615,7 @@ static void update_ioc_handlers(SocketChardev *s)
                                      tcp_chr_read, chr,
                                      chr->gcontext);
 
+    qemu_mutex_lock(&chr->hup_source_lock);
     remove_hup_source(s);
     s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
     /*
@@ -634,6 +637,7 @@ static void update_ioc_handlers(SocketChardev *s)
     g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
                           chr, NULL);
     g_source_attach(s->hup_source, chr->gcontext);
+    qemu_mutex_unlock(&chr->hup_source_lock);
 }
 
 static void tcp_chr_connect(void *opaque)
diff --git a/chardev/char.c b/chardev/char.c
index bbebd246c3..d03f698b38 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -279,6 +279,7 @@ static void char_init(Object *obj)
     chr->handover_yank_instance = false;
     chr->logfd = -1;
     qemu_mutex_init(&chr->chr_write_lock);
+    qemu_mutex_init(&chr->hup_source_lock);
 
     /*
      * Assume if chr_update_read_handler is implemented it will
@@ -316,6 +317,7 @@ static void char_finalize(Object *obj)
         close(chr->logfd);
     }
     qemu_mutex_destroy(&chr->chr_write_lock);
+    qemu_mutex_destroy(&chr->hup_source_lock);
 }
 
 static const TypeInfo char_type_info = {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 429852f8d9..064184153d 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -60,6 +60,7 @@ struct Chardev {
     Object parent_obj;
 
     QemuMutex chr_write_lock;
+    QemuMutex hup_source_lock;
     CharBackend *be;
     char *label;
     char *filename;
-- 
2.35.3


