Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F62EB7EBC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjYS-0003Yk-So; Wed, 04 Mar 2026 05:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxjYR-0003YS-0b
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:34:11 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxjYN-0004Nk-2x
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:34:10 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772620423; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SXktKFHfaXx3raQ5+p4k6TMtWAP3CvHtv8Z5CmxKNaystAIa9eXNiCwJjMG9G25Mb5bQfQmMsfsNAEWOATAA8s4C5KkhpSYZPEpge/I+NNhGFr84sesap4NOcEEKMOiIy2E4GC1yKNMyGQ0ECpTtGg+eJQKHjgEsYGOUKZ9K1TQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772620423;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1F89aWZAu+9+anLlvOy/zQ7CtCwcUpdLnJdLHmwa8CI=; 
 b=ih1Qk49rRvBM8zxHsuyWHvSdUm1wiqCPoPmfXuM1ippgg3kIEXbl19aI0pK9HzcnsaTeV/hzph9Ka6p5UttkF7xsauOyK4rPrPW4YkwwUvJgveyiX70MG3pCprQZJD84NUzyEuocFI/kqILlJ2O/GVdDGFXm4EQJBefEnsF+A/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772620423; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1F89aWZAu+9+anLlvOy/zQ7CtCwcUpdLnJdLHmwa8CI=;
 b=EZ/PTz2LPAKmddrxupZDqDfVGl9FAjyrKp8RWuHvZ8aKlla0wWHG83tRk3ZWN/Jm
 naWucVxu/O/D3TrewbFhTFRLUo3Xa39dr9Uouht3SWSUrRs2Ws2NFEa9P2XMNZMB7BA
 fl4Hh0ELXr5DAhVr+QwQM1z8ongXQJWVfV+7keac=
Received: by mx.zohomail.com with SMTPS id 1772620420837284.77220577561604;
 Wed, 4 Mar 2026 02:33:40 -0800 (PST)
Message-ID: <feff43ef-1618-4a09-aba4-e4e9c2d07e2c@collabora.com>
Date: Wed, 4 Mar 2026 13:33:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 06/18] ui/sdl2: Implement dpy dmabuf functions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <20260303151422.977399-7-dmitry.osipenko@collabora.com>
 <874imwq8rj.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <874imwq8rj.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On 3/4/26 11:49, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> If EGL is used, we can rely on dmabuf to import textures without
>> doing copies.
>>
>> To get this working on X11, we use the existing SDL hint:
>> SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).
>>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  include/ui/sdl2.h |  7 +++++
>>  meson.build       |  6 ++---
>>  ui/sdl2-gl.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>>  ui/sdl2.c         | 42 ++++++++++++++++++++++++++++++
>>  4 files changed, 117 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
>> index dbe6e3d9739b..9daf5ecffae7 100644
>> --- a/include/ui/sdl2.h
>> +++ b/include/ui/sdl2.h
>> @@ -45,6 +45,7 @@ struct sdl2_console {
>>      bool gui_keysym;
>>      SDL_GLContext winctx;
>>      QKbdState *kbd;
>> +    bool has_dmabuf;
>>  #ifdef CONFIG_OPENGL
>>      QemuGLShader *gls;
>>      egl_fb guest_fb;
>> @@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>>                               void *d3d_tex2d);
>>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>>                             uint32_t x, uint32_t y, uint32_t w, uint32_t h);
>> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>> +                            QemuDmaBuf *dmabuf);
>> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
>> +                            QemuDmaBuf *dmabuf);
>> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
>> +void sdl2_gl_console_init(struct sdl2_console *scon);
>>  
>>  #endif /* SDL2_H */
>> diff --git a/meson.build b/meson.build
>> index 3cd1d8dbc669..0ce84d45e6f3 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1937,10 +1937,8 @@ if get_option('gtk') \
>>    endif
>>  endif
>>  
>> -x11 = not_found
>> -if gtkx11.found()
>> -  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
>> -endif
>> +x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
>> +
>>  png = not_found
>>  if get_option('png').allowed() and have_system
>>     png = dependency('libpng', version: '>=1.6.34', required: get_option('png'),
>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>> index fbac3edbc09d..697ba2169c34 100644
>> --- a/ui/sdl2-gl.c
>> +++ b/ui/sdl2-gl.c
>> @@ -26,6 +26,8 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>> +#include "qemu/error-report.h"
>>  #include "ui/console.h"
>>  #include "ui/input.h"
>>  #include "ui/sdl2.h"
>> @@ -250,3 +252,67 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>>  
>>      SDL_GL_SwapWindow(scon->real_window);
>>  }
>> +
>> +void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>> +                            QemuDmaBuf *dmabuf)
>> +{
>> +    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>> +    const int *fds;
>> +
>> +    assert(scon->opengl);
>> +    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>> +
>> +    egl_dmabuf_import_texture(dmabuf);
>> +    if (!qemu_dmabuf_get_texture(dmabuf)) {
>> +        fds = qemu_dmabuf_get_fds(dmabuf, NULL);
>> +        error_report("%s: failed fd=%d", __func__, fds ? fds[0] : -1);
>> +        return;
>> +    }
>> +
>> +    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), false,
>> +                            qemu_dmabuf_get_width(dmabuf),
>> +                            qemu_dmabuf_get_height(dmabuf),
>> +                            0, 0,
>> +                            qemu_dmabuf_get_width(dmabuf),
>> +                            qemu_dmabuf_get_height(dmabuf),
>> +                            NULL);
>> +
>> +    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
>> +        scon->guest_fb.dmabuf = dmabuf;
>> +    }
>> +}
>> +
>> +void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
>> +                            QemuDmaBuf *dmabuf)
>> +{
>> +    egl_dmabuf_release_texture(dmabuf);
>> +}
>> +
>> +bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
>> +{
>> +    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>> +
>> +    return scon->has_dmabuf;
>> +}
>> +
>> +void sdl2_gl_console_init(struct sdl2_console *scon)
>> +{
>> +    bool hidden = scon->hidden;
>> +
>> +    scon->hidden = true;
>> +    scon->surface = qemu_create_displaysurface(1, 1);
>> +    sdl2_window_create(scon);
>> +
>> +    /*
>> +     * QEMU checks whether console supports dma-buf before switching
>> +     * to the console.  To break this chicken-egg problem we pre-check
>> +     * dma-buf availability beforehand using a dummy SDL window.
>> +     */
>> +    scon->has_dmabuf = qemu_egl_has_dmabuf();
>> +
>> +    sdl2_window_destroy(scon);
>> +    qemu_free_displaysurface(scon->surface);
>> +
>> +    scon->surface = NULL;
>> +    scon->hidden = hidden;
>> +}
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index 032dc14bc398..3bb2676f847b 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -35,6 +35,10 @@
>>  #include "qemu/log.h"
>>  #include "qemu-main.h"
>>  
>> +#ifdef CONFIG_X11
>> +#include <X11/Xlib.h>
>> +#endif
>> +
>>  static int sdl2_num_outputs;
>>  static struct sdl2_console *sdl2_console;
>>  
>> @@ -120,6 +124,9 @@ void sdl2_window_create(struct sdl2_console *scon)
>>          /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
>>          scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
>>      }
>> +
>> +    qemu_egl_display = eglGetCurrentDisplay();
>> +
> 
> This fails on MacOS for some reason:
> 
>   o libsystem.a.p/ui_sdl2.c.o -c ../ui/sdl2.c
>   ../ui/sdl2.c:128:5: error: use of undeclared identifier 'qemu_egl_display'
>     128 |     qemu_egl_display = eglGetCurrentDisplay();
>         |     ^
>   ../ui/sdl2.c:128:24: error: call to undeclared function 'eglGetCurrentDisplay'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     128 |     qemu_egl_display = eglGetCurrentDisplay();
>         |                        ^
>   2 errors generated.
> 
> See: https://gitlab.com/stsquad/qemu/-/jobs/13340079105
> 
> Not sure what the include differences are because --enable-sdl builds
> fine on Linux.

Please try with this change and let me know if you could squash it or I
need to send a patch:

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3bb2676f847b..2603b0c2bdd8 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -125,7 +125,9 @@ void sdl2_window_create(struct sdl2_console *scon)
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }

+#ifdef CONFIG_OPENGL
     qemu_egl_display = eglGetCurrentDisplay();
+#endif

     sdl_update_caption(scon);
 }

-- 
Best regards,
Dmitry

