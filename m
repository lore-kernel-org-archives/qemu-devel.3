Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0BFC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 06:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wind3-0004wf-MA; Sun, 12 Jul 2026 02:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wincy-0004r2-EQ
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 02:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wincv-0006hl-To
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 02:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783837518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3W73L2B1E4/n7toCqwu0I2cOqFSHsfrizsUfrHNuMkk=;
 b=SRkl9+9fFnglJHYkBEP/OlqPnS+zrzgMfsB/iSIr5iobMwPFRl9wI2QpyTml+SGutQZay8
 5WdS+MXnfGiHZ4NyQeyLVpsTYz8hpGpGAPBTv6O1ITyxjE+aGkiAzc3Y93znYX48YbmmUH
 j8j5HrVXvBkVLfCwYwlN+CTmiULNbgc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-qzw3V1u-Naql8Gp0exCJJw-1; Sun, 12 Jul 2026 02:25:16 -0400
X-MC-Unique: qzw3V1u-Naql8Gp0exCJJw-1
X-Mimecast-MFC-AGG-ID: qzw3V1u-Naql8Gp0exCJJw_1783837515
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484739a9cbso3095293b3a.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 23:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783837515; cv=none;
 d=google.com; s=arc-20260327;
 b=RTVjFgW6ujb2j67gRKgkqctRY4P+lQkI8rAJ/afBl/Vv4cfshTVUNYrXfklUZuW8//
 ddVivEwP608l/Bnx+1qjfbbcaizwcill5yHo8Y23Ug9/mEmbklftkecMSjdqC/pld3nt
 Hxz47X90mkL1rAtiHpFfUG1d3xkNt0sQvFfpIbCDVLp2YE6Igqsr5j2sdIShLBvgmsNY
 ZUw1kXLgsLFlIt3mPzR1BgIDi7TT0SMA4ebH2uGRbpiIH2A0nZb6EFleQ6+/SUxexV58
 5ENLu/OAr6biO0yrsNx2QkffaxgkfZbzQbyOC1usOBd+s1b3yMXV3OiDbGDmBv5ysIRb
 4HCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3W73L2B1E4/n7toCqwu0I2cOqFSHsfrizsUfrHNuMkk=;
 fh=2yfpql/T1Xk/sJBU2wstEL6ddhzw2KJDbbrN+Gi201w=;
 b=RLVXxmtgNKXpaIEijiQw3nEdt0UIC3O8quRGQuLeur76RkGAxa99HuT9X3jAa13mzz
 fsNR8D1h23NmB1+Q8QaWvm3dGgviBwi+RaBURJPtV6lp3YeZVPsbb6zax8veRfp2g2hJ
 Ry5LIMSjBxb/odPtrYZrnJV3vj57+Dkad2A0O9tEX9/Qlh1vTG/glZ5h20NU8aL6BBN2
 Q2nZHt+G/ts5LXcIa+tDYJJ2jfj1mEykCTemxK0eA2O+AiKT1EnSec5UoCPqgHkxTBrB
 Lz/DoZLfwYXBOCau/Vqd4MDbRGabPUAR7LGgYZqLOUpduLl9OtlYpYfu2+r66yO8pAXD
 rabQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783837515; x=1784442315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3W73L2B1E4/n7toCqwu0I2cOqFSHsfrizsUfrHNuMkk=;
 b=ORcFG+HW78rsV7sY+qRzPPayH+Slyk6dW8q82bv7j3aTJkDxdK8ZaYkGnxxWeDFNZk
 XlBLSPvDXhI9wE2O5pN8JZjVRvQq4KQ71ktkn30BbGnwciiIwADLrAaBHAnpgtTg2OKx
 f62f7cZbHzm44uLYSm+WcDLXJaxR4dIblJPv5bPWHDxd9eCPgYj42bQdgS6jRgnafyrx
 FAaBJoXWVXbiVj6hWIjJ7Cf2oOjSBvySoEuAY+eMVzz4kfJkCXfq9cxOup1zgBBu9Xdo
 up3dIvpvM+hgBYkmeok0S/Db6F/2YsWmP2m50jD/PBjnRWX37DSTAq+wDM77TpaXYZQs
 +kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783837515; x=1784442315;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3W73L2B1E4/n7toCqwu0I2cOqFSHsfrizsUfrHNuMkk=;
 b=NN7uDOrhmEzsLxZu9M7oUEWW3kU6KGFvzBw4yHcdGEXSoZn4Ddwb/mWzYlEZ629AVt
 30qn1jLI6foCuce97uxwZ5BQ7QFbq415apIXWziv9FjxAZj9nHcKn3ERMRjxDvB+suJw
 w2vbyGtLnib+OaoV6aGnsoo3HoViuUSyeUkql+6gPU4POVtMKI4wDk/8MENgnv7uus51
 4FlFALM3rEtNrdGhPfFKwvu15N7NjuQz6QvMDJT8pPclUzmnU0J7B8tFHNcJTOcTOwJK
 Rh1ipQHD94afVUz22iAspTz35Zhgh5dq7wg8o/EfOqgX5JM/rcdIWEzq2eIoRJxgS0vk
 6PJw==
X-Gm-Message-State: AOJu0Yxk3UHHf5aR/8CGMfHU5bmCHkog4R4jqfN5Cfsr7da1a493D8zD
 P2Axp77YBerj195NORS1lzlm5nv7up6yP+NMd5XnGrHy81+QFpAd+Hmn529EqW4IZIMCKT6yiq+
 hsgZhmQahXXrCJWZYJ5EwVCUz5UMxmkGT+1Ea0vvmZUBcKXgmc6pl0A+buLQkjh+IdPZLSTITt7
 psSnAcrFnaMZRzTj+uT7/isPClhW8Q5NM=
X-Gm-Gg: AfdE7cnkOHnaI8D0dN7x01GmcJnbUOhlmoggVM7ZVNnVWHuvMJSLhUd0o6ucGA0EFX6
 jDWtrZyk8WSC52GqshS5M/LwbVsNqUFgiHR6o4khXJuZ7BcbPWUHsRAWam4aKAamYVABOXyqhQs
 ZK+vBvVez2auFwUOtKhWXOZvNm93N/aLxh78L/2UEPSmxwKg/pUl4pNOZ8CBRw+FE2CfBFjfW/s
 M4ugYONk1hVfWAACFFSvb5rapq6uxksctVNtlQ5FKkuOLHPO4hEhSkJ+mafeQKvs9gnw+2X3GNl
 Ar5759b9rhoy
X-Received: by 2002:a05:6a00:a28:b0:847:9223:9731 with SMTP id
 d2e1a72fcca58-8488ab520e8mr4166460b3a.8.1783837514944; 
 Sat, 11 Jul 2026 23:25:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:a28:b0:847:9223:9731 with SMTP id
 d2e1a72fcca58-8488ab520e8mr4166451b3a.8.1783837514451; Sat, 11 Jul 2026
 23:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-6-alexander@mihalicyn.com>
 <178248314307.2718091.12113748256980319907.b4-review@b4>
 <CAJqdLrr2FLG=_FWabC+dmJcWVVfiAf-hKxOHqPK_d_7inftMSQ@mail.gmail.com>
In-Reply-To: <CAJqdLrr2FLG=_FWabC+dmJcWVVfiAf-hKxOHqPK_d_7inftMSQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 12 Jul 2026 10:25:03 +0400
X-Gm-Features: AVVi8CcTfe_XCu6ixUkudY2tzKTeVaE196xASi4isoffXcxKf-KaeZy381rDYbU
Message-ID: <CAMxuvaxC6wyc_=8FBzrnNvcuHfjLa=99JTK=oDpN3U_bYikhfg@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] hw/audio/virtio-sound: add stream state variable
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=mlureau@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi

On Fri, Jul 10, 2026 at 6:56=E2=80=AFPM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Fr., 26. Juni 2026 um 16:12 Uhr schrieb <marcandre.lureau@redhat.com>:
> >
> > > So far, only rudimentary checks have been made to ensure that
> > > the guest only performs state transitions permitted in
> > > virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
> > > variable per audio stream and check all state transitions.
> > >
> > > Because only permitted state transitions are possible, only one
> > > copy of the audio stream parameters is required and these do not
> > > need to be initialised with default values.
> > >
> > > The state variable will also make it easier to restore the audio
> > > stream after migration.
> > >
> > > Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> > > [AM: there were too many conflicts, I did `git checkout --ours -- <.>=
`
> > >      and then reimplemented the patch idea
> > > /AM]
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusi=
on.io>
> > > Message-ID: <20260626123531.132078-6-alexander@mihalicyn.com>
> > >
> > > diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-=
snd.h
> > > index 41c63b3f23b..72ef34e0976 100644
> > > --- a/include/hw/audio/virtio-snd.h
> > > +++ b/include/hw/audio/virtio-snd.h
> > > @@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMS=
tream;
> > >
> > >  typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
> > >
> > > -typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> > > -
> > >  typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
> > >
> > >  /*
> > > @@ -121,31 +119,18 @@ struct VirtIOSoundPCMBuffer {
> > >      uint8_t data[];
> > >  };
> > >
> > > -struct VirtIOSoundPCM {
> > > -    /*
> > > -     * PCM parameters are a separate field instead of a VirtIOSoundP=
CMStream
> > > -     * field, because the operation of PCM control requests is first
> > > -     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE=
; this
> > > -     * means that some times we get parameters without having an all=
ocated
> > > -     * stream yet.
> > > -     */
> > > -    virtio_snd_pcm_set_params *pcm_params;
> > > -    VirtIOSoundPCMStream **streams;
> > > -};
> > > -
> > >  struct VirtIOSoundPCMStream {
> > >      virtio_snd_pcm_info info;
> > >      virtio_snd_pcm_set_params params;
> > > +    uint32_t state;
> > >      /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> > >      uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> > >      VirtIOSound *s;
> > > -    bool flushing;
> > >      audsettings as;
> > >      union {
> > >          SWVoiceIn *in;
> > >          SWVoiceOut *out;
> > >      } voice;
> > > -    bool active;
> > >      uint32_t latency_bytes;
> > >      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
> > >  };
> > > @@ -212,7 +197,6 @@ struct VirtIOSound {
> > >
> > >      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> > >      uint64_t features;
> > > -    VirtIOSoundPCM pcm;
> > >      VirtIOSoundPCMStream *streams;
> > >      AudioBackend *audio_be;
> > >      VMChangeStateEntry *vmstate;
> > > diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> > > index 300ba13ffeb..68d737478f5 100644
> > > --- a/hw/audio/virtio-snd.c
> > > +++ b/hw/audio/virtio-snd.c
> > > @@ -30,11 +30,30 @@
> > >  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> > >  #define VIRTIO_SOUND_HDA_FN_NID 0
> > >
> > > +#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
> > > +#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
> > > +#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
> > > +
> > > +#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
> > > +#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PARAMS_SET)
> > > +#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PARAMS_SET \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PREPARED)
> > > +#define VSND_PCMSTREAM_STATE_STARTED       (4 \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PARAMS_SET \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PREPARED \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
ACTIVE)
> > > +#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PARAMS_SET \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PREPARED)
> > > +#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
> > > +                                           | VSND_PCMSTREAM_STATE_F_=
PARAMS_SET)
> >
>
> Dear Marc-Andr=C3=A9,
>
> > Hmm, those 1,2,4,6,7 values matches the spec 5.14.6.6.1 states. Ok, but=
 worth a
> > comment imho.
>
> Manos made a point that we can simplify these definitions and instead
> of using bitmask,
> just have enum like:
>
> + enum virtio_snd_pcm_state {
> +   VIRTIO_SND_PCM_STATE_UNINIT =3D 0,
> +   VIRTIO_SND_PCM_STATE_PARAMS_SET,
> +   VIRTIO_SND_PCM_STATE_PREPARED,
> +   VIRTIO_SND_PCM_STATE_STARTED,
> +   VIRTIO_SND_PCM_STATE_STOPPED,
> +   VIRTIO_SND_PCM_STATE_RELEASED,
> + }
>
> (see https://lore.kernel.org/qemu-devel/thdwg7.z2gqqr4zn5aq@linaro.org/#t=
 )
>
> WDYT?

Sure

thanks


