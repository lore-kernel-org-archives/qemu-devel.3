Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED97FD0079
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 20:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwnjR-0002GP-KZ; Sun, 01 Mar 2026 15:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnjM-0002Fm-Rf
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:49:36 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnjK-0001zC-Dj
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772398156; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fg0wfodT5dTzVm6tKvz72VW0KDQXW1ex9OurY3qkeJz+4ojnN0dO0YIBzrSVL+LbC3kSWHhIFgGYE8zRMhWh/JU1uZgq5s5nekXzPHn3Q6txihxKrWKN1cF6mEcewPxDeu/ea9wzBrptnuXUUvi/HqybxIqXPF/IzCvRuKH2Syc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772398156;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2aGZDYDWXsJHRLsuo8Wciu8joq27z49TBTkmChVpnMQ=; 
 b=eLiL3LBARnaUirVI1V/qy0rxfiR4wv13nf0UNR5oL2MmOW5sFs7/Bj0XMufAeiR2YPbrXHi3SEcDzYMNdL5r9cxS1Feg8MI+KNRSaTceFtdtX4A7yWqoY75L6DiswQ0t0xvgm9MGfzCFui2hyJAiXGB3U4ubnAdElhmnS9FK1tA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772398155; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2aGZDYDWXsJHRLsuo8Wciu8joq27z49TBTkmChVpnMQ=;
 b=ZdPdgvlUyTBxsW659DJvw+YTKI1hZyL0vcvtEcxA3AWyhvht72PQCtdqH0m54LtN
 ruyK6LT9kPSZqAbE8Sf3SfuQAeSk5sZhRuUIciv2AwcaxsQWQOlzHEEW3no1aFnj4wv
 CniZ6arBtDb3Q//nx7yb6h64fRvPjkIYtlb1pM+0=
Received: by mx.zohomail.com with SMTPS id 1772398152817780.6777634921494;
 Sun, 1 Mar 2026 12:49:12 -0800 (PST)
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
Subject: [PATCH v20 03/21] ui/gdk: Restore original context after new context
 creation
Date: Sun,  1 Mar 2026 23:48:20 +0300
Message-ID: <20260301204838.596994-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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
 ui/gtk-gl-area.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c709b2ce0f63..55c2c55ee93b 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -250,17 +250,19 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
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
         g_printerr("Create gdk gl context failed: %s\n", err->message);
         g_error_free(err);
-        return NULL;
+        goto out;
     }
     gdk_gl_context_set_required_version(ctx,
                                         params->major_ver,
@@ -270,7 +272,7 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
         g_printerr("Realize gdk gl context failed: %s\n", err->message);
         g_error_free(err);
         g_clear_object(&ctx);
-        return NULL;
+        goto out;
     }
 
     gdk_gl_context_make_current(ctx);
@@ -283,6 +285,13 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
         g_clear_object(&ctx);
     }
 
+out:
+    if (current_ctx) {
+        gdk_gl_context_make_current(current_ctx);
+    } else {
+        gdk_gl_context_clear_current();
+    }
+
     trace_gd_gl_area_create_context(ctx, params->major_ver, params->minor_ver);
     return ctx;
 }
-- 
2.52.0


