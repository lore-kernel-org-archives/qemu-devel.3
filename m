Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC4D3E76E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP6k-0003yl-Vp; Wed, 10 Dec 2025 13:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP6g-0003iY-Pw
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:40:12 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP6e-00032H-Im
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:40:10 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-786a822e73aso1454757b3.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765392007; x=1765996807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cAvDBf/KnucMG5F1r4c+5gaiEktB6k54NaX7t7zsOE=;
 b=tdBtjJwEcs7k0C5aKfeJIa5WCR9Y1ZnuVzLe0Ws90XqtW6jzpDjfymC4sdPASvXYC6
 Lkl1qbpruud4NiI7qjReoDhUHRrOydtVHUCoZjm8cC/r0/Aax3AJs63APTg8/7pl1tFe
 cUGYnn/BfM35fVnkJNTcpbY9hArDVqMWsX5kIC4Bbnzqc79FPxAR91QvZO5+IM/c/3uM
 WHbDuqSs3NyZYKmPHDUI3ULMHJLoWGjoMZGXfqY5TVQAgpsvRUslfcpyGeZQ3WuusE6u
 Q7wQxRXACUFUhzxUGjLL5c47UrjNOTVbeB6nwXdy+uoyaExJHCZTnhJBya3TYye0aaSb
 WJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765392007; x=1765996807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cAvDBf/KnucMG5F1r4c+5gaiEktB6k54NaX7t7zsOE=;
 b=uV64/Txv4UyhDxpC2BiUsh19i6G7lUI1/JUOh8328XdXuFttRdPWz5E0/UwrqIQsDX
 lT9FdbhsV8g0LBmNHh8C+Jr/3t8Hzf0OjrsbVM9LdR8YB5Hb/zxugGZpupQeXM13O8At
 E+Eo8QVpXtnAFqDUhXx/1nwOaHdlimYQiG310VzMHfbIP64zlNZqMdS6D6/yRmIv6iIO
 0nU3JlK2Cc624E/A4Dy8twiArgDobNzKWm92SYuEIzwFw+fcBLSEIkrmQXCZNyHxOwnr
 nc8KnFStzItD8kmT922pPgxmWQ+HFOS3t4JGR65AM/iZPb+Ku2pN83fjPkFI9+z0khd/
 2LjA==
X-Gm-Message-State: AOJu0YxASYEsVYdeSkAOD1+P42XpA76TCZboncWFza6r6YdHJet/3yg6
 Zr1isXywYVdNXA9FqXMHd0+6yKQRREgs2btuXkgvDZsapXhyt6lkC5I3bKd8jgLpbONNsNNy4an
 FFzxZkAU74Ja6qoRW4OskseXXYLFl81+k1xtxhKzjCw==
X-Gm-Gg: AY/fxX6q28BV89XL5hN7x3ZsK4+UllL7WD1WSsHUCfqPu3tvDqGIMq+Euq14TOzSOjv
 MzurceesbJwEXvoqCcOpes+u9F65x+Xo+Yn14VkzJb3vwB/lP135a2C+7Hk3tqRhW/B8MDbKSea
 P/NiKyLZNvh8X+C9DIklZv0ESBdIvo9zzEG13BpA78NXxpR1wb9goyO8eMmzs/DgwZOP7XVYKhJ
 8UzLxMVNZV1S5lILzSl1eXYeIHCh++Pb+fpoLhlhviOEs3MKRiAU9ckMAEQQdWseYfoBIllSdjR
 ++91SIE=
X-Google-Smtp-Source: AGHT+IFHI3OfUG7BLLsx4DfZdVtGqiLnbRJbbQA1e5Yx06Zd9kuhcFAeK9/12+OQz5QBuz1hllLxqyw8ww6nYtzAX1Y=
X-Received: by 2002:a05:690c:3806:b0:784:957a:16a1 with SMTP id
 00721157ae682-78c9d787325mr26724027b3.56.1765392007079; Wed, 10 Dec 2025
 10:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-2-clg@redhat.com>
In-Reply-To: <20251210181306.926334-2-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Dec 2025 18:39:55 +0000
X-Gm-Features: AQt7F2oZcKl_X2QJ5Zv8AJ_U0WhPZGoUCLPrI8YX_lEr3T_j0u9IMj8YwKXLObA
Message-ID: <CAFEAcA_YcPvLhsnbJy1e2ua8+dBBv_9a7izhxWXbjwN4pieUKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] i386: Fix const qualifier build errors with recent
 glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 10 Dec 2025 at 18:13, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
>
>   ../hw/i386/x86-common.c:827:11: error: assignment discards =E2=80=98con=
st=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifi=
ers]
>   827 |     vmode =3D strstr(kernel_cmdline, "vga=3D");
>       |           ^
>
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
>
> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3Dcd748a63ab1a=
7ae846175c532a3daab341c62690
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/i386/x86-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index c844749900a30c9c9c284c529e93c84c9457b128..f77e2e63046ff56d079363e41=
1a9ee0eca365291 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -654,7 +654,7 @@ void x86_load_linux(X86MachineState *x86ms,
>      uint8_t header[8192], *setup, *kernel;
>      hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
>      FILE *f;
> -    char *vmode;
> +    const char *vmode;
>      MachineState *machine =3D MACHINE(x86ms);
>      struct setup_data *setup_data;
>      const char *kernel_filename =3D machine->kernel_filename;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

