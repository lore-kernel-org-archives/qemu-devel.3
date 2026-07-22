Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE7C4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPT-0007ho-VU; Wed, 22 Jul 2026 08:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNT-0003bS-3s; Wed, 22 Jul 2026 08:48:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNP-0001sq-2d; Wed, 22 Jul 2026 08:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=E43CQu5J+3NqLcWmX90uT/f3YTrvkTkpbFPw5yZiNlo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QSRRX8Jk+XxQcf9v7/E3+ygymYfGEXAnFCgkunjxrnaSC599kMbclYq0jFHVzaPzk
 JsymmeaihmIsXTA8A79C9RPODfTcEKHBjb0v6VcflogTZs7QNBWx0ozpWE4BLvBW0w
 7zrdUxl6iobXGMDiqNNL2yRk3TPO+GC2dT3Lh2adD1lR0yrld54U9etjIV0BgnRIye
 YpEpml7HZ3UJSAsmrlP0wtDZhgk4s10L7deSq2JAie8LtCItNbcEWSFsO5HyRdKu+P
 T+HGiokLmD/dmmUd6A8z3klDfeDb4OjYv3W/XBOg11BzwqSuTEsoN50pZ0FmHY1FwC
 bTCeUKnttAJ7A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B86F71C3B0E;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0BC343F3768;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 736A917F05; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 101/122] ui/input-barrier: fix off-by-one in
 keycode bounds check
Date: Wed, 22 Jul 2026 15:45:50 +0300
Message-ID: <20260722124622.31034-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use strict "<" to fix the off-by-one.

Fixes: 6105683da35b ("ui: add an embedded Barrier client")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
Reported-by: huntr bubble
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 82b4d693d522d406c950067caa4f14f45f4b679e)
(Mjt: fixup the change to before v11.0.0-365-gd276ad86eb8
 "ui: rename init_keyboard_layout->kbd_layout_new()")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 7acc48d7046..aad520e7f56 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -87,7 +87,7 @@ static kbd_layout_t *kbd_layout;
 static int input_barrier_to_qcode(uint16_t keyid, uint16_t keycode)
 {
     /* keycode is optional, if it is not provided use keyid */
-    if (keycode && keycode <= qemu_input_map_xorgkbd_to_qcode_len) {
+    if (keycode && keycode < qemu_input_map_xorgkbd_to_qcode_len) {
         return qemu_input_map_xorgkbd_to_qcode[keycode];
     }
 
-- 
2.47.3


