Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2823AFED9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6A-0002bZ-BF; Tue, 17 Mar 2026 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y60-0002RR-At
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5y-0005cb-5w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQI/w+zr0ImkWaMScB8CdNpb8d18t6S6VN1q82FOZO8=;
 b=As13OvVvsFvRUB7S75OLI1J/wVeHC6nxqwfbfIpxXoUhXiPveZOxNdWFCmsv4Cbs6iRM6a
 Z3GbqklOEeFBmcAgNTTLYH4eUOYUYZFVp7xsLAQ/g2eBd8uh9CvieJ24/UqLz0W+pHbg50
 PX7p5NGD0XvmtFYz8b087s1wm59H1W4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-xOHd23MFM7SdRTFXGMDQpQ-1; Tue,
 17 Mar 2026 13:20:36 -0400
X-MC-Unique: xOHd23MFM7SdRTFXGMDQpQ-1
X-Mimecast-MFC-AGG-ID: xOHd23MFM7SdRTFXGMDQpQ_1773768035
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08BA11956048; Tue, 17 Mar 2026 17:20:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEBDD19560AB; Tue, 17 Mar 2026 17:20:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 11/16] ui/console: Remove DisplaySurface::mem_obj
Date: Tue, 17 Mar 2026 21:19:11 +0400
Message-ID: <20260317171916.438575-12-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Only spice uses it so move it to spice.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260303-gl-v1-2-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/spice-display.h | 1 +
 include/ui/surface.h       | 1 -
 ui/console-gl.c            | 6 ------
 ui/spice-display.c         | 9 ++++++++-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 690ece73801..a382553fa8e 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -121,6 +121,7 @@ struct SimpleSpiceDisplay {
     QEMUBH *gl_unblock_bh;
     QEMUTimer *gl_unblock_timer;
     QemuGLShader *gls;
+    GLuint gl_surface_mem_obj;
     int gl_updates;
     bool have_scanout;
     bool have_surface;
diff --git a/include/ui/surface.h b/include/ui/surface.h
index 006b1986bb9..f16f7be8be8 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -22,7 +22,6 @@ typedef struct DisplaySurface {
     GLenum glformat;
     GLenum gltype;
     GLuint texture;
-    GLuint mem_obj;
 #endif
     qemu_pixman_shareable share_handle;
     uint32_t share_handle_offset;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 22e9787c415..73be35c1fc7 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -185,12 +185,6 @@ void surface_gl_destroy_texture(QemuGLShader *gls,
     }
     glDeleteTextures(1, &surface->texture);
     surface->texture = 0;
-#ifdef GL_EXT_memory_object_fd
-    if (surface->mem_obj) {
-        glDeleteMemoryObjectsEXT(1, &surface->mem_obj);
-        surface->mem_obj = 0;
-    }
-#endif
 }
 
 void surface_gl_setup_viewport(QemuGLShader *gls,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 5052f371f44..87cc193cdee 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -950,7 +950,14 @@ static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
     } else {
         surface_gl_destroy_texture(ssd->gls, ssd->ds);
         ssd->ds->texture = texture;
-        ssd->ds->mem_obj = mem_obj;
+
+#ifdef GL_EXT_memory_object_fd
+        if (ssd->gl_surface_mem_obj) {
+            glDeleteMemoryObjectsEXT(1, &ssd->gl_surface_mem_obj);
+        }
+
+        ssd->gl_surface_mem_obj = mem_obj;
+#endif
     }
     return ret;
 }
-- 
2.53.0


