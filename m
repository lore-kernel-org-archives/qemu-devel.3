Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C585C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuEZ-0002YZ-Ap; Fri, 01 Aug 2025 14:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhslO-0002yd-VH
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:37:52 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhslM-0002cT-6d
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:37:45 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e8e14cf9e2aso1911371276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754066263; x=1754671063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o6wvhG3N+qc0vNBp7kVbyWSWqk/t57hJQAjtDWhWDwU=;
 b=fNtmJuvangrq9tICIHWAUQ6gm8yJl38jgsHMxzjBwiZHzQCVZlrRcCf5WYfJ+1cr7d
 YoaK9u9GwpoYCpBcNjcWyaNVccHiYKKcc9dyp30jXw1gGWIl3ttZ3d6okjY201L9JxI8
 r9VA+Od7jL0VWSMo/Oa5/0Q9uUGHgBEgc9JFu9JvlhdijnB9YZH9Zm14w86ccAiDyLLm
 ChhuFxmsVgQKOF4J5SXOH89IQm6EBcIpxTdS9T2NtfPi0lZZujLs8DNaWTWpSHZcraXs
 gBaAN3QPYKz+CJQZ7HOpKfIuUmI3RRTsrWfEmIP/2VfmbZT9PMTJzlwx1vaohVJ1GOk6
 ulKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754066263; x=1754671063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6wvhG3N+qc0vNBp7kVbyWSWqk/t57hJQAjtDWhWDwU=;
 b=kucNoiIQwHYE6rS6XCx8yeDFlq/OoxEpTNYjAToiLopAKkqec2OKHTeMaslvcsyrMG
 1tDTg4Fq85KMs2DZoSg41+hY7P6qWUHa6EiDY7GDdiixDjEqjLVmpRI1WdM61IdXFsyD
 5rHd9ei5+HMGhrtP+hjzwMpHXZdg9ANobtZRn5cE8Oqg/bEoeg5oll3qNLyNzHkA0kV7
 tMC5tVD4OIGYW0KgSlXma8mqGc2jDFEcuaFuPCUkwCg0GrGh/L1kbqV8o1pksImdu5hd
 UgGZVm1G4hDPyEzLN0UuvklZfIaqLuWjA9ErQkizoUWRPTdiOu5B6PoVpXnq4DuDfq+L
 eBAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoImeAwbK2PuAAqoOd6uYZ6VYze4AblctW+eLBVBELqmO3aun5MnFM7si7oMc5iG0u+XWimItoI/zw@nongnu.org
X-Gm-Message-State: AOJu0YyGr1ZZy9T0RJ+QNjQsLQnDYV2LwpwczNezZIH6EYGO5tUx8qHQ
 0WjZ+YVHorEf2DtTSD5ngQOUK7YKPCrE6mcNLBfWrwtmfoDBz9yMNGczpkFcOE5WjSrG2u4Q3nM
 AFIXY4Y948PrY0Evqsm9wrdiIwshJKz49ulnKHklj7A==
X-Gm-Gg: ASbGncvVA2A6nURVYzrP8tsXJx7AqDT6iM/t+Umsgp+5KkU+l8oIKwqSVO/siA3xp7M
 prtuZwP5a5cTG8e20O/ooRgNVed/jjkZFSNGfMLqcVPfDTjhQsWqdYPBaRbFjfuaFfHWEYUj9aD
 vQHErQzp2+zgoynNtk2h3aAumyEPdQ1o8v26Xu2WZfHloKYdWAd3STvB4nBaf3j9CoGJPcy6t1b
 M42yob6
X-Google-Smtp-Source: AGHT+IG9mY2aGPSxyivwuDVY8viMx/RoSGqYncyUm6TzvVuWeQGcMmHKoWBdpmKJ3vm6GtKElWERe+x3apJoZqJW+KY=
X-Received: by 2002:a05:690c:d96:b0:71a:1e72:84c6 with SMTP id
 00721157ae682-71b7f5e133emr3841217b3.1.1754066262739; Fri, 01 Aug 2025
 09:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
 <2c337408-5caa-4e24-a8dd-d947203a1dc3@linaro.org>
In-Reply-To: <2c337408-5caa-4e24-a8dd-d947203a1dc3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:37:31 +0100
X-Gm-Features: Ac12FXzdJcNwN20FjQK44CG3SDhOjse_9wCuWeFpv3ANO9STSycHhTWBwR5LZyg
Message-ID: <CAFEAcA-LmS0dus5ZW6P+-VXkw=m4K3MaE6O+Qtj5i3H7ULJFFQ@mail.gmail.com>
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 1 Aug 2025 at 17:26, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/1/25 6:22 AM, Peter Maydell wrote:
> > On Thu, 31 Jul 2025 at 21:34, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> On 7/27/25 1:02 AM, Richard Henderson wrote:
> >>> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> >>> index 64ee9b3b56..3cef47281a 100644
> >>> --- a/target/arm/gdbstub64.c
> >>> +++ b/target/arm/gdbstub64.c
> >>> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> >>>        case 32:
> >>>            return gdb_get_reg64(mem_buf, env->pc);
> >>>        case 33:
> >>> +        /* pstate is now a 64-bit value; can we simply adjust the xml? */
> >>>            return gdb_get_reg32(mem_buf, pstate_read(env));
> >>>        }
> >>
> >> If I'm correct, we currently don't expose PSTATE through gdbstub, but
> >> only CPSR. This was a bit confusing for me, considering that CPSR is not
> >> even supposed to exist in Aarch64.
> >> Maybe it's a good opportunity to expose PSTATE instead, which could have
> >> a 64 bits size. This way, we don't break any workflow.
> >
> > Architecturally, PSTATE is simply an abstract bundling together of
> > different information: it is not a particular format of a value,
> > whether 32 or 64 bit or otherwise. (This makes it different to
> > AArch32 CPSR, which really is a guest-visible register.)
> >
>
> I see.
> Then maybe what we really miss are the special registers associated to
> PSTATE (CurrentEL, DAIF, NZCV, ...) which are defined architecturally.
> When I tried to read EL for the first time using gdbstub, I was looking
> for CurrentEL, and finally found it accidently under CPSR.
> Would that make more sense?

I think for backwards-compatibility reasons we should stick
with the current cpsr format for the information that is in it.
We do at least define the fields so you get a nice view of it:

(gdb) print $cpsr
$4 = [ EL=0 BTYPE=0 Z ]

> > The thing that *is* defined architecturally is the SPSR_ELx format, which
> > is where various bits of PSTATE get saved when reporting an exception up
> > to a higher exception level (and which is pretty much the AArch32 CPSR
> > format when the lower EL is AArch32). (Note that not *all* of PSTATE
> > appears in the SPSR_ELx: for example the SME SM and ZA bits are
> > considered part of PSTATE but they aren't saved into SPSR_ELx.)
> >
> > For convenience, various pieces of software pass around information
> > in that SPSR_ELx format. Calling this either "CPSR" or "PSTATE"
> > is not really correct, but either is perhaps less confusing than
> > calling it SPSR when the context is that of the code running at the
> > lower EL rather than the higher.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/kgdb.h#n41
> > suggests that expanding the existing pstate to 64 bits is probably
> > likely to produce problems. Perhaps we should define a pstate_high
> > or something for the top 32 bits?
> >
>
> It seems we don't expose pstate at all now, and from your answer above,
> it would not make sense to expose it directly, as it's not formally
> defined. What is exposed by kgdb?

kgdb currently does the same thing we do, and exposes a 32-bit
"cpsr" value.

-- PMM

