Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FD7C79F90
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckt3-0003HF-NG; Mon, 05 Jan 2026 08:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vcksH-00035q-LZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 08:43:57 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vcksF-0007Fl-0H
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 08:43:57 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-888310b91c5so15025976d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767620633; x=1768225433; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ukVIvuBiKsEjyg12crAnHzqmC6Yi4Ie1ngM/NlsLTmI=;
 b=gv4Ay/VnGWhuLVtBbvSrgJv1VA6wtMlEHh9O4wC7x1592viQ/Qw+ZJLWukguTD//LY
 cfL7FO/rogRHGlw+m773JafsitW+DB9WwuttLoxUTRwtE2OVZIqammyAEcr+c7s76ll6
 JW4MC+u+GNxKDmhKEZTMmPCKTwNmZp/35tFDDmLM0Tx6NRT0msTfbAsBXpS5YFSLO00O
 1Gx6eTAnR3pP2QREheG7W1tnSW7Q8dzge2Lvg7dMcwzMMIDiMPsZ6kqUILKZ3r/fkGui
 KJzMNXVReri2q850tqYUxvvh89XFs2ZAQIgcS5a+h1DW7gUwRr5awKQywTdenKDKzapy
 lIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767620633; x=1768225433;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ukVIvuBiKsEjyg12crAnHzqmC6Yi4Ie1ngM/NlsLTmI=;
 b=a8kSZkUbhj96wHeV/ZP/2rAEHk5E7/m62HLen3rOJrKkNsF69FWS2AwTaZddBporo7
 v9DW3o7G8otqRraMa2WQC6TyhoYM+ntt+Ql8Cfv3QcuJqncLxGxaQymFCwO0E7Qarinm
 bONRc6Z3vwP80oczMtLPrJj9YDNpjACGF09q3P8tVohg1gnRBd/HfCQBiTrSDcFTqlyE
 b+Ivs/7yzqq7UcOH0BWaceALpM7iZBSQ0akuQCKKeIfqGgrlUuAfhdLg1LAQLBrvGCpe
 Cmk1LT8M+eJvMJBJPQjEmLExSV73fYVPgBsb0335srbSOB7wfPsty6ixnUDZ8KJKK3pN
 OE1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe4RoY5T3cA5o2wYqbUwGd8ZxC/4xjYMvBoRDbHDVBJdl0P4UpQAz7GwcZVG/T50w5g7NX66or2bmq@nongnu.org
X-Gm-Message-State: AOJu0YwpXToTzTQr6ItSfwhfZKX//zEO/R6XC4wN7cvmODPbv07gYhe2
 5nVXMb855aPYHdQ59SwCIJHdOy7iugF+tOJ8hYjAJzgln0te910W7cdxjirmyEx47Duvp9jx3MS
 3xNnXJdc8V3U3YVSPbx1v0YfyjYyhVDKFU4lgwtl8cA==
X-Gm-Gg: AY/fxX4zm9jG2soTnx+RlbZe088DdOn60n6P6QMf6KLw8tsU8wyI2BhzTVaH1sUFeyz
 pjcom/wa/lohPfeWjp2Z9UzZhSuUR/IB4QV+QD8F5BYom42A96ENpXPB9URFzz2SURRMkAvtcHN
 bbd4Z1s1zueGGJYBVnqtewmY89UfWpmt3BkTcaOrFPKcm21i9B1TaZaooZOjBULep5Xz6l5Lhi/
 YVla18DNegZqfCRbTlxPiTUuva882OmxTFaR0VXw7IB7gKAT42siuplQ0WAIk9UyqrymX4YlQ==
X-Google-Smtp-Source: AGHT+IHE+NKFLzhS5Pwiw2sy41yqos7Y6s58F9cE/PxSZ96a2cfUjct/kaV8IKjG7MyyXssbN8SuyfNNFxlxFv9myYo=
X-Received: by 2002:a05:622a:4d2:b0:4ee:1ec6:aeda with SMTP id
 d75a77b69052e-4ff472d336amr119416151cf.34.1767620633164; Mon, 05 Jan 2026
 05:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
 <bc812773-1a09-4541-ae6d-7a6d7327b6a5@ventanamicro.com>
In-Reply-To: <bc812773-1a09-4541-ae6d-7a6d7327b6a5@ventanamicro.com>
From: Kito Cheng <kito.cheng@sifive.com>
Date: Mon, 5 Jan 2026 21:43:42 +0800
X-Gm-Features: AQt7F2o20FzBcZD6L3GYMPqSg0smuPIV672ETs2QDkC3wVJgx1WifpPCgtgoAu0
Message-ID: <CALLt3Tig9WLNxfHDKKBzpHz908mZWRACioQWoxfjMk5p7eVVbQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] target/riscv: Add arch= CPU property for ISA
 configuration
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 kito.cheng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=kito.cheng@sifive.com; helo=mail-qv1-xf2f.google.com
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

Hi Daniel:

Thanks for your reply, and here is my response :)

> > 1. How do you run RISC-V QEMU with a specific extension configuration?
> >     Please try to configure an rv64im user mode QEMU before you answer
> >     this question.
>
> I would use the 'rv64i' bare CPU that we introduced a few releases ago
> and enable just 'm':
>
> qemu-riscv64 -cpu rv64i,m=on
>
>
> It gives you a bare bones CPU with only "RVI" enabled. We added this CPU
> specifically to support the use case you mentioned: users that want to
> have full control of what is enabled in the CPU.

Oh, thanks for this info, my impression of this is stuck in my memory of 2022,
which is the time I wrote the qemu wrapper for riscv-gnu-toolchain,
So I'm still using a rather clumsy way to play with qemu.

It's really good to know this, and I definitely need to update the
script in riscv-gnu-toolchain :)

> We can't control how riscv-gnu-toolchain and others implement their scripts and
> wrappers. These are the kind of thing that people write once and never look it
> back, and that's fine.
>
> That said, we have 'rv64i' and other bare CPUs since QEMU 9.0, released in April
> 24. We don't need to do this kind of massive extension disablement to get a
> clean CPU for almost 2 years.
>
> I advise to not take QEMU wrappers, scripts and etc from other projects as a sort
> of proof of what QEMU is currently capable. They're usually outdated.

Yeah, I admit that, I always spend time updating the script for
mapping extension to
extension to qemu option...and it's hard to always be up to date.

> > So how do other tools/simulators address these problems? Toolchains like
> > Clang and GCC use -march with an arch string to configure, and Spike uses
> > --isa=<ISA-string> to configure.
> >
> > Could we introduce a similar way to configure QEMU? Yes, I think we can.
> > That's what this patch set does.
> >
> >    -cpu rv64,arch=<ISA-string>
>
> I don't mind the 'arch' property if users find it easier to enable extensions with
> it rather than the boolean properties, but it should be used on top of bare CPUs
> only. Otherwise the 'arch' property would include the already enabled extensions
> from 'rv64' and others.
>
> And we would need to be okay with the fact that this is redundant to what we already
> can do with bare CPUs + manual extension enablement.

One point here is that the ISA string is the official way to represent
the ISA configuration in RISC-V, it would be simpler if we can use the
same string to set up every tool.

> We have profile CPUs for this use case:
>
> $ ./qemu-riscv64 -cpu help
> Available CPUs:
>    max
>    rv64
>    rv64e
>    rv64i
>    rva22s64
>    rva22u64
>    rva23s64
>    rva23u64
> (...)
>
>
> So 'qemu-riscv64 -cpu rva23u64'  creates an user mode QEMU with RVA23.

To be honest, I was a little hesitant about adding the `arch=<profile>` syntax,
because as you said, `-cpu` is already supported.

My final decision was to add it for alignment with the toolchain interface,
but that's because I'm a toolchain developer.

> > 5. zvl*b extensions
> >     Specify vector length (VLEN) in bits using zvl<N>b where N is a power
> >     of 2 (32-65536). Requires v or zve* extension.
> >
> >     Examples:
> >       $ qemu-riscv64 -cpu rv64,arch=rv64gcv_zvl256b /bin/true
> >       $ qemu-riscv64 -cpu rv64,arch=rv64i_zve64f_zvl128b /bin/true
>
> We already have vlen and elen properties. Not sure if we need another way to set
> the same stuff.
>
> I'll give a closer look later at the first 2 patches (arch=dump and arch=help)
> since these are nice additions for the user experience.

The first two patches should be less controversial, so I'm okay with
that if we decide to get the first two first :)

>
> I would like to hear other opinions about arch=<ISA_STRING> because it would be
> just another way (probably an easier way) of doing what we already support with
> bare CPUs + manual extension enablement.
>
> I don't see the need to support arch=PROFILE given that we have profile CPUs
> that does exactly that. Same thing for the 'vlen' setting.

The primary motivation for supporting zvl*b/VLEN syntax is to align
with the toolchain interface, allowing users to process both qemu and
the toolchain using a single string, and again, that is the official
way to describe that info in RISC-V ISA spec, so I adding this syntax
sugar in arch=<isa-str>.

