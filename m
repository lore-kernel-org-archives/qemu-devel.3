Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBDDC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhULI-0007wT-SK; Tue, 05 Mar 2024 07:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rhULF-0007tK-FU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:56:21 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rhULC-0002uJ-UZ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:56:21 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42e8758fd52so40845951cf.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709643377; x=1710248177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7TS9nBP/KqF+Q6q/v+qlv2NgIROPSOybWMJjEjsQWE=;
 b=i/6g6hsrOHsKEZJ6k2pOTJi9kpWao8K2ycxtGPtsQ9k9OrdQ9gTqNGqEozN5p0r4eA
 dE6nVoEPF7qaqtCJrY1ipHUfiSmO6hPNlU7A3XaXIclnXrXOANmPosaiyMDXwAAVkKFz
 ELqz7lPFDy6XNLZfeQZhzcCaSYhXJg+duszygdCDlb1o0E40/HuHyngQF0C9htwZV6FN
 yGmjGPxsFDK1uDXDn1x1aiLKYCbM8LYGFEUM8sFD/jmEed6pCY3ToRiYk5Bzm4WW3D4I
 CmgwkMrDwrsU/edKv9tz68hs1EjJTsVSJ5q5t0yzaHTF4cGTJMX9EUVkNJuYEt06Pt8c
 qZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709643377; x=1710248177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7TS9nBP/KqF+Q6q/v+qlv2NgIROPSOybWMJjEjsQWE=;
 b=IYrl55+vqQ8cwRAheSuojj/mvUCH+auahYZKYqzWo3F1D0y3+YwoYC0v9wNGNyI0sJ
 /LYymyArTb3/eoLat/wXrlC12yNY04pfIbzpty1p8/33EmIytiZyWNh3sVoJzvPxS4hj
 atSz2ZJZBcQxbP9wZEfD/NyxSuVMyYEZlIuUcN7PjdDPcDX1OMyh2AVHovCTkWG0QlNO
 F9dOllFzZrKrsPa3PGjj5WfwrDnsvYNwrnI6bK5XqzxAekZmXPLnQQjJHhd7LZGVLoEP
 4OBk/XrfxeiT0FZQi7AYYssQvWSyYNcbCou8pMp7piI/KWd6qsMXWRyKCZs/NvhI5fVU
 4m8g==
X-Gm-Message-State: AOJu0Yw+ccRsD8EoOkT75P1c44kVfubTt8gjAEOEhmsV+iYkhROD7mAX
 MJcw5Sze+AhpqNZaHzqGF/DjaotrR34Eegiiu0J5KHmNRAYlwKPAMgTQRpDVP/94665hLOHslRm
 bLKBBejqzKH9CcbVjbAanlK2uLx5PZwz0
X-Google-Smtp-Source: AGHT+IHY5fCduZpICYXroDqmo+sOab/MYRjpdfHmg6YRb+lxlUFWkxCiGMS8MqA9ccK6rl+VPGAwhPawIHN32Z7bJy0=
X-Received: by 2002:a05:622a:1394:b0:42e:ecae:16e with SMTP id
 o20-20020a05622a139400b0042eecae016emr1891439qtk.68.1709643376833; Tue, 05
 Mar 2024 04:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
 <20231213202419.15459-3-dongwon.kim@intel.com>
In-Reply-To: <20231213202419.15459-3-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 5 Mar 2024 16:56:05 +0400
Message-ID: <CAJ+F1CJjRZORH-LbA5dhY_0OZo0AHMbkJ3WkY=SA1ot9=-t0cg@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-gpu: first surface update with blob scanout
 after resumed
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Dongwon Kim

On Thu, Dec 14, 2023 at 8:26=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com>=
 wrote:
>
> The guest surface needs to be updated with a blob scanout after resumed
> from saved vm state if blob is enabled.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Can you resend the last version of the series?

thanks

> ---
>  hw/display/virtio-gpu.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index b016d3bac8..34dc0ab9fc 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1417,19 +1417,27 @@ static int virtio_gpu_post_load(void *opaque, int=
 version_id)
>          if (!res) {
>              return -EINVAL;
>          }
> -        scanout->ds =3D qemu_create_displaysurface_pixman(res->image);
> -        if (!scanout->ds) {
> -            return -EINVAL;
> -        }
> +
> +        if (res->blob_size) {
> +            assert(g->dmabuf.primary[i] !=3D NULL);
> +            g->dmabuf.primary[i]->buf.fd =3D res->dmabuf_fd;
> +            dpy_gl_scanout_dmabuf(scanout->con, &g->dmabuf.primary[i]->b=
uf);
> +        } else {
> +            scanout->ds =3D qemu_create_displaysurface_pixman(res->image=
);
> +            if (!scanout->ds) {
> +                return -EINVAL;
> +            }
>  #ifdef WIN32
> -        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0=
);
> +            qemu_displaysurface_win32_set_handle(scanout->ds, res->handl=
e, 0);
>  #endif
> +            dpy_gfx_replace_surface(scanout->con, scanout->ds);
> +            dpy_gfx_update_full(scanout->con);
> +        }
>
> -        dpy_gfx_replace_surface(scanout->con, scanout->ds);
> -        dpy_gfx_update_full(scanout->con);
>          if (scanout->cursor.resource_id) {
>              update_cursor(g, &scanout->cursor);
>          }
> +
>          res->scanout_bitmask |=3D (1 << i);
>      }
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

