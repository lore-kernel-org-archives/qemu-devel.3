Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF821C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukMBb-0007MC-6J; Fri, 08 Aug 2025 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukMBT-0007LC-Jc
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:26:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukMBR-00037D-EB
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:26:55 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-617d24e7246so2597516a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754656011; x=1755260811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHkclpiD8YC6oyRY7ajOLzf14SPFUCjolM10wDvyHMg=;
 b=w3P/214dOh1vdj++EpoiMqGJYZgJFko0YngnG45+wfz0s0B4jlS5yLWosTrurn1i9g
 oPf/qgxEiQyHXmB6XubXoVEu2G67Z7CTjEhz6gHXYdnBDY2X4zDmn3XWcMIrOzhkW6XP
 86+Btzgf9RWJ9OgQTPm21MuSvJiF1PNk5nTy9WPYEBmFdx6JnNDjU5jqbEbpQEppi0Eg
 o2HYwdvQnzaZgVoynasx8ou6UOFatUlB3jiIUCE4WgmIJMrzSPxI2p+70fsjdXfvPNdo
 aO3CFZkF2Lw2RLTQx/7TluGY6ftM0PdAVDj6TODDFkhyUwLXGI8Lv1lSfsGXS/CHtg8I
 U0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754656011; x=1755260811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHkclpiD8YC6oyRY7ajOLzf14SPFUCjolM10wDvyHMg=;
 b=Lepsut7mud5m94z96167cTRi66HLmwxF7n/4c1FXfP7+CZYYJfku3RwqfNxtSDb/RQ
 LIdg99IjGTi2ukrUDqk7PTAA3E98sbQ+dLPpMZ+b7b1PukL6Zpoqu3AAVhhzY865Rg5M
 AWvUy7afGJWtLY/wtYvVLHIJ5cdc3zeGYQzA/08MNLkxy2acl0cpO7FR7IXA+RcL45j4
 tQAe0/1Hffhl9fRW+0rzCdws21mgxAG9M6Vrw83+m/zcaFBSnr4vufbtqP19VWJGhnT6
 c3uaFWsthTqta0bXeE/0qyfgkKwFwO8zBApLDAbJqm2GTYXU+06w56cFnVG/x9mpsRn4
 nzug==
X-Gm-Message-State: AOJu0YzvWmm09HXEKjQ2vP/7NqAtZOAYcyuOxsNgqi6FBz6qwa8yRc2C
 TUi8hb5rGUC5QmRPjUNRP2kwcqLj2pMwK2ymFg7cmJ4Y9aXdr0gE0ywVqB9uyIH4UR8rN6GCuP1
 glh2oszjuFYleJjzacySA0tqti1PPE8KeUhKxsIIPNw==
X-Gm-Gg: ASbGncuJ0sewG7F80vawIb7cVBQdudw4wIOoBkT1Mpet1cA1ncSQOJ2T0cplhiTTwAH
 1+ZD/fBnwRilQV0CdJuYDSFiEUvc++93X8lEqwcUv/6JbGk8IG5LT+bbuv8LRcgESSb7XfweUX/
 CcYGnEH9BA5H95m66VqJfHcnBKuJURmZsG4R/8JdOqp6iZXv+gApTn0bkcGTy3uwNz8ys3XnY31
 A92YMY8
X-Google-Smtp-Source: AGHT+IH6UoqUnU/QpUShLGftP7CdVKHxQa5bhFp5H4j2FM0T7zV7TRg9lzO7HiG8QMMkmeLuEFuHeaP6H3WnYEXA6D0=
X-Received: by 2002:a05:6402:3485:b0:617:bb83:99a0 with SMTP id
 4fb4d7f45d1cf-617e2e7c16dmr2266350a12.30.1754656011113; Fri, 08 Aug 2025
 05:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
 <20250808-gdbstub-aarch64-pstate-regs-v1-1-14ba70be1b3d@linaro.org>
 <CAFEAcA-2Zt7HTDX_bdBHjJyQS7o=csE1x6eDymyEPkV3K+pXrg@mail.gmail.com>
In-Reply-To: <CAFEAcA-2Zt7HTDX_bdBHjJyQS7o=csE1x6eDymyEPkV3K+pXrg@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 8 Aug 2025 15:26:25 +0300
X-Gm-Features: Ac12FXxb_WNFiQ0jXr-R33ezBkmA_j-8G9JPQ6q5lo7r9GQ5a6tc-KGIMngASXk
Message-ID: <CAAjaMXbZK=n_HJGrmuGv1DZZ3AeaX7-fK-soFto4J=w-9=vdmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] gdbstub/aarch64: add CurrentEL register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, Aug 8, 2025 at 3:21=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Fri, 8 Aug 2025 at 12:30, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  gdb-xml/aarch64-core.xml | 5 +++++
> >  target/arm/cpu.h         | 1 +
> >  target/arm/gdbstub64.c   | 6 ++++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/gdb-xml/aarch64-core.xml b/gdb-xml/aarch64-core.xml
> > index b8046510b9a085d30463d37b3ecc8d435f5fb7a4..19ad743dc5607b4021fb795=
bfb9b8e9cf0adef68 100644
> > --- a/gdb-xml/aarch64-core.xml
> > +++ b/gdb-xml/aarch64-core.xml
> > @@ -91,4 +91,9 @@
> >    </flags>
> >    <reg name=3D"cpsr" bitsize=3D"32" type=3D"cpsr_flags"/>
> >
> > +  <flags id=3D"current_el_flags" size=3D"8">
> > +    <!-- Exception Level.  -->
> > +    <field name=3D"EL" start=3D"2" end=3D"3"/>
> > +  </flags>
> > +  <reg name=3D"CurrentEL" bitsize=3D"64" type=3D"current_el"/>
> >  </feature>
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index dc9b6dce4c92297b2636d0d7c0dce580f1806d5b..c3070cd9863381fac40f564=
0e0a7a84dfa1c6e06 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1473,6 +1473,7 @@ void pmu_init(ARMCPU *cpu);
> >   * AArch32 mode SPSRs are basically CPSR-format.
> >   */
> >  #define PSTATE_SP (1U)
> > +#define PSTATE_EL (3U << 2)
> >  #define PSTATE_M (0xFU)
> >  #define PSTATE_nRW (1U << 4)
> >  #define PSTATE_F (1U << 6)
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 08e28585396816ab90d6d8e460ff8171892fe8da..16b564e1a970cb5e854a705=
619f71ffc61545a73 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -48,6 +48,9 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByte=
Array *mem_buf, int n)
> >          return gdb_get_reg64(mem_buf, env->pc);
> >      case 33:
> >          return gdb_get_reg32(mem_buf, pstate_read(env));
> > +    case 34:
> > +        /* CurrentEL */
> > +        return gdb_get_reg64(mem_buf, env->pstate & PSTATE_EL);
> >      }
>
> The debugger already has this information in the 'cpsr'
> register, so it could implement convenience views of
> the subfields itself if it liked.

Yep, but consider: it is a register, architecturally, so it's nice to
include it for consistency. It's redundant only because gdb has cpsr
which is not a register. So this is about more about being technically
correct than correcting an actual problem.


>
> If we're going to do this I would prefer it to be because
> we've gained some consensus with e.g. the gdb maintainers
> that this is the "preferred" way to expose the CPU state.
> The XML config stuff lets us do it in our own way if we
> want to, but I think there is value in consistency across
> stubs here.

I plan to upstream the XML patches to gdb as well, separately. But
since we use custom target xml it's not like we depend on gdb to
change it.

>
> thanks
> -- PMM

