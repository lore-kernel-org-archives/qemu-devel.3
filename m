Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F12C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 08:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhmrg-0003aU-DE; Wed, 06 Mar 2024 03:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rhmre-0003W2-00
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:43:02 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rhmra-000339-9E
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 03:43:01 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-787990149edso357588885a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 00:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709714577; x=1710319377; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWJXEnfLu7aJeG3d6E+CNystN42syJyzv2NPa5pf3fE=;
 b=eE2WasX/48aV/FPZMwLZckBZ/zDVNgrKs+JidUOVFS4/DiqPSSxpjgbcGeoLT/JyAU
 iLFbdpZMjzthv2iQy/fmYfCCMyhW+QZ1peGwgdgB8RfOzKkHwXZKiNe3hsQn0skuWC6e
 m+IP6T+/9hoBW22AB7109IoahAqEoiwkzxhZV9gRTc6cCF66XxIVEIJYr5VfliKI/qpu
 EV5ELIlJMR1FINOpFT1vBcHZPA8+4ifjLhF10cDV5FXb8LOe0x+V4vN2T7YdZTwq5Hfc
 pFl3q/HNbRuu0bUbg2MaTLGyMA71D2XQBWN+mIrCxluR4vdGwKgomhBBnxqXKxfWxLUz
 GFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709714577; x=1710319377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWJXEnfLu7aJeG3d6E+CNystN42syJyzv2NPa5pf3fE=;
 b=hRF+HACUsTC1CFzhsvjsZa5afHlMDlUTzjcWZG3b/jIzmCDwCXRce72HIsVqLmEW2R
 RZiBP3Tf8oXD/1OnBc83hf8ClnmnG3xZrzqKdsTcpTOXX4FYkp2Jo2tiDAxI/2bsTRfw
 jqecM/Sjg1XNeV67el5fkZCWJx4US/XmaphBIyqot12iphhH5SFr0mwQSbb3K/XVAMtT
 syIFG8gOYRIUbOPEphGNp0EV08rUHCEC7DjoTisnNn3TvOjW6aT+yGxHFw1E8Xx6smjc
 m8viApw03MhgpMWdVXaflpe914RgfgFu7T2RPbPmo1s88IXGB2DsGt2uO3G6IHcLl6Kr
 TH+Q==
X-Gm-Message-State: AOJu0YyCFz0HiJMcEvw539CpSuASorbBGispsF5/FEQbqqteoM8tODOE
 tWykxDhKTTkJL8VSlDTskWowhyZk+VX0hdE58jLG5dlI8ja130ysaKMv4w5ob0AQ9ZmKJJfdHX4
 cHuI2BguyOSLzf9iykBjlJ0oHxxE=
X-Google-Smtp-Source: AGHT+IGHh11Am6q3u7+C8lhEP8AZmoA/HZuC5NnjRWjGeDm444Rsn5xtozavJvKMRPZqKGgtatdE7Kl/3ZK+J5vyIfM=
X-Received: by 2002:a05:622a:1792:b0:42e:e949:7a40 with SMTP id
 s18-20020a05622a179200b0042ee9497a40mr5212197qtk.52.1709714576873; Wed, 06
 Mar 2024 00:42:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CJjRZORH-LbA5dhY_0OZo0AHMbkJ3WkY=SA1ot9=-t0cg@mail.gmail.com>
 <20240305222252.3232608-1-dongwon.kim@intel.com>
 <20240305222252.3232608-2-dongwon.kim@intel.com>
In-Reply-To: <20240305222252.3232608-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Mar 2024 12:42:45 +0400
Message-ID: <CAJ+F1C+1bS5OOL31dm+4Ms5zpJetrOpQX-qoc5ihb9yjCS3ddQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-gpu: first surface update with blob scanout
 after resumed
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x733.google.com
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

On Wed, Mar 6, 2024 at 2:24=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> The guest surface needs to be updated with a blob scanout after resumed
> from saved vm state if blob is enabled.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  hw/display/virtio-gpu.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>


The way you send patches to the ML confuses patchew, and they are not
properly triaged or tested.
(https://patchew.org/search?q=3Dproject%3AQEMU+from%3Adongwon.kim%40intel.c=
om)

Please send a series of your pending patches, with a new version. It's
confusing with the various mails otherwise. And it's then easier to
deal with regular patch series that are tracked by patchew.

thanks

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


--=20
Marc-Andr=C3=A9 Lureau

