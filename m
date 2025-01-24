Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673BDC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBbn-0002EV-JA; Thu, 23 Jan 2025 23:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbk-0002EF-9n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbi-0004bh-Fd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:52 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so38826925ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 20:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737694069; x=1738298869;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cE+X4PDl66cqVXABqWkosmyuaKRyDx9YI4ApMGsc4ZM=;
 b=wNX6ETHZscXX78uEAmonlxo80jjc4kwHkSPhvFbQM1wYOwyw5X1iTNuNqGoxKOviS5
 Rsls/PH2KZyo6zRXrC2qXMyYMvntS3VFYucskyhwAG+XzIvLURg73Z7/NVky6uFlTalO
 pCXv3qrgMF/CMHeZZbqJ5Nbba1jqaZBYqlmLkE9aQ0lTN6PQ1PQuK73B5bh1pqNXtJfB
 LX5PyGbpD3zHzTQFzkvU1TxbLWFQg0E1bwmyM7l/SDxCIVFeI93bIu6L6JyZL4Ehcbp4
 wUrm4iURR6Jl50ETmrF3ovFf1CFJenWUJ8CXK1kbwrEqxcOlnGo1ZDuuflejHb6RCR9D
 ts8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737694069; x=1738298869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE+X4PDl66cqVXABqWkosmyuaKRyDx9YI4ApMGsc4ZM=;
 b=lcmQXc7RmKkrPC5E1VSES80w9AjIvYUqHUFqvl8atC3qest0n9235XaB3qISwqsyRW
 6Z58rYcmRFgsUi8gLbmC5JovWlkcBYblIpLkdXhrY9w2oBrVvFAaHCLz5FmCxg8Nt8w4
 JVELKTyhATA0og7vaLqu+XZRslqgRZng9W5EqvlzOYLnwd61inaiyQCSSmctt/b8q7WA
 Klo4W3qxfziiB06wGipD7xLql7QpoAVn8369bqKIS4Rvf42M6sT6EeSw2co9O53QtgPy
 pW59AFh628/rxFRF40PRFk9cy5nNe5Uinb1bCftSSUIFlNc8ihg40LDS4oFVX0DXbsD6
 fL6Q==
X-Gm-Message-State: AOJu0YyExO6Cd/iUF3CHN2z7NOKSk0nQpX99EtvQao9KgBAyk6exAHD4
 6YQVzoBJ+mF5bG0rUm4r6/H90xnZi5gDJGvAP3lnlo+QULTr38FkASaM6YDyiFw=
X-Gm-Gg: ASbGncv95oiwQ0vfirLfTgUa3c75QJTmC+Bm+GaHOSSnp1MFW+iLdo1YJ1+f2xior2K
 /KMs8DsrRkfSBk+pXu0mCXK14suFFrGFs/znSkYonRPtJ5jV7br4OTmYa6yEzXa3/J9HppYJ5Cv
 bXIrCrjA7YHGUzdmIfnsoFoRkSvmq8n/BMQMOe2YS6Ha+2yO52EvNJl6yyuOHdlQHp+5aKn6fz/
 MCPD6EpCa59nttjXZVJBk5fMTlz8jsVYuXKfQdosJItqXUYAo+6AFc6dnlWH8+d7BzsS1gykDZi
 GPDsJUnG
X-Google-Smtp-Source: AGHT+IFDR10KCpM2sTwaaKsNc6HmovCtplomlJBglujhD5kfO8Vvjj+fFXO4NsWRZxaHER1p0dXI+A==
X-Received: by 2002:a05:6a20:3d8e:b0:1ea:ddd1:2fb6 with SMTP id
 adf61e73a8af0-1eb2158170dmr53880068637.30.1737694069293; 
 Thu, 23 Jan 2025 20:47:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72f8a782774sm834784b3a.156.2025.01.23.20.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 20:47:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 13:47:14 +0900
Subject: [PATCH v6 4/5] audio: Add functions to initialize buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v6-4-11fbcb6c47cf@daynix.com>
References: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
In-Reply-To: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 audio/audio_int.h |  2 ++
 audio/audio.c     | 24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 2d079d00a2596e6bce20e1f52abf01a88c4e0012..9ba4a144d571659ad2d32a4d6b2919ad0db89e25 100644
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
index 87b4e9b6f2f356b6e5e972eabc100cf270fcbc29..17c6bbd0ae9e6ff810c0989dbfa1710ef674ff0a 100644
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
2.48.1


