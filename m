Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AFEC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolZQ-0004RL-HB; Mon, 25 Mar 2024 10:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rolZO-0004Qm-DB
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:45:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rolZM-00024U-8G
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:45:01 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56c1a65275bso303383a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711377898; x=1711982698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UasTUmVBcL/VKWYDCP4/BH4KdfUFX2g4aOhY6ZmnY4A=;
 b=FDyxM01VIvIfrWm0Iqc9hUQvYbpCgHYG3t2bDx9ROxrqJwzuavKZX7fLZd5H7o/3mD
 NVslglkn15eqSsC4zggB0M7UvHgNR5XT0PD1jjx2IxJO2btpNwg3PZA3hphqAxrurYsZ
 Fvg4rnUApFR0DiCbwP431wy/Ik9sX2BNyz6COtk0QO1IbsUgkvTNosabTODC6r01HHC7
 Ob5TzntZpQzBuy4VVcAU3H9ciTFQTFSMC1SgSiDc6kbAMUwEVMsgDm785bgALwC6zPpf
 /9SdH007buKk3zHq4QA91BJG2TWFcezVB46KIP2ur+3ZjJvGd5eG6hfzBZQqxJifDPRh
 Spbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711377898; x=1711982698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UasTUmVBcL/VKWYDCP4/BH4KdfUFX2g4aOhY6ZmnY4A=;
 b=JIUZfK87pWogpfVtiEk2whgBt5atS5uYfltfeBavsNmOqDiuLqrP06W9Llb42vRrqK
 Jhq2p5OeqJfl24Px8uz8OVLV4Z3n3rw+qBDXEr8UKgdFqd8+Em441w0RY3/PbiQgTKo0
 2FSq4dS7pcUO3yZPdUB4rB19hqU/gIxoulmuPs+tx2xeQ/7gUMfZz0pLpG5ssoY/swPn
 GoV7wLLoMHrWZIRZJ+J3NgAbHir97ENhUDHhAQY4CEeb0LeMatZxrGCQHy7JJr1PhDIs
 eaSvueg/R/EhRmGIYg/i+5FbC3BVG4fs+q12HRclT3u8OaZ1N2DoXM5pdNELXYG59rQl
 6a1w==
X-Gm-Message-State: AOJu0YwUliIYSB7ZuAr4q4/mBbdCfT6PUc+pk1tbCRcYkx1uQQN2VS6p
 bZ8DiL5dpuCa6BrtyF7phv/8m3DAIsf02tdtl/FcyIQt0Q+gVQue5IFnNoPSaG6UbUH5rPaUSKR
 6GAus7EGs9kg0Xokba3kwdXYt1ZYgjFXbv67MKw==
X-Google-Smtp-Source: AGHT+IEoyQXUwZC5FBlZHDQWutX+6XYDDrNKCcQ/pCuy6ZjVFJVTVTSQfIJYxPezMehlH0DBgNG3SFC9Q+JpT7cpLS8=
X-Received: by 2002:a50:d7d1:0:b0:568:d7fe:a768 with SMTP id
 m17-20020a50d7d1000000b00568d7fea768mr6209020edj.25.1711377898145; Mon, 25
 Mar 2024 07:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240325133259.57235-1-philmd@linaro.org>
 <20240325133259.57235-3-philmd@linaro.org>
 <CAFEAcA9aM8J+0RjYnvr8Xr8Q2j3w_TgxHO-gPDn8MaAcAUDynw@mail.gmail.com>
 <e3806179-47ed-4952-a7b6-c256a2aad197@linaro.org>
In-Reply-To: <e3806179-47ed-4952-a7b6-c256a2aad197@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 14:44:46 +0000
Message-ID: <CAFEAcA_yyWKo7E1Vz2zQXnjetYWEXtt6mUyg+t4mJXt+nsKBgA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 25 Mar 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 25/3/24 14:47, Peter Maydell wrote:
> > On Mon, 25 Mar 2024 at 13:33, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Currently clock_set() returns whether the clock has
> >> been changed or not. In order to combine this information
> >> with other clock calls, pass an optional boolean and do
> >> not return anything.  The single caller ignores the return
> >> value, have it use NULL.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   include/hw/clock.h       | 22 ++++++++++++++++------
> >>   hw/core/clock.c          |  8 +++++---
> >>   hw/misc/bcm2835_cprman.c |  2 +-
> >>   hw/misc/zynq_slcr.c      |  4 ++--
> >>   4 files changed, 24 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/include/hw/clock.h b/include/hw/clock.h
> >> index bb12117f67..474bbc07fe 100644
> >> --- a/include/hw/clock.h
> >> +++ b/include/hw/clock.h
> >> @@ -180,21 +180,28 @@ static inline bool clock_has_source(const Clock =
*clk)
> >>    * clock_set:
> >>    * @clk: the clock to initialize.
> >>    * @value: the clock's value, 0 means unclocked
> >> + * @changed: set to true if the clock is changed, ignored if set to N=
ULL.
> >>    *
> >>    * Set the local cached period value of @clk to @value.
> >> - *
> >> - * @return: true if the clock is changed.
> >>    */
> >> -bool clock_set(Clock *clk, uint64_t value);
> >> +void clock_set(Clock *clk, uint64_t period, bool *changed);
> >
> > What's wrong with using the return value? Generally
> > returning a value via passing in a pointer is much
> > clunkier in C than using the return value, so we only
> > do it if we have to (e.g. the return value is already
> > being used for something else, or we need to return
> > more than one thing at once).
>
> Then I'd rather remove (by inlining) the clock_update*() methods,
> to have explicit calls to clock_propagate(), after multiple
> clock_set*() calls.

You mean, so that we handle "set the clock period" and
"set the mul/div" the same way, by just setting them and making
it always the caller's responsibility to call clock_propagate() ?

Would you keep the bool return for clock_set and clock_set_mul_div
to tell the caller whether a clock_propagate() call is needed ?

thanks
-- PMM

