Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C16AF33A8D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyAWy-0006Mt-Qi; Thu, 05 Mar 2026 10:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vyAWt-0006LN-V0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:22:24 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vyAWr-00030k-IL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:22:23 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-506a6cf8242so58424541cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 07:22:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772724139; cv=none;
 d=google.com; s=arc-20240605;
 b=M35gNdqwcduxWN6N1ydsbNZSPAdBnvGPc8EHXhjX8xSjgGzupX8xfEMdyh+kk2hj7G
 NVEV5q9jRyyg6QNDcIKBU5hRV4tf5hjzVfO55zcDfmPZnufAqctcmflPlEmtLAEznnEs
 ObgkgiPv2H+NvX96N36a7RjG/oxGxM/n/YXgrjHCmkFRfWIR0rn1IsLlztes1aOGuo9x
 NLkls/uVg8dnRn7gchKeV3QiAh6d8N5yRDKk4jMIeO9plV/OQ5saNWfJ3eNhkosYo3sf
 ZCDmpQ1Q/VzSpBTaKqYHS7T0snTuFXuTVvHpKSx1Z2fF3gwLHQXajYkjQioIywySlqnr
 TAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J7o+Gn8rtivx7pGMB4y015U+u3MWLF/4oAjLz9+3H5Q=;
 fh=qut9WCGoiumS8buQKfV4VTgRMJrLq2rWzZgt13Ew7uM=;
 b=DcQAZFPwnYqk7sd+4OwDKcBSbX4Jh+aNJIP66KmjQP8jeZRTPFTCoDxiCLdelmdJUY
 1nKjPmtucGHUf/00SZuiZqA2WZfQ9qjCPausEdBHXAr3nFrE9QF8P0LW7cj1/oCg+qHH
 ilcJRseOkZ46XW5L24oKC6rFcJ+3kvPgbfvV6SCVRXR7QuyZIHkcH/3CB89xKyDv3ejz
 vqBvUf74ZeRYsaHhNw7g6qvbrySdEsqL5pqTi0LwiVliK2uUOaIDrxsNSg3Ix2BsFIfd
 Qf6g1ka7ttSHkYVvX22OO8vQxuWr/uoix+Sz1XSscpHXJu2Jld5qYk38Me4+g4p1B0DC
 XYrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772724139; x=1773328939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7o+Gn8rtivx7pGMB4y015U+u3MWLF/4oAjLz9+3H5Q=;
 b=BisnyAFUqdPapo/JR8iC/ZVdsSkMO+1abEMzTLj+p9Rx1YpHd53K1QDNdwmbaCqoYt
 SX3ypeWOdwgdhtwiNfzVhLC4KEE+i3+tLCdiWnas+IhU8MU+aN1gMTXGEk+CpWwjP5a/
 WUU8v9kiwXl2LLWlq6U0YrLnY0BUaujSNP15bi5cfEP8nV7g5Gu7pZp2U2GJ4/VLIoXo
 HdN/idyQjpE27TGgZU65yFjwe4Ygwt2xtNcKAOifQJEt92Fph076GF5nr0691sSkBJcg
 xv7iJM34NyVeL/TT8D4q60OPx22w8kxG9z4jlm8LF6KB4vSSoS8tg9upIYFjROzjhr8v
 SpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772724139; x=1773328939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J7o+Gn8rtivx7pGMB4y015U+u3MWLF/4oAjLz9+3H5Q=;
 b=pEbJ93UZmhmTdJs00QOyPDobhA1UVlOsTXBH8n6OL3No2DGg+zm2BCOQBPHxJV2PJf
 yOptncZgAJ4oIz7lbXkXgOOCzDntevR19e2/ytreAqQ7BAAONLC4AcI1EfpBynLW/hzo
 XjZtIW1Jrhg2ChGL3ol10rcojqs2D0eRPKG7mOISleP6Lk5hZq2l6CrItbFD8tHRg3Dx
 KSqmok41QIYrefBH5Z5RX6gm5SkwGVMlfFFC0+x6Bo57nGCrUadE53/qfGhTFXvJhTvO
 JCPO1XVzrVnKDBRTs7r7B9sbhLFJMAKLuiFRPunoXi39AG2qxxfzsJxc1H3FeBuiZdY/
 AxqA==
X-Gm-Message-State: AOJu0YywLA1hAKu6sbBJqPRIZ67f9uYf1sVacztGT3z51tuIDkrtW7o5
 9NBhFM8yn1dnbmsEIX2mijVcYQqnsZ6Ezhw7JLfHKukGHq73I6vZz53r+8fcZKtzgQ9/LJsgSrm
 GcsRyqUaVvmds5FV/R7l2IuLXYKgV96c=
X-Gm-Gg: ATEYQzzDcCGxbCPDBHHvLbUGaOIETAV3M2liUAUylPNJFy0XMGL3PvSYe5iwh05tsNo
 +iE3HV95zwamUHAKyXu5Rd5T88denVzfEpf7/tULyK6vB2eRfrVNoEmBCRMJEdE3lQZLmh5hTbQ
 gNnu5wqbZ9fmxkXX3mCEyyeK/kDKYzxW4oM7SPpfkJlTheM3KFdiccl08FejEAdpOvd0kpPueBn
 8ND21aDv/Tq6vIenCpME4WtrJW+K2zC83LieY9TP5SRE6WpttW3MaAvu3n0lyLC8V6hR3SzXXSe
 VOHMm6Zs2pHgObuqXw==
X-Received: by 2002:ac8:7dd0:0:b0:501:4a4a:c24e with SMTP id
 d75a77b69052e-508db2ac5fbmr85764951cf.25.1772724139101; Thu, 05 Mar 2026
 07:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20260303030714.1926907-1-dongwon.kim@intel.com>
 <CAJ+F1C+ownUskL4troo57_GxJjGaZvX2sHCJoc4KjYm3rU-oQw@mail.gmail.com>
 <PH0PR11MB511248C615D6433E2ED7E7D4FA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB511248C615D6433E2ED7E7D4FA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Mar 2026 16:22:07 +0100
X-Gm-Features: AaiRm50JWZdGAvgtZhZrPNjFjr31Ls5zFvSCXhFPuiALFYfgreZZvtCo7Jstt7s
Message-ID: <CAJ+F1C+BGW3hzLc8jnxKXxmY3-jkQ85=BSWc+sPhOZ86bzsjVQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl
 and gtk-gl-area
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

On Tue, Mar 3, 2026 at 7:50=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > Subject: Re: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for g=
tk-
> > egl and gtk-gl-area
> >
> > Hi
> >
> > On Tue, Mar 3, 2026 at 4:13=E2=80=AFAM <dongwon.kim@intel.com> wrote:
> > >
> > > From: Dongwon Kim <dongwon.kim@intel.com>
> > >
> > > Currently, the texture associated with a DisplaySurface is not delete=
d
> > > when the surface is switched or freed, leading to a memory leak in th=
e
> > > GPU process. This occurs because the GTK backend lacks a mapping for
> > > the 'dpy_gl_ctx_destroy_texture' operation.
> > >
> > > This patch implements the necessary cleanup functions for both EGL an=
d
> > > GL Area backends. Each implementation ensures the appropriate GL
> > > context is made current before calling surface_gl_destroy_texture(),
> > > ensuring that the underlying GL texture ID is safely released by the =
driver.
> > >
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > > Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> > > ---
> > >  include/ui/gtk.h |  4 ++++
> > >  ui/gtk-egl.c     | 10 ++++++++++
> > >  ui/gtk-gl-area.c |  8 ++++++++
> > >  ui/gtk.c         |  2 ++
> > >  4 files changed, 24 insertions(+)
> > >
> > > diff --git a/include/ui/gtk.h b/include/ui/gtk.h index
> > > 3e6ce3cb48..f1765ad5cb 100644
> > > --- a/include/ui/gtk.h
> > > +++ b/include/ui/gtk.h
> > > @@ -170,6 +170,8 @@ void gd_egl_switch(DisplayChangeListener *dcl,
> > >                     DisplaySurface *surface);  QEMUGLContext
> > > gd_egl_create_context(DisplayGLCtx *dgc,
> > >                                      QEMUGLParams *params);
> > > +void gd_egl_destroy_texture(DisplayGLCtx *dgc,
> > > +                            DisplaySurface *surface);
> > >  void gd_egl_scanout_disable(DisplayChangeListener *dcl);  void
> > > gd_egl_scanout_texture(DisplayChangeListener *dcl,
> > >                              uint32_t backing_id, @@ -206,6 +208,8 @@
> > > QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
> > >                                          QEMUGLParams *params);  void
> > > gd_gl_area_destroy_context(DisplayGLCtx *dgc,
> > >                                  QEMUGLContext ctx);
> > > +void gd_gl_area_destroy_texture(DisplayGLCtx *dgc,
> > > +                                DisplaySurface *surface);
> > >  void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
> > >                                 QemuDmaBuf *dmabuf);  void
> > > gd_gl_area_scanout_texture(DisplayChangeListener *dcl, diff --git
> > > a/ui/gtk-egl.c b/ui/gtk-egl.c index ae9239999c..c1b32bc41b 100644
> > > --- a/ui/gtk-egl.c
> > > +++ b/ui/gtk-egl.c
> > > @@ -225,6 +225,16 @@ QEMUGLContext
> > gd_egl_create_context(DisplayGLCtx *dgc,
> > >      return qemu_egl_create_context(dgc, params);  }
> > >
> > > +void gd_egl_destroy_texture(DisplayGLCtx *dgc, DisplaySurface
> > > +*surface) {
> > > +    VirtualConsole *vc =3D container_of(dgc, VirtualConsole, gfx.dgc=
);
> > > +
> > > +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> > > +                   vc->gfx.esurface, vc->gfx.ectx);
> > > +
> > > +    surface_gl_destroy_texture(dgc->gls, surface); }
> > > +
> > >  void gd_egl_scanout_disable(DisplayChangeListener *dcl)  {
> > >      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> > > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c index
> > > cd86022d26..84e41f4221 100644
> > > --- a/ui/gtk-gl-area.c
> > > +++ b/ui/gtk-gl-area.c
> > > @@ -299,6 +299,14 @@ void gd_gl_area_destroy_context(DisplayGLCtx
> > *dgc, QEMUGLContext ctx)
> > >      g_clear_object(&ctx);
> > >  }
> > >
> > > +void gd_gl_area_destroy_texture(DisplayGLCtx *dgc, DisplaySurface
> > > +*surface) {
> > > +    VirtualConsole *vc =3D container_of(dgc, VirtualConsole, gfx.dgc=
);
> > > +
> > > +    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> > > +    surface_gl_destroy_texture(dgc->gls, surface); }
> > > +
> > >  void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
> > >                                  uint32_t backing_id,
> > >                                  bool backing_y_0_top, diff --git
> > > a/ui/gtk.c b/ui/gtk.c index 9ebe7e8df0..217f425075 100644
> > > --- a/ui/gtk.c
> > > +++ b/ui/gtk.c
> > > @@ -636,6 +636,7 @@ static const DisplayGLCtxOps gl_area_ctx_ops =3D =
{
> > >      .dpy_gl_ctx_is_compatible_dcl =3D gd_gl_area_is_compatible_dcl,
> > >      .dpy_gl_ctx_create       =3D gd_gl_area_create_context,
> > >      .dpy_gl_ctx_destroy      =3D gd_gl_area_destroy_context,
> > > +    .dpy_gl_ctx_destroy_texture =3D gd_gl_area_destroy_texture,
> > >      .dpy_gl_ctx_make_current =3D gd_gl_area_make_current,  };
> > >
> > > @@ -670,6 +671,7 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
> > >      .dpy_gl_ctx_is_compatible_dcl =3D gd_egl_is_compatible_dcl,
> > >      .dpy_gl_ctx_create       =3D gd_egl_create_context,
> > >      .dpy_gl_ctx_destroy      =3D qemu_egl_destroy_context,
> > > +    .dpy_gl_ctx_destroy_texture =3D gd_egl_destroy_texture,
> > >      .dpy_gl_ctx_make_current =3D gd_egl_make_current,
> >
> > But there is no dpy_gl_ctx_create_texture(), how can
> > dpy_gl_ctx_destroy_texture() get called?
>
> Textures are also created via surface_gl_create_texture in the places lik=
e,
>

But surface_gl_{create,destroy}_texture doesn't make use of
dpy_gl_ctx_destroy_texture. The later is only used by dbus so far, see
commit 589089feee ("ui/dbus: fix texture sharing").

> gtk-egl.c
> static void gtk_egl_set_scanout_mode(VirtualConsole *vc, bool scanout)
> {
>  .....
>        egl_fb_destroy(&vc->gfx.guest_fb);
>         if (vc->gfx.surface) {
>             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
>             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
>         }
>
> surface_gl_create_texture always come after surface_gl_destroy_texture
> so there is no leak while the guest is running but texture would remain u=
nremoved
> if we do none in dpy_gl_ctx_destroy_texture() when the guest is rebooting=
.
>
> >
> > >  };
> > >  #endif
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
> Thanks



--=20
Marc-Andr=C3=A9 Lureau

