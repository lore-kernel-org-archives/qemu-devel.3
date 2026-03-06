Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA4FFCC06A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDH-0005Gy-1d; Fri, 06 Mar 2026 14:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCN-0004BD-BP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCJ-0000QD-43
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so6371058f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826653; x=1773431453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Ywt0UlJuFZem0wHlvStS/BsneoI1aIANoubc5aE6vw=;
 b=w05TMZUvypXaCSn7WrSUvV6g3HF/PolzmHoHRSENn2QtLiQPXrDDZVRzSF0TU6f3sX
 30P5rQORmoQx6Aymuw6ItTIjkVeIjwBR+tAXSdmRyARrtdHt99BjGQf4GC5lNmBJk7vt
 2iB/mDqr7BDYgw+IvTd46Q7Sddf6C6+7pHDzFiPacYkYXUXLHEPT8AGg0CpHt5ZkZJVV
 vnb5h9qt9HsWk1TuRmBAzZoxRGXcudP18epWul9vKtxTXhrurkWeGg72nWkoHiZSwtKO
 RYGFCEM7BaML2tcTVxQHxgcoMyAZpDgVokN7Rs/1mdpSJ40dH5Fo0vT0h5uTa6fXbDyz
 I14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826653; x=1773431453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Ywt0UlJuFZem0wHlvStS/BsneoI1aIANoubc5aE6vw=;
 b=oYwSH/E0sMHta89OsgVrZJl4P+5IPojQjY5gbFy0mWUzSo7t51ftZ+EcFNRavk64g3
 vYqThgH4GeZGGLsW/WRtmpYbY3EUUg5qRp76vR3+wCR50jrzMGJDtSRtKbsomHU5g6Jh
 WmhsWkWWKm2aULWLeTTWRPrnmuzmryZdstin3/nlbV3syvEYfUfgLAlI1I89381smpEg
 DoMYEb2NlzVTjPK3QULShmJcjh/LwtstOceIb4kYpgduSDDTP8vpOEKY02TP+UAkpneh
 onafsPRqp5KuJTn4NX5PrJ5hYNGFmIkOuqVnmqdiaPAcICLcZZBmBbO1bqpyPKi4OQqr
 hu2g==
X-Gm-Message-State: AOJu0Ywbuhdc9qSqIfmaRmbzFX2ad0ZxnYW77ad6yMQqR397dkZJsVia
 5MTAOokPBsYypFpuc4lKVGXE+kRGMOnATOud/GSuzTZ7NHVB+fY/1GwSruxPRGwrznLEFpny6GL
 LvvOJ
X-Gm-Gg: ATEYQzywfnXBcngaCK6xLifaxAqL72qN5QtlInsgelyo+Zj21SqJKDSCFNTxxRSeiSk
 fNlerb922M+JC3pnCU65sv58/48N1j0E7iC4cAJzGpOR14ZaVk/W2VbEBtk4/LM5LRpODpC+b91
 It86Ol3WAoSl8WBiGc4Qn3fpRhq7qq22jQ1wPVhjUP+S6eKyFj87XB/x+JvPtFSiO+CdkwaFkDY
 Zy4mfszCknIZxdWB3TYfBB4NfnHzQQFBSqSSGxU+nSFUQGeJ3JBdU5nSw++PG9UfJ6cw7BNO/gd
 iUtWjHVmu6drV38vilExu1UWnw24lfwMU+177kSwAbG4Z2ecvWPlplWZimFYLWydDpjDVf3XtMu
 N1gsbs/2VyLRnSEKPbCuGzgAKbswqvdADFTA6Xt9aswx/X9ydnBXO/mXAFoEPH80XJ5SqUXVlLt
 M4OirFLQOHuAlszhk9FEE3vU4=
X-Received: by 2002:a05:6000:258a:b0:439:bdd7:425f with SMTP id
 ffacd0b85a97d-439da882125mr5981887f8f.35.1772826653452; 
 Fri, 06 Mar 2026 11:50:53 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm6608821f8f.26.2026.03.06.11.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 76A4C689D5;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/20] ui/gdk: Restore original context after new context
 creation
Date: Fri,  6 Mar 2026 19:50:33 +0000
Message-ID: <20260306195048.2869788-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Get currently bound GL context when creating new GL context and restore
it after the creation for consistency with behavior expected by virglrenderer
that assumes context-creation doesn't switch context.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-5-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c709b2ce0f6..ce49000d3f1 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -250,11 +250,13 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
                                         QEMUGLParams *params)
 {
     VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
+    GdkGLContext *ctx, *current_ctx;
     GdkWindow *window;
-    GdkGLContext *ctx;
     GError *err = NULL;
     int major, minor;
 
+    current_ctx = gdk_gl_context_get_current();
+
     window = gtk_widget_get_window(vc->gfx.drawing_area);
     ctx = gdk_window_create_gl_context(window, &err);
     if (err) {
@@ -275,8 +277,12 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
 
     gdk_gl_context_make_current(ctx);
     gdk_gl_context_get_version(ctx, &major, &minor);
-    gdk_gl_context_clear_current();
-    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
+
+    if (current_ctx) {
+        gdk_gl_context_make_current(current_ctx);
+    } else {
+        gdk_gl_context_clear_current();
+    }
 
     if (gd_cmp_gl_context_version(major, minor, params) == -1) {
         /* created ctx version < requested version */
-- 
2.47.3


