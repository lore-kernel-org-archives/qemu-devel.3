Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75476D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 18:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjLyb-0008Hz-O2; Fri, 23 Jan 2026 13:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vjLyZ-0008HL-HH
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 13:33:43 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vjLyY-000253-0e
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 13:33:43 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-89461ccc46eso48603096d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 10:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769193220; cv=none;
 d=google.com; s=arc-20240605;
 b=DJCkk4l4z9kSNE1Wx6mWTrA7EXBjPQGLImjjEOQcGWfu2zAd7GpUV7r9dwswtJwl+T
 K9ETrKLtlV08zm+b3ltdz6qXeHr1KsrJjMVmt49hJkpuAKRE0/y2E6DK2hZin8vj82Jd
 Jy2WnMI9928g8fgSCFuUGK7GQ12AhkbefbMXLgTJnnxhUyjc1zAUOxPomOYf21+8HKLt
 rkXzbf3l7tpvVLhg7s+fa3FI5QuWX00+dhyfhGtJYtdwKHSs4M7YbGnfKzmfv+eocPUy
 nJGTMhN77IMqyF8e0r4iSi4GhHKHpCEII6Qhr9lG0inYVNr9Jo+v39xqdhBRvL1xXvef
 +CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RIslNiyhnRSCxvEP/82cF8P8duDA4OhirrnLIM0FQzw=;
 fh=gVbkJjOVoRTC1auWeOj2FcKpAUYmr7UxHVRJCTXBxGY=;
 b=YpQAKMUouHQ61pebZp3XXEorwmL8DWyWulbTPBeaYeydlYz8/0B91BsVD30DcltO1I
 nNJfnwmve40iNZyz741IdDN8QSjDnZ9ijpluLqvuv9tuzLg9PTvOdl2pLiblvdGM4kDB
 esMCgKmvK2JISIZPOsEIixU8gFCOMEoB9+1m1TlZhHlO/C+CZean66iFEy3mod0B/zOg
 Z3nuuKeYREYNbqFcH+g3YXhQ+kPGuiOlLxa0tJGtIzcsjBaZZRB7QZhGwZbXLhWZ0Jtk
 VvgNhLxt7gAiLlrmQUXmuLe+tXU5gF8mhImNG6D36ihhPFCtdML9bFILGAsfKC36uks6
 3TsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769193220; x=1769798020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIslNiyhnRSCxvEP/82cF8P8duDA4OhirrnLIM0FQzw=;
 b=gagiYkgMVjoicXj9OqSWB2hcIRPv7O6VqHThc6G8PM1NuHw4P1dFJ0b3SLJmg4og+L
 Js9LWSgpu1vLiK8uDlqp5XOhM0H+wp/+au7f1KmB5Fgvvz6e/X8v2R5EARAacNPY8m2G
 HJGBdFVAOSoKExXLFRpoJRN5/99602DO6NkId4znxjHGD+5mYkDUUJ8fZhx4i8l0XxMP
 RSu7JvBbi7lnJPy1lcgj4z+z6PtwTV27OvcA5N5ZJd+NLpzel9QHNioPBDcQ92/EsYM9
 Jylp4VjKYJwyomEUJhFHT6nwiPH4kz6/Cs65PLHQJY1BpBWoecq61cjmyxO4kK6OwcjN
 mOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769193220; x=1769798020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RIslNiyhnRSCxvEP/82cF8P8duDA4OhirrnLIM0FQzw=;
 b=jBng5j/IkEvzPNlteM0PcgC1n/u0B9ALGWtsosMhjyoahye8Wl662T+aQy/jGDwoiF
 PH4eugWTNak4FqxKb30mmjoNbD00pkJAAjUr4BNAC2OiucRpltUn48s0uMT7y+1Hyh9A
 gFqQYs5gOHS+nSewbyns//lHhDy6jxp06aYxVURA9SB9jL2eWgperZ9VFqYs/ZuqSNM9
 dyhwGML/20UZ+PaojK9nn2YphX7MeE/zbBMN7t1KHaSjF4QuCsTjaOupJTUmOUXGdrgR
 KX9pnlCl4qWVNe1zPfmMxCpZFOWxekqGAzzKGvFh9FcLirneFoCUbz8VFPgecizn0GY5
 yR1A==
X-Gm-Message-State: AOJu0Yz78rHl001NcYHXIZifmRDpN3hWpewVayOfNI6b4HFrWjl3iv03
 Wmmj9JyvFHNZ8tzpW2tWzwN8xb6UXrsVVPyMi6bJpBMIJ9TRjhy4LMxl79SIGVZvxOrrkNqnghr
 K/uIqL0/2eU1X+XxgpDZog5cVEYOenyY=
X-Gm-Gg: AZuq6aIK17o/dZx3qfu09ci7CREMGQ6zwW9kF/kZKvlqAg/S5fN0bId9o+m2pb5fESd
 SkQbVkVh2tiJ9t8JTpGvLatBhMAPYuLzR4pyqvAThoGGSh4WJVXPxv2Grfygzd5/H0+tnDVRWoj
 6aHKoLrjEyji0AjxR6y3NHFzgjnCGgF7Hhj5NfSfOCKNZ+1PwSOuXRUh7hqve1vbfV/RR6d8Piy
 7Fdc1hpT9bDYixL/ixYaNIp5ymBSaOervY1832whkTNURZKCa8brFnWtrUpA0oDTZXoJVwGSTqD
 k5hHaWGrTA+kmQG+HpikJztfqjmtEGD8hmjx7g==
X-Received: by 2002:a05:622a:1b91:b0:502:a06a:fe5a with SMTP id
 d75a77b69052e-502f77bd5ccmr54207741cf.51.1769193219645; Fri, 23 Jan 2026
 10:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-22-marcandre.lureau@redhat.com>
 <3f0d41b1-dbce-80ba-c1e2-a8d73d1c6caf@eik.bme.hu>
In-Reply-To: <3f0d41b1-dbce-80ba-c1e2-a8d73d1c6caf@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Jan 2026 22:33:28 +0400
X-Gm-Features: AZwV_QhQ0n4fS-zt4GVgf6AdJNp-AI8E2LrpE6vyJKLaUUz_KdXswcwAjZ_6jNY
Message-ID: <CAJ+F1CLt0XsLXf2D87LnFBDcrvFFn2mv8K7UyChzFtBidLCXGA@mail.gmail.com>
Subject: Re: [PATCH 21/37] audio: add QOM module-objects for each backend
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Thomas Huth <huth@tuxfamily.org>,
 Alexandre Ratchov <alex@caoua.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Fri, Jan 23, 2026 at 6:24=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Fri, 23 Jan 2026, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This will allow to use QOM and the dynamic object module loading.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > audio/audio_int.h   |  2 ++
> > audio/alsaaudio.c   | 27 +++++++++++++++++++++++++++
> > audio/dbusaudio.c   | 26 ++++++++++++++++++++++++++
> > audio/dsoundaudio.c | 26 ++++++++++++++++++++++++++
> > audio/jackaudio.c   | 26 ++++++++++++++++++++++++++
> > audio/noaudio.c     | 26 ++++++++++++++++++++++++++
> > audio/ossaudio.c    | 26 ++++++++++++++++++++++++++
> > audio/paaudio.c     | 26 ++++++++++++++++++++++++++
> > audio/pwaudio.c     | 26 ++++++++++++++++++++++++++
> > audio/sdlaudio.c    | 26 ++++++++++++++++++++++++++
> > audio/sndioaudio.c  | 26 ++++++++++++++++++++++++++
> > audio/spiceaudio.c  | 26 ++++++++++++++++++++++++++
> > audio/wavaudio.c    | 26 ++++++++++++++++++++++++++
> > audio/coreaudio.m   | 26 ++++++++++++++++++++++++++
> > 14 files changed, 341 insertions(+)
> >
> > diff --git a/audio/audio_int.h b/audio/audio_int.h
> > index 06f5160e8df..29f5864be69 100644
> > --- a/audio/audio_int.h
> > +++ b/audio/audio_int.h
> > @@ -241,6 +241,8 @@ struct SWVoiceCap {
> >
> > struct AudioMixengBackendClass {
> >     AudioBackendClass parent_class;
> > +
> > +    audio_driver *driver;
> > };
> >
> > struct AudioMixengBackend {
> > diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> > index 814820e2864..881f3d0349d 100644
> > --- a/audio/alsaaudio.c
> > +++ b/audio/alsaaudio.c
> > @@ -27,6 +27,7 @@
> > #include "qemu/main-loop.h"
> > #include "qemu/module.h"
> > #include "qemu/audio.h"
> > +#include "qom/object.h"
> > #include "trace.h"
> >
> > #pragma GCC diagnostic ignored "-Waddress"
> > @@ -36,6 +37,22 @@
> >
> > #define DEBUG_ALSA 0
> >
> > +#define TYPE_AUDIO_ALSA "audio-alsa"
> > +OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
> > +
> > +struct AudioALSA {
> > +    AudioMixengBackend parent;
> > +};
>
> If you have nothing to put here only the parent you don't need to declare
> the state struct...
>
> > +
> > +static struct audio_driver alsa_audio_driver;
> > +
> > +static void audio_alsa_class_init(ObjectClass *klass, const void *data=
)
> > +{
> > +    AudioMixengBackendClass *k =3D AUDIO_MIXENG_BACKEND_CLASS(klass);
> > +
> > +    k->driver =3D &alsa_audio_driver;
> > +}
> > +
> > struct pollhlp {
> >     snd_pcm_t *handle;
> >     struct pollfd *pfds;
> > @@ -945,8 +962,18 @@ static struct audio_driver alsa_audio_driver =3D {
> >     .voice_size_in  =3D sizeof (ALSAVoiceIn)
> > };
> >
> > +static const TypeInfo audio_alsa_info =3D {
> > +    .name =3D TYPE_AUDIO_ALSA,
> > +    .parent =3D TYPE_AUDIO_MIXENG_BACKEND,
> > +    .instance_size =3D sizeof(AudioALSA),
>
> ...and can set instance_size of the parent so I think you can drop the
> struct above everywhere where no other fields are needed other than the
> parent. (See e.g. via_mc97_info)

True, although the pending patches to finish the conversion to QOM will
add fields there. This is an intermediary step, but yes, I can drop
the "empty" structs for now.


>
> Regards,
> BALATON Zoltan
>
> > +    .class_init =3D audio_alsa_class_init,
> > +};
> > +
> > +
> > static void register_audio_alsa(void)
> > {
> >     audio_driver_register(&alsa_audio_driver);
> > +    type_register_static(&audio_alsa_info);
> > }
> > type_init(register_audio_alsa);
> > +module_obj(TYPE_AUDIO_ALSA);



--
Marc-Andr=C3=A9 Lureau

