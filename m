Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB8CCF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkn1-0001xI-HO; Fri, 04 Oct 2024 12:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmU-0001oE-71; Fri, 04 Oct 2024 12:03:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkmS-0001WK-Go; Fri, 04 Oct 2024 12:03:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE2D895568;
 Fri,  4 Oct 2024 19:03:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3304E14D976;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282511 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 03/23] vnc: fix crash when no console attached
Date: Fri,  4 Oct 2024 19:03:11 +0300
Message-Id: <20241004160331.1282441-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index b59af625dd..93a8dbd253 100644
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
2.39.5


