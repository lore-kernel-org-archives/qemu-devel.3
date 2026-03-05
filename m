Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711CF3093A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6ru-0001h3-96; Thu, 05 Mar 2026 06:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vy6rs-0001gp-MF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:27:48 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vy6rq-0001lo-Oy
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:27:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772710048; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gU2YG+sMBgYVDxzwMk5RYRtkz1vIa8Q7foBw6eTLETXFZRyas2USss8A5YkcAB1h+DWQr/fgn2N6vh1gJTVCMjZI2dtAPP9xubEgp1vtCZZn2dYsotOR5Av6IB8pzri9KCV++FQxEO3PT+TNUtpt8SfqLLex1sEdtkgJ80fA8b4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772710048;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fnETLW+SC3pidVom1ZNtOllb6o+zv/mM5xor2jTL/mM=; 
 b=HYyOZYZcahw2UmWrqyR9nv3Iu8/oiDRv6qUe7tB5F2h6/NsegcGuKT7WoWkTc9sdcW/A692vJNkFS0nPdbszh7fpvmhrKwm/DaAV07hYo9oRgoeMVoF7cULKLSmbY/jS23MHBNsQjlzwWU8VijxCJlesqFL2JcffAXbvSYgCcTM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772710048; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=fnETLW+SC3pidVom1ZNtOllb6o+zv/mM5xor2jTL/mM=;
 b=Jho/OwZpPw/IpyAc3pm1ddZP5OuzdqCqh0eEx2jt7QSNMJloGCgcUpqBZuYnVW0S
 /uc9cMZvujXmfgdfGn5qeFJhe3zT38DZJXlkxyl4Jl2rsoh52gsvhNwZafrrThfegf9
 Brg//ULdNt7uWqzxD0p9lsEOxARKsMOcBDTNKk4o=
Received: by mx.zohomail.com with SMTPS id 17727100436659.43354919566832;
 Thu, 5 Mar 2026 03:27:23 -0800 (PST)
Message-ID: <66259f6a-5e7b-4686-912b-7393e28252e2@collabora.com>
Date: Thu, 5 Mar 2026 14:27:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] ui/sdl2: Implement dpy dmabuf functions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Yiwei Zhang <zzyiwei@gmail.com>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
 <20260304165043.1437519-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260304165043.1437519-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/4/26 19:50, Alex Bennée wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> If EGL is used, we can rely on dmabuf to import textures without
> doing copies.
> 
> To get this working on X11, we use the existing SDL hint:
> SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).
> 
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Message-ID: <20260303151422.977399-7-dmitry.osipenko@collabora.com>
> [AJB: ifdef CONFIG_OPENGL/CONFIG_GBM for non-linux hosts]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  meson.build       |  6 ++---
>  include/ui/sdl2.h |  7 +++++
>  ui/sdl2-gl.c      | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>  ui/sdl2.c         | 48 +++++++++++++++++++++++++++++++++
>  4 files changed, 125 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index df841e12e24..e623f398be9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1946,10 +1946,8 @@ if get_option('gtk') \
>    endif
>  endif
>  
> -x11 = not_found
> -if gtkx11.found()
> -  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
> -endif
> +x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
> +
>  png = not_found
>  if get_option('png').allowed() and have_system
>     png = dependency('libpng', version: '>=1.6.34', required: get_option('png'),
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d9739..9daf5ecffae 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -45,6 +45,7 @@ struct sdl2_console {
>      bool gui_keysym;
>      SDL_GLContext winctx;
>      QKbdState *kbd;
> +    bool has_dmabuf;
>  #ifdef CONFIG_OPENGL
>      QemuGLShader *gls;
>      egl_fb guest_fb;
> @@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>                               void *d3d_tex2d);
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
> +void sdl2_gl_console_init(struct sdl2_console *scon);
>  
>  #endif /* SDL2_H */
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index fbac3edbc09..bb066cdd885 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -26,6 +26,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
>  #include "ui/sdl2.h"
> @@ -250,3 +252,69 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>  
>      SDL_GL_SwapWindow(scon->real_window);
>  }
> +
> +#ifdef CONFIG_GBM
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
> +    const int *fds;
> +
> +    assert(scon->opengl);
> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> +
> +    egl_dmabuf_import_texture(dmabuf);
> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
> +        fds = qemu_dmabuf_get_fds(dmabuf, NULL);
> +        error_report("%s: failed fd=%d", __func__, fds ? fds[0] : -1);
> +        return;
> +    }
> +
> +    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), false,
> +                            qemu_dmabuf_get_width(dmabuf),
> +                            qemu_dmabuf_get_height(dmabuf),
> +                            0, 0,
> +                            qemu_dmabuf_get_width(dmabuf),
> +                            qemu_dmabuf_get_height(dmabuf),
> +                            NULL);
> +
> +    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
> +        scon->guest_fb.dmabuf = dmabuf;
> +    }
> +}
> +
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    egl_dmabuf_release_texture(dmabuf);
> +}
> +
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
> +{
> +    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
> +
> +    return scon->has_dmabuf;
> +}
> +#endif
> +
> +void sdl2_gl_console_init(struct sdl2_console *scon)
> +{
> +    bool hidden = scon->hidden;
> +
> +    scon->hidden = true;
> +    scon->surface = qemu_create_displaysurface(1, 1);
> +    sdl2_window_create(scon);
> +
> +    /*
> +     * QEMU checks whether console supports dma-buf before switching
> +     * to the console.  To break this chicken-egg problem we pre-check
> +     * dma-buf availability beforehand using a dummy SDL window.
> +     */
> +    scon->has_dmabuf = qemu_egl_has_dmabuf();
> +
> +    sdl2_window_destroy(scon);
> +    qemu_free_displaysurface(scon->surface);
> +
> +    scon->surface = NULL;
> +    scon->hidden = hidden;
> +}
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 032dc14bc39..aaaede56e0e 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -35,6 +35,10 @@
>  #include "qemu/log.h"
>  #include "qemu-main.h"
>  
> +#ifdef CONFIG_X11
> +#include <X11/Xlib.h>
> +#endif
> +
>  static int sdl2_num_outputs;
>  static struct sdl2_console *sdl2_console;
>  
> @@ -120,6 +124,11 @@ void sdl2_window_create(struct sdl2_console *scon)
>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
>          scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
>      }
> +
> +#ifdef CONFIG_OPENGL
> +    qemu_egl_display = eglGetCurrentDisplay();
> +#endif
> +
>      sdl_update_caption(scon);
>  }
>  
> @@ -808,6 +817,12 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
>      .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
>      .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
>      .dpy_gl_update           = sdl2_gl_scanout_flush,
> +
> +#ifdef CONFIG_GBM
> +    .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
> +    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
> +    .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
> +#endif
>  };
>  
>  static bool
> @@ -835,6 +850,35 @@ static void sdl2_display_early_init(DisplayOptions *o)
>      }
>  }
>  
> +static void sdl2_set_hint_x11_force_egl(void)
> +{
> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
> +    defined(CONFIG_X11)
> +    Display *x_disp = XOpenDisplay(NULL);
> +    EGLDisplay egl_display;
> +
> +    if (!x_disp) {
> +        return;
> +    }
> +
> +    /* Prefer EGL over GLX to get dma-buf support. */
> +    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
> +
> +    if (egl_display != EGL_NO_DISPLAY) {
> +        /*
> +         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer X11 over
> +         * Wayland. SDL will use Wayland driver even if XWayland presents.
> +         * It's always safe to set the hint even if X11 is not used by SDL.
> +         * SDL will work regardless of the hint.
> +         */
> +        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
> +        eglTerminate(egl_display);
> +    }
> +
> +    XCloseDisplay(x_disp);
> +#endif
> +}
> +
>  static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>  {
>      uint8_t data = 0;
> @@ -862,6 +906,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>      SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>  #endif
>      SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    sdl2_set_hint_x11_force_egl();
>      SDL_EnableScreenSaver();
>      memset(&info, 0, sizeof(info));
>      SDL_VERSION(&info.version);
> @@ -906,9 +951,12 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>  #endif
>          sdl2_console[i].dcl.con = con;
>          sdl2_console[i].kbd = qkbd_state_init(con);
> +#ifdef CONFIG_OPENGL
>          if (display_opengl) {
>              qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> +            sdl2_gl_console_init(&sdl2_console[i]);
>          }
> +#endif
>          register_displaychangelistener(&sdl2_console[i].dcl);
>  
>  #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)

Thanks a lot for adding the ifdefs, all looks good.

-- 
Best regards,
Dmitry

