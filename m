Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AEDCD98DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUQ3-0002AY-7h; Sat, 13 Jun 2026 15:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUP2-0000zu-VD; Sat, 13 Jun 2026 15:52:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUP1-0003eg-Cj; Sat, 13 Jun 2026 15:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380258; bh=P+ldOx6p71KK0pnrGMTU1XVvbDZ3R2F3PIPmQhI+G20=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K/Pkjj9ImJb9FEtW2hWYxnS1A5MeTu1bn6hdNKSaMXYnc8orVEj6aqdolFcQNAHKS
 L0JFNG6U+dYbryv/BGheJM/zFf/DRAheR06/uxOyJJR+T0cF1sE7BnnVPv+aFLxqPT
 ejwZLV2cc/krczwJSW9oHAEQU4I1uH4rEL3eIboLFf8V69zutLQr2GErrw6Q7WOOT8
 Jr46wyIm4CzmdU4zCc5HHDEQwnKoEg8Wh21RRKtRDyJYgma/XJcW/HG3CXrBSG0piY
 9I//hYXf+UuAlgooft1Tloxbjon1SUZuIL7ZfNpZ4YIEHFpoGk9tCVZC6vfqxHudIJ
 qFC+0oUQBfCzg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D28DA1B6E1E;
 Sat, 13 Jun 2026 22:50:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 37BAC3CE898;
 Sat, 13 Jun 2026 22:51:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 15/56] ui/vnc: fix OOB write in lossy rect worker code
Date: Sat, 13 Jun 2026 22:50:29 +0300
Message-ID: <20260613195116.1807273-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

From: Daniel P. Berrangé <berrange@redhat.com>

Incorrect calculation of the boundary condition when tracking lossy
rectangles in the worker thread will result in an OOB write which
can corrupt further worker state, and/or trigger any guard pages
that may lie beyond the VncWorker struct. This can be triggered
through careful choice of the display resolution in the guest
OS by an unprivileged user.

Fixes: CVE-2026-48002
Reported-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-4-berrange@redhat.com>
[Marc-André - added assert() suggest by philmd@linaro.org]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 46ee49034d26d04d95ba8f3183d4fbfa9d2b89b4)
(Mjt: context fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index ff683ba196..faff26454b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2968,13 +2968,15 @@ void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)
 {
     int i, j;
 
-    w = (x + w) / VNC_STAT_RECT;
-    h = (y + h) / VNC_STAT_RECT;
+    w = DIV_ROUND_UP((x + w), VNC_STAT_RECT);
+    h = DIV_ROUND_UP((y + h), VNC_STAT_RECT);
+    assert(h <= VNC_STAT_ROWS);
+    assert(w <= VNC_STAT_COLS);
     x /= VNC_STAT_RECT;
     y /= VNC_STAT_RECT;
 
-    for (j = y; j <= h; j++) {
-        for (i = x; i <= w; i++) {
+    for (j = y; j < h; j++) {
+        for (i = x; i < w; i++) {
             vs->lossy_rect[j][i] = 1;
         }
     }
-- 
2.47.3


