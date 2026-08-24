Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D31C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOqd-0004fd-FC; Mon, 24 Aug 2026 03:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1wyOqb-0004fJ-RZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:11:57 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1wyOqa-0004YB-1e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:11:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1CBB3E29;
 Mon, 24 Aug 2026 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1787555509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jJ8qGw+agFErzPYv0YCncP3NT4a3nGW2CIWK9s/ZZZA=;
 b=rL+EL+MWW0IqpTQeWdQ4ZNoRkHYomq2i8Oftw0qi9rbBMWIhxtNVbAzEq74pc1b6zhWmuj
 PA4sTcxre9+SMbN2Thb0abFaGijHyDlL9GUcoVb8PxY9QUj8b9CrgFuCTz9IXoabZdgE/K
 vlk+xG5S2dFyDXHWwcjnDZylHh92Gp0=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=boEpiZM1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1787555504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jJ8qGw+agFErzPYv0YCncP3NT4a3nGW2CIWK9s/ZZZA=;
 b=boEpiZM1/G7aZB5zrtrOnw9MYhMQ0hdQTmvI9rBARKvkdggVzCPo3HCtWWrp4OnI0R9kYu
 UBCDeyQ+qvFuihIErnJL0jUhpFhTIcQ7Hm6MCfSNRuVm8KLGlQdBfJYfQFWcSTWJVJSQk3
 310i8sSE8p0vDQRdtsIMLnrhkHsgWWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 586D313332;
 Mon, 24 Aug 2026 07:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vJsjErDui2poXQAAD6G6ig
 (envelope-from <dfaggioli@suse.com>); Mon, 24 Aug 2026 07:11:44 +0000
From: Dario Faggioli <dfaggioli@suse.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com, philmd@mailo.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Dario Faggioli <dfaggioli@suse.com>
Subject: [RFC PATCH 0/1] hw/display/xenfb: always register vfb and allocate
 console early
Date: Mon, 24 Aug 2026 09:11:15 +0200
Message-ID: <20260824071116.935828-1-dfaggioli@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:mid,suse.com:dkim];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[lists.xenproject.org,kernel.org,xenproject.org,gmail.com,mailo.com,rsg.ci.i.u-tokyo.ac.jp,suse.com];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: D1CBB3E29
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=dfaggioli@suse.com; helo=smtp-out2.suse.de
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

Hello,

We've been having an issue with Xen PV and PVH guests' console since:

https://bugzilla.suse.com/show_bug.cgi?id=1232712
https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg02294.html

Back then, until our QEMU 11.0 package, I "solved" it locally by reverting
these two commits:

6ece1df966 hw/xen: Register framebuffer backend via xen_backend_init()
e99441a379 ui/curses: Do not use console_select()

For the 11.1 package, I decided it was enough and finally managed to find
the time to investigate a bit more (and, yes, I know I should have done
this earlier, but never could... Sorry :-( ).

From my debugging, these are the problems:

1. Commit 6ece1df966 restricted the vfb backend registration under an
   'if (vga_interface_type == VGA_XENFB)'. However, it can happen that the
   -vga parameter is just not provided (e.g., for PV and PVH guests) and the
   backend is never initialized.

2. Once the backend is registered, xenfb defers the QemuConsole creation to
   fb_initialise(). The VNC server, though, starts earlier, finds no active
   consoles, and binds to the dummy surface (black screen showing the message
   "This VM has no graphic display device"). Furthermore, since the removal
   of console_select(), such surface is never dropped for switching to the
   actual xenfb console.

I have drafted a patch to address both issues. It removes the
vga_interface_type check and moves qemu_graphic_console_create() to fb_init()
so the console is created "early enough".

I am sending this as an RFC because, although it fixes the problem in my
testing, I am no expert in the QEMU UI subsystem and I am not sure that these
are the correct and/or the best solutions.

I'm happy to try to come up and/or to test different approaches and/or patches.

Thanks and Regards,
Dario

Dario Faggioli (1):
  hw/display/xenfb: always register vfb and allocate console early

 hw/display/xenfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.55.0


