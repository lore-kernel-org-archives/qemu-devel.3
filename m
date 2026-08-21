Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F8BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxUhh-0008Jt-7J; Fri, 21 Aug 2026 15:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wxUhf-0008Cl-Na
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 15:14:59 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wxUhe-00079E-3h
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 15:14:59 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b4740ec30cso1378330e87.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 12:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787339696; cv=none;
 d=google.com; s=arc-20260327;
 b=iRcFvA+XZn/Ebp7LD4EzL7xcVuYo3RvhIsvd8o1FfNd1BWPb72wDc7+jhtPcC821bo
 o5qvH3Z3AyPY0RCdVl3i+sbgpY8p+eNLqVPDz19pzde0QQA9bwuo/aIe69I+1PdsIMZz
 BnXX8Nk4B+BLOxajSIoWaSH3AT8BJZG24B9CR6VBALqSIE3qLSgP3DMSs3405rdao0zi
 lxHhjgMqAyEGfEUrKRbdJYxv9U2lmZJG88lQ8F96SCpfHiY87nnIEQpIZ8ZokA8TKgtq
 DPzYj/Y+JCOFYpvxa6O7zKPLdKBkqsXpUmaFgpx1AAELKCAJriCxWzQiXl2s3hLC2NPK
 u2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=+oA+jUn5llXQsoQ81nJjEf6x+kdBND1+WuOS+/5ZfYk=;
 fh=WS/FPZF4INf3fCqbT+W34SJMw0WsZ1wrdPlyicLyxsI=;
 b=EGQ0efhF+z/OmForF+DWUjK9+WBZJG+FXG5amX7UKAAhtoqOyOrFiFWSNzLbDEgAZD
 O8apUuOGUqUZBnJFEkdhxROXvOgRYp/ju7NEAyMp0jgrXhOvOT0cpmwKixxa1eAkkl7r
 4OkvLCJNsIGW5pXGSul/dRVx374KnjugOhB83lyScb8yxIEiKlbdmHYjqvN1oN9jlGQg
 RTF6NheScg/Xv7YVEpQudE2VjNaaOZ3WZxLnCCR+YEK8tAAd5m+63RedhExXMlqyS/z+
 2lbwfQnFARSn4+z/6pLKdyIaHzAjwCDHhCMpOVtUtX9pTezb0Mq0i4uhncNOq6AGCxKI
 krqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787339696; x=1787944496; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+oA+jUn5llXQsoQ81nJjEf6x+kdBND1+WuOS+/5ZfYk=;
 b=aty1/OEJf4t/VsTSyU0jymX0CaK+DN//wYhF0EyXqLfOrOAYGNKO4u0+tWwrFl0mzO
 imryERL6eRXk8XE500OyoEqDemZLqwiAaxuzfI+eK8d/sAWNyO+C3z4OEWUOItPbD9e3
 qKhK/e63qqfXKjv8QVeduUQeTt7xYRlJeh6yHHNTVA6MX4UihQUA1mQLMu7C2yD/p34X
 w76JKNSkyUPxQuVwRp0Y/dTaKtm/wfZVMDsSUe5AoszIOD4jbjR/AZcTsdsE0WhgMJ9Z
 oUv47f1WNjXaf3TO2uT8VBeoPpQmRAOJ7Ksq6m4jG5cZa7Mifbz01DfJwobmOKEdx/ei
 Hr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787339696; x=1787944496;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+oA+jUn5llXQsoQ81nJjEf6x+kdBND1+WuOS+/5ZfYk=;
 b=siJgYwxYFjwGe5JD7cCmq/n3TleUBg/NSn2T3KASSOWdATVm5Xp+oI6Uuq2nM9s2Rb
 ac9UcERQ+xdUrj8MdsCWe3hnuakCXRRx9NzHGVvCK9V7pQxuj7EgrjuEBT2XfTXqLxqa
 C11KG6I04fSVN0nRQrzn2xz114Yot5hfN62QVzvQEDXzxb5hZvj5Ge744xHYRac4c6F9
 8Oet2E8WITKgJ0tibeXmI0Nl1JkXCNO4YIS6ErgE+kyrUehiv5g72HhdMgBm39uhOvVC
 Pn9UF0WRrwlHlSakffb2GrADUYUlXrXjMQyo1EWxEVGBbj11jUb9J9Om1oJL38AjeOPq
 fIPQ==
X-Gm-Message-State: AFuF++kwPSGfyfP/UXUDFTD2QXFm+tXTJg8fpjezO5aG48hE+0JhBh0b
 xvalymi7s7ohYdFBzHYt32po4rA3qJ2nu+iJco4ODUQVcJV2aNWyHRHeQiKTvIN2MFK4ZTv3J1P
 lHRr5h9DLfc+wJ2nHWN68n059v5ovk7KYuFOpRyk=
X-Gm-Gg: AR+sD13cT6zm4B0YBRHTZk/gt/4N7NKGYibhfaAwXIYfDaw/Yt/4eL7hg0d4G9GTVMc
 K9zRNwelOk3fCGWM7bqO1Zh84VhKF5lOIw26MSgk4OiBQ58vxx3Xg4UMvsdUnyHw8EjxnTMYhcw
 lohBW/ihvtw9wP+zK+5785nMRT7IxsHJ3oTt4NWjMr9Whqb9MWtlc0RpgB2GioEMeUEYyiLg5MJ
 j3wIEUyrd9XAkzUSVLQtDVowFmYL5tXBQ/lZ9JZmqdZ3LgxajM4w+6TR08XiTdnGTB4FVVfnQPp
 Eh0OYnnuUiLeO2IxLo7AgzwOwh/tLIFeMOZxO+ive2oftz9Pwu64xh/VUrqqZ2AQReaJMGgEh0i
 re+0=
X-Received: by 2002:a05:6512:238b:b0:5ae:c27b:f7a0 with SMTP id
 2adb3069b0e04-5b4841f503emr2746232e87.11.1787339695485; Fri, 21 Aug 2026
 12:14:55 -0700 (PDT)
MIME-Version: 1.0
From: sin99xx <sinxx198@gmail.com>
Date: Fri, 21 Aug 2026 15:14:44 -0400
X-Gm-Features: AcwNN1Vutc5rckdA5P64UagxOth3m0nX95u7Lew0TnIAOtzz0IwU9SgehfFr-qM
Message-ID: <CAMX0No0RNTzennt6Z7t4-zO1y=b1o2jBtz-CfdWTpV+wyq_NTw@mail.gmail.com>
Subject: PATCH] vga: split text renderer geometry cache from graphics renderer
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=sinxx198@gmail.com; helo=mail-lf1-x130.google.com
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

