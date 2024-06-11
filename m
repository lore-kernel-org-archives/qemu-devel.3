Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629D9C27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 00:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGpCt-0002a1-5v; Mon, 10 Jun 2024 20:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGpCq-0002Zm-CH; Mon, 10 Jun 2024 20:17:44 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGpCo-00076E-QA; Mon, 10 Jun 2024 20:17:44 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-48c4739dd39so481860137.1; 
 Mon, 10 Jun 2024 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718065061; x=1718669861; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/qn5RbNDx69/foGBVXKjxYnQx5GX35lkJCROXiJLsI=;
 b=LvyY4q0c0bMSXpSzlvaSLaWctlulo5ptoWnLlqlhMiLKXVolBzjxiwz7DP1Lur8Hy8
 ziB5QfMOu4PfslCiqKBWB2DPzDbtFdFIzQV8XWOJRiAFFrhqkyfhsyYCKOSTep8ki64g
 twjjYuidlr6bYYDRDkoZcF5N49lnwQGbRmANM1VBwoaz5QeLqVjyx/GqeSFzTH6GXbx8
 l/u9zuDN/KPkz4tXQJnHR8hKk9cKDpN9aX6E2Mbt/PYn4SY+nc3UzgdFQNzV1s41fHHY
 Hz7ByUwfkvVYwgKDkDT1AqNcU5hHH4RjKWMRBq4nL5ejAKlnkQRNdHIIsgiDloFHyY6R
 ih1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718065061; x=1718669861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/qn5RbNDx69/foGBVXKjxYnQx5GX35lkJCROXiJLsI=;
 b=mGdcbN0OdZmZEJCSK67qlB9Wdjut0NMMzJeF3M6AacLlCzbIO5K4oY1eOrndbVBBrI
 i3gSv+gzeokxNiAMRTrceJFnKKmULu+ikUwOQPA4n+Lc4Z322VIaNb32UQT/2mCgc43p
 YGeEgUhQ03QuuGeYXVWTPMpzQoZ+ZL2O+1ikrfZDKwLl93PLBazzEledJXmVTLX68V8+
 +4VOvbaMwp6fc1gxeJvSEAixp4wN3Sh5Y4YgYS+911zPvlvdqdRJoJRTBh6pTjOGZdmL
 0rkgt1VheX9DS6DIBFfcs1e08PeV59pp106BId203jJfj6yBuObSbVJoE52NaTUPtqjN
 eS9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqu0bliT2lg8KYBrUCcsnf721zGiLMD4yJHKI/oOFnbEsoqwsgb2mGf38XsdB9GHp0aRiQNGvWdBudLB+NIQfnmVlq0GU=
X-Gm-Message-State: AOJu0YwzMzDQ9TT/IXzMyD68CtC6CF/Kd3ebc/aE6kH44THNgFpa0Gw1
 wRVmV38qxaK7tThAXZ1CIqRGFEJELunqVk8zEa6RE7GNRGIWck18aGXzMl71oWqeyyegi7hhPXI
 cEoGsb8YQtRqe7dO7t+R5/Z2DsPU=
X-Google-Smtp-Source: AGHT+IFkwVaK5mlSAQ4mmxveLCcRtiu8tBKhRNdvzfixuTDwU7fnp6stgfbkaQ+btfg3NuUV8dchg1kNJmqTheibwn4=
X-Received: by 2002:a05:6102:3092:b0:48c:1157:2f58 with SMTP id
 ada2fe7eead31-48c275dd6edmr9469584137.17.1718065061149; Mon, 10 Jun 2024
 17:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240610145808.2267-1-philmd@linaro.org>
 <20240610145808.2267-5-philmd@linaro.org>
In-Reply-To: <20240610145808.2267-5-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jun 2024 10:17:14 +1000
Message-ID: <CAKmqyKMMXNJzwH+XPexqsb1KUdmVuu8T+RZ-4ERo=-26Q1br-A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] target/riscv: Restrict semihosting to TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jun 11, 2024 at 12:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Semihosting currently uses the TCG probe_access API. To prepare for
> encoding the TCG dependency in Kconfig, do not enable it unless TCG
> is available.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
> index 5f30df22f2..c332616d36 100644
> --- a/target/riscv/Kconfig
> +++ b/target/riscv/Kconfig
> @@ -1,9 +1,9 @@
>  config RISCV32
>      bool
> -    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
> +    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
>      select DEVICE_TREE # needed by boot.c
>
>  config RISCV64
>      bool
> -    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
> +    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
>      select DEVICE_TREE # needed by boot.c
> --
> 2.41.0
>
>

