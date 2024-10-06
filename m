Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E62CFB441
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 23:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxaw5-00027R-Iv; Sun, 06 Oct 2024 19:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxavz-00024m-Sc
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:45:09 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxavt-00086W-Nn
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728258292; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=i9ilvuxdzlPjRdwq1uFjilY/aCwAK6PhMkw/mnC62v0VAfBIbD+QqAuQUGRo2eq1MYKUuF6aUd7ptDW07RxSclxasZ6BPe1IBSycOIG8WxtPCywwhoxfIfgwcMcHOugoMTSMbVf+C8afbFk63eyHfGUbTIWFG6Wf+uNJuaLObsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728258292;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WmH0g9uXaTATJwwc+jZZxbH6AdRXlW8CeEtxhmUnXpA=; 
 b=eUbgcnHOKA7h9U+jLjnNUXjc2O6KaxOLD5JW47XKwzPQoNnMMYuv4I44NTmSIufM2GanvrqCWFRN4v7AqPlYfmKtRMA6Tj/beirAJSYsL7S09Wy7OWip2hckRHhx45ovHem4wCFUNq1ZB+MFSC1tPX0TsWJxV+Sw/3PzojvWLqU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728258292; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=WmH0g9uXaTATJwwc+jZZxbH6AdRXlW8CeEtxhmUnXpA=;
 b=Zg6/F1yx5zey7P3nSggNai6VI0QrkurL+yHRm6mx82w8PkszofzQ3sn8jzWDhpOl
 A5lq4VjX6ZYOc2+5mbtvzjZ7Xm4pgx7GMXtIssWXHVgpjUlxsIM++Xqu6J1X8sjuSlx
 97lIIz0Qy6J2HKw5iyXJjo+/F0GNKtGCygsbpZJw=
Received: by mx.zohomail.com with SMTPS id 172825829083773.62333018968206;
 Sun, 6 Oct 2024 16:44:50 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 1/2] ui/sdl2: Don't disable scanout when display is
 refreshed
Date: Mon,  7 Oct 2024 02:43:52 +0300
Message-ID: <20241006234353.3201037-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
References: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/sdl2-gl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index e01d9ab0c7bf..4975d923db38 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
     int ww, wh;
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
-    sdl2_set_scanout_mode(scon, false);
 
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
     surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
-- 
2.46.0


