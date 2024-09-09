Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BD3E6FE49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 07:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snYnF-0003sG-Kr; Mon, 09 Sep 2024 03:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1snYnE-0003rl-Bo
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 03:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1snYnC-000224-Dk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 03:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725866790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+ud1BzBgPkV+8qCLrmMgUkHgtjUhjMYmKC8rYictp0=;
 b=WFBbn1omis11t1bBaPHNAvQRsHPhoweuq21wek5KFd2C0RJO5EQi3IxmsEEWsad8wajWGg
 RczLqLYPmCSTQYEw9Ptx3HElWK0z3jQawc0lfsMT94MCHPD+ulu3nsGI3f/hKfnmQMi309
 GKW7i2RI+nWH8L9eRsjHr0SR6IkQ5RY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ZLMXxh8kODOiP8KLIuLWuA-1; Mon, 09 Sep 2024 03:26:27 -0400
X-MC-Unique: ZLMXxh8kODOiP8KLIuLWuA-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-49bdf2d6643so1247548137.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 00:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725866786; x=1726471586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+ud1BzBgPkV+8qCLrmMgUkHgtjUhjMYmKC8rYictp0=;
 b=rIo7uhIU4AzmiUkAJnwwDGYRxpxIqLuT/p6m8fL9CfyB3vq6pkVsRHI9YQ900GWqHi
 lHs6vdSIPD7Kgchr1M3Y6TzZN/jXtPqcVKRs9uOAleraulzERggMgOD+KM73YRkVcIuL
 fUf9RtqiLAYRqL44jkj7BDmejkFphwwpiTMeAM8B88uGZ+tJdkJpmKOmh6v/DxNeSvnt
 Z4rNIXUetZVn11pQh+kwxaoD1qJucSW+bI181ZPe829EGNVRWQoHJNfx30rTPuv+Em7c
 7/l6ggA2O911W4Y8lcnZ73g4IsVQQLNIrfoakJJFQaUPY9nfNJ8lcHbuBLh6vVnRPc8q
 v3eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwNSGI5/aOnEtqGcUq9lpWdmU/K3+wkLRC1zPhhs/TQisgf0NOdDA6a1USiwKi2KKl9Pduv+PBWkBj@nongnu.org
X-Gm-Message-State: AOJu0Yw1M7Wk+9ho+PMBhitrreoEWhML7P9dsPfXDl1wP2kYFYtXMm2G
 FFjCSPhdnf7o/g4Z0WTFGQEAD6UzPZVjzfiJFExBZ/cHdAvc26ydN2vXqjihyH/sIH7HiHF9I5Z
 VHSEJ6eWPmePaetfxN46mJbm1oGATNPISP3gEh+LOPZsROJshqwE3fkiYlBmoMrrW/18XZ/YMju
 SKFCxeZuM7aMH0fbEfFkFaWsVmweg=
X-Received: by 2002:a05:6102:941:b0:497:50c0:a6cb with SMTP id
 ada2fe7eead31-49bde262e6emr10464235137.19.1725866786211; 
 Mon, 09 Sep 2024 00:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyzjjC6vcNvX6cvObHARFiyMElrw8HkKcNJ/o9IHdjTAurn4RtN7kbitfavrNEq4lVL7mHnFcL0P3N8Agqryo=
X-Received: by 2002:a05:6102:941:b0:497:50c0:a6cb with SMTP id
 ada2fe7eead31-49bde262e6emr10464214137.19.1725866785806; Mon, 09 Sep 2024
 00:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
 <20240909061552.6122-1-vr_qemu@t-online.de>
In-Reply-To: <20240909061552.6122-1-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 9 Sep 2024 11:26:14 +0400
Message-ID: <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 9, 2024 at 10:22=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> Windows only:
>
> The libSDL2 Windows message loop needs the libSDL2 Windows low
> level keyboard hook procedure to grab the left and right Windows
> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
>
> Because the QEMU Windows keyboard hook procedure is still needed
> to filter out the special left Control key event for every Alt Gr
> key event, it's important to install the two keyboard hook
> procedures in the following order. First the SDL2 procedure, then
> the QEMU procedure.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  ui/sdl2.c           | 53 ++++++++++++++++++++++++++++++---------------
>  ui/win32-kbd-hook.c |  3 +++
>  2 files changed, 38 insertions(+), 18 deletions(-)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 98ed974371..ac37c173a1 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -42,6 +42,7 @@ static SDL_Surface *guest_sprite_surface;
>  static int gui_grab; /* if true, all keyboard/mouse events are grabbed *=
/
>  static bool alt_grab;
>  static bool ctrl_grab;
> +static bool win32_kbd_grab;
>
>  static int gui_saved_grab;
>  static int gui_fullscreen;
> @@ -202,6 +203,19 @@ static void sdl_update_caption(struct sdl2_console *=
scon)
>      }
>  }
>
> +static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
> +{
> +#ifdef CONFIG_WIN32
> +    SDL_SysWMinfo info;
> +
> +    SDL_VERSION(&info.version);
> +    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
> +        return info.info.win.window;
> +    }
> +#endif
> +    return NULL;
> +}
> +
>  static void sdl_hide_cursor(struct sdl2_console *scon)
>  {
>      if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
> @@ -259,9 +273,16 @@ static void sdl_grab_start(struct sdl2_console *scon=
)
>      } else {
>          sdl_hide_cursor(scon);
>      }
> +    /*
> +     * Windows: To ensure that QEMU's low level keyboard hook procedure =
is
> +     * called before SDL2's, the QEMU procedure must first be removed an=
d
> +     * then the SDL2 and QEMU procedures must be installed in this order=
.
> +     */
> +    win32_kbd_set_window(NULL);
>      SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
> +    win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>      gui_grab =3D 1;
> -    win32_kbd_set_grab(true);
> +    win32_kbd_set_grab(win32_kbd_grab);
>      sdl_update_caption(scon);
>  }
>
> @@ -370,19 +391,6 @@ static int get_mod_state(void)
>      }
>  }
>
> -static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
> -{
> -#ifdef CONFIG_WIN32
> -    SDL_SysWMinfo info;
> -
> -    SDL_VERSION(&info.version);
> -    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
> -        return info.info.win.window;
> -    }
> -#endif
> -    return NULL;
> -}
> -
>  static void handle_keydown(SDL_Event *ev)
>  {
>      int win;
> @@ -605,7 +613,7 @@ static void handle_windowevent(SDL_Event *ev)
>          sdl2_redraw(scon);
>          break;
>      case SDL_WINDOWEVENT_FOCUS_GAINED:
> -        win32_kbd_set_grab(gui_grab);
> +        win32_kbd_set_grab(win32_kbd_grab && gui_grab);
>          if (qemu_console_is_graphic(scon->dcl.con)) {
>              win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>          }
> @@ -849,6 +857,7 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
>      uint8_t data =3D 0;
>      int i;
>      SDL_SysWMinfo info;
> +    SDL_version ver;
>      SDL_Surface *icon =3D NULL;
>      char *dir;
>
> @@ -866,10 +875,7 @@ static void sdl2_display_init(DisplayState *ds, Disp=
layOptions *o)
>  #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available sin=
ce SDL 2.0.8 */
>      SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
>  #endif
> -#ifndef CONFIG_WIN32
> -    /* QEMU uses its own low level keyboard hook procedure on Windows */
>      SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
> -#endif
>  #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
>      SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>  #endif
> @@ -877,6 +883,17 @@ static void sdl2_display_init(DisplayState *ds, Disp=
layOptions *o)
>      SDL_EnableScreenSaver();
>      memset(&info, 0, sizeof(info));
>      SDL_VERSION(&info.version);
> +    /*
> +     * Since version 2.16.0 under Windows, SDL2 has its own low level
> +     * keyboard hook procedure to grab the keyboard. The remaining task =
of
> +     * QEMU's low level keyboard hook procedure is to filter out the spe=
cial
> +     * left Control up/down key event for every Alt Gr key event on keyb=
oards
> +     * with an international layout.
> +     */
> +    SDL_GetVersion(&ver);
> +    if (ver.major =3D=3D 2 && ver.minor < 16) {
> +        win32_kbd_grab =3D true;
> +    }
>

Note: there is no 2.16 release. They jumped from 2.0.22 to 2.24 (see
https://github.com/libsdl-org/SDL/releases/tag/release-2.24.0)

The windows hook was indeed added in 2.0.16, released on Aug 10, 2021.

Given the distribution nature of the Windows binaries, I think we
could simply depend on a much recent version without worrying about
compatibility with < 2.0.16. This would help reduce the potential
combinations of versions and bugs reports.

>      gui_fullscreen =3D o->has_full_screen && o->full_screen;
>
> diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
> index 1ac237db9e..39d42134a2 100644
> --- a/ui/win32-kbd-hook.c
> +++ b/ui/win32-kbd-hook.c
> @@ -91,6 +91,9 @@ void win32_kbd_set_window(void *hwnd)
>              win32_unhook_notifier.notify =3D keyboard_hook_unhook;
>              qemu_add_exit_notifier(&win32_unhook_notifier);
>          }
> +    } else if (!hwnd && win32_keyboard_hook) {
> +        keyboard_hook_unhook(&win32_unhook_notifier, NULL);
> +        qemu_remove_exit_notifier(&win32_unhook_notifier);
>      }
>
>      win32_window =3D hwnd;
> --
> 2.35.3
>


