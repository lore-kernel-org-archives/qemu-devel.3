Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397E6CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTfn-0004DP-Fr; Wed, 22 Oct 2025 03:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBTfl-0004Cp-Na
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:54:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBTfj-0000M1-9p
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:54:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso17923315e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761119653; x=1761724453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4MZQWzJTVmD3yaNo5gw4GFMojWDARfanU6wGvPLqkA=;
 b=GHge5aNOGz6GyYlwrT+Iz7tGjSxOmOTKxc4eFZ9UWVp2Lij2Aa2yMuD+2peG3gowCl
 T5hjYymW9gNhuEMWmcphVRb7CYSZS/ufbIT5jr7IsdxzF5qiMPTxk2HUq9PDJvDGeTGL
 MCT2SA2/7n1dcO7jMbeg3nrq+I7ixfvxnl9AijI1fG+I57fPzInR9xV3cf22ah7Gulqh
 v910UMf74Tm+mALP2WmHZOnT0ps5PR5OyF0oKzZQbkdJh+SxJItQxHNv1zSp5y1A5Bx8
 fiPkwLvHazczf+O8SwM1hXTZ2UxFifuq8v31TsC9wqQQ6HDY6LyAEutF4Fbeh/aPxtVT
 JhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761119653; x=1761724453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4MZQWzJTVmD3yaNo5gw4GFMojWDARfanU6wGvPLqkA=;
 b=Le4g/q96Bv+EPrlEYnb4BWyNdyfO1rrZPVlXHXzNSlL1H2h6dqcb7rXovb9hPNcG5m
 /Jhho0fN8GvBncpwB7oz1Jc4emWynXKsxUCfzh5b23tA84DYWDSiwd3UZTa6iQIKXsj3
 ZU6O4vlGQFeRhxfzmBDwCSrCVtmFUr5x/xNQz1z02LFRgwyZ1aShWAW2z5uGJFWf06zc
 unbBp8NuVaab+avMEECtbRwEqG6uFLZy2kWkK6Yfv8jANKI79eje1i6MtRJ5OYDccX7w
 LJ4dmxkAe03H5Cgt0uzxkTqGjw+dW7SBsgQKpBfC5Jhcpt9LGU2TTxOb7Klce5hW+dWI
 DUMg==
X-Gm-Message-State: AOJu0YyTFR09adA/5g/z+UmDrI3QtG0Et+WWPgESYR2UDsP3tkUzvb55
 xF1G4/DGV8qIL87mGwuvsUWpt/oIdUxWgJ91/dVAIBnyQCDQRxorI4jGcHMmP99A9XFFt96SA9S
 /Hu/3nqE=
X-Gm-Gg: ASbGncuS5PYcRzFkrPw8EUHUs+3964Us9xEagxD5EEentf1igVENvklVg4rUZaLds52
 SGcrYCuESfFq9PLOjLESlS3Tl09h3PvnmfU6Q+3KjqnOW4fmjt6iPcBzy9nWLh57f1wNRSWheli
 rj48KgYJxakwndDEF02CaAdqYq0nS26nVgFh5BFSrki0oqYZq48yyOZLByFe5PKcOC48TqeyUpG
 A/rgnw5jY6rn+IyOXfbziCmhWHJyhyogQU5o9/X4gtxXHUsEZrywO+M8ZDwdQI/DIWgGYl9JvAn
 dlb2Q6Pf44ceKhY7Kw9BR1HMYm0EoM2ChXKetOourozN9Kb+r1ASAU5alrRLZYAz1lyiAc0kXfM
 +Likc5fuXG6Tk6veGPG6Q0Xjsu1AdOzefyRB06gQBqhcwkWQ0jVWaBufeMdDpzCaZ2N6JC9lXAL
 hRg8Ldqu9MFqhkefKAH28eRwkREsIlD7tlj3181VHw/5LQIEYguzYdUMaDx2qO
X-Google-Smtp-Source: AGHT+IHQZrui2EnH9cKr2IQ+/7FLftX3O6jn2DRlNpF4DMusNNT/IpwKR0R+vyiwpjfV8r2q89KVGw==
X-Received: by 2002:a05:600c:8b0c:b0:46e:731b:db0f with SMTP id
 5b1f17b1804b1-47117912b5fmr162839725e9.28.1761119652647; 
 Wed, 22 Oct 2025 00:54:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b3esm29695475e9.13.2025.10.22.00.54.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 00:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 44/42] audio: Rename @endianness argument as @big_endian
 for clarity
Date: Wed, 22 Oct 2025 09:53:52 +0200
Message-ID: <20251022075352.66756-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

@endianness is used as a boolean, rename for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/alsaaudio.c | 32 ++++++--------------------------
 audio/ossaudio.c  | 14 +++-----------
 audio/paaudio.c   |  8 ++++----
 audio/pwaudio.c   | 12 ++++++------
 4 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 89f6dad1a97..7d7da576dc9 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -264,7 +264,7 @@ static int alsa_poll_in (HWVoiceIn *hw)
     return alsa_poll_helper (alsa->handle, &alsa->pollhlp, POLLIN);
 }
 
-static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
+static snd_pcm_format_t aud_to_alsafmt(AudioFormat fmt, bool big_endian)
 {
     switch (fmt) {
     case AUDIO_FORMAT_S8:
@@ -274,39 +274,19 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat fmt, int endianness)
         return SND_PCM_FORMAT_U8;
 
     case AUDIO_FORMAT_S16:
-        if (endianness) {
-            return SND_PCM_FORMAT_S16_BE;
-        } else {
-            return SND_PCM_FORMAT_S16_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_S16_BE : SND_PCM_FORMAT_S16_LE;
 
     case AUDIO_FORMAT_U16:
-        if (endianness) {
-            return SND_PCM_FORMAT_U16_BE;
-        } else {
-            return SND_PCM_FORMAT_U16_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_U16_BE : SND_PCM_FORMAT_U16_LE;
 
     case AUDIO_FORMAT_S32:
-        if (endianness) {
-            return SND_PCM_FORMAT_S32_BE;
-        } else {
-            return SND_PCM_FORMAT_S32_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_S32_BE : SND_PCM_FORMAT_S32_LE;
 
     case AUDIO_FORMAT_U32:
-        if (endianness) {
-            return SND_PCM_FORMAT_U32_BE;
-        } else {
-            return SND_PCM_FORMAT_U32_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_U32_BE : SND_PCM_FORMAT_U32_LE;
 
     case AUDIO_FORMAT_F32:
-        if (endianness) {
-            return SND_PCM_FORMAT_FLOAT_BE;
-        } else {
-            return SND_PCM_FORMAT_FLOAT_LE;
-        }
+        return big_endian ? SND_PCM_FORMAT_FLOAT_BE : SND_PCM_FORMAT_FLOAT_LE;
 
     default:
         dolog ("Internal logic error: Bad audio format %d\n", fmt);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 86c4805675e..c6cad47a015 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -131,7 +131,7 @@ static void oss_poll_in (HWVoiceIn *hw)
     qemu_set_fd_handler(oss->fd, oss_helper_poll_in, NULL, hw->s);
 }
 
-static int aud_to_ossfmt (AudioFormat fmt, int endianness)
+static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
 {
     switch (fmt) {
     case AUDIO_FORMAT_S8:
@@ -141,18 +141,10 @@ static int aud_to_ossfmt (AudioFormat fmt, int endianness)
         return AFMT_U8;
 
     case AUDIO_FORMAT_S16:
-        if (endianness) {
-            return AFMT_S16_BE;
-        } else {
-            return AFMT_S16_LE;
-        }
+        return big_endian ? AFMT_S16_BE : AFMT_S16_LE;
 
     case AUDIO_FORMAT_U16:
-        if (endianness) {
-            return AFMT_U16_BE;
-        } else {
-            return AFMT_U16_LE;
-        }
+        return big_endian ? AFMT_U16_BE : AFMT_U16_LE;
 
     default:
         dolog ("Internal logic error: Bad audio format %d\n", fmt);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 6b9b6d219ab..0c06a397195 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -316,7 +316,7 @@ unlock_and_fail:
     return 0;
 }
 
-static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
+static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian)
 {
     int format;
 
@@ -327,14 +327,14 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat afmt, int endianness)
         break;
     case AUDIO_FORMAT_S16:
     case AUDIO_FORMAT_U16:
-        format = endianness ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
+        format = big_endian ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
         break;
     case AUDIO_FORMAT_S32:
     case AUDIO_FORMAT_U32:
-        format = endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
+        format = big_endian ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
         break;
     case AUDIO_FORMAT_F32:
-        format = endianness ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
+        format = big_endian ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
         break;
     default:
         dolog ("Internal logic error: Bad audio format %d\n", afmt);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 0fd59d9fe60..30f717ccacf 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -324,7 +324,7 @@ done_unlock:
 }
 
 static int
-audfmt_to_pw(AudioFormat fmt, int endianness)
+audfmt_to_pw(AudioFormat fmt, bool big_endian)
 {
     int format;
 
@@ -336,19 +336,19 @@ audfmt_to_pw(AudioFormat fmt, int endianness)
         format = SPA_AUDIO_FORMAT_U8;
         break;
     case AUDIO_FORMAT_S16:
-        format = endianness ? SPA_AUDIO_FORMAT_S16_BE : SPA_AUDIO_FORMAT_S16_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_S16_BE : SPA_AUDIO_FORMAT_S16_LE;
         break;
     case AUDIO_FORMAT_U16:
-        format = endianness ? SPA_AUDIO_FORMAT_U16_BE : SPA_AUDIO_FORMAT_U16_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_U16_BE : SPA_AUDIO_FORMAT_U16_LE;
         break;
     case AUDIO_FORMAT_S32:
-        format = endianness ? SPA_AUDIO_FORMAT_S32_BE : SPA_AUDIO_FORMAT_S32_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_S32_BE : SPA_AUDIO_FORMAT_S32_LE;
         break;
     case AUDIO_FORMAT_U32:
-        format = endianness ? SPA_AUDIO_FORMAT_U32_BE : SPA_AUDIO_FORMAT_U32_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_U32_BE : SPA_AUDIO_FORMAT_U32_LE;
         break;
     case AUDIO_FORMAT_F32:
-        format = endianness ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORMAT_F32_LE;
+        format = big_endian ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORMAT_F32_LE;
         break;
     default:
         dolog("Internal logic error: Bad audio format %d\n", fmt);
-- 
2.51.0


