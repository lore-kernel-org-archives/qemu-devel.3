Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F6FCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUFh-0000oH-1k; Mon, 08 Jun 2026 03:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFb-0000Px-3Z
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUFX-0000Fw-RI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESuLLFwIW6j5JF43r6z1Rimzjac38Z2vjPfM1I49KGw=;
 b=cXO44zyqUjeZW3yw0JNeD4Jdom3NHNcf8viCb/2E4MrX3/Uq4Op7f9N/puM/99CDd3h+xo
 OzbZqlRMDbmE7DQCTmSCBO19zVS59clKmfXgVt3UPYHMWUEZXermRc0//LxG0jyQtLmXhS
 2FsGNfHzjy9nLgnrXU2t3o10SrXPezc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-kGF4x5KPP96Un5fRXMOGSQ-1; Mon,
 08 Jun 2026 03:18:17 -0400
X-MC-Unique: kGF4x5KPP96Un5fRXMOGSQ-1
X-Mimecast-MFC-AGG-ID: kGF4x5KPP96Un5fRXMOGSQ_1780903096
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CD35180061D; Mon,  8 Jun 2026 07:18:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FE8F765; Mon,  8 Jun 2026 07:18:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:36 +0400
Subject: [PATCH v2 18/33] ui/egl: implement display and EGL cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-18-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxL9k6JLPG/oABR6PViMfNyRCylj6p/UCkEA
 IEdk9bF8uKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSwAKCRDa6OEJdZac
 5W0fD/4neJE64iZfAPXS+94MA2NO4r4lQdcjTlWxrsuv5tnslzYwRRAJikP8g+Ovkqb4ca9OLBL
 TE4cHOlWKy+ue+dGpAbpT/Pj8xMcGKqJbaHlHuULkcwOYZ6Qnaj820AlfzjE9cdHwqGefaMd04+
 m+gSNibdrFZrF2RrFwc02jwAfcfhsalIgqxaug1l4hOeHaKwEYpOKGZoL1CiVZriCZfjFeVMGSf
 +SyF6YLpQQpbS4ZmNTXGG50hRs+6BD346ehR2WzmO8n3+6zE2zr9bSOFL/Ta9k+Drl+GInKsbkT
 Kh04hCCk0TSF13k/OZybQqa4/Rrel+ibvSbDWeSaF2PdJ4wgv2QQcLYKcL/RbVzdx1GVPfvFL5S
 HYkgdeIvQWz9hpEBmgUeBhCTfyAEMSA0EbR8m1sheTuH1iCWOJrrNBtcZ8uhs516J0t6cdQqL2p
 VTEk5zsm0giYJveoalz2/VWbtnuQ93lk02/9NkSWayIqs+6ahmsx5ooUN+x732Y1c9GdAlYXRc+
 2CsLFSv+pBUg0LYWvjJS+2ldACmIMoFbgKkNW9T2LQwzOk7Wh4mTZ108STWG+HyiDOlBemdtH5R
 lya9Za2ORt0aZexKGNdWOZ3tofM3nQn2/ItTRRFZQG5LUio00IAqGYac8BCjRlaXR25s4XcJurZ
 zdu8GoCeWXZkWyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


