Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8IK-00023o-HF; Fri, 10 Jul 2026 06:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi8II-0001us-Mf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:17:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi8IG-0006eF-5U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:17:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so3630535e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783678634; cv=none;
 d=google.com; s=arc-20260327;
 b=cLA21pN7gZgKfzw+9WkyNBCN03rmVwMRdQW4T1B9RxyTQwMZfvJUSdLGxdhoN7QA9U
 qMkhE8FWbslMCLHQ1RpJPtN/3EKYhMpqQMOo9XZMt0iPvZV4KuZ4ifuEfMRO8Gg9kZZ4
 VrZp5RQpcMRL9Pe32fxZ/Le5sju4dgzRm8eP4plUgsyl73U/4p1855CN7kbTuqLKgyNo
 aUDihGKyCYPxC+TIl759EpARjyJ7JNZTWmV7hIr2vzy81PHiqQwuNXF5QSj4NOhQkxFd
 IlC1mcplR4M9ABbpL73g0elFwYoLWE69TcWa7e1m2yVBmIdGo/rinls3SPJoO/5SbKHp
 IW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cwCCDd4pgiqkjXRJcId6VvKBhAi1ITz2mMctf9wHpSY=;
 fh=8RUj9I7f+xWGgTMe9QkV6YSB9vzdqYA/iBz75JNnkZI=;
 b=n2HVDe7q5oOEF6JLvHxBBSSSluD5v9x2BuA7C40o7L9boTmjNybX03rs4FO7JDn74b
 aNL+rhA/dW9RuCGe2cRFS1nscRqfAULHyyrfVHuN0S6ZhWwebFF2IxrW7JlzzCvxvNxm
 dOqx08x3RYSuG+UTU24fH9CL74+maaQdK7VkJv5btvJsAYbJetutl/OyeGy0n6ZQrvfd
 YUAkXPV9c2b8Kg5p6oSRzn0fZcIs19S9m4tZmRITG4np+cfs+nIe/LKUTX8d37Esoo7W
 d+zX9iTaaqItZg6xaAs4T/dJWv336LgCXRSuW7AjPPsa3HdvcsAOsGCo+6s9L710mM4r
 qUoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783678634; x=1784283434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cwCCDd4pgiqkjXRJcId6VvKBhAi1ITz2mMctf9wHpSY=;
 b=xh9g5PRaiuhsBUtKEZAQxrUpdLJ3eJxY/peVmJc+k9xpORzZgjTUw2MhguqIlMUCKz
 0hRiO3k+avgDOP2/X81r6urBcWtD++iwWrtolQr7rAImBJS48mcSHq4+yYlJBr5JESV9
 kR1O/UBKb0m3dNHfmF7Ha1uY2e3X/IPvboddJvhF+GQ6ZUCWMClaanCKCt5yBN2FNXn3
 uc1/tUyNHoMawIXhM33QZJAwMul/iqVnInmC4ZyyUxQlgew61vonkxlbaQFymPeq9ZTC
 9mrU3crIfHGucPlJ2Ro+0vWajD6JkbW7UOooWdV4Mh42Z5XVznDGDWFHSsqkeVt9/rsy
 8zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783678634; x=1784283434;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cwCCDd4pgiqkjXRJcId6VvKBhAi1ITz2mMctf9wHpSY=;
 b=p1VjKWclKnBSl1JHpS5/a0i5eUSlmlTZR0/wyr/EKPh+1DzDHSMR3bXAm8QTU7CBHX
 HgMpci/1aGlelyKVvvu17t0ddNS/A/xWsW9v03TuU9KlAd08gO6gopSmbujmDwZkJ0Ck
 dbLWPRdgRbFkdqyo/9vogCy19IBknnlvg2GHHHMqtrxorSbg2wT+FMUZ4uRD3L+ZVX8X
 20lqI/1sYcEWi9ERK7XdcqFBVPwqE6tepIm5XU+7AflKkN7g83QhmY4fhDt+u98uyTyb
 0aM6gPWU/3VOORGzorIgMnghYjgPoUwWACzHrMqbb15QvxQxgH5uZ0Gh/u5Dtfokxc4s
 KkFw==
X-Gm-Message-State: AOJu0YzefWdN//jjPd5z2vH0B4GLy3kN6QeAYDs0ERPnGM0flemBhNmn
 B5dkaWPjG/xPO2wiiWPwV8K5+84bLoHWhlDVvYrdms3OX2EzEa6muwZszqXz+jEgw/ysDTtjIBO
 Ke1ps5O17PVeAlkXrCw7eEvT2atg/QuBVDYqrLcRZ7Q==
X-Gm-Gg: AfdE7cmR8UUMmsj9AMVNjoeUj4Zoqw1LQoIxc1HBkt6/j1DQu2JfkvUOSRGX/Y+DrnA
 JBIGAzR1fcUcP6i/JMnV/WCrQbIprClxx06dDWrnwM9B4ZTIxuDccrGL1oOXOhnUyMNkG8bdrQk
 4nL4z3eGKfzFL+WKNccnRZ+muTa05LBHtaclgkwalzi3at8tQBBZpejO8BTlelVSQKzsPCvtv6F
 HYAwUq/r8JTqjD5VllzsFC2LUWQjeZzB8uXO6dFxS39tNWnDcy7u76SZ6DFl1+7/cf7u5thNsr1
 /kAihTPVww1eHgUxPP8qS4HgCEwyqx5i1ZXrbf3rnjTokFJ3uCvbCguLCGPrzRW0nGCgOshboH7
 3vds3VrqTv7OqLjk3PEHJqOPT4tUNCEyaGndh5ynP3pp61NSQhsg=
X-Received: by 2002:a05:600c:8b17:b0:493:e6f7:ad75 with SMTP id
 5b1f17b1804b1-493e6f7afb1mr105293575e9.11.1783678633824; Fri, 10 Jul 2026
 03:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
 <thdwvg.71u440c3d5z8@linaro.org>
 <CAJqdLrrYyhmT4VCxe932Nb9VG+=x+EWZ+O5sZsKyQm4Zo_3GfQ@mail.gmail.com>
In-Reply-To: <CAJqdLrrYyhmT4VCxe932Nb9VG+=x+EWZ+O5sZsKyQm4Zo_3GfQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 10 Jul 2026 13:16:47 +0300
X-Gm-Features: AUfX_mxNMOIeR_9hj29yAmuJmrP_LgQgQL0rXKqCMD--wLC0_rlM0Im8uChqCGk
Message-ID: <CAAjaMXZ5UnGTf+Bxvro41PW_yXOS+mtz6T+KMmAVOKzRf8tEOA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] hw/audio/virtio-sound: add missing vmstate fields
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

On Fri, Jul 10, 2026 at 12:43=E2=80=AFPM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Mo., 29. Juni 2026 um 10:28 Uhr schrieb Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org>:
> >
> > On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.c=
om> wrote:
> > >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > >
> > >The virtio-sound device is currently not migratable. Add the
> > >missing VMSTATE fields, enable migration and reconnect the audio
> > >streams after migration.
> > >
> > >The queue_inuse[] array variables mimic the inuse variable in
> > >struct VirtQueue which is private. They are needed to restart
> > >the virtio queues after migration.
> > >
> > >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > >[AM: trivial rebase changes]
> > >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusio=
n.io>
> > >---
> > >v3:
> > >       - added latency_bytes field to VMStateDescription
> > >
> > >       As suggested by Marc-Andr=C3=A9 Lureau:
> > >       - removed the "rc" variable from virtio_snd_post_load()
> > >       - dropped info field from VMStateDescription, because
> > >         it can't be modified by guest and initialized only from reali=
ze
> > >       - added minimum_version_id/version_id so we can extend VMStateD=
escription
> > >         without breaking compatibility in the future
> > >---
> > > hw/audio/virtio-snd.c         | 80 +++++++++++++++++++++++++++++++---=
-
> > > include/hw/audio/virtio-snd.h |  1 +
> > > 2 files changed, 73 insertions(+), 8 deletions(-)
> > >
> > >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > >index 81ba1e1a277..7af0b63c03b 100644
> > >--- a/hw/audio/virtio-snd.c
> > >+++ b/hw/audio/virtio-snd.c
> > >@@ -24,7 +24,6 @@
> > > #include "qapi/error.h"
> > > #include "hw/audio/virtio-snd.h"
> > >
> > >-#define VIRTIO_SOUND_VM_VERSION 1
> > > #define VIRTIO_SOUND_JACK_DEFAULT 0
> > > #define VIRTIO_SOUND_STREAM_DEFAULT 2
> > > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > >@@ -78,17 +77,40 @@ static uint32_t supported_rates =3D BIT(VIRTIO_SND=
_PCM_RATE_5512)
> > >                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
> > >                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
> > >
> > >+static const VMStateDescription vmstate_virtio_snd_stream =3D {
> > >+    .name =3D "virtio-sound-stream",
> > >+    .version_id =3D 1,
> > >+    .minimum_version_id =3D 1,
> > >+    .fields =3D (const VMStateField[]) {
> > >+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> > >+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
> > >+        VMSTATE_END_OF_LIST()
> > >+    },
> > >+};
> > >+
> > > static const VMStateDescription vmstate_virtio_snd_device =3D {
> > >-    .name =3D TYPE_VIRTIO_SND,
> > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > >+    .name =3D "virtio-sound-device",
> > >+    .version_id =3D 1,
> > >+    .minimum_version_id =3D 1,
> > >+    .fields =3D (const VMStateField[]) {
> > >+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_=
MAX),
> > >+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
> > >+            snd_conf.streams,
> > >+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> > >+        VMSTATE_END_OF_LIST()
> > >+    },
> > > };
> > >
> > > static const VMStateDescription vmstate_virtio_snd =3D {
> > >-    .name =3D TYPE_VIRTIO_SND,
> > >-    .unmigratable =3D 1,
> > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > >+    .name =3D "virtio-sound",
>
> Dear Manos,
>
> >
> > Why change the name? It differentiates between the device impl and
> > virtio-sound-pci wrapper device.
>
> I'm not sure that I understand this point. Before this patch both
> vmstate_virtio_snd and vmstate_virtio_snd_device
> had the same name TYPE_VIRTIO_SND, we are trying to give the
> distinctive names here. Please, elaborate on this.

Ah, I misunderstood the change then. The name must be unique for the
vmstate to be migrateable, right?

> Kind regards,
> Alex
>
> >
> > >+    .version_id =3D 1,
> > >+    .minimum_version_id =3D 1,
> > >     .fields =3D (const VMStateField[]) {
> > >         VMSTATE_VIRTIO_DEVICE,
> > >         VMSTATE_END_OF_LIST()
> > >@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_comman=
d *cmd)
> > >                  sizeof(virtio_snd_hdr));
> > >     virtqueue_push(cmd->vq, cmd->elem,
> > >                    sizeof(virtio_snd_hdr) + cmd->payload_size);
> > >+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
> >
> > Let's do a g_assert that this is > 0 before decrementing it.
>
> Great idea, I will address this in v4.
>
> >
> > >     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > > }
> > >
> > >@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *v=
dev, VirtQueue *vq)
> > >
> > >     elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > >     while (elem) {
> > >+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> > >         cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> > >         cmd->elem =3D elem;
> > >         cmd->vq =3D vq;
> > >@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
> > >             goto tx_err;
> > >         }
> > >
> > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> > >         size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> > >
> > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> > >@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevi=
ce *vdev, VirtQueue *vq)
> > >             goto rx_err;
> > >         }
> > >
> > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> > >         size =3D iov_size(elem->in_sg, elem->in_num) -
> > >             sizeof(virtio_snd_pcm_status);
> > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> > >@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIOSoundP=
CMStream *stream,
> > >     virtqueue_push(buffer->vq,
> > >                    buffer->elem,
> > >                    sizeof(virtio_snd_pcm_status));
> > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
> >
> > Ditto
>
> +
>
> >
> > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > >     QSIMPLEQ_REMOVE(&stream->queue,
> > >                     buffer,
> > >@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIOSoundP=
CMStream *stream,
> > >     virtqueue_push(buffer->vq,
> > >                    buffer->elem,
> > >                    sizeof(virtio_snd_pcm_status) + buffer->size);
> > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
> >
> > Ditto
>
> +
>
> >
> > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > >     QSIMPLEQ_REMOVE(&stream->queue,
> > >                     buffer,
> > >@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceState *d=
ev)
> > >     virtio_cleanup(vdev);
> > > }
> > >
> > >+static int virtio_snd_post_load(VirtIODevice *vdev)
> > >+{
> > >+    VirtIOSound *s =3D VIRTIO_SND(vdev);
> > >+    uint32_t i;
> > >+
> > >+    for (i =3D 0; i < s->snd_conf.streams; i++) {
> > >+        struct VirtIOSoundPCMStream *stream;
> > >+
> > >+        stream =3D virtio_snd_pcm_get_stream(s, i);
> > >+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > >+            virtio_snd_pcm_open(stream);
> > >+
> > >+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
> > >+                virtio_snd_pcm_set_active(stream, true);
> > >+            }
> > >+        }
> > >+    }
> > >+
> > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > >+        if (s->queue_inuse[i]) {
> > >+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i])) {
> > >+                error_report(
> > >+                    "virtio-snd: could not rewind %u elements in queu=
e %u",
> > >+                    s->queue_inuse[i], i);
> > >+            }
> > >+            s->queue_inuse[i] =3D 0;
> > >+        }
> > >+    }
> > >+
> > >+    return 0;
> > >+}
> > >
> > > static void virtio_snd_reset(VirtIODevice *vdev)
> > > {
> > >@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice *vdev=
)
> > >             virtio_snd_pcm_buffer_free(buffer);
> > >         }
> > >     }
> > >+
> > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > >+        vsnd->queue_inuse[i] =3D 0;
> > >+    }
> > > }
> > >
> > > static void virtio_snd_class_init(ObjectClass *klass, const void *dat=
a)
> > >@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectClass *k=
lass, const void *data)
> > >
> > >     dc->vmsd =3D &vmstate_virtio_snd;
> > >     vdc->vmsd =3D &vmstate_virtio_snd_device;
> > >+    vdc->post_load =3D virtio_snd_post_load;
> > >     vdc->realize =3D virtio_snd_realize;
> > >     vdc->unrealize =3D virtio_snd_unrealize;
> > >     vdc->get_config =3D virtio_snd_get_config;
> > >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-s=
nd.h
> > >index 85d5d7c8619..384d2868c19 100644
> > >--- a/include/hw/audio/virtio-snd.h
> > >+++ b/include/hw/audio/virtio-snd.h
> > >@@ -194,6 +194,7 @@ struct VirtIOSound {
> > >     VirtIODevice parent_obj;
> > >
> > >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> > >+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
> > >     uint64_t features;
> > >     VirtIOSoundPCMStream *streams;
> > >     AudioBackend *audio_be;
> > >--
> > >2.47.3
> > >

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

