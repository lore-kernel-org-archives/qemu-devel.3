Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0417CFD0079
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 20:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwnjf-0002I8-Eh; Sun, 01 Mar 2026 15:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnjd-0002Hh-88
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:49:53 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwnjb-00020g-8M
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 15:49:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772398168; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aVu9l0hRZ9oJmvHkSwtAY73A0nFk21jfoPxipkcLHCiPplss18GpW3oVUIo/baFh5A/dfnmpP0nrwR+KguyWd/vsFfpHcRaGKuQSIGN66QrNBZ+VE/5BxJT1YVFq+y/nUpe9CtPKsaelNkckO+hiIotiSo17Rkgi8ekl1ilBAqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772398168;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b9DUeFEzlsXB6JR3qsoQH+lKifZP0zu1ykTE7vxMs+8=; 
 b=VIs9yQxjdLLZxJgNICtdpaa9HFH3zPaJXCuq80bqSS/eNyxJyW2veOZ33UDmxH8ZLMcb9lnJ4rcjoWvyozxLU9Tos4XhW9DWH6D77wZ714Wy797ReyEVySrUxrdr5e0r0M3sdMta3RmqXdD3jCWfHb1+bTYpyGIFxmXdrhdAtdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772398168; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=b9DUeFEzlsXB6JR3qsoQH+lKifZP0zu1ykTE7vxMs+8=;
 b=iKAd5OgBPsoNq/pPEkc5uuqfleFMwTkVxLQ/lM20u4CNtjmp5HQoVyh2lLaeR/+N
 jKHcJldxNwdlGx4uqaIcZuPei/3cXj6BhVl/zdbBVdEEHLkpEcL83DsvlBG+6YqwfYb
 LcDN+seX7V3jHfWUKseykbqbTw6O7QN1FMMcN1LQ=
Received: by mx.zohomail.com with SMTPS id 1772398165761852.2134488240242;
 Sun, 1 Mar 2026 12:49:25 -0800 (PST)
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
Subject: [PATCH v20 05/21] ui/sdl2: Restore original context after new context
 creation
Date: Sun,  1 Mar 2026 23:48:22 +0300
Message-ID: <20260301204838.596994-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

SDL API changes GL context to a newly created GL context, which differs
from other GL providers that don't switch context. Change SDL backend to
restore the original GL context. This allows Qemu's virtio-gpu to support
new virglrenderer async-fencing feature for Virgl contexts, otherwise
virglrenderer's vrend creates a fence-sync context on the Qemu's
main-loop thread that erroneously stays in-use by the main-loop after
creation, not allowing vrend's fence-sync thread switch to this new
context that belongs to it.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/sdl2-gl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 5eca0248233e..fbac3edbc09d 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -139,10 +139,12 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
                                      QEMUGLParams *params)
 {
     struct sdl2_console *scon = container_of(dgc, struct sdl2_console, dgc);
-    SDL_GLContext ctx;
+    SDL_GLContext ctx, current_ctx;
 
     assert(scon->opengl);
 
+    current_ctx = SDL_GL_GetCurrentContext();
+
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
@@ -167,6 +169,9 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
                             SDL_GL_CONTEXT_PROFILE_ES);
         ctx = SDL_GL_CreateContext(scon->real_window);
     }
+
+    SDL_GL_MakeCurrent(scon->real_window, current_ctx);
+
     return (QEMUGLContext)ctx;
 }
 
-- 
2.52.0


