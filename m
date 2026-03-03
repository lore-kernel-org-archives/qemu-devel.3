Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DC6EDA687
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRUx-0005Br-VA; Tue, 03 Mar 2026 10:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRU9-0004sh-N3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:16:44 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRU6-00055U-AB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:16:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772550968; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fsDjL3Xg9LagPB+O/NJ3Nx0TI7aZcYWq5bIk9PFqx8mpINroAc20XaM96vQN0h3xWmJWCgu4soYYKnFDBi6Y7quyg9/c5uEydF+zac1w4HwNVBHZsm+B3RcxVQhsVG6Tra+UX76viCa1STF0+6ErEBv8oAV9TQFInuEHrXydk3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772550968;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=niyYgQGaryUtB9WABCvYoibdRU+LTyVDwSsSyGa814I=; 
 b=jzjBOXlyepX6qibibNArV2KD1lhNmkQ66taLYNcJfxKw8B0Fr8JCpyj6syAidxmRYJlCKMZf5g/ISJE6AaFDYPpI/kKd1wRQLOYii97xHiFOsroiiDRsSZ3KUL+yIW8uUZR8waVSnqq56+C6XU6cHWB5XdpVzFOgShkAfftRvqc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772550967; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=niyYgQGaryUtB9WABCvYoibdRU+LTyVDwSsSyGa814I=;
 b=kM70q81/2LSyny1qZ39FICJmcodpapFYnPJcFE93QuRr+UlJH+MjDh4JZJABmwru
 oCyIYtEGKOJOwTNM7jYMcNv8S8VK/J7XgMmHRmhZ8fuJCtqWuplxlwDJ+AenAo6u7VU
 Im/GCzID8Qi8OzeMvHVJeye8EE+SuDC7ShpUnCIY=
Received: by mx.zohomail.com with SMTPS id 1772550965474282.4726872821975;
 Tue, 3 Mar 2026 07:16:05 -0800 (PST)
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
Subject: [PATCH v22 04/18] ui/gdk: Restore original context after new context
 creation
Date: Tue,  3 Mar 2026 18:14:07 +0300
Message-ID: <20260303151422.977399-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


