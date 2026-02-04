Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E29E9D3E7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vndzD-0008NT-4B; Wed, 04 Feb 2026 09:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vndz5-0008Mr-Rx
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vndz2-0006kZ-Gp
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770215755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgQkTjBcICMRJRvuk/RrIJwW0jVGpZIxNmY9lOp/X88=;
 b=FqTgJ4kNd/y7D89woz9QSZep5xkzCbzT/X/dcbNyY3zNf5Qwb2Llqz1q5+UcDeByluZvn9
 IBnrexKJ2tx776tCG8E03ai77+Uqny1BMRejMkQy++E6zk3Kp+6RZQnmCZUzobp5cturoi
 JcZZjemttZbSYHVq2r5BRj3z06tPROc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hHBAzjzBOp2kijNEbwU7kg-1; Wed, 04 Feb 2026 09:35:54 -0500
X-MC-Unique: hHBAzjzBOp2kijNEbwU7kg-1
X-Mimecast-MFC-AGG-ID: hHBAzjzBOp2kijNEbwU7kg_1770215753
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35301003062so16498808a91.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:35:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215753; cv=none;
 d=google.com; s=arc-20240605;
 b=LcQBr5ma1sxC275U3z2fWIP0dw6RV0lOCQpjCc12jXLoOmfmf2TLSz89lAsnR8jGWh
 NSyTmbzYQkpFf3DpbSVNn+7139EsmChnhdwTr/u8/1jv7aD6PPjScCwmoI3SMJR17jna
 9mdJ3dq0SS4ORiZMlfL2NPmE6n5jR45FH+/jHk0L8I7uTy4IZBSQhdwHkcbc1l5rL3SQ
 3AUQ6j9M0tFW4lUebBlzpAbe5umUySRXL4hSJnmgdJ3Jv2pmI56HjYhPuuscnSCjd0jW
 21YTYgHt5o6h/06lCpHZDVFqjzJRRcQFundvAQ3RTGJnImUdtHeTjQdifED6DjVp6rYu
 Q+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mgQkTjBcICMRJRvuk/RrIJwW0jVGpZIxNmY9lOp/X88=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=LDEwAITUx3USVqfmUURB4gNu+WjlupI5Md2sPxlmbHqQjRPCKuc5jTKcqKAQsTUtZD
 ogRQBDVti/i0Whv72WYM7YSeIpYbs/qf0suzLtKeHiOjpDMyjqNZ9FHFhOLYYpJSEZ7c
 jqgigV56OfXSnifE4yAIvwSEC4nl5Nq6oBPj1/JyCqu9OUcMCyaHs0tcE/jBtTvnjb+n
 R6lntwyNUpxPtF7rmA3njcGcKRZaUB7rOqKFPKCpvvYjKKHC7ps24ZyjX8wUxhqTHnge
 uYWY+wAeW1zqlL86EGunyXxmpxgNmY7x6sXF2CW45eb3HOcfF/ZzpAjCMdjLL5h4Y0kK
 CPaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770215753; x=1770820553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgQkTjBcICMRJRvuk/RrIJwW0jVGpZIxNmY9lOp/X88=;
 b=n4t/THpG8nBkRhPkmmaDu/5tGXJ+CzB49aaKyVv6bYNWs0hXgTYRa3nNTjGvOUJQ+e
 5vDsKZ5zjo1fx+ZiJ/VnFtVFX1GjG/CB/gazDgqF8JEgDrUN0o6uzdxXSA9eSjNEGxLA
 fCcmB4r87fmDKhWAqV3K60z8QjvOs+sG1PHuEC3dK7Zs3rOfHArFRCQ0vf86t+DaQ9o0
 +rCuc1D+0iLlOi3uO/aY8P1lPVwEoqXAiwYZqixMPmnUmPBiHwRicHwWkU86qdDSZNeO
 fpy5u3sDOc5tQi6mYV0W4/+N1QWzluIeoUtrHenoAB5W9J1yNSr62Hye1AtnvG2/L9xX
 6rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770215753; x=1770820553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgQkTjBcICMRJRvuk/RrIJwW0jVGpZIxNmY9lOp/X88=;
 b=gGtRyKY+unKzibGuwestXxpJuGSIPZU0vU2GlptV++856ppiPZzeGrT3Rvvocus/69
 oqAJlw5cBlCRdX2ixWjnO7CvMc8Nl7YqptHmz4Kv1lpQWWEfkzjMtZsyAwObrNH1KbFh
 ka16zU28UIjRJKIsSI5urhtCzm9GZ0eB8CnUJNIKZD4eGr6A9Ls3QaeeKBqnlG5DH0ZM
 eX5mBlxEMuG6MdEyDx+BkQubt3eHQmcisHIvhYCKtIuK93aCoNOl1+21zcg4p3dATiSH
 tREwa0eKAgbJiNdpyML6vuSwypMm32Gxb3+kNTxwuFpgJP+Kb0Heoy0ZC4i4ua/GDuij
 tHEQ==
X-Gm-Message-State: AOJu0YwW+Uam6tvBM1UFwA6Txs5lGwPUVNovFWouTqtKEF4tDV9sacfF
 1k+mJj3yJESngFzmeKTf+Jnv/6qEUZxhd4lMshYHbo+7CZLtqbesO8108GAiAMHnNnE/pNoJKra
 N6bL3AKKcSGXpRTbblHAbcjki1Yx8OZbEVs/HqkBw6TCt3uAbH3OztaiPbe3vYICOcR1GD/1y+U
 8+D/7+K5TJoBZz6QsEGjsGlOKqx/MyXwI=
X-Gm-Gg: AZuq6aI2GF8iEAqBtT/KYbhObKAjGEsV3qodJ9uy8t0jpGmxccOzAXasRk7FpZZUgUe
 UVAEY8kI7aojCYLFsXH3bD9ZoKfKcGNFbVWUtX3UO7GFEcot5ayzFdoIvF8g50qHB+pjIvAS2C1
 TLJ4eUWgQtEMM9HYXtz0xcJ9oTyiJLAEtN2D6FGN2xkstQQcwnVHbvcGqAjsoJ2LO+r1QN7nLKl
 Yb2mNcxMoR2ONjdPs7iUrsFLw==
X-Received: by 2002:a17:90b:2242:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-354870aad4dmr2344620a91.5.1770215752915; 
 Wed, 04 Feb 2026 06:35:52 -0800 (PST)
X-Received: by 2002:a17:90b:2242:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-354870aad4dmr2344602a91.5.1770215752483; Wed, 04 Feb 2026
 06:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-21-marcandre.lureau@redhat.com>
 <45496226-53eb-4ce6-b93e-7c1b2ffbea83@nutanix.com>
In-Reply-To: <45496226-53eb-4ce6-b93e-7c1b2ffbea83@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Feb 2026 18:35:41 +0400
X-Gm-Features: AZwV_QggSGhr_TTsAKw1JOora4L68R_2Mt1KvNsMXfJt5QJ-YTjmBUmubnemv7w
Message-ID: <CAMxuvawSMRYrTzvjLmQWEsSx8ERfNxxzQRhmoUWD+y16=s7GDg@mail.gmail.com>
Subject: Re: [PATCH 20/37] audio: move object creation to audio_driver_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 4, 2026 at 3:09=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > As we will allow other kind of AudioBackend objects to be instantiated,
> > move the object allocation to a audio_driver_init() and rename it
> > audio_be_new().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/audio.c | 65 +++++++++++++++++++++++++++-----------------------=
-
> >   1 file changed, 34 insertions(+), 31 deletions(-)
> >
> > diff --git a/audio/audio.c b/audio/audio.c
> > index 2a067075b0c..323608ea0d5 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -1561,19 +1561,24 @@ size_t audio_generic_read(HWVoiceIn *hw, void *=
buf, size_t size)
> >       return total;
> >   }
> >
> > -static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
> > +static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> >   {
> > -    const char *drvname =3D AudiodevDriver_str(d->dev->driver);
> > +    const char *drvname =3D AudiodevDriver_str(dev->driver);
> >       struct audio_driver *drv =3D audio_driver_lookup(drvname);
> >
> >       if (!drv) {
> >           error_setg(errp, "Unknown audio driver `%s'", drvname);
> > -        return false;
> > +        qapi_free_Audiodev(dev);
> > +        return NULL;
> >       }
> >
> > -    d->drv_opaque =3D drv->init(d->dev, errp);
> > -    if (!d->drv_opaque) {
> > -        return false;
> > +    AudioMixengBackend *be =3D AUDIO_MIXENG_BACKEND(object_new(TYPE_AU=
DIO_MIXENG_BACKEND));
> > +    be->dev =3D dev;
> > +
> > +    be->drv_opaque =3D drv->init(be->dev, errp);
> > +    if (!be->drv_opaque) {
> > +        object_unref(OBJECT(be));
> > +        return NULL;
> >       }
> >
> >       if (!drv->pcm_ops->get_buffer_in) {
> > @@ -1585,17 +1590,17 @@ static bool audio_driver_do_init(AudioMixengBac=
kend *d, Error **errp)
> >           drv->pcm_ops->put_buffer_out =3D audio_generic_put_buffer_out=
;
> >       }
> >
> > -    audio_init_nb_voices_out(d, drv, 1);
> > -    audio_init_nb_voices_in(d, drv, 0);
> > -    d->drv =3D drv;
> > +    audio_init_nb_voices_out(be, drv, 1);
> > +    audio_init_nb_voices_in(be, drv, 0);
> > +    be->drv =3D drv;
> >
> > -    if (d->dev->timer_period <=3D 0) {
> > -        d->period_ticks =3D 1;
> > +    if (be->dev->timer_period <=3D 0) {
> > +        be->period_ticks =3D 1;
> >       } else {
> > -        d->period_ticks =3D d->dev->timer_period * (int64_t)SCALE_US;
> > +        be->period_ticks =3D be->dev->timer_period * (int64_t)SCALE_US=
;
> >       }
> >
> > -    return true;
> > +    return AUDIO_BACKEND(be);
> >   }
> >
> >   static void audio_vm_change_state_handler (void *opaque, bool running=
,
> > @@ -1792,41 +1797,39 @@ void audio_create_default_audiodevs(void)
> >    */
> >   static AudioBackend *audio_init(Audiodev *dev, Error **errp)
> >   {
> > -    AudioMixengBackend *d;
> > +    AudioBackend *be;
> >
> > -    d =3D AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
> > -    d->dev =3D dev;
> > -    if (d->dev) {
> > -        if (!audio_driver_do_init(d, errp)) {
> > -            goto out;
> > +    if (dev) {
> > +        be =3D audio_be_new(dev, errp);
> > +        if (!be) {
> > +            return NULL;
> >           }
> >       } else {
> >           assert(!default_audio_be);
> >           for (;;) {
> >               AudiodevListEntry *e =3D QSIMPLEQ_FIRST(&default_audiodev=
s);
> > +
> >               if (!e) {
> >                   error_setg(errp, "no default audio driver available")=
;
> > -                goto out;
> > +                return NULL;
> >               }
> > -            d->dev =3D e->dev;
> > +            dev =3D e->dev;
> >               QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
> >               g_free(e);
> > -            if (audio_driver_do_init(d, NULL)) {
> > +            be =3D audio_be_new(dev, NULL);
> > +            if (be) {
> >                   break;
> >               }
> >           }
> >       }
> >
> >       if (!object_property_try_add_child(get_audiodevs_root(),
> > -                                       d->dev->id, OBJECT(d), errp)) {
> > -        goto out;
> > +                                       audio_be_get_id(be), OBJECT(be)=
, errp)) {
> > +        object_unref(be);
> > +        return NULL;
> >       }
> > -    object_unref(d);
> > -    return AUDIO_BACKEND(d);
> > -
> > -out:
> > -    object_unref(d);
> > -    return NULL;
> > +    object_unref(be);
> > +    return be;
> >   }
> >
> >   AudioBackend *audio_get_default_audio_be(Error **errp)
> > @@ -2182,7 +2185,7 @@ void audio_init_audiodevs(void)
> >       AudiodevListEntry *e;
> >
> >       QSIMPLEQ_FOREACH(e, &audiodevs, next) {
> > -        audio_init(e->dev, &error_fatal);
> > +        audio_init(QAPI_CLONE(Audiodev, e->dev), &error_fatal);
> >       }
> >   }
>
> Mildy curious as to the use of QAPI_CLONE() and qapi_free_Audiodev()
> introduced here, but otherwise:
>

audio_be_new() now takes ownership of the Audiodev. I don't remember
the exact details, but ASAN seems happy.

> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

thanks


