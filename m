Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5963CCE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWvD-0004fN-5E; Fri, 06 Sep 2024 07:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvC-0004bF-7I; Fri, 06 Sep 2024 07:14:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWvA-0007jd-JM; Fri, 06 Sep 2024 07:14:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 701DB8C47F;
 Fri,  6 Sep 2024 14:12:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7CCEF1336E9;
 Fri,  6 Sep 2024 14:13:25 +0300 (MSK)
Received: (nullmailer pid 353588 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, songziming <s.ziming@hotmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 15/69] chardev/char-win-stdio.c: restore old console
 mode
Date: Fri,  6 Sep 2024 14:12:24 +0300
Message-Id: <20240906111324.353230-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: songziming <s.ziming@hotmail.com>

If I use `-serial stdio` on Windows, after QEMU exits, the terminal
could not handle arrow keys and tab any more. Because stdio backend
on Windows sets console mode to virtual terminal input when starts,
but does not restore the old mode when finalize.

This small patch saves the old console mode and set it back.

Signed-off-by: Ziming Song <s.ziming@hotmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <ME3P282MB25488BE7C39BF0C35CD0DA5D8CA82@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
(cherry picked from commit 903cc9e1173e0778caa50871e8275c898770c690)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 1a18999e78..13325ca967 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -33,6 +33,7 @@
 struct WinStdioChardev {
     Chardev parent;
     HANDLE  hStdIn;
+    DWORD   dwOldMode;
     HANDLE  hInputReadyEvent;
     HANDLE  hInputDoneEvent;
     HANDLE  hInputThread;
@@ -159,6 +160,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
     }
 
     is_console = GetConsoleMode(stdio->hStdIn, &dwMode) != 0;
+    stdio->dwOldMode = dwMode;
 
     if (is_console) {
         if (qemu_add_wait_object(stdio->hStdIn,
@@ -221,6 +223,9 @@ static void char_win_stdio_finalize(Object *obj)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(obj);
 
+    if (stdio->hStdIn != INVALID_HANDLE_VALUE) {
+        SetConsoleMode(stdio->hStdIn, stdio->dwOldMode);
+    }
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
     }
-- 
2.39.2


