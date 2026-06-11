Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD9CCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbM0-0003lA-H1; Thu, 11 Jun 2026 05:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLw-0003TO-Dn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLu-00053G-Gm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESuLLFwIW6j5JF43r6z1Rimzjac38Z2vjPfM1I49KGw=;
 b=Zqq6AFvU+uLgQ50jqhoFfON1h1xnO0/xsALrK0cFrafJolxvXxebtagjkWyNTnzgDy6CRp
 PrRkqqbVmnIh6jW7DCAz3UC0kue1WzvjByH4Wl7p+s3KSuWFJWBSDasDeqTmSI+fAO1emK
 Hf583TwHL6Fl6pZoKwaHriPjlfY5zPE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-BHjLEu0ROO26geFFMSZf4w-1; Thu,
 11 Jun 2026 05:05:28 -0400
X-MC-Unique: BHjLEu0ROO26geFFMSZf4w-1
X-Mimecast-MFC-AGG-ID: BHjLEu0ROO26geFFMSZf4w_1781168726
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA3EB1956064; Thu, 11 Jun 2026 09:05:26 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D3EA1800351; Thu, 11 Jun 2026 09:05:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:35 +0400
Subject: [PATCH v3 20/35] ui/egl: implement display and EGL cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-20-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3wgnq3+LmSQWhX3LOCNiGJbGeShmFv6Mi0xyiipmBTo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnng+J6gha3gyuxDZ8AfO8zV6NTGjyyvk+5EB
 lMLRiW95/OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54AAKCRDa6OEJdZac
 5fcBEACTzXLnNPwTvTm+5LFw5kMCEwv4aIm2/xiX2PxUmVNdWbtmktf2RFsatr6LrD0V3hy4xhw
 +vBg5b8NcUUcY4RkR8hqPlcu2dJQElsDWQpg1bBWDzMPJcbySKdbia+Zx8xqz9kTore0sgEVzis
 m6K60GXOBjLfLicN2pfC5oRd2TNSRHvQGRA6mcE+sekvgoYoQnaljHLZFXTnJFYrT77Vgp7PhFE
 wAFsDggk217W8F8nOxABTKMp2gRhB4+y6r74SXgxg7MBIyEY9oCyOu7CD5o+qeHL4HguU7xh+ZJ
 kK5OBIVC9L8xs763RTUwNH1HJe5tp4BmfY83jRWQ31H+BdOkDXAJIVhdXHx3Bcb4XJA4rt9m7mw
 LKpSvhCAh1TZPwtH/iHcEAwQSNOSvy+cndiBuFIQjq7jOSGS4ie6MtUmArvMfGZ1xswAAjrYXts
 vHA1p3JpVXdRygL42HfQ6J0lJuAb5n4hmgCs3mOk4iAOb9GBSSez4U6qipen+RkqbRhd2iVyKve
 M0OzMegh7ZYgPgZeMGh0Qov8LR3JrirEUuRWIirJuO9j1rUkxZNPGM/uVBjrxtskwydYgkX2HeT
 VsAnjy2xZRC1llXJt97S2L4ifv2DzddELbbBOcysuZ5jjNGyyPn7F881hdcuTbEwi4/h6fjikx9
 FElcjrtOU4biJ1Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h |  1 +
 ui/egl-headless.c        | 31 +++++++++++++++++++++++++++++++
 ui/egl-helpers.c         | 19 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index acf993fcf52..dba788fead7 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -76,6 +76,7 @@ EGLContext qemu_egl_init_ctx(void);
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
index e3f2872cc14..a7bfb15fd88 100644
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


