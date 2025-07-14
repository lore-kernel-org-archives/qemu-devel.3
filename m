Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B042C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLS1-0000Fl-Po; Mon, 14 Jul 2025 11:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ubKJ9-00045b-ND
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:37:34 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ubKJ7-00049Q-27
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:37:31 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso63485301cf.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752503847; x=1753108647; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37/kV6oNNr+YsMEoe8w5gieaOrP+vGgou2O1vX6B5t8=;
 b=FVaXpFACl6xtpZmk2OJellMZe+Rq/KLUjnLEyY5ea1E4wSYl8XTbN0rXSb3iPuLX+Q
 p/Ygzi5tuRyr4HynxdVa2Fl/72n40LDL7K5QGcSkzGR7cyq4GZP63VPLlng7x+dEx2T1
 gwvHGhXUixUh1zwbApI49jc/VCLp31JWD9u6NWONj5BOMCZLX13PNWD/XeDxB+HiX8k/
 KUnEDA5/uHXD+29g6ciOQmcYawcva6IwAzachwSh4pcNQcoKtDuYBcLWZuWLDwB6STVo
 UYKa6Gmb7PgXr3zvPetKNo+eoInbcS6O8TbLn9OvTxPtSDgewIqs1sTH2mgNBKXTiQ8z
 /FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752503847; x=1753108647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37/kV6oNNr+YsMEoe8w5gieaOrP+vGgou2O1vX6B5t8=;
 b=iBxdjtHjQYbdsM4FfDZ8N7b8YLCSK6dbpN2kz2xvelKSw48ymzfeekvNe4Zh9KNtke
 RRiXGzs/KC5sIiGFmQ9aQ7j1KZffGXe/QpHZbGJ4Y+GaG/J8jQ3XVw49eCKdn3sFxtwY
 Nbwe/LDLMQDESy+sLYXnH7kmpzC5mtLykuHbB1Vy5UYQXXEjrsGoh1aKBE5dDfkoE+6s
 7mFlLD+518eKKxng0J58ZZQ3CZIjVi7YMnojJN7Mlm2MeOYulZOGW+fiBBp37cIOZ4Ix
 Mhw3NlyegG+0CsXSW16FZG+BYpcMVS4ZTyQqd7/OmFq7ZmqMqu8aORQJ2mkt2D0VPI9f
 GQNA==
X-Gm-Message-State: AOJu0YwLWoG+OpF94owZeA7cRcGz1GslgMFGyxW0J/VcAJ2X74QYEXyH
 K2ZYOjfnVCNFBnDiOqdaMHh2Tjfq/xSV9Q7R7/WCmFbeaTW142hnfuf/a7HbZ5TZv1kZNZDdRKZ
 jPbAQcU18SeCWepXsTnnqAzriuJogwaQ=
X-Gm-Gg: ASbGncv2zQ7/TxyMmJBF7fwgF9/H4G2y5S5Wsl6nEkCZNvo+fd97TvfJQWWWEfVA+QZ
 qukX5fv09x4XDJ7wktHDUeCTGSKw9pROTXOgWHeurbiXZ+eN/IJcKrg5aXn8inSIfY5zZWXGeH4
 qBaWRTecYv3/w/lLKtrxMKh3WsCvNna0QpN1R79RQUa+uiYBr0bUiew//JiT1bMXIO/b4aBe1TK
 mCQ/V3AVXvql774dwtZOxQPdOYXdvLZxEi4S8iY
X-Google-Smtp-Source: AGHT+IE/AAep1Y4N85Tok0o9PscvZ6joFzFzZOWSNi2AQG2mcDArKahXxzXZhE408FPJDQn0G2ZDcKe6VavK/5e31t0=
X-Received: by 2002:a05:622a:1452:b0:4ab:6bd2:e25 with SMTP id
 d75a77b69052e-4ab6bd251fcmr67193781cf.25.1752503847373; Mon, 14 Jul 2025
 07:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250714141758.10062-1-weifeng.liu.z@gmail.com>
In-Reply-To: <20250714141758.10062-1-weifeng.liu.z@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Jul 2025 18:37:16 +0400
X-Gm-Features: Ac12FXygrj_OU3-yQ1Ek0XcfNqfYqbnrnherg45poJ4XEYL4Tb0UKzD93Z2IJms
Message-ID: <CAJ+F1CJZ0-pvt0-dn_5S58GYobG=H+hb_czNRVGnhVU3VA1ybA@mail.gmail.com>
Subject: Re: [PATCH] gtk: Skip drawing if console surface is NULL
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Mon, Jul 14, 2025 at 6:18=E2=80=AFPM Weifeng Liu <weifeng.liu.z@gmail.co=
m> wrote:
>
> In gtk draw/render callbacks, add an early NULL check for the console
> surface and skip drawing if it's NULL. Otherwise, attempting to fetch
> its width and height crash. This change fixes Coverity CID 1610328.
>
> In practice, this case wouldn't happen at all because we always install
> a placeholder surface to the console when there is nothing to display.
>
> Resolves: Coverity CID 1610328
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk-egl.c     | 5 +----
>  ui/gtk-gl-area.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 0b787bea25..ae9239999c 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -72,7 +72,7 @@ void gd_egl_draw(VirtualConsole *vc)
>  #endif
>      int ww, wh, pw, ph, gs;
>
> -    if (!vc->gfx.gls) {
> +    if (!vc->gfx.gls || !vc->gfx.ds) {
>          return;
>      }
>
> @@ -112,9 +112,6 @@ void gd_egl_draw(VirtualConsole *vc)
>          }
>  #endif
>      } else {
> -        if (!vc->gfx.ds) {
> -            return;
> -        }
>          eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                         vc->gfx.esurface, vc->gfx.ectx);
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 8151cc413c..05fc38096e 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -48,7 +48,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>      int fbw, fbh;
>      int wx_offset, wy_offset;
>
> -    if (!vc->gfx.gls) {
> +    if (!vc->gfx.gls || !vc->gfx.ds) {
>          return;
>      }
>
> @@ -135,9 +135,6 @@ void gd_gl_area_draw(VirtualConsole *vc)
>          }
>  #endif
>      } else {
> -        if (!vc->gfx.ds) {
> -            return;
> -        }
>          gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>
>          surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, pw, ph);
> --
> 2.49.0
>


--=20
Marc-Andr=C3=A9 Lureau

