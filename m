Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF180CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXb00-0003VU-O8; Thu, 11 Jun 2026 04:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXazy-0003V8-Q6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:42:50 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXazx-00056C-33
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:42:50 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66062a414fcso8551801d50.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 01:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167367; cv=none;
 d=google.com; s=arc-20240605;
 b=CHDbhV+SWzoa0rDM6KC8ORHw77J28RhspPZL/BtiIe3diyU9JLFShqArV6tHTPVPI0
 m54jGBZKzXJM9VKHVb3wFjWuIkRAVpF8NZvMWJ7NaLPDD/SItNQBIECpKPMco3Wr0HfP
 YNjwVaSjg4tXNQTfCqeKf5raLJuqTMj2x1Ounlu/qDm+pvBKegxIoiProK2BTT1Z5NEC
 XREzRjA3bNDeqZN41XMyN022JLN0IVMybJ56TEpHrUCe/1cpqyd1nEJa70WYWGxIQX5N
 pKOjnfK6tSVgY5koEMHxOt2x01uLuws4C6d17RAd547nDtKwtNmOanYzOjYLX1mrdHFx
 dLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mWWhH03T5VRWIBwRbGmz9d1HPX4OId+5W+QZjs7c6TQ=;
 fh=TpNiJu7eWjoj/sj8B9ppLGSr7HqVokMiQY3poZNBRDg=;
 b=ItiTTtDqS6EKg2zRzNofW99xzxOzk6oXQm40hi5VTwWIVSdFeM3vQQyq/p3PwbzQea
 7TkkiqcoihRUUhDd2dIAq8nZ+sLUqtybasqjIVBwi6aB2PFuQimIzMkP6X+rdnzQabCj
 kHSuriXW/c872aHr30uor5VTwLhldodCWknUoN1HRECPaJLn0UfAlahjUu9ETuVWdx9O
 Pjm0gqWdVwrWdz+F8LkT6t51FfvyyuAR9DVJyS/oQ9pfrgmrwLTSd01XCXqvOhiV5/I5
 VTD6hkrC1sT7iESVPPyxakfhMUDlJV1XSIfnsKRttH4qhmWtFa8Vm0ahop60Z0mzs6ub
 Bxaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781167367; x=1781772167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWWhH03T5VRWIBwRbGmz9d1HPX4OId+5W+QZjs7c6TQ=;
 b=rHw1LJuWDre1Wo+nCdYcvLXH+4Zi1MVRmdJuCINtYP7iVqMLPKfXb4pE31scz3vjQt
 UGfht9gvBGan2ZLTaWWxp87xdrd9lZPxhESDkLshLgTcuRSPpgvmTOkOLbIBS0FL2MWK
 jpQ/zlq4zZ3pT5lOrh/PxuCObJDLYZKUQ6HRYcGkiOWtNK2k9IR2vFw2GtxCk304QgCV
 m+B+Vsd1GnFcGGkspWny0giBh7WSSHa2B+VLaO+aQymFRQADyTw28hl8gwMl54urwjaV
 gXv96M53zvc+Lui6Nt2Hr99mj26B8QWON6rJeqDITLHsGJIlXVIia9WmfNHbSAsiULhg
 iiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781167367; x=1781772167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mWWhH03T5VRWIBwRbGmz9d1HPX4OId+5W+QZjs7c6TQ=;
 b=YYtYXH33bJoCVShHYNRy6Hsvlg7xTy0DiRRO1jI7MPt10z2gE2nGReG5yLZCUsjRZ7
 9GaE3hTnr70dFdYlNtdswFJItt7LVf8uKRGr5T8QkJcJ++ZNkNvSQp8elqZjJ230tQkx
 2RTTFfrdosCnIBVdS6c/WBCnfvcORry/0zKp2kky3ou6Ok36UriGK+jtwkhdB3DzehOc
 fjdzyt/KA5vbWjRied9/5gUDDOO7L5OHd5aHrcBBlfrTkXYRUhajFD24+lhwYJFJ8Fk5
 tjOUSu7BNr4MF9IgIZ3DxSb4j9lGBIhehMC6CybJR1hU3em+ztPh87eGpp6OfTRpQQi9
 ClCw==
X-Gm-Message-State: AOJu0YwSiAPhov0S2t/mQfKSITw+tz7xKgA+dkHEEQOXh5S374hN1tff
 oV/UiMl6wsR66YF+Lzf/PgElpuNkwkpeM4yb54NrSygRk+AHF/0UvSrOFGCccDJbOPe6YehTH9D
 B5lpiUuWCrS5V679B07x8wsGfUdIR0dtOGRBAIotLAw8eB07OaOsX
X-Gm-Gg: Acq92OECpTSo7Vr72A2k7O5N4guOEru+UgwgXcfpGb6Aa+JufLu32zuN22Uo+SlMQH6
 LSjrSAhBySibSUE+HVLma3ZGhU8YVQDB6MouormKJNN323/e0MraIB2P8S8jDzmxjtUoX2LFmQj
 h9RkAmgHdLtdaBoTSY62bmtWcZT7C8zTKy18y8G6guFQf2rsnhXqCoQkYzvVL3mi8FCKZIdOWAf
 6eSbUP89jnGB7Vp8RRnkY7taQG1curh4h8rGrP2osSOMLuHx+HgfjHj7IgXQczPt/0tI39SgCnm
 pd41LFBZCrJlbXa2T7OdrqRBqzjO452+40PHLuH65LOC92ACQu9ZxifSOLxTBUNzmrgQLf+LmB6
 /J05mYIe2Weef
X-Received: by 2002:a53:d00a:0:b0:660:8fc2:cba0 with SMTP id
 956f58d0204a3-662699ff617mr1391689d50.58.1781167367074; Thu, 11 Jun 2026
 01:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
 <20241014133935.470709-19-marcandre.lureau@redhat.com>
 <CAFEAcA9kBAUESA+ATfYLM8bPuNJ6xB_HLPAp9SrsuQ4LP4m_dA@mail.gmail.com>
In-Reply-To: <CAFEAcA9kBAUESA+ATfYLM8bPuNJ6xB_HLPAp9SrsuQ4LP4m_dA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2026 09:42:35 +0100
X-Gm-Features: AVVi8Cf3b8XUaCuY0-BDoxaDJ17CcA9Y_hdJD8d8usLCc1KbQKdbixIJ9EYkuu8
Message-ID: <CAFEAcA-wuhdRVc44HSOdQnGP05sCg3Ngt7KsZS3EOa7duQLJOw@mail.gmail.com>
Subject: Re: [PULL 18/20] ui: refactor using a common qemu_pixman_shareable
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

Ping -- does anybody have suggestions for the best fix
for this regression ?

thanks
-- PMM

On Fri, 29 May 2026 at 14:34, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 14 Oct 2024 at 14:41, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Use a common shareable type for win32 & unix, and helper functions.
> > This simplify the code as it avoids a lot of #ifdef'ery.
> >
> > Note: if it helps review, commits could be reordered to introduce the
> > common type before introducing shareable memory for unix.
> >
> > Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Message-ID: <20241008125028.1177932-19-marcandre.lureau@redhat.com>
>
> Hi; this is a rather old commit (now 1ff788db9781615b in git),
> but I have just noticed that it seems to break the usage of
> qemu_create_displaysurface_from() by hw/display/xlnx_dp.c.
>
>
> > @@ -517,14 +482,25 @@ DisplaySurface *qemu_create_displaysurface_from(i=
nt width, int height,
> >      DisplaySurface *surface =3D g_new0(DisplaySurface, 1);
> >
> >      trace_displaysurface_create_from(surface, width, height, format);
> > -#ifndef WIN32
> > -    surface->shmfd =3D -1;
> > -#endif
> > -    surface->image =3D pixman_image_create_bits(format,
> > -                                              width, height,
> > -                                              (void *)data, linesize);
>
> Before this refactoring, qemu_create_displaysurface_from() always
> calls pixman_image_create_bits(). That pixman function allows
> you to pass NULL to mean "allocate me the memory for the data".
> If you do that, pixman will always compute the stride for the
> data (by looking at the pixel format and the width), so the
> input linesize here is ignored. The xlnx_dp.c code takes
> advantage of this in calls like:
>
>         s->g_plane.surface
>                 =3D qemu_create_displaysurface_from(width, height,
>                                                   s->g_plane.format, 0, N=
ULL);
>
> > -    assert(surface->image !=3D NULL);
> > +    surface->share_handle =3D SHAREABLE_NONE;
> >
> > +    if (data) {
> > +        surface->image =3D pixman_image_create_bits(format,
> > +                                                  width, height,
> > +                                                  (void *)data, linesi=
ze);
> > +    } else {
> > +        qemu_pixman_image_new_shareable(&surface->image,
> > +                                        &surface->share_handle,
> > +                                        "displaysurface",
> > +                                        format,
> > +                                        width,
> > +                                        height,
> > +                                        linesize,
> > +                                        &error_abort);
> > +        surface->flags =3D QEMU_ALLOCATED_FLAG;
> > +    }
>
> In the refactored version, although non-NULL data still
> results in a call to pixman_image_create_bits(), now a NULL
> data pointer means we call qemu_pixman_image_new_shareable().
>
> > +bool
> > +qemu_pixman_image_new_shareable(pixman_image_t **image,
> > +                                qemu_pixman_shareable *handle,
> > +                                const char *name,
> > +                                pixman_format_code_t format,
> > +                                int width,
> > +                                int height,
> > +                                int rowstride_bytes,
> > +                                Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    size_t size =3D height * rowstride_bytes;
>
> This function assumes that rowstride_bytes is not zero,
> so the previously-working "pass 0, NULL" now results in
> a size value of 0 here and an attempt to allocate 0 bytes
> in qemu_pixman_shareable_alloc(), which winds up triggering
> an abort in qemu_memfd_alloc().
>
> Presumably:
> (1) qemu_pixman_image_new_shareable() should calculate the
> rowstride_bytes as pixman does, rather than requiring it
> to be passed in
> (2) qemu_memfd_alloc() ought not to abort on zero size
>
>
> For a repro case:
>
> $ cat /tmp/xlnx-dp.txt
> writel 0xfd4a0194 0x00000780
> writel 0xfd4a0198 0x00000438
> $ ./build/arm/qemu-system-aarch64 -accel qtest -M xlnx-zcu102
> -display none -chardev
> file,id=3Drepro,path=3D/dev/null,input-path=3D/tmp/xlnx-dp.txt -qtest
> chardev:repro
> [I 0.000000] OPENED
> pulseaudio: set_sink_input_volume() failed Reason: Invalid argument
> pulseaudio: set_sink_input_mute() failed Reason: Invalid argument
> [R +0.121066] writel 0xfd4a0194 0x00000780
> [S +0.121092] OK
> [R +0.121096] writel 0xfd4a0198 0x00000438
> Unexpected error in qemu_memfd_alloc() at ../../util/memfd.c:143:
> qemu-system-aarch64: failed to allocate shared memory: Invalid argument
> Aborted (core dumped)
>
> thanks
> -- PMM

