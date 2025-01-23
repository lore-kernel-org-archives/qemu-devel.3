Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A446BC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 07:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tarUM-0007XH-2P; Thu, 23 Jan 2025 02:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUK-0007WI-9U
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:52 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarUI-0006DK-J6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163b0c09afso9611245ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 23:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737616729; x=1738221529;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cE+X4PDl66cqVXABqWkosmyuaKRyDx9YI4ApMGsc4ZM=;
 b=X7NnqSLbP50yyPr1nvmPp8EVEX2lH+TtUMccwxL8k+p9i9XTqZBEVh1mOyOWeyODOm
 FyQ+DwyzXZ632ZvMuGvrsQr9gCI64gfAXB+LjM2Y2gFpTEf4m5VMhl+0N9I8h47SqL0F
 dBWLiAzjuIKdtXCLTLnqWM9Spst9QMJ4Y2Y+JPcEZwyNZ3uES1i9a2IcxEcrrq14F7ed
 AGZzco1KLb8lHUwZQta3KcB1PnqlJFwItgSflokNqZ3Wi4K8uO07nvcw1qfa7O9Ixom/
 Dy58e9Q5bwG/07QoU10vFP7+HoXP2rQ7IfcazlxYyenfvSrvJ2cYXpFPA1c0bVu92XXL
 MjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737616729; x=1738221529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE+X4PDl66cqVXABqWkosmyuaKRyDx9YI4ApMGsc4ZM=;
 b=jNUmSu2xwMAkggKqW/qbo3FHmqGfBzW4kpklqbzYg+NBD0rk4RfOz9JpNeLJciNp/F
 JTQgV7RhkSF4ey/ELgN4nIcr27GziIQM0KGzOlSO77Z0LmPc/Q6wfcnSYcEGOWNzOFV8
 CKcz6gFKC5/cnzQQ21EGIv4yREv36J47JxELzDqq1/PWPoU9rJ4nUX3/mH5o585y1rhb
 g9OUzpW1uWEHDnGMOQQE7CzUHIE3MnOCPOTQUdujbeOA/cpy4B63tnF4BsKRPDzsQme+
 EP2b6/yuEsLpVEeWanFXPIDuulVOpal7APgL3qLysku3QAEnDynreQCgzCPilQzkluWJ
 ZR6A==
X-Gm-Message-State: AOJu0YwwycBw/qbV9HqzLGoAbCg7vHKhcQQFZOefOQOafxcXkYs/UC/y
 iSg111cL71E/40HOsRi3WVrJX/Rs7J5UlAVDGM/RSIYEqLAKKlIGWagthhcegUI=
X-Gm-Gg: ASbGnctRxeFfRVjZ+z9GVNOZOSGQ8ltcTOgRqxw6wArB3HdiQWL7C5ch2t1a0Pbliw/
 lqtDJ48vIs5vRZV05s+ocowfHbFR7I6emsy2QkwkEDF5OCHUd5WsiY4p+dq4bUyLf+c9WKGj+x9
 +lrQtiKMHw2TPV/w/8RMsAv0gVxcPp9GHQXCVGEeolxqtV7LLAJuYxYkmLFzTU3jyWj3RKkSb9z
 mFq+zLETOOvjU0v3dN8/Yz9jrZ5Q3ypnCA41HiYH4sdvq6tWYvKgiJPV4E6zpk94f5qGuvpPxJE
 YaXXY+5a
X-Google-Smtp-Source: AGHT+IGWFk/C4qu2ySbEIlwWdXkpRSKfXoca0h8O2asfkukSMzKeTW2ZpjY4q3Vq60WQW+u7KrPEEQ==
X-Received: by 2002:a17:903:2342:b0:215:cbbf:8926 with SMTP id
 d9443c01a7336-21c355b053fmr370941785ad.35.1737616729260; 
 Wed, 22 Jan 2025 23:18:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21c2ceb8cfbsm106203235ad.63.2025.01.22.23.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 23:18:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 23 Jan 2025 16:18:31 +0900
Subject: [PATCH v5 3/4] audio: Add functions to initialize buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-coreaudio-v5-3-6873df4215a0@daynix.com>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
In-Reply-To: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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


