Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE394C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 08:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raAJ1-0004zA-AX; Wed, 14 Feb 2024 03:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1raAJ0-0004z2-Fz
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 03:07:46 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1raAIy-0004mT-SF
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 03:07:46 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-604a1581cffso48578357b3.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707898063; x=1708502863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kle6xP7rVSAp5ii5ldQQLPNraAGQveQSP72wimwu2j0=;
 b=i8m36L/MFeby1Rr6OJmNwi/2hkUH4jOi5kywatB/OcuyG7j8rNEO3bFk1pDVe7nZ0h
 f5m06HP+ajj2DkayzyXzn50ggNvZt7W1x1LJEFN+XfxVBNjWvvlLILcRpm80JVsQ3Ciy
 41Ydr2aWkMxOR6mCwoGT6AB5jAQYYTNDLQbrcTNK8bkxUna5pgKMb+aRotuqaIgUhuv2
 4aDX1b6Ead4pLE0ZK1vNt23AHBHjuVX+Gj/LQdwRez9vWtxwPQGcTQ/Vh9E4eJTJBDMe
 gs/03QAm30RLU/CW+58NTcN+USIQZoOOOookI7Jd7jSX5yOm1wEnTh8l3JTqT7cEfxZN
 VB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707898063; x=1708502863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kle6xP7rVSAp5ii5ldQQLPNraAGQveQSP72wimwu2j0=;
 b=VY8K1CqygUdAD9zx+uZSKebKZNae0mjd3xqqh2zglXOpT0BLkA10FFKbuDrMMbiiOD
 mlzgO2TT3a3O6c87/quryOcqYmI3hc3xl5RntcliwIYDgPb2WIUbLxPO2KX2HzkLR5CD
 c+xLsONssbmNXIWfZfIVdlOY8syhSKQrKQVqx5qpvxF4DKbnvvQaXkam5Rj4HFayVxsx
 GBXv02SitUECC1yipVBhQq5TA9NCxKCxymmNIISX8XIXVW0dDdyQhyLxOaoxG2F0lvhQ
 OW/IszTE/sDcyB69keNWQBsuyRtdbABKIX+0t1xTh4x+hh4FvkngeUlEErQRc4D4uGH/
 iOBA==
X-Gm-Message-State: AOJu0Yyk5bjIedjjdnafzbNZMrFGbLYbNlN+A7qaEjNo0vOOY5lJ08ab
 m5XssaXFDDzF8DIX1jKbs0mleLLofXk5Rlg1vywsR5iOfKLnouDxqoivNmFCJbej7/g785XA9dB
 V93/uJwnaVbSzJL3XfYtJyw9PLCOHo58klqt9kQ==
X-Google-Smtp-Source: AGHT+IHWvNXjS1P6RXfax08Ul/nFGtZEkU+FbqcS3slXnuisA6V0Y4hDifXuItGcGKW6vINuNyjvoW6kX5CIRouWbEI=
X-Received: by 2002:a0d:d4d4:0:b0:607:a080:acc5 with SMTP id
 w203-20020a0dd4d4000000b00607a080acc5mr1778623ywd.47.1707898063590; Wed, 14
 Feb 2024 00:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20240206140414.1134857-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240206140414.1134857-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Feb 2024 12:07:32 +0400
Message-ID: <CAJ+F1CKXh3+8dJWfjcFzQbg44+OuozDjT+t2LXkp3N6z+6A7BA@mail.gmail.com>
Subject: Re: [PATCH] build-sys: add the D-Bus generated header to the
 dependency
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 6, 2024 at 6:06=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fixes:
>    rm -rf b; cd b
>   ../configure --enable-modules --target-list=3Dx86_64-softmmu
>   ninja qemu-system-x86_64
>
>    In file included from ../ui/dbus-chardev.c:34:
>   ../ui/dbus.h:34:10: fatal error: ui/dbus-display1.h: No such file or di=
rectory
>      34 | #include "ui/dbus-display1.h"
>         |          ^~~~~~~~~~~~~~~~~~~~
>   compilation terminated.
>
> See also:
> https://github.com/mesonbuild/meson/issues/12814
>
> Reported-by: Tokarev, Michael <mjt@tls.msk.ru>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

turns out Akihiko sent the same fix earlier:
https://lore.kernel.org/all/20231215-dbus-v2-0-1e2e6aa02115@daynix.com/

> ---
>  ui/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/ui/meson.build b/ui/meson.build
> index 376e0d771b..fa47360830 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -91,7 +91,9 @@ if dbus_display
>                                            '--c-namespace', 'QemuDBus',
>                                            '--generate-c-code', '@BASENAM=
E@'])
>    dbus_display1_lib =3D static_library('dbus-display1', dbus_display1, d=
ependencies: gio)
> -  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,=
 include_directories: include_directories('.'))
> +  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,
> +                                         include_directories: include_di=
rectories('.'),
> +                                         sources: dbus_display1[0])
>    dbus_ss.add(when: [gio, dbus_display1_dep],
>                if_true: [files(
>                  'dbus-chardev.c',
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

