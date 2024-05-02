Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7EEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2VHt-0004gD-Sy; Thu, 02 May 2024 08:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2VHf-0004bU-1i
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:11:31 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2VHP-0000Ur-Mt
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:11:29 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a595199cb9bso206088866b.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714651873; x=1715256673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsrKDleFzHSj0P76ZC+1+SnrGqsGd846AhS22yDI8ck=;
 b=eT9WL/CGnwjHyL338Iq60It857IykcMVH4CgBJZI/CAgY/wsGwiCnScPME158C+kEd
 KVa44Z9k4A+4tJ1uBpkJfC4v8IbyX0eWh3xEQO24UfekE5uTgMIjU8R9f5FGdeN2CHrM
 hhdcwPBHVPd/Cgp8Pt6oI1ruzq23h6fG6Yux7p6ztRAjBpgv0kcRk+Y2ufZRGAo8FzKr
 QIrDn4Mm6OoPPJ1WbZ0IrueTUeiUniI2KqbdeKeAFWjJvmOzRn8LzfGzoHsQdGM4ikpy
 s1BQjYDzMyZmgkVQaxMUSellsMCb5Kx0TAQcM7WDd/k7QTJaUuFnBT+hmBDmo7YVuI9+
 Kwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714651873; x=1715256673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsrKDleFzHSj0P76ZC+1+SnrGqsGd846AhS22yDI8ck=;
 b=nJBMqjDAE63gdyfH8QfpqzmKOl8fwiRtH8nrs1BUukQutA6JGr12Nm7jaavitStw5c
 Utm2d1rCdXJqThwfA6i4YsqzV4ToOPzt6nkdD5Yiy8mUEvzPQr3vnXXvYJva0mkj/8N2
 YjLl5KgC1dPfsVN7pTWa+KSmLKPqi4dm1SPER+vZJRJYSJFvsRicCyhrPI0g78IY9BvQ
 9efajV9B4Lsoq7gEacdKhaIE58wZdUVj+4kolVtFkNacDMbGtBbPC1krxpK1oZ9OtFcI
 79Fn/N1N7+K57B2GXh0kc6ZnUcYxC9CZr87T2C4lW5ZXZRcds6gzXPO07287b2RuEKI2
 8o9A==
X-Gm-Message-State: AOJu0YxVu+k9L67H5umI6hl/FvgStq1ZT6DNrJeYTtuktAtZfE2bQoAO
 Q9BCC0emgabm+jNDtMpRfOW3GAkrFOLn8+oC2EDGs0PEPMfPAGRNHVYtCWOzzogqsMTW84CExin
 WglLPsVviAnJEBMt8w8hII3lGkh4ygMw6f8vgaPogSsWU/rsf
X-Google-Smtp-Source: AGHT+IGTsZhVcBacGSMn64INidZR0WTWISv48fT5lI5FuPV8KNnKuspnwRYjOKUSpr931D9y8uv9h4aPirS1AC9nKus=
X-Received: by 2002:a50:8d12:0:b0:572:4fc3:3a28 with SMTP id
 s18-20020a508d12000000b005724fc33a28mr3749241eds.23.1714651872847; Thu, 02
 May 2024 05:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240502074158.85800-1-philmd@linaro.org>
In-Reply-To: <20240502074158.85800-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 13:11:01 +0100
Message-ID: <CAFEAcA8R6mGCPvtDEfUUxPLz1w084hof-FdADnmXHOWj6aAvaA@mail.gmail.com>
Subject: Re: [PATCH] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 2 May 2024 at 08:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Check the function index is not negative and use an unsigned
> variable to avoid the following warning with GCC 13.2.0:
>
>   [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
>   hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
>   hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-W=
char-subscripts]
>     416 |     s->dav |=3D mode_regs[s->function];
>         |                         ~^~~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/input/tsc2005.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
> index 941f163d36..fa93eb5d25 100644
> --- a/hw/input/tsc2005.c
> +++ b/hw/input/tsc2005.c
> @@ -406,6 +406,7 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, i=
nt len)
>  static void tsc2005_timer_tick(void *opaque)
>  {
>      TSC2005State *s =3D opaque;
> +    unsigned func_idx;
>
>      /* Timer ticked -- a set of conversions has been finished.  */
>
> @@ -413,7 +414,9 @@ static void tsc2005_timer_tick(void *opaque)
>          return;
>
>      s->busy =3D false;
> -    s->dav |=3D mode_regs[s->function];
> +    assert(s->function >=3D 0);
> +    func_idx =3D s->function;
> +    s->dav |=3D mode_regs[func_idx];
>      s->function =3D -1;
>      tsc2005_pin_update(s);
>  }

This code is in a deprecated device, but it makes sense to
avoid the compiler warning in the meantime. (I'm curious why this
only comes up now, since I thought this warning had been around
for a while. Maybe gcc 13 is applying it in a wider range of
situations.)

If we're going to assert I think we might as well catch
array overruns in both directions:

     unsigned int function =3D s->function;

     assert(function < ARRAY_SIZE(mode_regs);
     s->dav |=3D mode_regs[function];

thanks
-- PMM

