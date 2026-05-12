Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E156CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuVp-0002sX-3R; Tue, 12 May 2026 17:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVY-00029s-0e; Tue, 12 May 2026 17:19:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVV-0007un-Ee; Tue, 12 May 2026 17:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=KcCabwFzWrmO66mf9hxZ+26dvO/eGo3AO/wddZXfZCE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MO9HmS7yQNuox9LDLWHdBzA0fmi7rMWh0hHdkapFq8crPKlzm7cgFZFcygnUnPaXv
 lTdBMS+bWu4cka+v6VipBnVyP5yNUQs6gPyBuZppWmjoHE2mnoa29HY9mCU5dtPCe4
 HP2Kz2O0pKaUOBd9moQReGRbhzeUjIHs4hryaVTvQ1Tb6nQ/v/ZLd3wuBoMv0wpPFk
 8nuK9kgxbkGudkRfOH6uMZ9PdotJchnEJzXMic6pONeooPfx3k1HSiNZXcigtxvd+a
 q73/zuz/F6kY5ksv+1NRaaapsowf26qSWNaGoN3w6tyEjRuaEFeQIRaQrdbh12X0l+
 HERrq0OMHVeMA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F4A51AA3D6;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AC4FB3ABD2E;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anthony Roberts <anthony.roberts@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 11/58] ui/sdl2: Fix assumption of EGL presence at
 runtime
Date: Tue, 12 May 2026 23:57:32 +0300
Message-ID: <20260512205820.361821-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anthony Roberts <anthony.roberts@linaro.org>

The original commit had a section of code which worked on the assumption
that if OpenGL was enabled at build, it was present on the end user machine,
and calls could be made to it. This is not always the case (such as Windows
on Arm devices).

This line should have also included a runtime check.

This commit moves the relevant line to inside a runtime check for OpenGL.

Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
Cc: qemu-stable@nongnu.org
Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260409110256.684-1-anthony.roberts@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 7077c83f71a7530af5d93748e998b00732f6fb36)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aaaede56e0..987ad334bb 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -120,15 +120,15 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         scon->winctx = SDL_GL_CreateContext(scon->real_window);
         SDL_GL_SetSwapInterval(0);
+
+#ifdef CONFIG_OPENGL
+        qemu_egl_display = eglGetCurrentDisplay();
+#endif
     } else {
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
 
-#ifdef CONFIG_OPENGL
-    qemu_egl_display = eglGetCurrentDisplay();
-#endif
-
     sdl_update_caption(scon);
 }
 
-- 
2.47.3


