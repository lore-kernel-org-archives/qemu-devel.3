Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E80C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1Cy-0003rT-B9; Sun, 11 May 2025 03:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cu-0003rA-0y
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:44 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cs-0003eA-Av
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30aa8a259e0so3279154a91.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948880; x=1747553680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tS+g3pnX6R2LSJM2Y4TIWBBIODQHvMi7Upe+tVFJbTI=;
 b=bLbd7857zmrxecDjNvZ2UWcZTGTHuT7rZ4SHCeB6p6KEe3WVrb0CwTzMvOYfgX2oQA
 bOwC4c3HQGvXEF+1og4+dZQlbB6IqZI7UhTw0qYN1JMc2SYw8PH9M6LnPi847Q0Xf87P
 zxRVp07eByopzCyU+vuLL5oH8CcxWMB7zd52SM+OUIkLoo159NjppNOHVY0Q494Vvcl4
 JUCyRTO+lPw977bilNQ3PII8pK8fbCmNUsaeb7/bHz/PNwRhhL3oJ6U5iO9U33teL4t0
 tLGsxlA3HmMa8brSkwq8oNLPFuT4ZNzaYIZJva9n+IR5EYy8CeJvsL6IZ9Z+JO9IEfNb
 nOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948880; x=1747553680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tS+g3pnX6R2LSJM2Y4TIWBBIODQHvMi7Upe+tVFJbTI=;
 b=ZHND3uZQKMyxm7VoDNU04J7URadzpABD2+Bxo9QLDpl5k5rzwzt4yASw4GSpbqD2z+
 R80bbGXJ38srKFufG4iA5WwiSqUOPXuTdLi2EobUA3Yr8uP/x0b7aVnDqZBQJoFp1VTy
 nPqR+T5Q2NQReCM20ZMbhND+wxiuSg0YhZfvWsi7bCX5aBm4JlMs+S3Eo+I/v+XaDCwb
 vDbqyaYiRwX8ygyljUwa6OwkIGK1Svq1L9hkq3zlx77wMNsu8AWKyk7D/NN1FC/zYo9f
 xQGiHoRnc4DGAot3kIZFyFd5sIhE3o950zz516zle735cXOgGjy7itEBYYAWGUKVbUy3
 uC8A==
X-Gm-Message-State: AOJu0YyaP3QsCIJQc+advfNsfYDm8o6N00drHK96RLzyJ8mu0mkuALho
 QcDbTq6hCJ8RgkfwYHLdYYgNjVICqj2OZUJVd0xerEF5T5pNpL5emMb8gLA5
X-Gm-Gg: ASbGncu56nTEbOIqqzF3KaIT0JCLBesw95loZ2xqg3xGU3TzBRfOTC311ktZUjx3gHe
 Sdy7yeeBP4mTP4uYjsn80x5oYSGfqp//Sb0sxLD20DjkF7L0mz10n+lkFurKD52WWt/4eWD5UPT
 /LJbdV++jCgTDZwKL6QbbmkLCoXIJR1vroLETjOdYsE0xat89zvwUUk+zIrXrxWo20bN4BsfFzZ
 jkvyjhI2M4esL5v0u5HOz9bdqrJs45q8PaeyiS+Cuo9pxY/X00bAE+hvE7etbjmSIdblRzZUc4t
 54vvFL5YASkrW9rxKxsMwtCJp4kWQuzH8sWX6ORwL1zWePZQYgPiN+c=
X-Google-Smtp-Source: AGHT+IEBaExnNiVQiIm4JH0XJZk68B9bMhjw53xw4HYJU1eWpJ/SPB3MI59quXoKaH27P9WzWfc+pQ==
X-Received: by 2002:a17:90b:1dc1:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-30c3d6580famr13692023a91.29.1746948879818; 
 Sun, 11 May 2025 00:34:39 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39e76039sm4491951a91.43.2025.05.11.00.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:39 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 3/9] gtk/ui: Introduce helper gd_update_scale
Date: Sun, 11 May 2025 15:33:13 +0800
Message-ID: <20250511073337.876650-4-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pj1-x1032.google.com
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

The code snippet updating scale_x/scale_y is general and will be used in
next patch. Make it a function.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 30 +++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index aa3d637029..d3944046db 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -224,4 +224,6 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
 /* gtk-clipboard.c */
 void gd_clipboard_init(GtkDisplayState *gd);
 
+void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh);
+
 #endif /* UI_GTK_H */
diff --git a/ui/gtk.c b/ui/gtk.c
index 8f5bb4b62e..47af49e387 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -801,6 +801,24 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
 #endif
 }
 
+void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh)
+{
+    if (!vc) {
+        return;
+    }
+
+    if (vc->s->full_screen) {
+        vc->gfx.scale_x = (double)ww / fbw;
+        vc->gfx.scale_y = (double)wh / fbh;
+    } else if (vc->s->free_scale) {
+        double sx, sy;
+
+        sx = (double)ww / fbw;
+        sy = (double)wh / fbh;
+
+        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
+    }
+}
 /**
  * DOC: Coordinate handling.
  *
@@ -908,17 +926,7 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     ww_widget = gdk_window_get_width(gtk_widget_get_window(widget));
     wh_widget = gdk_window_get_height(gtk_widget_get_window(widget));
 
-    if (s->full_screen) {
-        vc->gfx.scale_x = (double)ww_widget / fbw;
-        vc->gfx.scale_y = (double)wh_widget / fbh;
-    } else if (s->free_scale) {
-        double sx, sy;
-
-        sx = (double)ww_widget / fbw;
-        sy = (double)wh_widget / fbh;
-
-        vc->gfx.scale_x = vc->gfx.scale_y = MIN(sx, sy);
-    }
+    gd_update_scale(vc, ww_widget, wh_widget, fbw, fbh);
 
     ww_surface = fbw * vc->gfx.scale_x;
     wh_surface = fbh * vc->gfx.scale_y;
-- 
2.49.0


