Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC24CEF173
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAXV-0006Kt-Pe; Tue, 08 Oct 2024 09:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAXI-0006Ep-JZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:46:02 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAXG-00030e-Jw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:45:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c89e66012aso7451706a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728395156; x=1728999956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6zn3fK3CiuGgVaDoIgQbvIno/exHZm/VUj6W0G5YYs=;
 b=B5FN23f8UJ214P56L6eApEbyibzAa3v0HtO4tm6GiI55+jI9I797gdDNDpkp9N8mhJ
 QEm4bJNJObxo3h+rdUnRo0W4T3he9LXP6SPHyRrSl3ZtP6Md3Kc3wSnVbuEV3dd7mzU6
 yDuMKMniWRC+rRsQuvPpJK1Qm1xmFYb/mz5dYYhACyq+Ki9YHslFiOTWhKl8ZPo1dDY2
 nVNKLTcbE6Y5ZWvszHx32WshVd64jeF5VNIpk/IIr1ubNXeV1q3w/Fn2GzA0d4MPGI5y
 rQGxYNiq0Nj/viPKuu5AWknPMTXviDLWM4NH4gE8PkmNcDRDLw/OzaMOkN/fUh4TMsec
 DMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395156; x=1728999956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6zn3fK3CiuGgVaDoIgQbvIno/exHZm/VUj6W0G5YYs=;
 b=Ws+3awCfj1glSCca3lfWO9n4NdaHfWHyJnfcAMTP82S54taP/cMlcbQbSVKeEwF+9J
 UK+/1GmekVIE2fHCMCnnO7KUUGAyHsuVMIvuer5jJxumWx3iI3CNM2nUXgh4ZYuotE7/
 /uEKxtm9mde/tJtGKMDWDwqozc0DyX7uPkH1PsuBmaxtgBOKihO7ZtJGe8iNG5wSzu1I
 woffgauP3g3re+IvuOjHaWHx5g4Ja+HTAEZUHwjuBSSb5XT3bRF/5i11NBD+gx9nc6rc
 fFxCHY5P1BtyGzLKceGSCR5oOkItF0AH+TAG2AaFjn8kpa0nsP07N3XSWDK9jQfSibKW
 76DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrqFKCR8fXL1jJnPBoc3iR6m7oZqDern7Quup1yfv/lOnjysenHrh6pyeOK7COhUglGObi60fi1ZR5@nongnu.org
X-Gm-Message-State: AOJu0YxNZL6FOcg+RMAsKmh7xJiCEZvC0t9DWC4oVcyafYiwRz2OsDTJ
 JzWSbovBVFjpKJz5os4HqNAqnvVwPYRPxX0hqwNgBc7CG2CbeFLpjb9GjNrNv3spn/K3HedbBdk
 7aWobd5JGgFDxFsYrA+a4F8uJ2oyP2SAVRjecpg==
X-Google-Smtp-Source: AGHT+IEc51A4hYpS/DlWJAHnr0TpEl8tX2xYHguaPZIK/QVFzWJ1GE+syjfOA5YBixJ8/tf8LS7VMSPGsQar+Hy5PLE=
X-Received: by 2002:a05:6402:270d:b0:5c8:8e92:564e with SMTP id
 4fb4d7f45d1cf-5c8d2e27116mr11769195a12.19.1728395156464; Tue, 08 Oct 2024
 06:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
 <CAFEAcA9GHEGrar3Mcf09Hrrmz6mWeQhD0Z7KEvxr3RxYSyFeEQ@mail.gmail.com>
 <7ced0b1a-8548-44af-b108-23ef296e0b2b@gmail.com>
 <CAFEAcA-LoJUh4rXYtPnvQTwFhXhx8RHyzVh7sfMMvje98L2k+g@mail.gmail.com>
 <4aa1f089-6ae1-4a2d-9fdc-d62d26bd22ca@gmail.com>
In-Reply-To: <4aa1f089-6ae1-4a2d-9fdc-d62d26bd22ca@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 14:45:45 +0100
Message-ID: <CAFEAcA-nAsXx=Y8phqUcVQVn5YooYicsTqYPtUHY-hs67b1Xhw@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Jacob Abrams <satur9nine@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 14 Sept 2024 at 04:42, Jacob Abrams <satur9nine@gmail.com> wrote:
> I have received a response from my contact Nicolas Fillon at STM, he wrot=
e "I see we are making 16 bit access read and write to these 16 bit registe=
rs in our library for both HAL and LL so this should be a documentation iss=
ue."

Thanks for the update.

> I noticed in the Qemu source the RegisterAccessInfo struct and associated=
 register_write_memory/register_write functions. These functions appear qui=
te helpful to ensure that reserved bits are not written by using the ro fie=
ld. I don't see very much usage of this paradigm in Qemu however, only Xili=
nx and USB DWC3 code appears to use it, but it seems a useful approach in m=
any situations, especially for STM chips.
>
> On the physical STM hardware, specifically the STM32L476, it allows write=
s smaller than 32-bit to 32-bit registers and does not fault or ignore them=
. In fact I noticed some very interesting byte duplication behavior, I test=
ed the following code

> Notice how an 8-bit write of just 0xDD is duplicates to all words in the =
register, strange. I wonder if Qemu is interested in emulating this exact b=
ehavior, it doesn't seem particularly critical since the drivers provided b=
y STM should never purposely write to fewer bits than are actually writable=
.

No, I don't think we care about emulating that exact behaviour.
We could if you like do a LOG_GUEST_ERROR for a write that's
smaller than the number of implemented bits, since it seems
highly unlikely that a guest really intended that byte
duplication, but I'm not sure I would personally go to that
effort.

-- PMM

