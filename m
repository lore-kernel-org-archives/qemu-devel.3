Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17B1CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEE8-00032e-P6; Thu, 01 Oct 2026 06:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEE5-00032N-L4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEE3-0001Wl-Vg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790851278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4yOJXHxvJWFb03okiF3FBz8IA/gBOQnGxB73IwO3j34=;
 b=BhwDfiGotHg+4XdLQprIg68d+QpNeq0kCSR28wGm5NvVexh9cXfeEslKssgtfMS+hEPzro
 DmlDCO9mL/fDWyAsqcAp4xZNH9pf5vlVvNB+ZSpQnU+Rj+iz2I9krRx+hadxNI721+2n+k
 tnAKF6M/O2C5XZvit7xZd8sWKCkZQ8U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-W8fVmTuVNG277FP7e62qiw-1; Thu,
 01 Oct 2026 06:41:17 -0400
X-MC-Unique: W8fVmTuVNG277FP7e62qiw-1
X-Mimecast-MFC-AGG-ID: W8fVmTuVNG277FP7e62qiw_1790851276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68A3818052CC
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 10:41:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EBDB1956089; Thu,  1 Oct 2026 10:41:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/display/vga: fix OOB writes after external surface resize
Date: Thu,  1 Oct 2026 14:41:13 +0400
Message-ID: <20261001104112.2167807-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vga.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index cb0e28b79b6a..b9b8c529419d 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1641,7 +1641,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
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
@@ -1789,9 +1791,9 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
         qemu_console_set_surface(s->con, surface);
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
2.56.0.rc0.29.g47ce80527c56


