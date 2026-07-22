Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123CEC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWUc-0003ab-I4; Wed, 22 Jul 2026 08:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSd-0004OH-4X; Wed, 22 Jul 2026 08:54:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSa-0002sT-3w; Wed, 22 Jul 2026 08:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=N1rv3iLKf/VRKJAgEst6Ev5H996LvhOE0gApFPDo4P8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aw9tPawz4L1Rd46KPED5bodVcdrJk9U764YrdTG8XI5DoLoVa7OaETMXvNJjsavEf
 1Ift9a6l2db/AhDWPVqxyZ0laeOybW4MNu1zzs2EukkIOuA5xjqC2h3SJSPOf+2NmV
 fmjKlRS7A4ZisDK+KQVC2slZanMEhqws5O6GaBcjD29h05Axuwv2iLFSKY/LhjB/id
 8uTGZyTx7oyUHopfNoL5n3vXYAtIHEM0oJsPJPp498AMus2PuUg2kqPareao32nYZ2
 g0aPl49sBo6HcEproGkFWWIZrw2DHJGGxD6J9DUvXi8t48hcXSDYWi5U/0eHngoysC
 4gVNNJWyyR3gQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 159B61C3B49;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5DD653F3799;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D1DC817F67; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 108/127] ui/vnc: fix out-of-bounds write in lossy
 refresh dirty marking
Date: Wed, 22 Jul 2026 15:48:33 +0300
Message-ID: <20260722124859.32371-27-mjt@tls.msk.ru>
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

vnc_refresh_lossy_rect() marks a full VNC_STAT_RECT (64) rows of the
dirty bitmap when refreshing a lossy tile. When the display height is
not a multiple of VNC_STAT_RECT, the last tile row is a partial tile and
the loop writes past the end of vs->dirty[VNC_MAX_HEIGHT].

For example, with a 2160-pixel-high display (VNC_MAX_HEIGHT), the last
stat tile starts at y=2112. The unconditional 64-row loop writes rows
2112..2175, overflowing 16 rows (640 bytes) past the dirty bitmap into
subsequent VncState fields.

Fix by passing the effective display height into
vnc_refresh_lossy_rect() and clamping the inner loop.

Fixes: CVE-2026-61475
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3935
Reported-by: "Vulnerability Report" <vr@darknavy.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit e650e4fe0fb35b7a8ec9fc04e00346c02640bd58)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index d2ae127f0bf..16cd3eac2a6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3015,18 +3015,18 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
     }
 }
 
-static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
+static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
+                                  int height)
 {
     VncState *vs;
     int sty = y / VNC_STAT_RECT;
     int stx = x / VNC_STAT_RECT;
     int has_dirty = 0;
-    int height = MIN(pixman_image_get_height(vd->guest.fb),
-                     pixman_image_get_height(vd->server));
     int rows;
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
+    rows = MIN(VNC_STAT_RECT, height - y);
 
     rows = MIN(VNC_STAT_RECT, height - y);
     if (rows <= 0) {
@@ -3098,7 +3098,7 @@ static int vnc_update_stats(VncDisplay *vd,  struct timeval * tv)
 
             if (timercmp(&res, &VNC_REFRESH_LOSSY, >)) {
                 rect->freq = 0;
-                has_dirty += vnc_refresh_lossy_rect(vd, x, y);
+                has_dirty += vnc_refresh_lossy_rect(vd, x, y, height);
                 memset(rect->times, 0, sizeof (rect->times));
                 continue ;
             }
-- 
2.47.3


