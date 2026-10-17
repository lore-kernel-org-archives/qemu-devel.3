Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B44CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9eT-000715-P8; Sat, 17 Oct 2026 15:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dW-0005g7-OL; Sat, 17 Oct 2026 15:00:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dT-00041v-K9; Sat, 17 Oct 2026 15:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263416; bh=xUDaSs0dFvWdsRtn6qWHsTNkADKNx8vi3MO318Oj/x4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O/ySc/V5QftO2AMjNc38G2FQZhnINTtSJ3kRxMu6rV3dFjRK3XS/mIupd+UmTUogr
 84ckjgk49iO8qYQjwBSw+qQRYDV3aB/pkVjCvFdRIIH1FjpPJtgzP/YLa7Rdkhp48e
 ju+JogoeVxhkSAjjCj2AK/g+MkWzRttGNT8sC80E8dE6Ggk3JynAfWf/SOZSbh+zJU
 q8RJJCdJJ6JseUvAYzar5EvmHIWEgCGhglgHmdDuJ4oCGjSwn5W9/4cjSxPo5NcdOF
 7n4/JnXoJZ+S8tRf2BNQBVr8uhclUl2iMUgy0TePJhBczoVH0X82N6umbAZO/it0YG
 dXY3BmyU4sSqg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 309941DE6D2;
 Sat, 17 Oct 2026 21:56:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5A64F44339A;
 Sat, 17 Oct 2026 21:56:55 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 47/63] hw/display/vga: fix OOB writes after external
 surface resize
Date: Sat, 17 Oct 2026 21:55:03 +0300
Message-ID: <20261017185528.722197-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

virtio-vga has two renderers (VGA core and virtio-gpu) sharing a single
QemuConsole, with no invalidation protocol between them. When virtio-gpu
replaces the surface (SET_SCANOUT) or destroys it (reset via
qemu_console_set_surface(con, NULL)), the VGA renderer's cached geometry
(last_scr_width, last_height, last_depth, etc.) is never cleared:
vga_common_reset() does not run during a virtio-gpu reset.

The text draw path was fixed by 418396be80 (CVE-2026-77913), but
vga_draw_blank() and vga_draw_graphic() still trust stale cache against
a foreign surface:

vga_draw_blank() uses last_scr_width/height to memset the display
surface. When the surface has been replaced by a smaller one (e.g.
after a text-to-graphics mode switch, or a virtio-gpu reset installing
a 16x16 placeholder), the memset writes past the surface buffer. Use
the actual surface dimensions for the memset bounds instead of the
cached last_scr values.

vga_draw_graphic() decides whether to recreate the DisplaySurface based
solely on VGA register state (line_offset, width, height, depth,
byteswap, allocated). When virtio-gpu replaces the surface with a
smaller one, the predicate sees no change and the drawing loop writes a
full VGA-geometry frame into the undersized surface. Add surface
dimension checks to the predicate so that a foreign surface whose size
does not match the VGA geometry triggers a resize before drawing.

Ideally the two renderers could coordinate through a console-level
invalidation callback, but these defensive checks are needed regardless
as a safety net against any path that replaces the surface.

Fixes: CVE-2026-97889
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4579
Reported-by: david korczynski (@david1766)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261001104112.2167807-2-marcandre.lureau@redhat.com>
(cherry picked from commit 35164929cfa33b9f5001de72c0f3e37e9a4612c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 405ea89ed4..41ca1aa897 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1623,7 +1623,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         height != s->last_height ||
         s->last_depth != depth ||
         s->last_byteswap != byteswap ||
-        allocate_surface != surface_is_allocated(surface)) {
+        allocate_surface != surface_is_allocated(surface) ||
+        disp_width != surface_width(surface) ||
+        height != surface_height(surface)) {
         /* display parameters changed -> need new display surface */
         s->last_scr_width = disp_width;
         s->last_scr_height = height;
@@ -1773,9 +1775,9 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
         dpy_gfx_replace_surface(s->con, surface);
     }
 
-    w = s->last_scr_width * surface_bytes_per_pixel(surface);
+    w = surface_width(surface) * surface_bytes_per_pixel(surface);
     d = surface_data(surface);
-    for(i = 0; i < s->last_scr_height; i++) {
+    for (i = 0; i < surface_height(surface); i++) {
         memset(d, 0, w);
         d += surface_stride(surface);
     }
-- 
2.47.3


