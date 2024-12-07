Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC61E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 12:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJuCz-00008j-Ad; Sat, 07 Dec 2024 07:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tJuCm-00007O-2W
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 07:46:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tJuCj-0004b6-FM
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 07:46:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434e84b65e7so5849545e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733575591; x=1734180391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdvUB1tBDRiOx5Ver3+35U23ee89rG/OZPFdVcW6QhI=;
 b=DYS0rsZNqWzJtOyshrRpC1GCsFlVog1i2ayp980AAmyWBwgqUpQxxWWHIaUg1il0Ji
 iTjq8P3mnscxMjcwGg4yTkhhzfhh6HDOvq99tH9Men+Nxp6IHqE25ieOCHOYEX2za0bK
 AKvnRKpHDoswDanpxsASQ1wmW+1kIUVe8BoEuFauX7kTEHHfWcOMPh6W3Q3qvf5yLOMP
 MOrbp2SsWolbRsvggQzDiCpyBI7K8ip3MFBXfcQawIu1UU8zp8LEcNlSexxD8V+ocIxg
 OfAIcpaWWS6EBWrMBDWfvoQ7UgmR4iLt4dv3QzAmAHH9O3ZfQZRBToU2La8YMbAsCTqE
 W2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733575591; x=1734180391;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdvUB1tBDRiOx5Ver3+35U23ee89rG/OZPFdVcW6QhI=;
 b=uo08ekP27V9Ta3IFfi0ZGtSS1N3jSgRnf0PYGTaEWX2vI9vf3x1FSm0mV1Fb7oXj2s
 U1U0yB/ajOhKn6iKpSCihKVJFVjIRVjPpRthVRzj2IVNdgJvYjXuD72EW+NlL9bLdt9s
 /11UQtn9lb75ElubpnCYbsVRmgcIW3wJBB0WbP8PLodCMWVQPZuUzpf8slybBXDj1fUt
 Jjd4Y2lJqWrrhiI+jZ0T5zgWY8uK8UeU1TzBs2euk+OhEG1EMKgu+9T2rh1rlYqMb+Qw
 MhmCZ6PnApYbWlhctpCTJ24Sz1JaA+rPVD6wPprITYVD+OG/CcQkIe6BC2aD6jaLs1Fm
 X6Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqK6qgmal6fAvrQ1v4ZS7mi1mvG3pcIsgXiVrtOPg2DlWZnd7VGlRTiRcojqI+kI9ZfhCZ+Y0Qpm/f@nongnu.org
X-Gm-Message-State: AOJu0YzBZVpCAds7XsMqwth1GtMKAbr+JfDNlPPBXwD/76a2SnlLNQOG
 HtG6UPrHJxidrZCqcS1j3bvEcwj7/QdIjvmEQ8CpxTmrjxnJzXUCfPtzAQ==
X-Gm-Gg: ASbGncsH7tTk95QMvWihZswlJvVQhFLlMWzYM7G0KpuvQ7MqUVLZv36hA8OClnZM7gt
 dFDml0ezq6lt8Wzp485YNTinPYTxgsHj+SrN5EBgQatUb5Ifl0+IlmrTYHNp/aCOJtFY6DDYiJU
 zocoWNWWNFnvUaozOCNqNXJW5YQUWSQdLh5litcdRMGXhoMZej5BuKFiiHimFA5BMyPEEcIszs5
 jNqvefFLZbT7W5NmCNw5H/BwyFfeFxeOUxq+Lj8Ibsp2aGt7jsCSesK8j+9VEllka5olH2MIuv6
 zLX0fjzlaC1EXawZSLwsJy64
X-Google-Smtp-Source: AGHT+IH3GNZVqWcGtE80FpSBbDj4Q/GKjkgLP5xuGfb0LYatyfL4odxmTfqrtdR5BBg5i/ewAQH40Q==
X-Received: by 2002:a05:600c:3b1d:b0:434:a5bc:7103 with SMTP id
 5b1f17b1804b1-434ddeade1cmr51706925e9.19.1733575591017; 
 Sat, 07 Dec 2024 04:46:31 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-055-182-161.78.55.pool.telefonica.de.
 [78.55.182.161]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434ea1ae415sm15324325e9.33.2024.12.07.04.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Dec 2024 04:46:30 -0800 (PST)
Date: Sat, 07 Dec 2024 12:46:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
CC: Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>,
 qemu-devel@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/3=5D_ui/sdl2=3A_reenable_the?=
 =?US-ASCII?Q?_SDL2_Windows_keyboard_hook_procedure?=
In-Reply-To: <69b15684-0d00-4a74-aeac-2d98f7e88d95@t-online.de>
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
 <20240909061552.6122-1-vr_qemu@t-online.de>
 <CAMxuvay4vRm6ZYQoUx=cmD5mr-8-qR4Z4iLEJ6-f0m2eUSbdOg@mail.gmail.com>
 <69b15684-0d00-4a74-aeac-2d98f7e88d95@t-online.de>
Message-ID: <90F0F2BF-CD32-45D8-8BFB-2B973E95BB9B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 9=2E September 2024 19:38:26 UTC schrieb "Volker R=C3=BCmelin" <vr_qemu=
@t-online=2Ede>:
>Am 09=2E09=2E24 um 09:26 schrieb Marc-Andr=C3=A9 Lureau:
>> Hi
>>
>> On Mon, Sep 9, 2024 at 10:22=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-=
online=2Ede> wrote:
>>> Windows only:
>>>
>>> The libSDL2 Windows message loop needs the libSDL2 Windows low
>>> level keyboard hook procedure to grab the left and right Windows
>>> keys correctly=2E Reenable the SDL2 Windows keyboard hook procedure=2E
>>>
>>> Because the QEMU Windows keyboard hook procedure is still needed
>>> to filter out the special left Control key event for every Alt Gr
>>> key event, it's important to install the two keyboard hook
>>> procedures in the following order=2E First the SDL2 procedure, then
>>> the QEMU procedure=2E
>>>
>>> Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2139
>>> Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2323
>>> Tested-by: Howard Spoelstra <hsp=2Ecat7@gmail=2Ecom>
>>> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online=2Ede>
>>> ---
>>>  ui/sdl2=2Ec           | 53 ++++++++++++++++++++++++++++++------------=
---
>>>  ui/win32-kbd-hook=2Ec |  3 +++
>>>  2 files changed, 38 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/ui/sdl2=2Ec b/ui/sdl2=2Ec
>>> index 98ed974371=2E=2Eac37c173a1 100644
>>> --- a/ui/sdl2=2Ec
>>> +++ b/ui/sdl2=2Ec
>>> @@ -42,6 +42,7 @@ static SDL_Surface *guest_sprite_surface;
>>>  static int gui_grab; /* if true, all keyboard/mouse events are grabbe=
d */
>>>  static bool alt_grab;
>>>  static bool ctrl_grab;
>>> +static bool win32_kbd_grab;
>>>
>>>  static int gui_saved_grab;
>>>  static int gui_fullscreen;
>>> @@ -202,6 +203,19 @@ static void sdl_update_caption(struct sdl2_consol=
e *scon)
>>>      }
>>>  }
>>>
>>> +static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
>>> +{
>>> +#ifdef CONFIG_WIN32
>>> +    SDL_SysWMinfo info;
>>> +
>>> +    SDL_VERSION(&info=2Eversion);
>>> +    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
>>> +        return info=2Einfo=2Ewin=2Ewindow;
>>> +    }
>>> +#endif
>>> +    return NULL;
>>> +}
>>> +
>>>  static void sdl_hide_cursor(struct sdl2_console *scon)
>>>  {
>>>      if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
>>> @@ -259,9 +273,16 @@ static void sdl_grab_start(struct sdl2_console *s=
con)
>>>      } else {
>>>          sdl_hide_cursor(scon);
>>>      }
>>> +    /*
>>> +     * Windows: To ensure that QEMU's low level keyboard hook procedu=
re is
>>> +     * called before SDL2's, the QEMU procedure must first be removed=
 and
>>> +     * then the SDL2 and QEMU procedures must be installed in this or=
der=2E
>>> +     */
>>> +    win32_kbd_set_window(NULL);
>>>      SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
>>> +    win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>>>      gui_grab =3D 1;
>>> -    win32_kbd_set_grab(true);
>>> +    win32_kbd_set_grab(win32_kbd_grab);
>>>      sdl_update_caption(scon);
>>>  }
>>>
>>> @@ -370,19 +391,6 @@ static int get_mod_state(void)
>>>      }
>>>  }
>>>
>>> -static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
>>> -{
>>> -#ifdef CONFIG_WIN32
>>> -    SDL_SysWMinfo info;
>>> -
>>> -    SDL_VERSION(&info=2Eversion);
>>> -    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
>>> -        return info=2Einfo=2Ewin=2Ewindow;
>>> -    }
>>> -#endif
>>> -    return NULL;
>>> -}
>>> -
>>>  static void handle_keydown(SDL_Event *ev)
>>>  {
>>>      int win;
>>> @@ -605,7 +613,7 @@ static void handle_windowevent(SDL_Event *ev)
>>>          sdl2_redraw(scon);
>>>          break;
>>>      case SDL_WINDOWEVENT_FOCUS_GAINED:
>>> -        win32_kbd_set_grab(gui_grab);
>>> +        win32_kbd_set_grab(win32_kbd_grab && gui_grab);
>>>          if (qemu_console_is_graphic(scon->dcl=2Econ)) {
>>>              win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
>>>          }
>>> @@ -849,6 +857,7 @@ static void sdl2_display_init(DisplayState *ds, Di=
splayOptions *o)
>>>      uint8_t data =3D 0;
>>>      int i;
>>>      SDL_SysWMinfo info;
>>> +    SDL_version ver;
>>>      SDL_Surface *icon =3D NULL;
>>>      char *dir;
>>>
>>> @@ -866,10 +875,7 @@ static void sdl2_display_init(DisplayState *ds, D=
isplayOptions *o)
>>>  #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available =
since SDL 2=2E0=2E8 */
>>>      SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
>>>  #endif
>>> -#ifndef CONFIG_WIN32
>>> -    /* QEMU uses its own low level keyboard hook procedure on Windows=
 */
>>>      SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
>>> -#endif
>>>  #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
>>>      SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
>>>  #endif
>>> @@ -877,6 +883,17 @@ static void sdl2_display_init(DisplayState *ds, D=
isplayOptions *o)
>>>      SDL_EnableScreenSaver();
>>>      memset(&info, 0, sizeof(info));
>>>      SDL_VERSION(&info=2Eversion);
>>> +    /*
>>> +     * Since version 2=2E16=2E0 under Windows, SDL2 has its own low l=
evel
>>> +     * keyboard hook procedure to grab the keyboard=2E The remaining =
task of
>>> +     * QEMU's low level keyboard hook procedure is to filter out the =
special
>>> +     * left Control up/down key event for every Alt Gr key event on k=
eyboards
>>> +     * with an international layout=2E
>>> +     */
>>> +    SDL_GetVersion(&ver);
>>> +    if (ver=2Emajor =3D=3D 2 && ver=2Eminor < 16) {
>>> +        win32_kbd_grab =3D true;
>>> +    }
>>>
>> Note: there is no 2=2E16 release=2E They jumped from 2=2E0=2E22 to 2=2E=
24 (see
>> https://github=2Ecom/libsdl-org/SDL/releases/tag/release-2=2E24=2E0)
>
>Hi Marc-Andr=C3=A9
>
>Oh=2E This means that the comparison I wrote is true for SDL2 versions <
>2=2E24=2E0=2E
>
>>
>> The windows hook was indeed added in 2=2E0=2E16, released on Aug 10, 20=
21=2E
>>
>> Given the distribution nature of the Windows binaries, I think we
>> could simply depend on a much recent version without worrying about
>> compatibility with < 2=2E0=2E16=2E This would help reduce the potential
>> combinations of versions and bugs reports=2E
>
>Okay, I'll send a version 2 patch series=2E

Ping (for this patch, the others were merged)

>
>With best regards
>Volker
>
>>
>>>      gui_fullscreen =3D o->has_full_screen && o->full_screen;
>>>
>>> diff --git a/ui/win32-kbd-hook=2Ec b/ui/win32-kbd-hook=2Ec
>>> index 1ac237db9e=2E=2E39d42134a2 100644
>>> --- a/ui/win32-kbd-hook=2Ec
>>> +++ b/ui/win32-kbd-hook=2Ec
>>> @@ -91,6 +91,9 @@ void win32_kbd_set_window(void *hwnd)
>>>              win32_unhook_notifier=2Enotify =3D keyboard_hook_unhook;
>>>              qemu_add_exit_notifier(&win32_unhook_notifier);
>>>          }
>>> +    } else if (!hwnd && win32_keyboard_hook) {
>>> +        keyboard_hook_unhook(&win32_unhook_notifier, NULL);
>>> +        qemu_remove_exit_notifier(&win32_unhook_notifier);
>>>      }
>>>
>>>      win32_window =3D hwnd;
>>> --
>>> 2=2E35=2E3
>>>
>

