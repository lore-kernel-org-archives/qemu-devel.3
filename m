Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A1C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbmA-0003cH-2X; Sat, 25 Jul 2026 08:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnbm8-0003c4-BM
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:46:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnbm6-0004Vq-R9
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:46:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8484f229529so881573b3a.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 05:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784983600; cv=none;
 d=google.com; s=arc-20260327;
 b=PPRogysHyEpEactJvBl4nbWGORa6tC1bDKvyTEsONL0kMy0r9eoxk8Q8V2Lxjn+tdb
 S4HqRrH0t8WrI0W2KhKpmPNYJxR96+B132iPfzYPS7w2wsfQaSRzur//ALgX2jcg/dIs
 wKF22fYcHoWIMeo6Iv7l4ilaaY/t+7i0jBFlmAKbSinDOiq5dNUYbfRDO7j+Q1KeSY8H
 jNUh2+zcxkAt/vJwGER4AnYhkXe3Ua56ExsJ1MDpK+6KIzr4E+fvv2val/FjcVLLfeSA
 9UW3MjsqTQSCBMvK6JcRKBTZvE9KXIFFahK4sTJFsC5LomVSMNyhZdfWUFahaMM+kmQP
 loyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GXAsE2WgbUInUYGMCJmNzd3G5fAlQOdHBC7dKuoCEoc=;
 fh=fWOTDz5YDRO8gq4Ddplx48s4Kmwze/7hZKKkVfzrGlw=;
 b=lQBbw7ods5H5odsBMnrAb2rEBbmZuH5bjhthd7KHq7KGK/6OqPvxZxDl83/QmrsG4C
 GkRh8OmLuLR0sTMTs5cH7ArnSYEKyNHjjuiwIe5Ubxh1auS24hpuqSYWuiEu+TF9SU5h
 SHtgijBdEuDbBhtuaRw8AEuezaHxp/JLtV1lJRIMx0XYMacQZ5Na4fzo++xwDVgsfKB4
 RbeL/D3Xi6Y7m9rA4Hplb3BrQ5okz61rKbIrNfp2j1f/prCdaHUtieE2kv9pFMDR9cuW
 raK2zZOeil0f9Gng/c7YhkWCWQPQHebweSfksut1LD8idu86BzY5URv6l4wpymz2Zkyw
 o9Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784983600; x=1785588400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GXAsE2WgbUInUYGMCJmNzd3G5fAlQOdHBC7dKuoCEoc=;
 b=mDVgg2u0jd2QgjwhvennPM3xZTbZZ/6GxRIzyn+O7/fen7OIS/ub4Uznd71hcQkfv2
 volf0i5ERcXnZdeiPVwDu1ztXAJvDiBZ+v/gYWVFYw68ojMXULN61nCokdduG5888eac
 YLWeijyNtmnM3gYPxQhnVqRXa3hGbyGUaIgwOD8S8bXXuolCEqXOiXicnhRWgA3F5zbX
 WQrFAlbVigfiqGTWfdYsHIJjGGpvRFczO7nAC0ZC6cRpRoSS/m8474xH7XdCuOiEW0gt
 2wcflEa4+zJt0VXbX0c0M+X7VPN3BaqGO7q/Se5JgD+bLgggGxkhL+kLj53VRRIRGAfs
 r3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784983600; x=1785588400;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GXAsE2WgbUInUYGMCJmNzd3G5fAlQOdHBC7dKuoCEoc=;
 b=spqfPkHOVoREi+q3y3KCfA5na0eAydErPBz62/h+ATRIurl/NUE5Y7XXxwukHSCBUU
 poH6h2YOE4syd/G6CJPyxcL6GotdXbPk97SpXArkOvN34ov4TMO3/6aiPOfdE6/wTzrK
 y2z1j4Zq96OEbRViAmxeNvWC2gTAT0omVrVNCaQ5vIIqyTfjO4SDqATG70oBS0xtX38A
 jcnYOosplIaYg/wsOH3efvtXRz5jVajZOofzCFBCPRyX6XeLPh1wC13svhnmIImdcewZ
 Z+f+xR3JIYXj7MRimMPvM1NqtCKA9lfgsO3bzzwWJlaGjQgwXWxu6u3G1J0Br+B9EfrQ
 xr2g==
X-Gm-Message-State: AOJu0Yz2Lexnh+lnKLAnLvx9/cThHSjczO8tohMyGQRLO7GVDHe9PGbY
 6FvB1FMbRwTAAaEly0lcAm+4AV/65coEDU4a0BUI3bNOoQR9feWRS41oaltI738PZfXP5RNTgoP
 MOEnyT/SlYC9SuHQRyAPmm0tJMd0KJeY=
X-Gm-Gg: AR+sD12VvX++vuK/GaOlInsCFf6Qk5XtOxD7E/SL2OuGlm6ZUZrGrQhxnvd851zySvV
 Vib4iddujteFBd/sF0aNdHIRxy6dMuvWK4xtBmLmtff9FHxVJK/2v0rB4fZGPzeXYvS3W9QVY3Y
 UPf8uLpghbBDh7+h/Z63ewLXjA3tFTT+Od9z9RPE6+2TaUsPNu/uXhb6aOiMjMiRhipki/cDxE6
 zJcXYKy4DZUJQEdHxj4cPSrs9ClOEFQtFQe2WIiyWFctjuho4hfhyW6ipjvxXVs1qO7gUDAPp0w
 7R7wM/NLP88clURymA==
X-Received: by 2002:a05:6a20:a128:b0:3b3:d0f:7883 with SMTP id
 adf61e73a8af0-3c67d9b3dbcmr2186882637.7.1784983599733; Sat, 25 Jul 2026
 05:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 25 Jul 2026 16:46:27 +0400
X-Gm-Features: AUfX_mwbrSggvLkPaW2apa3IaTOlimkPsXy6rs_qzvK4U9SKwai5DUn0jLUZo5Q
Message-ID: <CAJ+F1CKQJoA9G9b0hB1RfAysik8xo+c8g042WXmHzxaRv5t4+A@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Fix empty blob discrimination
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Jul 25, 2026 at 11:13=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Discriminating blobs by checking whether blob_size is nonzero fails for
> empty blobs. Identify 2D resources by their non-NULL image instead.
>
> Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection"=
)
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 718ba3039290..6413df029b8e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -56,18 +56,18 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>          return;
>      }
>
> -    if (res->blob_size) {
> -        if (res->blob_size < (s->current_cursor->width *
> -                              s->current_cursor->height * 4)) {
> -            return;
> -        }
> -        data =3D res->blob;
> -    } else {
> +    if (res->image) {
>          if (pixman_image_get_width(res->image)  !=3D s->current_cursor->=
width ||
>              pixman_image_get_height(res->image) !=3D s->current_cursor->=
height) {
>              return;
>          }
>          data =3D pixman_image_get_data(res->image);
> +    } else {
> +        if (res->blob_size < (s->current_cursor->width *
> +                              s->current_cursor->height * 4)) {
> +            return;
> +        }
> +        data =3D res->blob;
>      }
>
>      pixels =3D s->current_cursor->width * s->current_cursor->height;
> @@ -1279,7 +1279,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaqu=
e, size_t size,
>      assert(QTAILQ_EMPTY(&g->cmdq));
>
>      QTAILQ_FOREACH(res, &g->reslist, next) {
> -        if (res->blob_size) {
> +        if (!res->image) {
>              continue;
>          }
>          qemu_put_be32(f, res->resource_id);
> @@ -1430,7 +1430,7 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *=
opaque, size_t size,
>      assert(QTAILQ_EMPTY(&g->cmdq));
>
>      QTAILQ_FOREACH(res, &g->reslist, next) {
> -        if (!res->blob_size) {
> +        if (res->image) {
>              continue;
>          }
>          assert(!res->image);
>
> ---
> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> change-id: 20260725-image-6c8566fb1253
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

