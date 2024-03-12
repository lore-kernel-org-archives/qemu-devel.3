Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8972C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0PW-0005YR-Kv; Tue, 12 Mar 2024 07:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rk0PT-0005Tr-4C
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:35:07 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rk0PR-0002Wk-6Y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:35:06 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42f59ca9a7dso2016621cf.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710243304; x=1710848104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBiiiSNgOpxz2KeHaJd8ZE6W2tm8N+ksGJtLDHwd9Cg=;
 b=GUpMcQdhLPP85b1rX2Ua3mIJ7b9We0dbPXFHwUlR7aisPuwcM3fJNkm3Q9M62LanYl
 v9MH6bRXIKl9Djw0/Ro7P19S621QUvcPm7OPcuSIJUkbBEMeSZcjYIpjtXqzxQ8osrX4
 zewnf7+ol3rS8fP4pRFf3FGCyeSfJ2aLNuXMGTBttPdoSlrSO8E9gCn3tnglsFVanQsc
 FHv7zLYDAyCpX6Jn+uL+8ZAYdwIlrAkndynI+b6PaQhFn2mUWjm+c5vr3gewjJ22JU3Y
 itVE7DwtK5QaHwuqHgrDSmPjuW2ZWYSoPlz7fBHuJC/7SsSnraCmxiv8J71qZ9axJHWq
 IZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243304; x=1710848104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBiiiSNgOpxz2KeHaJd8ZE6W2tm8N+ksGJtLDHwd9Cg=;
 b=nJe6P41+faKaKAfzlM+7TKg/CajHo7jr4DnZoIObtKWYimfzo0LDZz53MiGtgOIfW4
 RVrgPQSN0xnuxopqIqoBdHBV7AUJVym+ImIuuxR2RjFY5zRKDczDuQrWlBv2zNKhXSMO
 KMTxrFrfpV49vHEuaPhaCbNRP14Zvk3tmZ4H1xYVZQw+w7F0lyPL7zc9BpikPVsZcniX
 /sSKVeUvF03MXzg016vmk7t5vrowLE+eU5KF6h7Sw62ecGrmonjQATlfeqbboCOQMw99
 g+gY6VJWmOApW5imJdx/LGH+pnq6aEBQC0HhS1M5BSb/gfJF9JO2x7YCuL49MG7uXtJP
 Tfqw==
X-Gm-Message-State: AOJu0YzDG9EY+dJbPf2jktWA8zi0eqfIBpl7CKD4hgqVn3gSMNysrFRb
 nBCS/YoOUTVsVbO+9MFLxSmZx4igYCXzlr/1yuBmkI14N5fdcowROV1ZCY9+iitgQwbIarabJxj
 EGws7W1pNT2bOf7KEMHJlTAnMPAQ=
X-Google-Smtp-Source: AGHT+IGlCxGKwU0bQCLFyfrSsgkOAhXJhBEVRj0oFkJU6s5uxM2QAvK8HuKaZwiEgmm5d8x10g+l6Kil3hoUcjxZbeg=
X-Received: by 2002:a05:622a:188c:b0:42e:72ba:d54b with SMTP id
 v12-20020a05622a188c00b0042e72bad54bmr13202109qtc.21.1710243303773; Tue, 12
 Mar 2024 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240306222535.3236855-1-dongwon.kim@intel.com>
In-Reply-To: <20240306222535.3236855-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Mar 2024 15:34:53 +0400
Message-ID: <CAJ+F1CJG3fMhon-GyRCsjtJtJ3m6OK7vtPDEix=Hwnxt=sKjjg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: first surface update with blob scanout
 after resumed
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

Hi

On Thu, Mar 7, 2024 at 2:27=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> The guest surface needs to be updated with a blob scanout after resumed
> from saved vm state if blob is enabled.
>
> v2: Rebased
>

This patch conflicts with the already reviewed (and almost in queue)
patch from https://patchew.org/QEMU/20240228122323.962826-1-marcandre.lurea=
u@redhat.com/20240228122323.962826-3-marcandre.lureau@redhat.com/.

There are chances that it solves your problem, since it calls into
virtio_gpu_do_set_scanout() which handles blob resources.

Could you check? And if it doesn't fix it, can you apply your solution
on top of it?

thanks

> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  hw/display/virtio-gpu.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 1c1ee230b3..01bc4f9565 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1422,16 +1422,23 @@ static int virtio_gpu_post_load(void *opaque, int=
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
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

