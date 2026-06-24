Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D37CDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNkY-0000JT-9q; Wed, 24 Jun 2026 09:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNkT-00005c-Eg; Wed, 24 Jun 2026 09:34:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNkR-0000XV-Sa; Wed, 24 Jun 2026 09:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307996; bh=lGk/OGkifKx4LKSM9herBoN6ehFZjTS6Al80zJPhBAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MSA/Uy49bccgyvkyyXCOakwLLo9MohGKCIFlzOkhfSzCXEZPNR+JyaHrvd4H8Ssie
 Cyw8NGzKpDTCtKSNSYorAMS9slngIm8LCw8DBQazNuTE8LwzInvrGPXHahmMh428m7
 ZxLLNmoxVeYlLujuVAXjodRMkrpxKImBo7QMwRjYV9k6OFz+4wgd0p/PFLVQ9RcyrI
 HG5qcyi+CMcZ7S+dSLWX0pVUtlWinr/J9HoP+JyQ/8bdWgLu+G089DDdUTFryNGZ3O
 yiKJASrD7jdHD8IO7737X4gbJPrNE9R5VRkybadyQXHU5pOG5CwBS4E+/YvngCQ330
 dW4NeO2vxCm1A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 733F01BA9C5;
 Wed, 24 Jun 2026 16:33:16 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0F4563DEA14;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 019/107] ui/vnc: fix OOB write in lossy rect worker
 code
Date: Wed, 24 Jun 2026 16:30:24 +0300
Message-ID: <20260624133301.403266-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index ccc73bd7aa..8ab44c830c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2994,13 +2994,15 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
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
             worker->lossy_rect[j][i] = 1;
         }
     }
-- 
2.47.3


