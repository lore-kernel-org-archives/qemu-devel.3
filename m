Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27D8E68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6PfK-0007Nn-TZ; Thu, 31 Oct 2024 03:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PfG-0007NG-06
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:32:18 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PfC-0001YR-Qf
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:32:17 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so524284a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730359931; x=1730964731;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aj/IPCOsnzxh3s5z5laJzNHbJXPyvKPzkUpfpb88ooo=;
 b=0B3rN0TW0x6hyFc7uxjJSEArOlilzw8vj4YInkNAmhdBypaoq9QjTx33v4dIV5YJFw
 afKUBYbD4fYt+vrcxq9bx/prWrWWRpIh0cTIkIcdJ7KbFN63EPzSInjjWSkipZ8CObGe
 PfjRr8dzLlhP9SJs5+dkIf76lnsh7r1fg7jhOtgVL7JkmhvqjFrc2u/guWqUtqACTmJC
 2VEeHTwnl8nJ36xSpElTzJfaPRIgmYqoX0PxbDadw9EZP0jWtWqe/vUds9x1MMtmUpEh
 cp/DeO8GE6iRviowi5kzpJfSlrZnSxXWu3HHPrKm3WmNhMGfp3IffrAYzFNj0IEdeKgN
 c/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730359931; x=1730964731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aj/IPCOsnzxh3s5z5laJzNHbJXPyvKPzkUpfpb88ooo=;
 b=VtoXS4+afCVBDK3g56pulp6EuiN7mA+HnGL0bOZqhcL4SxGzgv3OAV3NybydfnjwI2
 6O0U7gOo4cilFa9QnaiZ2j8RT+3zp4jTJyod8/nJkkQRFBst6vSOphrWwddj+ttMLmaT
 /FaYLlZnKooKY6PsGg91jaZCHdWqpeb3e1IpxN1MXDeXI0UJgeOEV9hztBdP1nQ3jZ9A
 bTm3mD9gbi34v+VVm6+0EGgSF2/4bRSnjr5vHGG1cVZdOUQczV9Fv5RDsxgv0zvEmI0R
 M9yZf7niPLGdD69JnPMVA0Rvi/DpCUISSIs0hNLdZfsS1HhHQ3LUzW08zLEnGpZNEWSa
 +Tjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVr/G4Ce9Coe5TeGWt9kIBqHmDS13ze1Ah5PGqQHjrRPqKjAhTnbcj09EScf9P6if4ysU0th4u/ra@nongnu.org
X-Gm-Message-State: AOJu0Yz2c0r3MoBQ4ng2yw4Jjaw/c3AnwZ+/zy39CGv9UydDgDaSsLVU
 f/z8h5YwGpvLkleLtJmBqjy2VuFLYCT5dnapNfBp1QTg4TZGRW/BH1KIJI+wyaM=
X-Google-Smtp-Source: AGHT+IFSKcjtE2E+vmWL+Wfbmg+NvztE3XzrrXPhA6by/hmXWJa+poi3XjSp+R6SyzfO8j3NDr2b0Q==
X-Received: by 2002:a05:6300:4043:b0:1d9:3bfd:4a0d with SMTP id
 adf61e73a8af0-1d9a850b5a5mr20142128637.50.1730359931440; 
 Thu, 31 Oct 2024 00:32:11 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2c3da0sm659887b3a.135.2024.10.31.00.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 00:32:11 -0700 (PDT)
Message-ID: <d800f856-cdf4-4573-8fd6-6a8e1434090a@daynix.com>
Date: Thu, 31 Oct 2024 16:32:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ui/sdl2: Implement dpy dmabuf functions
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-3-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241024233355.136867-3-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/25 8:33, Dmitry Osipenko wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> If EGL is used, we can rely on dmabuf to import textures without
> doing copies.
> 
> To get this working on X11, we use the existing SDL hint:
> SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   include/ui/sdl2.h |  7 ++++++
>   meson.build       |  4 +++
>   ui/sdl2-gl.c      | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>   ui/sdl2.c         | 40 ++++++++++++++++++++++++++++++
>   4 files changed, 114 insertions(+)
> 
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d9739b..9daf5ecffae7 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -45,6 +45,7 @@ struct sdl2_console {
>       bool gui_keysym;
>       SDL_GLContext winctx;
>       QKbdState *kbd;
> +    bool has_dmabuf;
>   #ifdef CONFIG_OPENGL
>       QemuGLShader *gls;
>       egl_fb guest_fb;
> @@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>                                void *d3d_tex2d);
>   void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                              uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf);
> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
> +void sdl2_gl_console_init(struct sdl2_console *scon);
>   
>   #endif /* SDL2_H */
> diff --git a/meson.build b/meson.build
> index 089cbd2bb364..1ace2bfa0ebe 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1531,6 +1531,9 @@ else
>     sdl_image = not_found
>   endif
>   
> +# libx11 presents together with SDL or GTK libs on systems that support X11
> +xlib = dependency('x11', required: false)

There is a line saying:
x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())

Please reuse it.

> +
>   rbd = not_found
>   if not get_option('rbd').auto() or have_block
>     librados = cc.find_library('rados', required: get_option('rbd'))
> @@ -2397,6 +2400,7 @@ config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
>   config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>   config_host_data.set('CONFIG_SDL', sdl.found())
>   config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> +config_host_data.set('CONFIG_XLIB', xlib.found())
>   config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>   if seccomp.found()
>     config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index b1fe96d6af22..7612af18292c 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -26,6 +26,8 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>   #include "ui/console.h"
>   #include "ui/input.h"
>   #include "ui/sdl2.h"
> @@ -249,3 +251,64 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>   
>       SDL_GL_SwapWindow(scon->real_window);
>   }
> +
> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                            QemuDmaBuf *dmabuf)
> +{
> +    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
> +
> +    assert(scon->opengl);
> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
> +
> +    egl_dmabuf_import_texture(dmabuf);
> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
> +        error_report("%s: failed fd=%d", __func__, qemu_dmabuf_get_fd(dmabuf));

It still continues to call sdl2_gl_scanout_texture() and I doubt that's 
what you meant.

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
> index bd4f5a9da14a..5a1e5940c66a 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -35,6 +35,10 @@
>   #include "ui/win32-kbd-hook.h"
>   #include "qemu/log.h"
>   
> +#ifdef CONFIG_XLIB
> +#include <X11/Xlib.h>
> +#endif
> +
>   static int sdl2_num_outputs;
>   static struct sdl2_console *sdl2_console;
>   
> @@ -120,6 +124,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>           /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
>           scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
>       }
> +
> +    qemu_egl_display = eglGetCurrentDisplay();
> +
>       sdl_update_caption(scon);
>   }
>   
> @@ -820,6 +827,10 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
>       .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
>       .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
>       .dpy_gl_update           = sdl2_gl_scanout_flush,
> +
> +    .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
> +    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
> +    .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
>   };
>   
>   static bool
> @@ -847,6 +858,33 @@ static void sdl2_display_early_init(DisplayOptions *o)
>       }
>   }
>   
> +static void sdl2_set_hint_x11_force_egl(void)
> +{
> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
> +    defined(CONFIG_XLIB)
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
> +         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer 11 over

s/prefer 11 over/prefer X11 over/

Personally, I'm more concerned whether setting that hint will make an 
invalid argument error or something.

> +         * Wayland. I.e. SDL will use Wayland driver even if XWayland presents.
> +         */
> +        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
> +        eglTerminate(egl_display);
> +    }
> +
> +    XCloseDisplay(x_disp);
> +#endif
> +}
> +
>   static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>   {
>       uint8_t data = 0;
> @@ -877,6 +915,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>       SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>   #endif
>       SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    sdl2_set_hint_x11_force_egl();
>       SDL_EnableScreenSaver();
>       memset(&info, 0, sizeof(info));
>       SDL_VERSION(&info.version);
> @@ -923,6 +962,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>           sdl2_console[i].kbd = qkbd_state_init(con);
>           if (display_opengl) {
>               qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> +            sdl2_gl_console_init(&sdl2_console[i]);
>           }
>           register_displaychangelistener(&sdl2_console[i].dcl);
>   


