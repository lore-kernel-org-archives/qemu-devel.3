Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACF2E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 07:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTFI7-000435-Js; Thu, 02 Jan 2025 02:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTFI5-00042v-Eb
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:06:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTFI3-0001Da-6d
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:06:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso98192045e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 23:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735801601; x=1736406401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6BaCjE5enx78osRlk9cvV9Ue3gTky5y4F3hsrMtXnw=;
 b=LcA8qia5vbalrnFObKHiaq0NV1TpilcDAOgJzQcWe8s4RC74htNp9G2Z8KBDr5FU9p
 tjTWxs7103WujdRpKZWouaEheoOdIlFVtY2ZARtQnf8I4S1G0Gdvrs43bsJ1wcsEbSH8
 VkSAwCKmiOH48+1lB2H1CVs4agzh3e5zVvzgoabgz1ZGkU2ZM1CH6wywQu4SIDzycJPq
 rq6CcLOy2abT7KpXo4WdYTJ7a3lXkSOMz/EPkWytZZ2ZB2T02aRxfqa0bxzYyv5AzSrR
 qsoNzOxW3fjJGti2nDsrdM8V9crM6d3+rD3OXmLI0WAgNC0LwVNEnNB4Msvpa19xtWjk
 X9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735801601; x=1736406401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6BaCjE5enx78osRlk9cvV9Ue3gTky5y4F3hsrMtXnw=;
 b=eX3dGr7UHHf5L1jgaLFQV0uuBL8bq1V6I238cbpfeozLdTR2fAomvwXMm4EPh5Tnko
 efQ4qbIf2OOzhHzCW6kBLfQFD2WLhzA/EwkuNIe6w6pij+SyPCut0xygEVAyLx4Blozr
 KLaM7tAPdpbMKDXfFAddh15XAFH3XBaUbJIKHylsPoOyeToiqBZrqSv7gJecrGIefB0x
 JmmtQdAUT/8+IhEdMVKezH7rk6BZlzqnY5IefHwT0rVW2y/DBL/VT+mgaaqfTJt5bNj9
 QfK7ymGvgiAMrdQvnxPAlS+jjW/vB7svT/MWax4721EZycBe6pRXh2ab9Y0LhUucoKLa
 +9dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaSvtUkorEX2bRwAD+zidxqWdRKi15t6vywX6wgdDuxYwhgswbcXJjelcx7w8sq8xPJk2Xycyg99GK@nongnu.org
X-Gm-Message-State: AOJu0YyTu+82lJ1emBMrEXOphEg1Cv4NX2xCJ21UKaAm8WUiXONg+CqP
 5haD0JSt6k/aber12MTomqwKB4AcLUj4NvV1oRIHB6JYdvNQz3/SfGtBqLsUNDg=
X-Gm-Gg: ASbGnctyIRsBspHPdWwbbANdTrh0Jo/Zgk7J5b/O4dR65NoaQ/zVsVvcKmYuvYFxjUL
 w5MV0ufrA5MajMWsDNz2RRMeq9PiNIAdy6N2AaXlIhZp/nk0C8AGD7kD2Frvg0d+9/rwf7VwzNp
 oeDdauYKGxkeRPXB6saYw34bsfm9d2wEFnn/YaHFr+hA3Lvsd6C+hduZGyt0j7erv7r3hlq1M3w
 ceu8F+GjNbyeqTMmZPwh+017AmVS41T3+zeVJ6k/S1e3PvME2YAso8euUvfFGZMLrsVcMW5Zn2j
 t9xoSIiK+9U7WpBrKTP9pfY+
X-Google-Smtp-Source: AGHT+IGsyvhCQUXPxjurisHRkQV/rEdR0cM9xvyaJ814/nX47JQ//NFehI8L2OkVSfv6ZOCBZUaaDg==
X-Received: by 2002:adf:a19c:0:b0:38a:50f7:23fe with SMTP id
 ffacd0b85a97d-38a50f72528mr10746815f8f.56.1735801600649; 
 Wed, 01 Jan 2025 23:06:40 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e1bsm37096787f8f.31.2025.01.01.23.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2025 23:06:40 -0800 (PST)
Message-ID: <b1fb1999-8bfa-4238-b366-f31c4b1e0db8@linaro.org>
Date: Thu, 2 Jan 2025 08:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ui/sdl2: reenable the SDL2 Windows keyboard hook
 procedure
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexander von Gluck IV <kallisti5@unixzen.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org
References: <20241231115950.6732-1-vr_qemu@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241231115950.6732-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Volker,

On 31/12/24 12:59, Volker Rümelin wrote:
> Windows only:
> 
> The libSDL2 Windows message loop needs the libSDL2 Windows low
> level keyboard hook procedure to grab the left and right Windows
> keys correctly. Reenable the SDL2 Windows keyboard hook procedure.
> 
> Since SDL2 2.30.4 the SDL2 keyboard hook procedure also filters
> out the special left Control key event for every Alt Gr key event
> on keyboards with an international layout. This means the QEMU low
> level keyboard hook procedure is no longer needed. Remove the QEMU
> Windows keyboard hook procedure.

Cc'ing Alexander & Thomas because I wonder if Haiku isn't using
an older version (SDL 2.0.8).

Should we require a minimum version in meson?

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
> 
> v2: Remove the QEMU lowlevel keyboard hook procedure from the
> SDL2 UI backend.
> 
> v3: Rebase to current master because of a merge conflict.
> 
>   ui/meson.build |  4 ----
>   ui/sdl2.c      | 26 --------------------------
>   2 files changed, 30 deletions(-)
> 
> diff --git a/ui/meson.build b/ui/meson.build
> index 28c7381dd1..35fb04cadf 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -120,10 +120,6 @@ if gtk.found()
>   endif
>   
>   if sdl.found()
> -  if host_os == 'windows'
> -    system_ss.add(files('win32-kbd-hook.c'))
> -  endif
> -
>     sdl_ss = ss.source_set()
>     sdl_ss.add(sdl, sdl_image, pixman, glib, files(
>       'sdl2-2d.c',
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 1fb72f67a6..2cb95a6b7c 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -32,7 +32,6 @@
>   #include "system/runstate.h"
>   #include "system/runstate-action.h"
>   #include "system/system.h"
> -#include "ui/win32-kbd-hook.h"
>   #include "qemu/log.h"
>   
>   static int sdl2_num_outputs;
> @@ -262,7 +261,6 @@ static void sdl_grab_start(struct sdl2_console *scon)
>       }
>       SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
>       gui_grab = 1;
> -    win32_kbd_set_grab(true);
>       sdl_update_caption(scon);
>   }
>   
> @@ -270,7 +268,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
>   {
>       SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
>       gui_grab = 0;
> -    win32_kbd_set_grab(false);
>       sdl_show_cursor(scon);
>       sdl_update_caption(scon);
>   }
> @@ -371,19 +368,6 @@ static int get_mod_state(void)
>       }
>   }
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
>   static void handle_keydown(SDL_Event *ev)
>   {
>       int win;
> @@ -608,10 +592,6 @@ static void handle_windowevent(SDL_Event *ev)
>           sdl2_redraw(scon);
>           break;
>       case SDL_WINDOWEVENT_FOCUS_GAINED:
> -        win32_kbd_set_grab(gui_grab);
> -        if (qemu_console_is_graphic(scon->dcl.con)) {
> -            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
> -        }
>           /* fall through */
>       case SDL_WINDOWEVENT_ENTER:
>           if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
> @@ -627,9 +607,6 @@ static void handle_windowevent(SDL_Event *ev)
>           scon->ignore_hotkeys = get_mod_state();
>           break;
>       case SDL_WINDOWEVENT_FOCUS_LOST:
> -        if (qemu_console_is_graphic(scon->dcl.con)) {
> -            win32_kbd_set_window(NULL);
> -        }
>           if (gui_grab && !gui_fullscreen) {
>               sdl_grab_end(scon);
>           }
> @@ -869,10 +846,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>   #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
>       SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
>   #endif
> -#ifndef CONFIG_WIN32
> -    /* QEMU uses its own low level keyboard hook procedure on Windows */
>       SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
> -#endif
>   #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
>       SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>   #endif


