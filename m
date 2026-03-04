Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9854FEF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR4-0003tk-J9; Wed, 04 Mar 2026 11:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQz-0003qE-LK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:53 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQx-0002Q7-Mf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:53 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b936331786dso760319266b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643050; x=1773247850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9djD3xly+1+FURxga6yaG12+NYP55Xt+lHD4jM3mqc=;
 b=yz4KNom+8sohQRSuObEpuXY2BthQj8Pt3JC05exw4a+9U6x62lPxzorskvw+kBwmsw
 4EDnL7s/9lkNDwMAiTM6WrmRLVNXmQKsRayjAsQRXNrg1snfnASyxWuaifyH26IuAY/0
 FKKCAGOodpm0HGfOiU1rS0l973aXhVy2foaLvP42BoNUps3W5ne/kzl3V9xGRDL61Svi
 FaBipy90lH3vlUoL40A1kRhWUnkkwWyHD9I8BL+jhNBEeirCKfpg8UekzVLCPOiqZNud
 u3+nmEnQA2j3iPtrS5zy+qiNlweUkiT82CO/GeSr48xWcHjo7/LOMaNo50EUqv9is2CL
 /UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643050; x=1773247850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D9djD3xly+1+FURxga6yaG12+NYP55Xt+lHD4jM3mqc=;
 b=Or5xlIEzZNBky9hNgWl+sLbW7V28TzKDJOGvUl+xPnT9Y6Yf2DA3t9N2h2/uLPVIw7
 BBdyrqKT0x10nrTnNi2I5rJ4+dINoyT4kiRMdcWRT/IzKCa7r4BT1mHGzUfCLht67jyj
 JQ63mrXLUMv+mukv4ZaShQkdq/MeHW5EoJ7bxjJenlG68nZRmUrXQBpvetEPQp7YRJzD
 0SUX6GZCA3Yy/HHN90JLwOG5Gh1IOJKQS9+6NgkbkZmy9lmXpg4R+6GajdpoiNDF/+sj
 uWVbD82R2GwqWcrTQDcWpNMjtedfCRdqH9zzy3QOwiaEzIALmwSZNqMr49NccOHZVNrI
 KNhg==
X-Gm-Message-State: AOJu0Yx8waTti5niCw8oML4uCtSZCSkeQyotoYJ5ncwnvDzJBSvKdud/
 XNDHDZYkqB+EEfVzZDVG0sL/88YORlkmM9C+BjcGwPTQJIQGfFe0zX9C9W1hblTYst0=
X-Gm-Gg: ATEYQzxNOQ2ghEjgz68Ga3n2pwn7JUN6jBDZ6Q9vr6FjFOEqYpQVGTR2ReyVMbleg9p
 IoDvpMwKkNeMU2qN6q2gA9ezpS8i1gRCdlKIEdjXqVSCLy4r2+ozbEB84VEaQmcHpV5zS/+AKL2
 kMVWLJtdYB6OTluITO1ig2jbKRsTdM5IvTXdHkr6GIovJgQsFto3fJk/oIh4UpV4I3DQTXGCpLN
 vQJr90CaYcyhqo3Lsbp+6r1Qh0xnuZiMHudovH8wUxCWn7/OJKE3P8njTDsQ9lC1UjTV1SuL1yQ
 DYFsVPkF0n065zoiFlUVXGCDhqdamPRjsBYQDx2r0r9Y7RQ3Yh+mY/DNVy5AfKmv8gNs8D8VqO1
 HUBHcwv6Smc3Y3ziuJILSeP+S9e2TymW6jC1UBEf6l7uFkm5u6fjsrAe6ZbQeXhSWAZ5acnps3p
 T+ZH+Umrw04pqPNn4TzX7OCiLM0bW0Ut+CCw==
X-Received: by 2002:a17:907:9618:b0:b86:e938:1b21 with SMTP id
 a640c23a62f3a-b93f11bb08cmr162709566b.23.1772643050133; 
 Wed, 04 Mar 2026 08:50:50 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b93973d3ec4sm558567866b.66.2026.03.04.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 583F362A4C;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 07/20] ui/sdl2: Restore original context after new context
 creation
Date: Wed,  4 Mar 2026 16:50:29 +0000
Message-ID: <20260304165043.1437519-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

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
Message-ID: <20260303151422.977399-6-dmitry.osipenko@collabora.com>
---
 ui/sdl2-gl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 5eca0248233..fbac3edbc09 100644
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
2.47.3


