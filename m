Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A2CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 06:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4D61-00062W-Pa; Thu, 02 Oct 2025 02:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v4D5r-00061e-LM
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 02:47:15 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v4D5d-0006sb-DH
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 02:47:11 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3d80891c6cso294921966b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759387604; x=1759992404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zi88AHS5bOIRZ4kh7aaYzFf8O5pF/bkhz+hNY7JxcjE=;
 b=SQx0QTiG+6NFE7CJDhq9bt3hGTj5WOosETIgwA2wf1R8y7QoW41nDPqxJHIs4RABAb
 by0q/kFeJIygHDZuYXkJHWc0dH9mCsvCcf2gcd9Y4QJB0xse7huXAG/mlYbHeVKZLcOh
 GqM/WPWLcDk6U3j7Oi/uE/jTVx6biR59hqP75Ph8xr0KXHu6kXfRsLTSB7zCdHAC3VNh
 B8M8uriuvlxiyS338vEov8fwRPClRElXSVF7T/SVjfa/Xw4W0q+9Iaguiis7pnOTTshW
 eEtuAQ0QPEDZlgKh00ytkNR5sISYotsba+PI3TL1f9hWn/A44yKY1R8oKmW7SKYm9vrl
 IAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759387604; x=1759992404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zi88AHS5bOIRZ4kh7aaYzFf8O5pF/bkhz+hNY7JxcjE=;
 b=QCPNx2lGJrU03WFvDhSnj8yuZgk+q95yUCsI0Xx75GIk4tEqqq/elgxTwElDlVHa+I
 h1cSRu2z1sGSgBCcCsYlbfBMGguiBK77nSOSNjSXCib5xdVo0cy50kNo5kNd8RR+nG9q
 +VK6nKUOkK4RPYMJPXIOx6CoquYm9p5OfJ5bysQ+/eS+XuT9YE+PhWBdjmA4lJ33DAwm
 MAa948hZv6WxLgJIMeYxgrIMw/vCBa7CcGx7WyyPP0ErU/U0OUIbt964s28K1y7Fu/iF
 Yc6VZMZFuq9I5QkgMbSy2hRTgvDdB7LpAAHGvtUE62hzpIuOFL3ffpE9zzADlKmN1rwD
 whkA==
X-Gm-Message-State: AOJu0YzzXks/HXKFfrRMp+CcuO8FA6tX5vqM0vel2nTWDegVtGpNU11U
 bm4dTpfAUxmTd3X+AUh8/eYH4yKGRNbJEtraXvCwBKvIO8b1uKP4Km/hOI3LHmVOCSu25TuOIBj
 17i48DKl+4cn/VsdYKiSJzcWgUPOlyM2PyWRwMn5L
X-Gm-Gg: ASbGnctf/99u0zxEbRZwnMswSqBKgmSm3PCUJzMje17u5adObHrOf3JSJjfJ1tN9Oq3
 /2fG8EKynaZeh2ePKCREadJvEpD75RkeWbZPKC4GVj45jKmzEMiEXFUvQ5Xm+qI51axLO+F7bUJ
 ViGJQp1m9FdHytVfPQts1l2EsmGckyLQWBtgPCQdxDicyHfnHiX1hvW/tR9Q3qYZAVs1+k34JVk
 JYjzCDwixPm68622HQeDTi8nmPPA/306jjOD0pZ6L1gPpakEAtG7AZA2c5FNTp8
X-Google-Smtp-Source: AGHT+IFi17E1RM9UGydrrcBKDwvhrvEG3NarD1rdVQq4ZoUFc0SSJYjckgdAPqnMtf/fG++KS4vBgdB8Hi7T/v8gbrA=
X-Received: by 2002:a17:907:2da4:b0:b3a:8d34:7f71 with SMTP id
 a640c23a62f3a-b485afacf56mr287435866b.32.1759387604559; Wed, 01 Oct 2025
 23:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251002033623.26800-1-philmd@linaro.org>
In-Reply-To: <20251002033623.26800-1-philmd@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 2 Oct 2025 08:46:33 +0200
X-Gm-Features: AS18NWAdtox7QquKJ07WQLyfHj--A4WO41FROT_K8hcLgIkUXZEPSOPVliC03fI
Message-ID: <CAJ307Eh7Xq-dBpbN-hb+e46gSbm66NbeUGnhE-ktPbCamFEJBQ@mail.gmail.com>
Subject: Re: [PATCH] hw/sparc/leon3: Remove unnecessary CPU() QOM cast
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 2, 2025 at 5:36=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> env_cpu() already returns a CPUState type, no need to cast.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

> ---
>  hw/sparc/leon3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 0aeaad3becc..09d2cec488c 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -192,7 +192,7 @@ static void leon3_cache_control_int(CPUSPARCState *en=
v)
>
>  static void leon3_irq_ack(CPUSPARCState *env, int intno)
>  {
> -    CPUState *cpu =3D CPU(env_cpu(env));
> +    CPUState *cpu =3D env_cpu(env);
>      grlib_irqmp_ack(env->irq_manager, cpu->cpu_index, intno);
>  }
>
> --
> 2.51.0
>

