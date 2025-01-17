Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551A0C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYg8t-0002xv-MC; Fri, 17 Jan 2025 01:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8n-0002wp-Ku
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:39 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8b-00056H-FG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:27 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso2382612a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 22:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737096443; x=1737701243;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qdmdAb2d8j2jwxZ4AeBFUh6ixb+QzL3NZeL44K9HsII=;
 b=14C01nMjFjQDQ5uqEO+oweu29yT61/wV0cOd5ZgGXesZwB4WepH/FHCh3TeIF6WIuy
 Z5PbvD4rxvHgwir+QLuUGR0oWXQQTI9e6EZvhu2xG5nXYq8++q9clS0ffH3BpX3gQYmZ
 ACP5DgTJLWvSUmF4Bsrn3mqGalJd6sVpKWjr6WLpD9xzNND6qnYTds8h6xyWGY+d05wh
 Aa8yQ6IQf6gwPa/PzxGHUdg1dJG3Y6dc8uqL/ahvEAAkJw3KqE+FMZKckAoQ5/g/0LF/
 Ac8Uz8Y1Q7aIufBD6ZzuLK8MHe1kd0wnL6itJ0zC+QcVoak4M7vIssOKHUGBEuZWCfhg
 mvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737096443; x=1737701243;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdmdAb2d8j2jwxZ4AeBFUh6ixb+QzL3NZeL44K9HsII=;
 b=sqtVc5XreIZMbdNpYQtsvadUjwaBLWN9UuPJ7uO3w40eHaivywNUlKBbS4f63LOkZQ
 ZYBZZO71ruiq7CmDq76Oag70P6EwQqYVn6NajSXwBPZXAcZjuQZmkOWaKxgx4k3PjqWy
 gRhCXwdLMfYe07ytikdrQdCcZTVrFpIpnmUsnMCB0KUv0opItYJtDio86xIQCeRVI7Yl
 aeAU3QszLZXKR/ekQ/Yw5L1drh4SMvvk6FvJB/HpR3H9ZTrZi+bXBzIvh4CCFFxXEvZZ
 t9SMMJDB5ebHIzV+8xzttUVGXqxMnWsJ/It4M1GJt6dvLjz7cI94mZJcTpWRHsQmrZk7
 eqww==
X-Gm-Message-State: AOJu0Yw9+UEv3JhOmQxw4jLkqq3K6A/BrhcwStPeSo5YM5zEfPvdB88p
 wPKRpXLi8g8gpeLaxgp5YlaFFZH8c8dYZqzyZDr59hvAOa1b5yFNCkC9g7iZtl0=
X-Gm-Gg: ASbGnctbZf5o0xtTdV4qkk7YGIc0Z/2EGKXxBFmBrx5eHUbvdfum9O5E91FGv1j/U8n
 V/rjMy1yoQykmMFKkHBey7WKjvBaw1eOT0I3QHCTOSJgGo5wCFbsS8NkcpkSNYHfVjtjZh8BkVP
 EHsB5/aReIWwyvdGr+x2A+hQ1ML7ditA5udtidK9sn8rPs2QI2XgtWBPtmO6o2CUaEe2y9gli3z
 okZaKwFNAi8v8RDf33QpHhPpyXlZBRnfaYM2PSN3KB/A/7U6v9AKMcHUU8=
X-Google-Smtp-Source: AGHT+IEuX0Td4PteDnvdTD/uRs0VsrvojFg/1YDJPmRTcCvjsRKKAMK/wTjHfn/HdcGOgR9LG4l26A==
X-Received: by 2002:a17:90b:2748:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f782c73b7fmr2321359a91.10.1737096443330; 
 Thu, 16 Jan 2025 22:47:23 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f70bd40b8csm2324740a91.1.2025.01.16.22.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 22:47:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 17 Jan 2025 15:47:01 +0900
Subject: [PATCH v4 2/3] audio: Add functions to initialize buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-coreaudio-v4-2-f8d4fa4cb5f4@daynix.com>
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
In-Reply-To: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

These functions can be used to re-initialize buffers when hardware
parameters change due to device hotplug, for example.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/audio_int.h |  2 ++
 audio/audio.c     | 24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

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

-- 
2.47.1


