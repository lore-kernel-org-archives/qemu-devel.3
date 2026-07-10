Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEDEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8Wy-0000TY-8B; Fri, 10 Jul 2026 06:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi8Wv-0000TN-HO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:32:25 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi8Ws-0005RL-N7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:32:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so1189354a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783679540; cv=none;
 d=google.com; s=arc-20260327;
 b=XIbzqIfm4QvqJK9e/7+VYLWZr+qdGURlgyQkrcvuL5SUY5O5WFOoic20OzxZ0j2Imh
 VEKN6ftrEU8Fe6REwgLXLMT3b0t+tx1I4GyjhICrYMihwdWFXcHVF+Yrf67Ghv2amwJh
 WlQ+lHkfGg89XW1IThZia3ua/MDaBSQYWtcglhE6japbnnda3qUq96O5ptyJCf3FHPEx
 W/ROipm+pFefMWZO2+Aiugtb4Ga3yHB1bkQyhPkb8W36BXPH29eOWIWSFbZNTyi4Jnfj
 6Tj2DtCORkLY+kPWEMyO7nSsFgPGlQdDWl68L9C3xRF4IqkPVh4Wd127hbKJRf6LYzBg
 2jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WjoQWiOeguu07ebiS9y5DFRmcMc5rrcwtZbgbuASnfA=;
 fh=qty3g77Sl39ix/vs6vEQferIpKkxxHZnWW1uZOZG04Y=;
 b=V7CUHDj7YbdmmoCf3m51mAdOojrrXWe2QGJ/IXV1z6qlwuwQiKTbNROgJoy+NQpVv1
 Wl+VAe/MiTD4+J0RKDZFttu9ca7QtFZk20FPKow+zHLSr1mzVQef0e1QHIFnm1z6WwCl
 spE4rDtUG9WTlsL6XSlumD0pdek/qr7OTKXEmQXH/1RLvG5mMPigVlieWZA98bVKTevk
 /hSsz3sQJRiG8AiCS7WjYrN5Etx7LiFX//uxY3KAw01B0kq6X2mQkT5rSvuEw6exrG9H
 8RY89uLoTiUFjil1oU77ileRtx777r2pJTE3vsRUVZHrVB/63/hNmBNjqJX3dzC/sLvy
 7YJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783679540; x=1784284340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WjoQWiOeguu07ebiS9y5DFRmcMc5rrcwtZbgbuASnfA=;
 b=elF0tNj+KzBiROvZskIDzh1ZDw+XrfTm5NGUz+LRyHHLYoFqwY3XV9hCBbp10V2Pfy
 jCatmVrEfPcSY7Ttnj4bRp7fsxU0OEuozCEWASmQcsVUkbGBYdYgwvIN4IL75ZoHMBs5
 3ZU8//obZAOBXtBPXp0djSl5QjnkJLgO3yMDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783679540; x=1784284340;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WjoQWiOeguu07ebiS9y5DFRmcMc5rrcwtZbgbuASnfA=;
 b=Jrm7s33jEB2Z2h/wxgIyWeLyoXgKOeERh2Ik1ta5x8ZFk6gqCUDy+BzcVk0jqS90tn
 PerqmzurVrjuRXr4BRLih/YkdSs89gw9mH0Wp9+8RWEBKY5MzZhLj6GR6FAk7uPA5scc
 1P2NFBbtApzkZ4KtM9PR2cFdzUN/GCyldnvJx3Lck+1j/pWBzZyHMnG4YaS3R8zPDIcI
 GZzPdK1b7f35XyOfCCyYhyJVdUCmux/VLVcvvcYb6hwSYjv7Wha99hX04FOqIfmWTvk2
 iaU8MBcztm7lrZjP4hHTj+8JwQki6PiT0D/eOHukRc18cKtaudsB4afsD694prcNowLO
 Q9sA==
X-Gm-Message-State: AOJu0YzlBLyAFc7klg+klUPbP85Pbem32+yw3yjZ3X129ehAolKmdh3x
 azLwSHa3ubP5nc8yoyBW2wtJqq994lC+PHQePaaeBVhsGMES4/hz8zI29TxEQMG3X0cRZswt2Ew
 yy3RWNdaMkZxOhUtJnBxAbbUctwDyzDWMZDQyMgRSPA==
X-Gm-Gg: AfdE7cnSHPfZak4ZK5JPLEPdFociSdQP74IJ9TXSuud6dyCiHKOMnb7pc0j4DJHcLbh
 MFpygRFzuNIOdNZrL0wlk7VBLJRTEGhVCj3WR7D1OdIWPBmtXjtGNjEMLNN/bRZDdNtSOQ88l1m
 WzPua9G2ryyzdeO6nCftEIc+cN/59au7CRqHJv0FSqZH6xja0J2yaUfWXio8Hixl2zijKWfLY6n
 vV+gb1V7Jp9F8+WCboQSfaOUNwHJrhuj/dRAIHn8EAvKI8TsKIThV3rxY/5hXyyIse+wQSCOsde
 c8uvd/xxjIndvErhrD95AoYuc6U=
X-Received: by 2002:a17:906:7955:b0:c08:695:8819 with SMTP id
 a640c23a62f3a-c15cda2397fmr462712366b.0.1783679540253; Fri, 10 Jul 2026
 03:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
 <thdwvg.71u440c3d5z8@linaro.org>
 <CAJqdLrrYyhmT4VCxe932Nb9VG+=x+EWZ+O5sZsKyQm4Zo_3GfQ@mail.gmail.com>
 <CAAjaMXZ5UnGTf+Bxvro41PW_yXOS+mtz6T+KMmAVOKzRf8tEOA@mail.gmail.com>
In-Reply-To: <CAAjaMXZ5UnGTf+Bxvro41PW_yXOS+mtz6T+KMmAVOKzRf8tEOA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 10 Jul 2026 12:32:08 +0200
X-Gm-Features: AUfX_myxgvbyhEIJ3msznXKMTGEq87FLu6vEYsprsIWfHHw4aM05MfMAWk5K4dQ
Message-ID: <CAJqdLroXAOY9t3MM1_pbNdX=Zs0DQn_b8kws_qbj-1=u7NPkrA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x52b.google.com
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

Am Fr., 10. Juli 2026 um 12:17 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Fri, Jul 10, 2026 at 12:43=E2=80=AFPM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > Am Mo., 29. Juni 2026 um 10:28 Uhr schrieb Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org>:
> > >
> > > On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn=
.com> wrote:
> > > >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > >
> > > >The virtio-sound device is currently not migratable. Add the
> > > >missing VMSTATE fields, enable migration and reconnect the audio
> > > >streams after migration.
> > > >
> > > >The queue_inuse[] array variables mimic the inuse variable in
> > > >struct VirtQueue which is private. They are needed to restart
> > > >the virtio queues after migration.
> > > >
> > > >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > >[AM: trivial rebase changes]
> > > >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfus=
ion.io>
> > > >---
> > > >v3:
> > > >       - added latency_bytes field to VMStateDescription
> > > >
> > > >       As suggested by Marc-Andr=C3=A9 Lureau:
> > > >       - removed the "rc" variable from virtio_snd_post_load()
> > > >       - dropped info field from VMStateDescription, because
> > > >         it can't be modified by guest and initialized only from rea=
lize
> > > >       - added minimum_version_id/version_id so we can extend VMStat=
eDescription
> > > >         without breaking compatibility in the future
> > > >---
> > > > hw/audio/virtio-snd.c         | 80 +++++++++++++++++++++++++++++++-=
---
> > > > include/hw/audio/virtio-snd.h |  1 +
> > > > 2 files changed, 73 insertions(+), 8 deletions(-)
> > > >
> > > >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > > >index 81ba1e1a277..7af0b63c03b 100644
> > > >--- a/hw/audio/virtio-snd.c
> > > >+++ b/hw/audio/virtio-snd.c
> > > >@@ -24,7 +24,6 @@
> > > > #include "qapi/error.h"
> > > > #include "hw/audio/virtio-snd.h"
> > > >
> > > >-#define VIRTIO_SOUND_VM_VERSION 1
> > > > #define VIRTIO_SOUND_JACK_DEFAULT 0
> > > > #define VIRTIO_SOUND_STREAM_DEFAULT 2
> > > > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > > >@@ -78,17 +77,40 @@ static uint32_t supported_rates =3D BIT(VIRTIO_S=
ND_PCM_RATE_5512)
> > > >                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
> > > >                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
> > > >
> > > >+static const VMStateDescription vmstate_virtio_snd_stream =3D {
> > > >+    .name =3D "virtio-sound-stream",
> > > >+    .version_id =3D 1,
> > > >+    .minimum_version_id =3D 1,
> > > >+    .fields =3D (const VMStateField[]) {
> > > >+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> > > >+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
> > > >+        VMSTATE_END_OF_LIST()
> > > >+    },
> > > >+};
> > > >+
> > > > static const VMStateDescription vmstate_virtio_snd_device =3D {
> > > >-    .name =3D TYPE_VIRTIO_SND,
> > > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > >+    .name =3D "virtio-sound-device",
> > > >+    .version_id =3D 1,
> > > >+    .minimum_version_id =3D 1,
> > > >+    .fields =3D (const VMStateField[]) {
> > > >+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_V=
Q_MAX),
> > > >+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
> > > >+            snd_conf.streams,
> > > >+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> > > >+        VMSTATE_END_OF_LIST()
> > > >+    },
> > > > };
> > > >
> > > > static const VMStateDescription vmstate_virtio_snd =3D {
> > > >-    .name =3D TYPE_VIRTIO_SND,
> > > >-    .unmigratable =3D 1,
> > > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > >+    .name =3D "virtio-sound",
> >
> > Dear Manos,
> >
> > >
> > > Why change the name? It differentiates between the device impl and
> > > virtio-sound-pci wrapper device.
> >
> > I'm not sure that I understand this point. Before this patch both
> > vmstate_virtio_snd and vmstate_virtio_snd_device
> > had the same name TYPE_VIRTIO_SND, we are trying to give the
> > distinctive names here. Please, elaborate on this.
>
> Ah, I misunderstood the change then. The name must be unique for the
> vmstate to be migrateable, right?

I don't think that it is a strict requirement, because, basically
vmstate_virtio_snd_device is implicitly nested in vmstate_virtio_snd.

In vmstate_virtio_snd we only have VMSTATE_VIRTIO_DEVICE as a VMStateField,
which, in turn leads migration engine to virtio_save() and then to
vmstate_save_state(f,
vdc->vmsd (=3D vmstate_virtio_snd_device), ...).

But, when and if somebody will analyze a migration stream (dump as
JSON, or just use tracepoints in migration subsystem), then
it is just more convenient to have distinctive names, IMHO.

>
> > Kind regards,
> > Alex
> >
> > >
> > > >+    .version_id =3D 1,
> > > >+    .minimum_version_id =3D 1,
> > > >     .fields =3D (const VMStateField[]) {
> > > >         VMSTATE_VIRTIO_DEVICE,
> > > >         VMSTATE_END_OF_LIST()
> > > >@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_comm=
and *cmd)
> > > >                  sizeof(virtio_snd_hdr));
> > > >     virtqueue_push(cmd->vq, cmd->elem,
> > > >                    sizeof(virtio_snd_hdr) + cmd->payload_size);
> > > >+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
> > >
> > > Let's do a g_assert that this is > 0 before decrementing it.
> >
> > Great idea, I will address this in v4.
> >
> > >
> > > >     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > > > }
> > > >
> > > >@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice =
*vdev, VirtQueue *vq)
> > > >
> > > >     elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > >     while (elem) {
> > > >+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> > > >         cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> > > >         cmd->elem =3D elem;
> > > >         cmd->vq =3D vq;
> > > >@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevi=
ce *vdev, VirtQueue *vq)
> > > >             goto tx_err;
> > > >         }
> > > >
> > > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> > > >         size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> > > >
> > > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> > > >@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODe=
vice *vdev, VirtQueue *vq)
> > > >             goto rx_err;
> > > >         }
> > > >
> > > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> > > >         size =3D iov_size(elem->in_sg, elem->in_num) -
> > > >             sizeof(virtio_snd_pcm_status);
> > > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> > > >@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIOSoun=
dPCMStream *stream,
> > > >     virtqueue_push(buffer->vq,
> > > >                    buffer->elem,
> > > >                    sizeof(virtio_snd_pcm_status));
> > > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
> > >
> > > Ditto
> >
> > +
> >
> > >
> > > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > > >     QSIMPLEQ_REMOVE(&stream->queue,
> > > >                     buffer,
> > > >@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIOSoun=
dPCMStream *stream,
> > > >     virtqueue_push(buffer->vq,
> > > >                    buffer->elem,
> > > >                    sizeof(virtio_snd_pcm_status) + buffer->size);
> > > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
> > >
> > > Ditto
> >
> > +
> >
> > >
> > > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > > >     QSIMPLEQ_REMOVE(&stream->queue,
> > > >                     buffer,
> > > >@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceState =
*dev)
> > > >     virtio_cleanup(vdev);
> > > > }
> > > >
> > > >+static int virtio_snd_post_load(VirtIODevice *vdev)
> > > >+{
> > > >+    VirtIOSound *s =3D VIRTIO_SND(vdev);
> > > >+    uint32_t i;
> > > >+
> > > >+    for (i =3D 0; i < s->snd_conf.streams; i++) {
> > > >+        struct VirtIOSoundPCMStream *stream;
> > > >+
> > > >+        stream =3D virtio_snd_pcm_get_stream(s, i);
> > > >+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > > >+            virtio_snd_pcm_open(stream);
> > > >+
> > > >+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
> > > >+                virtio_snd_pcm_set_active(stream, true);
> > > >+            }
> > > >+        }
> > > >+    }
> > > >+
> > > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > > >+        if (s->queue_inuse[i]) {
> > > >+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i]))=
 {
> > > >+                error_report(
> > > >+                    "virtio-snd: could not rewind %u elements in qu=
eue %u",
> > > >+                    s->queue_inuse[i], i);
> > > >+            }
> > > >+            s->queue_inuse[i] =3D 0;
> > > >+        }
> > > >+    }
> > > >+
> > > >+    return 0;
> > > >+}
> > > >
> > > > static void virtio_snd_reset(VirtIODevice *vdev)
> > > > {
> > > >@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice *vd=
ev)
> > > >             virtio_snd_pcm_buffer_free(buffer);
> > > >         }
> > > >     }
> > > >+
> > > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > > >+        vsnd->queue_inuse[i] =3D 0;
> > > >+    }
> > > > }
> > > >
> > > > static void virtio_snd_class_init(ObjectClass *klass, const void *d=
ata)
> > > >@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectClass =
*klass, const void *data)
> > > >
> > > >     dc->vmsd =3D &vmstate_virtio_snd;
> > > >     vdc->vmsd =3D &vmstate_virtio_snd_device;
> > > >+    vdc->post_load =3D virtio_snd_post_load;
> > > >     vdc->realize =3D virtio_snd_realize;
> > > >     vdc->unrealize =3D virtio_snd_unrealize;
> > > >     vdc->get_config =3D virtio_snd_get_config;
> > > >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio=
-snd.h
> > > >index 85d5d7c8619..384d2868c19 100644
> > > >--- a/include/hw/audio/virtio-snd.h
> > > >+++ b/include/hw/audio/virtio-snd.h
> > > >@@ -194,6 +194,7 @@ struct VirtIOSound {
> > > >     VirtIODevice parent_obj;
> > > >
> > > >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> > > >+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
> > > >     uint64_t features;
> > > >     VirtIOSoundPCMStream *streams;
> > > >     AudioBackend *audio_be;
> > > >--
> > > >2.47.3
> > > >
>
> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

