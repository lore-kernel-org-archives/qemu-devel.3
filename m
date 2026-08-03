Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1D3C55175
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmN-0001cO-Tw; Mon, 03 Aug 2026 04:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmN-0001bo-1B
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmK-0003fL-Lc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49557167508so16093735e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744727; x=1786349527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AZRKMVtsLh2FlJrqbHcFTrJa0a2L1BmpZYhwv58PQLU=;
 b=edbqH8xROwDXDb+RUiiV3RdxZYs/L5I6ewwNDzHsaSrI8Kz7R+RmQX+63/0TzluhpM
 4m3WCmliB1oq6tiVvct1FSOfymbetyQIp6DXRU+xgaqmws0PBsCt26KVhpYnRej+MGvT
 GNDnaCPqEuowuql/y3xGEYjtYcmgV4lixodko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744727; x=1786349527;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AZRKMVtsLh2FlJrqbHcFTrJa0a2L1BmpZYhwv58PQLU=;
 b=rXqwZdC+7p25jQgBD9XYmay8hwel4ZTjw50goC90AdfhUbsViz6D1wCMHkN+j/5/5M
 YiLOiHuM7ZHl6XOTL3+zkYI5mnOaJltDc+Y4Gh699MS7GIxvohmsqEP+loWWC0diFBrE
 iSNog20bQ+AwR1yKGo16k+XuUtRgkJykP4YMkuo7BPRVfl/+ZanJWEEEw9ZckYKy9LYz
 Yrhq7LYHDA+/Z1qGV+yRQ4WSbZxPYxM8/AbH/YSyWEdfnVGPL+Vivc9FV91xlzeQBUfv
 voI+MKCdfidp6MBTl1KcE8as2B1pttQsbpoQiWWaAzlLPJ1CrUFlgIHFJMGcsafRbrTO
 zkmA==
X-Gm-Message-State: AOJu0YxsFCbHhuA7d2YYKfy+DWnyHsiBz9nvOPTQRTJ/PRqbJZ0JMXR7
 BBNDu7EBmpfajPMcgobmd7ce6p0uTpouiSDz05/qs3KtoGKXruSrljWQzXEsZgdS9JbHkZC+lJ3
 B8oU6
X-Gm-Gg: AR+sD13nxUWlKZ18YghOk4x/NFHmGUlVXtZieRK/cp+XKAirrEhiXfbXU4RKxHVQL9i
 qWP6/yjt1sZhFuDrwplZUuXZk7JtlVi3z7f+x2eWUWDTU4wuPYRW8rX9Qex0HDM0SJc8b/IaplM
 w2PuoZXehSwGV9bTM8QP+aYSVhkzchGn4pvhS22z3svYIOQzkr4yNX5A8otWMcVBdCgfP438ro8
 dXThlUGo81povHvJ7YlfaLQwXq1CKv+pGU8YfZ38meT6DgoLDk3UMLdWbjvZBml7ju1bm/K3YXb
 acbUlJDzEfJQK0zVoJklyw6ezqT54ktyyxTATFDjV9zRlozo44Sa6eh3updosKzM8CPBmjSF2ct
 YWdatezyPtoL7o/euGPPg39NtRRrp71CXkwUp+aJOnX1ZbUWFaC3x5lnxB/0+HlbQ/VAlAdQDdU
 LTwOjPeerZBTMYdBUKv7YXggVBNqeD/oJU9r2ZebfptstNW0xgIo0ucwCGdjKeSdNjQdPzzOj5n
 O5hoDD3ZcowVKnIBYMEBMKTB4rU5qzhXdbQs9pvUngcbLPuUg/b7+U/ytWPE9E0QiDjgz9h
X-Received: by 2002:a05:600c:917:b0:496:c06b:9fb4 with SMTP id
 5b1f17b1804b1-4980c65c487mr135716155e9.14.1785744727058; 
 Mon, 03 Aug 2026 01:12:07 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:06 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 05/10] hw/audio/virtio-sound: free all stream buffers on
 reset
Date: Mon,  3 Aug 2026 10:11:54 +0200
Message-ID: <20260803081159.91981-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
References: <20260803081159.91981-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x336.google.com
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
v4:
	- reduced a scope of loop counter variable in virtio_snd_reset
	  (as suggested by Manos Pitsidianakis)
---
 hw/audio/virtio-snd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 84083be8825..f9822fc609a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1364,6 +1364,16 @@ static void virtio_snd_reset(VirtIODevice *vdev)
         QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
         virtio_snd_ctrl_cmd_free(cmd);
     }
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
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


