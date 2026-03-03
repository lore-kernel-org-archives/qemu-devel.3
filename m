Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FAAEB362F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTqt-0006HL-Lb; Tue, 03 Mar 2026 12:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxTqr-0006Gv-2b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:48:09 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxTqo-0001dr-Ny
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:48:08 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-506a1627a09so33798911cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:48:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772560086; cv=none;
 d=google.com; s=arc-20240605;
 b=GSNL+xJS/GbwMfJ4EAqkjjg+f0iLISGRki80OW245zeo4dY/SPZAqDVo4A0Qix0K52
 MxoJXqsIDPze1j5AE+/8tg7C9SXy2YVNSreQiEcbJ1BqIYyxm7Yau+fwRbzV9e0KjaDE
 Z6/8gu39UkUudnwamyFzbJaFeiq+xpSTBcVrZkpUmYPg6NLOEyyc1FauD+Sw0my9PSl4
 w1v19TZrujdtGlS/t+57jDvtFGOAZ/IVbPy8zSLK4Jbd8yR7LE30GWlADunByWOmmhpe
 IrhR3zcCrDUX88akby5xdEm2uXuA/dimg9beQgCc7NPNmxlU4Ik1xBkjh6XUsAatAhoR
 EepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hvc/yt7iGsZPhVyV73WZBfQqXsHByuf28n5OnEXrKqk=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=kd4+RoQKnUku5DlqmqqvB1B99uB2XA9ZAxACCvUzcYl0ZHOomdNYWZuKc5+6km6Z93
 3DcmgJ/hfgQI8ktMk8WqXtaLJBNjiXKcuSvr+12pUleR6W46floI6QRENR9Pl5voYLpj
 SdpK6lNT7weg96CD4+EUWtU68soOOMo402dXQtwkYZqsSePOkERzBNlJxjmFfRMTrCTL
 PyoCKLFhe+wS4FxMIcGLOFQ261KCOXt+I/Z4yA93gDBdZKwyf7wIbbTDjzwUqhv0yRd5
 3mwQkuElcE6PKRA71lIWjII84eJC6RAUHHKwnDN0g3aNSnwIav03auPDfg9lelugOPew
 ifUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772560086; x=1773164886; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hvc/yt7iGsZPhVyV73WZBfQqXsHByuf28n5OnEXrKqk=;
 b=BOPGG2qxzQDFqW4xO77h+3fUSZ0FJI70jannpCgmxhX1YFm0amp7oTihNrgBvoofs4
 6Os5TnKsMT2gcWMMUn3loDzPFzC8+oHB1gFp9Zyqn2PpE9cWNZQtSO3b7RTCjc2HFMj5
 zsuE5uE+UC6dKxUgA//EEK2lkziqn0l1dGbXnsUEYYoKbFtDiXSgAcv8MHRvGho+6Mg2
 pzQ6TgrJQmfCy+1ne5xxzlOUHg+1rzsW4hPRUCs/MoovQJV2eciLRe0iEYo6Ek7SE6Uz
 9YDHzmAJf/HAar3rK+J97O3eCARFJ6moX6Nu3qG1XsYbnZ8WsG81IBMxGLd1NRvVIPAJ
 BLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772560086; x=1773164886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hvc/yt7iGsZPhVyV73WZBfQqXsHByuf28n5OnEXrKqk=;
 b=SdjfW16G8FAHVBlKM5a2NeisQkjmesVxiXvyzXWBiUCFoeZYTIj1nuS2HGYsf/w972
 2Sb2ThkXk+UCDx4oI00LQPlf1pxejqxVWBHk62HIHpeUkvByH42lZLPtUIPcevY19NSd
 y7B2A56InRjoWBIgK2pntR6D+ce6MsOv5DuUAx1uk9FPqZqM7+TqNhoMC+ePrX/Q6Lsc
 NpzhpsI0OsL7Y53tJuIenS356qOrfQdwdD+ve3xoArrT7dzB2EAXrGrVgPjN30miaH+4
 PliS1/9RwEN7UJ8s74NVd5ILgN1e/9tynOIKZrtBM5Jw0ixGRTRgbV2sdAY2z2Lja2JG
 wttw==
X-Gm-Message-State: AOJu0YwufohCGTy0u/KTcaR+70RIh3FzlS2NZL/t8PrdqzMO7CZJlYeQ
 C51Hdjc0g7ugUDOnUhUSu3L9ilQOBlzmuLYdhz5LXd3mLsmIxwJjAklKxYhfjpJ+IgAndPixpIt
 cI+bC64N7sm6MADLEfkuAoyS1iWfUQh+B4ZOQhJJzNmOCOHg=
X-Gm-Gg: ATEYQzwX9lOWrd0MhV7F42CD0W5mk2KPQOzW4VCBRWbPxjtb/iuPW0eLY6ynr/qKFWp
 5B3QnAn1CTVFCyEg3Ia9nsvsQ693i0TJPvXUlIW2vKTcrScdpJNel1viTorhGaIGvoN+4PHZdQ2
 hqwa5Yq6gJkLU1LYLzexTM2o9EvV3gV9crKbkDTzEKjB9FtYT3owzp11G9idYwbF4r99TvBvCo8
 n6zW5v1cVkkpCgtu6+YsrmtEAYYt5mBiNfKXvC4BpXCeBsgL7hojwUO52l2WGxLl6G/1cr1a8hY
 plyK1swFF+lNHauGpNhPumvqn9MjbUM8Hjm9FPnA
X-Received: by 2002:ac8:5d49:0:b0:501:3c86:80b9 with SMTP id
 d75a77b69052e-5075296f1fcmr214880371cf.40.1772560085660; Tue, 03 Mar 2026
 09:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20260303030714.1926907-1-dongwon.kim@intel.com>
In-Reply-To: <20260303030714.1926907-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2026 18:47:54 +0100
X-Gm-Features: AaiRm51tbBVQnoLVzrx3K-pMhp6LIiGKvCEaDqGnPXbZ67P0bN-qtNqaYnFKxJ8
Message-ID: <CAJ+F1C+ownUskL4troo57_GxJjGaZvX2sHCJoc4KjYm3rU-oQw@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl
 and gtk-gl-area
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Mar 3, 2026 at 4:13=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> Currently, the texture associated with a DisplaySurface is not deleted
> when the surface is switched or freed, leading to a memory leak in the
> GPU process. This occurs because the GTK backend lacks a mapping for the
> 'dpy_gl_ctx_destroy_texture' operation.
>
> This patch implements the necessary cleanup functions for both EGL and
> GL Area backends. Each implementation ensures the appropriate GL context
> is made current before calling surface_gl_destroy_texture(), ensuring
> that the underlying GL texture ID is safely released by the driver.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/gtk.h |  4 ++++
>  ui/gtk-egl.c     | 10 ++++++++++
>  ui/gtk-gl-area.c |  8 ++++++++
>  ui/gtk.c         |  2 ++
>  4 files changed, 24 insertions(+)
>
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 3e6ce3cb48..f1765ad5cb 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -170,6 +170,8 @@ void gd_egl_switch(DisplayChangeListener *dcl,
>                     DisplaySurface *surface);
>  QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
>                                      QEMUGLParams *params);
> +void gd_egl_destroy_texture(DisplayGLCtx *dgc,
> +                            DisplaySurface *surface);
>  void gd_egl_scanout_disable(DisplayChangeListener *dcl);
>  void gd_egl_scanout_texture(DisplayChangeListener *dcl,
>                              uint32_t backing_id,
> @@ -206,6 +208,8 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx =
*dgc,
>                                          QEMUGLParams *params);
>  void gd_gl_area_destroy_context(DisplayGLCtx *dgc,
>                                  QEMUGLContext ctx);
> +void gd_gl_area_destroy_texture(DisplayGLCtx *dgc,
> +                                DisplaySurface *surface);
>  void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>                                 QemuDmaBuf *dmabuf);
>  void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index ae9239999c..c1b32bc41b 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -225,6 +225,16 @@ QEMUGLContext gd_egl_create_context(DisplayGLCtx *dg=
c,
>      return qemu_egl_create_context(dgc, params);
>  }
>
> +void gd_egl_destroy_texture(DisplayGLCtx *dgc, DisplaySurface *surface)
> +{
> +    VirtualConsole *vc =3D container_of(dgc, VirtualConsole, gfx.dgc);
> +
> +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> +                   vc->gfx.esurface, vc->gfx.ectx);
> +
> +    surface_gl_destroy_texture(dgc->gls, surface);
> +}
> +
>  void gd_egl_scanout_disable(DisplayChangeListener *dcl)
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index cd86022d26..84e41f4221 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -299,6 +299,14 @@ void gd_gl_area_destroy_context(DisplayGLCtx *dgc, Q=
EMUGLContext ctx)
>      g_clear_object(&ctx);
>  }
>
> +void gd_gl_area_destroy_texture(DisplayGLCtx *dgc, DisplaySurface *surfa=
ce)
> +{
> +    VirtualConsole *vc =3D container_of(dgc, VirtualConsole, gfx.dgc);
> +
> +    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> +    surface_gl_destroy_texture(dgc->gls, surface);
> +}
> +
>  void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>                                  uint32_t backing_id,
>                                  bool backing_y_0_top,
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 9ebe7e8df0..217f425075 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -636,6 +636,7 @@ static const DisplayGLCtxOps gl_area_ctx_ops =3D {
>      .dpy_gl_ctx_is_compatible_dcl =3D gd_gl_area_is_compatible_dcl,
>      .dpy_gl_ctx_create       =3D gd_gl_area_create_context,
>      .dpy_gl_ctx_destroy      =3D gd_gl_area_destroy_context,
> +    .dpy_gl_ctx_destroy_texture =3D gd_gl_area_destroy_texture,
>      .dpy_gl_ctx_make_current =3D gd_gl_area_make_current,
>  };
>
> @@ -670,6 +671,7 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
>      .dpy_gl_ctx_is_compatible_dcl =3D gd_egl_is_compatible_dcl,
>      .dpy_gl_ctx_create       =3D gd_egl_create_context,
>      .dpy_gl_ctx_destroy      =3D qemu_egl_destroy_context,
> +    .dpy_gl_ctx_destroy_texture =3D gd_egl_destroy_texture,
>      .dpy_gl_ctx_make_current =3D gd_egl_make_current,

But there is no dpy_gl_ctx_create_texture(), how can
dpy_gl_ctx_destroy_texture() get called?

>  };
>  #endif
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

