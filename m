Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E1CCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeF9-0003PA-0i; Thu, 11 Jun 2026 08:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXeF6-0003Ok-Tf
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:10:40 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wXeF5-0000uC-2g
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:10:40 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso3681177eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781179837; cv=none;
 d=google.com; s=arc-20240605;
 b=D0FvZOrqIqezVNghXMf/WZ+h5y6PZBqRUzBqA2j16HnjAOcwLGMBEbWwFz7Z9RYnsk
 ScGTClKTzNgvySFD/cgb6NcZaqugS7da0WNr8hLiepu4AbzAhK8jM8rdIII0OVsa9ztV
 N3mwygaog/PrXP+MXueWpT2ote0wNoQbJRk5Hhu/nwKykJsqFIn0IBJkf8UkVBkckD1I
 JZtSVugmOom0Y3cnZTWWDagQRAVMsTj40mzoKxFmuuvFcz2ChAbjk1Jjr8j4rewLgkXN
 be5c6LLsS5K7CoAjD8yL5VbWaRBR6RnWuklYzq7xttJIXMa14lDlNo8umSVI2DHwuK8u
 yGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yEHPNMUtuJVFhsfZw0PGpQB8RdCznX2EEXKGdRKxTP4=;
 fh=Klr0oso4nYcLYZzLj8DXUbfDse3EWGslCrZOPoSTp1k=;
 b=FdVzNPbH32Af89sGXWGKfEkae3wEDCV/SyNrRtrjqUsPmKQP+h36l9n1aZ0Px8UTWy
 lDMRUy6FGWjkLupljlgniOp/13W9eS1xeN63W5qCm29AFgUxfb5B/oYgTxcq1uw1PZ20
 MuqktmIeOIEJBgCdxJIr+ptSbX80FztPKZpNpxw4hwkPnDjvj+M3gEKzX/hw+XtxjMPQ
 CNab7gBW2J43KbHeemo0WXMidqc/qF4XUuUv2sd1pSzs4354PkqPZB9LDQfxop1bwJIw
 8ELJpPycw+eHW3zsypfktIqYGzeWnmBXEMreeIIiUIJQ9m08kcPE7B+xfTHnBsBMx90w
 L9Cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781179837; x=1781784637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEHPNMUtuJVFhsfZw0PGpQB8RdCznX2EEXKGdRKxTP4=;
 b=pquZyI7DtoJLcKHv+Ux6d6hTXlwM5ZmT2HXAx7eOgDCQGIal3aVmIi4qEn4bxF/ri6
 wFMSJDDRsiKMfG4VZVkwIjixgCZcQOnPBUpYu8f/8iVz2dlvr6rm2RlEAXynCeyYBqdk
 hm3/yR2sKzagGO4rU7mQtakM0UJQlDsU+UbwVO/6lnOUfrZ56sLn5aDDM2wIAuTgl7nq
 M5pEUFhuBOuaS/4ZHIyIs0s+L8IA4OGT5+uzhJEDP6V+iacgWVeq8652pMz/2ijo5MPu
 b/us4cTCammQ2XGwHmFUddg+PU1E4MCyRo916LYbPpavEV9hsd/F15imz7skS/ktlts7
 0Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781179837; x=1781784637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yEHPNMUtuJVFhsfZw0PGpQB8RdCznX2EEXKGdRKxTP4=;
 b=bvLRJnbu693CafDx2O1MsdSjhBx1IXB/FZB55XGZfcAERaMwbhTKIo7ln4NF+qGFD5
 y1sRnfhFAzV8Mr6PqrMpNtom5HpqrMZ/6TuOzwscBIrQvmsBdjnVuaje332ZcI9512nT
 7OE/KJ/fc1vAI7C1HpFvGPtRugO7fCA1e+7SD0m15ewn435w5mj1PySyejCDYIYxkNEz
 VXTMcukSPX4QrSfmcg8seZUUy07I0Ee4tZqASZwcZAgZwoY4kygHcOX9agM0Ef5nguDE
 nft/lSVpPDsQqQiJNLjpYD13SBBt4jitBRO8gUrPAdrRAu7D94CjoQOfdmjmmhEUtC86
 vmkg==
X-Gm-Message-State: AOJu0YzZE2/tEZnhBctUpGXwKHdNZwkXov4e/x7l0OhNxt9NoR381smE
 ykysJFvML12wSl1AjjvoR9h1uoqlaS7ePp9VTMvj+Kmm2GXTpNENaeDmbVAlkMFo8ebJgMG7BJy
 wJ1ektxN+k1IHkAKbfOrMZmrmznwp4XY=
X-Gm-Gg: Acq92OHUPSxu6gm+83PxDM3kmpzk+4hcglaNt5UccMGdSmYahPQyi4M7uDI0sQOOcCx
 HPMP5mB34P7VjcekbJtMhYPBMujYLCsIKXVM7VR/rHD7MiOjdaic7JfEpeRBB2/inLy0MxZbE32
 90qXRFC1TqwQirOoHzLEppsKFMQuhZwkWF8GwhbxEgymRFypZSAf6zMzWXsXKEmfhiWtvNiKQN6
 InzhdOJjXR9TcgftobnIwoIqSdJKvrm2ky3Zm0EIlPtAoUHSHImzjeGk7zJuu4FflhLRDsDj602
 E3XtfPlnuD4F4Wz8zf//KOOOi/T1/cCn3rnk1IBbKYMGPwidxg==
X-Received: by 2002:a05:7300:3b07:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-3080464d07bmr2042695eec.8.1781179837103; Thu, 11 Jun 2026
 05:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 16:10:24 +0400
X-Gm-Features: AVVi8CeKktUtG17zkQ_sDczcJ1uN6ZntoJuZlpWgGNef4bldB48X-Fg4-i4orcc
Message-ID: <CAJ+F1CKF+89hT57ekdhQutecCteH4Z1Sbd16Hgwj+0Q26Sfqpw@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Explicitly specify EGL platform
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alexander Kanavin <alex.kanavin@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
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

On Thu, Jun 11, 2026 at 4:00=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Mesa's eglGetDisplay() chooses the native EGL platform from
> EGL_PLATFORM, limited autodetection, or the build-time default. If that
> selects Wayland while SDL is using the X11 video backend, Mesa can treat
> the X11 Display pointer as a wl_display and crash during eglInitialize().
>
> Probe EGL with the X11 platform explicitly before enabling
> SDL_HINT_VIDEO_X11_FORCE_EGL.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3540
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Resolving the issue described in the GitLab work item also requires:
> https://github.com/libsdl-org/SDL/pull/15806
> ---
>  include/ui/egl-helpers.h | 5 +++++
>  ui/egl-helpers.c         | 4 ++--
>  ui/sdl2.c                | 3 ++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index acf993fcf52f..c97a0d5c248f 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -61,6 +61,11 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
>
>  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowTyp=
e win);
>
> +#if defined(CONFIG_X11) || defined(CONFIG_GBM) || defined(WIN32)
> +EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
> +                                EGLenum platform);
> +#endif
> +
>  #if defined(CONFIG_X11) || defined(CONFIG_GBM)
>
>  int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode);
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index e3f2872cc14b..069a52495541 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -520,8 +520,8 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx,=
 EGLNativeWindowType win)
>   * platform extensions (EGL_KHR_platform_gbm and friends) yet it doesn't=
 seem
>   * like mesa will be able to advertise these (even though it can do EGL =
1.5).
>   */
> -static EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
> -                                       EGLenum platform)
> +EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
> +                                EGLenum platform)
>  {
>      EGLDisplay dpy =3D EGL_NO_DISPLAY;
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 4fcdbd79d3c0..ce14bd1f4e15 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -862,7 +862,8 @@ static void sdl2_set_hint_x11_force_egl(void)
>      }
>
>      /* Prefer EGL over GLX to get dma-buf support. */
> -    egl_display =3D eglGetDisplay((EGLNativeDisplayType)x_disp);
> +    egl_display =3D qemu_egl_get_display((EGLNativeDisplayType)x_disp,
> +                                       EGL_PLATFORM_X11_KHR);
>
>      if (egl_display !=3D EGL_NO_DISPLAY) {
>          /*
>
> ---
> base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
> change-id: 20260611-sdl-a148cd469727
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>

