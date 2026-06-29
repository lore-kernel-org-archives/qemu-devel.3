Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5955EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7M4-0005tu-04; Mon, 29 Jun 2026 04:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7M2-0005tO-4b
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:28:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7M0-0003Ta-4K
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:28:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493a287b8c1so8456785e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782721710; x=1783326510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6EBCgYCl1c/EFz5qNJ+IZVbmtL8NqUAYJ+SNhcF0Mok=;
 b=EEV0TXgiH0xk3clhxYSo0CSvsoZ9m5rzxUwWiaSamJG81x+SHkXPlKfMKaP0TuCgmE
 6aWmJB63Zve2hsc70qZGlGLL9v87c8HvF5cAkyknSywwGele3ru4tkw9k3kUAOfXd4nW
 8NSLDdysSR4EmZnVQC/AiEpWAeflVJaP7X7apTT5SsF19ScxoA1n75d7HBQ01Rzqo3dE
 sID/SWfdqqFolHUuIsghHnD8vXO4Io60WXh0nq7klatg4ZGe38io5T5bgXGMxevjTWz4
 97BHo3Odegsv3834+7jI8UmCwZPo5t8n/RvL4ntGWC8/qTs6tGGqsfNwAe08GhmTaeAH
 ybRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721710; x=1783326510;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6EBCgYCl1c/EFz5qNJ+IZVbmtL8NqUAYJ+SNhcF0Mok=;
 b=iyiX+CNHKeoQXnd8ksibAt3wU5xa8coVHNq0bPtCtg1BBINTNs37UsG91fv/q2l1Uq
 7RMwnXw/SiZr0/9isvQeetElpGj58Meo5+v43zJBLODmG6nIrWXQKXww8bXyau245DXi
 Z63MfCOt+MJDcBcH8YHFTLQ+RkrIoA5+UoXaqw222lxETGRryxAuzHET7d4ak6jp6uri
 BB0pihUnbO008z4oBGhUGk2vlj+1LQiyyMOq4tSu4IBYAecAdwKZVAhU+rRg+hBEuCFz
 Ck3Y0ri1mTc5SUuw+LZVJuqFKRc/SdBnXnbKKRXLx0aumrsbu67i1TCcqvi+GP8Y40WK
 K6tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FaPB0QYyuf6YwWdj6msA8UtJCnh5C3UXNlW/UiI+7aeppfrBw+nauY/ja36EP0n+o30kpOXh9uhYK@nongnu.org
X-Gm-Message-State: AOJu0YxrFdd9VfgbA2+tNV2utF3P6Xp34ChHgZI/PVNi4G6aALdAaDhX
 MmKT5eCL1YTz9CUqJDdmrKASQROgLXlg6mYZriyVzp0H/0bA3AzEjAHH70/X9w0GUq0=
X-Gm-Gg: AfdE7cnkQjN0Dy1eWRH2aTCG9n/voRZyuJsUp8vAGeghs4a2hs79K1XNezdIZS8eSak
 i7gSq+55nxZNM8iYOhp2xh1qSjJeK9QG+4vffEWEKXebBQrBwiuCENLfWM/dIOgklXYiJQqvFe2
 ++y8xL82fxIe4BsPU/NSQxSZ0akYK82xmiJu8mUF+K5rwMf/VBmGVyLTjUtDyet35zYwzmeUSKX
 zVlB/IkSl0hf19Thx/eBaR9D/g6pOfvn3L0d9bHlARekFcFFpC86GSBFlPQu7jqKV2QYt04yOcr
 BE5e2DAoW2G50l7nfGI9FncYsdbcvokTWcuyZVKDawS9qTyQPsv3Rzy8ijJpT9HKDJSzTCtdfU4
 HeFidXPS+No76pXKPxizlyUxbqWYJmB/4oo3Tj2rQvYq1Xakd8W+lfd9qqfk1Cj42cwANcuzooY
 gFTl4nKQaSl2sXYvrfSZqPAaK4KvDpXihCRdfTXFmvpD5nrdIpL6/+OmhzSf1RJiDlS+g7SYaHr
 LJyo/KdPqqcmMfRfcba7fvagN8a/+kmHEnoNmv9hvQgiluRTj6KXom4eEFDQDb8G5tXudTKJr7K
 1zHV0HnsPGDI90m7JcAlwvo=
X-Received: by 2002:a05:600c:a00e:b0:493:a91c:d47 with SMTP id
 5b1f17b1804b1-493a91c0e98mr60305295e9.23.1782721709658; 
 Mon, 29 Jun 2026 01:28:29 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690168d5sm411376645e9.14.2026.06.29.01.28.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:28:29 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:23:32 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 9/9] hw/audio/virtio-sound: add missing vmstate fields
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-10-alexander@mihalicyn.com>
Message-ID: <thdwvg.71u440c3d5z8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>The virtio-sound device is currently not migratable. Add the
>missing VMSTATE fields, enable migration and reconnect the audio
>streams after migration.
>
>The queue_inuse[] array variables mimic the inuse variable in
>struct VirtQueue which is private. They are needed to restart
>the virtio queues after migration.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: trivial rebase changes]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>---
>v3:
>	- added latency_bytes field to VMStateDescription
>
>	As suggested by Marc-André Lureau:
>	- removed the "rc" variable from virtio_snd_post_load()
>	- dropped info field from VMStateDescription, because
>	  it can't be modified by guest and initialized only from realize
>	- added minimum_version_id/version_id so we can extend VMStateDescription
>	  without breaking compatibility in the future
>---
> hw/audio/virtio-snd.c         | 80 +++++++++++++++++++++++++++++++----
> include/hw/audio/virtio-snd.h |  1 +
> 2 files changed, 73 insertions(+), 8 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 81ba1e1a277..7af0b63c03b 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -24,7 +24,6 @@
> #include "qapi/error.h"
> #include "hw/audio/virtio-snd.h"
> 
>-#define VIRTIO_SOUND_VM_VERSION 1
> #define VIRTIO_SOUND_JACK_DEFAULT 0
> #define VIRTIO_SOUND_STREAM_DEFAULT 2
> #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>@@ -78,17 +77,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
>                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
>                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
> 
>+static const VMStateDescription vmstate_virtio_snd_stream = {
>+    .name = "virtio-sound-stream",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
>+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
>+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
>+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
>+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
>+        VMSTATE_END_OF_LIST()
>+    },
>+};
>+
> static const VMStateDescription vmstate_virtio_snd_device = {
>-    .name = TYPE_VIRTIO_SND,
>-    .version_id = VIRTIO_SOUND_VM_VERSION,
>-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
>+    .name = "virtio-sound-device",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_MAX),
>+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
>+            snd_conf.streams,
>+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
>+        VMSTATE_END_OF_LIST()
>+    },
> };
> 
> static const VMStateDescription vmstate_virtio_snd = {
>-    .name = TYPE_VIRTIO_SND,
>-    .unmigratable = 1,
>-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
>-    .version_id = VIRTIO_SOUND_VM_VERSION,
>+    .name = "virtio-sound",

Why change the name? It differentiates between the device impl and 
virtio-sound-pci wrapper device.

>+    .version_id = 1,
>+    .minimum_version_id = 1,
>     .fields = (const VMStateField[]) {
>         VMSTATE_VIRTIO_DEVICE,
>         VMSTATE_END_OF_LIST()
>@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
>                  sizeof(virtio_snd_hdr));
>     virtqueue_push(cmd->vq, cmd->elem,
>                    sizeof(virtio_snd_hdr) + cmd->payload_size);
>+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;

Let's do a g_assert that this is > 0 before decrementing it.

>     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> }
> 
>@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
> 
>     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>     while (elem) {
>+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
>         cmd = g_new0(virtio_snd_ctrl_command, 1);
>         cmd->elem = elem;
>         cmd->vq = vq;
>@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>             goto tx_err;
>         }
> 
>+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
>         size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
> 
>         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>             goto rx_err;
>         }
> 
>+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
>         size = iov_size(elem->in_sg, elem->in_num) -
>             sizeof(virtio_snd_pcm_status);
>         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
>     virtqueue_push(buffer->vq,
>                    buffer->elem,
>                    sizeof(virtio_snd_pcm_status));
>+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;

Ditto

>     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
>     QSIMPLEQ_REMOVE(&stream->queue,
>                     buffer,
>@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
>     virtqueue_push(buffer->vq,
>                    buffer->elem,
>                    sizeof(virtio_snd_pcm_status) + buffer->size);
>+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;

Ditto

>     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
>     QSIMPLEQ_REMOVE(&stream->queue,
>                     buffer,
>@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceState *dev)
>     virtio_cleanup(vdev);
> }
> 
>+static int virtio_snd_post_load(VirtIODevice *vdev)
>+{
>+    VirtIOSound *s = VIRTIO_SND(vdev);
>+    uint32_t i;
>+
>+    for (i = 0; i < s->snd_conf.streams; i++) {
>+        struct VirtIOSoundPCMStream *stream;
>+
>+        stream = virtio_snd_pcm_get_stream(s, i);
>+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
>+            virtio_snd_pcm_open(stream);
>+
>+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
>+                virtio_snd_pcm_set_active(stream, true);
>+            }
>+        }
>+    }
>+
>+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
>+        if (s->queue_inuse[i]) {
>+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i])) {
>+                error_report(
>+                    "virtio-snd: could not rewind %u elements in queue %u",
>+                    s->queue_inuse[i], i);
>+            }
>+            s->queue_inuse[i] = 0;
>+        }
>+    }
>+
>+    return 0;
>+}
> 
> static void virtio_snd_reset(VirtIODevice *vdev)
> {
>@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>             virtio_snd_pcm_buffer_free(buffer);
>         }
>     }
>+
>+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
>+        vsnd->queue_inuse[i] = 0;
>+    }
> }
> 
> static void virtio_snd_class_init(ObjectClass *klass, const void *data)
>@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectClass *klass, const void *data)
> 
>     dc->vmsd = &vmstate_virtio_snd;
>     vdc->vmsd = &vmstate_virtio_snd_device;
>+    vdc->post_load = virtio_snd_post_load;
>     vdc->realize = virtio_snd_realize;
>     vdc->unrealize = virtio_snd_unrealize;
>     vdc->get_config = virtio_snd_get_config;
>diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>index 85d5d7c8619..384d2868c19 100644
>--- a/include/hw/audio/virtio-snd.h
>+++ b/include/hw/audio/virtio-snd.h
>@@ -194,6 +194,7 @@ struct VirtIOSound {
>     VirtIODevice parent_obj;
> 
>     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
>     uint64_t features;
>     VirtIOSoundPCMStream *streams;
>     AudioBackend *audio_be;
>-- 
>2.47.3
>

