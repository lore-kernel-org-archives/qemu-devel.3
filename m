Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B52CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSLH-0005nF-U5; Wed, 10 Apr 2024 03:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKI-00043H-9u; Wed, 10 Apr 2024 03:25:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKG-0004EV-CQ; Wed, 10 Apr 2024 03:24:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B1D75D688;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D349AB02C9;
 Wed, 10 Apr 2024 10:23:05 +0300 (MSK)
Received: (nullmailer pid 4191721 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 25/87] hw/audio/virtio-sound: return correct command
 response size
Date: Wed, 10 Apr 2024 10:21:58 +0300
Message-Id: <20240410072303.4191455-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Volker Rümelin <vr_qemu@t-online.de>

The payload size returned by command VIRTIO_SND_R_PCM_INFO is
wrong. The code in process_cmd() assumes that all commands
return only a virtio_snd_hdr payload, but some commands like
VIRTIO_SND_R_PCM_INFO may return an additional payload.

Add a zero initialized payload_size variable to struct
virtio_snd_ctrl_command to allow for additional payloads.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20240218083351.8524-1-vr_qemu@t-online.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 633487df8d303b37a88584d5a57a39dbcd91c7bf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 137fa77a01..cfb12ba78a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -243,12 +243,13 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         memset(&pcm_info[i].padding, 0, 5);
     }
 
+    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     iov_from_buf(cmd->elem->in_sg,
                  cmd->elem->in_num,
                  sizeof(virtio_snd_hdr),
                  pcm_info,
-                 sizeof(virtio_snd_pcm_info) * count);
+                 cmd->payload_size);
 }
 
 /*
@@ -749,7 +750,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  0,
                  &cmd->resp,
                  sizeof(virtio_snd_hdr));
-    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
+    virtqueue_push(cmd->vq, cmd->elem,
+                   sizeof(virtio_snd_hdr) + cmd->payload_size);
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -808,6 +810,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         cmd->elem = elem;
         cmd->vq = vq;
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        /* implicit cmd->payload_size = 0; */
         QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     }
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index c3767f442b..3d79181364 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -230,6 +230,7 @@ struct virtio_snd_ctrl_command {
     VirtQueue *vq;
     virtio_snd_hdr ctrl;
     virtio_snd_hdr resp;
+    size_t payload_size;
     QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
 };
 #endif
-- 
2.39.2


