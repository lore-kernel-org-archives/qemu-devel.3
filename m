Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D15DD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAvK-0002Ge-In; Mon, 29 Dec 2025 05:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAv9-0002Fl-6t
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:56:15 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAv6-0002G8-4S
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:56:14 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b83949fdaso11949020a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005769; x=1767610569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPhTct9QOa8R0mVKAMdyfbeAyQnub/sqy2/BpUKgCS0=;
 b=XLjzsyy4oIKkBREJkaidGVgkmO5a/TY9Kwc/JB0phyPPrYKi37S/a1fUr6aBaOXS3S
 50/hSQz0yQWpZB7lGcEhk7w9cMxW9UYHBY+hmIBiFQv8FRsMkmgslrijJa3jkpnsp6x/
 QqfcPJP1JlWs9EccynAdSue2JoZ0URrGG1Ul++vHrWHpqhbuXX6fueSOT9NEMMzmybgQ
 JFRcA0qf5KdUKTAqITQ/aJDvbiJ2AnuMSoSkiWpe2vSNdweMkYgpT5F+qUiJ1z42WY/p
 j0Xu1luvEhMBppa0jc4tWyisZey6KBAPyNhkQTRDD1ZY5bbOsWx3ORnDFwgaJK9NfESk
 5l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005769; x=1767610569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LPhTct9QOa8R0mVKAMdyfbeAyQnub/sqy2/BpUKgCS0=;
 b=HFtstNnMGXhmGfDudD/jQl0Uk/QLXkfwNQwAt63WQOHQzGzktXJQsnhh+cg0h4QA6a
 y37ehIUOG7VyI0voflyZCNIXoPdlDBqux53UaDZV4jUR9IqIJZbw//aJLiHvqqPsZSpp
 3rX2+e5QFZprEGTt94bdtiCjVbyH41wmiufwRT8FDRTukf5S7cO/CBfrVEsgppUZ8Bs3
 PDYxSjkhczlKrkXKHPfiPWzBEbjJgJqnJk4Rvsu0VacemBPzgNf/BCZbG13U8ZPoj8+3
 BTPs8PmdSh+9JqlAOlSKYQWIP7fRlQGU5fT/OfEt+0wisBnbi+ASHFYYMYBrbkLOr+Ic
 VlWQ==
X-Gm-Message-State: AOJu0Yya+nTPAn0yWBi4mlD33APVrDQ3wJXC34LeWBxfU6BKDbiPe3Lc
 OsvPqEq35/A3zfqJfigZTy7P5sDfOYz198FRGwX578AE4ZJ344qoVjmNF/3A1sx6QrJIpAtF5jf
 fsPmKjGoDEFuciUhqVvxLV2eWMR321xVt4Y3o8virRg==
X-Gm-Gg: AY/fxX5FtyWYFOybBTvVKVzmXnX3LjWvm+u2RPjD1vD3Z0LTNUV2UuTIM37xIuKQjGf
 pda3VA+jhelBRa2ra2s1G0xUgRSCkYSpCAzUuYC3k+hwMFu55IwGVErjfJHbgXPfhdTVyYH/5Rt
 NOpV4zR3l9PCqw9iKmb2SsliLkdplCpGnCMGKY6z5SZkafrgpqU4CjI+4l5W1RDTgs+KTFUlEFI
 O4VpNIhSbMmWJB5YQF34zJ13FR/tTy23qGrYlpVUgITUuOS3OsARMfGr5BbjfMiHoW49/Xv4qW/
 s0S4YKqWFBOux2Mz4XpaUMFmCh/RNU9/uxTIIP9jhR9CuT0Bgg==
X-Google-Smtp-Source: AGHT+IH4QS8sgJsj8SvmY+cADGiM3lTg/BieaKmH0yLfL9Cp+l4beNGQjgK2VxZYuv+DngTvoSFdpwcc3hb8RZ+nR/E=
X-Received: by 2002:a17:907:7e9a:b0:b76:6c85:9fd3 with SMTP id
 a640c23a62f3a-b8036960757mr3262986466b.0.1767005768731; Mon, 29 Dec 2025
 02:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20251224160335.88861-1-philmd@linaro.org>
 <20251224160335.88861-2-philmd@linaro.org>
In-Reply-To: <20251224160335.88861-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:55:42 +0200
X-Gm-Features: AQt7F2oLrB4OhMqEevlXIF7MKbJ1JV7l7kiGaFY-mBfy96WY41t7Z8izGxyps44
Message-ID: <CAAjaMXZX_OZoL15Bh4bjk0nozCHP3JuoL5+Hysw2iV1CyRBLWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/avr: Mark AVR-specific peripherals as little-endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, Dec 24, 2025 at 6:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> These devices are only used by the AVR target, which is only
> built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
> using DEVICE_LITTLE_ENDIAN.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/char/avr_usart.c    | 2 +-
>  hw/misc/avr_power.c    | 2 +-
>  hw/timer/avr_timer16.c | 6 +++---
>  target/avr/helper.c    | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
> index fae15217e9f..5510dd3f487 100644
> --- a/hw/char/avr_usart.c
> +++ b/hw/char/avr_usart.c
> @@ -255,7 +255,7 @@ static void avr_usart_write(void *opaque, hwaddr addr=
, uint64_t value,
>  static const MemoryRegionOps avr_usart_ops =3D {
>      .read =3D avr_usart_read,
>      .write =3D avr_usart_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {.min_access_size =3D 1, .max_access_size =3D 1}
>  };
>
> diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
> index 411f016c997..d8e0d918519 100644
> --- a/hw/misc/avr_power.c
> +++ b/hw/misc/avr_power.c
> @@ -69,7 +69,7 @@ static void avr_mask_write(void *opaque, hwaddr offset,
>  static const MemoryRegionOps avr_mask_ops =3D {
>      .read =3D avr_mask_read,
>      .write =3D avr_mask_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {
>          .max_access_size =3D 1,
>      },
> diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
> index 012d8290018..110bcd58163 100644
> --- a/hw/timer/avr_timer16.c
> +++ b/hw/timer/avr_timer16.c
> @@ -524,21 +524,21 @@ static void avr_timer16_ifr_write(void *opaque, hwa=
ddr offset,
>  static const MemoryRegionOps avr_timer16_ops =3D {
>      .read =3D avr_timer16_read,
>      .write =3D avr_timer16_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {.max_access_size =3D 1}
>  };
>
>  static const MemoryRegionOps avr_timer16_imsk_ops =3D {
>      .read =3D avr_timer16_imsk_read,
>      .write =3D avr_timer16_imsk_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {.max_access_size =3D 1}
>  };
>
>  static const MemoryRegionOps avr_timer16_ifr_ops =3D {
>      .read =3D avr_timer16_ifr_read,
>      .write =3D avr_timer16_ifr_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {.max_access_size =3D 1}
>  };
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 365c8c60e19..9ee0a558ea7 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -256,7 +256,7 @@ static void avr_cpu_trap_write(void *opaque, hwaddr a=
ddr,
>  const MemoryRegionOps avr_cpu_reg1 =3D {
>      .read =3D avr_cpu_reg1_read,
>      .write =3D avr_cpu_trap_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid.min_access_size =3D 1,
>      .valid.max_access_size =3D 1,
>  };
> @@ -264,7 +264,7 @@ const MemoryRegionOps avr_cpu_reg1 =3D {
>  const MemoryRegionOps avr_cpu_reg2 =3D {
>      .read =3D avr_cpu_reg2_read,
>      .write =3D avr_cpu_trap_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid.min_access_size =3D 1,
>      .valid.max_access_size =3D 1,
>  };
> --
> 2.52.0
>

