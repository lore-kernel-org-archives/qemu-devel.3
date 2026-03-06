Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBB6FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDM-0005wz-TO; Fri, 06 Mar 2026 14:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCO-0004Cb-I7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCM-0000Qe-28
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso5061965e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826656; x=1773431456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39GedOA/zhD2INkZV87nF0IgHSvIChHEdqlmVOM0ds4=;
 b=TO6XF65gb8NOVPw1XJm2imnnKAbPKG2jTyz/fCkJT8vDTtwiYtdBLu3g1/KXvVoHds
 1rybxKbaAxgGdqgyD2O1u1JU2/WpnhkqIWFqMpvxuY8oKk50kP/MzAjH8nNhW2z6584I
 Y6dIbnxo8jFx9mhHNTBP4DZNx+EHsqP9Ge6U4tcZWN2YOtY79BqsW0Q//NvCGqQP94m6
 y45C3X70KWDE69SORX34jTZoSLXML5ywQcgtaEAON8hn0pnrpV3cPg5auG5G5Rt4szOF
 NqsvsDkBEUhTuLihpn0BQGzX4fKTKsoOvz681E6++Z0u4rMVRsnQKZWxLM0kcLpnhQZR
 3WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826656; x=1773431456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39GedOA/zhD2INkZV87nF0IgHSvIChHEdqlmVOM0ds4=;
 b=G+be8hEK7crvEXWu+eRE7GuqL/ev5pgten7wV0ifcjTWAmQ0WKz6qLtQuvyk84Tzny
 wMCcUnWOOGEfU+jV/6zOv8xsac7vSsDgJrAynHWqYFTFlO/rXKMcwROmVCREwwpFCMFf
 pcV1zoDRu0Mld4C0nQ60PXsAMB+DsomBvbZIlMg+gZSl2EQIPyqIY6FzFysa7UrR+c1b
 HENutE8UbTPaKdr3Vgu2L3Vq5KMbuM7KQYOaLrthLUO+05dKsXlqOzf0rupG1RECnJ81
 FAZRIzhEVRlFjG8d9o3i6U8Pk+MQHTI2bPIr3ntnE15hSkyTl4gt6UnBdRzTVMnKOVku
 MY1A==
X-Gm-Message-State: AOJu0YxlHAskkbO9kcbBHx6fmwtuaESH6D82+lI2Hb7LaSUSvHEJiHsg
 qjSqMTabSZbGuNqazjMcuDAukJZTqFCNVCF+zdSos8thMJx5v0Vz3KsgUg4dNDX6ViQ=
X-Gm-Gg: ATEYQzydHS2eDHsMVdaO6lK5FvbJOJOriyeGEwagO+PW2NeeqDrURlnHxWgae3A8vvr
 Pp0GL5YJSMQ8Shbpo3Q1Okb98Bfb16fJaL0fk4t8JlkzsCAzmVSv6r/s2s+GsE+ZDDkuaNySl12
 ox9VEYD///wpHkIWX3uNKzx5F1ewT2IPCtpgZi/XYvtoxkpNdUdjT2gU8SQhkfiTCcJQyma0q/d
 /b5DrdMM+7qyK6gbqQW3SXlF06wCjfeKrXCSbUgOAtsPLyccaV5XsmCd1kdQO3bnoNj2rOoMqjT
 NHBhkTLa9znRF2COUoQ3NcLFSUIrIZXYF4LNTWWFw03evzI0qqBhYBr3Zxxv56xIMA09/RMtxkB
 XvAVaqrwYOna/gzhjbaKuE1VjM5Bm8ZKHAaN+PPHTfb6GCwjDkkew6ueKlBBq528nlc3KyPJoM3
 4i+PBvmt84SeBs/J8nnsFkL2Y=
X-Received: by 2002:a05:600c:1e88:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-485269182b5mr64592525e9.6.1772826656381; 
 Fri, 06 Mar 2026 11:50:56 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237f354esm24971605e9.5.2026.03.06.11.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 30A1E689D2;
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
Subject: [PULL 03/20] ui/gtk: Don't disable scanout when display is refreshed
Date: Fri,  6 Mar 2026 19:50:30 +0000
Message-ID: <20260306195048.2869788-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-ID: <20260303151422.977399-2-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999cd..0dbb429958e 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -180,7 +180,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_egl_set_scanout_mode(vc, false);
         gd_egl_draw(vc);
     }
 }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d264..c709b2ce0f6 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -199,7 +199,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_gl_area_set_scanout_mode(vc, false);
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
     }
 }
-- 
2.47.3


