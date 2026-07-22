Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A07C4453F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPQ-0007E5-8N; Wed, 22 Jul 2026 08:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNs-0003zX-QU; Wed, 22 Jul 2026 08:49:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNp-0001tM-10; Wed, 22 Jul 2026 08:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=nQOQyxNmFpVz4tp6sj6mq8eedidmmUgBGMFfTtJ1nT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TVTXAffraNDN9xuaCEvUA9tMUWRheGGsBCE+ULY6dHfLi5J5S5VtA76vhA+0qw8/Q
 iZwf6gMJZPV7lIvMHz8wkkYu1L1z/xGsEw3UnIbbwKPtKtoLzK4F7xz2JGz5spB6R3
 qqzfluq13gCmCf2xXOLpV7mrlr/nSZ7+mIGOwrQ74qjApc56MTKTC17GU9o8g4+LqX
 UqLK+vOl6e9T0MTqKIhILPgXSgojm/RXxYPCNW24CnYpXhuy14tJJHj3weyscC9Oaf
 ekcdjEhCq/mwbky5pNNwHqP9UcizxD/vt3SbNjyprWt5ih4jRyUWjdGhcmtc775SZt
 BGQTsZabhaNfw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C38D81C3B10;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 176BE3F376A;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 786F917F09; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 103/122] ui/vnc: fix out-of-bounds write in lossy
 refresh dirty marking
Date: Wed, 22 Jul 2026 15:45:52 +0300
Message-ID: <20260722124622.31034-28-mjt@tls.msk.ru>
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
index 397773f1e52..b42e0973101 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2989,18 +2989,18 @@ void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)
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
@@ -3071,7 +3071,7 @@ static int vnc_update_stats(VncDisplay *vd,  struct timeval * tv)
 
             if (timercmp(&res, &VNC_REFRESH_LOSSY, >)) {
                 rect->freq = 0;
-                has_dirty += vnc_refresh_lossy_rect(vd, x, y);
+                has_dirty += vnc_refresh_lossy_rect(vd, x, y, height);
                 memset(rect->times, 0, sizeof (rect->times));
                 continue ;
             }
-- 
2.47.3


