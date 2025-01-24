Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE26C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 05:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBzm-0003ND-T4; Fri, 24 Jan 2025 00:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzj-0003N1-1O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:39 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzh-0000IL-87
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:38 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so2430207a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 21:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737695556; x=1738300356;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cE+X4PDl66cqVXABqWkosmyuaKRyDx9YI4ApMGsc4ZM=;
 b=HRBsxvighgfrv8xRWoA8s9jARR/nsISmueJJT9zFahZIodtMnLwBL5oHSBeKtNsRr4
 /ZVHs37JCWbnE2iCOkFZx++4Xz4Odxb0x93ZmV2EXMRWDbTl0Ig/S9WVCjIrSFfpIVKE
 XzPOOwJoauAJ2UZESJF932UejDPaOKkVgc8WqxgtLDDlEycepnB0Asl3dDw+h4cpQ5So
 kKi+3Mxl0dJgNUI4xv+CiPC9W8Bqs/ZT31ioweVO7o4Cd2aXqgNkdtyDk3/VONcviulO
 ruWNqn9CDLg2Qy7kkAY6xh66alzNHIFcqeuQ0IgkiOzG6ilSKqmkWVMeTexG2t+ZfxyB
 voPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737695556; x=1738300356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cE+X4PDl66cqVXABqWkosmyuaKRyDx9YI4ApMGsc4ZM=;
 b=Ne9hrroUOXriloHHzXotJFH/jHS8GYTrMn2SeWXljA/0NEj6ED1bdDDHLt4D9u9BqQ
 ffpM73b4AxL7n66GbUfjqBVdZu6jxbqfCi5f4aKgOfwJbTHgS/DUpwYIVJKYxXtzkj06
 EezTLlzw6+mB93EfPgNeYgR8ZfAzTlDa7HHqo7C2YgMlOhFlgVMwOU/RimpJgG0g2Zx2
 kFoPkQB7qm5SYvC/O8u8AQOWFcsxlxwwBH1bXmcSvE1ikr9Ojalb2B4y+VCjw6btInUe
 inoCMWijF6CbcJV8tQnAG+ALNAffOoFg1i2Q5XFLP8Jm+nW7OpJNZ/EV9QTqK2M4k/cN
 7ZPA==
X-Gm-Message-State: AOJu0YzIJXL23vitqdlpcygZzKhF0zxzhznYMraDRO5yN5DYggy4jRNv
 4vBc2DNgCIgMWfD1AmkSizZZYHpo0lzyLMXYBNeCN46zdgbh8alNksCGpG1Awe20QsRSSpTidty
 jOMc=
X-Gm-Gg: ASbGnctTQ70zozKXZFWp/4RvHtop3uQiAkCkFOEIrkZTGRlBxPwL5QG3B+WaAa4Xkux
 Eyv+d2AgdpDIM7etbMFcJCWWcBlac/UnIB8GH3qEO4bH4qoE4lUP8g5Lv1mNwny+KkEeJr05LrT
 n6AHsCDXI1dSaAsuL7jV3Yb7U3SxD4+4WiRkPMj3UhkntRFoukyJF0SFcTwI8CjLY74JBi2K/0k
 E0E/v/aFqEy4ZWF0pcjB9uPtYO7m1hZSeL+VHCQ/u34xprD9vmQHIr1mQv9SK1ln6jLkpbPfs2a
 SIV3eAAw
X-Google-Smtp-Source: AGHT+IHHKJJMgySAVNEEeRdAsWcztyEON7u7Z76JcUbbL/CUGS8JPM68FiNCzwJiBQHKymGDWkOEyw==
X-Received: by 2002:a17:90a:c2c5:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2f782c9c88fmr45584761a91.16.1737695555692; 
 Thu, 23 Jan 2025 21:12:35 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f7ffa6b315sm667766a91.26.2025.01.23.21.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 21:12:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 14:12:08 +0900
Subject: [PATCH v7 5/6] audio: Add functions to initialize buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v7-5-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
In-Reply-To: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
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


