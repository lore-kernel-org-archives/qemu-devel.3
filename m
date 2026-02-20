Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E3C531F3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 00:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtEG0-0005dU-78; Thu, 19 Feb 2026 19:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEFy-0005dM-So
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:20:30 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEFx-0004oc-5m
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771546813; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c/qFjv0hkv5iDB93zQv34QfiknqMjvThjgjKNBglBk+lwe0Ipkr0d6CocBPO2UDeOTQUHbG7Qv9LPMbS+AXis2GJdMR41jRl6EMm5r/FwXQEc7lpwD2luyHlKUWTWqfv8Dwza0kSihmhfuwp8WphazS46JVmJ5UEqA4fv0Qy1Nk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771546813;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5t2EuLg4YASqUONs0Cvc9VJYOprJt/+1BkZslrnN450=; 
 b=BXVBYqil+hTzg4b/jlwZfywLsT+72SJO5yjPvMulQOorKcxqz/rHd/ZNc5XxQlz5vxG8MOxAwAEt5YBUtwUC6LODx4Xvsh0dcrGaCYD3Enz6mLdRd60uStbB2vZkGjDvBK/Rx0Eh9qzBOvo+u066KHviAcv+L1/jzfcpVxEcq5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771546813; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=5t2EuLg4YASqUONs0Cvc9VJYOprJt/+1BkZslrnN450=;
 b=QI/ly1DI8EHRpjiJSgzPB0Vi6W8V9k0D+NQRJsOSkGMlHW3JCt+UnAox7KWG3I8d
 h/2DAP6DdZPVhQuQFwP56w/s11fSir5oP+wFCCx0RybuvZhGaVqk2lTZAM+a2KODe8F
 kXhRPP8iyNlwbXqApigtXJDEHjZqiqiOmSVU5OlE=
Received: by mx.zohomail.com with SMTPS id 1771546811498479.6979513463026;
 Thu, 19 Feb 2026 16:20:11 -0800 (PST)
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
Subject: [PATCH v19 01/20] ui/gdk: Restore original context after new context
 creation
Date: Fri, 20 Feb 2026 03:16:15 +0300
Message-ID: <20260220001634.3579257-2-dmitry.osipenko@collabora.com>
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

Get currently bound GL context when creating new GL context and restore
it after the creation for consistency. In particular, if there was no GL
context bound when gd_gl_area_create_context() invoked, then GL context
will be unbound, which is important GL housekeeping detail because GL may
be performed by different QEMU process threads.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/gtk-gl-area.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d264a..fb783db3042d 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -251,11 +251,13 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
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
@@ -284,6 +286,12 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
         g_clear_object(&ctx);
     }
 
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


