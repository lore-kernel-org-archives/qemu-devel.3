Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3620BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8pP-0005SP-HD; Fri, 10 Jul 2026 06:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi8pN-0005S7-2i
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:51:29 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wi8p9-0000Qd-IL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:51:18 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so164929666b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783680673; cv=none;
 d=google.com; s=arc-20260327;
 b=l+HH1igA8j68NO7Eu36H/4bqk94BzTqiqdkr7zaiEcKZiVriwpV8Gy2bJBjGG76jFc
 R+gM/F24lqm6Z7k1FsHQL/12/IHwfHcn/R4zCPff/KiUaIm8DQzHu1kXhjZ1fOjXChel
 jaHIFSHpTeguNt/4w+77ZKfcn1xn00EMhnLhD+n/ro+LfnhWUPkWg9ZTJDZJNI/S41sS
 tzlf6UEAZQHeyQd9ySLevq5MhX5KDaW909KE5hqEV3vzPf8wTAxq0vGktNq2Kh2rXKM4
 OQmINZAqoXDh82ckalbfWKlgS/CFIa9gm96QrmxxFGnBvra1bp/AR/NVLZow9qyZtf81
 6UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9igmehdSkC6icuWDcEH92hwZo0g6spli6J+ixGpT3NI=;
 fh=qty3g77Sl39ix/vs6vEQferIpKkxxHZnWW1uZOZG04Y=;
 b=R2BxRHRYPC/wdpkR/fHeGztfgFPX7He7FV2h8AiwiZNezX8aqDf+O/1GYN/MLrltQg
 gPNBaic8d7bGrqH9hiCHC4jodHkiGmjSs2nOBS4JaBVKOdVQX1hAvkQcHrT+xdqeMr2u
 U7M5W5ezOoco6iC1FCe0jEymLkPpD1W28wz4Q3FpnDVFVU89P8r4tzICnZVydcGLMgN6
 R81/70l3hYBu2CJV91sbY5wHCrpjYjl52iffdN8GRpxs3BOsCJa6FrpQ9Dc54g3xBLI4
 yalDzuTNI8UQ6dmsCDA5/DlNjKRyI5AXLhQ6H7+s+UYWt5uwR1ppi6DwwoRXQpViokxZ
 W2QQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783680673; x=1784285473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9igmehdSkC6icuWDcEH92hwZo0g6spli6J+ixGpT3NI=;
 b=Sw6n9rC3+2pnITJbI1mkWl/FRrBL2WwZTE+uENJjrgaTeGvjB0rg75MnN7bxHsealW
 xgc6Jg8zNWbUA4YELmtBQKFXPLW2mSaoFybG+jTaJdRcMYatE93ay2OBq8M960Exq2fF
 jA4T+ZetH1aFl51O4c/aV61+9/KgIBZ8sv8s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783680673; x=1784285473;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9igmehdSkC6icuWDcEH92hwZo0g6spli6J+ixGpT3NI=;
 b=etERBmClTavXgS9yZsCsy0ZS8PEan8kxdF1jgHD9tY7nBkDaIMLw6yo4Dnloc22t4a
 gW2mtS2jECEd3pq/e5TNF9dR2bWL/+zl6dV/Z2493VwSvk0zNpkge+bnAbcP6nxZ85ak
 yUQd6CAEvY2BHZCtF8A2n9lIypf95xuVGFa3ZGRaXM/AcEWpEyQWuc/85bmSV9V8IQI9
 dMqIHIeGBH4uynwcpsKJjNjXkNxB9LM/WrWo59UFqacCUz921lBDrBKW3lkQDURZhr7N
 Cb3J52Kmm1HnqgKX2DNsMmbnH2hw5dd1ZWMooADFINUq8YhsepFQBiQwMA4hUJK1VYXm
 qhmA==
X-Gm-Message-State: AOJu0Yzlygb4uSR5eqsVmlEF2LU2jg07ejp8UgsZ5Ip5PckgW2A5utKA
 ZV4vwV7mvHS7y682sBrzOc3EBUQBtt7PPT43RsUH7e5IHRqm3PIQKc8r0pw6OZlMbhw6vsrKv5k
 Q6hlpy74/6+c3xGHdHjqWxaCoNyp44m8CRDNlt6epzw==
X-Gm-Gg: AfdE7clXqoT7Arej0+bz8rzPIjV7k48VDhbofAlLCwtR1zr2ZVip+97LUfJ/u8EY6Fk
 hNfMRIy5nfwM8V4GGq2yr3CI8tIGBd+9rTetgGIMd9+FDT+yDNP38QbnmjLFpTC5bc0VWpGsCBu
 Dwlm7jy9p88vc6kaAXWwf+BnW8jgghjniM3Eg+f7BETESirBWmu8qWKYsUbM+983oq6BK+oM+di
 fjNa7RYTWBDkC/ws96FcAzfU8Zh6nCKYLdbIyHApVy801mE9qWBD2Z7k2BnWpZ0o7jpyjC3cQIw
 cY2Zsw7+ue9umdwlMDkLAjCgnGY=
X-Received: by 2002:a17:907:1c27:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c15fee47b97mr148685966b.10.1783680671902; Fri, 10 Jul 2026
 03:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
 <thdwvg.71u440c3d5z8@linaro.org>
 <CAJqdLrrYyhmT4VCxe932Nb9VG+=x+EWZ+O5sZsKyQm4Zo_3GfQ@mail.gmail.com>
 <CAAjaMXZ5UnGTf+Bxvro41PW_yXOS+mtz6T+KMmAVOKzRf8tEOA@mail.gmail.com>
 <CAJqdLroXAOY9t3MM1_pbNdX=Zs0DQn_b8kws_qbj-1=u7NPkrA@mail.gmail.com>
 <CAAjaMXb8i+bZU2WgiJxi4aPMpjkDJN2=xuHxU3L0z+Ft8OLYNA@mail.gmail.com>
In-Reply-To: <CAAjaMXb8i+bZU2WgiJxi4aPMpjkDJN2=xuHxU3L0z+Ft8OLYNA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 10 Jul 2026 12:51:00 +0200
X-Gm-Features: AUfX_mx4RSNf_KmMIIoItWCJUGNJBk1ILK6mI1nsU_7nAyiOjs2zgXA306N6vCw
Message-ID: <CAJqdLro+i37GPSq435XqhHAiDm-xHRfQ_+k+bXbr=Xr4hgktGQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x632.google.com
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

Am Fr., 10. Juli 2026 um 12:48 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Fri, Jul 10, 2026 at 1:32=E2=80=AFPM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > Am Fr., 10. Juli 2026 um 12:17 Uhr schrieb Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org>:
> > >
> > > On Fri, Jul 10, 2026 at 12:43=E2=80=AFPM Alexander Mikhalitsyn
> > > <alexander@mihalicyn.com> wrote:
> > > >
> > > > Am Mo., 29. Juni 2026 um 10:28 Uhr schrieb Manos Pitsidianakis
> > > > <manos.pitsidianakis@linaro.org>:
> > > > >
> > > > > On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihal=
icyn.com> wrote:
> > > > > >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > > > >
> > > > > >The virtio-sound device is currently not migratable. Add the
> > > > > >missing VMSTATE fields, enable migration and reconnect the audio
> > > > > >streams after migration.
> > > > > >
> > > > > >The queue_inuse[] array variables mimic the inuse variable in
> > > > > >struct VirtQueue which is private. They are needed to restart
> > > > > >the virtio queues after migration.
> > > > > >
> > > > > >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > > > >[AM: trivial rebase changes]
> > > > > >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futu=
rfusion.io>
> > > > > >---
> > > > > >v3:
> > > > > >       - added latency_bytes field to VMStateDescription
> > > > > >
> > > > > >       As suggested by Marc-Andr=C3=A9 Lureau:
> > > > > >       - removed the "rc" variable from virtio_snd_post_load()
> > > > > >       - dropped info field from VMStateDescription, because
> > > > > >         it can't be modified by guest and initialized only from=
 realize
> > > > > >       - added minimum_version_id/version_id so we can extend VM=
StateDescription
> > > > > >         without breaking compatibility in the future
> > > > > >---
> > > > > > hw/audio/virtio-snd.c         | 80 ++++++++++++++++++++++++++++=
+++----
> > > > > > include/hw/audio/virtio-snd.h |  1 +
> > > > > > 2 files changed, 73 insertions(+), 8 deletions(-)
> > > > > >
> > > > > >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > > > > >index 81ba1e1a277..7af0b63c03b 100644
> > > > > >--- a/hw/audio/virtio-snd.c
> > > > > >+++ b/hw/audio/virtio-snd.c
> > > > > >@@ -24,7 +24,6 @@
> > > > > > #include "qapi/error.h"
> > > > > > #include "hw/audio/virtio-snd.h"
> > > > > >
> > > > > >-#define VIRTIO_SOUND_VM_VERSION 1
> > > > > > #define VIRTIO_SOUND_JACK_DEFAULT 0
> > > > > > #define VIRTIO_SOUND_STREAM_DEFAULT 2
> > > > > > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > > > > >@@ -78,17 +77,40 @@ static uint32_t supported_rates =3D BIT(VIRT=
IO_SND_PCM_RATE_5512)
> > > > > >                                 | BIT(VIRTIO_SND_PCM_RATE_19200=
0)
> > > > > >                                 | BIT(VIRTIO_SND_PCM_RATE_38400=
0);
> > > > > >
> > > > > >+static const VMStateDescription vmstate_virtio_snd_stream =3D {
> > > > > >+    .name =3D "virtio-sound-stream",
> > > > > >+    .version_id =3D 1,
> > > > > >+    .minimum_version_id =3D 1,
> > > > > >+    .fields =3D (const VMStateField[]) {
> > > > > >+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStrea=
m),
> > > > > >+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStrea=
m),
> > > > > >+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_END_OF_LIST()
> > > > > >+    },
> > > > > >+};
> > > > > >+
> > > > > > static const VMStateDescription vmstate_virtio_snd_device =3D {
> > > > > >-    .name =3D TYPE_VIRTIO_SND,
> > > > > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > > >+    .name =3D "virtio-sound-device",
> > > > > >+    .version_id =3D 1,
> > > > > >+    .minimum_version_id =3D 1,
> > > > > >+    .fields =3D (const VMStateField[]) {
> > > > > >+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_S=
ND_VQ_MAX),
> > > > > >+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSou=
nd,
> > > > > >+            snd_conf.streams,
> > > > > >+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> > > > > >+        VMSTATE_END_OF_LIST()
> > > > > >+    },
> > > > > > };
> > > > > >
> > > > > > static const VMStateDescription vmstate_virtio_snd =3D {
> > > > > >-    .name =3D TYPE_VIRTIO_SND,
> > > > > >-    .unmigratable =3D 1,
> > > > > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > > >+    .name =3D "virtio-sound",
> > > >
> > > > Dear Manos,
> > > >
> > > > >
> > > > > Why change the name? It differentiates between the device impl an=
d
> > > > > virtio-sound-pci wrapper device.
> > > >
> > > > I'm not sure that I understand this point. Before this patch both
> > > > vmstate_virtio_snd and vmstate_virtio_snd_device
> > > > had the same name TYPE_VIRTIO_SND, we are trying to give the
> > > > distinctive names here. Please, elaborate on this.
> > >
> > > Ah, I misunderstood the change then. The name must be unique for the
> > > vmstate to be migrateable, right?
> >
> > I don't think that it is a strict requirement, because, basically
> > vmstate_virtio_snd_device is implicitly nested in vmstate_virtio_snd.
> >
> > In vmstate_virtio_snd we only have VMSTATE_VIRTIO_DEVICE as a VMStateFi=
eld,
> > which, in turn leads migration engine to virtio_save() and then to
> > vmstate_save_state(f,
> > vdc->vmsd (=3D vmstate_virtio_snd_device), ...).
> >
> > But, when and if somebody will analyze a migration stream (dump as
> > JSON, or just use tracepoints in migration subsystem), then
> > it is just more convenient to have distinctive names, IMHO.
>
> Makes sense, thanks for the explanation.

Thank you for reviews ;-)

>
> > >
> > > > Kind regards,
> > > > Alex
> > > >
> > > > >
> > > > > >+    .version_id =3D 1,
> > > > > >+    .minimum_version_id =3D 1,
> > > > > >     .fields =3D (const VMStateField[]) {
> > > > > >         VMSTATE_VIRTIO_DEVICE,
> > > > > >         VMSTATE_END_OF_LIST()
> > > > > >@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_=
command *cmd)
> > > > > >                  sizeof(virtio_snd_hdr));
> > > > > >     virtqueue_push(cmd->vq, cmd->elem,
> > > > > >                    sizeof(virtio_snd_hdr) + cmd->payload_size);
> > > > > >+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
> > > > >
> > > > > Let's do a g_assert that this is > 0 before decrementing it.
> > > >
> > > > Great idea, I will address this in v4.
> > > >
> > > > >
> > > > > >     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > > > > > }
> > > > > >
> > > > > >@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODev=
ice *vdev, VirtQueue *vq)
> > > > > >
> > > > > >     elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > > > >     while (elem) {
> > > > > >+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> > > > > >         cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> > > > > >         cmd->elem =3D elem;
> > > > > >         cmd->vq =3D vq;
> > > > > >@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIO=
Device *vdev, VirtQueue *vq)
> > > > > >             goto tx_err;
> > > > > >         }
> > > > > >
> > > > > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> > > > > >         size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz=
;
> > > > > >
> > > > > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + siz=
e);
> > > > > >@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(Virt=
IODevice *vdev, VirtQueue *vq)
> > > > > >             goto rx_err;
> > > > > >         }
> > > > > >
> > > > > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> > > > > >         size =3D iov_size(elem->in_sg, elem->in_num) -
> > > > > >             sizeof(virtio_snd_pcm_status);
> > > > > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + siz=
e);
> > > > > >@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIO=
SoundPCMStream *stream,
> > > > > >     virtqueue_push(buffer->vq,
> > > > > >                    buffer->elem,
> > > > > >                    sizeof(virtio_snd_pcm_status));
> > > > > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
> > > > >
> > > > > Ditto
> > > >
> > > > +
> > > >
> > > > >
> > > > > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > > > > >     QSIMPLEQ_REMOVE(&stream->queue,
> > > > > >                     buffer,
> > > > > >@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIO=
SoundPCMStream *stream,
> > > > > >     virtqueue_push(buffer->vq,
> > > > > >                    buffer->elem,
> > > > > >                    sizeof(virtio_snd_pcm_status) + buffer->size=
);
> > > > > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
> > > > >
> > > > > Ditto
> > > >
> > > > +
> > > >
> > > > >
> > > > > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > > > > >     QSIMPLEQ_REMOVE(&stream->queue,
> > > > > >                     buffer,
> > > > > >@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceSt=
ate *dev)
> > > > > >     virtio_cleanup(vdev);
> > > > > > }
> > > > > >
> > > > > >+static int virtio_snd_post_load(VirtIODevice *vdev)
> > > > > >+{
> > > > > >+    VirtIOSound *s =3D VIRTIO_SND(vdev);
> > > > > >+    uint32_t i;
> > > > > >+
> > > > > >+    for (i =3D 0; i < s->snd_conf.streams; i++) {
> > > > > >+        struct VirtIOSoundPCMStream *stream;
> > > > > >+
> > > > > >+        stream =3D virtio_snd_pcm_get_stream(s, i);
> > > > > >+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > > > > >+            virtio_snd_pcm_open(stream);
> > > > > >+
> > > > > >+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) =
{
> > > > > >+                virtio_snd_pcm_set_active(stream, true);
> > > > > >+            }
> > > > > >+        }
> > > > > >+    }
> > > > > >+
> > > > > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > > > > >+        if (s->queue_inuse[i]) {
> > > > > >+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[=
i])) {
> > > > > >+                error_report(
> > > > > >+                    "virtio-snd: could not rewind %u elements i=
n queue %u",
> > > > > >+                    s->queue_inuse[i], i);
> > > > > >+            }
> > > > > >+            s->queue_inuse[i] =3D 0;
> > > > > >+        }
> > > > > >+    }
> > > > > >+
> > > > > >+    return 0;
> > > > > >+}
> > > > > >
> > > > > > static void virtio_snd_reset(VirtIODevice *vdev)
> > > > > > {
> > > > > >@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice=
 *vdev)
> > > > > >             virtio_snd_pcm_buffer_free(buffer);
> > > > > >         }
> > > > > >     }
> > > > > >+
> > > > > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > > > > >+        vsnd->queue_inuse[i] =3D 0;
> > > > > >+    }
> > > > > > }
> > > > > >
> > > > > > static void virtio_snd_class_init(ObjectClass *klass, const voi=
d *data)
> > > > > >@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectCl=
ass *klass, const void *data)
> > > > > >
> > > > > >     dc->vmsd =3D &vmstate_virtio_snd;
> > > > > >     vdc->vmsd =3D &vmstate_virtio_snd_device;
> > > > > >+    vdc->post_load =3D virtio_snd_post_load;
> > > > > >     vdc->realize =3D virtio_snd_realize;
> > > > > >     vdc->unrealize =3D virtio_snd_unrealize;
> > > > > >     vdc->get_config =3D virtio_snd_get_config;
> > > > > >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/vi=
rtio-snd.h
> > > > > >index 85d5d7c8619..384d2868c19 100644
> > > > > >--- a/include/hw/audio/virtio-snd.h
> > > > > >+++ b/include/hw/audio/virtio-snd.h
> > > > > >@@ -194,6 +194,7 @@ struct VirtIOSound {
> > > > > >     VirtIODevice parent_obj;
> > > > > >
> > > > > >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> > > > > >+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
> > > > > >     uint64_t features;
> > > > > >     VirtIOSoundPCMStream *streams;
> > > > > >     AudioBackend *audio_be;
> > > > > >--
> > > > > >2.47.3
> > > > > >
> > >
> > > --
> > > Manos Pitsidianakis
> > > Emulation and Virtualization Engineer at Linaro Ltd
>
> --
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

