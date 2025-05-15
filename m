Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB562C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 22:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFgwS-0006cR-2R; Thu, 15 May 2025 18:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwQ-0006bu-6g
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwO-0000ZL-1l
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B046E1F7F5;
 Thu, 15 May 2025 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7V3pk0hf/BePuUnMB/AIoL4/3z/5fFir7975cFBizY=;
 b=XDVw8kS+YOmJScWqvzyUM28WwExr2MebBQjzsnWbDNCl6l+bbSY49m9e+DmuqnXkhOs6el
 b6s4BwwzHzy5TFPJZOYU4efu7Who5uHP6PD8xprDB1hhlT/JMD5RtJDtgmJ/6XTO3UDswg
 UrsoHJqEG0dCP34UR7Ss+hWa03+Rll0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7V3pk0hf/BePuUnMB/AIoL4/3z/5fFir7975cFBizY=;
 b=KM/P0LAR6n4wyiAzfL+MwcQB1BK0KpyxR29yamBx51JSxXQ/5roqpVgKiF0REbrfq6otUY
 9GEFxsLgJjU4jTAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7V3pk0hf/BePuUnMB/AIoL4/3z/5fFir7975cFBizY=;
 b=XDVw8kS+YOmJScWqvzyUM28WwExr2MebBQjzsnWbDNCl6l+bbSY49m9e+DmuqnXkhOs6el
 b6s4BwwzHzy5TFPJZOYU4efu7Who5uHP6PD8xprDB1hhlT/JMD5RtJDtgmJ/6XTO3UDswg
 UrsoHJqEG0dCP34UR7Ss+hWa03+Rll0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7V3pk0hf/BePuUnMB/AIoL4/3z/5fFir7975cFBizY=;
 b=KM/P0LAR6n4wyiAzfL+MwcQB1BK0KpyxR29yamBx51JSxXQ/5roqpVgKiF0REbrfq6otUY
 9GEFxsLgJjU4jTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D4BF137E8;
 Thu, 15 May 2025 22:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CocM6VoJmhUNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 May 2025 22:20:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH 2/4] chardev: Don't attempt to unregister yank function more
 than once
Date: Thu, 15 May 2025 19:20:12 -0300
Message-Id: <20250515222014.4161-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250515222014.4161-1-farosas@suse.de>
References: <20250515222014.4161-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

tcp_chr_free_connection() can be called multiple times in succession,
in which case the yank function will get as argument a NULL s->sioc
that has been cleared by the previous tcp_chr_free_connection() call.

This leads to an abort() at yank_unregister_function().

 #0  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
 #1  __GI_abort () at abort.c:79
 #2  qtest_check_status (s=0x513000005600) at ../tests/qtest/libqtest.c:209
 #3  qtest_wait_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:273
 #4  qtest_kill_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:285
 #5  kill_qemu_hook_func (s=0x513000005600) at ../tests/qtest/libqtest.c:294
 #6  g_hook_list_invoke (hook_list=0x55ea9cc750c0 <abrt_hooks>, may_recurse=0) at ../glib/ghook.c:534
 #7  sigabrt_handler (signo=6) at ../tests/qtest/libqtest.c:299
 #8  <signal handler called>
 #9  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
 #10 __GI_abort () at abort.c:79
 #11 yank_unregister_function (instance=0x7fb26f2ea9a0,
     func=0x55ea9bcc0a10 <char_socket_yank_iochannel>, opaque=0x0) at
     ../util/yank.c:151
 #12 tcp_chr_free_connection (chr=0x51300000ffc0) at ../chardev/char-socket.c:385
 #13 tcp_chr_disconnect_locked (chr=0x51300000ffc0) at ../chardev/char-socket.c:477
 #14 tcp_chr_disconnect (chr=0x51300000ffc0) at ../chardev/char-socket.c:495
 #15 tcp_chr_hup (channel=0x514000000040, cond=G_IO_HUP, opaque=0x51300000ffc0) at ../chardev/char-socket.c:536
 #16 qio_channel_fd_source_dispatch (source=0x50c0000b5fc0, callback=0x55ea9bcd6770 <tcp_chr_hup>,
     user_data=0x51300000ffc0) at ../io/channel-watch.c:84
 #17 g_main_dispatch (context=0x50f000000040) at ../glib/gmain.c:3381
 #18 g_main_context_dispatch (context=context@entry=0x50f000000040) at ../glib/gmain.c:4099
 #19 g_main_context_iterate (context=0x50f000000040, block=block@entry=1, dispatch=dispatch@entry=1,
     self=<optimized out>) at ../glib/gmain.c:4175
 #20 g_main_loop_run (loop=0x502000055690) at ../glib/gmain.c:4373

Commit ebae6477dc ("chardev: check if the chardev is registered for
yanking") seems to have encountered a similar issue, but checking
s->registered_yank is not a complete solution because that flag
pertains to the yank instance, not to each individual function.

Skip the yank_unregister_function() in case s->sioc is already NULL,
which indicates the last yank function was already removed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
Can tcp_chr_free_connection() race with itself? I'm assuming no.

Could we just make yank_unregister_instance() remove all yank
functions at once? Those asserts/abort in the yank code are a bit
masochistic.
---
 chardev/char-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e8dd2931dc..8ae225d953 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -378,7 +378,8 @@ static void tcp_chr_free_connection(Chardev *chr)
 
     tcp_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
-    if (s->registered_yank &&
+
+    if (s->registered_yank && s->sioc &&
         (s->state == TCP_CHARDEV_STATE_CONNECTING
         || s->state == TCP_CHARDEV_STATE_CONNECTED)) {
         yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
-- 
2.35.3


