Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B0FCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSQx-0005zv-HC; Wed, 10 Apr 2024 03:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQZ-0005S7-Bf; Wed, 10 Apr 2024 03:31:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQX-0005TH-Kz; Wed, 10 Apr 2024 03:31:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BCD135D6C6;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 609ADB0306;
 Wed, 10 Apr 2024 10:23:10 +0300 (MSK)
Received: (nullmailer pid 4191910 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 86/87] virtio-snd: Enhance error handling for invalid
 transfers
Date: Wed, 10 Apr 2024 10:22:59 +0300
Message-Id: <20240410072303.4191455-86-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zheyu Ma <zheyuma97@gmail.com>

This patch improves error handling in virtio_snd_handle_tx_xfer()
and virtio_snd_handle_rx_xfer() in the VirtIO sound driver. Previously,
'goto' statements were used for error paths, leading to unnecessary
processing and potential null pointer dereferences. Now, 'continue' is
used to skip the rest of the current loop iteration for errors such as
message size discrepancies or null streams, reducing crash risks.

ASAN log illustrating the issue addressed:

ERROR: AddressSanitizer: SEGV on unknown address 0x0000000000b4
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20240322110827.568412-1-zheyuma97@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a45f09935c88ae352a5ec120418a8b2b36ec1daa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index cfb12ba78a..2d118d6423 100644
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
@@ -995,13 +995,13 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            goto rx_err;
+            continue;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= s->snd_conf.streams
             || !s->pcm->streams[stream_id]) {
-            goto rx_err;
+            continue;
         }
 
         stream = s->pcm->streams[stream_id];
-- 
2.39.2


