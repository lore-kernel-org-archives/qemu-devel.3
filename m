Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1913D62077
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRo5-0007cn-SD; Tue, 19 Nov 2024 12:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDRo1-0007cf-Ej
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:14:26 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDRnx-0001fo-Gr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:14:23 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cfcd99846fso2867774a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732036459; x=1732641259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hiryb1KkcV7nkBd7H0i0x5zejyIdN2CBvhNcucf0Dc8=;
 b=s0LgUJQaSR9PY3tkO/oH71CvzECMupLjA+1czPeNot8gNGu/v2jVbQfHCF2G0SD1af
 5UXhz2kGKnm96RGuUws/M3mGp1KTn5qU71ZIHeyPZtnfLjPmQ+Kx5aSfCHbLXy6ZYDJg
 nx//HuEUZS4ABtOQcJNOvzp91OmK/+/FyNk6iF0R6khPZEOEQQHkvvHhs28V19iimJAi
 QbMecW2G9ncr/YsPQOiC4DxBVsXr79Gf16Up+HQeb9pzhGEq1/KE3zPAQAFt8EjCQ40M
 SQh62R0fLWmRtOSQqb3Y8y9oiL0Ttwoi8Aoj9TUFdft4xzmsdrgHEcGIld3B8rYjLtHO
 i7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036459; x=1732641259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hiryb1KkcV7nkBd7H0i0x5zejyIdN2CBvhNcucf0Dc8=;
 b=aYlnPQsjqXbTq6BzQmC5fCa6TGOxOWeRskp4nSZDl4AwncJtwISR1y5cwqlVnpO5bK
 Wj2V/mO6APIJH53bfjZwYiXk3o+c7TaEpKwEB0rMHtFMSj4CnsMrfoh8EYZRJeWEDEwv
 7u+HF3OK79M2puJcOrEfcbpVX5b/jb70c1uzXdJ1CdGZRpK/c2G8QR8iZN+3MTNOLK3Q
 TmB+tYl75BofvkCCbkwXgaiRexTLFODz5msiaZV++fDAHQWEGRVyDoPXnsSodqNRrNhr
 dcpwtmgfvzzBTLi/iEAGzSMNjJMsx42e1y9YzhQH5+swsMICkz5/iN1tK4rq9kbCHJV5
 EV6w==
X-Gm-Message-State: AOJu0Yy/BRpuBeS+Aw8QBgXr+dgzw0JOrSUQeaA4VyGmFhUkT1zcy4x3
 simNO191C6f0mTv1T64XXlOS/3+WIxnzdJweamxFtZ2lsjpKLMGu3FIdJ1x3+J3eQWA1SbEPbQL
 mrIouKMJ+xLQKRipNmIUJygHHQbrbh6TczQsxfg==
X-Google-Smtp-Source: AGHT+IEoftZMle06NWJQaTrTQU4iDSMSM7phayrypYeRmD90HKP7X0Yui5T3OvmxHtDR0A4V083R21ZMj67BIcHnqbM=
X-Received: by 2002:a05:6402:35c1:b0:5cf:d1b5:1b91 with SMTP id
 4fb4d7f45d1cf-5cfd1b51bc4mr4825864a12.15.1732036458594; Tue, 19 Nov 2024
 09:14:18 -0800 (PST)
MIME-Version: 1.0
References: <51442716-467b-46c2-b2f7-8ffdeeca320e@linaro.org>
 <CAFEAcA_eL+F572fZpFW2+Tz6xx5Mx5ux-axe3HR_fEf43_GLRA@mail.gmail.com>
 <33af12d7-9269-4c21-96d4-aa76becd0f09@linaro.org>
In-Reply-To: <33af12d7-9269-4c21-96d4-aa76becd0f09@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2024 17:14:07 +0000
Message-ID: <CAFEAcA9YGBxGTOXT0F3eCAVD+pqEa-kLY94GtFKHU31reSb=rQ@mail.gmail.com>
Subject: Re: Status of some Arm features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 19 Nov 2024 at 16:52, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 11/19/24 02:09, Peter Maydell wrote:
> > On Mon, 18 Nov 2024 at 23:33, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >> I'm currently reviewing the QEMU Arm documentation, and I have a
> >> question about the status of following features:
> >>
> >> 8.0:
> >> - FEAT_DoubleLock, Double Lock
> >
> > This is actually an "anti-feature" :-)  It is optional from v8.0
> > and it must not be implemented from v9.0. We implement the handling
> > of it based on the DOUBLELOCK fields in ID_AA64DFR0 and DBGDEVID
> > (so it does the right thing on older named CPU types) and don't
> > advertise it in "max".
> >
>
> Despite this singularity on versions implementation, should we list that
> in our documentation?

Yeah, I think we reasonably could.

> >> 8.2:
> >> - FEAT_ASMv8p2, Armv8.2 changes to the A64 ISA (bfc and rev64 instructions)
> >
> > This isn't a feature for CPU implementations; it's a feature for
> > assemblers and disassemblers, which have to recognize BFC and
> > REV64 mnemonics as being ways to write special-case flavours
> > of the BFM and REV instructions.
> >
>
> Reading the feature description [1] or the A-profile manual:
> FEAT_ASMv8p2 introduces the BFC instruction to the A64 instruction set
> as an alias of BFM. It also requires that the BFC instruction and the
> A64 pseudo-instruction REV64 are implemented by assemblers.
>
> I understand it's both introducing the BFC instructions *and also*
> ensure that BFC and REV64 are implemented by assemblers.
> Is my interpretation wrong?

For an implementation, there is no BFC instruction. If you look
at the Arm ARM entry for BFC, it says "This instruction is an alias
of the BFM instruction", which means it exists only for
assemblers and disassemblers and assembly authors.
(And if you look at the BFM instruction, there is no subset of the
encoding that is gated on any feature; so there is no extra
behaviour of BFM that got added here.)

These "alias" instructions are there to make the assembly be
a bit easier to read. The only unusual thing about this alias
is that it wasn't in the architecture right from the start,
which I think is why it got a FEAT_ name: to flag up that
if you're writing asm or if you're an assembler author then
you need to do something here. But if you're creating an
implementation of a CPU, then there's nothing to do, because
you already implemented the handling of BFM as part of ARMv8.0.

For an example of an alias that was present from v8.0, look
at "MOV (to/from SP)". This is an "ADD (immediate)" instruction
under the hood, but you can write it in assembly source as
"MOV SP, Xn", and the assembler will put in the same bit pattern
as if you'd written "ADD SP, Xn, #0". In QEMU (or in a hardware
implementation) we don't need to do anything for "MOV SP, Xn",
because our implementation of "ADD (imm)" will catch it.

> >> 8.4:
> >> - FEAT_CNTSC, Generic Counter Scaling (hw/timer/sse-counter.c)
> >
> > This is optional, and we don't implement it yet. (There's an
> > open ticket for it in Linaro JIRA at
> > https://linaro.atlassian.net/browse/QEMU-309 )
> >
>
> Ok. For my personal knowledge, does the implementation in
> hw/timer/sse-counter.c is related to it?

I elaborated a bit on that in my other email -- they're
doing a similar thing, but sse-counter.c is M-profile.

-- PMM

