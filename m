Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2229C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk6RA-0003Nc-9V; Wed, 15 Jul 2026 16:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wk6R7-0003KK-0x
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:42:33 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wk6R5-0005LH-7e
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:42:32 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso3777223a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 13:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784148149; cv=none;
 d=google.com; s=arc-20260327;
 b=apl6kb2QI8VSuASIkimwYbrCeiDSDb3O82Hac0UriR44We75Gnv4j7TY+UE+Akf1gl
 EEcItJI+utmb1hUavrQNyJSLNq1/vtGF/U8I4vpear1UwWkSuwsE8/fhQXBkImLkQx81
 p29lRE4BsLf/4zfZNBXbN+f7/6RcooQukmjROng+MfxqZOzmkL1qRR/zOFs7jn+Jt50O
 Wtz7f6EpDsVWogXiirbbOfI+W7MOJR9TaBN38i45boBrCe4w8pn9ZfKEHOUJtz8e1LSK
 xgIFYWNMEFqZIiohaHYbbuptOwAu9qE+i34lF5fl0X2tN3eGLFZpB5zcVpf5SwjZrwyV
 l8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ud/Zaqf/QlFSY2bKrii4iZixGotFcps82VP9iIe/rnI=;
 fh=VzS71yghJsggmz4I5fuH2VJ3VNNH4DW4ZfhUqemcHTg=;
 b=aKa2zatDeoOXJ0EW4JV8K4utgo8tb+nVz62glwgC+66xVKJnunLW3bVHnaZIxs27yC
 og80BCVb+PgXE9XKEd+2Cko61qwSsWSvgOEVPgFQa8mvcxHi0Kg1Kb/jGH8hE8uWi0/X
 amrNU88gJLDtVc5xSLPm0Y4//P4xAZr/j/WyueqbuZcGYRgsXTuk9nO/9scX/FuR1JGn
 IF8lrQBsYeUB9pJafOzC8jjO9gE5UR3hT+Z+TrHrIEs0eHiud8jl2rO6se6VThmGcdGp
 9Rblv00p8OpmpYre6G/cHcv9baPvvZjQneOxO5ii3LsJ1NdPfbdyNiNNIgXjKjgmS1GI
 YdVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784148149; x=1784752949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ud/Zaqf/QlFSY2bKrii4iZixGotFcps82VP9iIe/rnI=;
 b=kX73h5v7anPiAhQ6uBFG5kXxzjc7q+4ISY/jLyeXqm29V+AdQSGbtcRUJskFQBpX/W
 ++yoC3YstniDszoAaBKn0W3KWhlJU/ZHK5aZYqg5HgErVCn4Zads3wodFg6A00mZJ4p6
 NJR0nKKLhRpa2T2eAM+QDkPRhQp3NRixjOH+0Yki3ysZaeYChjG7GP/asBrFA8XT3yGO
 hAkuX5xb1TQR+jrf5925wsQhzX6Dph6oKKC4rL4F8+hV8d+TV5Edccxtmt5UNLfO6taP
 gkeNUqZN5CZ7+qhBpsCGlrrFor/QcxtrgZgsU2hsyg5Y1sem1wLOLe08u75JRhAKyGY7
 HtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784148149; x=1784752949;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ud/Zaqf/QlFSY2bKrii4iZixGotFcps82VP9iIe/rnI=;
 b=KtJrlGvOqjLMNv5hKH5MFaSc68WPJ4LG+QPW5ZAyV4bmW4Lm22q40OEOkVh5BPLSxr
 SiKt0qd+65xXmuFYpbxKiimPxbXEbuOgFE1VBnLjnYzKlgUw95KegUFYJW2z10nL2lpR
 8QXEZUUVjWlC41k19J0XPq47kEiIkBLg8mqy19N/5R18E7sCWtqqIL6IOdikboaN/Hka
 ++Jy9/gv/237lIByO4U0OrIbwi1qIfzJOdbDoVLduJ+CI8aSasXSC82XCJrsBGcZVF2m
 Bb8ROF+cvHNDWQE9jBAFZQqrmo4NPETFBS0VQaIvS/Ow2qN+bk62ZsF1qtz1S5/Jhn5E
 MgVA==
X-Gm-Message-State: AOJu0Yy7unSTK8R58ZUj48sb99SLI6XviRo7WUd+sPv+cSY2ov7XFZr3
 FTjmTxkiR0hPWxZsqqb9gK35rSDHMEOg3Ne1w/cIVnzgOPb1uWtKrFd1XgGp0/EBLgJhTBFWqkW
 5WF6U2SwEGOtxFHH3dJYfiyThPEWENeBYHt0Ba/02Rg==
X-Gm-Gg: AfdE7cm5rWGMfjX97uFGxD3zQ7nGjbQfb1282dBRg/kTlkIvlvhkgchhlx4ubMHWx85
 sb8TPoOKqZ5lx1hcpYL2SVIgAuocs/M92skDiujXjAhP1Z+RKWN6wiXti9rF+HoGTm/etoqhrns
 EaGNMUOOYukqdJl5S6Ndg7S+zcEU4oWM264UGUiGsjPeEBM/szZn7AGU9k9BP3vFKDRqRVasbPF
 01HdUvB3EDR20PoTDS0NMT2R3qTkM4PS0pn04KzS7hNv2AFqO/EiUCCy45rAyQtTwRgS7keOJ2F
 yIuciUF6pU1hcj68tGW2cK21cyw0FmDFoHc1QMo=
X-Received: by 2002:a05:6a20:eeca:20b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3c3704d5f20mr2694793637.12.1784148149058; Wed, 15 Jul 2026
 13:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Jul 2026 00:42:16 +0400
X-Gm-Features: AUfX_mxz3F20VLXSGeNfCRadrdaqKLJ4hpKadST1uJgGbLPEk5mb4EV6HuRLAFk
Message-ID: <CAJ+F1CJ3is7RHcmcH4mJe-dV8S=bKfyTWpfsGf4CdPLxTQ1KoQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: validate stride against width on
 scanout
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x530.google.com
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

On Thu, Jul 16, 2026 at 12:11=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Validate that the framebuffer stride is at least width * bytes_per_pixel
> in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout().
>
> A guest can set a very small stride while using a large width. The total
> size check (offset + stride * height <=3D blob_size) passes because
> stride * height is small, but pixman reads width * bytes_per_pixel per
> row, causing heap OOB reads. The leaked data is rendered to the host
> display.
>
> The check is added in virtio_gpu_do_set_scanout() to cover all paths:
> blob scanout, non-blob scanout and migration post_load. The additional
> early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
> configurations early.
>
> Fixes: CVE-2026-63109
> Fixes: 144bd171c837 ("virtio-gpu: Support blob scanout using dmabuf fd")

+

Reported-by: Tristan @TristanInSec

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3989
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 89a73793a42..1d4b8ee4192 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -647,6 +647,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>          return false;
>      }
>
> +    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: stride %u too small for width %u at %u bpp\n"=
,
> +                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +        *error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return false;
> +    }
> +
>      g->parent_obj.enable =3D 1;
>
>      if (res->blob) {
> @@ -754,6 +762,14 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu=
_framebuffer *fb,
>      fb->width =3D ss->width;
>      fb->height =3D ss->height;
>      fb->stride =3D ss->strides[0];
> +
> +    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: stride %u too small for width %u at %u bpp\n"=
,
> +                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +        return false;
> +    }
> +
>      fb->offset =3D ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * f=
b->stride;
>
>      fbend =3D fb->offset;
> --
> 2.55.0
>
>

