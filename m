Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B53D3C549
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 05:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1fS3-00066y-9O; Fri, 18 Oct 2024 01:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1fS1-00066V-8G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 01:23:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1fRz-00074e-5Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 01:23:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cb89a4e4cso12223105ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729228977; x=1729833777;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bgI5l4SwGV7obPPim0dYwKQ7q4Oi0kthTyD1lt9oHkA=;
 b=qiM/QoVQ0r02NJJLo4vIdeOIAHFt7Ff/URlGuXCX3t8SLuTnr6jqaQrK1InrKmTbJx
 e3B/hWF8/XE334gL8sDdXmCELNEAVogJ9fUVCgxrwrFIgktwOyLvQJPbcNvQA53SrP1M
 isvLiKvB9PHHWfK9+wqJGh2PrPs12tORtVSHEs+TvlsX8eHccHvfHPOpWvxlNBD3aD7L
 xidUOO+Wc9usFcRPy+Ro3cE67uscqWsLA6OfzCGQrKzG3zHhZndGJmW8tt9g7yfWsPCd
 XRrmJinLDRT2Q3ouMvQ7FygdUfu30tvWca/fxYWrYvBFrif/Ki/df01VDUET85ptmFw+
 onyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729228977; x=1729833777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bgI5l4SwGV7obPPim0dYwKQ7q4Oi0kthTyD1lt9oHkA=;
 b=CIRSqSgQGk6m/d8JufcxvqEw6DQO/aB/64F3dvS4piZAV6WTC+xJvCNvK4G3IepSJh
 tEFJqQ+FPALSHAouGobzygioBn+EIwY4NzUa2CwvbWBqgdYUBIhjOvt40AYgxX39TrKj
 L5kUv3B/iBAYztZrerhM4EAqIm1jwh7EGoyn3iofFbdeai7JERu3q2mZE2NiqMLxYT+C
 HlTWekc2ZveNiopFdAjelWo+dVM/mZijITRpuBI+pe8HHy3WHyYvk1cxICdVkk4kvfBa
 o88aJDjVSsN4TiZ76xRrYtQqoEqE2l0gXUCg6qQtCNHoZtQnYar/e43p6Cw6vGuKQdMj
 PR9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCpRiteE2N5f6pPbh2Jw7d52ZDh6DPQvs7ftQA432qXTTzv4BpV9/tBVJHwifSApOffc/nqK7lm4DQ@nongnu.org
X-Gm-Message-State: AOJu0Yz4rxJJBzzhH/hd1uJLpuHcCOHKQSIqLhUTekm+oQSVn0s2dPDW
 oxl5Vaexi0RlFDB+qH8cTIHny0+1gX8E0L89xtnp+iOEICrkztvF7lNmXzRVWbI=
X-Google-Smtp-Source: AGHT+IH0UwDaXM18+txyRRj6WHUuEhOrMfq+2kJf31HWBaY7U5G05nQuw+u/EaEEQMbF+bel+44bzA==
X-Received: by 2002:a17:902:d510:b0:20c:8839:c517 with SMTP id
 d9443c01a7336-20e5a928cb1mr14387175ad.53.1729228977448; 
 Thu, 17 Oct 2024 22:22:57 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8d7408sm5003595ad.155.2024.10.17.22.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 22:22:57 -0700 (PDT)
Message-ID: <e2c0584f-c8da-4cdd-932d-a87ee2cd838f@daynix.com>
Date: Fri, 18 Oct 2024 14:22:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ui/sdl2: Implement dpy dmabuf functions
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
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-3-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241015043238.114034-3-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

On 2024/10/15 13:32, Dmitry Osipenko wrote:
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
>   ui/sdl2-gl.c      | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>   ui/sdl2.c         | 31 +++++++++++++++++++++++
>   3 files changed, 101 insertions(+)
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
> index bd4f5a9da14a..607181071b84 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -120,6 +120,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>           /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
>           scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
>       }
> +
> +    qemu_egl_display = eglGetCurrentDisplay();
> +
>       sdl_update_caption(scon);
>   }
>   
> @@ -820,6 +823,10 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
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
> @@ -847,6 +854,28 @@ static void sdl2_display_early_init(DisplayOptions *o)
>       }
>   }
>   
> +static void sdl2_set_hint_x11_force_egl(void)
> +{
> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(EGL_KHR_platform_x11)

EGL_KHR_platform_x11 is always defined when CONFIG_OPENGL is defined.
Check CONFIG_OPENGL for the availability of EGL APIs.

> +    Display *x_disp = XOpenDisplay(NULL);

The availability of Xlib must be checked.

> +    EGLDisplay egl_display;
> +
> +    if (!x_disp) {
> +        return;
> +    }
> +
> +    /* Prefer EGL over GLX to get dma-buf support. */
> +    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
 > +> +    if (egl_display != EGL_NO_DISPLAY) {
> +        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");

SDL may not be going to use X11 but may use e.g., Wayland.

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
> @@ -877,6 +906,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>       SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>   #endif
>       SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
> +    sdl2_set_hint_x11_force_egl();
>       SDL_EnableScreenSaver();
>       memset(&info, 0, sizeof(info));
>       SDL_VERSION(&info.version);
> @@ -923,6 +953,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>           sdl2_console[i].kbd = qkbd_state_init(con);
>           if (display_opengl) {
>               qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> +            sdl2_gl_console_init(&sdl2_console[i]);
>           }
>           register_displaychangelistener(&sdl2_console[i].dcl);
>   


