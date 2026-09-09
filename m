Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4EFC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4CfB-0002cy-Dn; Wed, 09 Sep 2026 03:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x4Cf9-0002cp-IS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:24:07 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x4Cf6-0002gz-Oc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:24:07 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f9c60b9so156713566b.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788938642; cv=none;
 d=google.com; s=arc-20260327;
 b=KHk12gfyqZ+FupGleCcWZmVTCuQ7vcd0Hjn4pdp4RB53aI2qBV6m+/7jVggqbdxBDm
 dqhR4TSwze5bmNUoPBdNNiKuqBlqGsxNj26eBOgvyhk10yKRFTD5QrEKSSLqti2Lg1vZ
 xjswBg2YcGpxp5AQn+d1NJQvr1nbgiJzxjMHlXw7relwtR5kB7kf5yP2wWox4T4f7B85
 EuqYWXapFRnjivd4xzQSHw1mnkDNCE/msqeWZvBTJPjg7HJVUmLpgiKfCpfIz4LluNO3
 67lhh9fznygGm5laQFeu5jrWe7QXzM0+Uo1P3/7UpyH9ttL3a4++x36nk73obugIv/iJ
 BfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iE96SeWs007tmawi+lHgPeJKOgrzQ5bFzOhZjRk5HQs=;
 fh=+YY8Td6BzP/pG4PCbnufthTNhmxWwkmv9wr1dFxI/U4=;
 b=Mo9T3cPziUyIX/nNUGww/y9lE6FtxSH06Pz74a+yzBmkhzAhpcC2qjRD7W2sfkNXp6
 CifuBqYY5EFkeCRBRHXZz8CknVnfRw8o8n8lra4cGl1uyxFOtFjQAz0dxIlROaBE3KsD
 tvr7NjHLIePb/AuVKWowEL7g7o9uWsZoq1cfu7TVRaufU/DX/XyfpRIugPvlBWV4xYZI
 4YnkKnBx1BRdnhXRyqkCCyUFIJPAreMkPbU3Lb1ZC6C5W9aGAtkx/VuwA42hAEse0w+8
 LKcAkNX1YHyAPBWyErE0hEANJX/2lrnmlJLKp9BbT12p9vLLGSVD3eIP8t8CUOi4WQwG
 au9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788938642; x=1789543442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iE96SeWs007tmawi+lHgPeJKOgrzQ5bFzOhZjRk5HQs=;
 b=E7EwUEyqYD1to/27FNiWH6p5dgyFs14Mjti7aH+UdEjRuE6+fZTOf2J3Khjl3TzyjJ
 HyZvffjCu20AfIEyLRauO37R6pB+ADIwEBGfLTBgnBCeM6+17XOtopzML0hipTzTJNFS
 L9onCkWntGWtAUeipthfU6FQavSu6GXHNjeL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938642; x=1789543442;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iE96SeWs007tmawi+lHgPeJKOgrzQ5bFzOhZjRk5HQs=;
 b=dSpTb82Jp7Ie/CHPhZsZgbIivpfV2zoyoCJuSZ/zqcS+xsSunp+J3Ho0wxf0dQRJOJ
 7h7emfT9ih7zPJF5NOt7z3zOJCngnhZAGSWxld4peJYfY44M06Y2S7JfmAwHtg1a6Wx8
 XftugvaakNv/dD0ywY0XZT4iUNKt6NX6Q7uj4hpIMnTSJetgnaigRxo/5AClrdpkjoOr
 zi39kPorW+d4nF+SBuZVJaWn5xNz9YPQ7yO927F9ex9GKZdu21iDsup2lYInaNVxqtIs
 Uw5EjiGNdMwz8bDdYTylaYBtvQissfMS+Kwf6iqEixQYxnK68i0sB6YeA3TtLPPzVtY+
 92Jg==
X-Gm-Message-State: AFuF++nHkZgN/Ksvms3cqx9UO/m6uy2d/TPAKjevWyN9CfblhDZozWs2
 tuRY4JldAWPriMxjZn4UhjfuMjWImajTABt3Hs4HHk0T7fboIDiG8c3C2TYGPhgMFnmYGzuwUDy
 s1OKJR3X9/AAU1eIod0QsRrjg28SsyKBndoAaoGtLNg==
X-Gm-Gg: AYBFou1JzmCoMh0kanE9ih29jNi86pDk+G59OzRz1fqXVZcK9woboofL13/anBPxhYk
 Y8XFg2JIqYge5vv+YQ7bE59t5nl0p+T99zUxhsbIWO40UYKqMcKoBMVjOSPi2pLXAa2ah4SAdSL
 lY7HT9BezV+RiNRhSOB+kGSp8uRGkxg+1snZ9TtlezDnDOkJq3P0jUW9jGJFJcqrjVxwtP51Ryb
 US5McSWr8ZPyZYsFqa7tLq9hgUX4qVmLQBA461UaxF42bvqgnxTmNtD7QRyUYO7HSaMgl6g/OpP
 Ak7KrznvaUJ1uWNeGT+R/+4djj+2r3VEndqBv95NoWzqEL01RK6XiJX9P+08zpLjnA9vCo0dOUG
 0j21CGv9wmCo=
X-Received: by 2002:a17:907:3f09:b0:c25:f7db:4bea with SMTP id
 a640c23a62f3a-c290446b88cmr525200866b.16.1788938641834; Wed, 09 Sep 2026
 00:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <20260803081159.91981-11-alexander@mihalicyn.com>
 <tl35q0.2bcgb86nv445o@linaro.org>
In-Reply-To: <tl35q0.2bcgb86nv445o@linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 9 Sep 2026 09:23:49 +0200
X-Gm-Features: AcwNN1WqEcDQfMjPzZHudySK2aC307Fp3br0Yy7v9oCqxP-vtTf5PsqLcU0ipw8
Message-ID: <CAJqdLrq++t_pLJcpCqODnnaZznxFZ7YHk5JqL69n9Dt1eXD66Q@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] hw/audio/virtio-sound: add missing vmstate fields
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej2-x10.google.com
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

Am Mi., 9. Sept. 2026 um 09:20 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Mon, 03 Aug 2026 11:11, Alexander Mikhalitsyn <alexander@mihalicyn.com=
> wrote:
> >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >
> >The virtio-sound device is currently not migratable. Add the
> >missing VMSTATE fields, enable migration and reconnect the audio
> >streams after migration.
> >
> >The queue_inuse[] array variables mimic the inuse variable in
> >struct VirtQueue which is private. They are needed to restart
> >the virtio queues after migration.
> >
> >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >[AM: trivial rebase changes]
> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.=
io>
> >Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >---
> >v4:
> >       - added assert(. > 0) before decremeting s->queue_inuse[.]
> >         (suggested by Manos Pitsidianakis)
> >v3:
> >       - added latency_bytes field to VMStateDescription
> >
> >       As suggested by Marc-Andr=C3=A9 Lureau:
> >       - removed the "rc" variable from virtio_snd_post_load()
> >       - dropped info field from VMStateDescription, because
> >         it can't be modified by guest and initialized only from realize
> >       - added minimum_version_id/version_id so we can extend VMStateDes=
cription
> >         without breaking compatibility in the future
> >---
> > hw/audio/virtio-snd.c         | 83 +++++++++++++++++++++++++++++++----
> > include/hw/audio/virtio-snd.h |  1 +
> > 2 files changed, 76 insertions(+), 8 deletions(-)
> >
> >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> >index 12473862d24..6df7ea0eb04 100644
> >--- a/hw/audio/virtio-snd.c
> >+++ b/hw/audio/virtio-snd.c
> >@@ -24,7 +24,6 @@
> > #include "qapi/error.h"
> > #include "hw/audio/virtio-snd.h"
> >
> >-#define VIRTIO_SOUND_VM_VERSION 1
> > #define VIRTIO_SOUND_JACK_DEFAULT 0
> > #define VIRTIO_SOUND_STREAM_DEFAULT 2
> > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> >@@ -74,17 +73,40 @@ static uint32_t supported_rates =3D BIT(VIRTIO_SND_P=
CM_RATE_5512)
> >                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
> >                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
> >
> >+static const VMStateDescription vmstate_virtio_snd_stream =3D {
> >+    .name =3D "virtio-sound-stream",
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >+    .fields =3D (const VMStateField[]) {
> >+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> >+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
> >+        VMSTATE_END_OF_LIST()
> >+    },
> >+};
> >+
> > static const VMStateDescription vmstate_virtio_snd_device =3D {
> >-    .name =3D TYPE_VIRTIO_SND,
> >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> >+    .name =3D "virtio-sound-device",
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >+    .fields =3D (const VMStateField[]) {
> >+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_MA=
X),
> >+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
> >+            snd_conf.streams,
> >+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> >+        VMSTATE_END_OF_LIST()
> >+    },
> > };
> >
> > static const VMStateDescription vmstate_virtio_snd =3D {
> >-    .name =3D TYPE_VIRTIO_SND,
> >-    .unmigratable =3D 1,
> >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> >+    .name =3D "virtio-sound",
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >     .fields =3D (const VMStateField[]) {
> >         VMSTATE_VIRTIO_DEVICE,
> >         VMSTATE_END_OF_LIST()
> >@@ -813,6 +835,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command =
*cmd)
> >                  sizeof(virtio_snd_hdr));
> >     virtqueue_push(cmd->vq, cmd->elem,
> >                    sizeof(virtio_snd_hdr) + cmd->payload_size);
> >+    g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
> >+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
> >     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > }
> >
> >@@ -859,6 +883,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vde=
v, VirtQueue *vq)
> >
> >     elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> >     while (elem) {
> >+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> >         cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> >         cmd->elem =3D elem;
> >         cmd->vq =3D vq;
> >@@ -976,6 +1001,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
> >             goto tx_err;
> >         }
> >
> >+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> >         buffer->elem =3D elem;
> >         buffer->populated =3D false;
> >@@ -1060,6 +1086,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
> >             goto rx_err;
> >         }
> >
> >+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> >         buffer->elem =3D elem;
> >         buffer->vq =3D vq;
> >@@ -1200,6 +1227,8 @@ static inline void return_tx_buffer(VirtIOSoundPCM=
Stream *stream,
> >     virtqueue_push(buffer->vq,
> >                    buffer->elem,
> >                    sizeof(virtio_snd_pcm_status));
> >+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
> >+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
> >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> >     QSIMPLEQ_REMOVE(&stream->queue,
> >                     buffer,
> >@@ -1293,6 +1322,8 @@ static inline void return_rx_buffer(VirtIOSoundPCM=
Stream *stream,
> >     virtqueue_push(buffer->vq,
> >                    buffer->elem,
> >                    sizeof(virtio_snd_pcm_status) + buffer->size);
> >+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
> >+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
> >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> >     QSIMPLEQ_REMOVE(&stream->queue,
> >                     buffer,
> >@@ -1411,6 +1442,37 @@ static void virtio_snd_unrealize(DeviceState *dev=
)
> >     virtio_cleanup(vdev);
> > }
> >
> >+static int virtio_snd_post_load(VirtIODevice *vdev)
> >+{
> >+    VirtIOSound *s =3D VIRTIO_SND(vdev);
> >+    uint32_t i;
> >+
> >+    for (i =3D 0; i < s->snd_conf.streams; i++) {
> >+        struct VirtIOSoundPCMStream *stream;
> >+
> >+        stream =3D virtio_snd_pcm_get_stream(s, i);

Dear Manos,

>
> i < s->snd_conf.streams so this will not be NULL. Is it okay if I add an
> assert anyway before we merging this? I can add it before sending a pull
> request.

Sure, please do ;-)

>
> (A little paranoia can't hurt).

+

>
> In any case:
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thank you!

Kind regards,
Alex

>
> >+        if (virtio_snd_pcm_state_prepared(stream->state)) {
> >+            virtio_snd_pcm_open(stream);
> >+
> >+            if (stream->state =3D=3D VIRTIO_SND_PCM_STATE_STARTED) {
> >+                virtio_snd_pcm_set_active(stream, true);
> >+            }
> >+        }
> >+    }
> >+
> >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> >+        if (s->queue_inuse[i]) {
> >+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i])) {
> >+                error_report(
> >+                    "virtio-snd: could not rewind %u elements in queue =
%u",
> >+                    s->queue_inuse[i], i);
> >+            }
> >+            s->queue_inuse[i] =3D 0;
> >+        }
> >+    }
> >+
> >+    return 0;
> >+}
> >
> > static void virtio_snd_reset(VirtIODevice *vdev)
> > {
> >@@ -1442,6 +1504,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
> >             virtio_snd_pcm_buffer_free(buffer);
> >         }
> >     }
> >+
> >+    for (uint32_t i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> >+        vsnd->queue_inuse[i] =3D 0;
> >+    }
> > }
> >
> > static void virtio_snd_class_init(ObjectClass *klass, const void *data)
> >@@ -1455,6 +1521,7 @@ static void virtio_snd_class_init(ObjectClass *kla=
ss, const void *data)
> >
> >     dc->vmsd =3D &vmstate_virtio_snd;
> >     vdc->vmsd =3D &vmstate_virtio_snd_device;
> >+    vdc->post_load =3D virtio_snd_post_load;
> >     vdc->realize =3D virtio_snd_realize;
> >     vdc->unrealize =3D virtio_snd_unrealize;
> >     vdc->get_config =3D virtio_snd_get_config;
> >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd=
.h
> >index 85d5d7c8619..384d2868c19 100644
> >--- a/include/hw/audio/virtio-snd.h
> >+++ b/include/hw/audio/virtio-snd.h
> >@@ -194,6 +194,7 @@ struct VirtIOSound {
> >     VirtIODevice parent_obj;
> >
> >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> >+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
> >     uint64_t features;
> >     VirtIOSoundPCMStream *streams;
> >     AudioBackend *audio_be;
> >--
> >2.47.3
> >

