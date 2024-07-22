Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98659C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpQ1-0006Qs-EN; Mon, 22 Jul 2024 05:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVpPz-0006Q6-VI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:33:19 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVpPy-0001WZ-5E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:33:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a1f9bc80e3so1377333a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721640796; x=1722245596; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSm2TY3wGJTirAsLXY3cLO+j0hFVRRDzKq082GjDYgk=;
 b=lVL78ulEwLAEkMNhiKCDI59A308nx6Q7H4scEMN5ANvHsuejgBHSRTK7FAtCIqBRFM
 0UZbeJ6xyUPnxoL5QUYQYt6Np4P8bvsB8bHtsJaYEE9xiwUCzNkKhdq40gtEEDWKyolI
 GZr6Eiqo+RUVxu/PsyToVvYLNrn0xuU8zbhXc/e7WlVw1RuGe204FPjG77GuKbY5D1Mu
 qDTjqCuA47v5rvKU/TSh0byycYU617tHaIQHQuyVKSujoYtvjfka2YmOyURLUZ4M//pS
 s0bA/Imk5vZtNYNj+uA/q+UuHZNHoCkAZjVaNE35P1mJ3BHtZ+nwXWwWenXfTaq12a17
 zlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721640796; x=1722245596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSm2TY3wGJTirAsLXY3cLO+j0hFVRRDzKq082GjDYgk=;
 b=iXS2FzyZEZuPou3xUw3jinYGGl43+3a9MhVMOQzgq4aKYeaCpWBD93PuefpMUwb5xU
 im5KJwgQ9Vc16PQoewWhu8a2zg3xXy3huCs3K1LOysx9kD+cAKjP0iixArXykPnDHdcv
 IXRlKZ+RYPGu/AG7dlEYnkSmNg1v2ASJE1jCizcGVXwL/tNY1J92upu1DC7BWY7QKik6
 /4lAXEssYcJUBxKGJ+G7n1tWPOpJAOAKREpj1kudWUMNtYSKg0nVwpRJc09CMaUbtoLa
 rxPmeCc71K6rMxNJMPLOUHllwR+75XlsmvGPlXPyHiL0XD0BWmx1smqV0weE8+Al5c7U
 y/Nw==
X-Gm-Message-State: AOJu0YxH/nXQoeavYAzH8jG30wWaiRiIr6gTWTTEjpwut5T1AXuhoFnF
 eb+dxm9P33b5rI0CLhD3ykTJjGQDnHGnH9xRwdjwxDER1OLOSuxjuw2jVxxAOjZWzdYUafkeRLN
 nRq9SNozS/DzykdFGHPM7TyVdL/7bFwLmox/uLg==
X-Google-Smtp-Source: AGHT+IFyyEqt4MJgOQpTzJxa18MyZbxFwYyYC+A2f/bA9bqicu6zeireD/6Z5OjtheXypSX3yi3WvbbcXtAgRMK7Qag=
X-Received: by 2002:a05:6402:50c8:b0:5a2:c1b1:4d3 with SMTP id
 4fb4d7f45d1cf-5a47b1dee89mr5759834a12.28.1721640795885; Mon, 22 Jul 2024
 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240718132028.697927-1-peter.maydell@linaro.org>
 <20240718132028.697927-22-peter.maydell@linaro.org>
 <CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com>
 <Zpw1C7L4dG8NCetB@google.com>
In-Reply-To: <Zpw1C7L4dG8NCetB@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 10:33:04 +0100
Message-ID: <CAFEAcA-bTFF3mSc+-dYYKjpz5R2+m=p3nLhYOkn6xGPgVnYtLQ@mail.gmail.com>
Subject: Re: [PULL 21/26] hw/arm/smmu: Refactor SMMU OAS
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 20 Jul 2024 at 23:07, Mostafa Saleh <smostafa@google.com> wrote:
>
> Hi Peter,
>
> On Sat, Jul 20, 2024 at 04:05:40PM +0100, Peter Maydell wrote:
> > On Thu, 18 Jul 2024 at 14:20, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > From: Mostafa Saleh <smostafa@google.com>
> > >
> > > SMMUv3 OAS is currently hardcoded in the code to 44 bits, for nested
> > > configurations that can be a problem, as stage-2 might be shared with
> > > the CPU which might have different PARANGE, and according to SMMU manual
> > > ARM IHI 0070F.b:
> > >     6.3.6 SMMU_IDR5, OAS must match the system physical address size.
> > >
> > > This patch doesn't change the SMMU OAS, but refactors the code to
> > > make it easier to do that:
> > > - Rely everywhere on IDR5 for reading OAS instead of using the
> > >   SMMU_IDR5_OAS macro, so, it is easier just to change IDR5 and
> > >   it propagages correctly.
> > > - Add additional checks when OAS is greater than 48bits.
> > > - Remove unused functions/macros: pa_range/MAX_PA.
> >
> > Hi; Coverity has spotted a possible problem with the OAS handling
> > in this code (CID 1558464). I'm not sure if that's directly because of
> > this patch or if it's just that the code change has caused Coverity to
> > flag up a preexisting problem.
> >
> > It's quite possible this is a false-positive because Coverity hasn't
> > noticed that the situation can't happen; but if so I think it's also
> > sufficiently unclear to a human reader to be worth addressing anyway.
> >
> > > -static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> > > +static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
> > > +                             STE *ste)
> > >  {
> > > +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
> > > +
> > >      if (STE_S2AA64(ste) == 0x0) {
> > >          qemu_log_mask(LOG_UNIMP,
> > >                        "SMMUv3 AArch32 tables not supported\n");
> > > @@ -460,7 +463,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> > >      }
> > >
> > >      /* For AA64, The effective S2PS size is capped to the OAS. */
> > > -    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), SMMU_IDR5_OAS));
> > > +    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), oas));
> >
> > oas2bits() is implemented as a function that returns -1 if the input
> > isn't a valid OAS. But we don't check for that failure here, so we put
> > the result into a uint8_t, which ends up as 255. Then later in
> > the function we will do
> >   MAKE_64BIT_MASK(0, cfg->s2cfg.eff_ps)
> > which will do an undefined-behaviour shift by a negative number
> > if eff_ps is 255.
> >
> > If the invalid-OAS case is impossible we should assert rather
> > than returning -1; if it's not impossible we should handle it.
> >
> > Mostafa, could you have a look at this, please?
>
> Yes, it should be impossible to have an invalid OAS.
>
> This patch doesn't change the old behaviour, it just consolidate OAS
> setting in one place, instead hardcoding it everywhere, so here
> instead of using the macro (SMMU_IDR5_OAS) directly we now read it
> from IDR5, which is set to SMMU_IDR5_OAS at smmuv3_init_regs().
>
> The other field S2PS is casted to 6 bits, and as we use MIN, and
> all the previous values are valid, so it should be fine:
> - 0b000: 32 bits
> - 0b001: 36 bits
> - 0b010: 40 bits
> - 0b011: 42 bits
> - 0b100: 44 bits
>
> Adding an assertion makes sense to me. Please, let me know if you
> want me to send a patch for that.

Yes, if this can't happen even with invalid guest input, please
send a patch that asserts that.

thanks
-- PMM

