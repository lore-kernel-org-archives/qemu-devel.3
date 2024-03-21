Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BD9CD11BF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQC3-00040r-3m; Thu, 21 Mar 2024 17:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rnQC1-00040i-UA
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:43:21 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rnQC0-0004RR-EI
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:43:21 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512f892500cso1825980e87.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711057398; x=1711662198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tZKMOnFmzQ9+WH5L4lnnMm+yPXbw1TkGocGT+XU0FKI=;
 b=Peq4TQlps1MrijFxS8XZK2blFigXJuMAjSJ7BgoeRhdPhxYT0mJW1kgSUKhpIfkCbf
 CwF3n9zDgMzQbNQoRQ2AZApw2bDNrgDmA1yRfWy5oKISB96oNVg2uIquM+DGD1lnhkOO
 kFvJagcjYePEdyXmoDjyLH+0TSQ3Mdtyoh8fH9Uo/j2QPHQ/TXRiGl8MHdc/OqkggLru
 Xw9Yn8F3pJFpWYfe716J5MTWzd5MwUHfMjq7avK4hv2F0LJDzen4ld2TWbbT7Q+cv0A4
 92VDeXbaQi5sgiFl34fpBuz/B495awzqS8HFTWt4YFZaGeU9VFlcFb8QiORZBvHJldQg
 IkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711057398; x=1711662198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZKMOnFmzQ9+WH5L4lnnMm+yPXbw1TkGocGT+XU0FKI=;
 b=GMcQkhVyz0l5WaYpWK1RXjGSD5OFrYdbQM+xY8ktiXq7dO8MGXOqfRsiJe4Bm4IGIY
 dmVlTKsz4wcR4u9o4pmKqIwMjnanVgQNJYNTSWumPoZg4ytFS3CoWYFrVKbVz/3L2oz8
 KQ3rqYrWdaSGYqPOKiYlOMinYZdqliJzrKZgpJRO04eAOPOd2G0jvWuXr5L/A3uXO/Mk
 rn2XbtSlpvEiGTyXO8NJXM1AFHd+eO6P/T6mD1szv4+44fk8rQs1Rhrr+mgufQbcQkDm
 z91JWYAPLsWzU20Hea25U39pDtenu8ikcu7AjeLMEbPKs4/4wMxpF2FlDMTUssU1NMhF
 0Ofw==
X-Gm-Message-State: AOJu0YyXIVezj/313lEpG7HlyJPifY6gwSbCud0zLUMp3537leMbhp1g
 g9fbM6D0i/s9dDXUcWmHt7glT94t+jLeb+5MY2FAa2S35atkMQs=
X-Google-Smtp-Source: AGHT+IERhKj3G9CbCARcgBFT9ujtYsRhjpDOtODMRGSyf3DK1OvrX6YQSxMg2ekYEsbHCQaKaIw44g==
X-Received: by 2002:a05:6512:1cc:b0:513:80cd:e80b with SMTP id
 f12-20020a05651201cc00b0051380cde80bmr499869lfp.29.1711057397776; 
 Thu, 21 Mar 2024 14:43:17 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a1709062a8c00b00a46f95f5849sm328963eje.106.2024.03.21.14.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 14:43:17 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: mst@redhat.com,
	kraxel@redhat.com,
	manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] virtio-snd: Skip invalid message sizes and null streams
Date: Thu, 21 Mar 2024 22:42:59 +0100
Message-Id: <20240321214259.518560-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This update changes how virtio_snd_handle_tx_xfer handles message size
discrepancies and null streams. Instead of using error handling paths
which led to unnecessary processing and potential null pointer dereferences,
the function now continues to the next loop iteration.

ASAN log illustrating the issue addressed:

ERROR: AddressSanitizer: SEGV on unknown address 0x0000000000b4 (pc 0x57cea39967b8 bp 0x7ffce84d51b0 sp 0x7ffce84d5160 T0)
    #0 0x57cea39967b8 in qemu_mutex_lock_impl qemu/util/qemu-thread-posix.c:92:5
    #1 0x57cea128c462 in qemu_mutex_lock qemu/include/qemu/thread.h:122:5
    #2 0x57cea128d72f in qemu_lockable_lock qemu/include/qemu/lockable.h:95:5
    #3 0x57cea128c294 in qemu_lockable_auto_lock qemu/include/qemu/lockable.h:105:5
    #4 0x57cea1285eb2 in virtio_snd_handle_rx_xfer qemu/hw/audio/virtio-snd.c:1026:9
    #5 0x57cea2caebbc in virtio_queue_notify_vq qemu/hw/virtio/virtio.c:2268:9
    #6 0x57cea2cae412 in virtio_queue_host_notifier_read qemu/hw/virtio/virtio.c:3671:9
    #7 0x57cea39822f1 in aio_dispatch_handler qemu/util/aio-posix.c:372:9
    #8 0x57cea3979385 in aio_dispatch_handlers qemu/util/aio-posix.c:414:20
    #9 0x57cea3978eb1 in aio_dispatch qemu/util/aio-posix.c:424:5
    #10 0x57cea3a1eede in aio_ctx_dispatch qemu/util/async.c:360:5

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/audio/virtio-snd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e604d8f30c..d9e9f980f7 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -913,13 +913,13 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            goto tx_err;
+            continue;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= s->snd_conf.streams
             || s->pcm->streams[stream_id] == NULL) {
-            goto tx_err;
+            continue;
         }
 
         stream = s->pcm->streams[stream_id];
-- 
2.34.1


