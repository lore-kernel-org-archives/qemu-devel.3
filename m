Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5941CFCC066
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybCX-0004D7-BO; Fri, 06 Mar 2026 14:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCM-0004As-Uw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCJ-0000Q8-3p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:58 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so4244060f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826653; x=1773431453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8fUu9eL4RVgzTGz/rJOnsGcUeJpizCfVBD7U0YbHu0=;
 b=i2Tz+ERTOHAfT+ZIi/fUADipyt5eOg9kS/n6GoTpXWVx3qY+jaRCO6vKrFro5OcQk3
 Jdy+q7Yau47CeFmIgb7I/7Z01zzrv0+j7+e/TMsHVQG+Y8TvaftXPIFrIlhpilsCZ4JB
 c6IN+pgIH/QBleTPgTBIlHchCVcbe8VsN/ID76c4S5HtBimMDChWFJWL/IxMUj31Wops
 uMXcEzfW53kgakMgZStG/jz8eUiEC/6jJDe/e9st25bu/rXRmBDyZ8rfaaQtxwu0jWqr
 1R3+YIDF4bUOcyJ37H29VjKiWU5Dqs9cgUGfgGulX5bduwMGfQTw/EW3KQOos4nk0aik
 2f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826653; x=1773431453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C8fUu9eL4RVgzTGz/rJOnsGcUeJpizCfVBD7U0YbHu0=;
 b=Cm/s+thJZyrtD8827QBEy6+H/nUrQXQ7g6DR5rBTT16rS6CcLg98yJbXB1X/U/Uw4M
 5Uc3kw9S82h+ilLLvOjApw6vVZBxRsFR/hRCATlLKUZNIV3iS8DE+IwNNUSQpSURefnd
 nrCCU5M6xEVnyOqgrRGaDWuzXr7Z9dYjHtvI3FetCIW9g9rODT2NEG7aI/q4ZQWPpixN
 Dc/GRSFtlEhedHwSBY4cWeTBjFmcShWsd8klJN1B7IyR7fi4qMHFB+w7/BzY/JE/YJog
 lUS4mgVH1o+7B7Cwxnwu1/31tqlswi/DfcSvY250/0RDlOxQfXUWE+5rlARRk+YUEEeD
 ZOOQ==
X-Gm-Message-State: AOJu0Ywqf06t1JJg+lrYr8kym541huvfxvDa+AZc3dcMXvdiXZp6ElA1
 P6FciBOii37oxpTRW/Wv1GDsqmPHn461+PxGyCZqU2mER5o7zlQsfmfRqeXdKhSh7WM=
X-Gm-Gg: ATEYQzxZU9n8oSCtiToLJya/I9tk2G6fCi/S4RISJnrMQ263H0A/LgaZ5HfH+3HNAn0
 KMd3VROxmt0upE6oxVZ1Ylu5ILzZj/NWrPEeO/pfWy1XpIGkCcSh1Le74NlVF0re6tTaGpX7Tmz
 N45KP0iV95HT3h2WBxgLpoC+7lZ5TLcH3VMxZ1R0yy1TDGajE9A6OWzAH23lZUo4mpbssWO5RA3
 CvF9Jl84pMK93W2Ozlzsa+mEgsRGw1ZkLo5JTPD3G56/sfX6SLiI1TQjEmr1eq/LYQj3G94Pyy3
 MnpRrKL5aqwu5RpvzLt+IJ5KD2OH66gwBtG2jT7fAgaftIRgJ35hkQXF/YUP33dwP00V2jUkmoZ
 Ok6xeN0bRAx9WNcBCz407B3ZOtSjUTHlr27hLmCcBeNjx5hNMnU0UeQ4m1SrgqFSU5JM3RjZH9b
 T5jBqOU/YXIUH5D0Gv6/a2XiA=
X-Received: by 2002:a05:6000:2881:b0:439:bb42:dbde with SMTP id
 ffacd0b85a97d-439da65531cmr6370732f8f.23.1772826652779; 
 Fri, 06 Mar 2026 11:50:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada3b43sm5889348f8f.13.2026.03.06.11.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46814689D3;
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
Subject: [PULL 04/20] ui/sdl2: Don't disable scanout when display is refreshed
Date: Fri,  6 Mar 2026 19:50:31 +0000
Message-ID: <20260306195048.2869788-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Message-ID: <20260303151422.977399-3-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 3be17d1079a..5eca0248233 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
     int ww, wh;
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
-    sdl2_set_scanout_mode(scon, false);
 
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
     surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
-- 
2.47.3


