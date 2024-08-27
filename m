Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EA7C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisfK-0000CJ-M4; Tue, 27 Aug 2024 05:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sisfJ-0000Bn-6I
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:39:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sisfH-0006v6-8N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:39:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso46135005e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724751541; x=1725356341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sIl8lrxrwBKYEhhLwHTvyqzy3dVcxOg0XD83wA+iEFg=;
 b=MRHpxozJXDzx1SW9khMYPlA5gIm+ZY7OB0+Ucnpgx/ibbxtbyEt4lwBNJX7KBwq9mq
 dgYHRiTt8k+YEnUx+Kn9QeQGTYP8C84w9oisDWdm1luiLHahDHVEkluO+zrfqq28oBQO
 QwGBTAhnsTucqKnUpSWY8h77OcPukGwHokjdmV6VRuVQE4Z+fCpCQ++XWTfTc9pg0I1B
 vmAIrWRlZh0/Rp6r6PRwHzQ7XRzHy9BPaxRTTs3VqFAlJRR9la26YOmpUS3ex4/i8n9S
 pOLHQy5H8Tup5kJ209Uxn62JRmoBrdI950qwfXR5NzZGCwSFexCvfePgXd3tHs8duHHs
 M+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724751541; x=1725356341;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIl8lrxrwBKYEhhLwHTvyqzy3dVcxOg0XD83wA+iEFg=;
 b=V7F/thnXNPZHqGpLOySWq5LRYJA0ymixIC2yipl/kYQPOEMZigEXPJDKmkSyTHu6/x
 UeArP+UtOgAWsMwkLrTPmmhW/fY7yPI5HDW/dMFmDhxCvZPye5S2lZV3vOCkaSuc4hXI
 bO42DAT6tHJc7Uk4QLjAfDZxrcokuHdXkVu4A9i/RwPrL3Vr9k87SpW+VdaZNJh0QLjz
 FXKL5+NjLsXVLzSSC8UXJJkCyE/U5P0Xyk/8SDcSR02D9NCy3hL9ttoBZNhluQ+Wd8Ie
 B0gwEgZCKcs36f2H9gBXYInGnEfLoV17Zb0GdnZTyveDqqM4jXAGHFYM9A84G2kbPW7N
 Jr2A==
X-Gm-Message-State: AOJu0Yya4azdBQ2uzdQH0954kaAMe9+utbGY1Sv4omB1TtQrxCouHY5d
 4kbrCjTkXCvxcGY1CVy9zESHUIc3mCbf4vYGdmXflykMeE6la4ZFimbGW5pqSHs=
X-Google-Smtp-Source: AGHT+IFKxmUCYmJs/KTXMbzU+rBY5sM5wzdbsgBOCHFIxBz0ujCmYnEzBVS1UL8OCkLvysEr7EEi+w==
X-Received: by 2002:a05:600c:150a:b0:42b:898a:1ce4 with SMTP id
 5b1f17b1804b1-42b898a1e1cmr77095235e9.34.1724751540608; 
 Tue, 27 Aug 2024 02:39:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac516252asm178749595e9.26.2024.08.27.02.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 02:39:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A81F5F7A2;
 Tue, 27 Aug 2024 10:38:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
In-Reply-To: <20240816162044.5764-1-just4now666666@gmail.com> (Elisha
 Hollander's message of "Fri, 16 Aug 2024 16:20:43 +0000")
References: <20240816162044.5764-1-just4now666666@gmail.com>
Date: Tue, 27 Aug 2024 10:38:59 +0100
Message-ID: <871q2ae24s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Elisha Hollander <just4now666666@gmail.com> writes:

> Signed-off-by: Elisha Hollander <just4now666666@gmail.com>

What is the use-case for this patch?

If you are simply looking to slow the emulated system down please have a
look at:

  https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instruct=
ions-per-second

which uses the plugin system to limit the run rate and sleep if its
running too fast. The longer term goal is to deprecate the icount clock
alignment feature from the core code and leave icount to just provide
the deterministic execution needed for record/replay and reverse
debugging.


> ---
>  accel/tcg/cpu-exec.c      | 4 +---
>  accel/tcg/icount-common.c | 4 ++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 8163295f34..4c2baf8ed4 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState *cp=
u)
>  static void print_delay(const SyncClocks *sc)
>  {
>      static float threshold_delay;
> -    static int64_t last_realtime_clock;
>      static int nb_prints;
>=20=20
>      if (icount_align_option &&
> -        sc->realtime_clock - last_realtime_clock >=3D MAX_DELAY_PRINT_RA=
TE &&
> +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>          nb_prints < MAX_NB_PRINTS) {
>          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay) ||
>              (-sc->diff_clk / (float)1000000000LL <
> @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>                          threshold_delay - 1,
>                          threshold_delay);
>              nb_prints++;
> -            last_realtime_clock =3D sc->realtime_clock;
>          }
>      }
>  }
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index 8d3d3a7e9d..f07f8baf4d 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -46,8 +46,8 @@
>   * is TCG-specific, and does not need to be built for other accels.
>   */
>  static bool icount_sleep =3D true;
> -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
> -#define MAX_ICOUNT_SHIFT 10
> +/* Arbitrarily pick the minimum allowable speed.  */
> +#define MAX_ICOUNT_SHIFT 30
>=20=20
>  /* Do not count executed instructions */
>  ICountMode use_icount =3D ICOUNT_DISABLED;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

