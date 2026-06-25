Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8E2CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcglm-0005oD-9T; Thu, 25 Jun 2026 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcgld-0005mN-86
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglb-0003ko-Ms
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so11687375e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381182; x=1782985982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QU+62G2kpYIQKz8C0MkahtdjizfxeeapbTqWi0XDWA=;
 b=VP0Z3XIlpfQkMWByWv/a4m3/H0i8DjauxVXL2VSVFyM3nbZpQ9sdWB0/jt4qTo0fWe
 iAMHD7HbzoMW1S+mPgdPl46znE3Dkkew+7KcmRyEwgRL9+sAfifT6OKcgcEDLv071mVy
 12RhU7W23bD8ene/LK68ThSCi591ZRzbiv8Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381182; x=1782985982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+QU+62G2kpYIQKz8C0MkahtdjizfxeeapbTqWi0XDWA=;
 b=NBU59jJj1kFmezdrlBl/TtaZjZK+iK7weSA3dlf9KG83QHH88wnwLhIdKBn1/lyBRp
 g97kY6WI4Yse1r+8JFP/smHDdrKrk17BSs0TmPuDnpNVstkhkc2iQSoT1jLYsVlrWpVh
 VLbjxHPXS0xInLoYrn2wxm88Ts7lqFpcFuPBqrx/7QxUVsF1xiuwA1X8rEawkjoGkmza
 QmzUN1T/h0b6bLdsovRN7GE9zPfWv74jo+KIIgikXuTkdsaDu9Mvwnv3tkFovFw7qmsc
 xz4u3VSzrzTKxqseuMyAmHzCxTCNfGxHc/Nm4rGvO6sQ4yLbfa1so5JgZUqnWBc40yh7
 mVcg==
X-Gm-Message-State: AOJu0YzmaZwbM5mBRFiNoOF89uAhcl3qem7u7Ge6dJfR0+3Yim3VTKfT
 aUDt7kZmb47Ed0nV0l1w3Ckdl9fM0bNzdYwnWJ436Ag4fkLxcOoaTG15j4soWh/C+x8EQP4RJTI
 C//YSrUrALQ==
X-Gm-Gg: AfdE7ckNoJCuJkpp1/OcWWSFxOrCSxenWUV/X0VekaTWJDQDbbN8fHyWIY/5AxJWNEl
 O3hgRC7b/S1cH0fqDmwKv6uplIci/JqKHuigKtydGx7KS+FuWi8TE8fvXBS6RDczjfL6vkQDlf3
 yWL/ABoZ1A6hFOL4lnroui8XI835cIG/hqdvsHbfgF9rylGJLzIr+ooDxI6z9S2x2vNBs6hA2Pc
 gD4OsvnUxE+8LvOWeugMyGLPhppgl8CQUqcRfp6NrYQsFCoNCb3PmxhV8UEc6Fb4KiuWTQjP2ef
 cAZ/HhMrDLU0wRYu81f2wPWjky+uII6M5lqYjfDYKLomHJOoEoq1qCRvasTpjoSPKg/eQu3XdEb
 2nEqMOd+qLYu3+mwqM+nXYoH3Fvv6OCEKmBxwRkm9d91TS19tbyjk83isS7f960oGLdG8FzBrfn
 rEngSpUPBrlgVk/IvkM8tzCe/Nchz84e6YAE2ijOYJw58QWzUvaZN1lVKrrW9jc0uqQgRr3xuSq
 DK/DwkbrU8K
X-Received: by 2002:a05:600c:609a:b0:492:322c:1dc3 with SMTP id
 5b1f17b1804b1-49266876a7emr21017705e9.16.1782381181908; 
 Thu, 25 Jun 2026 02:53:01 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:53:01 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 7/9] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
Date: Thu, 25 Jun 2026 11:52:47 +0200
Message-ID: <20260625095250.65073-8-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
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

From: Volker Rümelin <vr_qemu@t-online.de>

Split out the function virtio_snd_pcm_set_active() from
virtio_snd_pcm_start_stop(). A later patch also needs this
new funcion. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 48a6ca9f09c..53f9066ab24 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -461,6 +461,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
     }
 }
 
+/*
+ * Activate/deactivate a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ * @active: whether to activate or deactivate the stream
+ */
+static void virtio_snd_pcm_set_active(VirtIOSoundPCMStream *stream, bool active)
+{
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        audio_be_set_active_out(stream->s->audio_be, stream->voice.out, active);
+    } else {
+        audio_be_set_active_in(stream->s->audio_be, stream->voice.in, active);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -597,11 +612,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VSND_PCMSTREAM_STATE_STOPPED;
     }
 
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
-    } else {
-        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
-    }
+    virtio_snd_pcm_set_active(stream, start);
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
-- 
2.47.3


