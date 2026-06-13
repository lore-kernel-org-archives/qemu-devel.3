Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUdI-0002ot-1e; Sat, 13 Jun 2026 16:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUcI-0001YW-4w; Sat, 13 Jun 2026 16:06:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUcF-0000NJ-D6; Sat, 13 Jun 2026 16:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381068; bh=2DkJPZqgPQpVdCzNVIVk/r1VzeCc+R8NhjppcUCeL7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vc+KNOOQtivuS/I8URxqJq5d14R7/CnFYSJyokFF3OhpdcvFFXRH7oEQrX1LmAjOf
 Rmi5CQQ/JBuZPbL4y2cUK5PLj8t0HZxyXorV/Tn9KWD+QI+lDYzWYfyn+Zv+90nO25
 sU5jq2Wo75z2DtkABeIU9i8u28q7GVXgsdryTrxJNPF1jqNYZ+LpjXFReHWs1weklq
 bkQC8MWIqRI/BEeA+xxh6DhxEqDzR0/VTbnvaermvCfsRWSqtZLY5rKtKgTedMJ1PI
 JTUGxD11r2cL4ndj90NEaEFuV5hEBSIpyhy8FsEGkHd/w9LW517p0T1BsDPGNtaxBf
 1hVYES0SW0slw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1240C1B6E79;
 Sat, 13 Jun 2026 23:04:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 70CBC3CE8DC;
 Sat, 13 Jun 2026 23:04:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 18/61] ui/vnc: fix OOB write in lossy rect worker code
Date: Sat, 13 Jun 2026 23:03:01 +0300
Message-ID: <20260613200411.1808021-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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
index e6bcf0e1cf..b61d3d4b4e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3009,13 +3009,15 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
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


