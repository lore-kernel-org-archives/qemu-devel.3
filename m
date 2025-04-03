Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96415C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 03:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0BeN-0000Ox-NP; Wed, 02 Apr 2025 23:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <purplearmadillo77@proton.me>)
 id 1u0947-0000pD-BK
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 21:08:20 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <purplearmadillo77@proton.me>)
 id 1u0943-0007hM-Fp
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 21:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1743642481; x=1743901681;
 bh=IuIxDV9ZU7dW/T6L0RPb9jN3ZKTUoLiK+7IPUZdw5nQ=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=ZF2s1+Z20pXQJts5nSu8B1lzn+3SdIAa9OPvFXWIH2aljAClqffMOmRCn0motMxnu
 VhaS+LRJ2cWAzgcj4J/Lo/xI5PfSsFfScyQhcvMGWUXt4umzdI3olq6jlvFUzlS+iD
 rnprVEkyGvgM/g5Z+3QSAXWROBu3bEXZeIdHYi3BXzoeR0eP0rqDOpWcpUMOx5CcTY
 IuWo+SahrNb6eZS0Ku3jbpQFaBiGUSwP8al3ZObvZGcxHdcEAiRbZ0vUNKij0xdExX
 qEjw0b7emIZUjnrZ51HRpIytaV+jyhPBwl6UNUFBv7flhcaV4SK9j9iInnAynj/dHC
 df+dNdrUNhF1g==
Date: Thu, 03 Apr 2025 01:07:56 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] ui/curses: Fix infinite loop on windows
Message-ID: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
Feedback-ID: 51238035:user:proton
X-Pm-Message-ID: 1a0ed4ef1e55ba72f73976a7ad9b638932a48003
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158;
 envelope-from=purplearmadillo77@proton.me; helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 02 Apr 2025 23:53:52 -0400
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
Reply-to:  William Hu <purplearmadillo77@proton.me>
From:  William Hu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From a42046272f0544dd18ed58661e53ea17d1584c2c Mon Sep 17 00:00:00 2001
From: William Hu <purplearmadillo77@proton.me>
Date: Wed, 2 Apr 2025 12:00:00 -0400
Subject: [PATCH] ui/curses: Fix infinite loop on windows

Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused by =
a
65535 =3D=3D -1 comparison.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
Signed-off-by: William Hu <purplearmadillo77@proton.me>
---
 ui/curses.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index a39aee8762..3f5c5adf78 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -265,7 +265,12 @@ static int curses2foo(const int _curses2foo[], const i=
nt _curseskey2foo[],
=20
 static void curses_refresh(DisplayChangeListener *dcl)
 {
-    int chr, keysym, keycode, keycode_alt;
+    /*
+     * DO NOT MAKE chr AN INT:
+     * Causes silent conversion errors on Windows where wint_t is unsigned=
 short.
+     */
+    wint_t chr =3D 0;
+    int keysym, keycode, keycode_alt;
     enum maybe_keycode maybe_keycode =3D CURSES_KEYCODE;
=20
     curses_winch_check();
@@ -284,8 +289,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
         /* while there are any pending key strokes to process */
         chr =3D console_getch(&maybe_keycode);
=20
-        if (chr =3D=3D -1)
+        if (chr =3D=3D WEOF) {
             break;
+        }
=20
 #ifdef KEY_RESIZE
         /* this shouldn't occur when we use a custom SIGWINCH handler */
--=20
2.47.0


