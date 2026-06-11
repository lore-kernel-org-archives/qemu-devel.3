Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD3CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbsN-00037z-Q8; Thu, 11 Jun 2026 05:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wXbsL-00037b-Nb
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wXbsJ-0000D5-O1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781170736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7W8Wv9lSkns1CrS5GBy/3T6cO4vBAqv0K8BMLgWAZs=;
 b=PYlYw7IIr1JQliR0xiJfX9RHsGFpqkyhUbsi6rintT7lMcTU77BtN2eSXAdMHdzb6/qHEV
 m4SYJvLnMLbUAOtwFA4LC2SW2mK8fqg7u6fgHELcLOQjzvVU9cblmNQtezcPXtK0X7DwfW
 oTjF1C82CfIrxfUAMZ8YnFJdCs3rOw4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-l4fB3roEMe6s-EM7n9lsUQ-1; Thu, 11 Jun 2026 05:38:50 -0400
X-MC-Unique: l4fB3roEMe6s-EM7n9lsUQ-1
X-Mimecast-MFC-AGG-ID: l4fB3roEMe6s-EM7n9lsUQ_1781170729
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0532a6588so72187725ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 02:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781170729; cv=none;
 d=google.com; s=arc-20240605;
 b=DwcDAkjKy/DeSGD1dSvpQyiNqfQ9IvllsGOS7Swe88Arlv/00KxIZxbPeWTrbuwmBG
 7KWYj3RS5JYwYUxXi3S6//rGWoiqkPS7BkI4faxh2B7XMVwvJM49S+CvKIXjH2ahZu7c
 InKW5awhN7ukaCZyt7RLjIytNcC6PahcjdcMVfBf5XUMxxfaiZacaubQivl2vagfbn/F
 nzRtjJCsAMWJGndSYEtjZvd56wNza4v/VaKXyYbU5OLFF1qKjKWpEhElqQ5fc8tXLB4c
 XVG2SEGR+XcRey3NrBEXjUcEcxA6sW6h9u6i4BZPLn4K+PRl1R1DvMgzbaPR1AtrIDbB
 9Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p7W8Wv9lSkns1CrS5GBy/3T6cO4vBAqv0K8BMLgWAZs=;
 fh=9dVB1HX5f/lZfzul2cmuyofoPK8BBxvXeYi39TI2rr0=;
 b=SuU5/fYbWMO4RQRqbP9IDmZbWsr3o0F1igiGyOAOQ6b0798WNZRdGTnltq1dOY0FZp
 LM+2v5vOpXB5+QUVXwYN5lMWPe+PzXIyYNjnFVU5xFxSA9k9uw33hsjfOwXjK+9DoP8O
 Vqvk9TsgKcozNZrNEQPJ09Y4hN11YXrm0N0NPqe+J+iXUGl/AgEHT6bYBUuxfeKAWygK
 q6kEHsNhzLb9hkcb4aJf8x21IdFKm4Gv3HQRmNOfvu+/3ktf5vSBJtBpNLennUD5lhdv
 Swilsd29bBtUU6yjtN4TizTkuaxKr/jBwMYBY3kbTaITr7CLNqD693waB2ZAisPpYAoa
 c3Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781170729; x=1781775529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7W8Wv9lSkns1CrS5GBy/3T6cO4vBAqv0K8BMLgWAZs=;
 b=F6fdzwy/hnkbeB00bqCfY2H7vWNalwA6SRSi1/BqWmOcseyqAOMj5KJ/w54kr/UMHS
 rs0jV8e/hUfCa5QZkMuwFRC8UVepymsubbdiNyBlrGe7BoEBTUWotOWeAjqDrLH9Rvqq
 VfUEbkbhVkx0nbJfqILLf4W7/RGQrRWruXX4LTBE0BEERs82rcrxXcH0mfhC1i9MInL5
 YsayQA6nE8bDXh9e8O0UCnSBLLZMeE8qjWAFhFrR+/X/BC0AovxXUiy50saOLZG6FnJQ
 7sXPMWHa/V9g5cKuR4OLkz5fn+1bGj9Jri5ro6BUzJHzXpiYmqUv6TIvV3iVly6d3vCj
 pHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781170729; x=1781775529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7W8Wv9lSkns1CrS5GBy/3T6cO4vBAqv0K8BMLgWAZs=;
 b=LPW4iArGifzFdbOQ6AEl5oJs/oyZ6Dd7aPIeiSANH9S/uBrijywT9Mnh+meMeYYwK+
 LKq6t/JxWrNtCovejRg+ClyzxVm8r7G5mGzgvyUSptnLrNJkiy7YuJQDdYpOt8iTOe/1
 c+ziY5zcMzhYN6gUusfTK5ycsWok8elg1nrD3QPKqIjAOjQUNYjDIvu7LDJtyVJirC8C
 FHTa3k3nKBvzK3SkuDJeZuma/Nf/tFKq1y9lo1zBBOGHqwry1pwlYBUmM+xL+n38BDiI
 J+EFZiEFdhNGBoSZdulTKVmnxpshd7OO3T4r3b1+CwCnMqwNUaS7m+DYaAbvcbZ+zmPX
 OT1A==
X-Gm-Message-State: AOJu0YxbHder6M2kDNtRCa4kQkGk+vLc02lTdsoe5lu/z+cRctHwHPbg
 xSR00C5ETn8b6YC5QykBfFj8hOJht+bnQG9vYUVk2PDTpt3Ips17QxEEQedlpzRRdBM/dtDIWCQ
 MzQjZ9ON6/kPvWTNsZqW4au48I2vZt7d6Qn3gF6bkxvYlYpIS4fuKwIEY903la2V/oC+aokfeeM
 k0n85/G6RKcNMe4tXGtEZQ9qJrkyRSrpA=
X-Gm-Gg: Acq92OGuANyE6D6PA6EQJuZ98bTlUjXWVeKp2+09LScLTv/uy1rU1KlmT8LGSXPTAu+
 xLHp8ttPp8gLb7USTY0nmFn8R6CyZiPABuL6PSnyA58H/6aSsNy0DjQV7Za7xnvU/0uKtlG+ZiW
 NogViZzNCfZSCfy3XSod6OWor2XpYNdwHqs90WNUaFfKf0wrW2RUkvAB2z2ce5hDV2t/42YJWmq
 Kr1r/i3fApy0nGX9EK4NvQa9Spkn8fugEEXay3engRdzXoHSo8D3Mj5ppo2hlV897RIguUP+9M0
 BFahzLkQzYO/JBhQNCMcvBdsPcRGBMXHKA==
X-Received: by 2002:a17:903:1b30:b0:2c0:a373:89bf with SMTP id
 d9443c01a7336-2c2f0440700mr24733175ad.1.1781170729153; 
 Thu, 11 Jun 2026 02:38:49 -0700 (PDT)
X-Received: by 2002:a17:903:1b30:b0:2c0:a373:89bf with SMTP id
 d9443c01a7336-2c2f0440700mr24732865ad.1.1781170728606; Thu, 11 Jun 2026
 02:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
 <20241014133935.470709-19-marcandre.lureau@redhat.com>
 <CAFEAcA9kBAUESA+ATfYLM8bPuNJ6xB_HLPAp9SrsuQ4LP4m_dA@mail.gmail.com>
 <CAFEAcA-wuhdRVc44HSOdQnGP05sCg3Ngt7KsZS3EOa7duQLJOw@mail.gmail.com>
In-Reply-To: <CAFEAcA-wuhdRVc44HSOdQnGP05sCg3Ngt7KsZS3EOa7duQLJOw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:38:36 +0400
X-Gm-Features: AVVi8Ccz-fM2MPp-7QUxCWg90NnFDyTr2FXQ7_hnjdc9vwa4CQhHJCFhpZbA7Fc
Message-ID: <CAMxuvaxKiddemvvmu3q80DaQecYJy0NUm=iFMFxWMikNJkAWOg@mail.gmail.com>
Subject: Re: [PULL 18/20] ui: refactor using a common qemu_pixman_shareable
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter

On Thu, Jun 11, 2026 at 12:42=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> Ping -- does anybody have suggestions for the best fix
> for this regression ?
>

Sorry I missed it, I will send fixes.
thanks

> thanks
> -- PMM
>
> On Fri, 29 May 2026 at 14:34, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 14 Oct 2024 at 14:41, <marcandre.lureau@redhat.com> wrote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Use a common shareable type for win32 & unix, and helper functions.
> > > This simplify the code as it avoids a lot of #ifdef'ery.
> > >
> > > Note: if it helps review, commits could be reordered to introduce the
> > > common type before introducing shareable memory for unix.
> > >
> > > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Message-ID: <20241008125028.1177932-19-marcandre.lureau@redhat.com>
> >
> > Hi; this is a rather old commit (now 1ff788db9781615b in git),
> > but I have just noticed that it seems to break the usage of
> > qemu_create_displaysurface_from() by hw/display/xlnx_dp.c.
> >
> >
> > > @@ -517,14 +482,25 @@ DisplaySurface *qemu_create_displaysurface_from=
(int width, int height,
> > >      DisplaySurface *surface =3D g_new0(DisplaySurface, 1);
> > >
> > >      trace_displaysurface_create_from(surface, width, height, format)=
;
> > > -#ifndef WIN32
> > > -    surface->shmfd =3D -1;
> > > -#endif
> > > -    surface->image =3D pixman_image_create_bits(format,
> > > -                                              width, height,
> > > -                                              (void *)data, linesize=
);
> >
> > Before this refactoring, qemu_create_displaysurface_from() always
> > calls pixman_image_create_bits(). That pixman function allows
> > you to pass NULL to mean "allocate me the memory for the data".
> > If you do that, pixman will always compute the stride for the
> > data (by looking at the pixel format and the width), so the
> > input linesize here is ignored. The xlnx_dp.c code takes
> > advantage of this in calls like:
> >
> >         s->g_plane.surface
> >                 =3D qemu_create_displaysurface_from(width, height,
> >                                                   s->g_plane.format, 0,=
 NULL);
> >
> > > -    assert(surface->image !=3D NULL);
> > > +    surface->share_handle =3D SHAREABLE_NONE;
> > >
> > > +    if (data) {
> > > +        surface->image =3D pixman_image_create_bits(format,
> > > +                                                  width, height,
> > > +                                                  (void *)data, line=
size);
> > > +    } else {
> > > +        qemu_pixman_image_new_shareable(&surface->image,
> > > +                                        &surface->share_handle,
> > > +                                        "displaysurface",
> > > +                                        format,
> > > +                                        width,
> > > +                                        height,
> > > +                                        linesize,
> > > +                                        &error_abort);
> > > +        surface->flags =3D QEMU_ALLOCATED_FLAG;
> > > +    }
> >
> > In the refactored version, although non-NULL data still
> > results in a call to pixman_image_create_bits(), now a NULL
> > data pointer means we call qemu_pixman_image_new_shareable().
> >
> > > +bool
> > > +qemu_pixman_image_new_shareable(pixman_image_t **image,
> > > +                                qemu_pixman_shareable *handle,
> > > +                                const char *name,
> > > +                                pixman_format_code_t format,
> > > +                                int width,
> > > +                                int height,
> > > +                                int rowstride_bytes,
> > > +                                Error **errp)
> > > +{
> > > +    ERRP_GUARD();
> > > +    size_t size =3D height * rowstride_bytes;
> >
> > This function assumes that rowstride_bytes is not zero,
> > so the previously-working "pass 0, NULL" now results in
> > a size value of 0 here and an attempt to allocate 0 bytes
> > in qemu_pixman_shareable_alloc(), which winds up triggering
> > an abort in qemu_memfd_alloc().
> >
> > Presumably:
> > (1) qemu_pixman_image_new_shareable() should calculate the
> > rowstride_bytes as pixman does, rather than requiring it
> > to be passed in
> > (2) qemu_memfd_alloc() ought not to abort on zero size
> >
> >
> > For a repro case:
> >
> > $ cat /tmp/xlnx-dp.txt
> > writel 0xfd4a0194 0x00000780
> > writel 0xfd4a0198 0x00000438
> > $ ./build/arm/qemu-system-aarch64 -accel qtest -M xlnx-zcu102
> > -display none -chardev
> > file,id=3Drepro,path=3D/dev/null,input-path=3D/tmp/xlnx-dp.txt -qtest
> > chardev:repro
> > [I 0.000000] OPENED
> > pulseaudio: set_sink_input_volume() failed Reason: Invalid argument
> > pulseaudio: set_sink_input_mute() failed Reason: Invalid argument
> > [R +0.121066] writel 0xfd4a0194 0x00000780
> > [S +0.121092] OK
> > [R +0.121096] writel 0xfd4a0198 0x00000438
> > Unexpected error in qemu_memfd_alloc() at ../../util/memfd.c:143:
> > qemu-system-aarch64: failed to allocate shared memory: Invalid argument
> > Aborted (core dumped)
> >
> > thanks
> > -- PMM
>


