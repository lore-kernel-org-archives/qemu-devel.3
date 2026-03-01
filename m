Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4BBFD0075
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 20:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwnjm-0002Jj-SJ; Sun, 01 Mar 2026 15:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnjl-0002J4-2K
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:50:01 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnjj-00021l-Gn
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:50:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772398182; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TBEhCUikUOxGwpm2SCp9UoA9PPt4cT7fpBKABx4488JIAXiLKI/25HpITJMoWp8LUwsH2X27kchE4AXalBtn6Bv9yFQjVgHe1/AIQYmB930lTirt5KLkEv31SK8JXqUpK8Qa7aTSXsm2o3pNmXXgkxd4SFlZSAipNSyQ7/VXPD8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772398182;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=knWlQrCri4LBjViO2VL23zwDro6N/a6W7npzXIWzx7k=; 
 b=h0k1aefo3aFwfwfGfFn2uPGYy4jkPh6vvQQ1PwXLNu6Q9Ms92V3NmpiotENqvrUb/2qUK80WRf+rMkzfIRV4/GJaJHeW6ggLudVz7dP0QBRLimqHjGYH6OJFaDwcQ+nAq4SyXzYVOh0t4pOPb08GtmZxTOjlKeKEcy6yiQGUr5U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772398182; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=knWlQrCri4LBjViO2VL23zwDro6N/a6W7npzXIWzx7k=;
 b=Uo8Y5PkhoLf8AdylQw7aozvNV2/sgNtWQA3RkU7HlhraBVNz8GenT+SpdgHX/FjQ
 +1kbcHtUhgB9bE2UgzwXaiqgcQGaswbU62dVuY8Gd1Qe4m538prkKwaJu5xFSBtL7Dh
 aTSCtXHnUiVShmFsq7KhBaPSNWZjHGqdU4dAq6pE=
Received: by mx.zohomail.com with SMTPS id 1772398179208464.1154838573591;
 Sun, 1 Mar 2026 12:49:39 -0800 (PST)
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
Subject: [PATCH v20 07/21] ui/egl-headless: Restore original context after new
 context creation
Date: Sun,  1 Mar 2026 23:48:24 +0300
Message-ID: <20260301204838.596994-8-dmitry.osipenko@collabora.com>
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
 ui/egl-headless.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 1f6b845500dd..c2cb179393c3 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -42,9 +42,17 @@ static void egl_gfx_switch(DisplayChangeListener *dcl,
 static QEMUGLContext egl_create_context(DisplayGLCtx *dgc,
                                         QEMUGLParams *params)
 {
+    QEMUGLContext ctx, current_context = eglGetCurrentContext();
+
     eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
                    qemu_egl_rn_ctx);
-    return qemu_egl_create_context(dgc, params);
+
+    ctx = qemu_egl_create_context(dgc, params);
+
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
+                   current_context);
+
+    return ctx;
 }
 
 static void egl_scanout_disable(DisplayChangeListener *dcl)
-- 
2.52.0


