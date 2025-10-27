Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D0FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOww-0005xQ-5C; Mon, 27 Oct 2025 11:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOvx-00058q-La
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOvk-00045P-Oj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761578081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMmaChcf8jf2PWmovaXlzLXhyNCOVQEwDOiew6Lu3e4=;
 b=DX4FWdKLbiVo3hoaOFYGXq20K6s7G9+xWxl6RGlLGqyJQ7GG7Mq5jJ4tmt8PWHZz+5InIL
 MIR/5O/Rd7cKoyMdoiXTn8heWI5PEfwxTm6G8LQtUgUshXj5hXTn5gv1ie1ApufzMW8JVW
 3aFuVXhubMgQzhZa0Bhl5MkEWViPMd0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-gHUPTVk1MFSKlxT8F1Xb0Q-1; Mon,
 27 Oct 2025 11:14:37 -0400
X-MC-Unique: gHUPTVk1MFSKlxT8F1Xb0Q-1
X-Mimecast-MFC-AGG-ID: gHUPTVk1MFSKlxT8F1Xb0Q_1761578074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7E891801231; Mon, 27 Oct 2025 15:14:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28EB2180057C; Mon, 27 Oct 2025 15:14:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 34/35] audio: Remove pointless local variables
Date: Mon, 27 Oct 2025 19:10:41 +0400
Message-ID: <20251027151045.2863176-35-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/ossaudio.c | 12 ++----------
 audio/sdlaudio.c | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index ab8791bece..86c4805675 100644
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
index a7a9652d29..707110973a 100644
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


