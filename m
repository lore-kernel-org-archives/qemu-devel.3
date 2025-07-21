Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986A9C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlVO-0004AE-4p; Mon, 21 Jul 2025 04:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1udlUz-0003z5-28
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:03:55 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1udlUv-0005Ow-Ku
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:03:48 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ab8403b6daso42495101cf.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753085024; x=1753689824; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dk6OOKLiA5OUnxVXWAWsfybFyBNrlN58iLU10otgwgY=;
 b=JHkUJoHpuUFFs1PMZ7vq1IpF1dO01cRxJPc0zNd5lP8nskQJ06QKemO/oc8hTK8Eq3
 DFJDj9uX5uWSZahdkRjeBsIVqm8lMlOG9CR16oeKNpYtD7YKaJ0ZEXTJFkLdO+EAecMT
 iH6dGmEWyE4GeNpJupwvs78Zyen8kqCoBLX9oQ+Otti0xYNyFt6Fh/xfEXbnusrBPg84
 8DZqSTewu4BgMBK3RozjsOp35Gf7gcAFqI78Lno1OLpfPxIpal+DwSw8V1y64MOuJGau
 8Wc2Hr9a0q4aUNnVMRKOyXb9k1FwM1sAT5ztAK9SMzYySMfN6L1cFXr3kjmdEuUYD85C
 oFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753085024; x=1753689824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dk6OOKLiA5OUnxVXWAWsfybFyBNrlN58iLU10otgwgY=;
 b=HjdoV2a5OkW6fBAshK2kKjNnS4I2WxSjk9Iu+iTYpkXv+0St41oFKdXoG6YspCK5dI
 DL7qD37gf+dPrHUsdh/XoXOOv20oNX7Bkoc2ffikPCi7aq4Jab595L7CLxQO/yCqX6Th
 sgZQBD7cfI2/lnzTsbcUdq0OgNiJcoGNRV4Kzk6rvisfdLlNrV3ZlLTX1f7V6DFDL3De
 2xWG5gcJbZZmeVrapnPXaUKyU//Y7YHLRRlPlSw10zui6r98jk3KINyFYq/lszpUINcA
 SWXa2l0iFUTY3fHprjKkZ24aHqncLOZCJxb8rfAUGqejW33LZAjd82uNxbT1qz3pFYsW
 WXAQ==
X-Gm-Message-State: AOJu0YwgHcFA1ezha3z/1Q6YuQOu/7wqBU6WdiwB5IIg18ZP4NwPhmPo
 lrv5PSfOSQioliYg+oauYoTV/1Xtzs34pgLsGB4qFhf0UIPc3r6RUKXPmxP7n1bzPfKW0HDIojr
 0uVzOsy6IF2VIwp83ZFIBGS57lJH8+vU=
X-Gm-Gg: ASbGnctcRMMLJB8U+nhtHpAdrhVg/7W7p6h9iZ+NSQI64Vzfu7lxoG7W1zdAme126Hv
 NEW3gqKltcodxTqSy00h2lgfHpC+7rAb0SwHTKYB9v2Bh1QUICf48NWS5BgVmmLFRwXcAU6F6R3
 YigsxO3dLTD1AMhS+m8gxGGgU63UNjDZGiVZluPDZo+8nKGRvbeh02QDkfmASSBDpv9EjL5dN4L
 CWp3Nvn
X-Google-Smtp-Source: AGHT+IEnEwiysyAdGTm0Jsmse7YdzJ7QwqbtGTk2fMgg+zeopHd0IEAndEpS4/PvNl8Jse4js2BbMhTNIbVu3WajBc4=
X-Received: by 2002:a05:622a:1886:b0:4a9:c2e1:89c4 with SMTP id
 d75a77b69052e-4ab93db9a29mr286070881cf.47.1753085023538; Mon, 21 Jul 2025
 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250718234039.2266704-1-vivek.kasireddy@intel.com>
In-Reply-To: <20250718234039.2266704-1-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 21 Jul 2025 12:03:32 +0400
X-Gm-Features: Ac12FXzTMDMn_8W4Ld7VPpbiLoCSYc62boHhF9tVeH9QEy11o4RSNQRz5FVL9tw
Message-ID: <CAJ+F1CL9z1fLnj6U_jTayGrjwHZXuLV6xtek-7VN-2Uj4gPiSQ@mail.gmail.com>
Subject: Re: [PATCH] ui/spice: Destroy the temporary egl fb after the blit is
 submitted
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

On Sat, Jul 19, 2025 at 3:43=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> The temporary egl fb scanout_tex_fb is only needed to facilitate the
> blit to the display surface's texture (ssd->ds->texture). Therefore,
> destroy it after the blit is submitted. And, also make sure that it
> is empty initialized before it is actually used.
>
> Fixes: f851cd65 ("ui/spice: Blit the scanout texture if its memory layout=
 is not linear")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> v2:
> - Make scanout_tex_fb local to spice_gl_blit_scanout_texture() since
>   it is not used outside of it (Peter)
> ---
>  ui/spice-display.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 9ce622cefc..669832c561 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1183,20 +1183,20 @@ static void qemu_spice_gl_release_dmabuf(DisplayC=
hangeListener *dcl,
>      egl_dmabuf_release_texture(dmabuf);
>  }
>
> -static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd,
> -                                          egl_fb *scanout_tex_fb)
> +static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd)
>  {
>      uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
>      int fds[DMABUF_MAX_PLANES], num_planes, fourcc;
> +    egl_fb scanout_tex_fb =3D {};
>      uint64_t modifier;
>      bool ret;
>
> -    egl_fb_destroy(scanout_tex_fb);
> -    egl_fb_setup_for_tex(scanout_tex_fb,
> +    egl_fb_setup_for_tex(&scanout_tex_fb,
>                           surface_width(ssd->ds), surface_height(ssd->ds)=
,
>                           ssd->ds->texture, false);
> -    egl_fb_blit(scanout_tex_fb, &ssd->guest_fb, false);
> +    egl_fb_blit(&scanout_tex_fb, &ssd->guest_fb, false);
>      glFlush();
> +    egl_fb_destroy(&scanout_tex_fb);
>
>      if (!ssd->new_scanout_texture) {
>          return true;
> @@ -1330,9 +1330,7 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>      }
>
>      if (spice_remote_client && ssd->blit_scanout_texture) {
> -        egl_fb scanout_tex_fb;
> -
> -        ret =3D spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
> +        ret =3D spice_gl_blit_scanout_texture(ssd);
>          if (!ret) {
>              return;
>          }
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

