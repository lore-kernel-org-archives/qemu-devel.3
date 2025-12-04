Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A81CD1F9B4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR71g-0006hr-2Q; Thu, 04 Dec 2025 05:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vR71e-0006hS-IK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:57:30 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vR71d-0004Jn-5Q
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:57:30 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4edf1be4434so4852811cf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764845848; x=1765450648; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlnJL4mYoiccPVr/o4GtEVHBTKrNKtnlyy3mxKjrrvU=;
 b=Ig8eesccVayIcSd7ZefbK9Q+7rO3F1bZYiieulCp6xvL6ec8GLT61/8Aqlv7XZhLQh
 M0/K1yWiYeElaJj8LXWfTrllGcoo5qCHNekjrc2YlFddd5zl12yTIpXTC8/eTw9mhjgL
 oAUOA/5ekWmoqJaTJomNi2cC5T7du/mnLofYNiIiI3qVSa1F7zRV7ILPLZ4JX0Pjxpt8
 qFnB5yaGokBfQXDkBq98v4v3XGJIsaGRZTV/hHdhyiBTeGXaWGs1/pZARdtdDccz/UNq
 PURZQ/rNCtSpLK5H0FA0/WZh9rVsG3nPTGlot/dBeJ8IRpIB8KFYOFNEzvZ9Wz2crGIv
 czFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764845848; x=1765450648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QlnJL4mYoiccPVr/o4GtEVHBTKrNKtnlyy3mxKjrrvU=;
 b=NHipoC4OI9Wori7Tl3DIR3XYv8cuwvYhn5MKzWmI+AM6YFQ669cpHr4eX9WfdAGlXK
 DEEaCHJUb+AQCpJZ5yOdwLzHovtdxWVbfPZsRh9SOu1h4jBOdBte3jlBe9NN+HRzxLvl
 LSuoZChcS9WnHCNzPFb7N8+sa/WdlG3fjX0n3CSDQTSDKtYD2SDgLDmFgS8GeN2iJro3
 BWTU17VjhNvB+194zvriPKk7Upb3qF7AXrq5nhGunmiPrOT8Vo7e1QbDdMv3r3IcZEM6
 Hr/g+LL8h27gIpNEns/h7D/l8eNKpqw3c88BzMP3kuNncm+yiBjCxTCnV3X/OXFu+1mf
 NLIw==
X-Gm-Message-State: AOJu0YwvB+OlXhl5i7rK49UtOC6YRDXRyw+vyqKwew19HkjPXM+vxBse
 DOHnRlcIKIR56YqtDpws+kccsQJpk4NwHXawT0oJ12Gb+hzRS/frDQDD6/qQ3Kn8MauoDCtp2OB
 A5LdYknRgloPy9z/3z6PVjCdtCv3Uldg=
X-Gm-Gg: ASbGnctZgsWKi/L8WEbPokHPSClRdTIWjb5EEKpLyECOdn51FByeaF3ool0F515GwVu
 54Tcp94xB4m0131qSIJ+fY+rM4LPZNILjr1ZLqIRV+Rd772yPx2jhu57cN0Bt8GZzKMFTgLiTEP
 DJ6+oY1nY6lKod98VKn06/v+q8gz4Aa0hTBoYlWdY6kB0pqLxsAuPewTPNBg8C/apXjzQCoAS0U
 B6KvjgvNrszCAV97/un/b4F5DADptmcWDRbsy7kFM6sGVmFSfsJkWkbbiGlE/kD75YlR87qP3za
 hw==
X-Google-Smtp-Source: AGHT+IHWOIcJYTbZ6u0z6YVwOLbXIA19xyFs6kMndVv1+Gl01hNDEfVAzhrR0Ub311PJ+agd4NUvA4dEbDq/CEq63ac=
X-Received: by 2002:a05:622a:19a1:b0:4f0:131f:66fe with SMTP id
 d75a77b69052e-4f023ae1718mr33221301cf.59.1764845848182; Thu, 04 Dec 2025
 02:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-5-j@getutm.app>
In-Reply-To: <20251203040754.94487-5-j@getutm.app>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Dec 2025 14:57:17 +0400
X-Gm-Features: AWmQ_bmSH12G8CSc5Kl2iA8RYr5nqWQqYzYlfBQq2Gj8WqNC7gTOkQdS5F8Glas
Message-ID: <CAJ+F1C+Z1LdF06RoT6toEFvp0PXvT9OmY85MY7DXeVVjEV1Hpg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] virtio-gpu-virgl: update virglrenderer defines
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

On Wed, Dec 3, 2025 at 8:10=E2=80=AFAM Joelle van Dyne <j@getutm.app> wrote=
:
>
> In order to support additional native texture types, we need to update th=
e
> defines in virglrenderer. The changes are backwards compatible and so
> builds should work with either the new version or the old version.
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Please add a link to the pending MR.

> ---
>  hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index d0e6ad4b17..36c670f988 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -24,6 +24,8 @@
>
>  #include <virglrenderer.h>
>
> +#define SUPPORTED_VIRGL_INFO_EXT_VERSION (1)
> +
>  struct virtio_gpu_virgl_resource {
>      struct virtio_gpu_simple_resource base;
>      MemoryRegion *mr;
> @@ -441,12 +443,30 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>          memset(&ext, 0, sizeof(ext));
>          ret =3D virgl_renderer_resource_get_info_ext(ss.resource_id, &ex=
t);
>          info =3D ext.base;
> +        /* fallback to older version */
>          native =3D (ScanoutTextureNative){
>              .type =3D ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
>                                      SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
>              .u.d3d_tex2d =3D ext.d3d_tex2d,
>          };
> -#else
> +#if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >=3D SUPPORTED_VIRGL_INFO_E=
XT_VERSION
> +        if (ext.version >=3D VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
> +            switch (ext.native_type) {
> +            case VIRGL_NATIVE_HANDLE_NONE:
> +            case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
> +                /* already handled above */
> +                break;
> +            }
> +            default: {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                            "%s: unsupported native texture type %d\n",
> +                            __func__, ext.native_type);
> +                break;
> +            }
> +            }
> +        }
> +#endif
> +#else /* VIRGL_VERSION_MAJOR < 1 */
>          memset(&info, 0, sizeof(info));
>          ret =3D virgl_renderer_resource_get_info(ss.resource_id, &info);
>  #endif
> @@ -1169,11 +1189,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>          virtio_gpu_3d_cbs.get_egl_display =3D virgl_get_egl_display;
>      }
>  #endif
> -#ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
>      if (qemu_egl_angle_native_device) {
> +#if defined(VIRGL_RENDERER_NATIVE_SHARE_TEXTURE)
> +        flags |=3D VIRGL_RENDERER_NATIVE_SHARE_TEXTURE;
> +#elif defined(VIRGL_RENDERER_D3D11_SHARE_TEXTURE) && defined(WIN32)
>          flags |=3D VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
> -    }
>  #endif
> +    }
>  #if VIRGL_VERSION_MAJOR >=3D 1
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>          flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

