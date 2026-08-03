Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1383FC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqqCY-0000pc-4t; Mon, 03 Aug 2026 06:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wqqCX-0000pS-8b
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:47:21 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wqqCV-0002cU-7G
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:47:20 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so2036694a91.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 03:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785754037; cv=none;
 d=google.com; s=arc-20260327;
 b=CAIt+QmoJLU0YZpLdF1IgQbJVy8ZEhZ/6MBpe3EaNNZmnajJo6yO+b24iaBLPk4yOX
 +DntdIAUCNu/ScE9DNlv9ScedN8VNvYXRY0JMv4Ipaiuze2uMPWC9zjNV0UkUPgU0sX3
 tgV1im+eOiswQEE1WZZsEhHTqCYPFWBsRM8x75ju2/qjKbSWwN4ryt37OPyiWZyLs55A
 oOLsZvT8fGnA9ynX/3ClfkeaF6asSWKqWUeNiQwNDdZk4s3TCjCKnYGNhxj6ZtKXwSkP
 miFuMPoYn/YighsiAtyZwpzZVddXxT60JutwCQzr1VTyTP71Ymp+JVfISuUI5LtPA6xC
 m9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XVmSE596qKM8Y7UezYMq4fO+fEeBdRdhmoQSaU2e2F8=;
 fh=i9CwLnv/dHKZ45lJ1t8Mfhr83l6jrA0+RwEVVJT7XdI=;
 b=nXGhVO1BQdzWzaryBQNUSapmgIscgi7C0Us7UTaRS7bxMQgbDK9wZ2PPBs6pqoHJoE
 XO4yeCo6jhP0G+oNDcqept9g8OYvemDt7NoIA0FveBYu784RPgKbtZ5hfhm6u5ihBYWz
 5r7Bwchz8dlGBPlo2APTR/PGUesqf7uXMYfekuJ6Eg58z54vcpWpbZzoiCIHI5fbv/tZ
 LSS9N3rh6MyALDWdS247K704Vw/wNGq4Uga4VAC0enERcizLe5GATrGA2/+N2TNK1YiF
 A0vMl4L7tzrWAcrn/CnVFI6y8j+glLl+sHvPE4MDsL+HcPcePtPaQwXSvqiVOPkKG7+A
 6l6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785754037; x=1786358837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XVmSE596qKM8Y7UezYMq4fO+fEeBdRdhmoQSaU2e2F8=;
 b=ZWtnTjXHuIetfcqp43c3CQhFuY5hMXqwWmmEOnPhaSP5Oyk/wmCci11OwpUjnlHIBs
 5b9VVYwfIFjDFv44/zqmXH/lHGkjIRBnB9XMvN9TKaOiPG7EcrOR943AUoCz8cHQluV5
 YQJ9+NjmNv4O5gCgit2td9sSjHwOl1w0XrulqRATnfihreSWgxW7ieHBVMU09uQEaLWl
 dqLow6oE4kqqaxaHeVNrwM4Q2Pk1dWAABHfYhaNY0+V/SwCL+IvDp5ygYp5YewLzx2U8
 X5hsdg1B3ZFv+seTCO0ApdG7iM5PEpHlfAJ1Tz92vI3aF2ku9m0JJXuY4D0VQ8UmwzJg
 4i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785754037; x=1786358837;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XVmSE596qKM8Y7UezYMq4fO+fEeBdRdhmoQSaU2e2F8=;
 b=tDZl+djUaN8e3ZdjbBm6cH1AQeFE9Ioc4BvImmPlZvmo1GiyWX074Zwa0SpUI/ad8r
 8uu5XvA2J5TBk+8ohE0i3C9OopqRJS3gKY0qCdo5SyzN9v4vyUDYWTUw/wizT0d3oWHv
 Gl92Fj4T0f2tTiL5K8Yx7dimHaa5N3HrTv9lM4l6BZ27vM+/oahi0/Ot4+pvSbfw56Lb
 wPXHo83kSd3TZmydCbm+cF7QGNyct5XNBD24vaOLhRfMMP4CeOolnnJbkcbM28uFtzh1
 fA1tLOYbrT53luaTfZbk/9xpdsaLuCmFijtfHHEb9eAvSz29+NThzhy0LHQ3BNbrc/ip
 8JYA==
X-Gm-Message-State: AOJu0YyCoEtOzNof6Cm9kU+gekn1UYvOP7rj1ZCfMU1ys3G4WbSxeBDu
 RnIA2stLd/tG9QJHC3XIFXYwy1++4UHTDyJ8pOASzgbqcka/GDENnzJZDvyWEr+eJaKm8VSz2Xi
 C60WEPpnnkftQAZpbMtz9R9JJeXUl+H5zBrmsRyE=
X-Gm-Gg: AR+sD111AhxLGgBVHl3cO9xrmlGpfh01MUzbOxXw6l+LtQJsV/iil0CGqhcX0aNlhuK
 hHApInRZyY4eFccPNco81BQVBukZI8S6GV3vZzkHw0AIZFJR23ZDIg7tm3DKhcPjEQyciBJRSCg
 nIcIJRAXIQUZ77O/2cJOnj9BpgJL0y6SBM0R88NUCSvJQGnzEydXRLpcfr3HdXMbSTV1/CV7QaR
 Xm9Sw4oqpPKHK6f/3z+tUGde8BIuGcUapY6i3YxRkFflpSUtSf9nSyvN6L3mn3C5Lw4jCt2GqHD
 6NpNGUZKALllA68S1IkJ/tgbJsWQDUfxOuh8e/XUFKnlkdSpzYFjGxhEzWOgMav38IpW70mmEpg
 R
X-Received: by 2002:a17:90b:2dca:b0:38e:6dd:a9ad with SMTP id
 98e67ed59e1d1-38fbc0baf26mr9437564a91.0.1785754037170; Mon, 03 Aug 2026
 03:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 3 Aug 2026 14:47:05 +0400
X-Gm-Features: AUfX_mw1pA5Lt4SUK-LDXfAMRoNKat9xJd2WogPHKjRGxb3J0_WbBHuTqMbA2yc
Message-ID: <CAJ+F1C+w5n9V_cc0v=dK-4OG+ZS4GB3km6vOiY5kir4iPCNSgw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/vga: fix panning_buf OOB after text/graphics
 switch
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warisjeet Singh <sinxx198@gmail.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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

On Tue, Jul 28, 2026 at 7:16=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The fields last_width and last_height serve two purposes: the text
> renderer counts in characters, the graphics renderer in pixels.
> panning_buf reallocation is guarded by geometry-change check, so the
> unit mismatch can trick it into thinking nothing changed when the
> resolution actually grew.
>
> A guest can trigger this by switching graphics -> text -> graphics:
>
>   1. Enter graphics mode with a small width (CR01=3D0x00, 8 pixels).
>      The predicate fires and panning_buf is allocated for that width.
>
>   2. Switch to text mode with a large width (CR01=3D0xFF, 256 chars).
>      The text renderer stores 256 into last_width. The text path
>      never touches panning_buf.
>
>   3. Switch back to graphics with a width that happens to equal 256
>      in pixels (CR01=3D0x1F, 32*8 =3D 256). The predicate sees
>      256 =3D=3D 256 and skips the realloc. With horizontal pel panning
>      enabled, vga_draw_line4() then writes a full 256-pixel scanline
>      into the buffer still sized for 8 pixels -- a 960-byte heap
>      overflow on every scanline, every refresh.
>
> Fix it by reallocating unconditionally panning_buf on
> vga_draw_graphic().
>
> Fixes: CVE-2026-17516
> Fixes: 973a724eb006 ("vga: implement horizontal pel panning in graphics m=
odes")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4085
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Warisjeet Singh <sinxx198@gmail.com>
> [ Marc- Andr=C3=A9 - drop realloc() resize condition & commit message ]
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  hw/display/vga.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index abe3f8e07758..da0c331486eb 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1647,11 +1647,12 @@ static void vga_draw_graphic(VGACommonState *s, i=
nt full_update)
>          s->last_line_offset =3D s->params.line_offset;
>          s->last_depth =3D depth;
>          s->last_byteswap =3D byteswap;
> -        /* 16 extra pixels are needed for double-width planar modes.  */
> -        s->panning_buf =3D g_realloc(s->panning_buf,
> -                                   (disp_width + 16) * sizeof(uint32_t))=
;
>          full_update =3D 1;
>      }
> +
> +    /* 16 extra pixels are needed for double-width planar modes. */
> +    s->panning_buf =3D g_realloc(s->panning_buf,
> +                               (disp_width + 16) * sizeof(uint32_t));
>      if (surface_data(surface) !=3D s->vram_ptr + (s->params.start_addr *=
 4)
>          && !surface_is_allocated(surface)) {
>          /* base address changed (page flip) -> shared display surfaces
> --
> 2.55.0
>
>

