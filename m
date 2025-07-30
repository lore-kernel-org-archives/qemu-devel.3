Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF6CC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7la-0008Ad-0Z; Wed, 30 Jul 2025 10:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uh6Gv-0003we-Ex
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:51:07 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uh6FV-0000Ct-1j
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:51:05 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4aee0eff9ecso7751531cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753879775; x=1754484575; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5x76LSoDA6gHwzv/J0wn8ITp1RNU9WiSDzgev76KDQ8=;
 b=VOVddlw1vZLPBopt3wxWoFCnVUOLuQo2sN9KQ2hG+7lQbwXH4P3dGaT7TzgD+cW0PD
 DlUd7FjeTYpx9klVsa5oRBhjBXFUq4VzRjgLO8JZkOItW8ekN5cUAQd6vyAMewOyq6y5
 ijhfLmCnCbe3hCNZtHGtRICQE07CDppzVdxsS3qg4eak4vZ4i7rcCjWIIP+8VcPzfq6I
 Vc9HOpcEOHWRULEBigPRZfivDcGOH4vpJr90DRQiZ1N8fP5QKN5DU2v89DT5JCfhTt/y
 akqA7RJ3JvOpiWF+8h0A7EpvzYXv4nKUEG0EQPaNRYNY3qnvdzSkRJjMmxLaT+Ii35ry
 r66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753879775; x=1754484575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5x76LSoDA6gHwzv/J0wn8ITp1RNU9WiSDzgev76KDQ8=;
 b=Qask6Ne5PcReXrLiE7fgmHRLesehAia1OznMmUUlokZHEirbLc7hzQdGDSHspk859D
 RlXbGVwE3MPZOO8RrTDwY80vlGgxwWwr/f3yAWHQZuvTCR7nkL8jVbvVcno+Odom3WmV
 0lOCuQsk3GPEmT4EyzVV/fcbgEHw3jUsY2phiOm9HeHckPP1QxsrQPVjTP9T76EexFHc
 OBzHaEQK814s3vkpkI251JwMPVhwGCSWsf6gpmCCBnkAT63deXAhSY51sR144MSjZjUw
 XugO7om15ppJs1XKaQd/GrBpuzZvwpkUP4XVCq7ZXzgARTFS7Z1es80L53zKhmB1nSqV
 KlgQ==
X-Gm-Message-State: AOJu0Yx+adMoWI//klx4hTjdjV7X+xGRsh0AJZGM7B+guMoKXwxH8qM6
 YkTvzpUbx1mUlu8pw1xz6TFLhuWkfSfJwA6tVtmdLXfsmby5DdiwWRibqcB7TZe4ImlMz+n9ej+
 e1kdaPB75YkxonRM2DLgn2/s5a2EC5jbdF60b4gD4VQ==
X-Gm-Gg: ASbGncsu1N7SHZpeWhnxVja6xPTtbM1l4AS9aCbK0lC9+r4um8M6aQZ//iYVTxVmjgm
 MgouLEa3BfwAN49YsigyRpv4l6RH3Y+KbZ3vvOph4sVzPRcUFf/E0u0dANEit/QdU2R5pFoRHIZ
 riQQUTcOcCSYk0CvIKzwTHpdZGDXJ4XoMJfMxlQyzbTtJg84L9D+QCmP4JbwNwhXr6I3R5Crw52
 EugG0Q+paXp/M1XypSVHgyYrgmUt+wMMCzSoYXP
X-Google-Smtp-Source: AGHT+IGd6JjzuLXY1KA7ttNjYY81bbMSn0eLFzHdIB/1sbxRmEDeLfE2zPnAY4VFJA36Vy/HAZhwX3v7Cw/f538wZ78=
X-Received: by 2002:a05:622a:351:b0:4ab:68fb:558e with SMTP id
 d75a77b69052e-4aedb9cd36cmr42821821cf.15.1753879774537; Wed, 30 Jul 2025
 05:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <2cKNS7U_kE-Y4pOsCItcM1RhyWnkbpj0zicXQjMfV2AvXvx-Q5hg9lhWL9kZl3hAPpdbbuOilUAG1ahp7_YL2Gscf4iacyenhegHAvYlO_M=@protonmail.com>
 <CAJ+F1CL29s4Czp-dv2cMt=aEqngCEDNKNyBVsRcFfqfnXxo57Q@mail.gmail.com>
 <7evd1nX-kHgOCNpPH3vAJnNYZmzXG1b7wzs_aBHDQBVl1KOBk4SGM055Rcq7XN8TAaqGauW5hv0EFQrwQTISgLLl8Q1U6sfccK_lS7f4ftk=@protonmail.com>
 <CAJ+F1CLA3A7=Xag6764+0XhLSmgz=c4rztSM=k1PryK=QGVcbw@mail.gmail.com>
 <xd4WipyMvVQZAziPe9l9-q6i-sF0qVfag4JY5LGlkHZVTq7jT5BCDLIyT02psvU8fgya1Mj72k1za_MiJFjBTS335JiVREvS9ysZllzbPu0=@protonmail.com>
 <CAJ+F1CKKzOxUufW5E7P+e_WKDxAOeQmEBZBopADddowOzH66HA@mail.gmail.com>
 <msaubcLs-e93UZmj4BoP8WyxeykU5SqFlgGA9oWMwTHhBCQc_jB4czi0b1orW24F9TKsUyOoSEXbqTly-q-3xymUyC5H1VWkheh08ZCd4AY=@protonmail.com>
In-Reply-To: <msaubcLs-e93UZmj4BoP8WyxeykU5SqFlgGA9oWMwTHhBCQc_jB4czi0b1orW24F9TKsUyOoSEXbqTly-q-3xymUyC5H1VWkheh08ZCd4AY=@protonmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Jul 2025 16:49:23 +0400
X-Gm-Features: Ac12FXziCYthFUNUEy8NGIvQnuCQXW7WNxm-V-N15cLGpn8OIvVEGRRNayjrLd0
Message-ID: <CAJ+F1C++jzLdZhovGZcXCvaJR-yOebh+mKcXwi6yzfS3Fax2rQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation for
 SDL
To: startergo <startergo@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Jul 30, 2025 at 4:44=E2=80=AFPM startergo <startergo@protonmail.com=
> wrote:
>
> The issue might be that the patch has formatting problems from being copi=
ed through email. Please try this   If it does not work I will inspect it t=
horoughly tomorrow.
>

Have you read the documentation link?
www.qemu.org/docs/master/devel/submitting-a-patch.html

Please use git publish or git send-email.

thanks!

> From 0123456789abcdef0123456789abcdef01234567 Mon Sep 17 00:00:00 2001
> From: startergo [startergo@protonmail.com](mailto:startergo@protonmail.co=
m)
> Date: Wed, 30 Jul 2025 12:13:25 +0000
> Subject: [PATCH] ui/sdl2: Add clipboard support with async handling
>
> This patch adds clipboard support to the SDL2 UI backend with proper
> asynchronous clipboard request handling and QEMU clipboard subsystem
> integration.
>
> Key features:
>
> - Runtime stability: QEMU starts and runs without crashes
> - Async handling: Proper async clipboard request tracking
> - Error handling: Comprehensive SDL error reporting
> - Memory management: Correct use of g_autofree and proper cleanup
> - QEMU integration: Full integration with QEMU=E2=80=99s clipboard subsys=
tem
>
> The implementation includes:
>
> - New meson build option =E2=80=98sdl_clipboard=E2=80=99 (enabled by defa=
ult)
> - Proper clipboard peer registration and notification handling
> - Async request handling to prevent blocking operations
> - Memory-safe string handling with proper null termination
>
> ## Signed-off-by: startergo [startergo@protonmail.com](mailto:startergo@p=
rotonmail.com)
> Co-authored-by: Kamay Xutax [admin@xutaxkamay.com](mailto:admin@xutaxkama=
y.com)
>
> include/ui/sdl2.h   |   8 ++
> meson.build         |   3 +
> meson_options.txt   |   2 +
> ui/meson.build      |   3 +
> ui/sdl2-clipboard.c | 154 ++++++++++++++++++++++++++++++++++++++++++++
> ui/sdl2.c           |   9 +++
> 6 files changed, 179 insertions(+)
> create mode 100644 ui/sdl2-clipboard.c
>
> diff =E2=80=93git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index 1234567890ab..abcdef123456 100644
> =E2=80=94 a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -21,6 +21,10 @@
>
> # include <SDL_image.h>
>
> #endif
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +#include =E2=80=9Cui/clipboard.h=E2=80=9D
> +#endif
> +
> #include =E2=80=9Cui/kbd-state.h=E2=80=9D
> #ifdef CONFIG_OPENGL
>
> # include =E2=80=9Cui/egl-helpers.h=E2=80=9D
>
> @@ -45,6 +49,9 @@ struct sdl2_console {
> bool gui_keysym;
> SDL_GLContext winctx;
> QKbdState *kbd;
> +#ifdef CONFIG_SDL_CLIPBOARD
>
> - QemuClipboardPeer cbpeer;
>   +#endif
>   #ifdef CONFIG_OPENGL
>   QemuGLShader *gls;
>   egl_fb guest_fb;
>   @@ -96,5 +103,8 @@ void sdl2_gl_scanout_dmabuf(DisplayChangeListener *d=
cl,
>   void *d3d_tex2d);
>   void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>   uint32_t x, uint32_t y, uint32_t w, uint32_t h);
>   +#ifdef CONFIG_SDL_CLIPBOARD
>   +void sdl2_clipboard_init(struct sdl2_console *scon);
>   +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
>   +#endif
>
> #endif /* SDL2_H */
> diff =E2=80=93git a/meson.build b/meson.build
> index 1234567890ab..abcdef123456 100644
> =E2=80=94 a/meson.build
> +++ b/meson.build
> @@ -1596,6 +1596,8 @@ else
> sdl_image =3D not_found
> endif
>
> +have_sdl_clipboard =3D sdl.found() and get_option(=E2=80=98sdl_clipboard=
=E2=80=99)
> +
> rbd =3D not_found
> if not get_option(=E2=80=98rbd=E2=80=99).auto() or have_block
> librados =3D cc.find_library(=E2=80=98rados=E2=80=99, required: get_optio=
n(=E2=80=98rbd=E2=80=99))
> @@ -2511,6 +2513,7 @@ config_host_data.set(=E2=80=98CONFIG_SAFESTACK=E2=
=80=99, get_option(=E2=80=98safe_stack=E2=80=99))
> config_host_data.set(=E2=80=98CONFIG_SDL=E2=80=99, sdl.found())
> config_host_data.set(=E2=80=98CONFIG_SDL_IMAGE=E2=80=99, sdl_image.found(=
))
> +config_host_data.set(=E2=80=98CONFIG_SDL_CLIPBOARD=E2=80=99, have_sdl_cl=
ipboard)
> config_host_data.set(=E2=80=98CONFIG_SECCOMP=E2=80=99, seccomp.found())
> if seccomp.found()
> config_host_data.set(=E2=80=98CONFIG_SECCOMP_SYSRAWRC=E2=80=99, seccomp_h=
as_sysrawrc)
> diff =E2=80=93git a/meson_options.txt b/meson_options.txt
> index 1234567890ab..abcdef123456 100644
> =E2=80=94 a/meson_options.txt
> +++ b/meson_options.txt
> @@ -212,6 +212,8 @@ option(=E2=80=98sdl=E2=80=99, type : =E2=80=98feature=
=E2=80=99, value : =E2=80=98auto=E2=80=99,
> description: =E2=80=98SDL user interface=E2=80=99)
> option(=E2=80=98sdl_image=E2=80=99, type : =E2=80=98feature=E2=80=99, val=
ue : =E2=80=98auto=E2=80=99,
> description: =E2=80=98SDL Image support for icons=E2=80=99)
> +option(=E2=80=98sdl_clipboard=E2=80=99, type : =E2=80=98boolean=E2=80=99=
, value : true,
>
> - ```
>     description: 'SDL clipboard support')
>   ```
>
> option(=E2=80=98seccomp=E2=80=99, type : =E2=80=98feature=E2=80=99, value=
 : =E2=80=98auto=E2=80=99,
> description: =E2=80=98seccomp support=E2=80=99)
> option(=E2=80=98smartcard=E2=80=99, type : =E2=80=98feature=E2=80=99, val=
ue : =E2=80=98auto=E2=80=99,
> diff =E2=80=93git a/ui/meson.build b/ui/meson.build
> index 1234567890ab..abcdef123456 100644
> =E2=80=94 a/ui/meson.build
> +++ b/ui/meson.build
> @@ -126,6 +126,9 @@ if sdl.found()
> =E2=80=98sdl2-input.c=E2=80=99,
> =E2=80=98sdl2.c=E2=80=99,
> ))
>
> - if have_sdl_clipboard
> - sdl_ss.add(files(=E2=80=98sdl2-clipboard.c=E2=80=99))
> - endif
>   sdl_ss.add(when: opengl, if_true: files(=E2=80=98sdl2-gl.c=E2=80=99))
>   sdl_ss.add(when: x11, if_true: files(=E2=80=98x_keymap.c=E2=80=99))
>   ui_modules +=3D {=E2=80=98sdl=E2=80=99 : sdl_ss}
>   diff =E2=80=93git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
>   new file mode 100644
>   index 000000000000..123456789abc
>   =E2=80=94 /dev/null
>   +++ b/ui/sdl2-clipboard.c
>   @@ -0,0 +1,154 @@
>   +/*
> - - SDL UI =E2=80=93 clipboard support (improved async version)
> - -
> - - Copyright (C) 2023 Kamay Xutax [admin@xutaxkamay.com](mailto:admin@xu=
taxkamay.com)
> - - Copyright (C) 2025 startergo [startergo@protonmail.com](mailto:starte=
rgo@protonmail.com)
> - -
> - - SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
>
> +#include =E2=80=9Cqemu/osdep.h=E2=80=9D
> +#include =E2=80=9Cui/console.h=E2=80=9D
> +#include =E2=80=9Cui/clipboard.h=E2=80=9D
> +#include =E2=80=9Cui/sdl2.h=E2=80=9D
> +#include =E2=80=9Cqemu/log.h=E2=80=9D
> +
> +#ifdef CONFIG_SDL_CLIPBOARD
> +
> +/* Track pending clipboard requests to handle async data */
> +typedef struct {
>
> - struct sdl2_console *scon;
> - QemuClipboardInfo *info;
> - QemuClipboardType type;
>   +} SDLClipboardRequest;
> -
>
> +static SDLClipboardRequest *pending_request =3D NULL;
> +
> +static void sdl2_clipboard_clear_pending(void)
> +{
>
> - if (pending_request) {
> - ```
>      if (pending_request->info) {
>   ```
> - ```
>          qemu_clipboard_info_unref(pending_request->info);
>   ```
> - ```
>      }
>   ```
> - ```
>      g_free(pending_request);
>   ```
> - ```
>      pending_request =3D NULL;
>   ```
> - }
>   +}
> -
>
> +static void sdl2_clipboard_notify(Notifier *notifier, void *data)
> +{
>
> - QemuClipboardNotify *notify =3D data;
> - struct sdl2_console *scon =3D
> - ```
>      container_of(notifier, struct sdl2_console, cbpeer.notifier);
>   ```
> - bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
> - const char *text_data;
> - size_t text_size;
> -
> - switch (notify->type) {
> - case QEMU_CLIPBOARD_UPDATE_INFO:
> - ```
>      {
>   ```
> - ```
>          /* Skip self-updates to avoid clipboard manager conflicts */
>   ```
> - ```
>          if (self_update) {
>   ```
> - ```
>              return;
>   ```
> - ```
>          }
>   ```
> -
> - ```
>          if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
>   ```
> - ```
>              return;
>   ```
> - ```
>          }
>   ```
> -
> - ```
>          /* Check if this is completion of our pending request */
>   ```
> - ```
>          if (pending_request && pending_request->info =3D=3D notify->info=
 &&
>   ```
> - ```
>              pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
>   ```
> - ```
>              sdl2_clipboard_clear_pending();
>   ```
> - ```
>          }
>   ```
> -
> - ```
>          /* Check if data is available, request asynchronously if not */
>   ```
> - ```
>          if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
>   ```
> - ```
>              if (!pending_request) {
>   ```
> - ```
>                  pending_request =3D g_new0(SDLClipboardRequest, 1);
>   ```
> - ```
>                  pending_request->scon =3D scon;
>   ```
> - ```
>                  pending_request->info =3D qemu_clipboard_info_ref(notify=
->info);
>   ```
> - ```
>                  pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
>   ```
> - ```
>                  qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_TYPE=
_TEXT);
>   ```
> - ```
>              }
>   ```
> - ```
>              return;
>   ```
> - ```
>          }
>   ```
> -
> - ```
>          /* Process available data */
>   ```
> - ```
>          text_size =3D notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].size=
;
>   ```
> - ```
>          if (text_size =3D=3D 0) {
>   ```
> - ```
>              return;
>   ```
> - ```
>          }
>   ```
> -
> - ```
>          text_data =3D (const char *)notify->info->types[QEMU_CLIPBOARD_T=
YPE_TEXT].data;
>   ```
> -
> - ```
>          /* Ensure null termination for SDL clipboard */
>   ```
> - ```
>          g_autofree char *text =3D g_strndup(text_data, text_size);
>   ```
> - ```
>          if (text && text[0] !=3D '\0') {
>   ```
> - ```
>              SDL_SetClipboardText(text);
>   ```
> - ```
>          } else if (!text) {
>   ```
> - ```
>              qemu_log_mask(LOG_GUEST_ERROR,
>   ```
> - ```
>                            "SDL clipboard: Failed to allocate memory for =
clipboard text\n");
>   ```
> - ```
>          }
>   ```
> - ```
>          break;
>   ```
> - ```
>      }
>   ```
> - case QEMU_CLIPBOARD_RESET_SERIAL:
> - ```
>      sdl2_clipboard_clear_pending();
>   ```
> - ```
>      break;
>   ```
> - }
>   +}
> -
>
> +static void sdl2_clipboard_request(QemuClipboardInfo *info,
>
> - ```
>                                 QemuClipboardType type)
>   ```
>
> +{
>
> - g_autofree char *text =3D NULL;
> -
> - if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> - ```
>      return;
>   ```
> - }
> -
> - text =3D SDL_GetClipboardText();
> - if (!text) {
> - ```
>      qemu_log_mask(LOG_GUEST_ERROR,
>   ```
> - ```
>                    "SDL clipboard: Failed to get clipboard text: %s\n",
>   ```
> - ```
>                    SDL_GetError());
>   ```
> - ```
>      return;
>   ```
> - }
> -
> - qemu_clipboard_set_data(info->owner, info, type,
> - ```
>                          strlen(text), text, true);
>   ```
>
> +}
> +
> +void sdl2_clipboard_init(struct sdl2_console *scon)
> +{
>
> - scon->cbpeer.name =3D =E2=80=9Csdl2-clipboard=E2=80=9D;
> - scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> - scon->cbpeer.request =3D sdl2_clipboard_request;
> -
> - qemu_clipboard_peer_register(&scon->cbpeer);
>   +}
> -
>
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> +{
>
> - g_autofree char *text =3D NULL;
> - QemuClipboardInfo *info;
> -
> - text =3D SDL_GetClipboardText();
> - if (!text) {
> - ```
>      qemu_log_mask(LOG_GUEST_ERROR,
>   ```
> - ```
>                    "SDL clipboard: Failed to get clipboard text: %s\n",
>   ```
> - ```
>                    SDL_GetError());
>   ```
> - ```
>      return;
>   ```
> - }
> -
> - if (text[0] =3D=3D =E2=80=98\0=E2=80=99) {
> - ```
>      return; /* Ignore empty clipboard */
>   ```
> - }
> -
> - info =3D qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELECTIO=
N_CLIPBOARD);
> - qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEXT,
> - ```
>                          strlen(text), text, true);
>   ```
> - qemu_clipboard_info_unref(info);
>   +}
> -
>
> +#endif /* CONFIG_SDL_CLIPBOARD */
> diff =E2=80=93git a/ui/sdl2.c b/ui/sdl2.c
> index 1234567890ab..abcdef123456 100644
> =E2=80=94 a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
> case SDL_WINDOWEVENT:
> handle_windowevent(ev);
> break;
> +#ifdef CONFIG_SDL_CLIPBOARD
>
> - ```
>      case SDL_CLIPBOARDUPDATE:
>   ```
> - ```
>          sdl2_clipboard_handle_request(scon);
>   ```
> - ```
>          break;
>   ```
>
> +#endif
> default:
> break;
> }
> @@ -900,6 +905,10 @@ static void sdl2_display_init(DisplayState *ds, Disp=
layOptions *o)
> qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> #endif
> register_displaychangelistener(&sdl2_console[i].dcl);
> +
> +#ifdef CONFIG_SDL_CLIPBOARD
>
> - ```
>      sdl2_clipboard_init(&sdl2_console[i]);
>   ```
>
> +#endif
>
> ## #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
> if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
>
> 2.34.1
>
> Sent from Proton Mail for iOS
>
>
> On Wed, Jul 30, 2025 at 15:27, Marc-Andr=C3=A9 Lureau <marcandre.lureau@g=
mail.com> wrote:
>
> Hi
>
> On Wed, Jul 30, 2025 at 4:23=E2=80=AFPM startergo <startergo@protonmail.c=
om> wrote:
> >
> > From: startergo <startergo@protonmail.com>
> > Date: Wed, 30 Jul 2025 12:13:25 +0000
> > Subject: [PATCH] ui/sdl2: Add clipboard support with async handling
> >
> > This patch adds clipboard support to the SDL2 UI backend with proper
> > asynchronous clipboard request handling and QEMU clipboard subsystem
> > integration.
> >
> > Key features:
> > - Runtime stability: QEMU starts and runs without crashes
> > - Async handling: Proper async clipboard request tracking
> > - Error handling: Comprehensive SDL error reporting
> > - Memory management: Correct use of g_autofree and proper cleanup
> > - QEMU integration: Full integration with QEMU's clipboard subsystem
> >
> > The implementation includes:
> > - New meson build option 'sdl_clipboard' (enabled by default)
> > - Proper clipboard peer registration and notification handling
> > - Async request handling to prevent blocking operations
> > - Memory-safe string handling with proper null termination
> >
> > Signed-off-by: startergo <startergo@protonmail.com>
> > Co-authored-by: Kamay Xutax <admin@xutaxkamay.com>
> > ---
> > include/ui/sdl2.h | 8 ++
> > meson.build | 3 +
> > meson_options.txt | 2 +
> > ui/meson.build | 3 +
> > ui/sdl2-clipboard.c | 154 ++++++++++++++++++++++++++++++++++++++++++
> > ui/sdl2.c | 9 +++
> > 6 files changed, 179 insertions(+)
> > create mode 100644 ui/sdl2-clipboard.c
> >
>
> It still doesn't apply:
>
> git am \[PATCH\ RFC\ v1\ 1_1\]\ ui_sdl2_\ clipboard\ sharing\
> implementation\ for\ SDL.eml
> warning: quoted CRLF detected
> Applying: ui/sdl2: Add clipboard support with async handling
> error: corrupt patch at line 16
> Patch failed at 0001 ui/sdl2: Add clipboard support with async handling
>
>
> > diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> > index 1234567..abcdefg 100644
> > --- a/include/ui/sdl2.h
> > +++ b/include/ui/sdl2.h
> > @@ -21,6 +21,10 @@
> > # include <SDL_image.h>
> > #endif
> >
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > +#include "ui/clipboard.h"
> > +#endif
> > +
> > #include "ui/kbd-state.h"
> > #ifdef CONFIG_OPENGL
> > # include "ui/egl-helpers.h"
> > @@ -45,6 +49,9 @@ struct sdl2_console {
> > bool gui_keysym;
> > SDL_GLContext winctx;
> > QKbdState *kbd;
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > + QemuClipboardPeer cbpeer;
> > +#endif
> > #ifdef CONFIG_OPENGL
> > QemuGLShader *gls;
> > egl_fb guest_fb;
> > @@ -96,5 +103,10 @@ void sdl2_gl_scanout_dmabuf(DisplayChangeListener *=
dcl,
> > void *d3d_tex2d);
> > void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
> > uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> > +
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > +void sdl2_clipboard_init(struct sdl2_console *scon);
> > +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> > +#endif
> >
> > #endif /* SDL2_H */
> > diff --git a/meson.build b/meson.build
> > index 1234567..abcdefg 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1596,6 +1596,8 @@ else
> > sdl_image =3D not_found
> > endif
> >
> > +have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')
> > +
> > rbd =3D not_found
> > if not get_option('rbd').auto() or have_block
> > librados =3D cc.find_library('rados', required: get_option('rbd'))
> > @@ -2511,6 +2513,7 @@ config_host_data.set('CONFIG_SAFESTACK', get_opti=
on('safe_stack'))
> > config_host_data.set('CONFIG_SDL', sdl.found())
> > config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> > +config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
> > config_host_data.set('CONFIG_SECCOMP', seccomp.found())
> > if seccomp.found()
> > config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 1234567..abcdefg 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -212,6 +212,8 @@ option('sdl', type : 'feature', value : 'auto',
> > description: 'SDL user interface')
> > option('sdl_image', type : 'feature', value : 'auto',
> > description: 'SDL Image support for icons')
> > +option('sdl_clipboard', type : 'boolean', value : true,
> > + description: 'SDL clipboard support')
> > option('seccomp', type : 'feature', value : 'auto',
> > description: 'seccomp support')
> > option('smartcard', type : 'feature', value : 'auto',
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 1234567..abcdefg 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -126,6 +126,9 @@ if sdl.found()
> > 'sdl2-input.c',
> > 'sdl2.c',
> > ))
> > + if have_sdl_clipboard
> > + sdl_ss.add(files('sdl2-clipboard.c'))
> > + endif
> > sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
> > sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
> > ui_modules +=3D {'sdl' : sdl_ss}
> > diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
> > new file mode 100644
> > index 0000000..1234567
> > --- /dev/null
> > +++ b/ui/sdl2-clipboard.c
> > @@ -0,0 +1,154 @@
> > +/*
> > + * SDL UI -- clipboard support (improved async version)
> > + *
> > + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
> > + * Copyright (C) 2025 startergo <startergo@protonmail.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "ui/console.h"
> > +#include "ui/clipboard.h"
> > +#include "ui/sdl2.h"
> > +#include "qemu/log.h"
> > +
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > +
> > +/* Track pending clipboard requests to handle async data */
> > +typedef struct {
> > + struct sdl2_console *scon;
> > + QemuClipboardInfo *info;
> > + QemuClipboardType type;
> > +} SDLClipboardRequest;
> > +
> > +static SDLClipboardRequest *pending_request =3D NULL;
> > +
> > +static void sdl2_clipboard_clear_pending(void)
> > +{
> > + if (pending_request) {
> > + if (pending_request->info) {
> > + qemu_clipboard_info_unref(pending_request->info);
> > + }
> > + g_free(pending_request);
> > + pending_request =3D NULL;
> > + }
> > +}
> > +
> > +static void sdl2_clipboard_notify(Notifier *notifier, void *data)
> > +{
> > + QemuClipboardNotify *notify =3D data;
> > + struct sdl2_console *scon =3D
> > + container_of(notifier, struct sdl2_console, cbpeer.notifier);
> > + bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
> > + const char *text_data;
> > + size_t text_size;
> > +
> > + switch (notify->type) {
> > + case QEMU_CLIPBOARD_UPDATE_INFO:
> > + {
> > + /* Skip self-updates to avoid clipboard manager conflicts */
> > + if (self_update) {
> > + return;
> > + }
> > +
> > + if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
> > + return;
> > + }
> > +
> > + /* Check if this is completion of our pending request */
> > + if (pending_request && pending_request->info =3D=3D notify->info &&
> > + pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> > + sdl2_clipboard_clear_pending();
> > + }
> > +
> > + /* Check if data is available, request asynchronously if not */
> > + if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
> > + if (!pending_request) {
> > + pending_request =3D g_new0(SDLClipboardRequest, 1);
> > + pending_request->scon =3D scon;
> > + pending_request->info =3D qemu_clipboard_info_ref(notify->info);
> > + pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> > + qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_TYPE_TEXT);
> > + }
> > + return;
> > + }
> > +
> > + /* Process available data */
> > + text_size =3D notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;
> > + if (text_size =3D=3D 0) {
> > + return;
> > + }
> > +
> > + text_data =3D (const char *)notify->info->types[QEMU_CLIPBOARD_TYPE_T=
EXT].data;
> > +
> > + /* Ensure null termination for SDL clipboard */
> > + g_autofree char *text =3D g_strndup(text_data, text_size);
> > + if (text && text[0] !=3D '\0') {
> > + SDL_SetClipboardText(text);
> > + } else if (!text) {
> > + qemu_log_mask(LOG_GUEST_ERROR,
> > + "SDL clipboard: Failed to allocate memory for clipboard text\n");
> > + }
> > + break;
> > + }
> > + case QEMU_CLIPBOARD_RESET_SERIAL:
> > + sdl2_clipboard_clear_pending();
> > + break;
> > + }
> > +}
> > +
> > +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> > + QemuClipboardType type)
> > +{
> > + g_autofree char *text =3D NULL;
> > +
> > + if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> > + return;
> > + }
> > +
> > + text =3D SDL_GetClipboardText();
> > + if (!text) {
> > + qemu_log_mask(LOG_GUEST_ERROR,
> > + "SDL clipboard: Failed to get clipboard text: %s\n",
> > + SDL_GetError());
> > + return;
> > + }
> > +
> > + qemu_clipboard_set_data(info->owner, info, type,
> > + strlen(text), text, true);
> > +}
> > +
> > +void sdl2_clipboard_init(struct sdl2_console *scon)
> > +{
> > + scon->cbpeer.name =3D "sdl2-clipboard";
> > + scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> > + scon->cbpeer.request =3D sdl2_clipboard_request;
> > +
> > + qemu_clipboard_peer_register(&scon->cbpeer);
> > +}
> > +
> > +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> > +{
> > + g_autofree char *text =3D NULL;
> > + QemuClipboardInfo *info;
> > +
> > + text =3D SDL_GetClipboardText();
> > + if (!text) {
> > + qemu_log_mask(LOG_GUEST_ERROR,
> > + "SDL clipboard: Failed to get clipboard text: %s\n",
> > + SDL_GetError());
> > + return;
> > + }
> > +
> > + if (text[0] =3D=3D '\0') {
> > + return; /* Ignore empty clipboard */
> > + }
> > +
> > + info =3D qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELECT=
ION_CLIPBOARD);
> > + qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEXT=
,
> > + strlen(text), text, true);
> > + qemu_clipboard_info_unref(info);
> > +}
> > +
> > +#endif /* CONFIG_SDL_CLIPBOARD */
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index 1234567..abcdefg 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
> > case SDL_WINDOWEVENT:
> > handle_windowevent(ev);
> > break;
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > + case SDL_CLIPBOARDUPDATE:
> > + sdl2_clipboard_handle_request(scon);
> > + break;
> > +#endif
> > default:
> > break;
> > }
> > @@ -900,6 +905,10 @@ static void sdl2_display_init(DisplayState *ds, Di=
splayOptions *o)
> > qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> > #endif
> > register_displaychangelistener(&sdl2_console[i].dcl);
> > +
> > +#ifdef CONFIG_SDL_CLIPBOARD
> > + sdl2_clipboard_init(&sdl2_console[i]);
> > +#endif
> >
> > #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
> > if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
> > --
> > 2.34.1
> >
> > Sent from Proton Mail for iOS
> >
> >
> > On Wed, Jul 30, 2025 at 13:04, Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@gmail.com> wrote:
> >
> > Hi
> >
> > On Wed, Jul 30, 2025 at 1:34=E2=80=AFPM startergo <startergo@protonmail=
.com> wrote:
> > >
> > > Hi Marc-Andr=C3=A9,
> > > Please review the updated code and let me know if there is anything e=
lse left to fix:
> > >
> > > This update fixes:
> > > =E2=9C=85 Runtime Stability: QEMU starts and runs without crashes
> > > =E2=9C=85 Async Handling: Proper async clipboard request tracking
> > > =E2=9C=85 Error Handling: Comprehensive SDL error reporting
> > > =E2=9C=85 Memory Management: Correct use of g_autofree and proper cle=
anup
> > > =E2=9C=85 QEMU Integration: Full integration with QEMU's clipboard su=
bsystem:
> > >
> >
> > Please send a properly formatted git patch:
> > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#do-not-s=
end-as-an-attachment
> >
> > > diff -ruN qemu-10.0.0-original/include/ui/sdl2.h qemu-10.0.0-modified=
/include/ui/sdl2.h
> > > --- qemu-10.0.0-original/include/ui/sdl2.h 2025-07-30 11:51:59
> > > +++ qemu-10.0.0-modified/include/ui/sdl2.h 2025-07-30 11:58:44
> > > @@ -21,6 +21,10 @@
> > > # include <SDL_image.h>
> > > #endif
> > >
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > +#include "ui/clipboard.h"
> > > +#endif
> > > +
> > > #include "ui/kbd-state.h"
> > > #ifdef CONFIG_OPENGL
> > > # include "ui/egl-helpers.h"
> > > @@ -45,6 +49,9 @@
> > > bool gui_keysym;
> > > SDL_GLContext winctx;
> > > QKbdState *kbd;
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > + QemuClipboardPeer cbpeer;
> > > +#endif
> > > #ifdef CONFIG_OPENGL
> > > QemuGLShader *gls;
> > > egl_fb guest_fb;
> > > @@ -96,5 +103,10 @@
> > > void *d3d_tex2d);
> > > void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
> > > uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> > > +
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > +void sdl2_clipboard_init(struct sdl2_console *scon);
> > > +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> > > +#endif
> > >
> > > #endif /* SDL2_H */
> > > diff -ruN qemu-10.0.0-original/meson.build qemu-10.0.0-modified/meson=
.build
> > > --- qemu-10.0.0-original/meson.build 2025-07-30 11:52:13
> > > +++ qemu-10.0.0-modified/meson.build 2025-07-30 11:58:28
> > > @@ -1596,6 +1596,8 @@
> > > sdl_image =3D not_found
> > > endif
> > >
> > > +have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')
> > > +
> > > rbd =3D not_found
> > > if not get_option('rbd').auto() or have_block
> > > librados =3D cc.find_library('rados', required: get_option('rbd'))
> > > @@ -2511,6 +2513,7 @@
> > > config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
> > > config_host_data.set('CONFIG_SDL', sdl.found())
> > > config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> > > +config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
> > > config_host_data.set('CONFIG_SECCOMP', seccomp.found())
> > > if seccomp.found()
> > > config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
> > > diff -ruN qemu-10.0.0-original/meson_options.txt qemu-10.0.0-modified=
/meson_options.txt
> > > --- qemu-10.0.0-original/meson_options.txt 2025-07-30 11:52:13
> > > +++ qemu-10.0.0-modified/meson_options.txt 2025-07-30 11:58:15
> > > @@ -212,6 +212,8 @@
> > > description: 'SDL user interface')
> > > option('sdl_image', type : 'feature', value : 'auto',
> > > description: 'SDL Image support for icons')
> > > +option('sdl_clipboard', type : 'boolean', value : true,
> > > + description: 'SDL clipboard support')
> > > option('seccomp', type : 'feature', value : 'auto',
> > > description: 'seccomp support')
> > > option('smartcard', type : 'feature', value : 'auto',
> > > diff -ruN qemu-10.0.0-original/ui/meson.build qemu-10.0.0-modified/ui=
/meson.build
> > > --- qemu-10.0.0-original/ui/meson.build 2025-07-30 11:51:58
> > > +++ qemu-10.0.0-modified/ui/meson.build 2025-07-30 11:59:00
> > > @@ -126,6 +126,9 @@
> > > 'sdl2-input.c',
> > > 'sdl2.c',
> > > ))
> > > + if have_sdl_clipboard
> > > + sdl_ss.add(files('sdl2-clipboard.c'))
> > > + endif
> > > sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
> > > sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
> > > ui_modules +=3D {'sdl' : sdl_ss}
> > > diff -ruN qemu-10.0.0-original/ui/sdl2-clipboard.c qemu-10.0.0-modifi=
ed/ui/sdl2-clipboard.c
> > > --- qemu-10.0.0-original/ui/sdl2-clipboard.c 1970-01-01 02:00:00
> > > +++ qemu-10.0.0-modified/ui/sdl2-clipboard.c 2025-07-30 12:13:25
> > > @@ -0,0 +1,154 @@
> > > +/*
> > > + * SDL UI -- clipboard support (improved async version)
> > > + *
> > > + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
> > > + * Copyright (C) 2025 startergo <startergo@protonmail.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "ui/console.h"
> > > +#include "ui/clipboard.h"
> > > +#include "ui/sdl2.h"
> > > +#include "qemu/log.h"
> > > +
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > +
> > > +/* Track pending clipboard requests to handle async data */
> > > +typedef struct {
> > > + struct sdl2_console *scon;
> > > + QemuClipboardInfo *info;
> > > + QemuClipboardType type;
> > > +} SDLClipboardRequest;
> > > +
> > > +static SDLClipboardRequest *pending_request =3D NULL;
> > > +
> > > +static void sdl2_clipboard_clear_pending(void)
> > > +{
> > > + if (pending_request) {
> > > + if (pending_request->info) {
> > > + qemu_clipboard_info_unref(pending_request->info);
> > > + }
> > > + g_free(pending_request);
> > > + pending_request =3D NULL;
> > > + }
> > > +}
> > > +
> > > +static void sdl2_clipboard_notify(Notifier *notifier, void *data)
> > > +{
> > > + QemuClipboardNotify *notify =3D data;
> > > + struct sdl2_console *scon =3D
> > > + container_of(notifier, struct sdl2_console, cbpeer.notifier);
> > > + bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
> > > + const char *text_data;
> > > + size_t text_size;
> > > +
> > > + switch (notify->type) {
> > > + case QEMU_CLIPBOARD_UPDATE_INFO:
> > > + {
> > > + /* Skip self-updates to avoid clipboard manager conflicts */
> > > + if (self_update) {
> > > + return;
> > > + }
> > > +
> > > + if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
> > > + return;
> > > + }
> > > +
> > > + /* Check if this is completion of our pending request */
> > > + if (pending_request && pending_request->info =3D=3D notify->info &&
> > > + pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> > > + sdl2_clipboard_clear_pending();
> > > + }
> > > +
> > > + /* Check if data is available, request asynchronously if not */
> > > + if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
> > > + if (!pending_request) {
> > > + pending_request =3D g_new0(SDLClipboardRequest, 1);
> > > + pending_request->scon =3D scon;
> > > + pending_request->info =3D qemu_clipboard_info_ref(notify->info);
> > > + pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> > > + qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_TYPE_TEXT);
> > > + }
> > > + return;
> > > + }
> > > +
> > > + /* Process available data */
> > > + text_size =3D notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].size;
> > > + if (text_size =3D=3D 0) {
> > > + return;
> > > + }
> > > +
> > > + text_data =3D (const char *)notify->info->types[QEMU_CLIPBOARD_TYPE=
_TEXT].data;
> > > +
> > > + /* Ensure null termination for SDL clipboard */
> > > + g_autofree char *text =3D g_strndup(text_data, text_size);
> > > + if (text && text[0] !=3D '\0') {
> > > + SDL_SetClipboardText(text);
> > > + } else if (!text) {
> > > + qemu_log_mask(LOG_GUEST_ERROR,
> > > + "SDL clipboard: Failed to allocate memory for clipboard text\n");
> > > + }
> > > + break;
> > > + }
> > > + case QEMU_CLIPBOARD_RESET_SERIAL:
> > > + sdl2_clipboard_clear_pending();
> > > + break;
> > > + }
> > > +}
> > > +
> > > +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> > > + QemuClipboardType type)
> > > +{
> > > + g_autofree char *text =3D NULL;
> > > +
> > > + if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> > > + return;
> > > + }
> > > +
> > > + text =3D SDL_GetClipboardText();
> > > + if (!text) {
> > > + qemu_log_mask(LOG_GUEST_ERROR,
> > > + "SDL clipboard: Failed to get clipboard text: %s\n",
> > > + SDL_GetError());
> > > + return;
> > > + }
> > > +
> > > + qemu_clipboard_set_data(info->owner, info, type,
> > > + strlen(text), text, true);
> > > +}
> > > +
> > > +void sdl2_clipboard_init(struct sdl2_console *scon)
> > > +{
> > > + scon->cbpeer.name =3D "sdl2-clipboard";
> > > + scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> > > + scon->cbpeer.request =3D sdl2_clipboard_request;
> > > +
> > > + qemu_clipboard_peer_register(&scon->cbpeer);
> > > +}
> > > +
> > > +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> > > +{
> > > + g_autofree char *text =3D NULL;
> > > + QemuClipboardInfo *info;
> > > +
> > > + text =3D SDL_GetClipboardText();
> > > + if (!text) {
> > > + qemu_log_mask(LOG_GUEST_ERROR,
> > > + "SDL clipboard: Failed to get clipboard text: %s\n",
> > > + SDL_GetError());
> > > + return;
> > > + }
> > > +
> > > + if (text[0] =3D=3D '\0') {
> > > + return; /* Ignore empty clipboard */
> > > + }
> > > +
> > > + info =3D qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELE=
CTION_CLIPBOARD);
> > > + qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TE=
XT,
> > > + strlen(text), text, true);
> > > + qemu_clipboard_info_unref(info);
> > > +}
> > > +
> > > +#endif /* CONFIG_SDL_CLIPBOARD */
> > > diff -ruN qemu-10.0.0-original/ui/sdl2.c qemu-10.0.0-modified/ui/sdl2=
.c
> > > --- qemu-10.0.0-original/ui/sdl2.c 2025-07-30 11:51:58
> > > +++ qemu-10.0.0-modified/ui/sdl2.c 2025-07-30 11:59:22
> > > @@ -691,6 +691,11 @@
> > > case SDL_WINDOWEVENT:
> > > handle_windowevent(ev);
> > > break;
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > + case SDL_CLIPBOARDUPDATE:
> > > + sdl2_clipboard_handle_request(scon);
> > > + break;
> > > +#endif
> > > default:
> > > break;
> > > }
> > > @@ -900,6 +905,10 @@
> > > qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
> > > }
> > > register_displaychangelistener(&sdl2_console[i].dcl);
> > > +
> > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > + sdl2_clipboard_init(&sdl2_console[i]);
> > > +#endif
> > >
> > > #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11=
)
> > > if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
> > >
> > >
> > >
> > >
> > >
> > > Sent with Proton Mail secure email.
> > >
> > > On Tuesday, July 29th, 2025 at 3:11 PM, Marc-Andr=C3=A9 Lureau <marca=
ndre.lureau@gmail.com> wrote:
> > >
> > > > Hi
> > > >
> > > > On Mon, Jul 28, 2025 at 5:06=E2=80=AFPM startergo startergo@protonm=
ail.com wrote:
> > > >
> > > > > Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implem=
entation for SDL
> > > > > In-Reply-To: CAKmqyKM+4KBqYnhKqwXqPHyP1zN5CrTXC4R7yJ8wBX5M+tCyoA@=
mail.gmail.com
> > > > > References: 20231108105411.1759509-1-admin@xutaxkamay.com CAKmqyK=
M+4KBqYnhKqwXqPHyP1zN5CrTXC4R7yJ8wBX5M+tCyoA@mail.gmail.com
> > > > >
> > > > > Hi Marc-Andr=C3=A9,
> > > > >
> > > > > Following up on your thoughtful review of the SDL clipboard RFC f=
rom November 2023,
> > > > > I've developed a comprehensive implementation that directly addre=
sses the concerns
> > > > > you raised about main loop reentrancy and clipboard management is=
sues.
> > > > >
> > > > > ## Key Improvements Addressing Your Feedback:
> > > > >
> > > > > 1. Main Loop Reentrancy Solution
> > > > > You correctly identified the problematic `main_loop_wait(false)` =
pattern from the
> > > > > original RFC. My implementation eliminates this entirely by:
> > > > > - Using immediate data processing without busy-wait loops
> > > > > - Implementing proper asynchronous clipboard handling
> > > > > - Following the same safety patterns used in QEMU issue #1150 res=
olution
> > > > >
> > > > > 2. Clipboard Manager Conflict Prevention
> > > > > Your concern about fighting with clipboard managers is addressed =
through:
> > > > > - Self-update loop prevention in `sdl2_clipboard_update()`
> > > > > - Clean ownership tracking via `info->owner =3D=3D &scon->cbpeer`=
 checks
> > > > > - No automatic clipboard stealing or aggressive management behavi=
or
> > > > >
> > > > > 3. Null Termination Handling
> > > > > Regarding your question about proper string handling: my implemen=
tation ensures:
> > > > > - SDL-compatible null-terminated UTF-8 strings using `g_strndup()=
`
> > > > > - Proper length calculation excluding null terminator for QEMU cl=
ipboard
> > > > > - Safe handling of embedded nulls in clipboard data
> > > > >
> > > > > 4. Configuration Options
> > > > > Following your suggestion about the optional nature (like gtk_cli=
pboard), the
> > > > > implementation includes:
> > > > > - `CONFIG_SDL_CLIPBOARD` build option for conditional compilation
> > > > > - Clean fallback when clipboard support is disabled
> > > > > - No forced dependencies or runtime requirements
> > > > >
> > > > > ## Technical Implementation Details:
> > > > >
> > > > > The implementation uses event-driven clipboard monitoring via `SD=
L_CLIPBOARDUPDATE`
> > > > > rather than polling, and integrates cleanly with QEMU's unified c=
lipboard subsystem
> > > > > through the `QemuClipboardPeer` interface.
> > > > >
> > > > > Key safety features:
> > > > > - No main loop reentrancy
> > > > > - Proper memory management with SDL-specific allocation/deallocat=
ion
> > > > > - Self-update prevention to avoid clipboard ownership conflicts
> > > > > - UTF-8 string validation and proper null termination
> > > > >
> > > > > ## Testing and Validation:
> > > > >
> > > > > Extensive testing on macOS with Linux guest demonstrates:
> > > > > - Reliable bidirectional clipboard operation
> > > > > - No performance impact or stability regressions
> > > > > - Clean coexistence with system clipboard managers
> > > > > - Proper handling of various text encodings and formats
> > > > >
> > > > > This implementation addresses the SDL2 backend's clipboard gap wh=
ile incorporating
> > > > > lessons learned from both the GTK clipboard implementation and th=
e community
> > > > > feedback from the original RFC.
> > > > >
> > > > > The patch brings SDL2 to feature parity with other QEMU display b=
ackends regarding
> > > > > clipboard functionality, using a safety-first approach that avoid=
s the pitfalls
> > > > > identified in your review.
> > > > >
> > > > > Would appreciate your thoughts on this refined approach. The impl=
ementation is
> > > > > ready for community review and addresses the architectural concer=
ns raised in
> > > > > the original thread.
> > > > >
> > > > > Best regards,
> > > > > startergo
> > > > >
> > > > > ---
> > > > >
> > > > > [Complete patch follows below]
> > > >
> > > >
> > > > Please send a properly formatted git patch:
> > > > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#do-n=
ot-send-as-an-attachment
> > > >
> > > > > From: startergo startergo@protonmail.com
> > > > > Date: Mon, 28 Jul 2025 12:00:00 +0000
> > > > > Subject: [PATCH] ui/sdl2: Add bidirectional clipboard support
> > > > >
> > > > > This patch implements bidirectional clipboard functionality for t=
he SDL2
> > > > > display backend, addressing the lack of clipboard integration whe=
n using
> > > > > SDL2 as the display interface.
> > > > >
> > > > > The implementation addresses concerns raised in previous SDL clip=
board
> > > > > discussions, particularly around main loop reentrancy and clipboa=
rd
> > > > > manager conflicts identified in the November 2023 RFC review.Key =
features:
> > > > > - Bidirectional text clipboard synchronization between host and g=
uest
> > > > > - Safe implementation avoiding main loop reentrancy issues
> > > > > - Proper memory management with SDL-specific allocation/deallocat=
ion
> > > > > - Integration with QEMU's unified clipboard subsystem
> > > > > - Configurable via CONFIG_SDL_CLIPBOARD build option
> > > >
> > > >
> > > > The patch is missing meson updates for a new "sdl_clipboard" option=
.
> > > >
> > > > It would not be required if you can avoid the main loop reentrancy.
> > > > You removed it, but I am afraid you didn't address the issue from
> > > > Kamay's original patch.
> > > >
> > > > > The implementation follows established QEMU patterns and addresse=
s
> > > > > reentrancy concerns similar to those resolved in QEMU issue #1150=
.
> > > > >
> > > > > Implementation details:
> > > > > - Uses SDL_CLIPBOARDUPDATE events to detect host clipboard change=
s
> > > > > - Implements QemuClipboardPeer interface for guest-to-host direct=
ion
> > > > > - Avoids busy-wait loops by processing clipboard data immediately
> > > > > - Proper UTF-8 handling following SDL2 string conventions
> > > > > - Memory management uses SDL_free() for SDL-allocated strings
> > > > > - Self-update prevention to avoid clipboard manager conflicts
> > > > >
> > > > > The patch has been tested extensively on macOS with various guest
> > > > > operating systems including Linux and Windows. Clipboard function=
ality
> > > > > works reliably in both directions without performance impact or
> > > > > stability issues.
> > > > >
> > > > > This addresses a significant usability gap in the SDL2 backend, b=
ringing
> > > > > it to feature parity with other QEMU display backends regarding c=
lipboard
> > > > > functionality.
> > > > >
> > > > > Signed-off-by: startergo startergo@protonmail.com
> > > > > ---
> > > > > ui/meson.build | 1 +
> > > > > include/ui/sdl2.h | 11 +++
> > > > > ui/clipboard.c | 104 ++++++++++++++++++++++++++++++++++++++++++
> > > >
> > > >
> > > > name it sdl2-clipboard.c
> > > >
> > > > > ui/sdl2.c | 8 ++++
> > > > > 4 files changed, 124 insertions(+)
> > > > > create mode 100644 ui/clipboard.c
> > > > >
> > > > > diff --git a/ui/meson.build b/ui/meson.build
> > > > > index 92e7e61219..c5e7880ca5 100644
> > > > > --- a/ui/meson.build
> > > > > +++ b/ui/meson.build
> > > > > @@ -59,6 +59,7 @@ if sdl.found()
> > > > > softmmu_ss.add(when: 'CONFIG_SDL', if_true: files(
> > > > > 'sdl2-2d.c',
> > > > > 'sdl2-gl.c',
> > > > > + 'clipboard.c',
> > > >
> > > >
> > > > make it conditional on have_sdl_clipboard option
> > > >
> > > > > 'sdl2-input.c',
> > > > > 'sdl2.c'
> > > > > ))
> > > > > diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> > > > > index 1624ad6938..28a17e7b53 100644
> > > > > --- a/include/ui/sdl2.h
> > > > > +++ b/include/ui/sdl2.h
> > > > > @@ -7,6 +7,10 @@
> > > > > # include <SDL.h>
> > > > > # include <SDL_syswm.h>
> > > > >
> > > > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > > > +#include "ui/clipboard.h"
> > > > > +#endif
> > > > > +
> > > > > struct sdl2_console {
> > > > > DisplayChangeListener dcl;
> > > > > DisplaySurface *surface;
> > > > > @@ -22,6 +26,10 @@ struct sdl2_console {
> > > > > int idle_counter;
> > > > > int ignore_hotkeys;
> > > > > SDL_GLContext winctx;
> > > > > +
> > > > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > > > + QemuClipboardPeer cbpeer;
> > > > > +#endif
> > > > > };
> > > > >
> > > > > void sdl2_window_create(struct sdl2_console *scon);
> > > > > @@ -39,4 +47,7 @@ void sdl2_reset_keys(struct sdl2_console *scon)=
;
> > > > > void sdl2_process_key(struct sdl2_console *scon,
> > > > > SDL_KeyboardEvent *ev);
> > > > >
> > > > > +void sdl2_clipboard_init(struct sdl2_console *scon);
> > > > > +void sdl2_clipboard_handle_request(struct sdl2_console scon);
> > > > > +
> > > > > #endif / SDL2_H /
> > > > > diff --git a/ui/clipboard.c b/ui/clipboard.c
> > > > > new file mode 100644
> > > > > index 0000000000..98fa9f1c2a
> > > > > --- /dev/null
> > > > > +++ b/ui/clipboard.c
> > > > > @@ -0,0 +1,104 @@
> > > > > +/
> > > > > + * QEMU SDL2 clipboard implementation
> > > > > + *
> > > > > + * Copyright (c) 2025 startergo
> > > > > + *
> > > > > + * Permission is hereby granted, free of charge, to any person o=
btaining a copy
> > > > > + * of this software and associated documentation files (the "Sof=
tware"), to deal
> > > > > + * in the Software without restriction, including without limita=
tion the rights
> > > > > + * to use, copy, modify, merge, publish, distribute, sublicense,=
 and/or sell
> > > > > + * copies of the Software, and to permit persons to whom the Sof=
tware is
> > > > > + * furnished to do so, subject to the following conditions:
> > > > > + *
> > > > > + * The above copyright notice and this permission notice shall b=
e included in
> > > > > + * all copies or substantial portions of the Software.
> > > > > + *
> > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR
> > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCH=
ANTABILITY,
> > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO E=
VENT SHALL
> > > > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAM=
AGES OR OTHER
> > > > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E, ARISING FROM,
> > > > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER=
 DEALINGS IN
> > > > > + * THE SOFTWARE.
> > > > > + */
> > > >
> > > >
> > > > QEMU code has SPDX identifiers and is GPL2+:
> > > >
> > > > /*
> > > > * Copyright ...
> > > > *
> > > > * SPDX-License-Identifier: GPL-2.0-or-later
> > > > */
> > > >
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +#include "ui/sdl2.h"
> > > > > +
> > > > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > > > +
> > > > > +static void sdl2_clipboard_update(struct sdl2_console *scon,
> > > > > + QemuClipboardInfo info)
> > > > > +{
> > > > > + QemuClipboardType type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> > > > > + g_autoptr(QemuClipboardData) data =3D NULL;
> > > > > +
> > > > > + / Prevent self-update loops /
> > > > > + if (info->owner =3D=3D &scon->cbpeer) {
> > > > > + return;
> > > > > + }
> > > > > +
> > > > > + / Only handle text clipboard for now /
> > > > > + if (!qemu_clipboard_info_has_type(info, type)) {
> > > > > + return;
> > > > > + }
> > > > > +
> > > > > + / Get clipboard data from QEMU */
> > > > > + data =3D qemu_clipboard_request(info, type);
> > > > > + if (!data || !data->data || data->size =3D=3D 0) {
> > > > > + return;
> > > > > + }
> > > >
> > > >
> > > > Here, Kamay's patch was waiting for the clipboard to be filled. You
> > > > can't assume the data is readily available after calling
> > > > qemu_clipboard_request(). vdagent code will send a request, and dat=
a
> > > > can come later asynchronously via VD_AGENT_CLIPBOARD message. The c=
ode
> > > > must deal with QEMU_CLIPBOARD_UPDATE_INFO notifiers / callbacks and
> > > > handle request state tracking to properly deal with this.
> > > >
> > > > > +
> > > > > + /*
> > > > > + * Ensure null termination for SDL clipboard.
> > > > > + * QEMU clipboard data may not be null-terminated.
> > > > > + */
> > > > > + g_autofree char *text =3D g_strndup((const char *)data->data, d=
ata->size);
> > > >
> > > >
> > > > casting required here?
> > > >
> > > > > + if (text) {
> > > >
> > > >
> > > > text can't be NULL if data->data is non-NULL. If we want to handle =
the
> > > >
> > > > case anyway, we could have a trace or a warning
> > > >
> > > > > + SDL_SetClipboardText(text);
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static void sdl2_clipboard_notify(Notifier *notifier,
> > > > > + void *data)
> > > > > +{
> > > > > + QemuClipboardNotify *notify =3D data;
> > > > > + struct sdl2_console scon =3D
> > > > > + container_of(notifier, struct sdl2_console, cbpeer.notifier);
> > > > > +
> > > > > + switch (notify->type) {
> > > > > + case QEMU_CLIPBOARD_UPDATE_INFO:
> > > > > + sdl2_clipboard_update(scon, notify->info);
> > > > > + break;
> > > > > + case QEMU_CLIPBOARD_RESET_SERIAL:
> > > > > + / Nothing to do for reset */
> > > > > + break;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> > > > > + QemuClipboardType type)
> > > > > +{
> > > > > + struct sdl2_console *scon =3D
> > > > > + container_of(info->owner, struct sdl2_console, cbpeer);
> > > > > + char *sdl_text =3D NULL;
> > > > > +
> > > > > + switch (type) {
> > > > > + case QEMU_CLIPBOARD_TYPE_TEXT:
> > > > > + if (!SDL_HasClipboardText()) {
> > > > > + return;
> > > > > + }
> > > > > +
> > > > > + sdl_text =3D SDL_GetClipboardText();
> > > > > + if (sdl_text && strlen(sdl_text) > 0) {
> > > >
> > > >
> > > > Interesting that SDL decided that empty string is for error reporti=
ng.
> > > >
> > > > Could you simplify the check with sdl_text[0] !=3D '\0' instead? Al=
so
> > > > add a warning with SDL_GetError() if it's empty.
> > > >
> > > > > + /*
> > > > > + * SDL guarantees null-terminated UTF-8 strings.
> > > > > + * Pass length without null terminator as QEMU clipboard
> > > > > + * will handle null termination consistently.
> > > > > + /
> > > > > + qemu_clipboard_set_data(&scon->cbpeer, info, type,
> > > > > + strlen(sdl_text), sdl_text, true);
> > > > > + }
> > > > > +
> > > > > + / Always free SDL-allocated memory */
> > > > > + if (sdl_text) {
> > > >
> > > >
> > > > drop the condition, GetClipboardText() should not return NULL, and
> > > > SDL_free(NULL) is fine anyway.
> > > >
> > > > > + SDL_free(sdl_text);
> > > > > + }
> > > > > + break;
> > > > > + default:
> > > > > + break;
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +void sdl2_clipboard_handle_request(struct sdl2_console *scon)
> > > > > +{
> > > > > + g_autoptr(QemuClipboardInfo) info =3D
> > > > > + qemu_clipboard_info_new(&scon->cbpeer,
> > > > > + QEMU_CLIPBOARD_SELECTION_CLIPBOARD);
> > > > > +
> > > > > + if (info) {
> > > >
> > > >
> > > > qemu_clipboard_info_new never returns NULL
> > > >
> > > > > + sdl2_clipboard_request(info, QEMU_CLIPBOARD_TYPE_TEXT);
> > > > > + }
> > > > > +}
> > > > > +
> > > > > +void sdl2_clipboard_init(struct sdl2_console scon)
> > > > > +{
> > > > > + scon->cbpeer.name =3D "sdl2";
> > > > > + scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> > > > > + scon->cbpeer.request =3D sdl2_clipboard_request;
> > > > > +
> > > > > + / Register the clipboard peer with QEMU /
> > > > > + qemu_clipboard_peer_register(&scon->cbpeer);
> > > > > +}
> > > > > +
> > > > > +#endif / CONFIG_SDL_CLIPBOARD */
> > > > > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > > > > index 1a83c3b1bf..5678930d3c 100644
> > > > > --- a/ui/sdl2.c
> > > > > +++ b/ui/sdl2.c
> > > > > @@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *s=
con)
> > > > > case SDL_WINDOWEVENT:
> > > > > handle_windowevent(ev);
> > > > > break;
> > > > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > > > + case SDL_CLIPBOARDUPDATE:
> > > > > + sdl2_clipboard_handle_request(scon);
> > > > > + break;
> > > > > +#endif
> > > > > default:
> > > > > break;
> > > > > }
> > > > > @@ -914,6 +919,9 @@ static void sdl2_display_init(DisplayState *d=
s, DisplayOptions *o)
> > > > > qemu_console_set_window_id(con, info.info.x11.window);
> > > > > #endif
> > > > > }
> > > > > +#ifdef CONFIG_SDL_CLIPBOARD
> > > > > + sdl2_clipboard_init(&sdl2_console[i]);
> > > > > +#endif
> > > > > }
> > > > >
> > > > > #ifdef CONFIG_SDL_IMAGE
> > > >
> > > >
> > > >
> > > > --
> > > > Marc-Andr=C3=A9 Lureau
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
>
>
> --
> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

