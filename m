Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D4E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSzV-00009S-0a; Tue, 17 Feb 2026 16:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsSzL-0008RL-TA
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:52:13 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsSzK-0001Qw-Em
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771365114; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=juK3r2mCJtv1J8ECob+pSdAM1+pepwwUfmWID0gbSwIr2vw0jocAKD3uzUsXGVnjCXmqjMrUCjVzL4ghZ4JtbSJ15bQ8IVlD7lvCsOuOcuigO3yk9WLhlHoJlrDcJNqnT2XuMUAtla1J/jEnqyHWPcNjk/6yAN2Adn7qsiHBCB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771365114;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qs6jfH0eQ3bT7CeN8lKFGApCsyrxW7Kw8JNJtb9BGrc=; 
 b=F4ovXO2whtf9AHRZeuXFn3xEiMyLdpDqMCiCf/tRcjftxViZThXt8rxyqvBiSCe9zZlaBZWaG6Evoo70fMQXMfnJzM95JgVd7gK90q2/uHYkuk40sZ27DcyVj+m2prWX/X8JSMZ7IX4b9THS9XRrzxphyZV0y0oVGWFwVdFAZN0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771365114; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=qs6jfH0eQ3bT7CeN8lKFGApCsyrxW7Kw8JNJtb9BGrc=;
 b=OHSEGmzYp4ocFgDlJwfnvyjiFHlY7YIF7C1xdLUNgLE9+1lTx2SxmFXxXoC4aVcH
 2+f682R+7RRbY/1nViy7eaZm6kbVZUY7IONzS41Cd1J5wASqWSgrD92PRX3eSvlIqAg
 xduS0yTYBycE3bD91k4npSyRaq2G2ODy52UC/kY0=
Received: by mx.zohomail.com with SMTPS id 1771365111787357.61501342480994;
 Tue, 17 Feb 2026 13:51:51 -0800 (PST)
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
Subject: [PATCH v18 06/19] ui/gdk: Unset context after GL operations
Date: Wed, 18 Feb 2026 00:49:15 +0300
Message-ID: <20260217214928.2970885-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
References: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VirtIO-GPU commands may be processed outside of main-loop, from a CPU
thread. This results in GL context switch failure because context is held
by main-loop thread when GL is invoked from CPU thread. Always release GL
context after performing GL operations such that other threads could take
over the context.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/gtk-gl-area.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c709b2ce0f63..4d8ccb605f17 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -140,6 +140,8 @@ void gd_gl_area_draw(VirtualConsole *vc)
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, pw, ph);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
     }
+
+    gdk_gl_context_clear_current();
 }
 
 void gd_gl_area_update(DisplayChangeListener *dcl,
@@ -201,6 +203,8 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
         vc->gfx.glupdates = 0;
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
     }
+
+    gdk_gl_context_clear_current();
 }
 
 void gd_gl_area_switch(DisplayChangeListener *dcl,
@@ -227,6 +231,8 @@ void gd_gl_area_switch(DisplayChangeListener *dcl,
     if (resized) {
         gd_update_windowsize(vc);
     }
+
+    gdk_gl_context_clear_current();
 }
 
 static int gd_cmp_gl_context_version(int major, int minor, QEMUGLParams *params)
@@ -325,6 +331,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
     gtk_gl_area_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
+
+    gdk_gl_context_clear_current();
 }
 
 void gd_gl_area_scanout_disable(DisplayChangeListener *dcl)
@@ -378,6 +386,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
     }
+
+    gdk_gl_context_clear_current();
 #endif
 }
 
@@ -389,6 +399,11 @@ void gtk_gl_area_init(void)
 int gd_gl_area_make_current(DisplayGLCtx *dgc,
                             QEMUGLContext ctx)
 {
-    gdk_gl_context_make_current(ctx);
+    if (ctx) {
+        gdk_gl_context_make_current(ctx);
+    } else {
+        gdk_gl_context_clear_current();
+    }
+
     return 0;
 }
-- 
2.52.0


