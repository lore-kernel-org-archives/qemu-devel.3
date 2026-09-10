Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF6EC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dmF-0006B8-Sj; Thu, 10 Sep 2026 08:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4dmE-0006At-HN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:21:14 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x4dmC-0007iG-5E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:21:14 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ee4399c3abso7065890a34.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 05:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789042870; cv=none;
 d=google.com; s=arc-20260327;
 b=iosxU7xq9hCdpZXv2Kz2syDwpb+9/eH4yPBitX9csJIZiHRDlEU42XBs/vCb20gIur
 uUcZ2WSUNw4M3BB++CD4PSJ6Bz7qJ6q9MLNTpMpWaypv59vQwjOYjZAYaFIouThTEfhv
 17umsRthKkBUbOtLncC/8lMrCWgLf99jqqrL/yH6AxB+JfqymiV3irX8Zy54MoEve6W3
 w+Mg8hUeh0TSEVG7lW4iTwPNAurZyrb5sBJI/hSj7OYY8F8881lpN//W8QxmmZsZ3OuA
 3uBwqnAVDoLSxsaI19YY+9GBBPRzX/i9rLjcJ7Mk15CmyAll0f+1JPmr2yuSrXH8k8fF
 +NhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LXPY2Vq+nrUNJUEpwUKtkhAw33Cs0jgbs3YeQMyvbks=;
 fh=HLSuPskybtIIysCDrrCUGCclYLaEEdtpVmqnrjAgGtQ=;
 b=AVy8kA36Umgo9vi9RujAaJp/ngV7CFipyBbhV2q0OhDKPAkDIcccBlFS0QRiOS/K/B
 x2YmPxnJb5P+n8eL09B7mWD8+OlF+pyqK/77txa8Uoak4KF7iIacudRbyReoZfJotlFO
 bEwH9DMbqul2wybXeHVRALGYyFUQVBCx+d57x3L/kcDNa79jaWJ05R4u7pZ0V82lTQC3
 xaXDPmPM9b27aQr318pBu6cseUgdjZLbLmsmNIK6KpjAMcSY1ZLL63lv6nXKaD6ZtOjk
 r6cihjGiJAGfsQr07y66DOzSHVfq183g9Kjn1L7et+DbOfDq2mUceWO0e8lbcDme6mvL
 JoNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789042870; x=1789647670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LXPY2Vq+nrUNJUEpwUKtkhAw33Cs0jgbs3YeQMyvbks=;
 b=G2VByQjncjZhDOIJfFo96NuDP/zm53FAYyhWgg0MRU7uKU/1Yu3nn6B1JNg00PB657
 vvH+ST8AdUhmGys8By7nL7wrCXfamKeqyPrAKQBCfYWTsb6MDNla8Rw1nCkcO6iOiw0Y
 eU4O5554sxSEFATXLMRYNDPLaeNUlhrZrWQLhOjzo48HYrEdo4jL/Ub5kAN/JjSOb4Ym
 aXAV/fJvT+cQyVLOZm/z0/KrJHyFDcouEhjj+kB52n4mV8MPHoVug59/Ztq0kGxqV4Gz
 Znke8i9vqVzwUgbsGOl8RCpP/41LYfxkr88t/VlbFBcJrTgNt2XaJ8Vr3xfYLwRgvI23
 G1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789042870; x=1789647670;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LXPY2Vq+nrUNJUEpwUKtkhAw33Cs0jgbs3YeQMyvbks=;
 b=OD7LTnvQ1IZLP34FLeSWWlEnlk3zDsU7Yu1UrnyRsCOt+yJWT+UZmvDfuDDqcs1Tz4
 AMq6u+utsy5RzGkpNP9EIhO4l7fyRKL6etaCStDKwa4UiwkVtSz2oX9B6L7piGegMmTU
 P6JEhKEjNOMceaZ6BavGeoJLM9z/f4K2FeJt0/tfwciXURhfUaGxv/hDKhNDL1D8pvos
 qrN/Ya9sBaxxBDifYAvtIGms1/nEmi2I6LObdiXpL4j1pOKcP2TdnNfTkR9xLLiKkvw9
 HIE82dp7TtwGVKAKjUoTGpz9DZkrXuYWFwigUr6KOQWkoNuuM21WHQuXEFN3rjN/ij1q
 j2kw==
X-Gm-Message-State: AFuF++lEkcyxdYDaKv6yL7AWa2ZhvYKW2zD+aFbfWdkItGcPuZiqdrtO
 sG1XqaiY6Al3FY+Id2eFMBjo2w+JFQbltAloPzX7aX4h4UlxhW58BmRQlbxIwqLI2HkEu6vEZ5V
 S6rh23jKcpOn5v08DuZ8L56QD31I/g8w=
X-Gm-Gg: AYBFou1dHLz7AB0aqKDWIYVEGRImG8GkA46yvGGfgZ57p7vSh4zVX98OYybe7F00DNd
 CanZCXoPoDk9x/bSKHz5wkjDo2/XfmWCriYME8byul1XLa/CZOTtlHTDq0MzVgXC/58b7cs4xDA
 tEURqbVu7VUpS5T/Q+u4hUvxbJx+faTuDxmpuvCVT01vs9elD0q6KVTWkwdHK+K72K3JP5QulzO
 5j/MhXfPOI8h/ix7XBhBYCUa8LUB8uidxtcfGf3tkBq/zx4bogS7XTo2OCmFms0Je2LC1hY+j0i
 Dk4E06Q4F7G5BTIvfuDlCytoY5hKR1Br6VmDL2d0Jkpx5LfF1qN28rlCGvjFDHqXBESsxoXPyYu
 eigykawz8xho=
X-Received: by 2002:a05:6820:560b:b0:6ba:3635:800f with SMTP id
 006d021491bc7-6ba36359ff2mr8770338eaf.69.1789042869899; Thu, 10 Sep 2026
 05:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
 <20260910-virtio-gpu-cleanup-v4-13-7d623714bd71@redhat.com>
 <c9424c1b-9e00-4be0-9796-b98f9d4c5050@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1CJ7SF4h5D6hreoBDZ3k3gob037S0QXRr4w_mpXvP3ft5w@mail.gmail.com>
 <04932327-9f83-4993-9525-67e57a8037e4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <04932327-9f83-4993-9525-67e57a8037e4@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 16:20:57 +0400
X-Gm-Features: AcwNN1VlXFfKH3z5SaqCpoVH0nyQ8LSvKCS_ZUO5uunOIe8k_yumJ4gXCIVIw_M
Message-ID: <CAJ+F1CLiWRrH=hQYSN0LKuu1dYzjda_ydWsJGDZO+d1wwC0gJg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x332.google.com
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

On Thu, Sep 10, 2026 at 4:18=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/09/10 20:36, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Sep 10, 2026 at 2:55=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2026/09/10 17:17, Marc-Andr=C3=A9 Lureau wrote:
> >>> Display backend GL callbacks (scanout, flush, release, etc.) may be
> >>> invoked from a different GL context, like virgl. Since framebuffer
> >>> objects are per-context and textures require a valid context for
> >>> deletion, each callback must ensure the correct context is active bef=
ore
> >>> performing GL operations.
> >>>
> >>> Make each backend's own GL context current at the entry of every
> >>> callback that performs GL work.
> >>>
> >>> For GTK, the previously shared gd_gl_release_dmabuf is split into
> >>> backend-specific gd_egl_release_dmabuf and gd_gl_area_release_dmabuf,
> >>> matching the existing pattern where each backend manages its own
> >>> context.
> >>>
> >>> On the virgl side, restore ctx0 with virgl_renderer_force_ctx_0()
> >>> after SET_SCANOUT, RESOURCE_FLUSH, and SET_SCANOUT_BLOB command
> >>> handlers, since their display callbacks may have changed the current
> >>> GL context.
> >
> > Ok, it sounds like we need to save/restore context at each callback
> > for now. Later on we should try to change the code to avoid that dance
> > and defer it. Right?
>
> We rather need to let callbacks make the UI context current instead of
> keeping the virgl context current to wait for the UI to finish
> processing those commands.
>
> But now I have a second thought: actually the situation is way more
> complicated because theoretically one resource flush can update multiple
> scanouts with different contexts, not just one context. Using the last
> UI context for fence creation does not solve that problem.
>
> Making the virgl context current will ensure predictable behavior at
> least. Fence will not work with those commands properly, but it is just
> yet another silent long-standing bug.
>
> So this patch should have:
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Ok, I assume I can send a PR and I can count on you for a quick follow up ?
thanks!

>
> Regards,
> Akihiko Odaki
>
> >
> >
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>    hw/display/virtio-gpu-virgl.c |  4 ++++
> >>>    include/ui/gtk.h              |  5 +++++
> >>>    ui/egl-headless.c             | 17 +++++++++++++++++
> >>>    ui/gtk-egl.c                  | 12 ++++++++++++
> >>>    ui/gtk-gl-area.c              | 11 +++++++++++
> >>>    ui/gtk.c                      | 13 ++++---------
> >>>    ui/sdl2-gl.c                  |  2 ++
> >>>    ui/spice-display.c            |  2 ++
> >>>    8 files changed, 57 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-vi=
rgl.c
> >>> index 7f1d1e0c3276..0e43eacca406 100644
> >>> --- a/hw/display/virtio-gpu-virgl.c
> >>> +++ b/hw/display/virtio-gpu-virgl.c
> >>> @@ -1091,9 +1091,12 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g=
,
> >>>            break;
> >>>        case VIRTIO_GPU_CMD_SET_SCANOUT:
> >>>            virgl_cmd_set_scanout(g, cmd);
> >>> +        /* Display callbacks may change the current GL context. */
> >>> +        virgl_renderer_force_ctx_0();
> >>>            break;
> >>>        case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> >>>            virgl_cmd_resource_flush(g, cmd);
> >>> +        virgl_renderer_force_ctx_0();
> >>>            break;
> >>>        case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> >>>            virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
> >>> @@ -1130,6 +1133,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> >>>            break;
> >>>        case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
> >>>            virgl_cmd_set_scanout_blob(g, cmd);
> >>> +        virgl_renderer_force_ctx_0();
> >>
> >> I doubt that adding these virgl_renderer_force_ctx_0() calls is correc=
t
> >> here. Since scanout and resource flush actually happen in the UI
> >> context, we actually need to use the UI context to fence those operati=
ons.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>>            break;
> >>>    #endif
> >>>        default:
> >>> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> >>> index b66b9ca5c519..6b62e9758813 100644
> >>> --- a/include/ui/gtk.h
> >>> +++ b/include/ui/gtk.h
> >>> @@ -163,6 +163,7 @@ extern bool gtk_use_gl_area;
> >>>    void gd_update_windowsize(VirtualConsole *vc);
> >>>    void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget =
*widget);
> >>>    void gd_gl_wait_sync(VirtualConsole *vc, void *sync);
> >>> +void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf);
> >>>
> >>>    /* ui/gtk-egl.c */
> >>>    void gd_egl_init(VirtualConsole *vc);
> >>> @@ -190,6 +191,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *=
dcl,
> >>>                              uint32_t hot_x, uint32_t hot_y);
> >>>    void gd_egl_cursor_position(DisplayChangeListener *dcl,
> >>>                                uint32_t pos_x, uint32_t pos_y);
> >>> +void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
> >>> +                           QemuDmaBuf *dmabuf);
> >>>    void gd_egl_flush(DisplayChangeListener *dcl,
> >>>                      uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> >>>    void *gd_egl_scanout_flush(DisplayChangeListener *dcl,
> >>> @@ -221,6 +224,8 @@ void gd_gl_area_scanout_texture(DisplayChangeList=
ener *dcl,
> >>>                                    uint32_t x, uint32_t y,
> >>>                                    uint32_t w, uint32_t h,
> >>>                                    void *d3d_tex2d);
> >>> +void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
> >>> +                               QemuDmaBuf *dmabuf);
> >>>    void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
> >>>    void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
> >>>                                  uint32_t x, uint32_t y, uint32_t w, =
uint32_t h);
> >>> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> >>> index ba27efcf4c3e..c3f319c0960b 100644
> >>> --- a/ui/egl-headless.c
> >>> +++ b/ui/egl-headless.c
> >>> @@ -52,6 +52,8 @@ static void egl_scanout_disable(DisplayChangeListen=
er *dcl)
> >>>    {
> >>>        egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        egl_fb_destroy(&edpy->guest_fb);
> >>>        egl_fb_destroy(&edpy->blit_fb);
> >>>    }
> >>> @@ -69,6 +71,9 @@ static void egl_scanout_texture(DisplayChangeListen=
er *dcl,
> >>>
> >>>        edpy->y_0_top =3D backing_y_0_top;
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>> +
> >>>        /* source framebuffer */
> >>>        egl_fb_setup_for_tex(&edpy->guest_fb,
> >>>                             backing_width, backing_height, backing_id=
, false);
> >>> @@ -88,6 +93,8 @@ static void egl_scanout_dmabuf(DisplayChangeListene=
r *dcl,
> >>>    {
> >>>        uint32_t width, height, texture;
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        egl_dmabuf_import_texture(dmabuf);
> >>>        texture =3D qemu_dmabuf_get_texture(dmabuf);
> >>>        if (!texture) {
> >>> @@ -108,6 +115,8 @@ static void egl_cursor_dmabuf(DisplayChangeListen=
er *dcl,
> >>>        uint32_t width, height, texture;
> >>>        egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        if (dmabuf) {
> >>>            egl_dmabuf_import_texture(dmabuf);
> >>>            texture =3D qemu_dmabuf_get_texture(dmabuf);
> >>> @@ -126,6 +135,8 @@ static void egl_cursor_dmabuf(DisplayChangeListen=
er *dcl,
> >>>    static void egl_release_dmabuf(DisplayChangeListener *dcl,
> >>>                                   QemuDmaBuf *dmabuf)
> >>>    {
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        egl_dmabuf_release_texture(dmabuf);
> >>>    }
> >>>
> >>> @@ -151,6 +162,8 @@ static void egl_scanout_flush(DisplayChangeListen=
er *dcl,
> >>>        }
> >>>        assert(surface_format(edpy->ds) =3D=3D PIXMAN_x8r8g8b8);
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        if (edpy->cursor_fb.texture) {
> >>>            /* have cursor -> render using textures */
> >>>            egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_f=
b,
> >>> @@ -225,6 +238,8 @@ static void egl_headless_init(DisplayState *ds, D=
isplayOptions *opts)
> >>>
> >>>        egl_dpys =3D g_ptr_array_new();
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        for (idx =3D 0;; idx++) {
> >>>            DisplayGLCtx *ctx;
> >>>
> >>> @@ -250,6 +265,8 @@ static void egl_headless_cleanup(void)
> >>>            return;
> >>>        }
> >>>
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        for (guint i =3D 0; i < egl_dpys->len; i++) {
> >>>            egl_dpy *edpy =3D g_ptr_array_index(egl_dpys, i);
> >>>
> >>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> >>> index 8623181336e9..d595916476d9 100644
> >>> --- a/ui/gtk-egl.c
> >>> +++ b/ui/gtk-egl.c
> >>> @@ -426,6 +426,18 @@ void gtk_egl_init(DisplayGLMode mode)
> >>>        display_opengl =3D 1;
> >>>    }
> >>>
> >>> +void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
> >>> +                           QemuDmaBuf *dmabuf)
> >>> +{
> >>> +#ifdef CONFIG_GBM
> >>> +    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> >>> +
> >>> +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> >>> +                   vc->gfx.esurface, vc->gfx.ectx);
> >>> +    gd_release_dmabuf(vc, dmabuf);
> >>> +#endif
> >>> +}
> >>> +
> >>>    int gd_egl_make_current(DisplayGLCtx *dgc,
> >>>                            QEMUGLContext ctx)
> >>>    {
> >>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> >>> index 45c0c8c81a11..effd88f28721 100644
> >>> --- a/ui/gtk-gl-area.c
> >>> +++ b/ui/gtk-gl-area.c
> >>> @@ -360,6 +360,17 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeList=
ener *dcl,
> >>>    #endif
> >>>    }
> >>>
> >>> +void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
> >>> +                               QemuDmaBuf *dmabuf)
> >>> +{
> >>> +#ifdef CONFIG_GBM
> >>> +    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> >>> +
> >>> +    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
> >>> +    gd_release_dmabuf(vc, dmabuf);
> >>> +#endif
> >>> +}
> >>> +
> >>>    void gtk_gl_area_init(void)
> >>>    {
> >>>        display_opengl =3D 1;
> >>> diff --git a/ui/gtk.c b/ui/gtk.c
> >>> index 55e45e8445bc..c615d35451b6 100644
> >>> --- a/ui/gtk.c
> >>> +++ b/ui/gtk.c
> >>> @@ -584,21 +584,16 @@ static bool gd_has_dmabuf(DisplayChangeListener=
 *dcl)
> >>>        return vc->gfx.has_dmabuf;
> >>>    }
> >>>
> >>> -static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
> >>> -                                 QemuDmaBuf *dmabuf)
> >>> -{
> >>>    #ifdef CONFIG_GBM
> >>> -    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl=
);
> >>> -
> >>> +void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf)
> >>> +{
> >>>        egl_dmabuf_release_texture(dmabuf);
> >>>        if (vc->gfx.guest_fb.dmabuf =3D=3D dmabuf) {
> >>>            vc->gfx.guest_fb.dmabuf =3D NULL;
> >>>            vc->gfx.draw_submitted =3D false;
> >>>        }
> >>> -#endif
> >>>    }
> >>>
> >>> -#ifdef CONFIG_GBM
> >>>    static void gd_gl_fence_cb(void *vcon)
> >>>    {
> >>>        VirtualConsole *vc =3D vcon;
> >>> @@ -639,7 +634,7 @@ static const DisplayChangeListenerOps dcl_gl_area=
_ops =3D {
> >>>        .dpy_gl_scanout_disable  =3D gd_gl_area_scanout_disable,
> >>>        .dpy_gl_update           =3D gd_gl_area_scanout_flush,
> >>>        .dpy_gl_scanout_dmabuf   =3D gd_gl_area_scanout_dmabuf,
> >>> -    .dpy_gl_release_dmabuf   =3D gd_gl_release_dmabuf,
> >>> +    .dpy_gl_release_dmabuf   =3D gd_gl_area_release_dmabuf,
> >>>        .dpy_has_dmabuf          =3D gd_has_dmabuf,
> >>>    };
> >>>
> >>> @@ -673,7 +668,7 @@ static const DisplayChangeListenerOps dcl_egl_ops=
 =3D {
> >>>        .dpy_gl_cursor_dmabuf    =3D gd_egl_cursor_dmabuf,
> >>>        .dpy_gl_cursor_position  =3D gd_egl_cursor_position,
> >>>        .dpy_gl_update           =3D gd_egl_flush,
> >>> -    .dpy_gl_release_dmabuf   =3D gd_gl_release_dmabuf,
> >>> +    .dpy_gl_release_dmabuf   =3D gd_egl_release_dmabuf,
> >>>        .dpy_has_dmabuf          =3D gd_has_dmabuf,
> >>>    };
> >>>
> >>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> >>> index 46eff768c968..f41fc8bb9634 100644
> >>> --- a/ui/sdl2-gl.c
> >>> +++ b/ui/sdl2-gl.c
> >>> @@ -200,6 +200,7 @@ void sdl2_gl_scanout_disable(DisplayChangeListene=
r *dcl)
> >>>        struct sdl2_console *scon =3D container_of(dcl, struct sdl2_co=
nsole, dcl);
> >>>
> >>>        assert(scon->opengl);
> >>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> >>>        scon->w =3D 0;
> >>>        scon->h =3D 0;
> >>>        sdl2_set_scanout_mode(scon, false);
> >>> @@ -288,6 +289,7 @@ void sdl2_gl_release_dmabuf(DisplayChangeListener=
 *dcl,
> >>>    {
> >>>        struct sdl2_console *scon =3D container_of(dcl, struct sdl2_co=
nsole, dcl);
> >>>
> >>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> >>>        egl_dmabuf_release_texture(dmabuf);
> >>>        if (scon->guest_fb.dmabuf =3D=3D dmabuf) {
> >>>            scon->guest_fb.dmabuf =3D NULL;
> >>> diff --git a/ui/spice-display.c b/ui/spice-display.c
> >>> index 75c7df7bb5e0..22cd1e266caa 100644
> >>> --- a/ui/spice-display.c
> >>> +++ b/ui/spice-display.c
> >>> @@ -1176,6 +1176,8 @@ static void qemu_spice_gl_release_dmabuf(Displa=
yChangeListener *dcl,
> >>>            ssd->guest_dmabuf =3D NULL;
> >>>            ssd->guest_dmabuf_refresh =3D false;
> >>>        }
> >>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
> >>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
> >>>        egl_dmabuf_release_texture(dmabuf);
> >>>    }
> >>>
> >>>
> >>
> >>
>
>

