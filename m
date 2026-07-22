Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2E7C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPQ-0007Fj-Fr; Wed, 22 Jul 2026 08:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNN-0003YP-I2; Wed, 22 Jul 2026 08:48:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNK-0001sE-Ss; Wed, 22 Jul 2026 08:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=E9L0cdQ6TfwAlDLNImtKBGFf1nUC+N0uI1RSahQ/7Cc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P0ttyDkBTygmi5rz9fnkT6vjNKNciz6iXIUePbT4tuHy03EHM/OZ2xhdaEK/Bhwn1
 i3ACk8cxsnKiEIA7TqUzTGa2fNNyIgblOJFx+utCg289Q7DdiR9/i+auGM5A/iP0/G
 YXkhHiLcYmvRPZA/foJKsCQbbYA0Bb2k01duEUKvCB3OdUOuup6Yb2KaJo64dC8xc2
 ZnyBT5pG39jx/GhN8aMPoZjoLAIcA8W8WxEOONIv80X7ar547n8j5fEWDF4zMCC+rz
 gfVcWMF81U8ncLcoVt2akNDFosMOCgngABy8AOONCPmUvErsMwgfTD78jfMVf77u/F
 DBlkIN0+zk2VA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD4651C3B0C;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F40233F3766;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6EDE417F01; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 099/122] ui/vnc: fix OOB write in
 vnc_refresh_lossy_rect
Date: Wed, 22 Jul 2026 15:45:48 +0300
Message-ID: <20260722124622.31034-24-mjt@tls.msk.ru>
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

vnc_refresh_lossy_rect() always marks a full VNC_STAT_RECT (64) rows
as dirty when refreshing a lossy tile. When the display height is not
a multiple of VNC_STAT_RECT (e.g. VNC_MAX_HEIGHT = 2160), the bottom
tile is partial -- the last tile at y=2112 has only 48 valid rows.
The unclamped loop writes to vs->dirty[2160..2175], past the end of
the VNC_MAX_HEIGHT-sized array.

Clamp the row count to the actual surface height so partial bottom
tiles only mark valid dirty bitmap entries.

Fixes: CVE-2026-48002
Fixes: 7d964c9d2fc6 ("vnc: refresh lossy rect after a given timeout")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3950
Reported-by: huntr bubble
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 3543c2b855cc8cd25a5dbf05564a47ba42f45fad)
(Mjt: fixups for missing v10.0.0-2240-g37ff925d5d4
 "ui/vnc: Introduce the VncWorker type")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 3760afe564d..33432789905 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2988,10 +2988,18 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
     int sty = y / VNC_STAT_RECT;
     int stx = x / VNC_STAT_RECT;
     int has_dirty = 0;
+    int height = MIN(pixman_image_get_height(vd->guest.fb),
+                     pixman_image_get_height(vd->server));
+    int rows;
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
 
+    rows = MIN(VNC_STAT_RECT, height - y);
+    if (rows <= 0) {
+        return 0;
+    }
+
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         int j;
 
@@ -3005,7 +3013,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
         }
 
         vs->lossy_rect[sty][stx] = 0;
-        for (j = 0; j < VNC_STAT_RECT; ++j) {
+        for (j = 0; j < rows; ++j) {
             bitmap_set(vs->dirty[y + j],
                        x / VNC_DIRTY_PIXELS_PER_BIT,
                        VNC_STAT_RECT / VNC_DIRTY_PIXELS_PER_BIT);
-- 
2.47.3


