Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5E1C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWTs-0001Cl-13; Wed, 22 Jul 2026 08:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSL-0003t0-CS; Wed, 22 Jul 2026 08:53:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSD-0002du-1r; Wed, 22 Jul 2026 08:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=EcGB4+bEaZjNRvmzvdAqXj4RBmZ1uXlQPD11W64gW4s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iA+I+MHhZOd4Kijtto3gMP6YZF5iuLs+yD9zMZUWfq+F5scmAVWWsPHDos5NuZRJ3
 nN+LOa8WyNIa/akx+/cb2KdMPU8MiklRLWy058jk2PXlh4xzGAr3V/VDsiMm/njETx
 EyXdsO9KxH6iV+7sBfl5GMUPVKoeHW0AMOviaasOmW1qtWKuvrUsd653j7ab+9QU1H
 DJqXg6z1ycnCaIPOTH8QIBZr3hQuJYPeDyPGLUJXVCOFvjKmKbmU22++2H/CZA+new
 6wkBIy/2ORQgBmdUzhesMPokbYWWbqhFz/RvUnSabAlsLEburhedZJ+fyuq5i5RRZO
 7h0eRZ6ZN/5CQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 005151C3B45;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 48B773F3795;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C858817F5F; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 104/127] ui/vnc: fix OOB write in
 vnc_refresh_lossy_rect
Date: Wed, 22 Jul 2026 15:48:29 +0300
Message-ID: <20260722124859.32371-23-mjt@tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 1b5fc8117a7..1e6490f2730 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3014,10 +3014,18 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
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
         VncConnection *vc = container_of(vs, VncConnection, vs);
         int j;
@@ -3032,7 +3040,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
         }
 
         vc->worker.lossy_rect[sty][stx] = 0;
-        for (j = 0; j < VNC_STAT_RECT; ++j) {
+        for (j = 0; j < rows; ++j) {
             bitmap_set(vs->dirty[y + j],
                        x / VNC_DIRTY_PIXELS_PER_BIT,
                        VNC_STAT_RECT / VNC_DIRTY_PIXELS_PER_BIT);
-- 
2.47.3


