Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E926C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWUR-0002uE-HX; Wed, 22 Jul 2026 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSY-0004Ce-71; Wed, 22 Jul 2026 08:54:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSR-0002oT-MS; Wed, 22 Jul 2026 08:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=I2HFeA2xu/ok25spknF/B47PL0Y4GO/eKINQ/pS9J/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ICd6gXLLjHom1NoqiJx4TkkKjazgvL9ANIs3P89Yc/snbPh4W0r79116OX6nwFvFK
 Tj/yJeT3ozlD1qVH1pdtRb6g3s0uJTYtGubGX3ofmlUw+MkgQKH/SrcL4ritWWtP+U
 xUGoIpnMkxnF79rPHg0E+Vg2eYcGoKyN9r5CWOA6fGORh0pZDjzFLvuE7ZErxzzKsA
 Wjhoup1UNQyjVsgduTS5xr+7piE5Q5dgbv0BSY+FMtXMuMdcgwxuhu5DVauFamEsHH
 BVDcO8IPvQqIXmaw5hSQgZ77FC2Dtq+zm1ZJ/BewLlew2+6aa6pyDGbg1BStZIFkJ1
 eBS+Oxr3RHgVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A43C1C3B47;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 52A383F3797;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CD16017F63; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 106/127] ui/input-barrier: fix off-by-one in
 keycode bounds check
Date: Wed, 22 Jul 2026 15:48:31 +0300
Message-ID: <20260722124859.32371-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
index 0a2198ca500..d4b3079261a 100644
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


