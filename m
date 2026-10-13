Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6EBCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcVg-0002wU-1g; Tue, 13 Oct 2026 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUa-0001vi-4w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUV-0004is-UD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfPhgP85RGR///jWOqOT2zn6Zbn2CBrtl573YZ8OF7Y=;
 b=i5xv4w3zNIjEvd+JWiEOwwwbOWMTPMfXmAk46PgMC9ly8+NdTUo+t/W8uMUy7N86M9ng3f
 Tf5AJDb7zqDwXHwa5DUGJUwUTwK1DmB1JqetIjemZ8nYtTQwkxeCSmkkS+Y2nFbDQ8zbWC
 tVnBCeRB6VhGYjqZef42nn6DIswkDkM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-5hQ6EU5gNBCzsYeCvkHyrA-1; Tue,
 13 Oct 2026 13:24:22 +0000
X-MC-Unique: 5hQ6EU5gNBCzsYeCvkHyrA-1
X-Mimecast-MFC-AGG-ID: 5hQ6EU5gNBCzsYeCvkHyrA_1791897862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00CB5195FE24; Tue, 13 Oct 2026 13:24:22 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF862180057E; Tue, 13 Oct 2026 13:24:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:13 +0400
Subject: [GIT PULL 16/40] hw/display/vga: fix OOB writes after external
 surface resize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-16-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3298;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qqaX/KgYh8lyKKC3Bbk6JfAfndZtnAOxwN+pPDnGN4o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDNwHzDLZixLHd16R4x1UZCqKdSmbXlAykf
 0kMF1q4j6WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5Y9XD/9K07lxJvXx7K2MyBEuxDwdrpOPyxPC6CRw+DGVf1F34/d4vv/gXR6zB9ltB5uOhSG65CO
 WDA3Y0FjF08xD8M0JYllJSQRjDl1XQJjaMLf5omu6ZAdGzk7hSMMdsDtHCfqN/YxbtOr48gQWUC
 jHN0SiWOzn/PH4Z+oJQEB5RDYmocfGUJrDp6RVHYd0NZGtj+g28/rx33duHEb2IGOCBiYoll5Np
 Rxl4I8XN+ab6W1FNku1BNkiez/C/hfogka2ul5cJDg+AmcGCTAbAxcoYjOOIO3Gq0z5gmRXlTf8
 /6jHHLlYZcvITJ4QbQBpVeW0wEBoG43Go/bm8inQbws+ox3FZzPXtG6Da2yznqYGrLKBw6ZMw/y
 YkhVcz142ZiApnZ4GoZOJ5aOI8qZCcj2u14V15uVP0o+6+zcW+wDlDt7OnC1dzgfRxxiw3zeyT3
 3Ut4mq4x2Jd4NT36dP+0KwFxkUgQFIvrn2mCjbZVxVyxG2D42zdGg8mrDbbcpiiJV1wSIZLOMy9
 C7pF4spbNeDDDKqA5u+RtR5RLnBDGOZc4Ff9Xpcq3ANV0WUSrDWAWt4/04EuGIjIoQUSsjAR1le
 290TGhKi2QBZTvu9qIQ69CJ5C8RsSvzs8DcERRbKA+qPmKDSS8aop5Y2BDRSHXgNj8ZaknLXK6A
 hucUQIju3FzKdEg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.56.0.116.g6de20f6092dc


