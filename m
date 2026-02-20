Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45796C531F3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 00:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtEGP-0005ga-Gy; Thu, 19 Feb 2026 19:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEGO-0005gP-9E
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:20:56 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEGM-0004q7-8M
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:20:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771546841; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MIwODHqL2UObNXNyvDrDCuv8Kn8UbvPbTAFMGCB9Vzan2qLS7OIHpU2dxemKUqSF4iSxWa2RCMFycuI3Rg4KBYahjRPikGiU33OC3Yg9HlrhtcUIQylIXlweyO1ISLFaZfpRGNehxZPbrgvVf1XXqvg99IsqYAPZouWuD9uzjrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771546841;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KH6RbVdR7TRGnJt82XXSV4vcKVJ5XAqQetShwPY04x0=; 
 b=P90/tua9IDXZ8dkrh3oys4z0j4DepVWJPN1cpPxUIf4rIwgbHRlVpdtX3SMXH2qo0eOre7d2N1T1RRO8NJ/Jwj3IgS2CN+lfufpOLTbtzEPav5rl7JHx9p8VxsN6dZjFZhJBScrGQZ0CmvP9KkPOPr1YReyqbEzhqZtNK5tLeQ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771546841; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=KH6RbVdR7TRGnJt82XXSV4vcKVJ5XAqQetShwPY04x0=;
 b=NZ5xEcPoVwghf4vgfY6CS+7m57mROl4VGO9hW1miKqBCEmd+TqNfqoP3GriLWDwd
 +gx+3g7No694nQwRPL92zXBLbZTwX9ZXS9b9HJ/yI/ooRdnUa03yttpZkQC39dIH75m
 VqHVnLcHD2q0GDrd8Hh+aO1HZ3U3K9WXPG7Pg6cI=
Received: by mx.zohomail.com with SMTPS id 1771546840371175.20593544472672;
 Thu, 19 Feb 2026 16:20:40 -0800 (PST)
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
Subject: [PATCH v19 06/20] ui/gtk-egl: Unbind context after GL operations
Date: Fri, 20 Feb 2026 03:16:20 +0300
Message-ID: <20260220001634.3579257-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
References: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

thread. This results in GL context switch failure because context is held
by main-loop thread when GL is invoked from CPU thread. Always unbind GL
context after performing GL operations such that other threads could take
over the context.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/gtk-egl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0dbb429958e5..157b000f45fb 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -39,6 +39,8 @@ static void gtk_egl_set_scanout_mode(VirtualConsole *vc, bool scanout)
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
         }
+        eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                       EGL_NO_SURFACE, EGL_NO_CONTEXT);
     }
 }
 
@@ -125,6 +127,9 @@ void gd_egl_draw(VirtualConsole *vc)
                         surface_height(vc->gfx.ds));
 
         glFlush();
+
+        eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                       EGL_NO_SURFACE, EGL_NO_CONTEXT);
     }
 }
 
@@ -261,6 +266,9 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     gtk_egl_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
+
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                    EGL_NO_SURFACE, EGL_NO_CONTEXT);
 }
 
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
@@ -277,6 +285,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_import_texture(dmabuf);
     texture = qemu_dmabuf_get_texture(dmabuf);
     if (!texture) {
+        eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                       EGL_NO_SURFACE, EGL_NO_CONTEXT);
         return;
     }
 
@@ -294,6 +304,9 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
     }
+
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                    EGL_NO_SURFACE, EGL_NO_CONTEXT);
 #endif
 }
 
@@ -397,6 +410,9 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 #endif
 
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
+
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                    EGL_NO_SURFACE, EGL_NO_CONTEXT);
 }
 
 void gd_egl_flush(DisplayChangeListener *dcl,
-- 
2.52.0


