Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D68C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8mA-00031x-Du; Fri, 10 Jul 2026 06:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi8m7-00031j-QE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:48:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wi8m5-0008LK-F9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:48:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so775716f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783680483; cv=none;
 d=google.com; s=arc-20260327;
 b=p3eVaSwQR6Av8sLTsAip4gFWsUZiUWSJLHLeW6UJEhe2ThPqkINF6eVf37jcqFqXFl
 rS3poKtj+hrJdRocJEx8g9Fh2MrcEmky84aQkLaOr7+Z4dwoM+PtYIUJr4IGLmuRjgtd
 /I+uKLDIhCJQTDmpq8MZRvZCZ01uaZ+KGdIk/GBlBKUSNKk7dZtUytj1g+Q/G5dG5sJW
 SMBy2IX2VmD4IMcRDGiwJq2QVsAxgSoT6ePDqcLsWrvDoOuqTNtLycQEngZJBoBHCDvR
 sIBQ42isqHeWYbfIRP3OSLbVBIDxgd6tpV6DjFruL6rXtWn1bRTfOzM9kJ4imgGTcSmM
 IHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bQxTY+mCkKpReBfUiFz+QLHJ3T1ShB4xI9eK4y/GkWo=;
 fh=8RUj9I7f+xWGgTMe9QkV6YSB9vzdqYA/iBz75JNnkZI=;
 b=ZvHxIznVSOlNPX2PMNM5tmbdpDqaS8E6Nd9ijlor3m4FIifeAo+164NO2VGf53zmAk
 7HxYAl4WyCbJsAerLl9YNq5zru+KlN8Xx0WB/jY2HYmEvo9RjWUR4glJEC0Zu+7SBrLn
 rsS2znK7UQdRPpvaVbKQAv8AnznGd+MCQur6jvub8d48EV1cTu4ilEs3sCuiQlJlxEy8
 SRvCu8JwZyClVj7p43dw3rZDx1pVNz0fAE1jDWLjrIFYqVzrpY7d5oHjMI0Qs6sZ2RUv
 7dV1HMfvQfx26ibmKmsZeMvOv9FCTV6wJTQKxa8CX/G/nQeqoiJtZxho8akCBmuAo5Wc
 20iQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783680483; x=1784285283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bQxTY+mCkKpReBfUiFz+QLHJ3T1ShB4xI9eK4y/GkWo=;
 b=aGsrxXtCCpFkfthdJNFB5omgh7Pdz5yi43ZwXdhUgiJ7vlNLRNTKgXW5jnGPu033Yz
 I37rHAW63eUjQnOzc9zlS5yc5JcJUykNs7pXYyqJ19lBZYKRoKsrReIwlupBcXLGMl66
 hMn1aMDNVAO+zaor50EpIsiLVYVV3xRSugRrWZ8auyWISJobNY1N5L7IY8VTosnrHRty
 0cI+BuyehnZbPQKQ26fYXjkMo8I8hJctrEU2U/B0+qAqu9oZVmVnQONMPVJfjyxtV55H
 ASmipXMElciBGYwnBiHrJetllkQyZDjOQ/6cY/pSAMtD5sI7BKik10BHtt2xMsj57cH9
 xQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783680483; x=1784285283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bQxTY+mCkKpReBfUiFz+QLHJ3T1ShB4xI9eK4y/GkWo=;
 b=i4A1xnmBgE0jYIUUCk5gMJAcbxI4vJ//jaMt34SO9xOGky+EDpjC5Dh88vDUsQLG1r
 K9RZQVDKL0O+F7Sp0pLXrczznZim4wfuj7mt8XJRr44EFgQj3UO+fNij3WFi6CRRClFV
 sS9f7OVsC6kxGecil5DYIG3ErnUz7p/14CkLf+OwO5IU5zGx5+mlmDoeLmS/A8FY4WWe
 jM/RyOdA1eRzBCtzHoe8d6MEDGnlJy/BvqBagm++HKLQIVA6yVirsa9/J3F8t8ydhdkc
 W3lqFvHiU+9MjcStD4FNXM0vOPAYK1dsgBa5DlyStUiSW4ksy3+FBu1U8xLIPFrIALWv
 nGUQ==
X-Gm-Message-State: AOJu0YwPmCtG7Dd14Mvqf1kHdv8ToHNDDcESX7ZAuKLPiF+UWxC3YzlB
 rN18LgM9UjCnPm1+7tDC2MfBjKKVaf1VwGnBRFEYqvUyoqo8pzCP5Vs/cIeyRpoTz6lByghiBi8
 eF02v4rfmTi1e2MqxLnLQLFWK/Q0UOjHFmaLOuJ/nNw==
X-Gm-Gg: AfdE7ckWA+/PtLyCj1oIVBcwsoFqu2IynCq8aw1qXcOiIV5L36uBG7WNLDdwuC2GBw3
 sBJv3M13rtCj7M7RKJuWnBRpf/scv/xX/0fH8a4yJSyl931h7uhfuAXihI9fmeBawOg952ldpdo
 RNIW59DdKLcCFpAU2+AYNc9oELgJtsGFcKReH/sIfWOcUw7bSFnuj+wUtMJA3ktsL7LrQ/i8Od/
 vLQbYe3KUXrpHWViJoLRJkSJGPB5bEKuZsiT2icWH7G18qF2hgJ0kJrCETkhYf1QFYpFHihU9tV
 TKshSYlM8FKpdZtmkviXvL12gJvKavtN4+jf68Ll/deryqhg3e2/SPIB5bxC/QB1Aq1phoferZq
 nC2KsYEsZUuOeTQjomKdJYPbPRgxSYxbZYHrmo+Jwd8GJhh1PCmQ=
X-Received: by 2002:a05:6000:41c2:b0:475:f100:35f4 with SMTP id
 ffacd0b85a97d-47df076fa8emr14224258f8f.49.1783680482727; Fri, 10 Jul 2026
 03:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-10-alexander@mihalicyn.com>
 <thdwvg.71u440c3d5z8@linaro.org>
 <CAJqdLrrYyhmT4VCxe932Nb9VG+=x+EWZ+O5sZsKyQm4Zo_3GfQ@mail.gmail.com>
 <CAAjaMXZ5UnGTf+Bxvro41PW_yXOS+mtz6T+KMmAVOKzRf8tEOA@mail.gmail.com>
 <CAJqdLroXAOY9t3MM1_pbNdX=Zs0DQn_b8kws_qbj-1=u7NPkrA@mail.gmail.com>
In-Reply-To: <CAJqdLroXAOY9t3MM1_pbNdX=Zs0DQn_b8kws_qbj-1=u7NPkrA@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 10 Jul 2026 13:47:35 +0300
X-Gm-Features: AUfX_mwaKRFrY8X-WellCjAXKmNnlYilYNXbdr0HBV707ua1cMlUHaA0HhLdnbg
Message-ID: <CAAjaMXb8i+bZU2WgiJxi4aPMpjkDJN2=xuHxU3L0z+Ft8OLYNA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Fri, Jul 10, 2026 at 1:32=E2=80=AFPM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Fr., 10. Juli 2026 um 12:17 Uhr schrieb Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org>:
> >
> > On Fri, Jul 10, 2026 at 12:43=E2=80=AFPM Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > Am Mo., 29. Juni 2026 um 10:28 Uhr schrieb Manos Pitsidianakis
> > > <manos.pitsidianakis@linaro.org>:
> > > >
> > > > On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalic=
yn.com> wrote:
> > > > >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > > >
> > > > >The virtio-sound device is currently not migratable. Add the
> > > > >missing VMSTATE fields, enable migration and reconnect the audio
> > > > >streams after migration.
> > > > >
> > > > >The queue_inuse[] array variables mimic the inuse variable in
> > > > >struct VirtQueue which is private. They are needed to restart
> > > > >the virtio queues after migration.
> > > > >
> > > > >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > > >[AM: trivial rebase changes]
> > > > >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurf=
usion.io>
> > > > >---
> > > > >v3:
> > > > >       - added latency_bytes field to VMStateDescription
> > > > >
> > > > >       As suggested by Marc-Andr=C3=A9 Lureau:
> > > > >       - removed the "rc" variable from virtio_snd_post_load()
> > > > >       - dropped info field from VMStateDescription, because
> > > > >         it can't be modified by guest and initialized only from r=
ealize
> > > > >       - added minimum_version_id/version_id so we can extend VMSt=
ateDescription
> > > > >         without breaking compatibility in the future
> > > > >---
> > > > > hw/audio/virtio-snd.c         | 80 ++++++++++++++++++++++++++++++=
+----
> > > > > include/hw/audio/virtio-snd.h |  1 +
> > > > > 2 files changed, 73 insertions(+), 8 deletions(-)
> > > > >
> > > > >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > > > >index 81ba1e1a277..7af0b63c03b 100644
> > > > >--- a/hw/audio/virtio-snd.c
> > > > >+++ b/hw/audio/virtio-snd.c
> > > > >@@ -24,7 +24,6 @@
> > > > > #include "qapi/error.h"
> > > > > #include "hw/audio/virtio-snd.h"
> > > > >
> > > > >-#define VIRTIO_SOUND_VM_VERSION 1
> > > > > #define VIRTIO_SOUND_JACK_DEFAULT 0
> > > > > #define VIRTIO_SOUND_STREAM_DEFAULT 2
> > > > > #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > > > >@@ -78,17 +77,40 @@ static uint32_t supported_rates =3D BIT(VIRTIO=
_SND_PCM_RATE_5512)
> > > > >                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
> > > > >                                 | BIT(VIRTIO_SND_PCM_RATE_384000)=
;
> > > > >
> > > > >+static const VMStateDescription vmstate_virtio_snd_stream =3D {
> > > > >+    .name =3D "virtio-sound-stream",
> > > > >+    .version_id =3D 1,
> > > > >+    .minimum_version_id =3D 1,
> > > > >+    .fields =3D (const VMStateField[]) {
> > > > >+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream)=
,
> > > > >+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream)=
,
> > > > >+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_END_OF_LIST()
> > > > >+    },
> > > > >+};
> > > > >+
> > > > > static const VMStateDescription vmstate_virtio_snd_device =3D {
> > > > >-    .name =3D TYPE_VIRTIO_SND,
> > > > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > >+    .name =3D "virtio-sound-device",
> > > > >+    .version_id =3D 1,
> > > > >+    .minimum_version_id =3D 1,
> > > > >+    .fields =3D (const VMStateField[]) {
> > > > >+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND=
_VQ_MAX),
> > > > >+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound=
,
> > > > >+            snd_conf.streams,
> > > > >+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
> > > > >+        VMSTATE_END_OF_LIST()
> > > > >+    },
> > > > > };
> > > > >
> > > > > static const VMStateDescription vmstate_virtio_snd =3D {
> > > > >-    .name =3D TYPE_VIRTIO_SND,
> > > > >-    .unmigratable =3D 1,
> > > > >-    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > >-    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> > > > >+    .name =3D "virtio-sound",
> > >
> > > Dear Manos,
> > >
> > > >
> > > > Why change the name? It differentiates between the device impl and
> > > > virtio-sound-pci wrapper device.
> > >
> > > I'm not sure that I understand this point. Before this patch both
> > > vmstate_virtio_snd and vmstate_virtio_snd_device
> > > had the same name TYPE_VIRTIO_SND, we are trying to give the
> > > distinctive names here. Please, elaborate on this.
> >
> > Ah, I misunderstood the change then. The name must be unique for the
> > vmstate to be migrateable, right?
>
> I don't think that it is a strict requirement, because, basically
> vmstate_virtio_snd_device is implicitly nested in vmstate_virtio_snd.
>
> In vmstate_virtio_snd we only have VMSTATE_VIRTIO_DEVICE as a VMStateFiel=
d,
> which, in turn leads migration engine to virtio_save() and then to
> vmstate_save_state(f,
> vdc->vmsd (=3D vmstate_virtio_snd_device), ...).
>
> But, when and if somebody will analyze a migration stream (dump as
> JSON, or just use tracepoints in migration subsystem), then
> it is just more convenient to have distinctive names, IMHO.

Makes sense, thanks for the explanation.

> >
> > > Kind regards,
> > > Alex
> > >
> > > >
> > > > >+    .version_id =3D 1,
> > > > >+    .minimum_version_id =3D 1,
> > > > >     .fields =3D (const VMStateField[]) {
> > > > >         VMSTATE_VIRTIO_DEVICE,
> > > > >         VMSTATE_END_OF_LIST()
> > > > >@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_co=
mmand *cmd)
> > > > >                  sizeof(virtio_snd_hdr));
> > > > >     virtqueue_push(cmd->vq, cmd->elem,
> > > > >                    sizeof(virtio_snd_hdr) + cmd->payload_size);
> > > > >+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -=3D 1;
> > > >
> > > > Let's do a g_assert that this is > 0 before decrementing it.
> > >
> > > Great idea, I will address this in v4.
> > >
> > > >
> > > > >     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> > > > > }
> > > > >
> > > > >@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODevic=
e *vdev, VirtQueue *vq)
> > > > >
> > > > >     elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > > >     while (elem) {
> > > > >+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] +=3D 1;
> > > > >         cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> > > > >         cmd->elem =3D elem;
> > > > >         cmd->vq =3D vq;
> > > > >@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODe=
vice *vdev, VirtQueue *vq)
> > > > >             goto tx_err;
> > > > >         }
> > > > >
> > > > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] +=3D 1;
> > > > >         size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> > > > >
> > > > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size)=
;
> > > > >@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(VirtIO=
Device *vdev, VirtQueue *vq)
> > > > >             goto rx_err;
> > > > >         }
> > > > >
> > > > >+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] +=3D 1;
> > > > >         size =3D iov_size(elem->in_sg, elem->in_num) -
> > > > >             sizeof(virtio_snd_pcm_status);
> > > > >         buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size)=
;
> > > > >@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIOSo=
undPCMStream *stream,
> > > > >     virtqueue_push(buffer->vq,
> > > > >                    buffer->elem,
> > > > >                    sizeof(virtio_snd_pcm_status));
> > > > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -=3D 1;
> > > >
> > > > Ditto
> > >
> > > +
> > >
> > > >
> > > > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > > > >     QSIMPLEQ_REMOVE(&stream->queue,
> > > > >                     buffer,
> > > > >@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIOSo=
undPCMStream *stream,
> > > > >     virtqueue_push(buffer->vq,
> > > > >                    buffer->elem,
> > > > >                    sizeof(virtio_snd_pcm_status) + buffer->size);
> > > > >+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -=3D 1;
> > > >
> > > > Ditto
> > >
> > > +
> > >
> > > >
> > > > >     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
> > > > >     QSIMPLEQ_REMOVE(&stream->queue,
> > > > >                     buffer,
> > > > >@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceStat=
e *dev)
> > > > >     virtio_cleanup(vdev);
> > > > > }
> > > > >
> > > > >+static int virtio_snd_post_load(VirtIODevice *vdev)
> > > > >+{
> > > > >+    VirtIOSound *s =3D VIRTIO_SND(vdev);
> > > > >+    uint32_t i;
> > > > >+
> > > > >+    for (i =3D 0; i < s->snd_conf.streams; i++) {
> > > > >+        struct VirtIOSoundPCMStream *stream;
> > > > >+
> > > > >+        stream =3D virtio_snd_pcm_get_stream(s, i);
> > > > >+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
> > > > >+            virtio_snd_pcm_open(stream);
> > > > >+
> > > > >+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
> > > > >+                virtio_snd_pcm_set_active(stream, true);
> > > > >+            }
> > > > >+        }
> > > > >+    }
> > > > >+
> > > > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > > > >+        if (s->queue_inuse[i]) {
> > > > >+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i]=
)) {
> > > > >+                error_report(
> > > > >+                    "virtio-snd: could not rewind %u elements in =
queue %u",
> > > > >+                    s->queue_inuse[i], i);
> > > > >+            }
> > > > >+            s->queue_inuse[i] =3D 0;
> > > > >+        }
> > > > >+    }
> > > > >+
> > > > >+    return 0;
> > > > >+}
> > > > >
> > > > > static void virtio_snd_reset(VirtIODevice *vdev)
> > > > > {
> > > > >@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice *=
vdev)
> > > > >             virtio_snd_pcm_buffer_free(buffer);
> > > > >         }
> > > > >     }
> > > > >+
> > > > >+    for (i =3D 0; i < VIRTIO_SND_VQ_MAX; i++) {
> > > > >+        vsnd->queue_inuse[i] =3D 0;
> > > > >+    }
> > > > > }
> > > > >
> > > > > static void virtio_snd_class_init(ObjectClass *klass, const void =
*data)
> > > > >@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectClas=
s *klass, const void *data)
> > > > >
> > > > >     dc->vmsd =3D &vmstate_virtio_snd;
> > > > >     vdc->vmsd =3D &vmstate_virtio_snd_device;
> > > > >+    vdc->post_load =3D virtio_snd_post_load;
> > > > >     vdc->realize =3D virtio_snd_realize;
> > > > >     vdc->unrealize =3D virtio_snd_unrealize;
> > > > >     vdc->get_config =3D virtio_snd_get_config;
> > > > >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virt=
io-snd.h
> > > > >index 85d5d7c8619..384d2868c19 100644
> > > > >--- a/include/hw/audio/virtio-snd.h
> > > > >+++ b/include/hw/audio/virtio-snd.h
> > > > >@@ -194,6 +194,7 @@ struct VirtIOSound {
> > > > >     VirtIODevice parent_obj;
> > > > >
> > > > >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> > > > >+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
> > > > >     uint64_t features;
> > > > >     VirtIOSoundPCMStream *streams;
> > > > >     AudioBackend *audio_be;
> > > > >--
> > > > >2.47.3
> > > > >
> >
> > --
> > Manos Pitsidianakis
> > Emulation and Virtualization Engineer at Linaro Ltd

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

