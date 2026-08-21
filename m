Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxUuF-0002rh-22; Fri, 21 Aug 2026 15:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wxUuC-0002r4-Rf
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 15:27:56 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wxUuB-0001Su-98
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 15:27:56 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b01cb18515so1296801e87.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 12:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787340473; cv=none;
 d=google.com; s=arc-20260327;
 b=AgqKdytGPVDT2U2WdxfcvSQQVUgMtEeqhO4I+uCNkA1FjCO1MSX+Q/SzCnuRF5XMGt
 rZqNSHS3u1PITwIH5tHw7Epz1Ob/vBPsox098zDfqOGiTjzplHC0FBen/j32LGtKJvlJ
 eqlofNcZB3xk2zdo9koGCbc5Zc8mXubaUBi2czzyac2WaLfyMijAKd9d4GQpx4gYDv6T
 PGKdW7g4TfV1r27gaO8uzq5hSP486gdJBxOo+vXv+oGeDWAtlv0zOF+Gq2IX6xFwPSGg
 Wji/EEJx0M+cudnglhsASmBKqmMW5ykH8sRvWCP/rLFsn3hQoWT/2JraaVVTBjZ9OUJU
 CHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=liQ6gIq2fCUABSET/op+7K1EonSFvrL3S6iQeWpjV6k=;
 fh=WS/FPZF4INf3fCqbT+W34SJMw0WsZ1wrdPlyicLyxsI=;
 b=fICK+mDmd9aV4JiZfEWBhaMMyGhclrtnimjQz0kNvq1vzXlp5CA+ZhZma3U5XLca/t
 QRbPuPLXT1vvzLzhybEfs7hOj6ZDuZI+gTnJ6W0/JNNCcpD98FPGLarMq9gBb63CGqZV
 PWjRA9PozHnM74tv0P6rKUmqh1fNy7GkRK/zYcDC6z5yTllq6yqPw4WXfeKkGppoZ53G
 tgqxZYc9TvVxeypIRSOrqofEoao1X0oJTwew2ZwXqC1WAJThDgl+qWl7dw61K+thTgtm
 7oJOyFoGF23aMtvLpVlVN4zGsZn26UxKng5mAk0niG5IoBgmBma0Xx7gigdc4rzeGPVq
 MjGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787340473; x=1787945273; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=liQ6gIq2fCUABSET/op+7K1EonSFvrL3S6iQeWpjV6k=;
 b=Fayjhf8sjFQlxKGyf6P79PED8PfDxawDFAEw3hAnaVWZVMUlBiTgE9zekfqCDnCUWz
 hkzix94hHedDA1eHazOCypTuiSVs189KLAYZj2UMyCqTA7FAZCTHxgKakOZwoQGRJIg0
 K/sEYHhH/vHuZT54IxlqFyEohbyOmTHuYGM4qwd1cLAMH6wpUJu9V9AtUlo62Yhjs7Xd
 fw3JNmw5QFLkwLkE6mz/7gjHgMq7XHXkDSv9bvKAJ+jDJAHGJXmmpPPldHgbPlnJVeAO
 6mpzPLW39rldPsrhB6eyTKGe8olsJ/XEM/Z076NSNtk5/sQmng4doklLrPtX9oM+rfrj
 Bm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340473; x=1787945273;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=liQ6gIq2fCUABSET/op+7K1EonSFvrL3S6iQeWpjV6k=;
 b=imPA8t7k/lpuqwpYf1IvIDqbjfyunPYbnD0W3x7nvd7m5y5HNuk7Yn8BfnNcXdnsxb
 CVxwLMrObX8vw5J6odWDyrAcOl7Qleyc8xoGuqytXu4IhuTWpSJQGv7axD5umtZlmJDl
 8MTAprPaobOK9mCMsRlwozYG4jwfh9OiXcb2Djvs8aAKJzylt0D54B9p87r9czUu0ket
 6LRMVb2JNQq/Ha+hFdkkNkPUI0zW6gy1nah8oaH2xh4DWnaHrR3xW7TB0Yj/gsxeZmP9
 dhm8DmPYKsmE0mzidzfq6rfqSEzjQvemqMFifvdKoZ2dxMhFwZZQC2dkLohhk8IL+Q+G
 mp4g==
X-Gm-Message-State: AFuF++mA4ALsMIdWHVGExXCJvYuH3FamYRdDV/PuJntpG0cCzfaUe055
 Pw0X/foeIUoMr905/dPbnTP9zU/ONN+dyCLbRgRKx+GnwLEFthoAMgEHgQmZtsb8IKuqdqbRBey
 9Qt1r+S2VG0MIbqiRrfJhsSMuq+oIs141+HW0KTc=
X-Gm-Gg: AR+sD13g7gYmi3/rAdhzODk7PuDrbrnfYY2LYFS0Xylb+aH2FQDZ0NHTpPpFBx39Mnu
 h+/0xc31El+8OPBy6PYUDoIE3PWBrPNfmr23eCBFi6HV4IuTWuID4oPEIbDfbpNcOW/YQ25gVno
 psZmDfPX0nSYNNNME1YyYAmz9kqXoRf5jlh97WEUkY2WJyUkZPVFRweGvQRMHXLW1pSBdfQYkvE
 H+h+7daTdL+69LjzgIk6qtiRAiAM1L12/LUIDvYZHm2MBw9JrGhTthd3WSJ5iQr7rYwT0q7GtLy
 e9dDO4aD7/mpGYocGD7OoxK8XfpnGFQtH7Ee68ZTKYBJVYGBVQItkDxzNL1zEtfvEHktfHPYXWN
 eZPY=
X-Received: by 2002:a05:6512:3f18:b0:5b4:3ddd:8996 with SMTP id
 2adb3069b0e04-5b48424ba76mr2889926e87.15.1787340473055; Fri, 21 Aug 2026
 12:27:53 -0700 (PDT)
MIME-Version: 1.0
From: sin99xx <sinxx198@gmail.com>
Date: Fri, 21 Aug 2026 15:27:41 -0400
X-Gm-Features: AcwNN1Xv-ugioZIxdE8Zpi6a0_r7PcloELDEwQtZ-3k0-J1PzKQNXDhr4Dsznxk
Message-ID: <CAMX0No1tDwFE=XCDDOrE_n33fF-KKD5gqucOLfu8EBGXk6vFXw@mail.gmail.com>
Subject: [PATCH] vga: split text renderer geometry cache from graphics renderer
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=sinxx198@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Resending with the correct [PATCH] subject prefix; please ignore
the previous copy.  Sorry for the noise.

vga_draw_text() and vga_draw_graphic() share last_width/last_height
but store them in different units (chars vs pixels).  A graphics
frame leaving values equal to a following text frame's char counts
makes the text resize predicate compare equal, skipping the console
resize; the glyph loop then paints out of bounds of the surface.

Commit 95687639e6 (CVE-2026-17516) fixed the graphics-path consumer
of this confusion but not the text path.  Give vga_draw_text() its
own cache fields.

Fixes: CVE-2026-77913
Cc: qemu-stable@nongnu.org
Signed-off-by: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
---
 hw/display/vga.c     | 10 +++++++---
 hw/display/vga_int.h |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1241,7 +1241,7 @@
         return;
     }

-    if (width != s->last_width || height != s->last_height ||
+    if (width != s->last_text_width || height != s->last_text_height ||
         cw != s->last_cw || cheight != s->last_ch || s->last_depth) {
         s->last_scr_width = width * cw;
         s->last_scr_height = height * cheight;
@@ -1249,8 +1249,8 @@
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
@@ -1845,6 +1845,8 @@

     s->last_width = -1;
     s->last_height = -1;
+    s->last_text_width = -1;
+    s->last_text_height = -1;
 }

 void vga_common_reset(VGACommonState *s)
@@ -1887,6 +1889,8 @@
     s->last_ch = 0;
     s->last_width = 0;
     s->last_height = 0;
+    s->last_text_width = 0;
+    s->last_text_height = 0;
     s->last_scr_width = 0;
     s->last_scr_height = 0;
     s->cursor_start = 0;
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -122,7 +122,8 @@
     uint32_t plane_updated;
     uint32_t last_line_offset;
     uint8_t last_cw, last_ch;
-    uint32_t last_width, last_height; /* in chars or pixels */
+    uint32_t last_width, last_height; /* in pixels (graphics renderer) */
+    uint32_t last_text_width, last_text_height; /* in chars (text renderer) */
     uint32_t last_scr_width, last_scr_height; /* in pixels */
     uint32_t last_depth; /* in bits */
     bool last_byteswap;

