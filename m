Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A045CCFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 23:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxadk-0004aK-38; Sun, 06 Oct 2024 19:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxadi-0004Zx-2O
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:26:14 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxadg-0006ZE-Fb
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728257158; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AGLf1i9bskkBTqwifd4SRCn0X2O4W4MfWgAfOV4GNM91uTMlznv6RnPoUN3OptT0SIdB1k4uG4yI91O+5MfSJJVUWa/5L7z/qWXDkF1lH7cAG4nWIOQzMvJm9sWVICS/wd54DiC3N+dwD6bgFQyD0oxjtMtVq1j6Ztj3MWy4s7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728257158;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=emNu++YIp5pcQzK2NXHeQWsaZj08MI3rLs0OFZBjbZU=; 
 b=QceoPOTecSyQitadcwmZKeRfs+5GuKGW1xMW0JpxZiSi6nt2X2N1WQ68z+IQG2y6sYm2UFM2IfBqstlQyNFrvY3qyR/MJVIdUueBFQJ994jll6DZhb63WrNQHa/Vy+0sUaIYS+UbRkWABXn4bqdYnolQs9RzpF2f+258odGoSC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728257158; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=emNu++YIp5pcQzK2NXHeQWsaZj08MI3rLs0OFZBjbZU=;
 b=YVYp7fq9Qa1E2fzSDpjH1byA7Xrcro2R4AQEvAcVfwk+jJcJE33Ok0WPTYaeFejc
 YjWBuZhI8Uxcy+wzaUU6I4slan2NwHZV6vCLpa5jMoDDcn24wBn+rwkrVESn2OmG7Yu
 nr4KDBoOqzf/t1pHT9ZAa4BotYRwqdv6Uk1t7o1g=
Received: by mx.zohomail.com with SMTPS id 1728257156801491.626519418362;
 Sun, 6 Oct 2024 16:25:56 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
Subject: [PATCH v1 1/6] ui/sdl2: Restore original context after new context
 creation
Date: Mon,  7 Oct 2024 02:23:43 +0300
Message-ID: <20241006232350.3198759-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
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

SDL API changes GL context to a newly created GL context, which differs
from other GL providers that don't switch context. Change SDL backend to
restore the original GL context. This allows Qemu's virtio-gpu to support
new virglrenderer async-fencing feature for Virgl context, otherwise it's
impossible for virglrenderer to switch GL context from a thread that waits
for async-fences.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/sdl2-gl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index e01d9ab0c7bf..b1fe96d6af22 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -168,6 +168,9 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc,
                             SDL_GL_CONTEXT_PROFILE_ES);
         ctx = SDL_GL_CreateContext(scon->real_window);
     }
+
+    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
+
     return (QEMUGLContext)ctx;
 }
 
-- 
2.46.0


