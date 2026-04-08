Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BA210F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVq-0004sI-Ud; Wed, 08 Apr 2026 15:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wAY5X-0006qq-8E
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wAY5V-0002rB-A6
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775674634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STqray6qmWsFx97R5S9epAo+2Fo0qs+i07qxUyJhsl4=;
 b=Z15SMdJfo5Jaw0klLr8mwPWPbjpZ+ENXj106Eo3CmAuLnh8O9GtJIrxWgnKjdW6iKGFuqy
 gWKLnit+8rsTrzRF2D9nuD+36k2ivX4aBPwKCZiHET7flWdNlNly4ofjEDP0+mYAOq7uwv
 drQdBoaLKIRNBUZJcReavaV/dkXcWB0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-iIAdiWLAN6O_gEKrWvZuvg-1; Wed, 08 Apr 2026 14:57:11 -0400
X-MC-Unique: iIAdiWLAN6O_gEKrWvZuvg-1
X-Mimecast-MFC-AGG-ID: iIAdiWLAN6O_gEKrWvZuvg_1775674630
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9467e85aso161010a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775674630; cv=none;
 d=google.com; s=arc-20240605;
 b=QJoglMi9/4KefqWfTV+5vF0D0n4C03wCDaRwV1CDGe/V7Qnvx6YqxIlAGkuCe9xP1x
 YhT8itk/oHayLDoR/nQHqR99wCpwGIIZ/kk5OhfYjdVGDHwrVXhliWkQolEGvaVNZpzq
 WuWViW+OLn4XifqdJwjGZUcDX9gZ/wrx243gww0/HyUfctUOwrdq4utKxwKfcVQGjpY2
 2PFmWD1ZQLWvsp9Qr1hfgvmYxZPPsnQdlXuoo2lg7HsIZWpw24+d2QooGe3o8p2/1vld
 KSVNp4u/I5KuiSRVGmBG9hGAF4VH1G8a/4p9vTr48Jx6MeMnQaD6CN7hFZzhRyl6i+jk
 ww7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=STqray6qmWsFx97R5S9epAo+2Fo0qs+i07qxUyJhsl4=;
 fh=luLSmtlXKCOv5SwkeC/BxKiqDDjS9e8bilKSx6CLRyk=;
 b=Rq3kDMazc4ReiTcqKyh4TWElXqrm2XUb92Fbb86u9hS6W5hZ7reKTsnjaE1RIGNiAx
 GDBECUJG0iaXMRDL3YbuaTj4DZ4SCD7W71jC9LuXs4A5ZTNVJIeV8IItaV92GI3HHLDh
 CeVBCP6/e0PeSU8Ux6BaMZiDTsOnL+JlEc+cvJqv6TPRjucTjAlgMRYYaj0hsYx5CN88
 dw4/X6ExhpCEvqjVwycYUxRL6r9ImvYzVKzfXJlS6bOFhYsO9nCiVRY6rOy63g09IaDM
 J55I2ulEi6EWvgufVSCE9SKkKrZlBw7vnADI6FORlFvhAWVlH8TM7AUwEpcGVXhnVlap
 9YrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775674630; x=1776279430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STqray6qmWsFx97R5S9epAo+2Fo0qs+i07qxUyJhsl4=;
 b=adFTYp73FMlNuwZAI6dyi3jDrZOmGBgKoETL98fpcukcfi+5brpEHqEqMAIZ3lA8t8
 oidcwyS7ute10DnSS6UB2OroAOboFvpAVjeOBjlz+u3q0iYlgk5nicIOfF5vZjtWJLjZ
 jCHBMFjX15OPzE8Esk5IpSPcWYNRAAWm+gohJ6bJT6EnswFpI+BVMe6+KAlqViE6WjR/
 3N5kqKhRStoHM31BjGlwmDMAlgf7IAnfgHBB7uI8Qhgj8itYGNy9UvujUaueWkm5oAxS
 RSC8MIMaHhu/dEWf4HlAhlSlrZyeuHtxyCzveIRiJL7UqKgWdE5XXognqpF/WF1nUY8Y
 Tj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775674630; x=1776279430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=STqray6qmWsFx97R5S9epAo+2Fo0qs+i07qxUyJhsl4=;
 b=j05G9YRq7y/p0BW+hZOvklsYbK3VBd8ulItGgPHw39MLumryEK/7cdlTl0fIPSFtwR
 Zk4OFXvBMo8tQvJEZDX8gYpvNn325VbRHJGgMIAMcKbH0FvbCdNgq+R+MomFkT+kIrXk
 22nVJf+ACsvv9wIkGkM05FlXn8iMOr31iavooImMaO1Fo2bvoUAxv2rEAyjNd6XOtiWD
 OSurBHpHdHRlqLoLmEI0ohs4Hc5Bqrj2yInXrZ9LcjXY46rceTd7GfLRYvxroBXH0+Xq
 IKGMCM9+55HdOMB4YJWXYPW4SIfLofKZj/q0ZEwc1si4eA7yUKccGaYTXA2d1949M1e0
 CCjw==
X-Gm-Message-State: AOJu0Yx+glP8+Xi+ouO9qaT5af844Rb9uzGmhKVJvplfhwakL6yAs0Qr
 908tC8oe5EM28TETMuaGfG8mCIS3hHJnJba2RL+VCm+AUB5RtQ/vArPlEh/mh+7S2wa1eq9mrOb
 JTIot/hHG3y+Y/F4ZNcBYIlIACUAmuYDp3YhrotG70dcaERnf6s2OFm00kCBMj9e6jPTHroIcWC
 3AlCFdkThoMkWEMqz6TiDCrjAvtEPZGcE=
X-Gm-Gg: AeBDietA/XFBefcD5W516Q8u951xqLf+LFM4Rnt3taQacHFc+jIWy8JH8HEnytNvhKj
 99WP9wAZyD+fLv3IJbVERtFSGopCMyBA5l+gWz32aWT5M8qZAtYiyNRnfnM1U6J4G5TdmGYHOzk
 ZgTwaR2RdcFurKekt5eIoxNjuNl+VFLItu8bsS/78WLCpnY8/zsIwI1TP/3jTDGCEas1E08+lH9
 TBVWympga4k8cC4cGbW1PIheGRX3BpYT1Q+4yZ9v1iP451K+Z0CNdQhMyfr/woXMAx6QG6+RYJh
 oXaGP+WQGYyDMJYvJegqkl4=
X-Received: by 2002:a17:90b:3b8a:b0:35d:8e4d:23a8 with SMTP id
 98e67ed59e1d1-35de68f8b42mr20371995a91.15.1775674630022; 
 Wed, 08 Apr 2026 11:57:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8a:b0:35d:8e4d:23a8 with SMTP id
 98e67ed59e1d1-35de68f8b42mr20371975a91.15.1775674629493; Wed, 08 Apr 2026
 11:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260408012853.2A9F15969F6@zero.eik.bme.hu>
In-Reply-To: <20260408012853.2A9F15969F6@zero.eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Apr 2026 22:56:56 +0400
X-Gm-Features: AQROBzAV6pFQyVJnNqNhsPsgW-8VULJaVqnwrKIgBhwt1VZG5U3yuuqHvW78jt8
Message-ID: <CAMxuvazXgMBeLn-sZYB+b9f0cqHCYPh6yeMDa2y_87HoTs44dw@mail.gmail.com>
Subject: Re: [PATCH] ati-vga: Fix check for overflowing vram
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 8, 2026 at 5:29=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> Take into account the bytes per pixels when checking for accessing
> beyond end of vram area.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/ati_2d.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index f0f77cecc6..2450bb5e74 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -146,6 +146,7 @@ static uint32_t make_filler(int bpp, uint32_t color)
>  static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
>  {
>      QemuRect vis_src, vis_dst;
> +    unsigned int x, y, i, j, bypp =3D ctx->bpp / 8;
>
>      if (!ctx->bpp) {
>          qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> @@ -156,7 +157,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_=
pixman)
>          return false;
>      }
>      if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
> -        ctx->dst_bits >=3D ctx->vram_end || ctx->dst_bits + ctx->dst.x +
> +        ctx->dst_bits >=3D ctx->vram_end || ctx->dst_bits + ctx->dst.x *=
 bypp +
>          (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >=3D ctx->vram_=
end) {
>          qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>          return false;
> @@ -194,7 +195,7 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_=
pixman)
>          }
>          if (!ctx->host_data_active &&
>              (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
> -            ctx->src_bits >=3D ctx->vram_end || ctx->src_bits + vis_src.=
x +
> +            ctx->src_bits >=3D ctx->vram_end || ctx->src_bits + vis_src.=
x * bypp +
>              (vis_src.y + vis_dst.height) * ctx->src_stride >=3D ctx->vra=
m_end)) {
>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
>              return false;
> @@ -240,7 +241,6 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_=
pixman)
>              fallback =3D true;
>          }
>          if (fallback) {
> -            unsigned int y, i, j, bypp =3D ctx->bpp / 8;
>              for (y =3D 0; y < vis_dst.height; y++) {
>                  i =3D vis_dst.x * bypp;
>                  j =3D vis_src.x * bypp;
> @@ -299,7 +299,6 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_=
pixman)
>  #endif
>          {
>              /* fallback when pixman failed or we don't want to call it *=
/
> -            unsigned int x, y, i, bypp =3D ctx->bpp / 8;
>              for (y =3D 0; y < vis_dst.height; y++) {
>                  i =3D vis_dst.x * bypp + (vis_dst.y + y) * ctx->dst_stri=
de;
>                  for (x =3D 0; x < vis_dst.width; x++, i +=3D bypp) {
> --
> 2.41.3
>


