Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C5EB365D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 03:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxGm8-0007cw-Fs; Mon, 02 Mar 2026 22:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxGm6-0007cf-Oy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 22:50:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxGm4-00033H-Hk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 22:50:22 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6233nh6x037586
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 12:49:47 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=t12vpf5BydF6dZQ1OJ4FfNQstBfbjttaXn2PVWYVUfQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772509788; v=1;
 b=iLQgQ+Vj1WwTuzWvhBQNcUA1tHwd/qCYgDs5VPDcQ6sLUxX8dGxhBCx46JdAl3Dg
 JA7OP0zlwiMmM67PfAXpvT1IQV/jInHyegz+U8D6M8SHoMwtQd1Xk2z5xV0Lw/er
 bULX1uB4lpUOvAoDmjylJk12bDI51tg7Lw0ap29Z17c0oBZ8XGIHFe1jP9Vy7OaC
 MDzqiMAozPuMFtK2ysWL4Had7Y4Wmr7nhXd+E7AsgjZGGswErvzPf8MEOGG1GQon
 8LT6V+5VI+0PFgnXCnTPFQmTz5s+5iPnuFhITpFmN631Ig/pDkxthI64B9YJs6Lu
 ZgyKAo+gMJZrtkH1FaMF6w==
Message-ID: <88f3150c-277d-403c-8a64-0d91d61980be@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Mar 2026 12:49:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 03/18] ui/egl: Don't change bound GL context when
 creating new context
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
 <20260302145920.735423-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260302145920.735423-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
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

On 2026/03/02 23:59, Dmitry Osipenko wrote:
> Don't change bound GL context when creating new GL context for consistency
> with behavior expected by virglrenderer that assumes context-creation doesn't
> switch context. eglCreateContext() doesn't require GL context to be bound
> when it's invoked. Update qemu_egl_create_context() to spawn GL sub-contexts
> from a common parent GL context instead of a currently-bound context.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   ui/dbus.c          | 2 --
>   ui/egl-context.c   | 3 +--
>   ui/egl-headless.c  | 2 --
>   ui/gtk-egl.c       | 4 ----
>   ui/spice-display.c | 2 --
>   5 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/ui/dbus.c b/ui/dbus.c
> index 905ee6fea71b..750a064e3fbf 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -47,8 +47,6 @@ static DBusDisplay *dbus_display;
>   static QEMUGLContext dbus_create_context(DisplayGLCtx *dgc,
>                                            QEMUGLParams *params)
>   {
> -    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
> -                   qemu_egl_rn_ctx);
>       return qemu_egl_create_context(dgc, params);
>   }
>   
> diff --git a/ui/egl-context.c b/ui/egl-context.c
> index aed3e3ba1f3f..f9a998768beb 100644
> --- a/ui/egl-context.c
> +++ b/ui/egl-context.c
> @@ -19,8 +19,7 @@ QEMUGLContext qemu_egl_create_context(DisplayGLCtx *dgc,
>      };
>      bool gles = (qemu_egl_mode == DISPLAY_GL_MODE_ES);
>   
> -   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
> -                          eglGetCurrentContext(),
> +   ctx = eglCreateContext(qemu_egl_display, qemu_egl_config, qemu_egl_rn_ctx,
>                             gles ? ctx_att_gles : ctx_att_core);
>      return ctx;
>   }
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> index 1f6b845500dd..19955792ac95 100644
> --- a/ui/egl-headless.c
> +++ b/ui/egl-headless.c
> @@ -42,8 +42,6 @@ static void egl_gfx_switch(DisplayChangeListener *dcl,
>   static QEMUGLContext egl_create_context(DisplayGLCtx *dgc,
>                                           QEMUGLParams *params)
>   {
> -    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
> -                   qemu_egl_rn_ctx);
>       return qemu_egl_create_context(dgc, params);
>   }
>   
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 0dbb429958e5..6b3519419039 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -217,10 +217,6 @@ void gd_egl_switch(DisplayChangeListener *dcl,
>   QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
>                                       QEMUGLParams *params)
>   {
> -    VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
> -
> -    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
> -                   vc->gfx.esurface, vc->gfx.ectx);

This uses vc->gfx.ectx instead of qemu_egl_rn_ctx so it should be passed 
to qemu_egl_create_context().

Regards,
Akihiko Odaki

>       return qemu_egl_create_context(dgc, params);
>   }
>   
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 28399f8a8174..ae0f771c2a38 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1033,8 +1033,6 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
>   static QEMUGLContext qemu_spice_gl_create_context(DisplayGLCtx *dgc,
>                                                     QEMUGLParams *params)
>   {
> -    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
> -                   qemu_egl_rn_ctx);
>       return qemu_egl_create_context(dgc, params);
>   }
>   


