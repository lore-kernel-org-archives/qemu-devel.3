Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA053C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4d4m-0002BS-20; Thu, 10 Sep 2026 07:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4d4l-0002BK-0z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:36:19 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4d4h-00074l-Gl
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:36:18 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-39b9a99469fso2860119a91.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 04:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789040173; cv=none;
 d=google.com; s=arc-20260327;
 b=Ube2+J2lBDGW2wiDuXFGS2Wb6qApUn0Q+xBl1OkfiQbwHV6U61OTEza4W0RkI11m1w
 7TduJNtpHyXyOClpdTlrktXdklMAGjGNaJ45b1QmesQIieXAe63tLp0vnYoD1fFf/jhE
 KSFV5+SqKzAjaEyKUGUm5fJmTnKfFF8HOMjP2WsQiHuJe4Babdm4Qra3JUWldhLX3HzR
 l/lULC7vFR/GcNmnxF43IV6GRrSgy5DWaGnDv+G/83VchHFMqMA0z1m9up2660U0UY8O
 d4AWUKW/+eGjMyCZELS446fv5f/TzvYnED1/QkUrlhm8ahJ242wIzGmrFUJu350n7PFZ
 mgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nUyTtI47GWO/UvU3SNrR3VI/b9l8hXSBhBxRq3PlhZg=;
 fh=HLSuPskybtIIysCDrrCUGCclYLaEEdtpVmqnrjAgGtQ=;
 b=AqaNTm4pLppN/hXiw/5mZSKvWxUL8+/rEH1/qd23RZOrFVB9QisfgyivgoDlJvEpum
 RdV6zC9YnAaU75e99ZlaIhjTpmpeY/gb+zYS350Dh84vk97e++7LsH0IQdbxxMRm8zTy
 91rzbxSVyrvjrzxnDAY9pWRpB2bSl+ruE2NOOYthYb8S0Ma+FryZwGYxgvWb6dArdqSb
 5LoyBIgajShTIHtfxPbhmoO/gr2+LX2rydsCG/O2wOPqvdqagfCJ/L4UAnEG4dweeyLu
 rpGze7XRBxKnqIqXM4Lpq5bdEwNL2Q9nNxO50cjK8cImBgMS5zcCBoRfZ+oveX4XFkuG
 8vmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789040173; x=1789644973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nUyTtI47GWO/UvU3SNrR3VI/b9l8hXSBhBxRq3PlhZg=;
 b=KpgwUPTdwzaBfPMLJsjY89E8fmwsCOjf1GJUIH+v3UvHX2rixnUvMAxnMZ2Ht8rycL
 nJOJmKMUx8xHcNkvUdFXpe/C8chIY8nd9UAnLHgGr4ZMqcWG7M5zuOVkhd0WN8IFcbKA
 OiyrGsZJqr+cs/USI/9i0a/CzuRd/zdfmPIWqP3CN3FaKhrRWLH653bgp3Y1IeBJWkmB
 wk21LB//c1R0j5ZArP+UvmUz3U9phwPERAjzKHC6zdwTNeqSWxw4GWKUiYg/jiidn/VN
 ASwV1virVxzr81WkHxyWLdHZrVUXNdY0UolF++B86WyfAFzdjCLQqqopXePUOMZzwbAJ
 o4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789040173; x=1789644973;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUyTtI47GWO/UvU3SNrR3VI/b9l8hXSBhBxRq3PlhZg=;
 b=EnV5kyE9HNjIB78xd+/bgBhQnlGO7OSRPaGpbWhNq1wDXjbQcNNaYSVVu65gPaUO+J
 6gsXYLYgnOvZyb/poqQe0nYLbHvuoVEsu5BwH2OhpEL/y1ehYK32hIPStPcopD8eHFls
 ePoLZgITx0vJRZKpmSKGFzzbFhvNNrUP91QcvtZlEhaw8i6QwrWwFDHeNh9v163SRTb2
 iJpOm6dJ0flxuOmc68z48+sg5yCvc69aPDWSZdx/PO2oZPB+zUTTogi9gQX+0f9gBoVF
 1ijKGMcHTWrWpmtxI/4vBy220IWf7nNtMbbG0rvbkp5HwrQ0cEADBcKvVqJOcI7mQ7av
 GpXg==
X-Gm-Message-State: AFuF++k+oRRedVWv9lKru2dA7Nq25L5Y3IS+nyK4I5PoYhRn+MRC7XLb
 GIifs4nBebqlxICADfCikeWp1OLw4/JNLg4bxVxVnnHbgGjh75SuNVW9BPjvooCg6txgUE4JMTi
 MG2YHx99WCMH0z0zynnq4DjPSoN9LIpY=
X-Gm-Gg: AYBFou3cS8FgGo+0uLNHv9Uh9dwzl1hTx/SEdOzODZ8Fh4BO2pJohvBTG1K0YRnQBxn
 5gq2hku6HUDaC8TkU9Wo2IoFv34geuhzNXIzTRcO29tTaXyhE36s5SaimMEvteDubFKWKYcssER
 1h1uo2rQTNFVDIXzC/3ueIOzFqUL7aHrY0P9jnM1UVOqErBbdod9I0vJUrDckFMWdYcp53zvP2c
 vbcLG/TeAQyiblD/M+kpTXgsIT48ZNQzQxLt49OcNQsC8/rPro2bGKaaNzsve/tnYJMqxmNuuH+
 0R+KP8L4QuoH43i9M0pMR6Q3U3fLqBGz5nJsAbhq0GH+aWdelyN/XAWZP9eMYqDFrwl0ZIRM+CF
 PqwTNYhcAzEs=
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-39b260d2f07mr62463900a91.3.1789040173425; Thu, 10 Sep 2026
 04:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
 <20260910-virtio-gpu-cleanup-v4-13-7d623714bd71@redhat.com>
 <c9424c1b-9e00-4be0-9796-b98f9d4c5050@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c9424c1b-9e00-4be0-9796-b98f9d4c5050@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 15:36:01 +0400
X-Gm-Features: AcwNN1W1cTr3S5EgW4fsgNKCp5a2YWlPZMvwZUXIiNafbQhaBG1leso6eqTnppI
Message-ID: <CAJ+F1CJ7SF4h5D6hreoBDZ3k3gob037S0QXRr4w_mpXvP3ft5w@mail.gmail.com>
Subject: Re: [PATCH v4 13/24] ui: make GL context current in display backend
 callbacks
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 10, 2026 at 2:55=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/09/10 17:17, Marc-Andr=C3=A9 Lureau wrote:
> > Display backend GL callbacks (scanout, flush, release, etc.) may be
> > invoked from a different GL context, like virgl. Since framebuffer
> > objects are per-context and textures require a valid context for
> > deletion, each callback must ensure the correct context is active befor=
e
> > performing GL operations.
> >
> > Make each backend's own GL context current at the entry of every
> > callback that performs GL work.
> >
> > For GTK, the previously shared gd_gl_release_dmabuf is split into
> > backend-specific gd_egl_release_dmabuf and gd_gl_area_release_dmabuf,
> > matching the existing pattern where each backend manages its own
> > context.
> >
> > On the virgl side, restore ctx0 with virgl_renderer_force_ctx_0()
> > after SET_SCANOUT, RESOURCE_FLUSH, and SET_SCANOUT_BLOB command
> > handlers, since their display callbacks may have changed the current
> > GL context.

Ok, it sounds like we need to save/restore context at each callback
for now. Later on we should try to change the code to avoid that dance
and defer it. Right?


> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-virgl.c |  4 ++++
> >   include/ui/gtk.h              |  5 +++++
> >   ui/egl-headless.c             | 17 +++++++++++++++++
> >   ui/gtk-egl.c                  | 12 ++++++++++++
> >   ui/gtk-gl-area.c              | 11 +++++++++++
> >   ui/gtk.c                      | 13 ++++---------
> >   ui/sdl2-gl.c                  |  2 ++
> >   ui/spice-display.c            |  2 ++
> >   8 files changed, 57 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 7f1d1e0c3276..0e43eacca406 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -1091,9 +1091,12 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> >           break;
> >       case VIRTIO_GPU_CMD_SET_SCANOUT:
> >           virgl_cmd_set_scanout(g, cmd);
> > +        /* Display callbacks may change the current GL context. */
> > +        virgl_renderer_force_ctx_0();
> >           break;
> >       case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> >           virgl_cmd_resource_flush(g, cmd);
> > +        virgl_renderer_force_ctx_0();
> >           break;
> >       case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> >           virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
> > @@ -1130,6 +1133,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> >           break;
> >       case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
> >           virgl_cmd_set_scanout_blob(g, cmd);
> > +        virgl_renderer_force_ctx_0();
>
> I doubt that adding these virgl_renderer_force_ctx_0() calls is correct
> here. Since scanout and resource flush actually happen in the UI
> context, we actually need to use the UI context to fence those operations=
.
>
> Regards,
> Akihiko Odaki
> >           break;
> >   #endif
> >       default:
> > diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> > index b66b9ca5c519..6b62e9758813 100644
> > --- a/include/ui/gtk.h
> > +++ b/include/ui/gtk.h
> > @@ -163,6 +163,7 @@ extern bool gtk_use_gl_area;
> >   void gd_update_windowsize(VirtualConsole *vc);
> >   void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *wi=
dget);
> >   void gd_gl_wait_sync(VirtualConsole *vc, void *sync);
> > +void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf);
> >
> >   /* ui/gtk-egl.c */
> >   void gd_egl_init(VirtualConsole *vc);
> > @@ -190,6 +191,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dc=
l,
> >                             uint32_t hot_x, uint32_t hot_y);
> >   void gd_egl_cursor_position(DisplayChangeListener *dcl,
> >                               uint32_t pos_x, uint32_t pos_y);
> > +void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
> > +                           QemuDmaBuf *dmabuf);
> >   void gd_egl_flush(DisplayChangeListener *dcl,
> >                     uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> >   void *gd_egl_scanout_flush(DisplayChangeListener *dcl,
> > @@ -221,6 +224,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListen=
er *dcl,
> >                                   uint32_t x, uint32_t y,
> >                                   uint32_t w, uint32_t h,
> >                                   void *d3d_tex2d);
> > +void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
> > +                               QemuDmaBuf *dmabuf);
> >   void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
> >   void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
> >                                 uint32_t x, uint32_t y, uint32_t w, uin=
t32_t h);
> > diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> > index ba27efcf4c3e..c3f319c0960b 100644
> > --- a/ui/egl-headless.c
> > +++ b/ui/egl-headless.c
> > @@ -52,6 +52,8 @@ static void egl_scanout_disable(DisplayChangeListener=
 *dcl)
> >   {
> >       egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       egl_fb_destroy(&edpy->guest_fb);
> >       egl_fb_destroy(&edpy->blit_fb);
> >   }
> > @@ -69,6 +71,9 @@ static void egl_scanout_texture(DisplayChangeListener=
 *dcl,
> >
> >       edpy->y_0_top =3D backing_y_0_top;
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> > +
> >       /* source framebuffer */
> >       egl_fb_setup_for_tex(&edpy->guest_fb,
> >                            backing_width, backing_height, backing_id, f=
alse);
> > @@ -88,6 +93,8 @@ static void egl_scanout_dmabuf(DisplayChangeListener =
*dcl,
> >   {
> >       uint32_t width, height, texture;
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       egl_dmabuf_import_texture(dmabuf);
> >       texture =3D qemu_dmabuf_get_texture(dmabuf);
> >       if (!texture) {
> > @@ -108,6 +115,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener=
 *dcl,
> >       uint32_t width, height, texture;
> >       egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       if (dmabuf) {
> >           egl_dmabuf_import_texture(dmabuf);
> >           texture =3D qemu_dmabuf_get_texture(dmabuf);
> > @@ -126,6 +135,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener=
 *dcl,
> >   static void egl_release_dmabuf(DisplayChangeListener *dcl,
> >                                  QemuDmaBuf *dmabuf)
> >   {
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       egl_dmabuf_release_texture(dmabuf);
> >   }
> >
> > @@ -151,6 +162,8 @@ static void egl_scanout_flush(DisplayChangeListener=
 *dcl,
> >       }
> >       assert(surface_format(edpy->ds) =3D=3D PIXMAN_x8r8g8b8);
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       if (edpy->cursor_fb.texture) {
> >           /* have cursor -> render using textures */
> >           egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_fb,
> > @@ -225,6 +238,8 @@ static void egl_headless_init(DisplayState *ds, Dis=
playOptions *opts)
> >
> >       egl_dpys =3D g_ptr_array_new();
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       for (idx =3D 0;; idx++) {
> >           DisplayGLCtx *ctx;
> >
> > @@ -250,6 +265,8 @@ static void egl_headless_cleanup(void)
> >           return;
> >       }
> >
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       for (guint i =3D 0; i < egl_dpys->len; i++) {
> >           egl_dpy *edpy =3D g_ptr_array_index(egl_dpys, i);
> >
> > diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> > index 8623181336e9..d595916476d9 100644
> > --- a/ui/gtk-egl.c
> > +++ b/ui/gtk-egl.c
> > @@ -426,6 +426,18 @@ void gtk_egl_init(DisplayGLMode mode)
> >       display_opengl =3D 1;
> >   }
> >
> > +void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
> > +                           QemuDmaBuf *dmabuf)
> > +{
> > +#ifdef CONFIG_GBM
> > +    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> > +
> > +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> > +                   vc->gfx.esurface, vc->gfx.ectx);
> > +    gd_release_dmabuf(vc, dmabuf);
> > +#endif
> > +}
> > +
> >   int gd_egl_make_current(DisplayGLCtx *dgc,
> >                           QEMUGLContext ctx)
> >   {
> > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > index 45c0c8c81a11..effd88f28721 100644
> > --- a/ui/gtk-gl-area.c
> > +++ b/ui/gtk-gl-area.c
> > @@ -360,6 +360,17 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListen=
er *dcl,
> >   #endif
> >   }
> >
> > +void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
> > +                               QemuDmaBuf *dmabuf)
> > +{
> > +#ifdef CONFIG_GBM
> > +    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> > +
> > +    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> > +    gd_release_dmabuf(vc, dmabuf);
> > +#endif
> > +}
> > +
> >   void gtk_gl_area_init(void)
> >   {
> >       display_opengl =3D 1;
> > diff --git a/ui/gtk.c b/ui/gtk.c
> > index 55e45e8445bc..c615d35451b6 100644
> > --- a/ui/gtk.c
> > +++ b/ui/gtk.c
> > @@ -584,21 +584,16 @@ static bool gd_has_dmabuf(DisplayChangeListener *=
dcl)
> >       return vc->gfx.has_dmabuf;
> >   }
> >
> > -static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
> > -                                 QemuDmaBuf *dmabuf)
> > -{
> >   #ifdef CONFIG_GBM
> > -    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> > -
> > +void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf)
> > +{
> >       egl_dmabuf_release_texture(dmabuf);
> >       if (vc->gfx.guest_fb.dmabuf =3D=3D dmabuf) {
> >           vc->gfx.guest_fb.dmabuf =3D NULL;
> >           vc->gfx.draw_submitted =3D false;
> >       }
> > -#endif
> >   }
> >
> > -#ifdef CONFIG_GBM
> >   static void gd_gl_fence_cb(void *vcon)
> >   {
> >       VirtualConsole *vc =3D vcon;
> > @@ -639,7 +634,7 @@ static const DisplayChangeListenerOps dcl_gl_area_o=
ps =3D {
> >       .dpy_gl_scanout_disable  =3D gd_gl_area_scanout_disable,
> >       .dpy_gl_update           =3D gd_gl_area_scanout_flush,
> >       .dpy_gl_scanout_dmabuf   =3D gd_gl_area_scanout_dmabuf,
> > -    .dpy_gl_release_dmabuf   =3D gd_gl_release_dmabuf,
> > +    .dpy_gl_release_dmabuf   =3D gd_gl_area_release_dmabuf,
> >       .dpy_has_dmabuf          =3D gd_has_dmabuf,
> >   };
> >
> > @@ -673,7 +668,7 @@ static const DisplayChangeListenerOps dcl_egl_ops =
=3D {
> >       .dpy_gl_cursor_dmabuf    =3D gd_egl_cursor_dmabuf,
> >       .dpy_gl_cursor_position  =3D gd_egl_cursor_position,
> >       .dpy_gl_update           =3D gd_egl_flush,
> > -    .dpy_gl_release_dmabuf   =3D gd_gl_release_dmabuf,
> > +    .dpy_gl_release_dmabuf   =3D gd_egl_release_dmabuf,
> >       .dpy_has_dmabuf          =3D gd_has_dmabuf,
> >   };
> >
> > diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> > index 46eff768c968..f41fc8bb9634 100644
> > --- a/ui/sdl2-gl.c
> > +++ b/ui/sdl2-gl.c
> > @@ -200,6 +200,7 @@ void sdl2_gl_scanout_disable(DisplayChangeListener =
*dcl)
> >       struct sdl2_console *scon =3D container_of(dcl, struct sdl2_conso=
le, dcl);
> >
> >       assert(scon->opengl);
> > +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> >       scon->w =3D 0;
> >       scon->h =3D 0;
> >       sdl2_set_scanout_mode(scon, false);
> > @@ -288,6 +289,7 @@ void sdl2_gl_release_dmabuf(DisplayChangeListener *=
dcl,
> >   {
> >       struct sdl2_console *scon =3D container_of(dcl, struct sdl2_conso=
le, dcl);
> >
> > +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> >       egl_dmabuf_release_texture(dmabuf);
> >       if (scon->guest_fb.dmabuf =3D=3D dmabuf) {
> >           scon->guest_fb.dmabuf =3D NULL;
> > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > index 75c7df7bb5e0..22cd1e266caa 100644
> > --- a/ui/spice-display.c
> > +++ b/ui/spice-display.c
> > @@ -1176,6 +1176,8 @@ static void qemu_spice_gl_release_dmabuf(DisplayC=
hangeListener *dcl,
> >           ssd->guest_dmabuf =3D NULL;
> >           ssd->guest_dmabuf_refresh =3D false;
> >       }
> > +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> > +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >       egl_dmabuf_release_texture(dmabuf);
> >   }
> >
> >
>
>

