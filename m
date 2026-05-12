Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB3DCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuUd-000896-Be; Tue, 12 May 2026 17:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUT-0006yu-Jr; Tue, 12 May 2026 17:18:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuUR-000787-Sn; Tue, 12 May 2026 17:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=SzhnecTGMLKADIL0bXg2IKkkugTTFzlX9B/O24H7RrY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GbpXpI0Ib48DIIR+denf+iJVNWvScuNF6b88B7xeZe2wk2rT/291fz1a6n5prPW0j
 X0NRsYVCWyppybPDUQyiWCnYzpD1Ygwnbtr4V52vdkXwD8hweJ/kUbzlVDCFSeyUUh
 7NkOVS9joY6Wb+unM1DNfVwBhHbRg/3XxWSMabn8rxXUAVjB49uREt44N8FYbDVmhJ
 EO9F1ra5mk2MMl6Aqr7E8r1JcZrqkioCmhYFNWkjVEhQZWa+AeQa3kZwiWOs2vt8Fw
 AqyeVdaIlVJ+ifqbtyTXPEzDaTpjdGl8Fh7ybgN3CC0j7xVpwiLflr2dKY9YYTiNL6
 VrEEOeAx8GlOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 031C81AA3CE;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 054783ABD26;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 03/58] ui/console-vc: fix off-by-one in CSI J 2 (clear
 entire screen)
Date: Tue, 12 May 2026 23:57:24 +0300
Message-ID: <20260512205820.361821-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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

The loop condition used `y <= s->height` instead of `y < s->height`,
causing vc_clear_xy() to be called with y == s->height. This clears
a row in the scrollback buffer beyond the visible screen.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 181fdf8a7e13c0460a26777ff9301e0ecdca3784)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/console-vc.c b/ui/console-vc.c
index f22806fed7..8dee1f9bd0 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -899,7 +899,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 2:
                     /* clear entire screen */
-                    for (y = 0; y <= s->height; y++) {
+                    for (y = 0; y < s->height; y++) {
                         for (x = 0; x < s->width; x++) {
                             vc_clear_xy(vc, x, y);
                         }
-- 
2.47.3


