Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65772CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHmc-00047Z-Me; Wed, 27 Aug 2025 11:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkQ-0008I6-3h; Wed, 27 Aug 2025 11:07:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkO-0005fs-0P; Wed, 27 Aug 2025 11:07:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B474914C558;
 Wed, 27 Aug 2025 18:02:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A138D26985F;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, William Hu <purplearmadillo77@proton.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 47/59] ui/curses: Fix infinite loop on windows
Date: Wed, 27 Aug 2025 18:02:52 +0300
Message-ID: <20250827150323.2694101-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: William Hu <purplearmadillo77@proton.me>

Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused by a
65535 == -1 comparison.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
Signed-off-by: William Hu <purplearmadillo77@proton.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[ Marc-André - Add missing similar code change, remove a comment ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
(cherry picked from commit c7ac771ee750e37808928b62388fd27dcbf00f46)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/curses.c b/ui/curses.c
index a39aee8762..161f78c35c 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -265,7 +265,8 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
 
 static void curses_refresh(DisplayChangeListener *dcl)
 {
-    int chr, keysym, keycode, keycode_alt;
+    wint_t chr = 0;
+    int keysym, keycode, keycode_alt;
     enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
 
     curses_winch_check();
@@ -284,8 +285,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
         /* while there are any pending key strokes to process */
         chr = console_getch(&maybe_keycode);
 
-        if (chr == -1)
+        if (chr == WEOF) {
             break;
+        }
 
 #ifdef KEY_RESIZE
         /* this shouldn't occur when we use a custom SIGWINCH handler */
@@ -304,9 +306,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
         /* alt or esc key */
         if (keycode == 1) {
             enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
-            int nextchr = console_getch(&next_maybe_keycode);
+            wint_t nextchr = console_getch(&next_maybe_keycode);
 
-            if (nextchr != -1) {
+            if (nextchr != WEOF) {
                 chr = nextchr;
                 maybe_keycode = next_maybe_keycode;
                 keycode_alt = ALT;
-- 
2.47.2


