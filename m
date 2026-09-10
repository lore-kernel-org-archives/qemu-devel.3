Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6A5C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4diQ-0005MR-9s; Thu, 10 Sep 2026 08:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4diK-0005Lv-1r
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:17:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4diF-0006a0-C2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:17:11 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68ACGkjY089488
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 10 Sep 2026 21:16:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vkVO1hgPfTF61feoQfx/tGd8Nh8MCGBwMQqRuZlX24A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789042606; v=1;
 b=ar2ypFi6N+KPNmXgbXjhIlj52RtVj5xV1Uv839EGlyGkzrFu6Q4VEwiunwzVwnOw
 invMqy/su+57hNshrnnu5+BOZvSgnjWz9uQi1FK49ZlasTv6wc3O0L+TRcC8a5Ak
 gviPVQS2X5HfGPFpob11JCIHItPj2pqqz3LtS0JMg5YsulB7mO/H9700DquRCkdh
 +IQUwjnttRv4T+/2sswBiMqu8st24HFiimRZoUoqmYsUibItNQ9nWD5AhJYD/Qu3
 7WMr/g0+e7b8TdG5oFVZpIPE+x1LrBEsae+ao1w8nkklUwELeUsqVtqPHMkxJPO2
 o1masmBbGwd9TF3M8G8UbQ==
Message-ID: <04932327-9f83-4993-9525-67e57a8037e4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 10 Sep 2026 21:16:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/24] ui: make GL context current in display backend
 callbacks
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
 <20260910-virtio-gpu-cleanup-v4-13-7d623714bd71@redhat.com>
 <c9424c1b-9e00-4be0-9796-b98f9d4c5050@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1CJ7SF4h5D6hreoBDZ3k3gob037S0QXRr4w_mpXvP3ft5w@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1CJ7SF4h5D6hreoBDZ3k3gob037S0QXRr4w_mpXvP3ft5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/09/10 20:36, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Sep 10, 2026 at 2:55 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/09/10 17:17, Marc-André Lureau wrote:
>>> Display backend GL callbacks (scanout, flush, release, etc.) may be
>>> invoked from a different GL context, like virgl. Since framebuffer
>>> objects are per-context and textures require a valid context for
>>> deletion, each callback must ensure the correct context is active before
>>> performing GL operations.
>>>
>>> Make each backend's own GL context current at the entry of every
>>> callback that performs GL work.
>>>
>>> For GTK, the previously shared gd_gl_release_dmabuf is split into
>>> backend-specific gd_egl_release_dmabuf and gd_gl_area_release_dmabuf,
>>> matching the existing pattern where each backend manages its own
>>> context.
>>>
>>> On the virgl side, restore ctx0 with virgl_renderer_force_ctx_0()
>>> after SET_SCANOUT, RESOURCE_FLUSH, and SET_SCANOUT_BLOB command
>>> handlers, since their display callbacks may have changed the current
>>> GL context.
> 
> Ok, it sounds like we need to save/restore context at each callback
> for now. Later on we should try to change the code to avoid that dance
> and defer it. Right?

We rather need to let callbacks make the UI context current instead of 
keeping the virgl context current to wait for the UI to finish 
processing those commands.

But now I have a second thought: actually the situation is way more 
complicated because theoretically one resource flush can update multiple 
scanouts with different contexts, not just one context. Using the last 
UI context for fence creation does not solve that problem.

Making the virgl context current will ensure predictable behavior at 
least. Fence will not work with those commands properly, but it is just 
yet another silent long-standing bug.

So this patch should have:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> 
> 
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/display/virtio-gpu-virgl.c |  4 ++++
>>>    include/ui/gtk.h              |  5 +++++
>>>    ui/egl-headless.c             | 17 +++++++++++++++++
>>>    ui/gtk-egl.c                  | 12 ++++++++++++
>>>    ui/gtk-gl-area.c              | 11 +++++++++++
>>>    ui/gtk.c                      | 13 ++++---------
>>>    ui/sdl2-gl.c                  |  2 ++
>>>    ui/spice-display.c            |  2 ++
>>>    8 files changed, 57 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index 7f1d1e0c3276..0e43eacca406 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -1091,9 +1091,12 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>>            break;
>>>        case VIRTIO_GPU_CMD_SET_SCANOUT:
>>>            virgl_cmd_set_scanout(g, cmd);
>>> +        /* Display callbacks may change the current GL context. */
>>> +        virgl_renderer_force_ctx_0();
>>>            break;
>>>        case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
>>>            virgl_cmd_resource_flush(g, cmd);
>>> +        virgl_renderer_force_ctx_0();
>>>            break;
>>>        case VIRTIO_GPU_CMD_RESOURCE_UNREF:
>>>            virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
>>> @@ -1130,6 +1133,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>>>            break;
>>>        case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
>>>            virgl_cmd_set_scanout_blob(g, cmd);
>>> +        virgl_renderer_force_ctx_0();
>>
>> I doubt that adding these virgl_renderer_force_ctx_0() calls is correct
>> here. Since scanout and resource flush actually happen in the UI
>> context, we actually need to use the UI context to fence those operations.
>>
>> Regards,
>> Akihiko Odaki
>>>            break;
>>>    #endif
>>>        default:
>>> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
>>> index b66b9ca5c519..6b62e9758813 100644
>>> --- a/include/ui/gtk.h
>>> +++ b/include/ui/gtk.h
>>> @@ -163,6 +163,7 @@ extern bool gtk_use_gl_area;
>>>    void gd_update_windowsize(VirtualConsole *vc);
>>>    void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget);
>>>    void gd_gl_wait_sync(VirtualConsole *vc, void *sync);
>>> +void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf);
>>>
>>>    /* ui/gtk-egl.c */
>>>    void gd_egl_init(VirtualConsole *vc);
>>> @@ -190,6 +191,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
>>>                              uint32_t hot_x, uint32_t hot_y);
>>>    void gd_egl_cursor_position(DisplayChangeListener *dcl,
>>>                                uint32_t pos_x, uint32_t pos_y);
>>> +void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
>>> +                           QemuDmaBuf *dmabuf);
>>>    void gd_egl_flush(DisplayChangeListener *dcl,
>>>                      uint32_t x, uint32_t y, uint32_t w, uint32_t h);
>>>    void *gd_egl_scanout_flush(DisplayChangeListener *dcl,
>>> @@ -221,6 +224,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>>>                                    uint32_t x, uint32_t y,
>>>                                    uint32_t w, uint32_t h,
>>>                                    void *d3d_tex2d);
>>> +void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
>>> +                               QemuDmaBuf *dmabuf);
>>>    void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
>>>    void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>>>                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h);
>>> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
>>> index ba27efcf4c3e..c3f319c0960b 100644
>>> --- a/ui/egl-headless.c
>>> +++ b/ui/egl-headless.c
>>> @@ -52,6 +52,8 @@ static void egl_scanout_disable(DisplayChangeListener *dcl)
>>>    {
>>>        egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        egl_fb_destroy(&edpy->guest_fb);
>>>        egl_fb_destroy(&edpy->blit_fb);
>>>    }
>>> @@ -69,6 +71,9 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
>>>
>>>        edpy->y_0_top = backing_y_0_top;
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>> +
>>>        /* source framebuffer */
>>>        egl_fb_setup_for_tex(&edpy->guest_fb,
>>>                             backing_width, backing_height, backing_id, false);
>>> @@ -88,6 +93,8 @@ static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
>>>    {
>>>        uint32_t width, height, texture;
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        egl_dmabuf_import_texture(dmabuf);
>>>        texture = qemu_dmabuf_get_texture(dmabuf);
>>>        if (!texture) {
>>> @@ -108,6 +115,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
>>>        uint32_t width, height, texture;
>>>        egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        if (dmabuf) {
>>>            egl_dmabuf_import_texture(dmabuf);
>>>            texture = qemu_dmabuf_get_texture(dmabuf);
>>> @@ -126,6 +135,8 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
>>>    static void egl_release_dmabuf(DisplayChangeListener *dcl,
>>>                                   QemuDmaBuf *dmabuf)
>>>    {
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        egl_dmabuf_release_texture(dmabuf);
>>>    }
>>>
>>> @@ -151,6 +162,8 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
>>>        }
>>>        assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        if (edpy->cursor_fb.texture) {
>>>            /* have cursor -> render using textures */
>>>            egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_fb,
>>> @@ -225,6 +238,8 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
>>>
>>>        egl_dpys = g_ptr_array_new();
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        for (idx = 0;; idx++) {
>>>            DisplayGLCtx *ctx;
>>>
>>> @@ -250,6 +265,8 @@ static void egl_headless_cleanup(void)
>>>            return;
>>>        }
>>>
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        for (guint i = 0; i < egl_dpys->len; i++) {
>>>            egl_dpy *edpy = g_ptr_array_index(egl_dpys, i);
>>>
>>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>>> index 8623181336e9..d595916476d9 100644
>>> --- a/ui/gtk-egl.c
>>> +++ b/ui/gtk-egl.c
>>> @@ -426,6 +426,18 @@ void gtk_egl_init(DisplayGLMode mode)
>>>        display_opengl = 1;
>>>    }
>>>
>>> +void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
>>> +                           QemuDmaBuf *dmabuf)
>>> +{
>>> +#ifdef CONFIG_GBM
>>> +    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>>> +
>>> +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>>> +                   vc->gfx.esurface, vc->gfx.ectx);
>>> +    gd_release_dmabuf(vc, dmabuf);
>>> +#endif
>>> +}
>>> +
>>>    int gd_egl_make_current(DisplayGLCtx *dgc,
>>>                            QEMUGLContext ctx)
>>>    {
>>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>>> index 45c0c8c81a11..effd88f28721 100644
>>> --- a/ui/gtk-gl-area.c
>>> +++ b/ui/gtk-gl-area.c
>>> @@ -360,6 +360,17 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>>>    #endif
>>>    }
>>>
>>> +void gd_gl_area_release_dmabuf(DisplayChangeListener *dcl,
>>> +                               QemuDmaBuf *dmabuf)
>>> +{
>>> +#ifdef CONFIG_GBM
>>> +    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>>> +
>>> +    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>>> +    gd_release_dmabuf(vc, dmabuf);
>>> +#endif
>>> +}
>>> +
>>>    void gtk_gl_area_init(void)
>>>    {
>>>        display_opengl = 1;
>>> diff --git a/ui/gtk.c b/ui/gtk.c
>>> index 55e45e8445bc..c615d35451b6 100644
>>> --- a/ui/gtk.c
>>> +++ b/ui/gtk.c
>>> @@ -584,21 +584,16 @@ static bool gd_has_dmabuf(DisplayChangeListener *dcl)
>>>        return vc->gfx.has_dmabuf;
>>>    }
>>>
>>> -static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
>>> -                                 QemuDmaBuf *dmabuf)
>>> -{
>>>    #ifdef CONFIG_GBM
>>> -    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>>> -
>>> +void gd_release_dmabuf(VirtualConsole *vc, QemuDmaBuf *dmabuf)
>>> +{
>>>        egl_dmabuf_release_texture(dmabuf);
>>>        if (vc->gfx.guest_fb.dmabuf == dmabuf) {
>>>            vc->gfx.guest_fb.dmabuf = NULL;
>>>            vc->gfx.draw_submitted = false;
>>>        }
>>> -#endif
>>>    }
>>>
>>> -#ifdef CONFIG_GBM
>>>    static void gd_gl_fence_cb(void *vcon)
>>>    {
>>>        VirtualConsole *vc = vcon;
>>> @@ -639,7 +634,7 @@ static const DisplayChangeListenerOps dcl_gl_area_ops = {
>>>        .dpy_gl_scanout_disable  = gd_gl_area_scanout_disable,
>>>        .dpy_gl_update           = gd_gl_area_scanout_flush,
>>>        .dpy_gl_scanout_dmabuf   = gd_gl_area_scanout_dmabuf,
>>> -    .dpy_gl_release_dmabuf   = gd_gl_release_dmabuf,
>>> +    .dpy_gl_release_dmabuf   = gd_gl_area_release_dmabuf,
>>>        .dpy_has_dmabuf          = gd_has_dmabuf,
>>>    };
>>>
>>> @@ -673,7 +668,7 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
>>>        .dpy_gl_cursor_dmabuf    = gd_egl_cursor_dmabuf,
>>>        .dpy_gl_cursor_position  = gd_egl_cursor_position,
>>>        .dpy_gl_update           = gd_egl_flush,
>>> -    .dpy_gl_release_dmabuf   = gd_gl_release_dmabuf,
>>> +    .dpy_gl_release_dmabuf   = gd_egl_release_dmabuf,
>>>        .dpy_has_dmabuf          = gd_has_dmabuf,
>>>    };
>>>
>>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>>> index 46eff768c968..f41fc8bb9634 100644
>>> --- a/ui/sdl2-gl.c
>>> +++ b/ui/sdl2-gl.c
>>> @@ -200,6 +200,7 @@ void sdl2_gl_scanout_disable(DisplayChangeListener *dcl)
>>>        struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>>>
>>>        assert(scon->opengl);
>>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>>        scon->w = 0;
>>>        scon->h = 0;
>>>        sdl2_set_scanout_mode(scon, false);
>>> @@ -288,6 +289,7 @@ void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
>>>    {
>>>        struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>>>
>>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>>        egl_dmabuf_release_texture(dmabuf);
>>>        if (scon->guest_fb.dmabuf == dmabuf) {
>>>            scon->guest_fb.dmabuf = NULL;
>>> diff --git a/ui/spice-display.c b/ui/spice-display.c
>>> index 75c7df7bb5e0..22cd1e266caa 100644
>>> --- a/ui/spice-display.c
>>> +++ b/ui/spice-display.c
>>> @@ -1176,6 +1176,8 @@ static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
>>>            ssd->guest_dmabuf = NULL;
>>>            ssd->guest_dmabuf_refresh = false;
>>>        }
>>> +    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
>>> +                   EGL_NO_SURFACE, qemu_egl_rn_ctx);
>>>        egl_dmabuf_release_texture(dmabuf);
>>>    }
>>>
>>>
>>
>>


