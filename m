Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D0CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 16:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI8c0-0002A1-FU; Sun, 09 Nov 2025 11:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bh-0001cA-Ma
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:41 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bg-00009u-5k
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762706963; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xoc0vdr2vUKXjj7VsWKY4BV2ArFov9l7aAJBsCoAAGsJRJ/yg9rKpFLCUyrBMm9m/Wc1gRBokRdn9mbH5MBgtUVcA6kq2ytZUuTxEpjyzOtC2L0f0jaKS26xsVz7MwUVf3Jv37Qrf8avj8eTd4Q8ZrUeSTsr23GID97UJceYqz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762706963;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Kbq5j4g3EVatJbKy3t91p/JVim8cEGBRZ828mqbLAro=; 
 b=lGbJM8XQOS4yRBvtRSSnR/sjnK5zLh+LrhJiZMjC2L85F5YSneL3L1cui3iEcWvoz91BTWZaX9UeuQaJNUbhdoX/efFM6MVPEz0HGHhc5+sNDajHEdRfnVdNxrtqhy2fyzY5k/EjAw/lBgkOoef4BfFswaRLxWg3CjHxZ3kjNwo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762706963; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Kbq5j4g3EVatJbKy3t91p/JVim8cEGBRZ828mqbLAro=;
 b=VZODouM5W6eT5kILuQ2SE3JcLr7eUFTjFXD0s11d/57E0RsGmA2t6tgsHuCEZPJH
 vAuVTB0i5FQoRkWKxx47zEJ7emBpAs4GuAoD3S9LYtWWmG5/Y0AIW3OSqfG/rFXy5HN
 OepVpi4xueHYd1fZ3/3SyrNNiz1cO6s5tXXk5DC4=
Received: by mx.zohomail.com with SMTPS id 1762706960556808.2441987952313;
 Sun, 9 Nov 2025 08:49:20 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v15 07/10] ui/gtk: Don't disable scanout when display is
 refreshed
Date: Sun,  9 Nov 2025 19:47:08 +0300
Message-ID: <20251109164711.686873-8-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109164711.686873-1-dmitry.osipenko@collabora.com>
References: <20251109164711.686873-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Display refreshment is invoked by a timer and it erroneously disables
the active scanout if it happens to be invoked after scanout has been
enabled. This offending scanout-disable race condition with a timer
can be easily hit when Qemu runs with a disabled vsync by using SDL or
GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
content shouldn't disable the active display. Fix it by keeping the
scanout's state unchanged when display is redrawn.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/gtk-egl.c     | 1 -
 ui/gtk-gl-area.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999cdb..0dbb429958e5 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -180,7 +180,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_egl_set_scanout_mode(vc, false);
         gd_egl_draw(vc);
     }
 }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d264a..c709b2ce0f63 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -199,7 +199,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_gl_area_set_scanout_mode(vc, false);
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
     }
 }
-- 
2.51.1


