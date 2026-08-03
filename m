Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F73EC55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqqZm-0005UY-S1; Mon, 03 Aug 2026 07:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wqqZh-0005UF-0d
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wqqZe-00062i-QE
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785755473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWjXZkR+pRIJq2CPruMl7+kP9c+Hy4/85oZ/M794UmQ=;
 b=Ur79CiL6dyWDwMvTGpvVeVRFmQBxIUM9C1yYVlFSyN9UTLG400nRdcRvcz+htLmpthYZ6/
 BDaDjIMFyeXtYOQmIDPsfWQP9wu2C1SyTYv6aRwje7txLoRks0+T82PWRObgSRpvfLSSFF
 VcroIveiRO6xGr6dF7lXV4h2KLThIaw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-4gIhy3deP-2oQ8pQ-gVBtQ-1; Mon, 03 Aug 2026 07:11:11 -0400
X-MC-Unique: 4gIhy3deP-2oQ8pQ-gVBtQ-1
X-Mimecast-MFC-AGG-ID: 4gIhy3deP-2oQ8pQ-gVBtQ_1785755471
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so5026054a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 04:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785755471; cv=none;
 d=google.com; s=arc-20260327;
 b=HipddlmABDkhPkEluFT1dIGbOqV39uiWlsIh4SVwy+lm/XfLvfVLdoYFJZcYJNTJSM
 4JpqTygpruBWZE3yJS0lExl1zksMt7XgsnicKTGzjpmrnifFTimyVnuj+KIAz5ZRvaT0
 kmAZls/EZOOiorao2njX1BR9bkASvjQzTmkixjl4nIhhcThRypThdXuifOb9ogQl54lx
 4YX/LR2TAstk27NzkdyGzSK+2bgXn1J/cepc1rJaaMvLYgQCtMTj/SSUJKHPlkriUnBx
 bD9XYs2H7KQGZreNLjEIRkWUzh1IPnwV87Edwvnhldm4dZSJK4kuEIBiiHwWT2PlkeDc
 luzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uWjXZkR+pRIJq2CPruMl7+kP9c+Hy4/85oZ/M794UmQ=;
 fh=4wBBUZ8BjOyAMokcc/DbepkPpbRHeYF6hiVjL7CUbYw=;
 b=piW97UcCWfBAzMw8Urmqc/2ZagcSpWaIaYUiwmtOUdGTr1QFqgksT+pe6JnrQKxAhR
 c4IHCDo43EbEj1HKYeZkCPkCdD5tueHj6KjD6KkSQCGPkqeJRMe2htQlrYzMF55s6j1h
 p7CgUXxLPkGCkrYYC9lXEjf5F4ewh3xYg8Qx1RG0/H66A1XDz0UJ6jRk7IPsCVeA428c
 PuJktCbhPngwe4HqXN2h9ZMS5Er3PXfa0jZxvQpAo3ouYdo94iqc1Nv+JesgK8w/4DIG
 PdhS2gx8TUpe1eZWZSf1OstDwgMDiJrRICPUyOOlwbzsFw56PwCVWx7IdGXSTM1WtvAz
 UrUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785755471; x=1786360271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uWjXZkR+pRIJq2CPruMl7+kP9c+Hy4/85oZ/M794UmQ=;
 b=o+6DemXosIb5N0un1vR3tV9xdaKpjAg+sJ89lvrYWO5OuLFv5afHZ3ejSj+7nnYHeS
 GhDIYZC1vj0VeVlUehJN2fe0dz6hs9QW2S9d53Y+KaWbR9qpi8GIQPsu+PXQ2MlzTFsL
 Q4KTFKc4QP3ZjS3WfhqoQJEE8/afcN7JfnMzGQjTFNvKIJbLs2GzdVbwzQgG6erulebB
 SFYH2iiqhpm794murujpujWLSfk2sd40bEb9sMVoY33KFCZddQLH5l2XRp64dW5bcumI
 3LB5cKd9njK2WHpFZYagd+lBOJuZTgeYF5AHglRk/5xDg6yYHn6KxK2vubGK1BtKPVxv
 LNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785755471; x=1786360271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uWjXZkR+pRIJq2CPruMl7+kP9c+Hy4/85oZ/M794UmQ=;
 b=PJYOsS3Xu6LlFHYUJK5X8voc3tB8tTuszsPgNFhIO6TzJ1EuLCKKB42RX8ivRcA9KA
 mETXy2y3sfyFEcwVs7DcDFDtZmSFGI68v61dBvM2s3sM5SNZ67T5bl0f3HZ7K6VkPQzr
 TGLFIKTzHSpLN/mNZdZA9YLz+c17yj2aosoWgSPwlxAraZNZasGpl/iKsckgBMxPKpxU
 xMLxN8HE/YPHY1qtQmsdU0+4tlgDsj2BdJjE3sNUsvIHnrcoM+TRTsADgquA9klHJn3T
 cy8xmJzG068ow0IfdUAm/RV/9bcfUFV8eBcs/kmqyNm0Ko882zDw/K6kJAM6SkR4QuLE
 E3ZA==
X-Gm-Message-State: AOJu0YzMMM0xmUSK77wBrjO9HNZmpU0yEFTJJ6eTDynON4dppKKQq7CZ
 jinJYhAlUT5lRBPqyKXPGTR8MRGlTEUcdYe7f8E4H+YtOVW5L3MZHMOqYZuelHgG1xXLTOtHd1U
 Xac1GuFgLR7wTxcTYn0sIZSj5GCUKmfMDzaxDcto718GEWzOd1QKCsScV8wvvSAhxSVUpe1atg5
 /OCRK6XDKHMq0L/SDzjAa1pdVhuqiIY3En1KEO+GLglw==
X-Gm-Gg: AR+sD10GZo5Htm0GzqG6rvSwvRlZqX121QyhDYORFziPVrkSCqAzlRaNFdVPDiD7uj4
 QLUQTLfRzWd2ZSV0UWMOvjWcEkRiDlL9tCksCUCGoYP35tGOEZBaDzy82OLB0iByEKdsjkdIBFZ
 YOlyOcxjds1HuXoGd84BD5ZtUoXXBExm/JI8DavBiXacxRQ/MecmBBd9+ZDBScJ0sCIZcBMWpJV
 0qR2fa+YP44HJ8KP1BPaW+ALLoF7PJoXO1X5IggC5MJ7yVLntpTQ8mkfQypSKbI/7tYTvTSvvIu
 jQ==
X-Received: by 2002:aa7:8891:0:b0:848:7b92:8e68 with SMTP id
 d2e1a72fcca58-84ee49031cdmr8209463b3a.66.1785755470432; 
 Mon, 03 Aug 2026 04:11:10 -0700 (PDT)
X-Received: by 2002:aa7:8891:0:b0:848:7b92:8e68 with SMTP id
 d2e1a72fcca58-84ee49031cdmr8209420b3a.66.1785755469772; Mon, 03 Aug 2026
 04:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260725122411.1769492-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260725122411.1769492-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 3 Aug 2026 15:10:57 +0400
X-Gm-Features: AUfX_mxOBIrchvxSsdvRn_R3lRshAwJbGT6WPI--DUY0GdPcwpV7DEXK7c_Cfa8
Message-ID: <CAMxuvawO0RfUvL6oZcZHvRxsTBvLPAQnOhoO7Q-184YLohwr3g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/display/qxl: validate primary surface stride
 against width
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jul 25, 2026 at 4:24=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The existing validation in qxl_create_guest_primary() checks that
> abs(stride) * height fits in vgamem_size and that stride is 4-byte
> aligned, but never checks that abs(stride) is large enough to hold one
> row of pixels for the declared width and format.
>
> A malicious guest can create a primary surface with a stride much
> smaller than width * bytes_per_pixel (e.g. stride=3D4 for a 64-wide 32bpp
> surface). The spice server rejects this via red_validate_surface(), but
> the return is void and QEMU unconditionally proceeds to set up the local
> rendering state. On the next display refresh, VNC or SDL reads width *
> bytes_pp per scanline from a region backed by only stride bytes per
> row, causing a host-side out-of-bounds read.
>
> Add three checks in qxl_create_guest_primary() before creating the
> surface:
>  - reject unknown surface formats
>  - reject zero width or height
>  - reject surfaces where abs(stride) < width * bytes_per_pixel
>
> Also fix three related issues in qxl-render.c:
>  - qxl_blit() used abs_stride to advance the dst pointer into the
>    DisplaySurface, but when stride is negative the DisplaySurface is a
>    packed buffer whose stride may be smaller. Use surface_stride()
>    instead.
>  - qxl_render_update_area_unlocked() uses guest_head0_width (set via
>    QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
>    abs_stride, bypassing the new validation. Clamp the effective width
>    to abs_stride / bytes_pp to prevent out-of-bounds access while
>    tolerating the normal transient where the monitor config arrives
>    before the primary surface is resized to match.
>  - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
>    validation. Without clamping, abs_stride * height can overrun
>    vgamem_size, and the product can also overflow 32 bits (e.g.
>    abs_stride=3D16 MiB, height=3D256 wraps to zero), defeating the
>    qxl_phys2virt() bounds check. Clamp height to
>    vgamem_size / abs_stride to prevent both.
>
> Fixes: CVE-2026-16271
> Fixes: 3761abb16784 ("hw/display/qxl: fix signed to unsigned comparison")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
> v2:
>  - also clamp height
>  - factor out qxl_format_bpp() helper

ping

> ---
>  hw/display/qxl.h        |  2 ++
>  hw/display/qxl-render.c | 46 ++++++++++++++++----------------
>  hw/display/qxl.c        | 59 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 23 deletions(-)
>
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index 48d664f77736..6f5b96fe86cc 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -181,6 +181,8 @@ void qxl_spice_oom(PCIQXLDevice *qxl);
>  void qxl_spice_reset_memslots(PCIQXLDevice *qxl);
>  void qxl_spice_reset_image_cache(PCIQXLDevice *qxl);
>  void qxl_spice_reset_cursor(PCIQXLDevice *qxl);
> +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
> +                    uint32_t *bytes_pp, uint32_t *bits_pp);
>
>  /* qxl-logger.c */
>  int qxl_log_cmd_cursor(PCIQXLDevice *qxl, QXLCursorCmd *cmd, int group_i=
d);
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index 4799c9e8befd..b0a71a95ad66 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -27,6 +27,7 @@
>  static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
>  {
>      DisplaySurface *surface =3D qemu_console_surface(qxl->vga.con);
> +    int dst_stride =3D surface_stride(surface);
>      uint8_t *dst =3D surface_data(surface);
>      uint8_t *src;
>      int len, i;
> @@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect=
)
>      } else {
>          src +=3D rect->top * qxl->guest_primary.abs_stride;
>      }
> -    dst +=3D rect->top  * qxl->guest_primary.abs_stride;
> +    dst +=3D rect->top  * dst_stride;
>      src +=3D rect->left * qxl->guest_primary.bytes_pp;
>      dst +=3D rect->left * qxl->guest_primary.bytes_pp;
>      len  =3D (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
>
>      for (i =3D rect->top; i < rect->bottom; i++) {
>          memcpy(dst, src, len);
> -        dst +=3D qxl->guest_primary.abs_stride;
> +        dst +=3D dst_stride;
>          src +=3D qxl->guest_primary.qxl_stride;
>      }
>  }
> @@ -64,27 +65,9 @@ void qxl_render_resize(PCIQXLDevice *qxl)
>      qxl->guest_primary.qxl_stride =3D sc->stride;
>      qxl->guest_primary.abs_stride =3D abs(sc->stride);
>      qxl->guest_primary.resized++;
> -    switch (sc->format) {
> -    case SPICE_SURFACE_FMT_16_555:
> -        qxl->guest_primary.bytes_pp =3D 2;
> -        qxl->guest_primary.bits_pp =3D 15;
> -        break;
> -    case SPICE_SURFACE_FMT_16_565:
> -        qxl->guest_primary.bytes_pp =3D 2;
> -        qxl->guest_primary.bits_pp =3D 16;
> -        break;
> -    case SPICE_SURFACE_FMT_32_xRGB:
> -    case SPICE_SURFACE_FMT_32_ARGB:
> -        qxl->guest_primary.bytes_pp =3D 4;
> -        qxl->guest_primary.bits_pp =3D 32;
> -        break;
> -    default:
> -        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
> -                qxl->guest_primary.surface.format);
> -        qxl->guest_primary.bytes_pp =3D 4;
> -        qxl->guest_primary.bits_pp =3D 32;
> -        break;
> -    }
> +    /* fallback to default bpp if format is unknown */
> +    qxl_format_bpp(qxl, sc->format, &qxl->guest_primary.bytes_pp,
> +                   &qxl->guest_primary.bits_pp);
>  }
>
>  static void qxl_set_rect_to_surface(PCIQXLDevice *qxl, QXLRect *area)
> @@ -103,6 +86,23 @@ static void qxl_render_update_area_unlocked(PCIQXLDev=
ice *qxl)
>      int height =3D qxl->guest_head0_height ?: qxl->guest_primary.surface=
.height;
>      int i;
>
> +    if (width <=3D 0 || height <=3D 0) {
> +        qxl_set_guest_bug(qxl, "%s: invalid dimension %dx%d",
> +                          __func__, width, height);
> +        goto end;
> +    }
> +
> +    if (qxl->guest_primary.bytes_pp > 0) {
> +        int max_width =3D qxl->guest_primary.abs_stride
> +                        / qxl->guest_primary.bytes_pp;
> +        width =3D MIN(width, max_width);
> +    }
> +
> +    if (qxl->guest_primary.abs_stride > 0) {
> +        int max_height =3D qxl->vgamem_size / qxl->guest_primary.abs_str=
ide;
> +        height =3D MIN(height, max_height);
> +    }
> +
>      if (qxl->guest_primary.resized) {
>          qxl->guest_primary.resized =3D 0;
>          qxl->guest_primary.data =3D qxl_phys2virt(qxl,
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index b7d871b9ee33..384b8767b8e6 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1489,6 +1489,47 @@ static void qxl_create_guest_primary_complete(PCIQ=
XLDevice *qxl)
>      qxl_render_resize(qxl);
>  }
>
> +/*
> + * Convert a SpiceSurfaceFormat to bytes per pixel and bits per pixel.
> + *
> + * Only valid for surface suitable for rendering.
> + */
> +bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
> +                    uint32_t *bytes_pp, uint32_t *bits_pp)
> +{
> +    uint32_t bypp =3D 4;
> +    uint32_t bipp =3D 32;
> +    bool ret =3D true;
> +
> +    switch (format) {
> +    case SPICE_SURFACE_FMT_16_555:
> +        bypp =3D 2;
> +        bipp =3D 15;
> +        break;
> +    case SPICE_SURFACE_FMT_16_565:
> +        bypp =3D 2;
> +        bipp =3D 16;
> +        break;
> +    case SPICE_SURFACE_FMT_32_xRGB:
> +    case SPICE_SURFACE_FMT_32_ARGB:
> +        bypp =3D 4;
> +        bipp =3D 32;
> +        break;
> +    default:
> +        ret =3D false;
> +        qxl_set_guest_bug(qxl, "%s: unhandled format: %x", __func__, for=
mat);
> +    }
> +
> +    if (bytes_pp !=3D NULL) {
> +        *bytes_pp =3D bypp;
> +    }
> +    if (bits_pp !=3D NULL) {
> +        *bits_pp =3D bipp;
> +    }
> +
> +    return ret;
> +}
> +
>  static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>                                       qxl_async_io async)
>  {
> @@ -1496,6 +1537,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *=
qxl, int loadvm,
>      QXLSurfaceCreate *sc =3D &qxl->guest_primary.surface;
>      uint32_t requested_height =3D le32_to_cpu(sc->height);
>      int requested_stride =3D le32_to_cpu(sc->stride);
> +    uint32_t bytes_pp;
>
>      if (requested_stride =3D=3D INT32_MIN ||
>          abs(requested_stride) * (uint64_t)requested_height
> @@ -1532,6 +1574,23 @@ static void qxl_create_guest_primary(PCIQXLDevice =
*qxl, int loadvm,
>          return;
>      }
>
> +    if (!qxl_format_bpp(qxl, surface.format, &bytes_pp, NULL)) {
> +        return;
> +    }
> +
> +    if (surface.width =3D=3D 0 || surface.height =3D=3D 0) {
> +        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
> +                          __func__, surface.width, surface.height);
> +        return;
> +    }
> +
> +    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
> +        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
> +                          " stride %d width %u bpp %u",
> +                          __func__, surface.stride, surface.width, bytes=
_pp);
> +        return;
> +    }
> +
>      surface.mouse_mode =3D true;
>      surface.group_id   =3D MEMSLOT_GROUP_GUEST;
>      if (loadvm) {
> --
> 2.55.0
>


