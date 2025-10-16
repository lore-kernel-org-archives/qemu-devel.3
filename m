Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FDACCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWa-0002Cn-CH; Thu, 16 Oct 2025 11:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWY-0002CG-U8
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWR-0001AY-1A
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47114a40161so7110995e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627043; x=1761231843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJpyoRiL8sYez2Vw3+8NSwXbVIlyqCZS+tzmsklFGkI=;
 b=cWkKQV3XM3/y8cLgwt1KP/BM/SEuAnLpzqq4NtjB4azQUwXrzJ7jHTOXg7NwIAcvZh
 l4/k+7iiksE1/FHT9tgesV8pyciTi8HHNDKMqnDzUPtDr752lbo27IfS+LCEj1L9S1bO
 TDJzFMq6nv7MRzMt+p2KutGFA5coPMhzZgA0Zq0MVwzltE7uUQhqdDbIvO6KdSWRMOVB
 svkYp8ID2Df0jYKzvf1AaRjQtFWIY/Ktxk32UMK19sCTKRUEtiMnIYXdt/kco5Q74B30
 H1o0xikNhtW0JoI7pRYv2A/ZTbY+f5WL5NFweoxuTJnRGMyMgKKaIUBMjPTZkcwFzIXc
 4vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627043; x=1761231843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJpyoRiL8sYez2Vw3+8NSwXbVIlyqCZS+tzmsklFGkI=;
 b=rt3it2ztLcmKH8oSB/KcvDNjrkGY5zhJL6cCHqt4KwWk9OX/nLMjgDRLh4Vp4hpmig
 bdWLh4vQN9EZVvVc6CxiAvinLxcVIW6cPzjZhmTYTvnaHirRKelId+FdZivJQ1KkD6TZ
 +6Xm5CWDnbfXv5I5u69WCQw4Fvl+vD6GWRz48dKuVc0daVvmttq1vxAobn1VWRNAh3mK
 uXpPAmdrVvgynG7trCAl+SziOpP9OgTZix+rzQGdAa1euXrX/GfGvZtxJMJNuXXN3XLk
 U6VCi/7hr1GQvG6g7EHfs7z+zeBVAVWkA5PQrZZ8mn8AdU33TSrGIJtRqfX2m1YN5983
 b4ZA==
X-Gm-Message-State: AOJu0YyiT6Qs97GSwycjJUxIlVKAsvxa3y4enRZibyaA9Ep3TYXcmI/7
 kH//Rqfwp9KSHYOL7uATeOV4WblWPJto168PXAHO6Xcz84wc2nZWGk6MANChedooFvQ=
X-Gm-Gg: ASbGnctIP5E5nuH9LBzaj7vGAo+tBYWO1LfeUIlS3QTDjTaWlB1ezaVrX+Ob/Vr5sOA
 YrTNdH1UUP86e7EMgqZFc73JNZuDSrf/mgOfPi9D4fGlHl9gR6L+K4VkIkeZniGx0ZqMZzLyjXl
 YPHMtj5P4LJz04jfpH4CIQWZlcZyEwzPRWZS7usgASo/8JOy46eEaFRzb+lFgvQvqqcu8QrDzj1
 XPM/ultbroGVRPdCW300ytbUsOijRAqHL6WCrxIV8td5ThrE/7taRegT8ZdVSxfTDcuN1ES144L
 aBqVkpOWSyj3GlSV5W+LV1pLqkN1un1ZNDNCqCSMNdIQ/ENlGTNUNbhxLCk2Xvqc5wgeoXeaaGJ
 IMu9igcKlT0Nm2l8DuP5tIDi0waqcCKW8b0lygEwo6KaWrMvoMT2HwlqcYtK41cUywJgA6+JLE3
 EKtBkbqVdwE/M9l7g=
X-Google-Smtp-Source: AGHT+IHdw34NJ7JAA2SgB5l3oeY5Tn3bu4IE+sgGv9Tb29cCrBfcVdrvtYBvYQH8XBqrJZaoTselFQ==
X-Received: by 2002:a05:600c:4ec9:b0:471:15c1:45b9 with SMTP id
 5b1f17b1804b1-471179133b2mr2482055e9.29.1760627043091; 
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d015esm36294984f8f.33.2025.10.16.08.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB33A5FACE;
 Thu, 16 Oct 2025 16:03:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-stable@nongnu.org
Subject: [PATCH 05/11] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Thu, 16 Oct 2025 16:03:50 +0100
Message-ID: <20251016150357.876415-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
which causes some guest display corruption when gtk-gl-area
is used for GTK rendering (e.g. Wayland Compositor) possibly due to
simulataneous accesses on the guest frame buffer by host compositor
and the guest.

Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org

---
vpre-PR:
  - added large comment where draw command was removed
---
 ui/gtk-gl-area.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 05fc38096ec..cd86022d264 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -165,7 +165,22 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
+        /*
+         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has already
+         * been submitted, but this function does not call gd_gl_area_draw() in
+         * such a case due to display corruption.
+         *
+         * Calling gd_gl_area_draw() is necessary to prevent a situation where
+         * there is a scheduled draw event but it won't happen bacause the window
+         * is currently in inactive state (minimized or tabified). If draw is not
+         * done for a long time, gl_block timeout and/or fence timeout (on the
+         * guest) will happen eventually.
+         *
+         * However, it is found that calling gd_gl_area_draw() here causes guest
+         * display corruption on a Wayland Compositor. The display corruption is
+         * more serious than the possible fence timeout so gd_gl_area_draw() is
+         * omitted for now.
+         */
         return;
     }
 
-- 
2.47.3


