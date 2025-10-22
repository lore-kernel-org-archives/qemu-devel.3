Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D07CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTfW-0004Bp-Bu; Wed, 22 Oct 2025 03:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBTfU-0004Bg-23
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:54:00 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBTfR-0000Kn-8c
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:53:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso53528875e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761119634; x=1761724434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVCEnsuHTS4VEYUMvVbmqRXXIIigQTR/oqoQzVaXJGs=;
 b=ru/4/QBQ6ikq89G9Ue7GaqDhNtdIj8ohHb/ftwGtJbkv0YgpbdiZes21MQrLS5/DrO
 9uq8zutipwRb9SO6GmKc1o8J12FeH13uw4YN34VNKWMKk7cfYVbJaeF6kEGWghCdA/Gv
 Cct/2yAg+O44ZJpK7nr5W1HqbJ3HLVwB4Awz4vgU26/9JqBuJJCHY97aQ3NTOWAx2xDW
 jgBfckIcnW6m7B8l+qSI64Xr5IWGLVJreJiPGk85YmI/7a2H98W3HxumCxZ7+ZFtkD9w
 TuGpeE8ZSGV9eCCyEhH8IUMPg/Xo/lw+2TsLLXfD0xjHlDdpuAxVUzLv4V1QDxUAWvHb
 MCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761119634; x=1761724434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVCEnsuHTS4VEYUMvVbmqRXXIIigQTR/oqoQzVaXJGs=;
 b=J3ov09ExuoWM9mJBcFV6Xc8ZzHyumk7fu4GzSk4AecYIWgeFT/mo331zOqD9in5jmz
 kxRMB9ZZDkn9/mqwDMK8vXmLh7DkB04RU9CODjXdW4Olajr6cEXOaYGPDgaqxOE3pW5Z
 AWKIsGh3Nb6P+3ELRvskMDiGk/fPbgjbi9X4JCMsWWajM9aLY2nc645AF85Y0439mk74
 jrDbwNUe/1qOAmevFHkEJovCK4vky8RU+fZoQdZY5vmZA/ylQQMhuiJfjcKPMq1eBdYR
 +AfQbZXO4SNO/hmy6kEa+PodOGbWFs1z9ECi0Df/QBNKeAabjpR30RvbQqpt6knESfMH
 OeFA==
X-Gm-Message-State: AOJu0YxDM1fpHd5X+TKyRB1QTeF6qLWgrDIC6xg39sGp/BqtKadQK/ha
 OlyeYxpFbBmXn34Exud7xWfmwOhpSMqA6udQZ0nfIiiPeONcygKVoZPgtAYB2TZtThwC/gctEk9
 EtjhMtAE=
X-Gm-Gg: ASbGncs8SJFQgxV5Y/En9MAlvQTO49IFY8mFooaJ+PXqCvQwNHU/UEW0+YJsBwbRSru
 RBwaxNLwzFFUySJqcMZNMpBNyi5TM6Z0inLd8xWdDc99mRssGfR7KNzhiGhsQK+oFaVU5xDv80Q
 mMSTyY9CAaEJikicBqYpIegGxWCNPfQTTtCtuBA1RhSGDKxSET9prMSzFLVPyRb6tETQCKwnfcO
 tZ81Hnks+LeJmIubStBLKAV/Lmc5QP+th9EoCw+0PITvRRQl8ATT5EwwA/zYTvXJWWldPeqJlwH
 iHBsKkYg4YKMb+LKM7JElhT2kkGSMZFYzL5oIvd0mkJpiEdPoWPu72lFxklWyQHsJHuXTLuJjqQ
 Dvwb6U8bQTinRDPqnF6FQksA8EyJYNeEIRPJdRPjYEzcmhUSbvoVNH2jpI9oRW88G31zNj/ep2M
 K28jVuvd/GKQiSw9yaPitrzjjEcnteMpgiCe2Ahrb3WdLAOumIdPTV/DLelYG5
X-Google-Smtp-Source: AGHT+IH05y36Yrr0lnxj2JoMDkWhMQagaWuY5/Ob939sY41ofMvdfUpz+mxfe46NprD4Hi8+s4/Elw==
X-Received: by 2002:a05:600c:444d:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-471178b124amr130480545e9.18.1761119634493; 
 Wed, 22 Oct 2025 00:53:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b48c9sm33124385e9.15.2025.10.22.00.53.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 00:53:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 43/42] audio: Remove pointless local variables
Date: Wed, 22 Oct 2025 09:53:51 +0200
Message-ID: <20251022075352.66756-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/ossaudio.c | 12 ++----------
 audio/sdlaudio.c | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index ab8791bece9..86c4805675e 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -493,10 +493,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     struct oss_params req, obt;
-    int endianness;
     int err;
     int fd;
-    AudioFormat effective_fmt;
     struct audsettings obt_as;
     Audiodev *dev = drv_opaque;
     AudiodevOssOptions *oopts = &dev->u.oss;
@@ -511,7 +509,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
-    err = oss_to_audfmt (obt.fmt, &effective_fmt, &endianness);
+    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
     if (err) {
         oss_anal_close (&fd);
         return -1;
@@ -519,8 +517,6 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     obt_as.freq = obt.freq;
     obt_as.nchannels = obt.nchannels;
-    obt_as.fmt = effective_fmt;
-    obt_as.endianness = endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
     oss->nfrags = obt.nfrags;
@@ -628,10 +624,8 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
     struct oss_params req, obt;
-    int endianness;
     int err;
     int fd;
-    AudioFormat effective_fmt;
     struct audsettings obt_as;
     Audiodev *dev = drv_opaque;
 
@@ -644,7 +638,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         return -1;
     }
 
-    err = oss_to_audfmt (obt.fmt, &effective_fmt, &endianness);
+    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
     if (err) {
         oss_anal_close (&fd);
         return -1;
@@ -652,8 +646,6 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     obt_as.freq = obt.freq;
     obt_as.nchannels = obt.nchannels;
-    obt_as.fmt = effective_fmt;
-    obt_as.endianness = endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
     oss->nfrags = obt.nfrags;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index a7a9652d29d..707110973ac 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -338,9 +338,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
 {
     SDLVoiceOut *sdl = (SDLVoiceOut *)hw;
     SDL_AudioSpec req, obt;
-    int endianness;
     int err;
-    AudioFormat effective_fmt;
     Audiodev *dev = drv_opaque;
     AudiodevSdlPerDirectionOptions *spdo = dev->u.sdl.out;
     struct audsettings obt_as;
@@ -360,7 +358,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
-    err = sdl_to_audfmt(obt.format, &effective_fmt, &endianness);
+    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
     if (err) {
         sdl_close_out(sdl);
         return -1;
@@ -368,8 +366,6 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     obt_as.freq = obt.freq;
     obt_as.nchannels = obt.channels;
-    obt_as.fmt = effective_fmt;
-    obt_as.endianness = endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = (spdo->has_buffer_count ? spdo->buffer_count : 4) *
@@ -398,9 +394,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
 {
     SDLVoiceIn *sdl = (SDLVoiceIn *)hw;
     SDL_AudioSpec req, obt;
-    int endianness;
     int err;
-    AudioFormat effective_fmt;
     Audiodev *dev = drv_opaque;
     AudiodevSdlPerDirectionOptions *spdo = dev->u.sdl.in;
     struct audsettings obt_as;
@@ -420,7 +414,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
         return -1;
     }
 
-    err = sdl_to_audfmt(obt.format, &effective_fmt, &endianness);
+    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
     if (err) {
         sdl_close_in(sdl);
         return -1;
@@ -428,8 +422,6 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
 
     obt_as.freq = obt.freq;
     obt_as.nchannels = obt.channels;
-    obt_as.fmt = effective_fmt;
-    obt_as.endianness = endianness;
 
     audio_pcm_init_info(&hw->info, &obt_as);
     hw->samples = (spdo->has_buffer_count ? spdo->buffer_count : 4) *
-- 
2.51.0


