Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72182D6ED26
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 13:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE6wX-0001g1-Vt; Thu, 21 Nov 2024 08:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE6wM-0001fD-Bj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:09:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE6wK-0003kw-NH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:09:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43169902057so7372175e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 05:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732194582; x=1732799382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lVqSf6tRgP2wjiZ5qyh5pJyYLA55IGXtorUGMNDvwL4=;
 b=nQ2QcczsfkNu2mkhMNrYMrC4qLoHUbK/5RNovYEM/oTDT1n4KwYUUZoKxGXDkWzAln
 lqXGwvEulmpnTQbdWd9Oz8YJW0K6E6Tt43zNcy3RiVyosTIJsN1Eml8RIqRsNcIrJtZi
 PWyBjfMGeOoUgqXqdDbZBNgDvpo5IRvuYpdmMGuEou1seMxwI1yf08LierVgx+4DQEyD
 oAZ6pQDSQ1A6nHGpF4fFxlZvg8eRoqLfRqMqr3Kg1sH/tDkk5VFcQ7LSx1bTeF4tNEit
 5XjC0Pbp1CSLXCqcQ/R3Xolvu62DarHneCMDdzHLWT1K7pVgkz6CYpWsSAXAYX87TFf4
 Itbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732194582; x=1732799382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVqSf6tRgP2wjiZ5qyh5pJyYLA55IGXtorUGMNDvwL4=;
 b=Eo1bbvyZ9cBoOxguBZU1FNQ7lvFc3qD9hSs2/DQhyAMRPu757Un29vEx0dwDyKApLA
 e9alBN4OAIue8mK3mc2PVVu9wmEk3fFzLdoSJLL8CBzPqdfYjv/ivLtdhW+72gWZCANb
 ca1qp781Un2VkzBoYn+GpxRPjMVtESUkV9xV+b4H9gSNi4UQNkegDvc7Pp28tFMDk4zd
 dKntI+9/c7e94WeV4Ugmq2VyDlukhI0oq5CHw5cuCLqiaNGa7PJJ7Fr9MhGO5JBp2LyW
 PDkGa4KyEaZv11j+pLwd6k4jp7rF498oEjbdo7q2/cgY5o90HCLmpEt7wSIcBSQeOlHN
 Z4QA==
X-Gm-Message-State: AOJu0Yw8xw4LcwlhxDmMw+B50hUzh2w8ChGQ8N4zGeZnlzur+sJj9gEj
 qfmdkCXwKctVDX6SShjtkIg95pRDrZAJnuTSEEmfGcBq1gwwV7081JXS9yvW42w6jvPCZ4/EWX3
 D
X-Google-Smtp-Source: AGHT+IHAbFomlRlDmY9/6mHf+QZRm8Hz81G/qp7x94woRIsUCmKiBmJzraNgVkrt1BPh1tC7TMcHEQ==
X-Received: by 2002:a05:600c:34cf:b0:431:5a93:4e3c with SMTP id
 5b1f17b1804b1-433489d4d84mr63821425e9.16.1732194582407; 
 Thu, 21 Nov 2024 05:09:42 -0800 (PST)
Received: from localhost.localdomain ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d1aedsm54376575e9.1.2024.11.21.05.09.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Nov 2024 05:09:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] ui/gtk: ??? Remove dead code around X11 ???
Date: Thu, 21 Nov 2024 14:09:39 +0100
Message-ID: <20241121130939.97212-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I have no clue about what this code does,
but gtk_widget_set_double_buffered() is deprecated since GTK 3.14
and we require 3.22 since more than 4 years, commit 7b23d121f9
("ui: increase min required GTK version to 3.22.0").

Assert gtk_use_gl_area is set and remove the dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/gtk.c | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index bf9d3dd679..d968cf3de1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -809,17 +809,9 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 
 #if defined(CONFIG_OPENGL)
     if (vc->gfx.gls) {
-        if (gtk_use_gl_area) {
-            /* invoke render callback please */
-            return FALSE;
-        } else {
-#ifdef CONFIG_X11
-            gd_egl_draw(vc);
-            return TRUE;
-#else
-            abort();
-#endif
-        }
+        assert(gtk_use_gl_area);
+        /* invoke render callback please */
+        return FALSE;
     }
 #endif
 
@@ -2156,32 +2148,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 
 #if defined(CONFIG_OPENGL)
     if (display_opengl) {
-        if (gtk_use_gl_area) {
-            vc->gfx.drawing_area = gtk_gl_area_new();
-            g_signal_connect(vc->gfx.drawing_area, "realize",
-                             G_CALLBACK(gl_area_realize), vc);
-            vc->gfx.dcl.ops = &dcl_gl_area_ops;
-            vc->gfx.dgc.ops = &gl_area_ctx_ops;
-        } else {
-#ifdef CONFIG_X11
-            vc->gfx.drawing_area = gtk_drawing_area_new();
-            /*
-             * gtk_widget_set_double_buffered() was deprecated in 3.14.
-             * It is required for opengl rendering on X11 though.  A
-             * proper replacement (native opengl support) is only
-             * available in 3.16+.  Silence the warning if possible.
-             */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-            gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
-#pragma GCC diagnostic pop
-            vc->gfx.dcl.ops = &dcl_egl_ops;
-            vc->gfx.dgc.ops = &egl_ctx_ops;
-            vc->gfx.has_dmabuf = qemu_egl_has_dmabuf();
-#else
-            abort();
-#endif
-        }
+        assert(gtk_use_gl_area);
+        vc->gfx.drawing_area = gtk_gl_area_new();
+        g_signal_connect(vc->gfx.drawing_area, "realize",
+                         G_CALLBACK(gl_area_realize), vc);
+        vc->gfx.dcl.ops = &dcl_gl_area_ops;
+        vc->gfx.dgc.ops = &gl_area_ctx_ops;
     } else
 #endif
     {
-- 
2.45.2


