Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63259CDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9O-0001oh-3m; Thu, 25 Jun 2026 04:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9D-0001eA-Pg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9B-0007tG-3E
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so1288805f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374956; x=1782979756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9V/M8CX+OrnyuBfipEW1rSJ951L/45RTb80YytIYUU=;
 b=KUlC6uNMq2MA1wEDC+D+BeDFucc6gLhD5vYINpb+9cD7gRL2sWa811SfqgJFknAd8V
 4+QkHHLVWvGgzYMZqVXkLCFTG0EAyx8xxgEXWTrW9QBP/FTjXWRCMVEMimiH59rXhgE2
 rHGIS7WfgOiE3n3IZgxKkvkQtROy42jPsihX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374956; x=1782979756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9V/M8CX+OrnyuBfipEW1rSJ951L/45RTb80YytIYUU=;
 b=dory66F1WoUO/uI1nQ5jkp9xNhQINK/EL06+SmTaUIviAaapYi2lbVrTJiMJf/4eQl
 csIsR0bugb9v3nIIyCXH4qnIBEOcXEpAKBrVNNwKoaabfashKUHU8b0JRYA7d81rNdFO
 EiqPAwy9SIQHxOSvHpOVKbm+RGEJvat+2KIF45fXjxZJVPN8yioRdR9XGP9IlbI4urKm
 OX8hXaG5tfDD4cdX7EvLrClSggnvYiOA9BczElu5OYMlaVSytrV+nS3P3c4ffGXm2bN6
 SiRMP7Fl+j123DDO5nfluTyR38B8EZS0xEbQJOHr2zB26+gxwf0FUjpcQ9oz0ZX+BJVg
 9V3A==
X-Gm-Message-State: AOJu0YxynnaIPedYiSZ576u6Por1HoRqMcC9s6IYTR+F3GJY9voQQmOk
 LqSj+txXlq+C/qrqCfRh1OpCRA4/SnMjtzUSjzIGrR6pS2/uiAVpVfXC43pQ/xUT2pq5TSMnumw
 eZyhOmqz0ag==
X-Gm-Gg: AfdE7clYRBSXfGfyblF6F68YuPxtcv6mHP118PXLClpdTLqU/q3tCdiWyfQDTJCLwVA
 EyP6321Tgqv6foN6ZTtmm6fc1ndsbL4+nvKRBQYp4PG/nby8AIRfBSSyFyRkXQ8fhUumhhZn+XR
 nqkO8lumTGxJqVQNttRdu0dwBWgAptmVj/upBvvEjDUJyYy9NIRSDILAHWjXkfA0nFiaLUXKO0X
 DWPUx5xi6HFzQz0FjeGatvxxOr8EomjMy7qAtN1eua0gvCymkvPtAUOL0oN1ECxnY02O5C7s+6c
 gpdnWnHChiLHHn7569XF8nvxfhuv5SZYdb2uejgI4NkXMk3EhA+0x8kXNpEXRvnruFYuGMzdKbG
 eDCxFH4uD7nQ5IbH7WjY6M9I5yuGtTUNss0QkgvRGH0EY4/raP7Rqcqso53+8OOrKYgUV8RfSZz
 vjHvYGUcJTwL7MsK9vLffFU7rFoOIXS0ubx9/bwrSpetTN0Z4VM2WStFH0d7+5rANxrCKGbRlM5
 J4/Atsoo2YT
X-Received: by 2002:a05:6000:2c0e:b0:43f:e2b7:7160 with SMTP id
 ffacd0b85a97d-46dbed35f0amr2047308f8f.4.1782374955561; 
 Thu, 25 Jun 2026 01:09:15 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:14 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 3/9] hw/audio/virtio-sound: free all stream buffers on reset
Date: Thu, 25 Jun 2026 10:09:04 +0200
Message-ID: <20260625080910.30569-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x434.google.com
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


