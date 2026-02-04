Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDAAE9D3EB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vne2Q-0000e2-QB; Wed, 04 Feb 2026 09:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vne2N-0000da-ID
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vne2L-00074y-75
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770215959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dumdNAc4549Ee6+AHw2/0YnpngY+baQ4wAYY4m+rVKY=;
 b=IBbVV+HZFWhHFVVfdo5OVmD9EylFO6MkXV63eRD1OQgNQ1apbjtR6UPqrTc5F8tD81schr
 3HCpBHTBuD+2lajsvYzZVsoUFdL6yiw6i3cVWXC6QNbktaQWaWtkXIxr3mOUeuqCBGlli6
 0YURC+xHKX7HDrxiY9Qs9TYddJFFaEM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-7NTz2i99MzeuUiIhBRMrtw-1; Wed, 04 Feb 2026 09:39:14 -0500
X-MC-Unique: 7NTz2i99MzeuUiIhBRMrtw-1
X-Mimecast-MFC-AGG-ID: 7NTz2i99MzeuUiIhBRMrtw_1770215953
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a76b0673dcso68216805ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215953; cv=none;
 d=google.com; s=arc-20240605;
 b=W8HqzxJKUG2Zykl0chzI1+G5uImZTOHU/q3YjX+jtJEENqyIvmK02hsmBLiNkNS8Tq
 UikR5Y0q6n2K+N8xoh/HpSr8DjM2elxVDItpqQ9L4YneRYiDeIQoWVx//mdcLwO//HCn
 Z8Ly8OrpGCquRSgg385z8phXFVOEM3md3TvhQs/VGLHJrTYEK3L825it+r4z3nDjfcO5
 k28JlTtqrXvGp9rfM7wr3Co/gDaXiP7meFnGqB9FDJnP/uZqvBfLE0HrVCn33TR8YFbY
 Rais35QfwiEXzTit7MoQLvYBn6fxu4/70ACCITgiBPTXuRiSYjf73YIVUIlI9l8qvorH
 R1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dumdNAc4549Ee6+AHw2/0YnpngY+baQ4wAYY4m+rVKY=;
 fh=7YH/6k/j25NNwwt5Z0aNR+l5vsUJilkY+EqN5Ef/xhY=;
 b=Ss5UtKPPwrWXLHSPn2oBIzcSYqYOHS0uwqs11vfRenMeUMFg12dAaHwDwernQime8F
 qZYUGvptDfjNxuBTdftDi5pwH1qHsu3cD7fyXGalDuPEe5nN3qtl8oRoCyYLwo8WteJ9
 h0p6qaLRQt8HKA1GvshAleWFeoy0q5FdOsUwGeWb06YC7rJTYPbzXv1tD+VttvBg3qWP
 ZIUg/wXQXTYiieeO4kuqCO2pJNq6RRBi9tzp46q7WkY7tbxeAvsi6nMPunaT0XqOvAwK
 RgMD467e1bnwl5aI80csFEGH0OOwPy1IolGajM5BE2inyldKmcltCX91iq9EMOXAvXj7
 MV7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770215953; x=1770820753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dumdNAc4549Ee6+AHw2/0YnpngY+baQ4wAYY4m+rVKY=;
 b=o2UhNq3GwPptxNp5PpArbTxA14VPmpH2A3+tjo3TULy3Cit1ImNl8y6rH/3osIyyQC
 baZOP0gfI7hmGsOZp7MyCt1phR9+iwV8hLQmyqzzYuHLAe2vPJmnxNqFCCpSggz7cwEo
 dYptUWFiatDwaZGLOXtrks3y5/lho9COkJXE7ka3W5sP7071qMYduQuddFNTCOV8riNm
 ffNZdN0tHWdIWTjcJuRw5iPGBS+nkaKeifiC9KOfiZ65j4f7/pc2EBFiK4gwl0JbK/If
 5uo0hNp90ANOVnu+VpftZb6sDbVJo9HhR0sB5PNviZ98Msll85gb6BcN26UQtd2sZycI
 2HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770215953; x=1770820753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dumdNAc4549Ee6+AHw2/0YnpngY+baQ4wAYY4m+rVKY=;
 b=eQQe0c0w6xOf3CbxU/qge4pubD+epQwi08pGuoSi8Bq4AR3lk4rnmNITjlgGXDqO2M
 bVglf+upw22xwsOJO6AA3FERLewdVeLDqFWeZ9CUz2fSKyDYeKWOoSoe+eMPT4Ih3F7N
 fh4p3kiCinkc9xOUHZ8p5aPFQKB0/Z3CkNxyQN4Mw/YC1yfcHKgBNQQDLBuG5cdiMcWq
 jDbJ4zN2xcRALiIkjeyYIrQ6rrJbX3/+SvsezuzEs0O0UR8GZOnPpPPfWhqv49Imp7Zc
 QS7rLcwTfnTwRA7Kr2ebqEhAlioJDZriH9dm3qD/qKv2hWZnfUnyixsEuVcMINQhgJpb
 hg4g==
X-Gm-Message-State: AOJu0YyYJ6uTKIH/US9KvYYXHkO8/qxCpbuQ18kmkfLZ3Q8ScqDf8HLW
 GMFVpwYUKUmS8/HG0lqF9bNovYwpdo1JQgVW3mgVmsYzRvpEOxUN4NwhBFCxfH9kaq4+oUzX6Vr
 0CJTs8zfo/UvyOTFfsDgjLprP6hmsVqAoylN9GXp+4GIM8bR8a7j+SwJKMsD7o9xS2cKMTe6Xkd
 edhYYC+09AqxvoMnWM4OzR1CNl8VZB9hU=
X-Gm-Gg: AZuq6aIYUsS1XQPuEq2G/Eu1RJZ3IATKpoGMD1AdL/hm7oOvWMeELIbKVeaK7/2r/nP
 jfezzz6tW7R4naltdGomYxYCECqRjhPvU8M+ARtOhQZsIRqLRlo9d6M/WMVyqNHW7ODXTaJXdxn
 9f2DE/CU/1/at5bczMw7MVHBgFIGxWpC+vNmmgEboqQkynI3mDoTrwZ2FR6PuZU0rL30FCPyZCp
 Gcd0i4j9nzda/bVNEH4qxwiIQ==
X-Received: by 2002:a17:903:2ecc:b0:2a7:c21e:398d with SMTP id
 d9443c01a7336-2a933fa5ec3mr33082875ad.32.1770215953316; 
 Wed, 04 Feb 2026 06:39:13 -0800 (PST)
X-Received: by 2002:a17:903:2ecc:b0:2a7:c21e:398d with SMTP id
 d9443c01a7336-2a933fa5ec3mr33082655ad.32.1770215952887; Wed, 04 Feb 2026
 06:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-24-marcandre.lureau@redhat.com>
 <c77444a3-8bfb-44d0-8b6b-b72d59ed4e63@nutanix.com>
In-Reply-To: <c77444a3-8bfb-44d0-8b6b-b72d59ed4e63@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Feb 2026 18:39:00 +0400
X-Gm-Features: AZwV_QhawMlMuCL9kTPXKGxrROOsNBmQr1t6MC3i6fzKI-iJuBEN69Lw6wMoVkc
Message-ID: <CAMxuvazrTrL1mW6XDDgQTw+RpQn0NnMGLGirLzgxnXqpqTO_Ag@mail.gmail.com>
Subject: Re: [PATCH 23/37] audio: lookup "audio-" object types,
 and realize them
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

On Wed, Feb 4, 2026 at 3:33=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Now "audio_driver" is a detail implementation of AudioMixengBackend and
> > not required to implement an AudioBackend.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/qemu/audio.h |  1 +
> >   audio/audio.c        | 40 ++++++++++++++++++++++++++--------------
> >   2 files changed, 27 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> > index 474d761f0be..1eeead2a722 100644
> > --- a/include/qemu/audio.h
> > +++ b/include/qemu/audio.h
> > @@ -51,6 +51,7 @@ typedef struct AudioBackend {
> >   typedef struct AudioBackendClass {
> >       ObjectClass parent_class;
> >
> > +    bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
> >       const char *(*get_id)(AudioBackend *be);
> >   #ifdef CONFIG_GIO
> >       bool (*set_dbus_server)(AudioBackend *be,
> > diff --git a/audio/audio.c b/audio/audio.c
> > index 7e23a63d401..f6896229cfb 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> > @@ -1561,24 +1561,16 @@ size_t audio_generic_read(HWVoiceIn *hw, void *=
buf, size_t size)
> >       return total;
> >   }
> >
> > -static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> > +static bool audio_mixeng_backend_realize(AudioBackend *abe,
> > +                                         Audiodev *dev, Error **errp)
> >   {
> > -    const char *drvname =3D AudiodevDriver_str(dev->driver);
> > -    struct audio_driver *drv =3D audio_driver_lookup(drvname);
> > +    AudioMixengBackend *be =3D AUDIO_MIXENG_BACKEND(abe);
> > +    audio_driver *drv =3D AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
> >
> > -    if (!drv) {
> > -        error_setg(errp, "Unknown audio driver `%s'", drvname);
> > -        qapi_free_Audiodev(dev);
> > -        return NULL;
> > -    }
> > -
> > -    AudioMixengBackend *be =3D AUDIO_MIXENG_BACKEND(object_new(TYPE_AU=
DIO_MIXENG_BACKEND));
> >       be->dev =3D dev;
> > -
> >       be->drv_opaque =3D drv->init(be->dev, errp);
> >       if (!be->drv_opaque) {
> > -        object_unref(OBJECT(be));
> > -        return NULL;
> > +        return false;
> >       }
> >
> >       if (!drv->pcm_ops->get_buffer_in) {
> > @@ -1600,7 +1592,26 @@ static AudioBackend *audio_be_new(Audiodev *dev,=
 Error **errp)
> >           be->period_ticks =3D be->dev->timer_period * (int64_t)SCALE_U=
S;
> >       }
> >
> > -    return AUDIO_BACKEND(be);
> > +    return true;
> > +}
> > +
> > +static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> > +{
> > +    const char *drvname =3D AudiodevDriver_str(dev->driver);
> > +    g_autofree char *type =3D g_strconcat("audio-", drvname, NULL);
> > +    AudioBackend *be =3D AUDIO_BACKEND(object_new(type));
> > +
> > +    if (!be) {
> > +        error_setg(errp, "Unknown audio driver `%s'", drvname);
> > +        return NULL;
> > +    }
> > +
> > +    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
> > +        object_unref(OBJECT(be));
> > +        return NULL;
> > +    }
> > +
> > +    return be;
> >   }
> >
> >   static void audio_vm_change_state_handler (void *opaque, bool running=
,
> > @@ -1643,6 +1654,7 @@ static void audio_mixeng_backend_class_init(Objec=
tClass *klass, const void *data
> >   {
> >       AudioBackendClass *be =3D AUDIO_BACKEND_CLASS(klass);
> >
> > +    be->realize =3D audio_mixeng_backend_realize;
> >       be->get_id =3D audio_mixeng_backend_get_id;
> >   }
>
> I'm wondering if an AudioBackendClass realize() method is the right way
> to handle this, and if instead an object_property_set() function could
> be used to set a "driver" property?
>

By the end of the refactoring, "driver" is gone. Effectively, each
(current) backend will inherit from AudioMixengBe.


