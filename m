Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04172C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOqf-0004gI-7d; Mon, 24 Aug 2026 03:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1wyOqc-0004fT-Iv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:11:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1wyOqZ-0004YL-SC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:11:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E5D3865B9;
 Mon, 24 Aug 2026 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1787555509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQQzKc7fXgnyMVrT3Qi+0O4dsqzanUM4EfhHa4x9i88=;
 b=GRStE1zEjdoaZF7EeV1Qc7jRkK7AFsxQA8zdFSVrPuizxFKRrAFOHMrsza/kFNsjB79xxE
 JWtob8YtgEk2/+f8py9pZJf21SN362D2Bn2CJ2V6sRbyF0OlfhUzhq+tOwyXACWVqPx9uR
 06HjGZgDUwehZ+NfSocrJmxgXwu/2PI=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=Rp8Zz61W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1787555505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQQzKc7fXgnyMVrT3Qi+0O4dsqzanUM4EfhHa4x9i88=;
 b=Rp8Zz61WHAlZSqPrBHhVp2p/cTyKMXbTTswW8U98VQ8PoqXtbEqdD2SPXx9rqtAGKRbO0F
 2t3vqe9Rrjo+QVmXF7QGBMVTSs4I5ZjQ2B4ECwskTSUdOX1qbCXwC1PtO565DKAo+RStmP
 xYPR1XbzwMgxVfg4/qLGwPTPBq2KlQM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBDF013335;
 Mon, 24 Aug 2026 07:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QDQDM7Dui2poXQAAD6G6ig
 (envelope-from <dfaggioli@suse.com>); Mon, 24 Aug 2026 07:11:44 +0000
From: Dario Faggioli <dfaggioli@suse.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com, philmd@mailo.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Dario Faggioli <dfaggioli@suse.com>
Subject: [RFC PATCH 1/1] hw/display/xenfb: always register vfb and allocate
 console early
Date: Mon, 24 Aug 2026 09:11:16 +0200
Message-ID: <20260824071116.935828-2-dfaggioli@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824071116.935828-1-dfaggioli@suse.com>
References: <20260824071116.935828-1-dfaggioli@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5E5D3865B9
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_SEVEN(0.00)[8];
 FREEMAIL_CC(0.00)[lists.xenproject.org,kernel.org,xenproject.org,gmail.com,mailo.com,rsg.ci.i.u-tokyo.ac.jp,suse.com];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=dfaggioli@suse.com;
 helo=smtp-out1.suse.de
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

This commit addresses a black console issues for Xen PV and PVH guests.

In fact, commit 6ece1df966 ("hw/xen: Register framebuffer backend via
xen_backend_init()") introduced a check before registering the vfb
backend. Problem is that the '-vga' agrument may not be present (e.g.,
for PV/PVH guests started with 'xl') and this causes the backend to be
silently ignored.

This commit restores the unconditional registration of the vfb backend.

Furthermore, even with the backend always being registered, the fact
that xenfb allocates the QemuConsole asynchronously in fb_initialise()
looks problematic. In fact, when the UI initializes, it finds 0 active
consoles and it permanently allocates a dummy surface showing the
message "This VM has no graphic display device". And since the removal
of console_select() there's no way to dynamically switch to the xenfb
console, when it is finally up and running.

This commit works around the issue by moving console creation to
fb_init(), so that VNC attaches to it immediately. The surface is then
updated normally via qemu_console_set_surface() once the guest framebuffer
is mapped.

Fixes: 6ece1df966 ("hw/xen: Register framebuffer backend via xen_backend_init()")
Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
---
 hw/display/xenfb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index ae302b217f..3a0cdc0578 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -851,9 +851,14 @@ static void xenfb_handle_events(struct XenFB *xenfb)
 
 static int fb_init(struct XenLegacyDevice *xendev)
 {
+    struct XenFB *fb = container_of(xendev, struct XenFB, c.xendev);
+
 #ifdef XENFB_TYPE_RESIZE
     xenstore_write_be_int(xendev, "feature-resize", 1);
 #endif
+
+    fb->con = qemu_graphic_console_create(NULL, 0, &xenfb_ops, fb);
+
     return 0;
 }
 
@@ -882,8 +887,6 @@ static int fb_initialise(struct XenLegacyDevice *xendev)
     if (rc != 0)
         return rc;
 
-    fb->con = qemu_graphic_console_create(NULL, 0, &xenfb_ops, fb);
-
     if (xenstore_read_fe_int(xendev, "feature-update", &fb->feature_update) == -1)
         fb->feature_update = 0;
     if (fb->feature_update)
@@ -973,9 +976,6 @@ static const GraphicHwOps xenfb_ops = {
 static void xen_ui_register_backend(void)
 {
     xen_be_register("vkbd", &xen_kbdmouse_ops);
-
-    if (vga_interface_type == VGA_XENFB) {
-        xen_be_register("vfb", &xen_framebuffer_ops);
-    }
+    xen_be_register("vfb", &xen_framebuffer_ops);
 }
 xen_backend_init(xen_ui_register_backend);
-- 
2.55.0


