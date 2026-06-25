Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194CCCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcgln-0005qg-Lg; Thu, 25 Jun 2026 05:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglX-0005lR-AZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglV-0003jl-HO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:52:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49241896317so9242135e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381176; x=1782985976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFafHQUd4rrDPA5LCXYhKe5X31gRWu/+Xf2MdNeQ34U=;
 b=gHhz5vwb6gfnYJB9az4yjrgEHez6jQOax4LA//3ovdSA9+AzR9S9mWfpnhtzEUKbzW
 NN2QR+X/MO2HxhTzchTBK9wVhu5elicT4Bv0etWepA8bn7HDDTlRVnw3vVRU/H2VQSya
 afV269ll1str8LnEv2yiuNQG/Vv0qM5CUABFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381176; x=1782985976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yFafHQUd4rrDPA5LCXYhKe5X31gRWu/+Xf2MdNeQ34U=;
 b=L9DmuXQ89AGPq5QXmg/v08WWsxWYDOhNPJ+GdQDHEcJ7wBKwQuYwuU+tYI8WZGIMEG
 HbsdYPzRR9CXVow9hSwqtQIRUryHaTIaMVo1yVglfZQgecYj3pbhNnFIhA9cUYXM/E3t
 n+Hq5UWiloNRIr8j5vUV9trt1WV8qDynm0u4v857UPKfM27stOQJtGzMbscHb0Gb7pCC
 r5mGvmVbB6Ng6oBr0prx7dfC5a//XIrvyh90a4MVMaj20b5JNhAkQAMhOH+ZsW9q3mx1
 NQymh4AjQfX3JVmWxcxvzQiUgYJtsmetTcg4PTsIGQ8Yt6UpPjVpMECSZGX8MM/KIWP8
 APbA==
X-Gm-Message-State: AOJu0YyWUzDyZjBNXdQCk6LMuS42JYKLYS2NtE17EGFy19amI+JvNFT9
 Qa8//SJrO2FSVkc7CySRTmwah0E/aDkBYlxgH9Fw15YnNkcn7EuA/nd9Lp75wJRuJDTTmq3vDb7
 qSrsANIMSRQ==
X-Gm-Gg: AfdE7cnG1De8lCTqQ5RL4U+DEAf2l090EvFaL8mLe47MDasZXZMGlA7N8vI9LFKVnbw
 oKjJm47wU4dZi9ASWSTlJ2yM+TOeNG1uAjudYvX2vrfeEzpfKrAcroS3ENeY4KV1QBWjcm8aDek
 vqsGPEJ+EKfFwaj/4ijKHbogIa1ClZkpClLZ+uzeCwg5ur/kb+wJZe5bdiCsjOdIdJsD2RW4fOz
 NSUygQhtTzFyrtqk+jBVEpFhogRm4bR9INC30V8GT+fjOfuL3CUfwi5sqJDt3E34zjVFb0LcjCI
 5V3gjIdazJFmuwkl1kSCiU+HbtPH9vUqNF1ezcNtz7Jrgp81RGcqFhYgNnN+NeBLUlYNZqgXLFk
 qNib9xS9rWgPMTJzxIs6UfHDEPlvT38ARhUJSp8hHoRt1p3oVWchRRFHeSeN4gurcWmhZih51y3
 0DxOOJck3rSEXccFTI+avm1QiPKizmgxOKkfXih5DSmLaW6SXiothdhxCQ9l3qfD//Jnpdw+jcC
 7TTVHB6xj9p
X-Received: by 2002:a05:600c:c3dc:10b0:492:3e69:62df with SMTP id
 5b1f17b1804b1-4926685a7a9mr17698915e9.15.1782381176205; 
 Thu, 25 Jun 2026 02:52:56 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:52:55 -0700 (PDT)
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
Subject: [PATCH v2 3/9] hw/audio/virtio-sound: free all stream buffers on reset
Date: Thu, 25 Jun 2026 11:52:43 +0200
Message-ID: <20260625095250.65073-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x330.google.com
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

All remaining stream buffers in the stream queues must
be freed after a reset. This is the initial state of the
virtio-sound device.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial variable rename s -> vsnd]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index ebf2ec4b3f6..7687261192d 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1341,6 +1341,7 @@ static void virtio_snd_reset(VirtIODevice *vdev)
 {
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     virtio_snd_ctrl_command *cmd;
+    uint32_t i;
 
     /*
      * Sanity check that the invalid buffer message queue is emptied at the end
@@ -1354,6 +1355,16 @@ static void virtio_snd_reset(VirtIODevice *vdev)
         QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
         virtio_snd_ctrl_cmd_free(cmd);
     }
+
+    for (i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+        VirtIOSoundPCMBuffer *buffer;
+
+        while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
+            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+            virtio_snd_pcm_buffer_free(buffer);
+        }
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
-- 
2.47.3


