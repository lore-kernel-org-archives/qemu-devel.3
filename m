Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6CAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpBK-00021F-Ay; Thu, 09 Jul 2026 09:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whpBH-00020O-1v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:52:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whpBE-0008H3-Dp
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:52:46 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698c0ff45b5so1557735a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783605156; cv=none;
 d=google.com; s=arc-20260327;
 b=X2S8cNYP4deMQcQLO9FK3lfwIXWz1nsZwKVowpMaLETn0LUgcIrHkBNohGomJceF62
 F7gfg8Pi9rkW14IrY57uYxh48eC9zFNOa96ZVBdqDFJTQ277Tv7Hlm7C/jQl/n9Ct3gA
 Qbep1CMwTWry4ZvxJYgyzrDLeRYPciXtuIFyDoFmEwnxY8pCn1j6+BDTIcIV8n7B4j9T
 cC167lwvXhOh0PTjFk7iL8RYiNwIZ29foQ3X5h9bLYizgEC3zLlS7ky3W3w01aUwUlB6
 zZwDPSstcUQs3MPYMT/yKHkce0AZZmxaBOyvGsMwr65PYWcZtNCNq/aRxXmbXUwVtgXh
 A83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5cuGQR1+63nqgwesx/JZfl0oTpSQd/0m/0QKYn2lGzE=;
 fh=qty3g77Sl39ix/vs6vEQferIpKkxxHZnWW1uZOZG04Y=;
 b=HJPsKBxl3Bes2PqhDirnPsPqWqIwsv0xCp2m924WgVHtwBPq/D1H3KJyW/wGJF8iZ/
 EF70YKvzP+WWC2ES9obuF+RWZA0tjWCItWiCvX7MtUqLDAP+ayvsqW4Y+zy+4paKYR7B
 rPyPP3vTmHPL8y6RJVurz6gkTf5iaPTLva1P6GnRk1qfzhpVtg2RGcCLKvVPDNq2OTte
 UN0R6dgnsBREpxH/InUzlMMcnpRfFXLOJjTFHn3tOSuN1xgA9QXRHHV4tOTG8nXw203m
 scDdy6P88yjWhvawuaczAkxcbaBlueXxJkkmZWQmV4QbqXS7RmBQMRm3ct7Y6d4TGqFE
 OlYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783605156; x=1784209956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cuGQR1+63nqgwesx/JZfl0oTpSQd/0m/0QKYn2lGzE=;
 b=ccdEEQAlIOoBrP5ZC9EGTslI4gN42VjakOTqNO/+qisKFCBR2Hot55+0xGtgTvwgLP
 DK1fjgsCzlWcpCgJOnnUhJSh+rASJm8jddnIRxjClAUMbUy7a1t9aFX/ImYBpKu1gAFQ
 PGZglauCMaZjINisD9SuXNoPpNR8KByCPSmQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783605156; x=1784209956;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cuGQR1+63nqgwesx/JZfl0oTpSQd/0m/0QKYn2lGzE=;
 b=cMplr4SVBIWhXtmsEOUBvLUBJKt0idiZQV0K8v6N0/NLoHccGYlh1GRppVVD30Gyi/
 K3QxQIvU08IBNaJ0AD+7mQ6WUJxT9F0eFReHZHVPoIu/J33zP4mXB3B5Z+jtvhQdGprG
 gG2culMPRmysM2IKOHfLe/NoAIB+K4Zdm75tZiJJhwhRyLdeXWnXc327+z0Vjx6yrhpA
 rxt32EK+3wlYbAHzSHPKS9srn0CtAqr/00n5BuUWzad5q3/OnSC8DBCbYy8zuQZsqRst
 VCNv2pUWTnWf7Jbh6zCDWeq+b9utxCu0jugAi96RGy0hiY9oRElWlK5j1vYugjXVoUUP
 6VSQ==
X-Gm-Message-State: AOJu0YzM3zzvTY4xM6u29DigzVHV5nTKnfJxHdmH+FawcZtwnjXB5JXa
 a3041OMcbLP1EOdjYXsbdSA4Bqx+0hWfpLGukRG1CZ0TfrI66RNvy9Fhd1pcGCwnbKRKBbu//6/
 LNsZXsuj9bmhhfjzgR/XYshfSpWNk5c0VjC+4qJ9HxA==
X-Gm-Gg: AfdE7cncWX7t5H9W2ZmbiAZuERTpNCk/pju1WOK/4s56i+lF5eSC5/CYa+aN5jeTVvb
 +1DSbi+SeRWwpCJ1kAe4vz50gT62ggkyrnkveAyWqNKyDpFBJuo6oTJhugHMU4xS9HUzTj+QZ7V
 NI5yqG5jVtN1/xnMaD24kAzFCp+rVkYYcUz63QBkQxTEw2uCKfYFspiVFvytAuOm6vuwGAyBUnK
 XGp5qulc7ytgIgb9EvJiNDn4t4R0zCjt3NJaye3rP7SCFyPc5dZ9/yoe3+/+zqKdLSrAAVd/vJN
 GdhuUIotPqhAR5WDSmI74eTA5i8h
X-Received: by 2002:a17:907:60cd:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c15e7407dd8mr151478966b.6.1783605155527; Thu, 09 Jul 2026
 06:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-3-alexander@mihalicyn.com>
 <thdv34.1hr3kwq58lz3p@linaro.org>
In-Reply-To: <thdv34.1hr3kwq58lz3p@linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 9 Jul 2026 15:52:22 +0200
X-Gm-Features: AUfX_mzXe8DeGHsv0er24NHCEa9dZKqDZnbUqWppWyjURj8A0isJjAFPqIl39q0
Message-ID: <CAJqdLrrmybT6H5mQSBypOwu7rqM1hNq3CWydtUM8X74cE5RZVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] hw/audio/virtio-sound: allocate an array of streams
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x52e.google.com
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

Am Mo., 29. Juni 2026 um 09:49 Uhr schrieb Manos Pitsidianakis
<manos.pitsidianakis@linaro.org>:
>
> On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com=
> wrote:
> >From: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >
> >It is much easier to migrate an array of structs than individual
> >structs that are accessed via a pointer to a pointer to an array
> >of pointers to struct.
> >
> >For this reason, allocate an array of streams in
> >virtio_snd_realize() and initialise all stream variables that
> >are constant at runtime immediately after allocation.
> >
> >This makes it easier to remove the virtio_snd_set_pcm_params()
> >and virtio_snd_pcm_prepare() calls in the realisation phase and
> >to migrate the audio streams of the virtio sound device after
> >the next few patches.
> >
> >Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> >[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
> >     and then reimplemented the patch idea
> >/AM]
> >Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.=
io>
> >Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >---
> >v3:
> >       As suggested by Marc-Andr=C3=A9 Lureau:
> >       - drop VirtIOSoundPCMStream's id field
> >---
> > hw/audio/virtio-snd.c         | 34 +++++++++++++++++++++-------------
> > include/hw/audio/virtio-snd.h |  2 +-
> > 2 files changed, 22 insertions(+), 14 deletions(-)
> >
> >diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> >index 6eb31e2838e..859c2770195 100644
> >--- a/hw/audio/virtio-snd.c
> >+++ b/hw/audio/virtio-snd.c
> >@@ -436,12 +436,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
*s, uint32_t stream_id)
> >
> >     stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> >     if (stream =3D=3D NULL) {
> >-        stream =3D g_new0(VirtIOSoundPCMStream, 1);
> >+        stream =3D &s->streams[stream_id];
> >         stream->active =3D false;
> >-        stream->id =3D stream_id;
> >-        stream->s =3D s;
> >         stream->latency_bytes =3D 0;
> >-        QSIMPLEQ_INIT(&stream->queue);
> >
> >         /*
> >          * stream_id >=3D s->snd_conf.streams was checked before so thi=
s is
> >@@ -451,14 +448,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound =
*s, uint32_t stream_id)
> >     }
> >
> >     virtio_snd_get_qemu_audsettings(&as, params);
> >-    stream->info.direction =3D stream_id < s->snd_conf.streams / 2 +
> >-        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_=
INPUT;
> >-    stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> >-    stream->info.features =3D 0;
> >-    stream->info.channels_min =3D 1;
> >-    stream->info.channels_max =3D as.nchannels;
> >-    stream->info.formats =3D supported_formats;
> >-    stream->info.rates =3D supported_rates;
> >     stream->params =3D *params;
> >
> >     stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> >@@ -1046,6 +1035,24 @@ static void virtio_snd_realize(DeviceState *dev, =
Error **errp)
> >     vsnd->vmstate =3D
> >         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vs=
nd);
> >
> >+    vsnd->streams =3D g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.strea=
ms);
> >+
> >+    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> >+        VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> >+
> >+        stream->s =3D vsnd;
> >+        QSIMPLEQ_INIT(&stream->queue);
> >+        stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> >+        stream->info.features =3D 0;
> >+        stream->info.formats =3D supported_formats;
> >+        stream->info.rates =3D supported_rates;
> >+        stream->info.direction =3D
> >+            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & =
1)
> >+            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;

Dear Manos,

> >+        stream->info.channels_min =3D 1;
> >+        stream->info.channels_max =3D 2;
>
>
> Why 2 instead of as.nchannels? Does this break support for more than 2
> channels?

oh, good catch! It looks like the original patch has the same flaw
here and it wasn't noticed by
me while I was trying to be very attentive to details ;-)

I agree, this looks like a bug to me and I think that a correct fix
(to this patch) would be:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -448,6 +448,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound
*s, uint32_t stream_id)
     }

     virtio_snd_get_qemu_audsettings(&as, params);
+    stream->info.channels_max =3D as.nchannels;
     stream->params =3D *params;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

So, we can keep
+        stream->info.channels_max =3D 2;

chunk in virtio_snd_realize() function (as we don't have
virtio_snd_pcm_set_params at that point), but
then in virtio_snd_pcm_prepare(), we can take data from
virtio_snd_pcm_set_params through virtio_snd_get_qemu_audsettings()
and then put it to stream->info.channels_max. WDYT?

Kind regards,
Alex

>
> >+    }
> >+
> >     vsnd->pcm.streams =3D
> >         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
> >     vsnd->pcm.pcm_params =3D
> >@@ -1314,12 +1321,13 @@ static void virtio_snd_unrealize(DeviceState *de=
v)
> >             if (stream) {
> >                 virtio_snd_process_cmdq(stream->s);
> >                 virtio_snd_pcm_close(stream);
> >-                g_free(stream);
> >             }
> >         }
> >         g_free(vsnd->pcm.streams);
> >     }
> >     g_free(vsnd->pcm.pcm_params);
> >+    g_free(vsnd->streams);
> >+    vsnd->streams =3D NULL;
> >     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
> >     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
> >     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
> >diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd=
.h
> >index fce7d1feea2..41c63b3f23b 100644
> >--- a/include/hw/audio/virtio-snd.h
> >+++ b/include/hw/audio/virtio-snd.h
> >@@ -136,7 +136,6 @@ struct VirtIOSoundPCM {
> > struct VirtIOSoundPCMStream {
> >     virtio_snd_pcm_info info;
> >     virtio_snd_pcm_set_params params;
> >-    uint32_t id;
> >     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> >     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> >     VirtIOSound *s;
> >@@ -214,6 +213,7 @@ struct VirtIOSound {
> >     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> >     uint64_t features;
> >     VirtIOSoundPCM pcm;
> >+    VirtIOSoundPCMStream *streams;
> >     AudioBackend *audio_be;
> >     VMChangeStateEntry *vmstate;
> >     virtio_snd_config snd_conf;
> >--
> >2.47.3
> >

