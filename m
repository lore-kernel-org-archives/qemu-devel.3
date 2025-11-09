Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E84ACCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI8bb-0001aV-Sq; Sun, 09 Nov 2025 11:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8ba-0001ZF-2Y
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:30 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bY-00009L-IC
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762706955; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ieDZk3vnkblNmA+qvUMr1xtztiKsl3HabV7ouM0tx8UJqW6gem4oQMPpBfARXV8Ujrinmsj2hsOG1oNxgMXzgEouGzZGZJ1XU6V/SPrtXfN2FobPRKjfRLDkPo4UxcjG4ksutjLDDcEBdIt0qrtgTQsm7YiBSwhg5Vmt8nhGVLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762706955;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/7w8ta1DWV3a2bMv4C7H1+A7BzR2CHXgSqChY/0pPxo=; 
 b=CQ1u3l+8Xx/aDkseNkI1vDV7b1quhDr613Cm/d1zoxQkvw1gOGvLmVaYvvcOj8CdHuQk1J5Kq5piEt8zjEOOF59ObgSLPFcdThM2itoN93cBMPlI35OfDjBRLlUSpmS1S0yY/EqaHXf2e2aid0qNczCigmpit0rebVm1MWubnVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762706955; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=/7w8ta1DWV3a2bMv4C7H1+A7BzR2CHXgSqChY/0pPxo=;
 b=ioOZKIbgxAHhLHd0IgSJk4WeCXcFOlaojivX3+einNMR3eLnUbRKkSAN0wZ/0kqm
 Gm89k+iukGdHPIJ+GMS2BM/1rH4dgL9XLGDWunl+Pw2S8WvcaT0eEWZ1YeiBbyVy+dy
 Zq9n1JtfTPuBfZbwDTmamV4mc+gEkG9n88AYIe/o=
Received: by mx.zohomail.com with SMTPS id 1762706953193899.8269825088538;
 Sun, 9 Nov 2025 08:49:13 -0800 (PST)
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
Subject: [PATCH v15 06/10] ui/sdl2: Don't disable scanout when display is
 refreshed
Date: Sun,  9 Nov 2025 19:47:07 +0300
Message-ID: <20251109164711.686873-7-dmitry.osipenko@collabora.com>
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
 ui/sdl2-gl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 4906f6875046..d8e5e0a3642c 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -53,7 +53,6 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
     int ww, wh;
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
-    sdl2_set_scanout_mode(scon, false);
 
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
     surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
-- 
2.51.1


