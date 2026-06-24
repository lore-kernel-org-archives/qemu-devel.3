Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C01CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0t-0003MJ-DG; Wed, 24 Jun 2026 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0n-0003Ed-61
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0l-00085q-Ee
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wp+gOa7w6okWnqQG9NLVesU9AKbObvi0L3iuKa4JSGk=;
 b=b6ZHocN3koeem4zd67HuMLo7UXC6s/NmOKjcNvSyOlPf7T5KLCPAZzjh2OhX8MTbG+OAEe
 6z44Nb/wpbrww0NxWd+r6yneirt2UW4Igp//KGVt0nRn68VAA2mzx7a5e9+NNZSCqrbIaw
 Z2OhZPuTcAnbyMyNjXvDHlAA18ndUBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-gIIE2ibROFSJ4lKQONWxJg-1; Wed,
 24 Jun 2026 07:43:17 -0400
X-MC-Unique: gIIE2ibROFSJ4lKQONWxJg-1
X-Mimecast-MFC-AGG-ID: gIIE2ibROFSJ4lKQONWxJg_1782301396
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDA2B18005A9
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82338180058F; Wed, 24 Jun 2026 11:43:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:41 +0400
Subject: [GIT PULL 19/35] ui/egl: implement display and EGL cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-19-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jca7AjPmYbnDHRocndRnhM7EYaiMpafKt5/Xsb12RME=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JoK5IEwXgBVK3nIEpS4l15TIy5Z8SnAp0vf
 nV0A04AfXOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaAAKCRDa6OEJdZac
 5cpfEACTT4Y0rPMkfa05vklKxlAAAHATVTD71sxGOv4K9XDDjONHHu7NrbpDN2HL/ue5+VLh4+J
 XfgyfljS9+g9IQnZ0hcZkwPJy7s71zdLxzeOFYH9yzIPEdgILHmA8wbugIEz1Ymm+gzwJX9l2gM
 pq9t2/t/dv7w/5cA0c3R361IUMPYbHGmy0AlsvS1XuGL1pPsGUwUk9sGo4wDEloRTHdM9uj9zyo
 VSwCBcv/Qm+FWPCStaUlIqQeXPYh9zbu7xmjyX1ltIVRX4hwP0cLYjezQ8cLIEDYQ66L12yvTuq
 KxYyEtmef2VwdVekWrkPah8a7HXYZScAQmxaZciEc0n+O4EwcI2spsLnL+KQNzwVlDPH7TSSdMu
 Ix7B+sLeCMogmPp7+dRXLgtqXWC5813jZq343jNjNqHUc+GD87vYK2rH5X1ZOkHhGLQULGoSXcb
 Vwgl3FnEOJw6PUduLSG1pumWGkICL9y43PzJhHL///qaPKt9KQphUEhe69OZBqpBNqFnnQbKzyR
 7JOEE+i+3oyOtOOMvmAq5PVMXmjFjOKNxeS7NLp81OBjse/1AmuWBgz024760laT8rhN8P/Q/JK
 Q8UcrzEhQmNy54AHkjlI2tytrQInHK0hFZD1dsSvlH9YJc/rttq6iaCMbid9WV1OoXUIK4xFUJK
 vhH2nUxn8Jq0G8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add egl_cleanup() to tear down the EGL render node context, GBM device,
and EGL display. Add egl_headless_cleanup() to unregister listeners,
destroy framebuffers, and free per-console state tracked via a new
GPtrArray.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-19-4656aec3398d@redhat.com>
---
 include/ui/egl-helpers.h |  1 +
 ui/egl-headless.c        | 31 +++++++++++++++++++++++++++++++
 ui/egl-helpers.c         | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index c97a0d5c248..405ddd91259 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -81,6 +81,7 @@ EGLContext qemu_egl_init_ctx(void);
 bool qemu_egl_has_dmabuf(void);
 
 bool egl_init(const char *rendernode, DisplayGLMode mode, Error **errp);
+void egl_cleanup(void);
 
 const char *qemu_egl_get_error_string(void);
 
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 878bfebb40c..ba27efcf4c3 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -9,6 +9,7 @@
 
 typedef struct egl_dpy {
     DisplayChangeListener dcl;
+    DisplayGLCtx *ctx;
     DisplaySurface *ds;
     QemuGLShader *gls;
     egl_fb guest_fb;
@@ -19,6 +20,8 @@ typedef struct egl_dpy {
     uint32_t pos_y;
 } egl_dpy;
 
+static GPtrArray *egl_dpys;
+
 /* ------------------------------------------------------------------ */
 
 static void egl_refresh(DisplayChangeListener *dcl)
@@ -220,6 +223,8 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
     egl_dpy *edpy;
     int idx;
 
+    egl_dpys = g_ptr_array_new();
+
     for (idx = 0;; idx++) {
         DisplayGLCtx *ctx;
 
@@ -232,15 +237,41 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
         edpy->gls = qemu_gl_init_shader();
         ctx = g_new0(DisplayGLCtx, 1);
         ctx->ops = &eglctx_ops;
+        edpy->ctx = ctx;
         qemu_console_set_display_gl_ctx(con, ctx);
         qemu_console_register_listener(con, &edpy->dcl, &egl_ops);
+        g_ptr_array_add(egl_dpys, edpy);
+    }
+}
+
+static void egl_headless_cleanup(void)
+{
+    if (!egl_dpys) {
+        return;
     }
+
+    for (guint i = 0; i < egl_dpys->len; i++) {
+        egl_dpy *edpy = g_ptr_array_index(egl_dpys, i);
+
+        qemu_console_unregister_listener(&edpy->dcl);
+        qemu_console_set_display_gl_ctx(edpy->dcl.con, NULL);
+        egl_fb_destroy(&edpy->guest_fb);
+        egl_fb_destroy(&edpy->cursor_fb);
+        egl_fb_destroy(&edpy->blit_fb);
+        qemu_gl_fini_shader(edpy->gls);
+        g_free(edpy->ctx);
+        g_free(edpy);
+    }
+    g_clear_pointer(&egl_dpys, g_ptr_array_unref);
+
+    egl_cleanup();
 }
 
 static QemuDisplay qemu_display_egl = {
     .type       = DISPLAY_TYPE_EGL_HEADLESS,
     .early_init = early_egl_headless_init,
     .init       = egl_headless_init,
+    .cleanup    = egl_headless_cleanup,
 };
 
 static void register_egl(void)
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 069a5249554..d689f187c4e 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -733,3 +733,22 @@ bool egl_init(const char *rendernode, DisplayGLMode mode, Error **errp)
     display_opengl = 1;
     return true;
 }
+
+void egl_cleanup(void)
+{
+    if (qemu_egl_rn_ctx) {
+        eglDestroyContext(qemu_egl_display, qemu_egl_rn_ctx);
+        qemu_egl_rn_ctx = NULL;
+    }
+
+#ifdef CONFIG_GBM
+    g_clear_pointer(&qemu_egl_rn_gbm_dev, gbm_device_destroy);
+    g_clear_fd(&qemu_egl_rn_fd, NULL);
+#endif
+
+    if (qemu_egl_display) {
+        eglReleaseThread();
+        eglTerminate(qemu_egl_display);
+        qemu_egl_display = NULL;
+    }
+}

-- 
2.54.0


