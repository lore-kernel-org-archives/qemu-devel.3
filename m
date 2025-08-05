Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA0CC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 12:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujGeg-0004Q2-JE; Tue, 05 Aug 2025 08:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujGeU-0004LX-KW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:20:26 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujGeS-0003lF-Ci
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:20:22 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7e29616cc4fso501051285a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754396418; x=1755001218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjwu3X6p10c/nSK6weEvSAS+qWcobjDJV9L/hIgZd7w=;
 b=HNu0XHlU/CL3RO+rINZPbZuQCAhRvkr30Pnkm4XMaBmG/OUhC3hm7sGOkDRcOOqOcf
 6JBm3IxA4N6/6+8RgSgxi0HIbSIUA4M82Zcszsiu8MkiqQ0SEHsic6X16r0A8hS6BAmL
 pieJ6pyYfq/rSYvkxjl0P4z306yZ+VTzBWS/UIMYBndX7fBGGAe4fYiAj7tH+eQ6elbD
 3u9yOvw2e7aAEOBTFDF4pwTZ3pjfZxe0zIYWZWZkp0E5IG50YG0bIvn3BVc4GuGnmn/4
 fUThXm6tpc3kUkVjhngT6EchWRcbVNdIOBalNq7arDaPFWpyl83Jiag66eOz+dOi491o
 weaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754396418; x=1755001218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjwu3X6p10c/nSK6weEvSAS+qWcobjDJV9L/hIgZd7w=;
 b=YyqFTEIkJ9EvyM/OlnI8d+seF73Bpyh0IX2fR4dCw7QdJPhO96DPYVRpomROukIjzx
 quHM1LZ3rZiWiTv43fTII+cAJQd37Q5g9MrzjndOAIDEwZGOjmk3E6lk7c/P7eaQs5JV
 nAbGqsECuq8oycf7NKhk1MH8nxEDIlUEgaPAIyxbe//eJgPSYcNIryAcBeuEziIJrK79
 A/wwgwkw6anpaNCpqA8sr7xnBAGuBxIpOoajVcTbasNyaMFT5IKotr5eOfaG43QJpXPA
 uYIRnpnSF+FWTBGHNM+EfO5AgFV5f3DzV/LX9X4UWb9SgR7YqG/oqzpSql8faIeb52AO
 3g3A==
X-Gm-Message-State: AOJu0YwBdDRQJl0lG3pmoGzobIuWXomGA+61f/xyJub4aRN7zUV4I9Jp
 bwX7/scinZ1gBvfPDGop0rpXpnuLs2Bw34PDTu+2V6ceUqFmPcVjicwk7jQdazsHhDvm5K2Tl34
 kFE8tNeKMSL0g1GAOOuAgYpN+G0cE+4Y=
X-Gm-Gg: ASbGncsAprs9VzZN5exJY5dOn0+YlGxhZ27xxBVdsdLUebkrbYAvUTdBRHowQDYQ1bG
 F7hbzzd7/bC1+JAgfmuWu1EZBZA8i7VOZvL4GuvMq2wK24sj6tJOTwBZC93L3Htn3+2+KcLjCS0
 BjD12mhRQ59MsFeNlMnUXTPlv5SLeDu4G2Vlb3+1IfYA53Mmt1ATTE9L9tY4nj32TJWDd3EJH0D
 13smlXSlMyztIUiPvJWtt4hQ70hBw==
X-Google-Smtp-Source: AGHT+IFiKZsqeM61JTngUd/hcXyj1C0eY7UJ1Hq6Tssyo1SE1OCJ8qCYiDuSwMR8W+rDTsPEkAY57jZ6E6UAShQzRjw=
X-Received: by 2002:a05:620a:45a4:b0:7e6:9746:8acd with SMTP id
 af79cd13be357-7e697468c42mr1619723285a.49.1754396418040; Tue, 05 Aug 2025
 05:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <P4yQC2DHhjwCsAB9YmHj30-Ybx2BJiE3DZ4t8bxbQcDHNQSE-BctQB15IqJ9A-F-C4rHwSUAXuUiU4CEiqMCsIpS6bWVdft88xOlEArjP94=@protonmail.com>
In-Reply-To: <P4yQC2DHhjwCsAB9YmHj30-Ybx2BJiE3DZ4t8bxbQcDHNQSE-BctQB15IqJ9A-F-C4rHwSUAXuUiU4CEiqMCsIpS6bWVdft88xOlEArjP94=@protonmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 5 Aug 2025 16:20:05 +0400
X-Gm-Features: Ac12FXxtopbiNzSMvxYaGzVMzhGO1pW9DT5lI39DPWYuPo-Bx3MlHbg-yOcOPys
Message-ID: <CAJ+F1C+dCJMyD9MhWTB-JWngyYoGdXAc+aZTjJ+C_y=vfR6ecg@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Add SDL clipboard support
To: startergo <startergo@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x736.google.com
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

This is still not a correctly formatted git patch:

$ git am \[PATCH\]\ ui_sdl2_\ Add\ SDL\ clipboard\ support.eml
warning: quoted CRLF detected
Applying: ui/sdl2: Add SDL clipboard support
error: corrupt patch at line 16
Patch failed at 0001 ui/sdl2: Add SDL clipboard support

Please make sure you follow:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html

thanks

On Tue, Aug 5, 2025 at 3:54=E2=80=AFPM startergo <startergo@protonmail.com>=
 wrote:
>
> From 89affd7e5b1ac9fcf9f10e483d9e4e63328a42fa Mon Sep 17 00:00:00 2001
> From: startergo <startergo@protonmail.com>
> Date: Thu, 31 Jul 2025 19:36:07 +0300
> Subject: [PATCH 1/1] ui/sdl2: Add SDL clipboard support
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com,
>     marcandre.lureau@redhat.com
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
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "SDL clipboard: Failed to allocate memory =
for clipboard text\n");
> +            }
> +            break;
> +        }
> +    case QEMU_CLIPBOARD_RESET_SERIAL:
> +        sdl2_clipboard_clear_pending();
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
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SDL clipboard: Failed to get clipboard text: %s\n=
",
> +                      SDL_GetError());
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
> +{
> +    g_autofree char *text =3D NULL;
> +    QemuClipboardInfo *info;
> +
> +    text =3D SDL_GetClipboardText();
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


--=20
Marc-Andr=C3=A9 Lureau

