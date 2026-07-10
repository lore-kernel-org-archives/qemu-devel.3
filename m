Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E311C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi7lf-00006Q-IR; Fri, 10 Jul 2026 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi7ld-00005a-9R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:43:33 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi7lb-0001Vf-3r
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:43:33 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c1601d552a8so47929966b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 02:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783676609; cv=none;
 d=google.com; s=arc-20260327;
 b=rgdzI/fMyO2jN/MlR9OJapBF1k9rOUrlQCJE8suEsCbaLwrEvkyM4QUiPcBDjYTolr
 LA1GKIwuMfEWW31xDNm2AY8bUC3SHiIjgkfym1wIkFBi9tYsLLu0qoZn9IBfRsQi3bSM
 c+IqxLmfGXE4EfCNObw/yWuAVz3NeQKavV544GpC56xlbj8XyEG4hM1HqI7RXBYlsM9d
 4dWXzObea5vRwg/hliiingleNfzLpi1Z+3ryiRc+zHiQerS6tt2JhztkJOX2BoKSROJW
 JCWcSpgGwQ3gvvMX7/lUkYBkzouQm0gNti9F5nwrgGCkB2cAIr57KlKn7Enoc/u+v7WO
 4Zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qLGEbDTLNaYFrbi/m8uWs+woyPBVCS0o71AfwwhCYt8=;
 fh=qty3g77Sl39ix/vs6vEQferIpKkxxHZnWW1uZOZG04Y=;
 b=K6KA6DktWFhPpE28VsA20qKU746M27+++/gSadWyhXR2iNb6W7/c4SpZVt0PFjqeeh
 vnVeBPKHYwZ2Rc3Jk65Icg42XN0Qv7XMuSfc7vbzz8CK1GP4xKBXmJ6/7dyEdWRA93XW
 lPPn/Pjn5jcp2h/e6KcTr/x4pujdtVo1CZvy9qILqXz+/OmaR98KTeshoNpobsLE6MtX
 JnNQxts8hZzBM+RSpS2lrdZ+icgtV5W6f/pK+OKK2oIS+GHjCPheKpAV6kgdhgPZpPDs
 eEj0ircRpIhoOScr7xcV15SxcINgkGKQIf7sdyTGUbSy7oEUK3Mv59/086iuZ6uaUhiU
 GFbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783676609; x=1784281409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qLGEbDTLNaYFrbi/m8uWs+woyPBVCS0o71AfwwhCYt8=;
 b=iy43KFjtHhRXgkUNeRLhBvcOPOwSxWgEZAFTPwSOWteeJBeRvb+YEONDS6lfPMTd29
 NbnbkZ2P2zELgPisuAFvANFiBWZ47xdmfXz2FH3Dl53jtlD6lZetUYyX/WlyRIh3mjRG
 X+XyrtR+QCOAICKJcfAzmswAKhasny5TOhYEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783676609; x=1784281409;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qLGEbDTLNaYFrbi/m8uWs+woyPBVCS0o71AfwwhCYt8=;
 b=mdA0GW3CltawR4s2R5XU60Ki5+b88UJ7ktBI4SfVSo5o1XvMF++XszYJtbUAuNTocy
 yocAytfTNlx43QGguVJqCqqjGj9HLCdajDJJC9ikmjtF5sxLyW2zTFiAf83CrP8z19X/
 yMFfID38Rs+JVqhyNI/A7qUwg8CcF2JvoqX8Q/Vz+WfIr8z2QCGHAV7OZN6VUqnHmf8i
 3eFGeXWGig8PNq1BJ/rNshOrn/9k2eb/XHUckBqiNPxizb+wrW3CDfGRmMozVbw9D65Z
 HMBslvUfWQsiLCQvLTjXvefB26WPTn88VgJ0UCjZR0wb+S+aQ0KwZ7qPVqa0iOBDQ8Fp
 sPYw==
X-Gm-Message-State: AOJu0YxY7uwqi9sKtEijcBZm96At/FO6gL2QGPYkteqlZ4lSfvb/ciFL
 P2LkyHPIzWpKIuNsIgtxvtMfMXgXZkPTS9mOSW4XotGGj9GFOxPJLe4qX/xERVV8QAvPgvwUyAa
 FWOZMy5fl5YWI0/5+R1A11Z2kIqouPfo/PVp6Te3Zag==
X-Gm-Gg: AfdE7cmFSAj4e9OgPgWacPqlGYJLtQPqQQNFGETvHR572pXu/UGvX5YvxMErwpLAzbo
 OQaisrQNjSbgLoUXQZfaXekae2D1CXt2qxKXT6Oehl9br1wsVYa3FfUMPqINDosSbLaatDMR6As
 1BXRKwO9ZNrY4gBPVAXwv1qjVZkGiXwANIb9iyrQnvHuZ4guDrUdyBzKhi961UDQ0RBKRSSmQm3
 quy37scQfH27qZmkaDZoFA3C37n6dRom0fjako4ZlVQzQCxZ+JlYg6T9p6FJtxxV7zdXakSqGiN
 kY5bWj4lTqdh9zanEAOLODYmexY=
X-Received: by 2002:a17:906:2b1a:b0:c08:59dd:3fea with SMTP id
 a640c23a62f3a-c15ce006047mr404330966b.27.1783676608452; Fri, 10 Jul 2026
 02:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
 <thdwvg.71u440c3d5z8@linaro.org>
In-Reply-To: <thdwvg.71u440c3d5z8@linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 10 Jul 2026 11:43:17 +0200
X-Gm-Features: AUfX_mwaZ7glkWgygcnryKmokCHl-hIfADXEhb14PmiYCF_wvOX60bMH6ZbD4p0
Message-ID: <CAJqdLrrYyhmT4VCxe932Nb9VG+=x+EWZ+O5sZsKyQm4Zo_3GfQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] hw/audio/virtio-sound: add missing vmstate fields
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x631.google.com
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

Am Mo., 29. Juni 2026 um 10:28 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com=
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
> >---
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
> > hw/audio/virtio-snd.c         | 80 +++++++++++++++++++++++++++++++----
> > include/hw/audio/virtio-snd.h |  1 +
> > 2 files changed, 73 insertions(+), 8 deletions(-)
> >
> >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> >index 81ba1e1a277..7af0b63c03b 100644
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
> >@@ -78,17 +77,40 @@ static uint32_t supported_rates =3D BIT(VIRTIO_SND_P=
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

Dear Manos,

>
> Why change the name? It differentiates between the device impl and
> virtio-sound-pci wrapper device.

I'm not sure that I understand this point. Before this patch both
vmstate_virtio_snd and vmstate_virtio_snd_device
had the same name TYPE_VIRTIO_SND, we are trying to give the
distinctive names here. Please, elaborate on this.

Kind regards,
Alex

>
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >     .fields =3D (const VMStateField[]) {
> >         VMSTATE_VIRTIO_DEVICE,
> >         VMSTATE_END_OF_LIST()
> >@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command =
*cmd)
> >                  sizeof(virtio_snd_hdr));
> >     virtqueue_push(cmd->vq, cmd->elem,
> >                    sizeof(virtio_snd_hdr) + cmd->payload_size);
> >+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
>
> Let's do a g_assert that this is > 0 before decrementing it.

Great idea, I will address this in v4.

>
> >     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > }
> >
> >@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vde=
v, VirtQueue *vq)
> >
> >     elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> >     while (elem) {
> >+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> >         cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> >         cmd->elem =3D elem;
> >         cmd->vq =3D vq;
> >@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *=
vdev, VirtQueue *vq)
> >             goto tx_err;
> >         }
> >
> >+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> >         size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> >
> >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> >@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
> >             goto rx_err;
> >         }
> >
> >+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> >         size =3D iov_size(elem->in_sg, elem->in_num) -
> >             sizeof(virtio_snd_pcm_status);
> >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> >@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIOSoundPCM=
Stream *stream,
> >     virtqueue_push(buffer->vq,
> >                    buffer->elem,
> >                    sizeof(virtio_snd_pcm_status));
> >+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
>
> Ditto

+

>
> >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> >     QSIMPLEQ_REMOVE(&stream->queue,
> >                     buffer,
> >@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIOSoundPCM=
Stream *stream,
> >     virtqueue_push(buffer->vq,
> >                    buffer->elem,
> >                    sizeof(virtio_snd_pcm_status) + buffer->size);
> >+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
>
> Ditto

+

>
> >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> >     QSIMPLEQ_REMOVE(&stream->queue,
> >                     buffer,
> >@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceState *dev=
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
> >+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> >+            virtio_snd_pcm_open(stream);
> >+
> >+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
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
> >@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
> >             virtio_snd_pcm_buffer_free(buffer);
> >         }
> >     }
> >+
> >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> >+        vsnd->queue_inuse[i] =3D 0;
> >+    }
> > }
> >
> > static void virtio_snd_class_init(ObjectClass *klass, const void *data)
> >@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectClass *kla=
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

