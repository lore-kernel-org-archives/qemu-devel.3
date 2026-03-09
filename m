Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E922F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxB-0000oD-Gg; Mon, 09 Mar 2026 11:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwe-00086D-Go
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwc-0000R2-1H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-485409ab264so3751895e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071696; x=1773676496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRCFEGQuPtiHC3VwnDLK81Jf/zv4v7LzPgcsCWptTAo=;
 b=Mgu4I8kNgnrQPuqmu5uFpM9KHZzjjA9mgn1T5ETa6j/UntaxVA4aoJM9v1v2z+EI36
 UbtQlUDAO4q4fbtQ/2V1TE2obsMoUC7tbkdwbV414Ev3Qt/Cn+Oeg1TOXsiZ+hW7Wu34
 DkLC3yhiic9rlsEoKS6hfLo5mZcj1jWDnmHBg8wBscedvcgAijl+dfBAeqUbBt9rxDt/
 APWZ3rsY1vZGf0oRevaxhOYGYjOaYv9uiDJt3L5xXGisdYOkmBqLSTgaW695Wh2AVTjo
 wOclhcxh4OIXccGTT0rR8LWwyJcik4/dvuxkLo/eghAhouBCA3BHXSUnByGFE3LhQoSV
 YCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071696; x=1773676496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sRCFEGQuPtiHC3VwnDLK81Jf/zv4v7LzPgcsCWptTAo=;
 b=KnAbV3EjBE8Tx0G42RCfuzCDrIWM428OlxYplcddPvv5OYY+VmNyops5ShKQG6FQS8
 PjzxY2GEEVG4TN1zDGehOXrn33o5k4N30GyGDtlAVbo2UoEewd4sVC4jNSwjmvd8dtRZ
 dL9eOUtHwV4Ygf90mdRBp3tdu+ZQjS8RTbl/FtIopuZ+xx1+Bo2MRf8QInIuaapc8ila
 mrNPZzssm7f4RE2K1DCxIYRFyDNz41iLkaA4C7tDmacC0eSkR6ARgk6OR5w5C+6Uv5Jy
 yZHmJ0X8Lzc9R7bIzYwh8LLyMpAq6dlCfmZCc56lK71fpPE9VRBsT5z5Q4fz5Zm17ST+
 Inzg==
X-Gm-Message-State: AOJu0YwEHKVMpeS/Elz5PP9YQt+8n9EBkfJE4xLrbtAdJhKP9vVjvwnR
 z0FKaBjNW/Ig9WuQYXYcOXWPJb1NybBfBDLLD1PKAzGLvY6dOkG7wB3pPeGlLZkPRevVfN1omkq
 2gAxlBIk=
X-Gm-Gg: ATEYQzzZoRZThX54MUW75CNpQuNPfnIy/n6wOmuVbfRjaR5tfnVXpWBKRkhSFzXLaYT
 ysoXiKiPldlu5fxikNrcdk6kPGx6eI6CD67IzAKREoQSgOrUmUGwyXzEuAga/6j0a3uA7b0Gswt
 9CFg1k7GD2elYllG0ASuBgK4/gtmUrEO4Kg88Ivbvir7tB9KE0ythnQgLCkyIZsukJ+J3mJvqSc
 fW5G77fj8C36XM0jtYzTrbINYtz5qhWMQsQOZvN5Q1n5H0bckhpscpY1XP7AruSTA8P8bXSQweW
 mkXqC5YGwsIyHwDOFpusaG8nunPxV5+wMzfkaKo9b+6A1l95dyZ71Kiyt0gjPLowxxKDdH5S4Ix
 ETCM2NpXqUzkKhRQ+uP0PE003YwPejO/mQ7Gtwl4HNTvcnP+QdkCO/dcNC9CS/cAOh+xB6gwtC9
 fDwmjmACqPARBLGIA30JCpk9rcYePgoCIm119bPCpN/r9RLfB2E7olUNHunpBD7ib2biAdLVyd
X-Received: by 2002:a05:600c:138e:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-485419d759amr1574105e9.9.1773071695970; 
 Mon, 09 Mar 2026 08:54:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237f354esm92111355e9.5.2026.03.09.08.54.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/49] virtio-snd: remove redundant fields
Date: Mon,  9 Mar 2026 16:51:53 +0100
Message-ID: <20260309155219.62400-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
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

From: Roman Kiryanov <rkir@google.com>

VirtIOSoundPCM does not need a pointer to
VirtIOSound because each VirtIOSoundPCMStream
already carries a pointer to it.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305042523.335493-2-rkir@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/virtio-snd.h | 2 --
 hw/audio/virtio-snd.c         | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index da2ba9675e1..e28f1be5db9 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -122,7 +122,6 @@ struct VirtIOSoundPCMBuffer {
 };
 
 struct VirtIOSoundPCM {
-    VirtIOSound *snd;
     /*
      * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
      * field, because the operation of PCM control requests is first
@@ -135,7 +134,6 @@ struct VirtIOSoundPCM {
 };
 
 struct VirtIOSoundPCMStream {
-    VirtIOSoundPCM *pcm;
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 0f78cec967d..fb5cff38660 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -402,10 +402,10 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     if (stream) {
         virtio_snd_pcm_flush(stream);
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            audio_be_close_out(stream->pcm->snd->audio_be, stream->voice.out);
+            audio_be_close_out(stream->s->audio_be, stream->voice.out);
             stream->voice.out = NULL;
         } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
-            audio_be_close_in(stream->pcm->snd->audio_be, stream->voice.in);
+            audio_be_close_in(stream->s->audio_be, stream->voice.in);
             stream->voice.in = NULL;
         }
     }
@@ -440,7 +440,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream = g_new0(VirtIOSoundPCMStream, 1);
         stream->active = false;
         stream->id = stream_id;
-        stream->pcm = &s->pcm;
         stream->s = s;
         stream->latency_bytes = 0;
         qemu_mutex_init(&stream->queue_mutex);
@@ -1064,7 +1063,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
-    vsnd->pcm.snd = vsnd;
     vsnd->pcm.streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
     vsnd->pcm.pcm_params =
-- 
2.53.0


