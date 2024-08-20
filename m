Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9796EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 13:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgOe3-0007Rm-1H; Tue, 20 Aug 2024 09:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sgOe1-0007OS-2K
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 09:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sgOdy-0005eg-Ps
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 09:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724159484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/2wkUCHMj0/DcjKE45YY9tyb/3KmpGSqzxZpX55Ytmo=;
 b=DVtwu+TtEPOxEc7BaviV1mijsmLMXjf2wlqbtv+nlhNZRkctcpSU9FE0bP0gCDhCNkJtPb
 vwP0jrg3tdvs2ZLZE6tA68IsR6cm4Q5enfpFcSxpZLHA2KwivVUIvyygvImU7ou3NQBlCC
 UgQX10R8pefvv8F6+bqFGZclVfOYNTQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-9_8jm1OOPMaEKx83sKlczg-1; Tue,
 20 Aug 2024 09:11:20 -0400
X-MC-Unique: 9_8jm1OOPMaEKx83sKlczg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDD7C1955D54; Tue, 20 Aug 2024 13:11:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 797C01955F2D; Tue, 20 Aug 2024 13:11:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] vnc: fix crash when no console attached
Date: Tue, 20 Aug 2024 17:11:12 +0400
Message-ID: <20240820131112.1267954-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit e99441a3793b5 ("ui/curses: Do not use console_select()")
qemu_text_console_put_keysym() no longer checks for NULL console
argument, which leads to a later crash:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x00005555559ee186 in qemu_text_console_handle_keysym (s=0x0, keysym=31) at ../ui/console-vc.c:332
332	        } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
(gdb) bt
 #0  0x00005555559ee186 in qemu_text_console_handle_keysym (s=0x0, keysym=31) at ../ui/console-vc.c:332
 #1  0x00005555559e18e5 in qemu_text_console_put_keysym (s=<optimized out>, keysym=<optimized out>) at ../ui/console.c:303
 #2  0x00005555559f2e88 in do_key_event (vs=vs@entry=0x5555579045c0, down=down@entry=1, keycode=keycode@entry=60, sym=sym@entry=65471) at ../ui/vnc.c:2034
 #3  0x00005555559f845c in ext_key_event (vs=0x5555579045c0, down=1, sym=65471, keycode=<optimized out>) at ../ui/vnc.c:2070
 #4  protocol_client_msg (vs=0x5555579045c0, data=<optimized out>, len=<optimized out>) at ../ui/vnc.c:2514
 #5  0x00005555559f515c in vnc_client_read (vs=0x5555579045c0) at ../ui/vnc.c:1607

Fixes: e99441a3793b5 ("ui/curses: Do not use console_select()")
Fixes: https://issues.redhat.com/browse/RHEL-50529
Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index dae5d51210..5057ec8680 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1935,7 +1935,7 @@ static void do_key_event(VncState *vs, int down, int keycode, int sym)
     }
 
     qkbd_state_key_event(vs->vd->kbd, qcode, down);
-    if (!qemu_console_is_graphic(vs->vd->dcl.con)) {
+    if (QEMU_IS_TEXT_CONSOLE(vs->vd->dcl.con)) {
         QemuTextConsole *con = QEMU_TEXT_CONSOLE(vs->vd->dcl.con);
         bool numlock = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_NUMLOCK);
         bool control = qkbd_state_modifier_get(vs->vd->kbd, QKBD_MOD_CTRL);
-- 
2.45.2.827.g557ae147e6


