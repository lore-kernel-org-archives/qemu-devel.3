Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F571C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2EQy-0003mh-1B; Thu, 03 Sep 2026 16:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x2EQw-0003mQ-3f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:53:18 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x2EQu-0002ik-B4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:53:17 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-39927410578so385498a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788468795; cv=none;
 d=google.com; s=arc-20260327;
 b=HkznWHNxlTO1MSTzBGsHI+p0MIpJguACY9GEFQU1+pqRWSigtA4fDM6q+X7KcbwpxS
 Aun0Ti6Ri8W8QLvLLfUubF3vkD8V2ET1Nt+Cdo4SR/u9mEo8MwSuJpj947arW1sileX6
 YQOEBP/U1K58B7uB8R8xXdUR2Ej7cPz2SZHzm9UVZHBpRTQEZaCATRAP0T2arE5cWEkH
 QaViiqKj39Ld/B2ANNDLqszzMgBIdwuv+1bz+DXPoieUgp29xxUUvu2JhL5Y/Xut6cX8
 Fxw904gStReDIvnUiAXXEzKMhd9n3bCTDsFWSqbeg5DbCsGAVxG4cecfAOGrdH/nxsyj
 mN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zuEZMHoIHhpREYX/vrTmrS+0I92l8ELwtKuD4+Yf33E=;
 fh=2pplYgXEM+hOlv/5PGO56be0/FYYBiT2ZGRiKFfiBbE=;
 b=fX54OSC/VhpTZn33+PZp+EvcwlkqGtTkaVqtYIDyC+u8aPTh8j8QuIX9f2c4E3yDmH
 TtyIoNZbFukTriFkhBY6oky4pUX6jXkedNnhynuwja+RoFMJGcT236L6Jh4vzPdvPgTa
 rkir58WUpLttKYkptP3Rw+xxlYgTziyney/LCovMymIrdYJwvmlDi3QlztrZFiYAmsWo
 ZOP8+ea2KfCk014BI8RAj2NBoM1drQDPHEQb5ETgSM8doAyv1KW16RbPoCl1hftFcN+o
 50r6P8JQao5MMyB5O0Nc8K/8Q7zF39R33J5KmlJV99jet9UbVCrw8h1bh1SAOB8h5oAX
 Sykg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788468795; x=1789073595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zuEZMHoIHhpREYX/vrTmrS+0I92l8ELwtKuD4+Yf33E=;
 b=rtcB9Pbk5bFcPzqnIaha3OhBSOx+7oPBL+sgh8nl6iXEVtehGWxj28TRyDTKOF440j
 4+rh942LfDciBAdB2haaMUHeTKMK5+So2D0ZLOesoSvX81WnWm8GEJ5rsedMXA2eEx1S
 lRaf3G/KDEA0VN7g8Z0UNFrJKCSMIpSLkjIThnhxptif9Qj3Qjbgq38Md+R+DVztsFuN
 +tVZxDPlzc4wMADRXGATDhtnx7SBGMJa04mfZFMgqpaLH8e75hvusxDBqVincC/yFndG
 apJRa2PX2VY7hbMV0YTYPPQHzwJnez3RkPozDMObczDHZSXxZJGUdjkDQuf0FkzZW8S3
 JjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468795; x=1789073595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zuEZMHoIHhpREYX/vrTmrS+0I92l8ELwtKuD4+Yf33E=;
 b=gSRW1kCr4nWmZcZNbTCaGIobSt4yh2dhrti/SSltOxGDWrG/Qlyp4+aRteopGNmA5n
 dgEMiGSsR5LHHJMS/dffibELXZZBmuz2SdHRzgmkGTTiSxAZtAEmR6mLfYowGHv/A3mQ
 0TKV6/4kLw1W+tUD0h7kS1fsg13Yig6hVTKWmMkGrkp7x4nj9IvwI9xpEs5Sg1pfVkiF
 IbIGwevvM/4Io8lNjmRxtMwQnFzHtecNLEIZ9CBTkTuIAyg5kkLVU6IdH3x9WR4RQM5B
 X7tmaQrAjerTPXBBA6qD6LCSeujOdplEXFlxfrc5AOzcfuZqrIZeO3Z0CtHqlc4dGuE1
 oVoA==
X-Gm-Message-State: AFuF++mGKVkvo+ItKcbirhXt6kVe3yukxVbifaGGnto5KcpUWHmTBQp4
 HcQfQaIyR9ps/xoMzoO4YgE8X/RPgC1eLJAs/McDyR+NPSvNAvgNrvYejflswm7gD0H3J7mkQ6r
 /WBKJO2wUxnidi9WLKOQupnG6xAqf7gs=
X-Gm-Gg: AYBFou09qaSq38d9y9zlz63m/acHAT4tkDmTq4Wltp+SO9xiVCGUqcbulUCHdA0NHM3
 vh7rwKt6rDSjP+m7xCeruwuauH0gLxNhA4OpvR9zlvO3wXd1Dss8azwWz9dKWQeF8OhgdBMjl+e
 CRkc84hN6zRp6KnD3W9IuPElcImj61DptqX4F94LDjU0LbaoRiWli1i4mbA7isifZGrv0E9jW6x
 0GST/SwknE2OwqtsXDKAnUCI4uVUA0iu30e9daS5s1YuMwFh+lCSBYzNvuw961fPZ5QjmQPOBGq
 OD/E1RlG1hKIsLis7Fx1Ri0c2UqT3b+5J1/KR+HqmZEk4FQOGaza6sE1B0F26iFA5C6vfjY4L3z
 d
X-Received: by 2002:a17:90b:2542:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-39b26101402mr1801305a91.5.1788468794648; Thu, 03 Sep 2026
 13:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
 <20260825-fixes-v1-5-c59e8a620836@redhat.com>
 <CAFEAcA-e1N+f2G+ah3=9OXD9oM85ZEzUD3-DuRyrRg8KoU3ZDw@mail.gmail.com>
In-Reply-To: <CAFEAcA-e1N+f2G+ah3=9OXD9oM85ZEzUD3-DuRyrRg8KoU3ZDw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 4 Sep 2026 00:53:03 +0400
X-Gm-Features: AcwNN1UVB2AtbFTGohRUB7OtVqHCVrbNYhtMpNDXNDFYrz1_SzcG0L9voAqfWaY
Message-ID: <CAJ+F1CLTQTvDty9i4H2YGU6pV91cO9EAVGJNxADEL3WvEyR0OA@mail.gmail.com>
Subject: Re: [GIT PULL 05/19] virtio-gpu: use g_try_malloc to avoid
 guest-triggered abort
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 3, 2026 at 11:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 25 Aug 2026 at 12:29, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Use g_try_malloc/g_try_new0 for guest-controlled allocation, so failure
> > returns an error to the guest rather than crashing the host (glib
> > behaviour).
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3898
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-ID: <20260805130141.211398-1-marcandre.lureau@redhat.com>
>
> Hi; Coverity has some notes about this commit (CID 1685636,
> 1685637, 1685638):
>
> > @@ -498,17 +498,22 @@ vg_create_mapping_iov(VuGpu *g,
> >      }
> >
> >      esize =3D sizeof(*ents) * ab->nr_entries;
> > -    ents =3D g_malloc(esize);
> > +    ents =3D g_try_malloc(esize);
> > +    if (!ents && esize) {
> > +        return -1;
> > +    }
>
> This means that if esize =3D=3D 0 we will continue even though
> ents is NULL.
>
> >      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                     sizeof(*ab), ents, esize);
>
> Coverity complains because it thinks iov_to_buf() might
> try to dereference a NULL ent. I think that's wrong (a
> zero size makes iov_to_buf() never touch the buffer), but
> it does raise the question -- do we really want to be
> continuing ahead here with a zero size and NULL buffer pointer,
> rather than handling zero sizes with some kind of early return?
>
> I think it's preferable to have the "allocation failure"
> check be a plain "if (!ptr) { leave early }", because then
> static analysis tools don't go down blind alleys assuming
> that execution can run through all kinds of paths in the rest
> of the function with a NULL pointer.
>
> This specific check is what is triggering CID 1685638.

The previous code was accepting 0/NULL.. I agree it is questionable.

There is nothing in vg_resource_attach_backing() that prevents 0/NULL.
So unless we have a clear indication that this is invalid, I would
rather not change it.

I think we can silence those warnings for now, unless we have more
evidence or clear argument. I am happy to fix it otherwise.

>
> > diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/vi=
rgl.c
> > index 550fd03bf5c4..20bae57d0fe4 100644
> > --- a/contrib/vhost-user-gpu/virgl.c
> > +++ b/contrib/vhost-user-gpu/virgl.c
> > @@ -209,7 +209,11 @@ virgl_cmd_submit_3d(VuGpu *g,
> >          return;
> >      }
> >
> > -    buf =3D g_malloc(cs.size);
> > +    buf =3D g_try_malloc(cs.size);
> > +    if (!buf && cs.size) {
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> > +        return;
> > +    }
> >      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                     sizeof(cs), buf, cs.size);
>
> This one is CID 1685636.
>
> >      if (s !=3D cs.size) {
>
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index fbb6fec7a0ad..9eb010082d0d 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -892,7 +892,10 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >      }
> >
> >      esize =3D sizeof(*ents) * nr_entries;
> > -    ents =3D g_malloc(esize);
> > +    ents =3D g_try_malloc(esize);
> > +    if (!ents && esize) {
> > +        return -1;
> > +    }
> >      s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                     offset, ents, esize);
>
> And this one is CID 1685637.
>
> thanks
> -- PMM
>

