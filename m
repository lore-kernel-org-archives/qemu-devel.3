Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1BAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEe2-00023A-KR; Mon, 15 Jul 2024 01:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTEe0-0001sr-34; Mon, 15 Jul 2024 01:53:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTEdy-0007Dy-8f; Mon, 15 Jul 2024 01:53:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BAB917A3D0;
 Mon, 15 Jul 2024 08:52:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C3751108AB4;
 Mon, 15 Jul 2024 08:52:48 +0300 (MSK)
Received: (nullmailer pid 564529 invoked by uid 1000);
 Mon, 15 Jul 2024 05:52:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxim Mikityanskiy <maxtram95@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 19/19] char-stdio: Restore blocking mode of stdout on
 exit
Date: Mon, 15 Jul 2024 08:52:47 +0300
Message-Id: <20240715055248.564504-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240715074912@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240715074912@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Maxim Mikityanskiy <maxtram95@gmail.com>

qemu_chr_open_fd() sets stdout into non-blocking mode. Restore the old
fd flags on exit to avoid breaking unsuspecting applications that run on
the same terminal after qemu and don't expect to get EAGAIN.

While at at, also ensure term_exit is called once (at the moment it's
called both from char_stdio_finalize() and as the atexit() hook.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2423
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://lore.kernel.org/r/20240703190812.3459514-1-maxtram95@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a0124e333e2176640f233e5ea57a2f413985d9b5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 3c648678ab..b960ddd4e4 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -41,6 +41,7 @@
 /* init terminal so that we can grab keys */
 static struct termios oldtty;
 static int old_fd0_flags;
+static int old_fd1_flags;
 static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
@@ -50,6 +51,8 @@ static void term_exit(void)
     if (stdio_in_use) {
         tcsetattr(0, TCSANOW, &oldtty);
         fcntl(0, F_SETFL, old_fd0_flags);
+        fcntl(1, F_SETFL, old_fd1_flags);
+        stdio_in_use = false;
     }
 }
 
@@ -102,6 +105,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     stdio_in_use = true;
     old_fd0_flags = fcntl(0, F_GETFL);
+    old_fd1_flags = fcntl(1, F_GETFL);
     tcgetattr(0, &oldtty);
     if (!g_unix_set_fd_nonblocking(0, true, NULL)) {
         error_setg_errno(errp, errno, "Failed to set FD nonblocking");
-- 
2.39.2


