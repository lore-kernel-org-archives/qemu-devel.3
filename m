Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBDCCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAxJ-0002j7-7h; Tue, 05 May 2026 04:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKAxA-0002Pt-NT
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:16:30 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKAx7-0006tu-KS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:16:28 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so4987269d50.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777968981; cv=none;
 d=google.com; s=arc-20240605;
 b=KnzpbmfjeE1ePcvDu0i6DPNCtj/JHR92BuC4Zh5AIk2oT14XLezhlRKpQUa9TLyw4A
 qiwLcLQLQVNJ3BmYiWDtKoNnP4KxFj0I2E6rFT4gjfnAQFGUezVeAaC2ifYA1oQh4XdI
 esmrDzBqeXaJ4UeXvrD0yiMXaz9eDsMQiuTpycDstmj5SmdJXqza3E2B/hCsoZI8ZKCp
 qbe+x57VqGL2/vcLTMhZMt13EBFcDqS4chVNvoDhffB+q+puVt4CHx97qXaeKUEbNpWN
 bVJlEKu9RJu8pcRRVrCeOysVZHWYVrqtG6rc3GiIa/vtrVo8NzURUCwAm281N9raHpm3
 2xXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mmRM75DXa7rRa9X0aSIDUEIwb/AEktGctF6HwG7QDhU=;
 fh=Q/oTMpracqfeF0Shji68lD/6uwbacvRoH7pH36YfZaw=;
 b=FX51QVtrrAjR1WbJYCK31lyFeHVBcuQoFXFnik1/asmLRN0TPnx4B8vR8T/FxfxPXM
 oIMLdNVIWr/V3bnNT0qFnNwa2VjWZcGEF/aVNVuyemwupppB+3bHQrsLgwHRbs3pLrb5
 6U1Sttu12/1Dp2cJ5LEEd8h5WYHQtRPZu6QpW8THD3rjDFkDF39XTL+Zbx0fPmDHkkqi
 QV2FKhpIDsx8Iv8TGKha2top8Q/73Qt2q0vvWmp2jnb07ROenVFh4HJ+d4kWMjU9+RpQ
 NioH8RESpr1LxYmvN+bVI+1jTzzjrYT0m0X8q0EBvIDnrIwLuXnoMg0dbn33D2AvTdKS
 LZrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777968981; x=1778573781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmRM75DXa7rRa9X0aSIDUEIwb/AEktGctF6HwG7QDhU=;
 b=tpIybMJEgsNmNG+y2oeaxx/g74TBXsHjZZxxzh4PuZ8RCxtaQAGFg8hMpovxRsEv+5
 3ib3rzNGkVeShiPRLVldYiB6WlZuAisx1KvQownb7XgPSoQYjTvplfjVijscOUG8jE/p
 NmHppWVWdYhWxuUx7XzlT3si+90vv6sCoGbj7+1bugVRRBLk7pUkifJsHs2u8zd1PMkV
 S6z95CNZJ/u5fFb8Os3PiXQyc4XgoBkYXhxns1DPayV1oTdmDOdkC4NAAQN28kMaAcYe
 ZDGRDe7QCV+rqWKsVM9V5wY1yBeEn2Qfp5hvIeQmri/YSv2dqyAj0DTAGXq8kX39PsQD
 6jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777968981; x=1778573781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmRM75DXa7rRa9X0aSIDUEIwb/AEktGctF6HwG7QDhU=;
 b=W2JkqjYkAHXmb3Kc5+lkVBfm0Jxyq3BWQNkhJQBFYKZZA/ps2aSRHECL/cUaJcgQEK
 lVLt3G2yWawKCkhb0tYJL/g40C6NSStbATKxr434xgBEsltY2Vw/WzYGEx7zLIm1v65y
 jxbOQQTmWzp6dYh5UHX6VPmbjmZl3b5q334DpMHr/csdepXK9gsXtghErFNP8ogCzwcI
 DPm+yFSooSO2c/VAyYewqji/bNo5rARztd7JlW+uDVF8gAl1UwKDefnZCxSSkFT4xYYz
 KB0YT6Nlcrk6U4/z4L++k3FDA7zS8H1KtXn7vqqEWjPGJpZXHppilHtKnxSxnKrWh4qY
 28rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ963wC60BN8AtKAr2eW1HwjUX4GGU4lDkmTDfexlEnGtnykPLYSTrkrOtqDuC7lEor0tVgoHHFLrBh9@nongnu.org
X-Gm-Message-State: AOJu0YygXtkK1bifFnhaEt36XxmUJKh6CK1Sh3ZzPZRibfHJqM8tT7ob
 O4jg+ELZKHEGpDCTDpwRuKi/zTgVz3LlkzkhgT/jGb8qjFWzo65NE2QWafxLTeHk9r8zeJ4coPL
 QVRjBEfpDEePLBCDH93F20JKqfMnP6ajIMwSzpE1zOA==
X-Gm-Gg: AeBDiesaJi6CcPGs+ZY78Wl7IssGyv6JzbYzIz/8JXZPRy/QKQa8VY9HpQwQ0/gaEuz
 UUIeOepQYzG4ej38sIYAfSakeDVHAI8vYWvbfYskYqC2R14AcnmnY5DFrqHLH4a43eYUq8QbXpM
 6JehN9cXeKkgjkyHI6W5Z7pROEbX397bNex9xIepm2nGQRMxZX00lAtUPA353HqZg/t95NOpT+4
 9dRaD3szO5tKpyOSz03UxQel6PB0f7fNLc6JLLr8KfsQq/jsLoPpE9XIyOJWwOBndzDIO90B15e
 HGlspj2TKaHcI6Xnwh9cSA+pwTFapP+Te9snL/KMS4+EFfUxjGIKHgOaS+FZ475Ko43jph5eghU
 dnw==
X-Received: by 2002:a05:690e:1a4a:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-65c3dafa664mr10462962d50.35.1777968981335; Tue, 05 May 2026
 01:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260501162700.4092512-1-peter.maydell@linaro.org>
 <dac8ddbe-37c6-42b0-a6b7-8f42d96d24e6@linaro.org>
In-Reply-To: <dac8ddbe-37c6-42b0-a6b7-8f42d96d24e6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 09:16:10 +0100
X-Gm-Features: AVHnY4JOQJR5b6e8FrkR2ImRR9RuvIGnImJ9IPuk2_PIjIeC3VdAFUzqVOcLW88
Message-ID: <CAFEAcA_HyLZN_wk2cAotb=Hs6Di+DxPgV8jOAk7pHJ2f+tT4Zw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_rng: Specify valid memory access sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 4 May 2026 at 13:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Peter,
>
> On 1/5/26 18:27, Peter Maydell wrote:
> > The BCM2835 RNG has 32-bit registers only; specify this in
> > the MemoryRegionOps so wrong-sized accesses are rejected rather
> > than getting to the assertions in the read and write functions.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3394
> > Fixes: 54a5ba13a9f ("target-arm: Implement BCM2835 hardware RNG")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/misc/bcm2835_rng.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
> > index e4d2c224c8..bd4acade5b 100644
> > --- a/hw/misc/bcm2835_rng.c
> > +++ b/hw/misc/bcm2835_rng.c
> > @@ -93,6 +93,8 @@ static const MemoryRegionOps bcm2835_rng_ops =3D {
> >       .read =3D bcm2835_rng_read,
> >       .write =3D bcm2835_rng_write,
> >       .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid.min_access_size =3D 4,
> > +    .valid.max_access_size =3D 4,
>
> .impl is clearly 4 (why not set it? I tend to think the default
> values -- where unset -- come from adapting pre-MemoryRegionOps models,
> and today better be explicit and avoid implicit defaults here).
>
> What is the rationale for max_access_size=3D4, that the ARM core is
> a 32-bit CPU? I guess remember these peripherals are on an AXI bus
> accessible by the videocore as 64-bit accesses. But QEMU doesn't
> model that, and other peripherals are also limited to 32-bit max.
> So good enough for now I suppose.

The rationale is that the registers are all 32 bit, and we're
already asserting that size =3D=3D 4, so we know there's no code
out there in the wild that's trying to do accesses at different
sizes.

Adding

 +    .impl.min_access_size =3D 4,
 +    .impl.max_access_size =3D 4,

is probably a good idea here, I agree.

-- PMM

