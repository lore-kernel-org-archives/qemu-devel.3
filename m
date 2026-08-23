Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E448C5DF9C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyBFu-0005XY-Up; Sun, 23 Aug 2026 12:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyBFt-0005X9-6Q
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 12:41:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyBFq-0003H1-Me
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 12:41:08 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1939643a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787503264; x=1788108064; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q+WGVqvV27IodXI+eGY+twRXziciX/yYUNrdJZuWz+Q=;
 b=JrD2wGf+8ccr6DlearLCynAfiqkMQ60vMr1Z8YfucZZD9usKgfViuNbImSvf5BHNFK
 +MM28sHW1gi6GyAtNsP2PY5PfEjcSH5iEaDdHjQo1fqpnwWlXmUwlB0bXVWOSwJj/Mow
 NjDIB/a6GXacnBcGG2wtETSrHDv3F/lbIyFTA4wn0G5K2Meh87R4b7fWSDZlpE8GUzzD
 VASFAMtjEOAL2gSScPHqC3YDG5mV5S0f1uQRQe67YFjbpu4nEJ1tOZkFL7bSCLXRiliR
 1oIrEoKh7/PHkoXPRu2KkSFlVX1pVavKGxdhm1YnOH1hKzBfTy85Hs1LjRe8RNB993CB
 YN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787503264; x=1788108064;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q+WGVqvV27IodXI+eGY+twRXziciX/yYUNrdJZuWz+Q=;
 b=e0Cns1FZeUxnvDlEze5yF2nnwvPBGFA6NciaevdGtw7Pgd3DIz5TM95i7geu9eVz+T
 aaqKNnJJIHuPEx2K11M3iOcEUiJgszpwVWLQz/aFElYXM4YWLYzEnLKnWQUls8YLVZB0
 OQCAjGxQFaUaq7vY2ROsWF7NsOn7625ArcK8gqj4awK75BIcZbbU2g61Qzd/kbWACfNJ
 YCgzIbh67ZjauI4o4D7vcLQ6rXKLLY3tGYH7MDC8jJimdVpbOrxArWNLlP/EQBi36EkQ
 QwcWEIM1ysipSVKMCMDOAfUGq1Gd78o+EjEHIv/N5nObf68mGpR50kswq/GFuaroEtsx
 hvcA==
X-Gm-Message-State: AFuF++n6owsBvjdD3ZVCrVwEoWLgECMiCD5HwZo6GmYGWu7rl5gJBcbW
 t49lPnHELZjK6JbRsAlsxfTy+T6Q9ii/bZ/aiHLglolX7M24SU7GwoN9vdKlaQ==
X-Gm-Gg: AR+sD10hYtkXIQdWqxy7IHigD8AVoElmXgrwuwMgwe0mHtZzOVfu/Ke1puQDpM7tya+
 VeXpSutaHERbUOFQOGSd12iPfteJhEJ6poFd70jWRuZKyR/cf5MChzJ+Ale/HrJE9QzX2GbnMMi
 rWjl0bUTc2xoyhZWHb4g64CL1tNpBclIuWRL06yKcIavUu+btLqz3hIybARjS2Ak2cv8bi9RUkz
 OvnVL/9odanQEQjupI/XQY0G0IpQYnUsUJxLzBz3j60AmM2qexwSeFe66B1T8MhpAj3VUjISxhD
 p0YbY6MqOf1r+aFnDXQmHI/YYW8Ed34pnAYvQJQJ2d2c2dOLSgg3TBpaxTm0ULWEnEL7UB6Rux6
 BibzsZPIt0CO0MuskP/LA+VnK8p2oKgkvB9rvJU4j0ebODzU4ZVvkoGJTjWWyCorEYvj2iF76Tz
 BEOqbBSLZSSFHlyJNafSmx8eueLs/p9j1hnAkqNf+cAQvBgGy4xvlkmItl1A==
X-Received: by 2002:a17:90b:53c3:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-395c39cbc42mr37280881a91.11.1787503264400; 
 Sun, 23 Aug 2026 09:41:04 -0700 (PDT)
Received: from kali.sinner ([38.240.225.76]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e49b4060sm6540221a91.6.2026.08.23.09.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 09:41:03 -0700 (PDT)
From: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v2] hw/display/vga: fix text-mode OOB write after a graphics
 surface switch
Date: Sun, 23 Aug 2026 12:41:01 -0400
Message-ID: <vga-v2-20260823.sinxx198@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=sinxx198@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

vga_draw_text() decides whether the console surface needs a resize from
its geometry cache, but none of the cache terms observe the graphics
renderer having replaced the console surface in between:

- last_width/last_height are shared with vga_draw_graphic(), which
  stores them in pixels while the text path stores characters;
- last_depth stays 0 for legacy (non-VBE) graphics modes, because
  vga_get_bpp() only reports a depth when VBE is enabled, so the
  "s->last_depth" term that normally forces a resize after a graphics
  frame does not fire.

So a graphics frame that shrinks the console surface (e.g. 80x25
pixels) followed by a text frame with matching character geometry
(80x25 chars) skips the resize, and the glyph loop then paints
width*cw x height*cheight pixels into the smaller surface, out of
bounds, with guest-controlled (DAC palette) values, on every display
refresh.

Split the geometry cache per renderer so the units are unambiguous,
and additionally make the text path compare the pixel size it is
about to paint against the console surface's actual dimensions.
The surface check is the load-bearing term: caches in either unit
cannot see the other renderer swapping the surface, the surface can.

Fixes: CVE-2026-77913
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215
Cc: qemu-stable@nongnu.org
Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
---
Changes v1 -> v2:
- v1 (split caches only) did not fix the reported reproducer: after a
  legacy graphics frame (depth 0) the text predicate still compared
  equal, because nothing in it noticed the console surface had been
  replaced.  Keep the split for clarity, and add the surface-size
  check which actually catches it (verified with the qtest PoC and an
  ASAN build; without this patch ASAN reports a heap-buffer-overflow
  in vga_draw_glyph9(), with it the run is clean).
---
 hw/display/vga.c     | 13 ++++++++++---
 hw/display/vga_int.h |  3 ++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index da0c331486..7a349dc738 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1241,7 +1241,10 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         return;
     }
 
-    if (width != s->last_width || height != s->last_height ||
+    if (surface == NULL ||
+        surface_width(surface) != width * cw ||
+        surface_height(surface) != height * cheight ||
+        width != s->last_text_width || height != s->last_text_height ||
         cw != s->last_cw || cheight != s->last_ch || s->last_depth) {
         s->last_scr_width = width * cw;
         s->last_scr_height = height * cheight;
@@ -1249,8 +1252,8 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         surface = qemu_console_surface(s->con);
         qemu_console_text_resize(s->con, width, height);
         s->last_depth = 0;
-        s->last_width = width;
-        s->last_height = height;
+        s->last_text_width = width;
+        s->last_text_height = height;
         s->last_ch = cheight;
         s->last_cw = cw;
         full_update = 1;
@@ -1845,6 +1848,8 @@ static void vga_invalidate_display(void *opaque)
 
     s->last_width = -1;
     s->last_height = -1;
+    s->last_text_width = -1;
+    s->last_text_height = -1;
 }
 
 void vga_common_reset(VGACommonState *s)
@@ -1887,6 +1892,8 @@ void vga_common_reset(VGACommonState *s)
     s->last_ch = 0;
     s->last_width = 0;
     s->last_height = 0;
+    s->last_text_width = 0;
+    s->last_text_height = 0;
     s->last_scr_width = 0;
     s->last_scr_height = 0;
     s->cursor_start = 0;
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 5664317ecd..ca69ae9815 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -122,7 +122,8 @@ typedef struct VGACommonState {
     uint32_t plane_updated;
     uint32_t last_line_offset;
     uint8_t last_cw, last_ch;
-    uint32_t last_width, last_height; /* in chars or pixels */
+    uint32_t last_width, last_height; /* in pixels (graphics renderer) */
+    uint32_t last_text_width, last_text_height; /* in chars (text renderer) */
     uint32_t last_scr_width, last_scr_height; /* in pixels */
     uint32_t last_depth; /* in bits */
     bool last_byteswap;
-- 
2.47.3

