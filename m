Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861A4D1CDBD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Aij-0007r4-0Y; Tue, 22 Oct 2024 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Aid-0007qg-T9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:58:23 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Aib-00041b-Qa
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:58:23 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99c0beaaa2so888044166b.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729587499; x=1730192299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Hbii3qoqshHnZmu2mOvTiKwFvNvhl1mTvsi8OlfoJ8=;
 b=D4E/DP3Bur1mq/rl5bwb9I+Udq3a3UPH+wz0YDdPj4jf0BiedpNUlcreuXa6VfuESP
 c2fXQiDgIP/rqbFV5tjZRjcQYr0INC2ty6uPlI5oeGTjzdZ1FUI0xCbTFoWDTNx9VkGz
 Qxv6QcqZjCD0XxJK209B6KUBTuwPl78VSx3FDQu2rC1VvvAi077TSXjmgznJ9CJr5suO
 /PZoqPru6M7bXIFTqZv+WGSD+Fy/kJ6XNG+9HvpMg3nzvhTErLdddmYESI7WolQzhbJf
 UVAqCo0OY3ijmK1YjeCwlUbhK55ib0ayw/UQGnrOgcTA3YQF7cJtcXf73wDmZjx/KzRL
 HaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729587499; x=1730192299;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Hbii3qoqshHnZmu2mOvTiKwFvNvhl1mTvsi8OlfoJ8=;
 b=CFMTsa/LOdrjxe+H039WgSlph8j8inber4df3c/IQMh0Yny5msVzqobdF2WiHJtR0D
 FIlYrDFBg0By/cLL9LdYoWGu1KLcYj+JUdpcHUoEgTMmwwkdd1gYQpzsuhyCl0kWFkqC
 oEv2sutJi3/uqAEcsXD4ysSL2uZohmVwWg6Oolnle2BiGE45MrFJblP9p01NJDZRsl8F
 017qGVguJiadEFn5PIw8C7o4AEEV+OD/h+RLKqJgJi3+zeQLeuPhQ0EagXeLMGvfl0qM
 8AXYE/w/C+xSNMWLunw6nlqqpa+d+larjtaDqz5M0izXX/dwJRsqCcV157rbmzw6TnBn
 GLqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGE+IEwIM15FrC5q0e/O9Psaw9Lp+Q+QZD2818W1esxLouaIV6Pr64OoQYFQU8382JgYzitinf00z1@nongnu.org
X-Gm-Message-State: AOJu0YwKU/itZf0T6KTLfztftlkeN7k6Obnyisdt9hE4XOOsLJoh9l12
 0LxP/oKBB3yiia3ukodlZb2vgBYGemhavy9pXCHkviFRoet0HBtCJPOWaPYAezxt4r5+RDCZFm9
 J
X-Google-Smtp-Source: AGHT+IFzVDNmeDW3vB14l5ZCsMRlaVcVcHCRuVymUVPtu/sQxB8sk882AXwHbvfx5GtQDoVgRb3esg==
X-Received: by 2002:a17:907:7f23:b0:a9a:2afc:e4cc with SMTP id
 a640c23a62f3a-a9a69cdf994mr1434468466b.58.1729587499421; 
 Tue, 22 Oct 2024 01:58:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91370e91sm306801766b.123.2024.10.22.01.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 01:58:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 207F35F893;
 Tue, 22 Oct 2024 09:58:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Julian Ganz" <nenut@skiff.uberspace.de>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,  "Julian Ganz"
 <neither@nut.email>,  qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
In-Reply-To: <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 (Julian Ganz's message of "Tue, 22 Oct 2024 08:21:22 +0000")
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 22 Oct 2024 09:58:18 +0100
Message-ID: <87wmi0ms45.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

"Julian Ganz" <nenut@skiff.uberspace.de> writes:

> Hi, Pierrick,
>
> October 21, 2024 at 11:59 PM, "Pierrick Bouvier" wrote:
>> On 10/21/24 14:02, Julian Ganz wrote:
>> >  The motivation for this API is a plugin that simulates a RISC-V traci=
ng
>> >  unit (and produces a trace). For that we actually also needed to
>> >  track the "regular" control flow, i.e. find out whether a branch was
>> >  taken or where a jump went. That wasn't hard, especially considering
>> >  that the TCG API already gives you (more or less) basic blocks. Still,
>> >  we ended up tracing every instruction because that made some of the l=
ogic
>> >  much simpler and easier to reason about.
>> >  We realized that we need a trap API because they:
>> >  * can occur at any time/point of execusion
>> >  * usually come with additional effects such as mode changes.
>> >=20
>> Thanks for sharing your insights.
>> I think there is definitely value in what you offer, and I'm trying
>> to think how we could extend it in the future easily, without having
>> another callback when a new event appear. In my experience on
>> plugins, the least callbacks we have, and the simpler they are, the
>> better it is.
>>=20
>> Maybe we could have a single API like:
>>=20
<snip>
>
> Traps are just too diverse, imo there is too little overlap between
> different architectures, with the sole exception maybe being the PC
> prior to the trap. "Interrupt id" sounds like a reasonably common
> concept, but then you would need to define a mapping for each and every
> architecture. What integer type do you use? In RISC-V, for example,
> exceptions and interrupt "ids" are differentiated via the most
> significant bit. Dou keep that or do you zero it? And then there's
> ring/privilage mode, cause (sometimes for each mode), ...
>
> It would also complicate call sites for hooks in target code. You'd
> either need awkwardly long function signitures or setup code for that
> struct. Both are things you don't want, as a hook call site should
> never distract from the actual logic surrounding them. You could
> probably have something reasonable in Rust, using a builder/command
> pattern. But in C this would require too much boiler plate code than
> I'd be comfortable with.

How easy would it be to expose a Rust API? I'm curious because now we
are looking to integrate Rust into QEMU we could consider transitioning
to a Rust API for plugins. It has been done before:

  https://github.com/novafacing/qemu-rs/tree/main/qemu-plugin-sys

and

  https://github.com/novafacing/qemu-rs/tree/main/qemu-plugin

I'm curious as to what it would look like. I don't know how tenable it
would be to run 2 plugin APIs side-by-side long term though. We would
probably want to make a choice. Also how would that affect other C like
APIs like python?

>
> Regards,
> Julian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

