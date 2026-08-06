Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E7AC5620A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wru76-0007LF-MA; Thu, 06 Aug 2026 05:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wru75-0007Ih-6A
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 05:10:07 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wru72-0004A3-Tq
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 05:10:06 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1855601a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 02:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786007403; cv=none;
 d=google.com; s=arc-20260327;
 b=QxMIpi9ZRQBLbpDbZUYnHFfWoWLeGzO4TkLehlTF65aSYHhOhPTHKDsfNRWS4aPlRw
 674aG3ZEhqGXAqP1uM1eQDkknjrQMFGxrYYSf1rNhgL1NU98W6OHYWRhUHva7eB8YMzd
 DIzKOavWJKW9Esm9n85Q8Ewj7BGKA3wgi/XnXfZYDrQTdLJIBKhDWOe7+Uviim0stFc+
 eiH7r7ayX5mTqmPnF8KWmHq7hXAzZJlj11FloeGxFPdSY4Q113kJLg1xNUL4rLLU6HLQ
 W0SGJEn1+Qm1tnzJfa9BVKGzSbRxakqHSM+RG7vmQuytY8lcDeQnqzyNpY4c01Oion4b
 tHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UMhJJ679PqduYWa2xQdPeiTT4mkP4/IptnBrup8rd7I=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=HDJ8E5keHgoyX3EzHbNFJ95hjbyme61umeR/17PQGilKnNEnNG9TWek+f8QAJVSJLO
 aeSETnm5cGHeYe7cCBbEmsB+J1zs8YHt6i53W1w/xvYXkhMvr12r1m0aW0gWh3yQm/mW
 6+JLpTefRFO6h9+1rSsTgVZt3Tq7Hd4ETAd/tKMhYzkdwXTL4JQOYWAYz7KfnkiP+tuZ
 agQGG4LdNL2MnD+6G6sUoCZVCzBFSm3Vx96h2laAFw7c8wUANiih0bqP+ctFqcexpvQ0
 zMgYh/aQJuKwZYcLg9+bv1TNIreA1S7bo8I4+PjqTSRhQyh43i1lnn+JGy5Nh9OWNgjH
 Cs7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786007403; x=1786612203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UMhJJ679PqduYWa2xQdPeiTT4mkP4/IptnBrup8rd7I=;
 b=FgXoPDJOX/VTXLzBrbAbSk0jF0zF/KiQJ86kSrV3LEEZ8td8EVn1ntg2OG87gq9gb1
 pVnQgu/3q1trXC17sNYv+zY8RUEgf742ULs9DtAFzJ1+8Vj82mTnBtyoklGvGUSLJQXm
 giRjIxq63NzrrVqrEqjceuMVoi0JC2RLRwSE5f6dDQlx8Rvo4ku9dwuqSeSfS7p7sNSn
 z61rbgaWlLGXTO9rPvyg03l7eszML/H5uXsmh7blV3qWixTJq3q+HPiMg9yj67Gs5R4I
 00UUaV5lGQy7T6RLvGD7JvMM2F+cIuhQOSMORYlwi7p3/ico6ll/0FtaCJMGdAUQIJfu
 /V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786007403; x=1786612203;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UMhJJ679PqduYWa2xQdPeiTT4mkP4/IptnBrup8rd7I=;
 b=Ddn9EFa97ObdNg8C+5Amw01uaLmh1UxbQ3OyFPQWKsIorvjbWhyivW9FIgVax9pjFO
 EeMzU1VFCS9DA83I77WBBMj3EgxQeX6n3zjkxF3a6KF3GFkDJaHM7gODQsg67RmxHemw
 CNL3Afl/MVH+GGAPJDyzdydm+ZAjcT141x4+PT4fSZrS/AwJLlK1HBERMzERx1Lfl8O7
 RB2jNw6uObOy5rFycvmtK/LV8JIpTKHLJkYpZq0Cu1TQiIyLvwGiNtLJzUOIw3GXakA1
 u3HIazKNx61Fp+gaSP2htmhIx176y/7T3/JVeoXXI+Zd2r1IUIP30Z2/mE3/XLCvimT+
 sFaQ==
X-Gm-Message-State: AOJu0YwLL0pHXHDy5euDsQK3jybhzveP5V8QSCWXyirCAPFauaenn8Nt
 lr2bJJtIiykWX0nvcohtbOnt+xKbKPZoZkdt5ThTpcDQpkI0qkFHEMf8GtDbOREWtCA/Ty+sa2V
 so1JKPo1tC9R/DLF7q39HN4jBB+eN85VjNeYaMN4=
X-Gm-Gg: AR+sD12ytymb+f7SsiJQxt9xDSZodrP5BdWbIeQy5Z3pv7gekgZu8CRq1OUKOcYg7JS
 7qSJfJmmiEnkClBrWvIBjNyxaZMdPaGp0db9EBIuJTeumYXZL49veyZfRUjaMlBqWbcDfEFjg46
 VjIVuCNryRlJCI3NXaaRlhyxFlbBC44XMAxjvB68rHVVteELVTWbkq0pIaH8t614YqKuAfUVQIG
 1QRqApO/TMsxRuXSBQA4mtGyA64hgS1OpMnTACwhKMo4fXI5mZ74L4MUi7myfFCLeuk06XnSfza
 DrGDHhSUnDYO1RFdF6nyjcRr6U039wjND2uZMCvb7Y9wakSTx0eet8XlLRYIXCSPizI12A2eiEl
 gpdoLKJ723RA=
X-Received: by 2002:a05:6a20:7283:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3cb85e2b458mr13688066637.17.1786007402622; Thu, 06 Aug 2026
 02:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260805134425.249695-1-marcandre.lureau@redhat.com>
 <4c57fce5-f9ef-4327-ac78-f57f5822e387@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4c57fce5-f9ef-4327-ac78-f57f5822e387@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 6 Aug 2026 13:09:50 +0400
X-Gm-Features: AUfX_mwjhXhi_Ro-dJ9lpIHyPiGb5WVuunk9hspHMlGwXoAWlmY5UGFT_rT17bk
Message-ID: <CAJ+F1C+arxnGvvOnSFAU4mHJgbJxZ=Op+Hgs_0U1S0LS5rmAtw@mail.gmail.com>
Subject: Re: [PATCH v4] hw/display/qxl: validate primary surface stride
 against width
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Thu, Aug 6, 2026 at 8:00=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/08/05 22:44, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The existing validation in qxl_create_guest_primary() checks that
> > abs(stride) * height fits in vgamem_size and that stride is 4-byte
> > aligned, but never checks that abs(stride) is large enough to hold one
> > row of pixels for the declared width and format.
> >
> > A malicious guest can create a primary surface with a stride much
> > smaller than width * bytes_per_pixel (e.g. stride=3D4 for a 64-wide 32b=
pp
> > surface). The spice server rejects this via red_validate_surface(), but
> > the return is void and QEMU unconditionally proceeds to set up the loca=
l
> > rendering state. On the next display refresh, VNC or SDL reads width *
> > bytes_pp per scanline from a region backed by only stride bytes per
> > row, causing a host-side out-of-bounds read.
> >
> > Add three checks in qxl_create_guest_primary() before creating the
> > surface:
> >   - reject unknown surface formats
> >   - reject zero width or height
> >   - reject surfaces where abs(stride) < width * bytes_per_pixel
> >
> > Also fix three related issues in qxl-render.c:
> >   - qxl_blit() used abs_stride to advance the dst pointer into the
> >     DisplaySurface, but when stride is negative the DisplaySurface is a
> >     packed buffer whose stride may be smaller. Use surface_stride()
> >     instead.
> >   - qxl_render_update_area_unlocked() uses guest_head0_width (set via
> >     QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
> >     abs_stride, bypassing the new validation. Clamp the effective width
> >     to abs_stride / bytes_pp to prevent out-of-bounds access while
> >     tolerating the normal transient where the monitor config arrives
> >     before the primary surface is resized to match.
> >   - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
> >     validation. Without clamping, abs_stride * height can overrun
> >     vgamem_size, and the product can also overflow 32 bits (e.g.
> >     abs_stride=3D16 MiB, height=3D256 wraps to zero), defeating the
> >     qxl_phys2virt() bounds check. Clamp height to
> >     vgamem_size / abs_stride to prevent both.
> >
> > Fixes: CVE-2026-16271
> > Fixes: a19cbfb34642 ("spice: add qxl device")
> > Fixes: 979f7ef8966b ("qxl: use guest_monitor_config for local renderer.=
")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
> > Reported-by: huntr bubble
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> > ---
> > v4:
> >   - do not flag zero dimensions as guest bug in render path,
> >     since QXL_MODE_UNDEFINED starts with a zeroed primary surface
> >   - clamp negative-stride to the surface height, so qxl_blit()
> >     cannot walk before it
> >   - tweak commit message
> > ---
> >   hw/display/qxl.h        |  2 ++
> >   hw/display/qxl-render.c | 49 ++++++++++++++++++----------------
> >   hw/display/qxl.c        | 59 ++++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 87 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> > index 48d664f77736..6f5b96fe86cc 100644
> > --- a/hw/display/qxl.h
> > +++ b/hw/display/qxl.h
> > @@ -181,6 +181,8 @@ void qxl_spice_oom(PCIQXLDevice *qxl);
> >   void qxl_spice_reset_memslots(PCIQXLDevice *qxl);
> >   void qxl_spice_reset_image_cache(PCIQXLDevice *qxl);
> >   void qxl_spice_reset_cursor(PCIQXLDevice *qxl);
> > +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
> > +                    uint32_t *bytes_pp, uint32_t *bits_pp);
> >
> >   /* qxl-logger.c */
> >   int qxl_log_cmd_cursor(PCIQXLDevice *qxl, QXLCursorCmd *cmd, int grou=
p_id);
> > diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> > index 4799c9e8befd..57820f211fe6 100644
> > --- a/hw/display/qxl-render.c
> > +++ b/hw/display/qxl-render.c
> > @@ -27,6 +27,7 @@
> >   static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
> >   {
> >       DisplaySurface *surface =3D qemu_console_surface(qxl->vga.con);
> > +    int dst_stride =3D surface_stride(surface);
> >       uint8_t *dst =3D surface_data(surface);
> >       uint8_t *src;
> >       int len, i;
> > @@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *re=
ct)
> >       } else {
> >           src +=3D rect->top * qxl->guest_primary.abs_stride;
> >       }
> > -    dst +=3D rect->top  * qxl->guest_primary.abs_stride;
> > +    dst +=3D rect->top  * dst_stride;
> >       src +=3D rect->left * qxl->guest_primary.bytes_pp;
> >       dst +=3D rect->left * qxl->guest_primary.bytes_pp;
> >       len  =3D (rect->right - rect->left) * qxl->guest_primary.bytes_pp=
;
> >
> >       for (i =3D rect->top; i < rect->bottom; i++) {
> >           memcpy(dst, src, len);
> > -        dst +=3D qxl->guest_primary.abs_stride;
> > +        dst +=3D dst_stride;
> >           src +=3D qxl->guest_primary.qxl_stride;
> >       }
> >   }
> > @@ -64,27 +65,9 @@ void qxl_render_resize(PCIQXLDevice *qxl)
> >       qxl->guest_primary.qxl_stride =3D sc->stride;
> >       qxl->guest_primary.abs_stride =3D abs(sc->stride);
> >       qxl->guest_primary.resized++;
> > -    switch (sc->format) {
> > -    case SPICE_SURFACE_FMT_16_555:
> > -        qxl->guest_primary.bytes_pp =3D 2;
> > -        qxl->guest_primary.bits_pp =3D 15;
> > -        break;
> > -    case SPICE_SURFACE_FMT_16_565:
> > -        qxl->guest_primary.bytes_pp =3D 2;
> > -        qxl->guest_primary.bits_pp =3D 16;
> > -        break;
> > -    case SPICE_SURFACE_FMT_32_xRGB:
> > -    case SPICE_SURFACE_FMT_32_ARGB:
> > -        qxl->guest_primary.bytes_pp =3D 4;
> > -        qxl->guest_primary.bits_pp =3D 32;
> > -        break;
> > -    default:
> > -        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
> > -                qxl->guest_primary.surface.format);
> > -        qxl->guest_primary.bytes_pp =3D 4;
> > -        qxl->guest_primary.bits_pp =3D 32;
> > -        break;
> > -    }
> > +    /* fallback to default bpp if format is unknown */
> > +    qxl_format_bpp(qxl, sc->format, &qxl->guest_primary.bytes_pp,
> > +                   &qxl->guest_primary.bits_pp);
>
> sc->format is a raw guest-little-endian field. On a big-endian host,
> every valid format misses the switch and qxl_format_bpp() now latches
> guest_bug, disabling command-ring and I/O processing. Previously this
> function merely used its fallback, so the device-wide failure is
> introduced here.

I'll also fix sc->stride handling above. I suspect there are more
endianness bugs around..

>
> >   }
> >
> >   static void qxl_set_rect_to_surface(PCIQXLDevice *qxl, QXLRect *area)
> > @@ -103,6 +86,26 @@ static void qxl_render_update_area_unlocked(PCIQXLD=
evice *qxl)
> >       int height =3D qxl->guest_head0_height ?: qxl->guest_primary.surf=
ace.height;
> >       int i;
> >
> > +    if (width <=3D 0 || height <=3D 0) {
> > +        goto end;
> > +    }
> > +
> > +    if (qxl->guest_primary.bytes_pp > 0) {
> > +        int max_width =3D qxl->guest_primary.abs_stride
> > +                        / qxl->guest_primary.bytes_pp;
> > +        width =3D MIN(width, max_width);
> > +    }
> > +
> > +    if (qxl->guest_primary.qxl_stride < 0) {
> > +        /* qxl_blit() uses the primary height to find the first scanli=
ne. */
> > +        height =3D MIN(height, (int)qxl->guest_primary.surface.height)=
;
> > +    }
> > +
> > +    if (qxl->guest_primary.abs_stride > 0) {
> > +        int max_height =3D qxl->vgamem_size / qxl->guest_primary.abs_s=
tride;
> > +        height =3D MIN(height, max_height);
> > +    }
>
> qxl_render_update_area_unlocked() maps abs_stride * height, but
> qxl_blit() indexes from the declared surface.height. When the monitor
> height is smaller, a permitted dirty row can read beyond the span
> validated by qxl_phys2virt().

ok

>
> Regards,
> Akihiko Odaki
>
> > +
> >       if (qxl->guest_primary.resized) {
> >           qxl->guest_primary.resized =3D 0;
> >           qxl->guest_primary.data =3D qxl_phys2virt(qxl,
> > diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> > index b7d871b9ee33..384b8767b8e6 100644
> > --- a/hw/display/qxl.c
> > +++ b/hw/display/qxl.c
> > @@ -1489,6 +1489,47 @@ static void qxl_create_guest_primary_complete(PC=
IQXLDevice *qxl)
> >       qxl_render_resize(qxl);
> >   }
> >
> > +/*
> > + * Convert a SpiceSurfaceFormat to bytes per pixel and bits per pixel.
> > + *
> > + * Only valid for surface suitable for rendering.
> > + */
> > +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
> > +                    uint32_t *bytes_pp, uint32_t *bits_pp)
> > +{
> > +    uint32_t bypp =3D 4;
> > +    uint32_t bipp =3D 32;
> > +    bool ret =3D true;
> > +
> > +    switch (format) {
> > +    case SPICE_SURFACE_FMT_16_555:
> > +        bypp =3D 2;
> > +        bipp =3D 15;
> > +        break;
> > +    case SPICE_SURFACE_FMT_16_565:
> > +        bypp =3D 2;
> > +        bipp =3D 16;
> > +        break;
> > +    case SPICE_SURFACE_FMT_32_xRGB:
> > +    case SPICE_SURFACE_FMT_32_ARGB:
> > +        bypp =3D 4;
> > +        bipp =3D 32;
> > +        break;
> > +    default:
> > +        ret =3D false;
> > +        qxl_set_guest_bug(qxl, "%s: unhandled format: %x", __func__, f=
ormat);
> > +    }
> > +
> > +    if (bytes_pp !=3D NULL) {
> > +        *bytes_pp =3D bypp;
> > +    }
> > +    if (bits_pp !=3D NULL) {
> > +        *bits_pp =3D bipp;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >   static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
> >                                        qxl_async_io async)
> >   {
> > @@ -1496,6 +1537,7 @@ static void qxl_create_guest_primary(PCIQXLDevice=
 *qxl, int loadvm,
> >       QXLSurfaceCreate *sc =3D &qxl->guest_primary.surface;
> >       uint32_t requested_height =3D le32_to_cpu(sc->height);
> >       int requested_stride =3D le32_to_cpu(sc->stride);
> > +    uint32_t bytes_pp;
> >
> >       if (requested_stride =3D=3D INT32_MIN ||
> >           abs(requested_stride) * (uint64_t)requested_height
> > @@ -1532,6 +1574,23 @@ static void qxl_create_guest_primary(PCIQXLDevic=
e *qxl, int loadvm,
> >           return;
> >       }
> >
> > +    if (!qxl_format_bpp(qxl, surface.format, &bytes_pp, NULL)) {
> > +        return;
> > +    }
> > +
> > +    if (surface.width =3D=3D 0 || surface.height =3D=3D 0) {
> > +        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
> > +                          __func__, surface.width, surface.height);
> > +        return;
> > +    }
> > +
> > +    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
> > +        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
> > +                          " stride %d width %u bpp %u",
> > +                          __func__, surface.stride, surface.width, byt=
es_pp);
> > +        return;
> > +    }
> > +
> >       surface.mouse_mode =3D true;
> >       surface.group_id   =3D MEMSLOT_GROUP_GUEST;
> >       if (loadvm) {
>
>

