Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74ACC48BF8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbcdI-0003qw-CQ; Sun, 18 Feb 2024 03:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcdG-0003qK-El
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:42 -0500
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcdE-0006N7-Tw
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:42 -0500
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout04.t-online.de (Postfix) with SMTP id 5E61424363;
 Sun, 18 Feb 2024 09:34:17 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccp-1HWQuP0; Sun, 18 Feb 2024 09:34:15 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 7EFF4200386; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 11/11] hw/audio/virtio-sound: add placeholder for buffer
 write position
Date: Sun, 18 Feb 2024 09:33:51 +0100
Message-Id: <20240218083351.8524-11-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245255-AB7FD99C-A2921D3E/0/0 CLEAN NORMAL
X-TOI-MSGID: 7906d829-d0ef-4a4a-9b1c-943729d1fd07
Received-SPF: pass client-ip=194.25.134.18;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout04.t-online.de
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

When a running audio stream is migrated, on average half of a
recording stream buffer is lost or half of a playback stream
buffer is played twice. Add a placeholder for the write position
of the current stream buffer to the migrated data. Additional
program code is required to resolve the above issues. However,
the placeholder makes it possible to add code in a backwards and
forwards compatible way.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 2 ++
 include/hw/audio/virtio-snd.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b0a0ff2456..453c3a37ba 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -82,6 +82,7 @@ static const VMStateDescription vmstate_virtio_snd_stream = {
     .name = "virtio-sound-stream",
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(buf_wpos, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
         VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
@@ -1395,6 +1396,7 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
                 virtio_snd_pcm_set_active(stream, true);
             }
         }
+        stream->buf_wpos = 0;
     }
 
     for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 457d18d196..9be0276996 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -124,6 +124,8 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     uint32_t state;
+    /* placeholder: write position in current VirtIOSoundPCMBuffer */
+    uint32_t buf_wpos;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
-- 
2.35.3


