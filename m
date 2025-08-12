Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5B6CA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 23:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulycg-0006yJ-TC; Tue, 12 Aug 2025 19:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulyce-0006xK-Bk
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:41:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulycT-00087i-UO
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:41:39 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6154d14d6f6so7025331a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755042085; x=1755646885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNp9R9/dnBd/hRC+QUiGRCKNYQmASo17Z8cMOF0g+Fc=;
 b=Z12xdZdn6XhwPtvevVWGzTJnnauC33kPKir8QXrrF3v5ZS8ZMK2F9wjE+ZGZ5iuwZ8
 AhlJGj43COK/jX3Cpo72PI4Klg2oQpHZTIaRNB95T6h/yDDHmb1kVj+wQdVTGv78Ivqy
 Vet5IXKnTeHrT8gvlojBKE4NmlqsJmtD98sBaTcsXmzWBH9Vp+BuLsGmA/6HGhLeHC2P
 1ocePCgW0Rl9zIIBdJ+NAiflCVJyiBixFxiYLwMmj3u4eVYQcTPh3qUrtCPCENE29CBv
 vT5oZJ2ai5c5HcdDUwk67yJ2uafn1UMzEuM5EUcDPx/1AJAbRac+/1XrviS0ElON/iHj
 vHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755042085; x=1755646885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNp9R9/dnBd/hRC+QUiGRCKNYQmASo17Z8cMOF0g+Fc=;
 b=jRixEym4u6h34cwT0X59sD/S3VrtqwuDM+H7IJ9rxob3IOxNq+2ZRVwJoMXbeehBES
 hFB1EFGcFL3AtXLXTSCCEBftvsYSN3rJCffMN2JfhlcCNBxvxLMphoh/j/ve3v2qWWrz
 9ArAKZ02mkk1DTS6kX5civXMZKwHmzXPT+ea+Ekp8EPl4hgpoMOcewj/ZndivxaHjnM7
 BcGBrAeAzJlPdBKfdDGVSvrb3ibi+h9PDbSqk7Qi3Qb7T8Z7VuJxiKdM2a2CUmyGQbCj
 OEM5KpmYwXm3uqPT/qB1ykG/x6qqgLGSwd9TxwplV9I0iEJV/0tv9Fzu6osb/MXlvKdv
 NCVA==
X-Gm-Message-State: AOJu0YyAMuqncxqDSqGPTb/6nmNH/ky3qFRw6Rkv/demVtvRv2Hd4PxX
 y1px4nScNR/r49AJKueJc2aA7QexkR07q54FADf3o71n7YGo+P9iG/tmx+M15lsPCUGEDbnP5LA
 n/b4ZKK6dDZmWwLYjkGziPt8GdD1dKo9ghw==
X-Gm-Gg: ASbGncsxJVbNJUhjUUvhrRahEJYZG8YBN0UIZHYDcXAS513iHVKE9BSR0rK291nY1do
 NZJVQZSPYQZATWD2sSlx+HBtxuKNm91de2SMOb+MA1bWFJtIndh5FlFCiviEzteY3L2jqg+0n+9
 rBUisGWVjt+kzhM43qSyGyXNVIjUO2aHYevpARnvG1/ZNa8Hs+enLwR7QO3Pn/cJyTjRzPeoFSn
 YT5MXA3f5Dd/O3p
X-Google-Smtp-Source: AGHT+IHhPYil7S8XyBmLQi88jQtxorgAz9a/1m7sLLKMjGQugHc05kVrbfdeCS0EKjuveKOBY81fZti1gsN74azgl5g=
X-Received: by 2002:a05:6402:26c1:b0:615:97fe:54c7 with SMTP id
 4fb4d7f45d1cf-6186b99a0b6mr614014a12.14.1755042085270; Tue, 12 Aug 2025
 16:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250718234039.2266704-1-vivek.kasireddy@intel.com>
In-Reply-To: <20250718234039.2266704-1-vivek.kasireddy@intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Aug 2025 19:41:12 -0400
X-Gm-Features: Ac12FXxlmgQBTsW6AWTjO3pNYPmFRAR0_hoNqDsLrlV4hb5j-juULIoznXSrqDI
Message-ID: <CAJSP0QVpgFVRspVsNKvktebLpfziDaO8dPaGVPgDR9eViYMzZQ@mail.gmail.com>
Subject: Re: [PATCH] ui/spice: Destroy the temporary egl fb after the blit is
 submitted
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Fri, Jul 18, 2025 at 7:42=E2=80=AFPM Vivek Kasireddy
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
> ---
> v2:
> - Make scanout_tex_fb local to spice_gl_blit_scanout_texture() since
>   it is not used outside of it (Peter)
> ---
>  ui/spice-display.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied for QEMU v10.1.0-rc3. Thanks!

Stefan

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

