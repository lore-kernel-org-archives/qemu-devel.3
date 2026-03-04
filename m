Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF5FEF900B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR4-0003tV-1J; Wed, 04 Mar 2026 11:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQz-0003qD-Im
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:53 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQw-0002Pw-5z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:53 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65fb991d7eeso9568946a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643049; x=1773247849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t95kWQWOrKB4N4tylTfItpGqfNMJL0Byyr/GwBmoQ4E=;
 b=kXMrmSnjZrNJHiqxY8y1+YQfJpwXLOkbzH1iXzY/QgQ2W7PkMqx1pdGLcyJgqyeRuV
 /tqYaT3aR2N4NlnG5pFo0uBqntXy0XH0JW20VAUsLcdGj1IzLPYa/vtATNb+2zNuIxAr
 jt5RnZ+Us3Vpq2/g2ZSj4qUDh49BHcWz+8kHy2uE/u06GVJWBML0p5XpLq8KRA6ll8Gc
 SZ8JQ3MdBDJf43XoErxd8ZwWNGwvkasRuV4lRVgD/tRSIGCEhyXZkK44amMPtqKh00C8
 Y0jXzD2vzwOZWCyIhcFqQMVjBvsYpC5178PxyuusXaBaMf4inM7klfHRSOp5Z2xLdTe4
 cKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643049; x=1773247849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t95kWQWOrKB4N4tylTfItpGqfNMJL0Byyr/GwBmoQ4E=;
 b=CyN18voeyqhR+aayrClshZe+IPevVNjkSQ0oNGo3/Dkxu21oJ/6BF+gmoWRQmQFAsF
 uHSE8QNm5q88VSwpeCwft2cVACQkJrH1ErEV72TwKtz19ibIBGTfGTUtDQXKEQu//qTb
 pBGtKvdhvEnAhY5cuHOZEV8iwumoHQaxDXVNNP8HMZhjNH/G9U6+jaEy2XrzEY0ai0LD
 kx80oV1U4WrUlME71GskRDGaSnCIFjac2FXY9mnO2CgYeLQg0meYmM64tp4PyW9zSZHF
 C++w+SoDlKEYoI8k+JWQa0COCZ+Ffozd72CrfCFu8eOMxgzNBWHJY/Iw/7DBSG+tISDL
 sYqg==
X-Gm-Message-State: AOJu0Yx/KRpo7v4BcAYph/JlUsL0qgUxHDIfgcmSuMpiWiMwPjBPtyHD
 J/5+k+jWSnWfnLGSwPVh6nZl8sBzeh5QZ5DAzHrhgJCfAjP/W7IkyIgE12ZVQG/m4Vo=
X-Gm-Gg: ATEYQzz03IeszUbXgIm00wjfEKL868O2klbmQcH30A0KmIs3Q05Fdzz0kt0c8NiyfZT
 Qpk4cCHP6+JqOTZ6ePuke5THYe+zY0ZEvKbevvLUATjSg3da+5r5I/FVD9KfW2hDQ1g7NNYHvhX
 QyEqPFLzBsU7xMNWhz42LEMoFIXWE+c+loBr331Zg3nDChW5j29NbL5mwznb39+4G3IiQxOImZ3
 mYD3cdTrRmjW3sChQjoT6Rhzh7e25fmtJKwkLmIDJqk2ZBRuJRTD0TIdyxvIumegh2lf+SMrsD4
 jpRie46DARni8jM4Hjlo9qhHXFBOQdn/uas/QKgoURS25PeoNPz7FWSbcHBc7Rpj7qBMol9DBRf
 8q4yiPijT7DfitptajAOjVKr9AZPrZYWTYcwE53qv5gJwerbLrUDP7dAKNWu2BwyZEQ1VSet3k9
 w20E+Jbyg87/wHt4FUDN8FBdI=
X-Received: by 2002:a05:6402:34c2:b0:660:dd8e:5382 with SMTP id
 4fb4d7f45d1cf-660efa94b11mr1640523a12.13.1772643048745; 
 Wed, 04 Mar 2026 08:50:48 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-660e793b7d4sm894036a12.7.2026.03.04.08.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4443761EF4;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/20] ui/gdk: Restore original context after new context
 creation
Date: Wed,  4 Mar 2026 16:50:28 +0000
Message-ID: <20260304165043.1437519-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
---
 ui/gtk-gl-area.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

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


