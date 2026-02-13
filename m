Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F372EDF149
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqq4k-00009K-BA; Fri, 13 Feb 2026 05:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vqq4h-00008p-LI
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:06:59 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vqq4g-0002js-1k
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:06:59 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-506a6cf8242so4982391cf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770977216; cv=none;
 d=google.com; s=arc-20240605;
 b=Yx0JjQ4Zzoenn8KBvoTzFpT/MPGC2GqCh12gxZNwZ5A4LzXGe4ZQGjI/DYv93VdfJY
 xumAFyc8yyubqnhvll8Or/aeRjzV9ACyUnpdlEYFLunZlx5lxnrtvDTrZvoVGqXU9Ibk
 MlTAeRymjfSBFxO2p54UKf9oxDSUyBXoN3y7ObuOYsGgHDkcW58niOw4Aj+o0YF2CvhV
 aStgshHwscsiacPoVc7hJn2z3YB42+D2YXxuQY+a3vZaWoLxJZIYETulqvNKzu7ls7Bg
 uHjxgAYjoo2HGZr4uojneJzX5TIGwcu+zjJFsQan2xVHOX8O3LaVAEB8xiAVoAj25R4P
 OsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pyToiocvKUO94lNGO5eIsUhgTdnlsp9MkHlmQEDl2x8=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=Pjlr10YfuhccWjA6GwhGjIB9KTO79VDljLvNdNhC1OWqkJF2Ztav/A+eOiyDC4dV9N
 WSpRQ19P2fHhnWhU1lt5txV5gmOQSsjYfmMKBcIfLcMBaUKMPROjARC6ayB5L9CvvOq3
 6EyMWGvl2xRWO81QnFNTXzaG0wRT8zDIkrlgxhQDufnNvymKaIMlHOUU8L2z1lDQvDPC
 LAU1eiuQWcUmUfq9HNzz+UiJ/f551hRg5b5pBbAZTDpy52nByjHtDb0S1Kjf7sUC8o/i
 oAXPbBgC920jYQsNdcYwdggMpaNONrGbmfBaFZGa7/8WZ/OF/ov0POhzWsWMwSrgHtyI
 08xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770977216; x=1771582016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyToiocvKUO94lNGO5eIsUhgTdnlsp9MkHlmQEDl2x8=;
 b=DlN73OleRDoFn/r0d5KyInpJ+Alkoruihpq69myEHFOS0m9pJFnbgtDYn3sw0KRl3M
 ijorTjBZrN4VLuCFCpGEm66pbVRiNgrCw5m4AZ0hc4zGGHdH+4glrs7bCj+pDtpYtRGu
 d2M3B8ZokV7bqQ3ouSHK9CEjdT/mcSEQ8nSoDlnRPrg6f7cQumN3uMW+dFVN7bz+UMB8
 ujEZfMzweXw11xpOKd3b34rDY+wf8Dq+fvhjpR7WX5UM3JAzAH0vRayyVr5ZREi5TGE6
 XDRzCMlK84kNdKAin5aqiwT6unY1eVSe64EaFnhf1bdB3YIguUJpaJLAxeNic+DgJvcI
 CLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770977216; x=1771582016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pyToiocvKUO94lNGO5eIsUhgTdnlsp9MkHlmQEDl2x8=;
 b=CwhM5dengG3LiPKcJqCpMY8RJGZrfWeXH9SbCnMfZc19+7ZKvJfeSU4Wu2xo2/MPwO
 DkmzdAIMyD9y2rFVyQ/zeWSLb1MaMDqR04vWhKGapOVuoKnQH2spR0/NEEvwgI3Ef6MC
 cyenf9pz4EjsW/HW42Gskccs9oQmRfNJlQw9EJfghxzwL7EqsOmv9AGdTw/hAn3tR0Yc
 /U5mJR+1ZFJmqNJXZJykPlWeDYDlMeKrw6xULfsi6wqhePdegPKXK7M3PnhqNoFfejwf
 xAp5XlJZQS6gxKaPPQGtmT4JimB0I/BFeWlkXAmv0kaLpL4sKUfkoMdKgAxMC06L/qaz
 vMAw==
X-Gm-Message-State: AOJu0YwPtbtVZioeeBS74p4PYvRS2g6f0y4Qm37ZJy4GD/61cjiNa3pb
 rsTbvar9pKlnp7MWtSJ8lfLcBLZbJd/KmZifToDFGi4iVFQGNTdx/Ii3QVcAoTPGQJxE/iP4vV7
 nOkzLa3pcVgPCg2KtPTUTfWV+g8rvkdA=
X-Gm-Gg: AZuq6aJjnoCW0thZT3/xtCFdaP9J9iH7cizS3Kn6ecd+HU/G4ntfvxDnRlay1LoQq8+
 oP7oPi3NHOFCt/IQSh/SLTEGkGWVcnwyQOn+Yn52FznIQ63tjFQm0X3rds/tYJ3WgF2YsdBNnwl
 r5SGZWZaxlFaWT7oWKJq0+n5Xxe2bMwnhku/yxV06kWQOjv6hvQ9ZH0Ukvu7gHgM+X3RMhZdvnR
 poOZKbbfUVLFL8M2nQipdqHE4mSpKSZVBOWB4Z+oemRF6P3k/HAeaUwZIfVr57qcUTHI5m1Qm5h
 nVBLtOUD4AJ8tdsTznp2lCwhO8qa1reoazuni3HV
X-Received: by 2002:ac8:5709:0:b0:506:21ff:af13 with SMTP id
 d75a77b69052e-506a8271ba9mr15980831cf.1.1770977216545; Fri, 13 Feb 2026
 02:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-7-marcandre.lureau@redhat.com>
 <a45cff3e-2984-456a-8be7-0b136493c1d9@nutanix.com>
In-Reply-To: <a45cff3e-2984-456a-8be7-0b136493c1d9@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 13 Feb 2026 14:06:45 +0400
X-Gm-Features: AZwV_QgGgn7EmoFLmi-OfU9fvRT4Np5gwOpJXkh8L6U7P3GFolth2T6MTwdHOcU
Message-ID: <CAJ+F1CKTsM0rCSeMwv_TU2kJDBpB2Mfg_2Dj_fhjqw6VJOZq0A@mail.gmail.com>
Subject: Re: [PATCH 06/43] audio/oss: convert to QOM lifecycle methods
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 13, 2026 at 10:58=E2=80=AFAM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Migrate the OSS audio backend from the legacy driver init/fini
> > callbacks to proper QOM realize method.
> >
> > The oss_audio_init() function is replaced with audio_oss_realize(),
> > which performs the same device accessibility check before delegating
> > to the parent class realize method. The empty oss_audio_fini() is
> > removed.
> >
> > Access to the Audiodev is now through hw->s->dev instead of the
> > drv_opaque pointer.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/ossaudio.c | 37 +++++++++++++++++++++----------------
> >   1 file changed, 21 insertions(+), 16 deletions(-)
> >
> > diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> > index 013958e1344..e745149ca39 100644
> > --- a/audio/ossaudio.c
> > +++ b/audio/ossaudio.c
> > @@ -23,6 +23,7 @@
> >    */
> >
> >   #include "qemu/osdep.h"
> > +#include "qapi-types-audio.h"
> >   #include <sys/ioctl.h>
> >   #include <sys/soundcard.h>
> >   #include "qemu/main-loop.h"
> > @@ -39,19 +40,14 @@
> >   #define TYPE_AUDIO_OSS "audio-oss"
> >   OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
> >
> > +static AudioBackendClass *audio_oss_parent_class;
> > +
> >   struct AudioOss {
> >       AudioMixengBackend parent;
> >   };
> >
> >   static struct audio_driver oss_audio_driver;
> >
> > -static void audio_oss_class_init(ObjectClass *klass, const void *data)
> > -{
> > -    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> > -
> > -    k->driver =3D &oss_audio_driver;
> > -}
> > -
> >   #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
> >   #define USE_DSP_POLICY
> >   #endif
> > @@ -505,7 +501,7 @@ static int oss_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
> >       int err;
> >       int fd;
> >       struct audsettings obt_as;
> > -    Audiodev *dev =3D drv_opaque;
> > +    Audiodev *dev =3D hw->s->dev;
> >       AudiodevOssOptions *oopts =3D &dev->u.oss;
> >
> >       oss->fd =3D -1;
> > @@ -636,7 +632,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audset=
tings *as, void *drv_opaque)
> >       int err;
> >       int fd;
> >       struct audsettings obt_as;
> > -    Audiodev *dev =3D drv_opaque;
> > +    Audiodev *dev =3D hw->s->dev;
> >
> >       oss->fd =3D -1;
> >
> > @@ -737,7 +733,8 @@ static void oss_init_per_direction(AudiodevOssPerDi=
rectionOptions *opdo)
> >       }
> >   }
> >
> > -static void *oss_audio_init(Audiodev *dev, Error **errp)
> > +static bool
> > +audio_oss_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
> >   {
> >       AudiodevOssOptions *oopts;
> >       assert(dev->driver =3D=3D AUDIODEV_DRIVER_OSS);
> > @@ -748,17 +745,16 @@ static void *oss_audio_init(Audiodev *dev, Error =
**errp)
> >
> >       if (access(oopts->in->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
> >           error_setg_errno(errp, errno, "%s not accessible", oopts->in-=
>dev ?: "/dev/dsp");
> > +        qapi_free_Audiodev(dev);
> >           return NULL;
>
> Should this be "return false" instead?

good catch, thanks

>
> >       }
> >       if (access(oopts->out->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
> >           error_setg_errno(errp, errno, "%s not accessible", oopts->out=
->dev ?: "/dev/dsp");
> > +        qapi_free_Audiodev(dev);
> >           return NULL;
>
> And also here?
>
> >       }
> > -    return dev;
> > -}
> >
> > -static void oss_audio_fini (void *opaque)
> > -{
> > +    return audio_oss_parent_class->realize(abe, dev, errp);
> >   }
> >
> >   static struct audio_pcm_ops oss_pcm_ops =3D {
> > @@ -780,8 +776,6 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
> >
> >   static struct audio_driver oss_audio_driver =3D {
> >       .name           =3D "oss",
> > -    .init           =3D oss_audio_init,
> > -    .fini           =3D oss_audio_fini,
> >       .pcm_ops        =3D &oss_pcm_ops,
> >       .max_voices_out =3D INT_MAX,
> >       .max_voices_in  =3D INT_MAX,
> > @@ -789,6 +783,17 @@ static struct audio_driver oss_audio_driver =3D {
> >       .voice_size_in  =3D sizeof (OSSVoiceIn)
> >   };
> >
> > +static void audio_oss_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    AudioBackendClass *b =3D AUDIO_BACKEND_CLASS(klass);
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> > +
> > +    audio_oss_parent_class =3D AUDIO_BACKEND_CLASS(object_class_get_pa=
rent(klass));
> > +
> > +    b->realize =3D audio_oss_realize;
> > +    k->driver =3D &oss_audio_driver;
> > +}
> > +
> >   static const TypeInfo audio_oss_info =3D {
> >       .name =3D TYPE_AUDIO_OSS,
> >       .parent =3D TYPE_AUDIO_MIXENG_BACKEND,
>
> Otherwise:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>
>
> ATB,
>
> Mark.
>
>


--=20
Marc-Andr=C3=A9 Lureau

