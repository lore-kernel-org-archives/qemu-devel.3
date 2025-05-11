Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A12C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1DC-00046i-4V; Sun, 11 May 2025 03:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D9-0003z5-W7
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:35:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1D8-0003gP-4Q
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7418e182864so2534134b3a.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948896; x=1747553696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pwmbE/ztEjvj4DxSxFaguwhF55V37aeGCY7nprPzjc=;
 b=F4BkhGWhND9D9TCDSrWSg79IpsU2Pt3+lfq6lJnAsJkvEr2D8ztGFppPhad3PLQ1Ru
 qENw1xHwQVLjikbRCMojyjT7wilGfTmCUzScVAPLCzes2Pc5SsObKCX5vB+aRGLuys86
 Aic/EWI+FE6FfIB9jrTERCUjuJi/xgy/pZtHXJchHeZRXGZnJ+pUbbpbiRWQp8O53mHi
 WsM+0s9Wu887UnpMMQco3E/x9jxLU20VQpEXed3bq8Ngs8IVU8CQGWfcgqUFAa8kKzXp
 mM429BcmBX66F3WKlZsoANJmJlpCeTF1lVuPlVg9TLCjUwrmuTfyQCOW7SQH4+/ml8+O
 e+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948896; x=1747553696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pwmbE/ztEjvj4DxSxFaguwhF55V37aeGCY7nprPzjc=;
 b=tcWybRMitNr3dzsikBJew3BBJ6av9ydHw8j6RIGaM/cNlKNpXLIr7m04OI+vKG39UD
 KcVgOrSQ3MNaRTyjDrbfJwXT3yE6oFvEV3JO3aeTHXysmkQtGwWof4Z9ogOCFRIFReCQ
 AD1zhSS6h2wMGc/QfA8Ada+dDVzdKyYoHdcsYH/zO7E7o0jPILC6KmfbQOgbrvnwV/hm
 UOSHttmXFnVl1g2tqzbZyjm86WIQ/R1YV3Mc+D65tGuCmaC9weWljUyZi1oAMnrfe3Cf
 Ml9yn2J+SfLKqbnF2IhgSsq6AMes8vDDNnITawLmdRV6ksBhS3tMzPpqWh+zvX5yjMCt
 bzjg==
X-Gm-Message-State: AOJu0YyxugZMZy3ckrbMtdYYXSdgiKjov3DPXcFTPRZNwNwhdAIcn7kq
 +V4hFCBt7BDviZlCwSt3lDFH/xrCKUkWjIwTiH6UDgGHL4+Wts/dPp4aOCUN
X-Gm-Gg: ASbGncsCwoHVKGjbOER20UYxjGzZWfisU117aX/fYva1juQ00hctZmHOEhl5f1rkbIp
 XTRCnjTrZchFVxAbA92DFxiHkwz49JQYC0zm291VqKQaETUYM3q1rk21ZP0oVSEWT1jolTU/+pO
 89W5ipa4mwv64Ah3m0sArvBN8oGTVkABE0L0tqqqU8toBI45ARdTy8YjUSEuA7WZa5gk3qjUOPg
 iThJ0arBia6K4MLYT2tyzUx4jtiph4j4xUYGRfzqaXP7Ep2528/T1/Z0sOfzPbJx41wii23F/KK
 dO8/8wt1LIW+QUj5u9ZiM86EAXzJbOZyFLx+dIsMI6JcwS13aplZNmA=
X-Google-Smtp-Source: AGHT+IGK+l+gTPrL8u5Sv2U3zBygrzDGHtX7BZOOGPZcMe6M182ajLJ51oZfEBqKffaE+kWsGZXUIw==
X-Received: by 2002:a17:90b:1d81:b0:2ff:6e72:b8e9 with SMTP id
 98e67ed59e1d1-30c3d6464ffmr14827563a91.25.1746948895896; 
 Sun, 11 May 2025 00:34:55 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d54fe0sm6699177a91.22.2025.05.11.00.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:55 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding in
 fixed-scale mode
Date: Sun, 11 May 2025 15:33:18 +0800
Message-ID: <20250511073337.876650-9-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In fixed-scale mode (zoom-to-fit=false), we expect that scale should not
change, meaning that if window size is larger than guest surface,
padding is supposed to be added to preserve the scale. However, in
OpenGL mode (gl=on), guest surface is always painted to the whole canvas
without any padding. This change tries to fix this bug by adding
appropriate padding when drawing surfaces.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk-gl-area.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index db93cd6204..8151cc413c 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -44,7 +44,9 @@ void gd_gl_area_draw(VirtualConsole *vc)
 #endif
     int pw, ph, gs, y1, y2;
     int ww, wh;
+    int ww_surface, wh_surface;
     int fbw, fbh;
+    int wx_offset, wy_offset;
 
     if (!vc->gfx.gls) {
         return;
@@ -61,6 +63,17 @@ void gd_gl_area_draw(VirtualConsole *vc)
 
     gd_update_scale(vc, ww, wh, fbw, fbh);
 
+    ww_surface = fbw * vc->gfx.scale_x;
+    wh_surface = fbh * vc->gfx.scale_y;
+
+    wx_offset = wy_offset = 0;
+    if (ww > ww_surface) {
+        wx_offset = (ww - ww_surface) / 2;
+    }
+    if (wh > wh_surface) {
+        wy_offset = (wh - wh_surface) / 2;
+    }
+
     if (vc->gfx.scanout_mode) {
         if (!vc->gfx.guest_fb.framebuffer) {
             return;
@@ -79,11 +92,29 @@ void gd_gl_area_draw(VirtualConsole *vc)
         glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
         /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
 
+        if (wx_offset > 0) {
+            glEnable(GL_SCISSOR_TEST);
+            glScissor(0, 0, wx_offset * gs, wh * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glScissor((ww - wx_offset) * gs, 0, wx_offset * gs, wh * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glDisable(GL_SCISSOR_TEST);
+        }
+        if (wy_offset > 0) {
+            glEnable(GL_SCISSOR_TEST);
+            glScissor(0, 0, ww * gs, wy_offset * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glScissor(0, (wh - wy_offset) * gs, ww * gs, wy_offset * gs);
+            glClear(GL_COLOR_BUFFER_BIT);
+            glDisable(GL_SCISSOR_TEST);
+        }
+
         glViewport(0, 0, pw, ph);
         y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
         y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
         glBlitFramebuffer(0, y1, vc->gfx.w, y2,
-                          0, 0, pw, ph,
+                          wx_offset * gs, wy_offset * gs,
+                          (ww - wx_offset) * gs, (wh - wy_offset) * gs,
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
 #ifdef CONFIG_GBM
         if (dmabuf) {
-- 
2.49.0


