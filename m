Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7BDC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujIe7-0007Ee-02; Tue, 05 Aug 2025 10:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujIds-00079z-RS
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:27:56 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujIdp-0005nj-NH
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:27:51 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4b08a0b63c6so4358241cf.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754404068; x=1755008868; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPlvJ1pBxdeO9HoJRlks67Wf9CdAW1e4dfy02pTbeTA=;
 b=FObL/KMXZW5jtWVd17MWBP9ZBmGvJR/JNi6UyVuLAPMwSkxlSm0EFU1s4A19EpFqSu
 DS1TINLLRHjXIwGeGiv3a3NrsDH0ZZe3lGSNBHQQbrgKl8QWl/aipIYhxyjwpNb0zXNY
 SoYKQF1KoRnFcQ01X8bk9s1xqP/ANUzXXvw6IZq725h3t9nBVJkzcniFjbBlT6z7O66H
 yjnABg+jwaJf5xIqgMnhNwbdYf9w627QPBXFYKmVs60QuIJKpIptPupH//WdKjosNeg0
 vytSes8k29QTUrcxR99av3+16+5zWEbHxHtq5M9kXRo9CrwZ0BpzTWrVAFTSyEnB6VO7
 jE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754404068; x=1755008868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPlvJ1pBxdeO9HoJRlks67Wf9CdAW1e4dfy02pTbeTA=;
 b=m/DD6m/d0BK1kh/I8Nij4rvr+5D8LjOQ+2Yti2YP9Z6qIB37XqGG4bbX8ldDwfysCR
 QKHhokeCXcy+eAcF+vehvo40CjHRXFhKoanz6Ccb54oi7SnFriZj44IaES7RUUGWLld2
 wi2DecgUvWPPtaPMxUQSJxBD6kQgw48k8Jnjn4WiTm1Va1cYtOzI7lzMQsURo/S2Df3/
 wv3P9DAFgMQU0q2SxJbqR1tQ7OFmZWUvhJRxduEG1Vi06Mtgsok1s2NL/F0UXLCebtMQ
 QRNEIcY2ihA2zv89L9tYxGqoUEwlwIdVGUiYUBNOktWzhPIH7yoKXjtUjR/ejmSFDis7
 v1eg==
X-Gm-Message-State: AOJu0YwiuX9IV1LY3WCbuQSKAfiNzrRcLigj2vxNokl0Hk5lgWX+Dbzt
 d2ihJ6pZuth3df3imOpB5xL2qjCMNMDyMJ5+QPl1HDmEQM1wZzzYiah6t1WxnDbNiTHe8WIGF8e
 dx5sX0k64N1jkP9X1mqCQkaAyKZ88mI0=
X-Gm-Gg: ASbGncv7953I9XXf6o5pLjfcII/PPTYlEkOKi7k0AtDSXZQFxfMtLCluGimZEDRfZd6
 U/6RCHv3NTYi1Te/OwPoEZs+2INoFlynx14btjyaRu8t53NdM9HyHok105GTSKzwksnWXm4AbFf
 xWmmzg5wRME6MHc30XGcam/FCGxUm0g4hxwEGZ1HZwKwKHwhPuhDdPO2JyWTTW5/VGh8dD2O1eV
 DHms+EUlG4uAj3frxc=
X-Google-Smtp-Source: AGHT+IFJGSKwPTSga2i2d5Pi0ceAqtaiU8AUpLx3kUnopXGo+4iS+22iEcoGVwiQJRkWRdObA3SpI9fE0StwcljfcQo=
X-Received: by 2002:a05:622a:568d:b0:4af:1da3:e4d9 with SMTP id
 d75a77b69052e-4af1da3f1afmr105420301cf.50.1754404068094; Tue, 05 Aug 2025
 07:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250731174242.65816-1-startergo@protonmail.com>
In-Reply-To: <20250731174242.65816-1-startergo@protonmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 5 Aug 2025 18:27:36 +0400
X-Gm-Features: Ac12FXwxb1_BANnJ6orFCRg3k_EBtCetPnTTJIPSh0rATxJ1YRA55IxrFPaJG1M
Message-ID: <CAJ+F1CJyGmYhBoTKg_hWibAQfL0f9-1CDWxJnQVBjaS_iXExeg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Add SDL clipboard support
To: startergo <startergo@protonmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kamay Xutax <admin@xutaxkamay.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 5, 2025 at 5:33=E2=80=AFPM startergo via <qemu-devel@nongnu.org=
> wrote:
>
> Implement bidirectional clipboard integration between QEMU and host
> system when using the SDL display backend. This allows seamless
> copy-paste operations between the guest and host environments.
>
> Features:
> - Bidirectional clipboard sync (guest =E2=86=94 host)
> - Async clipboard request handling to prevent blocking
> - Self-update detection to avoid clipboard manager conflicts
> - Configurable via --enable-sdl-clipboard build option
> - Text-only clipboard support (following existing QEMU patterns)
>
> The implementation follows the same patterns used by the existing
> GTK and VNC clipboard implementations, integrating with QEMU's
> clipboard subsystem through QemuClipboardPeer.
>
> Tested on macOS with successful build and runtime clipboard
> functionality verification.
>
> Co-authored-by: Kamay Xutax <admin@xutaxkamay.com>
> Signed-off-by: startergo <startergo@protonmail.com>

Thanks for sending a patch that can be applied with git am !

Next time, make sure it passes checkpatch too:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#writing-your=
-patches

> ---
>  include/ui/sdl2.h   |  12 ++++
>  meson.build         |   3 +
>  meson_options.txt   |   2 +
>  ui/meson.build      |   3 +
>  ui/sdl2-clipboard.c | 154 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/sdl2.c           |   9 +++
>  6 files changed, 183 insertions(+)
>  create mode 100644 ui/sdl2-clipboard.c
>
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d973..0cadbe8c1c 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -21,6 +21,10 @@
>  # include <SDL_image.h>
>  #endif
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +#include "ui/clipboard.h"
> +#endif
> +
>  #include "ui/kbd-state.h"
>  #ifdef CONFIG_OPENGL
>  # include "ui/egl-helpers.h"
> @@ -45,6 +49,9 @@ struct sdl2_console {
>      bool gui_keysym;
>      SDL_GLContext winctx;
>      QKbdState *kbd;
> +#ifdef CONFIG_SDL_CLIPBOARD
> +    QemuClipboardPeer cbpeer;
> +#endif
>  #ifdef CONFIG_OPENGL
>      QemuGLShader *gls;
>      egl_fb guest_fb;
> @@ -97,4 +104,9 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dc=
l,
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t =
h);
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +void sdl2_clipboard_init(struct sdl2_console *scon);
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon);
> +#endif
> +
>  #endif /* SDL2_H */
> diff --git a/meson.build b/meson.build
> index 41f68d3806..4a37df9669 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1596,6 +1596,8 @@ else
>    sdl_image =3D not_found
>  endif
>
> +have_sdl_clipboard =3D sdl.found() and get_option('sdl_clipboard')

you should handle the option the same way as gtk_clipboard: fail if
requested but sdl not enabled, make it a feature, disabled by default
? etc


> +
>  rbd =3D not_found
>  if not get_option('rbd').auto() or have_block
>    librados =3D cc.find_library('rados', required: get_option('rbd'))
> @@ -2511,6 +2513,7 @@ config_host_data.set('CONFIG_RELOCATABLE', get_opti=
on('relocatable'))
>  config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
> +config_host_data.set('CONFIG_SDL_CLIPBOARD', have_sdl_clipboard)
>  config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>  if seccomp.found()
>    config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..be2cba3a30 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -212,6 +212,8 @@ option('sdl', type : 'feature', value : 'auto',
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
>         description: 'SDL Image support for icons')
> +option('sdl_clipboard', type : 'boolean', value : true,
> +       description: 'SDL clipboard support')
>  option('seccomp', type : 'feature', value : 'auto',
>         description: 'seccomp support')
>  option('smartcard', type : 'feature', value : 'auto',
> diff --git a/ui/meson.build b/ui/meson.build
> index 35fb04cadf..6d1bf3477e 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -126,6 +126,9 @@ if sdl.found()
>      'sdl2-input.c',
>      'sdl2.c',
>    ))
> +  if have_sdl_clipboard
> +    sdl_ss.add(files('sdl2-clipboard.c'))
> +  endif
>    sdl_ss.add(when: opengl, if_true: files('sdl2-gl.c'))
>    sdl_ss.add(when: x11, if_true: files('x_keymap.c'))
>    ui_modules +=3D {'sdl' : sdl_ss}
> diff --git a/ui/sdl2-clipboard.c b/ui/sdl2-clipboard.c
> new file mode 100644
> index 0000000000..e50ff11d5a
> --- /dev/null
> +++ b/ui/sdl2-clipboard.c
> @@ -0,0 +1,154 @@
> +/*
> + * SDL UI -- clipboard support (improved async version)
> + *

drop the "(improved async version)"

> + * Copyright (C) 2023 Kamay Xutax <admin@xutaxkamay.com>
> + * Copyright (C) 2025 startergo <startergo@protonmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "ui/console.h"
> +#include "ui/clipboard.h"
> +#include "ui/sdl2.h"
> +#include "qemu/log.h"
> +
> +#ifdef CONFIG_SDL_CLIPBOARD

this condition is unnecessary if the unit is already filtered out by meson

> +
> +/* Track pending clipboard requests to handle async data */
> +typedef struct {
> +    struct sdl2_console *scon;
> +    QemuClipboardInfo *info;
> +    QemuClipboardType type;
> +} SDLClipboardRequest;
> +
> +static SDLClipboardRequest *pending_request =3D NULL;
> +
> +static void sdl2_clipboard_clear_pending(void)
> +{
> +    if (pending_request) {
> +        if (pending_request->info) {
> +            qemu_clipboard_info_unref(pending_request->info);
> +        }
> +        g_free(pending_request);
> +        pending_request =3D NULL;

or g_clear_pointer(&pending_request, g_free)

> +    }
> +}
> +
> +static void sdl2_clipboard_notify(Notifier *notifier, void *data)
> +{
> +    QemuClipboardNotify *notify =3D data;
> +    struct sdl2_console *scon =3D
> +        container_of(notifier, struct sdl2_console, cbpeer.notifier);
> +    bool self_update =3D notify->info->owner =3D=3D &scon->cbpeer;
> +    const char *text_data;
> +    size_t text_size;
> +
> +    switch (notify->type) {
> +    case QEMU_CLIPBOARD_UPDATE_INFO:
> +        {
> +            /* Skip self-updates to avoid clipboard manager conflicts */
> +            if (self_update) {
> +                return;
> +            }
> +
> +            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].available=
) {
> +                return;
> +            }
> +
> +            /* Check if this is completion of our pending request */
> +            if (pending_request && pending_request->info =3D=3D notify->=
info &&
> +                pending_request->type =3D=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> +                sdl2_clipboard_clear_pending();
> +            }
> +
> +            /* Check if data is available, request asynchronously if not=
 */
> +            if (!notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].data) {
> +                if (!pending_request) {
> +                    pending_request =3D g_new0(SDLClipboardRequest, 1);
> +                    pending_request->scon =3D scon;
> +                    pending_request->info =3D qemu_clipboard_info_ref(no=
tify->info);
> +                    pending_request->type =3D QEMU_CLIPBOARD_TYPE_TEXT;
> +                    qemu_clipboard_request(notify->info, QEMU_CLIPBOARD_=
TYPE_TEXT);

There is a risk of requesting clipboard text, getting nothing back,
and going in a loop. It should handle that.

> +                }
> +                return;
> +            }
> +
> +            /* Process available data */
> +            text_size =3D notify->info->types[QEMU_CLIPBOARD_TYPE_TEXT].=
size;
> +            if (text_size =3D=3D 0) {
> +                return;
> +            }
> +
> +            text_data =3D (const char *)notify->info->types[QEMU_CLIPBOA=
RD_TYPE_TEXT].data;
> +
> +            /* Ensure null termination for SDL clipboard */
> +            g_autofree char *text =3D g_strndup(text_data, text_size);
> +            if (text && text[0] !=3D '\0') {
> +                SDL_SetClipboardText(text);
> +            } else if (!text) {

At this point text_data !=3D NULL and text_size !=3D 0, in this case
g_strndup() will never return NULL. If OOM, the process will abort()
before that.

> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "SDL clipboard: Failed to allocate memory =
for clipboard text\n");

you will drop this then

> +            }
> +            break;
> +        }
> +    case QEMU_CLIPBOARD_RESET_SERIAL:
> +        sdl2_clipboard_clear_pending();

you can ignore this, just like gtk-clipboard

> +        break;
> +    }
> +}
> +
> +static void sdl2_clipboard_request(QemuClipboardInfo *info,
> +                                   QemuClipboardType type)
> +{
> +    g_autofree char *text =3D NULL;
> +
> +    if (type !=3D QEMU_CLIPBOARD_TYPE_TEXT) {
> +        return;
> +    }
> +
> +    text =3D SDL_GetClipboardText();
> +    if (!text) {

SDL_GetClipboardText doc says: Returns the clipboard text on success
or an empty string on failure..Caller must call SDL_free() on the
returned pointer when done with it (even if there was an error).

if (!text || !text[0])

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SDL clipboard: Failed to get clipboard text: %s\n=
",
> +                      SDL_GetError());

use warn_report() && call SDL_free(text)

> +        return;
> +    }
> +
> +    qemu_clipboard_set_data(info->owner, info, type,
> +                            strlen(text), text, true);
> +}
> +
> +void sdl2_clipboard_init(struct sdl2_console *scon)
> +{
> +    scon->cbpeer.name =3D "sdl2-clipboard";
> +    scon->cbpeer.notifier.notify =3D sdl2_clipboard_notify;
> +    scon->cbpeer.request =3D sdl2_clipboard_request;
> +
> +    qemu_clipboard_peer_register(&scon->cbpeer);
> +}
> +
> +void sdl2_clipboard_handle_request(struct sdl2_console *scon)

The function should be renamed, see below.

> +{
> +    g_autofree char *text =3D NULL;
> +    QemuClipboardInfo *info;
> +
> +    text =3D SDL_GetClipboardText();

instead of requesting the content immediately here, we should wait for
an actual guest/peer request. This will remove the duplication of code
to actually get the content.

> +    if (!text) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SDL clipboard: Failed to get clipboard text: %s\n=
",
> +                      SDL_GetError());
> +        return;
> +    }
> +
> +    if (text[0] =3D=3D '\0') {
> +        return; /* Ignore empty clipboard */
> +    }
> +
> +    info =3D qemu_clipboard_info_new(&scon->cbpeer, QEMU_CLIPBOARD_SELEC=
TION_CLIPBOARD);
> +    qemu_clipboard_set_data(&scon->cbpeer, info, QEMU_CLIPBOARD_TYPE_TEX=
T,
> +                            strlen(text), text, true);

This will simply be qemu_clipboard_update(info)

> +    qemu_clipboard_info_unref(info);
> +}
> +
> +#endif /* CONFIG_SDL_CLIPBOARD */
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index cda4293a53..00a17b68a7 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -691,6 +691,11 @@ void sdl2_poll_events(struct sdl2_console *scon)
>          case SDL_WINDOWEVENT:
>              handle_windowevent(ev);
>              break;
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        case SDL_CLIPBOARDUPDATE:
> +            sdl2_clipboard_handle_request(scon);

It's not a request, it's an update. Please rename the function accordingly.

> +            break;
> +#endif
>          default:
>              break;
>          }
> @@ -901,6 +906,10 @@ static void sdl2_display_init(DisplayState *ds, Disp=
layOptions *o)
>          }
>          register_displaychangelistener(&sdl2_console[i].dcl);
>
> +#ifdef CONFIG_SDL_CLIPBOARD
> +        sdl2_clipboard_init(&sdl2_console[i]);
> +#endif
> +
>  #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
>          if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
>  #if defined(SDL_VIDEO_DRIVER_WINDOWS)
> --
> 2.50.1
>
>


--
Marc-Andr=C3=A9 Lureau

