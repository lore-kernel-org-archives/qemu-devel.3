Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577F3C48BF8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbcca-000359-Ew; Sun, 18 Feb 2024 03:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccY-00034u-1Y; Sun, 18 Feb 2024 03:33:58 -0500
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccW-0006JX-G1; Sun, 18 Feb 2024 03:33:57 -0500
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout02.t-online.de (Postfix) with SMTP id B104A89FD;
 Sun, 18 Feb 2024 09:33:52 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccR-0er8XB0; Sun, 18 Feb 2024 09:33:51 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 61D1F2001C6; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 01/11] hw/audio/virtio-sound: return correct command
 response size
Date: Sun, 18 Feb 2024 09:33:41 +0100
Message-Id: <20240218083351.8524-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245231-2FFFC9FB-24B1E8BB/0/0 CLEAN NORMAL
X-TOI-MSGID: d18c995b-3b24-4e30-bb46-fb1d3023e65a
Received-SPF: pass client-ip=194.25.134.17;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout02.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The payload size returned by command VIRTIO_SND_R_PCM_INFO is
wrong. The code in process_cmd() assumes that all commands
return only a virtio_snd_hdr payload, but some commands like
VIRTIO_SND_R_PCM_INFO may return an additional payload.

Add a zero initialized payload_size variable to struct
virtio_snd_ctrl_command to allow for additional payloads.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 7 +++++--
 include/hw/audio/virtio-snd.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index ea2aeaef14..e604d8f30c 100644
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
2.35.3


