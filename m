Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B86DEA4E18
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 15:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4mj-0005A6-Fs; Mon, 02 Mar 2026 10:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx4ln-0004Oc-RG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:01:22 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vx4li-00043y-0h
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 10:01:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772463634; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ICLzDkr6J+DOzdYiNH+yi3BrkHfZH1+JEi3ONnocnJRgSovWreXfAXXPkh7MfpIGtoEhiJJ/I3RIPIlpe8D4CddYEF8TOJvEpWy32VZyV8arQtI99NCXyrm24tNoqyuk6FbTyKZ9c1vtQcdDc/TY9YuyKXOkg17iMnZgNBr+3uY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772463634;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AS54lv189IEHKR9A0Q0cYhT+FCK95s4XT6UCUKP5tQY=; 
 b=YJN0jm5nEMlp7+M4AWMpFrrZfxCnV1dvNv+xGM1FoHZhv5XMwlJF/Ghr9K04AWx1YUuQxJVNstiTH+nl0JxmI54lXgswq3iLAWFG8VkHUCdumQhpA/K+Ws8pWLbfLLvYojRkBb2ATxXQ8x/0FsskHHc2YACIw/mNyCzuUV7CeIQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772463634; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=AS54lv189IEHKR9A0Q0cYhT+FCK95s4XT6UCUKP5tQY=;
 b=GKyINWic4SVYInhGcYghmQmm+cwvtOSXInbqwH8MEm1K2L0t+rWLJYa4FAcO9HPv
 7h3FQkPwI9Xzg8MtDlMhUDiIT9iQq87tyOtO7XOupj7tb1mM7PafrNoOd+OIjhUYRQe
 l1jZ3XLlBS/sMGAnT8/nxsit/ObWtwx99RzpXJZk=
Received: by mx.zohomail.com with SMTPS id 1772463633115499.5095331601332;
 Mon, 2 Mar 2026 07:00:33 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v21 04/18] ui/gdk: Restore original context after new context
 creation
Date: Mon,  2 Mar 2026 17:59:06 +0300
Message-ID: <20260302145920.735423-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Get currently bound GL context when creating new GL context and restore
it after the creation for consistency with behavior expected by virglrenderer
that assumes context-creation doesn't switch context.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/gtk-gl-area.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c709b2ce0f63..ce49000d3f17 100644
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
2.52.0


