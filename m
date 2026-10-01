Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F49BCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPWY-0001pW-W3; Thu, 01 Oct 2026 18:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1xCPWX-0001lh-3S
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:45:09 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1xCPWV-00060R-3U
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:45:08 -0400
Received: from frill.fritz.box (p508abfc2.dip0.t-ipconnect.de [80.138.191.194])
 by linux.microsoft.com (Postfix) with ESMTPSA id CCD6C20B7167
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:44:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCD6C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790894652;
 bh=1sEBvs+8ytpbnqpgoFl5oJCCuQJLNx/n/OoSkhHmTJI=;
 h=From:To:Subject:Date:From;
 b=e6zDQ4g0Ja6lycKplUkWq/++QoCjQW1H5pGYFYZtNZnAYSh3mpTYxS0q7rBmeoarU
 Ej8N71FY3/lSwWhxFhnAMf6AKZZM7lV3oQbxIJSP08u/DRxIJqdnZis4AcVmzfoiYE
 CSVYKFGcWqtcK+A2GPzIe/olJ/PmBSidBp/La2UA=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/audio/virtio-sound: Report bytes written in used length
Date: Fri,  2 Oct 2026 00:30:27 +0200
Message-ID: <20261001224501.1952113-1-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=anbelski@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

The control, invalid PCM, TX and RX completion paths pass fixed response
sizes to virtqueue_push() after copying into the guest's writable iovecs.
iov_from_buf() truncates the copy when those iovecs are undersized, so
the used length can exceed the writable descriptor capacity.

Use the byte count returned by iov_from_buf() for every completion.  For
PCM_INFO, retain the actual payload byte count so the control completion
also remains bounded when the requested element size is smaller than the
native structure.

Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
Tested with the following virtio-villain reproducers:

SND0005:
https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0005_info_size_short.c

SND0012:
https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0012_pcm_info_size_zero.c

SND0015:
https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0015_pcm_info_status_short.c

SND0065:
https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0065_tx_missing_status.c

SND0066:
https://github.com/weltling/virtio-villain/blob/e0c649562cf2e836a0a305e19fb72323e6543d10/tests/sound/snd0066_tx_status_short.c

Before this change all five tests fail because the used length exceeds
the writable descriptor capacity. With this change all five pass.

 hw/audio/virtio-snd.c | 82 +++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6df7ea0eb0..52e12603dd 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -271,13 +271,12 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         memset(&pcm_info[i].padding, 0, 5);
     }
 
-    cmd->payload_size = sizeof(virtio_snd_pcm_info) * count;
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
-    iov_from_buf(cmd->elem->in_sg,
-                 cmd->elem->in_num,
-                 sizeof(virtio_snd_hdr),
-                 pcm_info,
-                 cmd->payload_size);
+    cmd->payload_size = iov_from_buf(cmd->elem->in_sg,
+                                     cmd->elem->in_num,
+                                     sizeof(virtio_snd_hdr),
+                                     pcm_info,
+                                     sizeof(virtio_snd_pcm_info) * count);
 }
 
 /*
@@ -774,6 +773,7 @@ static inline void
 process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
 {
     uint32_t code;
+    size_t written;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
                                cmd->elem->out_num,
                                0,
@@ -828,13 +828,12 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    iov_from_buf(cmd->elem->in_sg,
-                 cmd->elem->in_num,
-                 0,
-                 &cmd->resp,
-                 sizeof(virtio_snd_hdr));
-    virtqueue_push(cmd->vq, cmd->elem,
-                   sizeof(virtio_snd_hdr) + cmd->payload_size);
+    written = iov_from_buf(cmd->elem->in_sg,
+                           cmd->elem->in_num,
+                           0,
+                           &cmd->resp,
+                           sizeof(virtio_snd_hdr));
+    virtqueue_push(cmd->vq, cmd->elem, written + cmd->payload_size);
     g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
     s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
@@ -917,6 +916,7 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSoundPCMBuffer *buffer = NULL;
     virtio_snd_pcm_status resp = { 0 };
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
+    size_t written;
 
     g_assert(!QSIMPLEQ_EMPTY(&vsnd->invalid));
 
@@ -926,14 +926,12 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
         g_assert(buffer->vq == vq);
 
         resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-        iov_from_buf(buffer->elem->in_sg,
-                     buffer->elem->in_num,
-                     0,
-                     &resp,
-                     sizeof(virtio_snd_pcm_status));
-        virtqueue_push(vq,
-                       buffer->elem,
-                       sizeof(virtio_snd_pcm_status));
+        written = iov_from_buf(buffer->elem->in_sg,
+                               buffer->elem->in_num,
+                               0,
+                               &resp,
+                               sizeof(virtio_snd_pcm_status));
+        virtqueue_push(vq, buffer->elem, written);
         QSIMPLEQ_REMOVE_HEAD(&vsnd->invalid, entry);
         virtio_snd_pcm_buffer_free(buffer);
     }
@@ -1216,17 +1214,17 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
                                     VirtIOSoundPCMBuffer *buffer)
 {
     virtio_snd_pcm_status resp = { 0 };
+    size_t written;
+
     resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
     update_latency(stream, buffer->size);
     resp.latency_bytes = cpu_to_le32(stream->latency_bytes);
-    iov_from_buf(buffer->elem->in_sg,
-                 buffer->elem->in_num,
-                 0,
-                 &resp,
-                 sizeof(virtio_snd_pcm_status));
-    virtqueue_push(buffer->vq,
-                   buffer->elem,
-                   sizeof(virtio_snd_pcm_status));
+    written = iov_from_buf(buffer->elem->in_sg,
+                           buffer->elem->in_num,
+                           0,
+                           &resp,
+                           sizeof(virtio_snd_pcm_status));
+    virtqueue_push(buffer->vq, buffer->elem, written);
     g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
     stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
@@ -1306,22 +1304,22 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
                                     VirtIOSoundPCMBuffer *buffer)
 {
     virtio_snd_pcm_status resp = { 0 };
+    size_t written;
+
     resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
     resp.latency_bytes = 0;
     /* Copy data -if any- to guest */
-    iov_from_buf(buffer->elem->in_sg,
-                 buffer->elem->in_num,
-                 0,
-                 buffer->data,
-                 buffer->size);
-    iov_from_buf(buffer->elem->in_sg,
-                 buffer->elem->in_num,
-                 buffer->size,
-                 &resp,
-                 sizeof(virtio_snd_pcm_status));
-    virtqueue_push(buffer->vq,
-                   buffer->elem,
-                   sizeof(virtio_snd_pcm_status) + buffer->size);
+    written = iov_from_buf(buffer->elem->in_sg,
+                           buffer->elem->in_num,
+                           0,
+                           buffer->data,
+                           buffer->size);
+    written += iov_from_buf(buffer->elem->in_sg,
+                            buffer->elem->in_num,
+                            buffer->size,
+                            &resp,
+                            sizeof(virtio_snd_pcm_status));
+    virtqueue_push(buffer->vq, buffer->elem, written);
     g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
     stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
-- 
2.55.0


