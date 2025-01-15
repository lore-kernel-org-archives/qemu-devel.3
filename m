Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA8C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2BJ-0007GT-Nt; Wed, 15 Jan 2025 07:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2BH-0007G8-IU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:07:32 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2BF-0001Au-3R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:07:30 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2163dc5155fso120704985ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942847; x=1737547647;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iT5ctD1NFwO4wtJYLdvtxC0Jt3IWKtNIGaVgl3Gv4/U=;
 b=qScs41uZcorEWhu/BqK8hI7+HLIHNV919K6RxIx6X9GP8gjzifJVddryz8poRcXJYe
 p+74MuwRH7mK6Yw35KsIIisERNWuljei+TdpXdRVFlxdMGBXtf0wwPa8X7vILhnCUp4Q
 hidaYfYYiVko3kjKUqe64Fvn3H8TKoO3GXpHWjP3m9GdyeWg79bm73ChF+FGtzm3lX3q
 7w9yoMKx/XGqtjVLnnHIYcFC8d20MtuT/zQvJJVorrycAtRPIN6l8FTLPKlOeJyire8/
 z6dKg5nHpgPqRY+BKF8a8ketyOxQZlGJ+gEmMKS/3ka93JE4dKcYCyiOKq4ztnYGNieB
 mIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942847; x=1737547647;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iT5ctD1NFwO4wtJYLdvtxC0Jt3IWKtNIGaVgl3Gv4/U=;
 b=S0q9QMgrxS9LQaTrcxIbf225RP3dW3O5T/AI2ybupKFMkXFbwQlXqMAXTUhtYelrc9
 oqpgR8HVF9q8cHBTpkO8l5HxH4Q/LjT7t+QC2uP02famK7LOA3NJ281SI3rYMGdnGR3v
 kdVsUWoikKAD4PJ57AfGV7tM9HM97f5evrAsU5AvqSCaZ0MRKz371TnLPpbLFuAQOYcC
 Jv7gvrlrdeNaPFcq5lSsNsDAzJL5f71nw17DCo5KqFrvPjm6tnbuSlS60gFOcfg59tJ4
 DeVvpOSYRQYL49OaCXOjCfxEDNYbrHAuv/7hBmkYER1axufA2R7r4gZFrt4majR2PFoy
 IKUQ==
X-Gm-Message-State: AOJu0YwrSi8qhWolc4PTfQjOKkOktlKuiN+c0danlvPQPJdhbSfsi7DG
 8le48oG4crPFk7VFFoLR7U9PtpHzBY+b4XYjJQoIqVAPTpt8Hr+HKsHQRFQE9Ug=
X-Gm-Gg: ASbGnctMzQxECarxZIVhw2iE/8p7b7WqBhnM2BLv6l1/7pR4aZLe1RpcH81FC7Gr4M8
 OoOHrtXdmr8amE0vlEpG1pPiVskRhF1Si55afxlPnxlaW7WUVAZ32j+u+V1GmSFPiwaGj9EcE0b
 pwCg4lK0q+P1BN/0MquDMGkViH0E4F4QkBgLnLuXDk3SzFsNjXI8LTtrWdWp4MNY5xVmdRQNqM0
 tgVLaBEyK/qIzeaHA0aB4vsRODTNBl0iV0lw8JZxUwFuboCtbiwxcezGIxP
X-Google-Smtp-Source: AGHT+IFrBW8pvwEb8WkgOtzdYRYKMZfa2b/w+jH1DxjoGJoVhQDTvC/8uYrk/C3OlmEpe4JHCBXB2w==
X-Received: by 2002:a05:6a20:a10f:b0:1e1:a829:bfb6 with SMTP id
 adf61e73a8af0-1e88cf7f5bdmr46405880637.3.1736942847495; 
 Wed, 15 Jan 2025 04:07:27 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a860dae3fddsm2075399a12.34.2025.01.15.04.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:07:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 21:06:56 +0900
Subject: [PATCH v3 2/2] coreaudio: Initialize the buffer for device change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-coreaudio-v3-2-bdb6bcb5bf9f@daynix.com>
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
In-Reply-To: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reallocate buffers when the active device change as the required buffer
size may differ.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/audio_int.h |  2 ++
 audio/audio.c     | 24 ++++++++++++++++++------
 audio/coreaudio.m |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 2d079d00a259..9ba4a144d571 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -187,9 +187,11 @@ struct audio_pcm_ops {
     void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
 };
 
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
 void audio_generic_run_buffer_in(HWVoiceIn *hw);
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
 void audio_generic_run_buffer_out(HWVoiceOut *hw);
 size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
diff --git a/audio/audio.c b/audio/audio.c
index 87b4e9b6f2f3..17c6bbd0ae9e 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
 #endif
 }
 
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
+{
+    g_free(hw->buf_emul);
+    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
+    hw->buf_emul = g_malloc(hw->size_emul);
+    hw->pos_emul = hw->pending_emul = 0;
+}
+
 void audio_generic_run_buffer_in(HWVoiceIn *hw)
 {
     if (unlikely(!hw->buf_emul)) {
-        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
-        hw->buf_emul = g_malloc(hw->size_emul);
-        hw->pos_emul = hw->pending_emul = 0;
+        audio_generic_initialize_buffer_in(hw);
     }
 
     while (hw->pending_emul < hw->size_emul) {
@@ -1446,6 +1452,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
     hw->pending_emul -= size;
 }
 
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
+{
+    g_free(hw->buf_emul);
+    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
+    hw->buf_emul = g_malloc(hw->size_emul);
+    hw->pos_emul = hw->pending_emul = 0;
+}
+
 size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
 {
     if (hw->buf_emul) {
@@ -1477,9 +1491,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
-        hw->buf_emul = g_malloc(hw->size_emul);
-        hw->pos_emul = hw->pending_emul = 0;
+        audio_generic_initialize_buffer_out(hw);
     }
 
     *size = MIN(hw->size_emul - hw->pending_emul,
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index b9e1a952ed37..72a6df0f75ee 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     core->outputDeviceID = deviceID;
     core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
     core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
+    audio_generic_initialize_buffer_out(&core->hw);
     core->ioprocid = ioprocid;
 
     return 0;

-- 
2.47.1


