Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E8AC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokgJ-0001he-9J; Mon, 25 Mar 2024 09:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rokfs-00013f-6U
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:47:41 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rokfo-0001Yb-0I
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:47:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso6002226a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711374454; x=1711979254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rt1vQHrPyRQSz/tnYXoveaVNPEz3zG79F4PYFBFIy9g=;
 b=qKRGZm6SxXAJPhJkMQPB9K9bNiS/uCvOvthWi088wSBkEpg8ICmpeRCliA5rOxhvpV
 Fz/YSMgPPIaJYqcysr9jX51ZE4XMaS7Zd+vW6yuAu4A59Vb7z2UusjelwcB8vNaZe1cM
 /wrJ2LvtPF/8MlX+KdkYU0ZehMQlKV/Bq2TC7+5Mzm10x91D6npsGyij291/JNcu4w3/
 K7fPFCxv2T915vgxJYzN2Ny00Tc8sXOTn42FBSM1UfXtvStA7EDdN6tYOZrMStteTp3J
 FSicWjHMoIdSfcFjMOtOS8d1ZHPUv3uZliYQclIb6gUZ2GunQGNx8ZGq7fMrHJGX7Gmz
 E9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711374454; x=1711979254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rt1vQHrPyRQSz/tnYXoveaVNPEz3zG79F4PYFBFIy9g=;
 b=QiGHviM/kMW2sOx1/Sb5HxaM6ocnFbI8JrKLvWoaSG3CuCOwyTB+/YPbrfpz/rNdtA
 SdDWFCPV5JB8IgbHVydq4QYagtVpxpeIZoRstLtYR7LWgkCSTWQUWbwCbx7UBxlascpV
 l+4ra8LadkB6OtXsOuxGsQ84JxIrChrqB95qApYapiks6gicx5n60KUUd3oP3RmNvmVL
 7Ej3Bar+IxyWnui93Negww+qcM4P+D/OBPKNxmwmc+eZ3o56tVq3V3geNzoV09ju+jj1
 NF/HS35FVx1ULErcHNbmrjfAqM6YV60Z6qs5LvormezgM0lQYgCpCO20YqnSQD9i4pGv
 T2jA==
X-Gm-Message-State: AOJu0YwHv/CU+90Jpeeup3C2EOy9OcY6+pAvPO98JTwfM0adL57kZ6Vm
 Rsv3wRQHkFkTCogWDTo6kr93I1r+okyICtCgNWhaQrrQv2vO82egrzaMXvckEgNJfA2fmm7Ox09
 T6gWenif2qek1lIhDk7fThZFItaZybrIje2ls+Q==
X-Google-Smtp-Source: AGHT+IEK+LDTwNpB0kNPrRB4dK3DVlUMqbIXF4QHr6LRMT0wzKhbLK6GOmgWoP/oT1kuSDukw2oKf1En0/bIZYZ+Kys=
X-Received: by 2002:a50:d5d5:0:b0:567:504e:e779 with SMTP id
 g21-20020a50d5d5000000b00567504ee779mr4409669edj.25.1711374453738; Mon, 25
 Mar 2024 06:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240325133259.57235-1-philmd@linaro.org>
 <20240325133259.57235-3-philmd@linaro.org>
In-Reply-To: <20240325133259.57235-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 13:47:22 +0000
Message-ID: <CAFEAcA9aM8J+0RjYnvr8Xr8Q2j3w_TgxHO-gPDn8MaAcAUDynw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? v2 2/8] hw/clock: Pass optional &bool argument to
 clock_set()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, 
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Luc Michel <luc@lmichel.fr>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 25 Mar 2024 at 13:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Currently clock_set() returns whether the clock has
> been changed or not. In order to combine this information
> with other clock calls, pass an optional boolean and do
> not return anything.  The single caller ignores the return
> value, have it use NULL.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/clock.h       | 22 ++++++++++++++++------
>  hw/core/clock.c          |  8 +++++---
>  hw/misc/bcm2835_cprman.c |  2 +-
>  hw/misc/zynq_slcr.c      |  4 ++--
>  4 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> index bb12117f67..474bbc07fe 100644
> --- a/include/hw/clock.h
> +++ b/include/hw/clock.h
> @@ -180,21 +180,28 @@ static inline bool clock_has_source(const Clock *cl=
k)
>   * clock_set:
>   * @clk: the clock to initialize.
>   * @value: the clock's value, 0 means unclocked
> + * @changed: set to true if the clock is changed, ignored if set to NULL=
.
>   *
>   * Set the local cached period value of @clk to @value.
> - *
> - * @return: true if the clock is changed.
>   */
> -bool clock_set(Clock *clk, uint64_t value);
> +void clock_set(Clock *clk, uint64_t period, bool *changed);

What's wrong with using the return value? Generally
returning a value via passing in a pointer is much
clunkier in C than using the return value, so we only
do it if we have to (e.g. the return value is already
being used for something else, or we need to return
more than one thing at once).

thanks
-- PMM

