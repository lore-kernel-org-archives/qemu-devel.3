Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C85C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 21:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rajgA-0007Rp-Bo; Thu, 15 Feb 2024 16:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1rajg9-0007RH-9M; Thu, 15 Feb 2024 16:54:01 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1rajg7-0006sA-8y; Thu, 15 Feb 2024 16:54:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2C9DACE1C7C;
 Thu, 15 Feb 2024 21:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E73C43390;
 Thu, 15 Feb 2024 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708034033;
 bh=bSG+m3fb86fIU+19oOnI7aLdthWN/chLHMCrHBYvlX0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XB6EeI2HD1gG9ksFlTcyVsi+qVaYXsr78GJwu1AMKMPvYj6LeBRyYm1ZlF07XqJuN
 jZWvHXF1IdPtJih5n/duKLw2Dc1ahvo04EeN3FUceGl8CAFbYS2m+djEQMm60SozR9
 V1Kn99ualsc9QZQKAyRmVG7uK+lArTiKkoWTLvb5nTyk5824ynmr3yWv7yRxIxQUHc
 1qOgzin6o7OMWN7k1tV8DqMW3lkXGUM6A76n8KMlL/J7aAqFT1OMRXOftdX/GdYrgy
 67GT4l5KyZVt/Y0p+t8J70uSsNRNlwyepfGlMYVkuIgjlEguqegTNKEXNFbyVOY2c0
 BJsEA0mzLOYeg==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-511ac32fe38so2017570e87.1; 
 Thu, 15 Feb 2024 13:53:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWE/4pDEsYFM4Zo64Gj3yTN2a0K44pqXOxIfbEL9TJPBFGebHKg25VgB3YndwwWDW0eHbU/j51JCYTvLvZa0zgY6F5BJGC1byPJK18/PobozfPQhSi5l7etaog=
X-Gm-Message-State: AOJu0YzY98oobbWAsjxZS1fBdDnxKEf2e1746pVzGIQTkSG/20639RPF
 a8VEu+I5faV7j8olhqiWyapYHPfvi9nmIX1mcVeCHr4gtky3Hr6kk4KFpb6IKdvT6ZRvJTHNDoQ
 smE+yz122B1hX7NZZNJUqYND6/NE=
X-Google-Smtp-Source: AGHT+IE/j5sw/3M1bEkVqOlozPWkUNxdgG1XI3y4sGlPKEm9dzHRdJvCmIqYMRg3y2PSvqDosVwqlHGXNEao31cS4R8=
X-Received: by 2002:a05:6512:690:b0:512:8a57:c87a with SMTP id
 t16-20020a056512069000b005128a57c87amr2688075lfe.7.1708034031614; Thu, 15 Feb
 2024 13:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20240215160202.2803452-1-ardb+git@google.com>
 <e3a9fe96-8462-42d5-9e9d-b15dc304250c@linaro.org>
In-Reply-To: <e3a9fe96-8462-42d5-9e9d-b15dc304250c@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 22:53:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG4qfJWc0aWH-KMvL7DFRMyarxMHq+iyBBweTw8NCvdsw@mail.gmail.com>
Message-ID: <CAMj1kXG4qfJWc0aWH-KMvL7DFRMyarxMHq+iyBBweTw8NCvdsw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Advertise Cortex-A53 erratum #843419 fix via
 REVIDR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=ardb@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 15 Feb 2024 at 21:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/15/24 06:02, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The Cortex-A53 r0p4 revision that QEMU emulates is affected by a CatA
> > erratum #843419 (i.e., the most severe), which requires workarounds in
> > the toolchain as well as the OS.
> >
> > Since the emulation is obviously not affected in the same way, we can
> > indicate this via REVIDR bit #8, which on r0p4 has the meaning that no
> > workarounds for erratum #843419 are needed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   target/arm/cpu64.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 8e30a7993e..0f7a44a28f 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -663,7 +663,7 @@ static void aarch64_a53_initfn(Object *obj)
> >       set_feature(&cpu->env, ARM_FEATURE_PMU);
> >       cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
> >       cpu->midr = 0x410fd034;
> > -    cpu->revidr = 0x00000000;
> > +    cpu->revidr = 0x00000100;
>
> Is it worth indicating all three errata fixes (bits 7-9)?
>

835769 has a build time workaround in the linker which I don't think
we even bother to enable in the kernel build. It is definitely not
something the OS needs to worry about at runtime, so I don't think it
matters.

The other one is a performance related CatC without a workaround, so
that one can be ignored as well.

OTOH, our emulation is affected by neither so setting the REVIDR bits
for them makes sense. But there is simply no software that I am aware
of that will behave differently as a result (as opposed to the one for
843419, which is read by the Linux kernel and triggers workaround
logic in the module loader)

> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Thanks.

