Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D479FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybCd-0004LD-Iu; Fri, 06 Mar 2026 14:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCN-0004BL-E1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCL-0000QG-3u
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so112134085e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826654; x=1773431454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPkKXJYX4SKRB+WSPLR+a/LvTfT4xEY7xvivBzryjps=;
 b=nMVXj6q22f9qsEm8fchzugtA30fbCK/wTvh/mFI32rBxMasbQ+osXwRa0UoN8j4hG9
 7zmZr1GH1BmyMa/acMmi5hS6/h6ahjW54cDls/KSCws5dALUnA5H4Dlmj3CvckPlFy9Z
 61l0Nx1/scTenJJJfHl08JPCzzQOr6br7Ulv/aSs7o9ZKiIVuKVZbWAqTLxKrq1W+wAi
 Ygte1azwyB8ldi7qyUet0NaYM66eQ9H4kzPatjlCSvMOTzUNSWGA+jp1iQPagCSQ8aEL
 8bo8htofMeFZAOKd02So0Mz8o2MRk3zM25QJV/5IHRd0g01DBunRhd/5xDLm9pMqxbXV
 7GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826654; x=1773431454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gPkKXJYX4SKRB+WSPLR+a/LvTfT4xEY7xvivBzryjps=;
 b=wiDeWcCigtYYSNrzvLX2w33dpEGSznvxcRgyP1of7tYaibmHKOST8Qms9m3+wL0jM7
 WNvE55ljKksy7xl1hip4A94GNQ1CCJA4qEYmtjTqJeQqqOGX3dJ2QPWcdoZEinC9Yijc
 GtO7momtiwu/1ioLYiUgM0+whOuCAJXITCxNYjag9E+xSw8rtY+cCeQr34IxDd1ZToTK
 Djbrb7rfqnyNnYGjanN961KF8rcA164nmZNmqrxynld0WLhSQjS3Pxx/HYwerchh6eyv
 BYlR3/IxdvFjXRI6Vh4DYFtut26NWB7zCVPTcdUrizXPUXhSUOFNBiiLXk/gwn8+kjGc
 XFeA==
X-Gm-Message-State: AOJu0YwEgCiMJzXsn54BpxFwVl8roomIXXMDtHsOlN5FNfMzwyik+CfG
 YGnNJQ8HloFCRHl5lTDX3TQqrRJ0j5R/47DOpzWNt3yj3dz7gELhbz1wUaUFjDJGsLk=
X-Gm-Gg: ATEYQzzftdDQNXdx/NeouRAVcPRjB+bRnRYWSGFXBT8qN6CqFiIOjIholesYdDMbmx+
 afjzrE7kF+mnfYMhD2HRos1btAEO7d6PR80uJhSGtLsKMBu0I84dXaac98iTlhkNLjeG7aF5QDI
 akoRLCZWytqootOz9/zq0z9rsRNvxvnfnFxe/CKSaFmxQEi6pGWKqldB+zF7w0zUjeg2fcNXwMH
 /OMdA6rQ/SWp9fE+jLoOAdnuFta+hvjhvW+/qMmq9Y6z7qg7q88AVvyA202IJIR7Kjveyv3Xi8v
 JW3QAXZuNe/P3Hjm0UCD5sz3fpr2czNQP+5+6iulZ8WvLbqSdU0l9pcHxIFihjzniSt2LPNb/aA
 gbQ91nWL+HmQ28u5kCkZ+LRjWtn9I00EuCs42JhMPVx28VncW79YeZJtDZ3i0D2Rd4Ue9OyEB/P
 /MykIPlhC7MWTf6apa8cYKecQ=
X-Received: by 2002:a05:600c:3acf:b0:483:6f37:1b33 with SMTP id
 5b1f17b1804b1-48526978d48mr58668425e9.30.1772826654070; 
 Fri, 06 Mar 2026 11:50:54 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686fa9sm72936415e9.8.2026.03.06.11.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C5FA689D6;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 07/20] ui/sdl2: Restore original context after new context
 creation
Date: Fri,  6 Mar 2026 19:50:34 +0000
Message-ID: <20260306195048.2869788-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Message-ID: <20260304165043.1437519-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


