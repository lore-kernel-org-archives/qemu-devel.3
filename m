Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7EDC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QzJ-00075C-GY; Mon, 28 Apr 2025 12:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9QzC-0006zS-32
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:05:38 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9Qz0-0007YG-Rq
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:05:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223fb0f619dso56304545ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745856322; x=1746461122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AQqQXg/3MYPjMQmC4x06+ud5ksukLFNdy/HiIea8tD4=;
 b=E93blDMIEy0Eo0+sqXB482VPx1Km+VCHm2WPN9qaIMuo7e098YHJCVHJwAcgdqkbpD
 SLzIWxR9NZ02yMI6vprS2hmCExpw4K/ueICWoeYdmN+WPc/H+/q258KfbifzoKJcqylM
 odQ1JyJ9Jm/XBH98hNcK7t21vvKrgHqrVrCJaoGCQN06JaLB7Vxnk0344Vq4jEv+59GF
 F6WCnbBxDVguXPTAvSK678iX9PGTin63y1X8gvcLlilaRAWhvX3D5Oy3A/pDJKvhruNy
 s1sQWHJR7PSfrvG+3JZl+cO67miC8W5Qp88hODlJ366XNYNZ+vSsfDNhGlfpSIn0p6Lb
 1JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856322; x=1746461122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AQqQXg/3MYPjMQmC4x06+ud5ksukLFNdy/HiIea8tD4=;
 b=YMYdTYiM627BTvmAWv7C3wbqWuMJPHT8ylTKJyGXCDpdvjDCDDl5OkRX+Be38tNVg4
 dlIjus2u099Cna+rZnKDaC3I/+1aeA8Jj65eN3xDDe/2LjEmaRGGtexNuboZQaYsdbwX
 w2ynNqSJen55Li/2OqEgdmHJfXMqGFC//11IjmpQehEmKd7CZMNiJqfaNS3P9fEeFvLh
 +i2Vl5XPuUj80vvSzXnzrefkE7Rm+zwAaHTPR/70+iJJWkAeBT/Oxpo+7bidE9dyUy4F
 KAl4iTpFeGXqJjAtx2gJ8A9NyF4VpsVNQCy05pUk/re7CdaQ2+1wH00NFl4e7lbNNRsP
 /DZg==
X-Gm-Message-State: AOJu0YwUYTGsjqTX39x1PCgB8kfT5h5B4FbSrXqytFrdeH10irnb01Jb
 OdKCielFZ5wUTkWPmoAatc2UQnumZUvlrBGigGi629U+6ma1BXSgX3oFV2TJ/F0=
X-Gm-Gg: ASbGncvmg6ubyZlWD46sX2OJ9EsOyXc7xmGB14ZWygkI4FI3Y5eE48J6R2J7JPLz8FT
 3niHTlysJ36lDfeG2m9A8Gx3oFbYVGk7thJad6Pi82dACbgTxeNHUnEBet61loTqkWNJbHePZ8h
 pPAXlb4GFJkKtAkFI6e3reKWB/S0Oq2snU9sqnbpz2nfCr5ur+jRQ1364InHY3OKb2QBv1j3r7o
 4JZJAgEt2ECsUfqdHxoi/JT3XhdL20+lWETw9m+CxVkzZ74hkGqyb4y646Qwr2K62Ht/3Q+16aR
 xmpt17Q1f9hZ64CAx1XvQzy3iaGSHebbwtTkuH3wpj2Agf9RaJsPwfyfympQ9ICd
X-Google-Smtp-Source: AGHT+IHcF8mRnxbMq54QyFIHrh8Kn+88GXCwx5v895cugLbrArhNNad7uyjrOWk+HMXLgdT5p5PZZg==
X-Received: by 2002:a17:903:3c48:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22dbf64099dmr163513895ad.42.1745856321880; 
 Mon, 28 Apr 2025 09:05:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51025basm84725995ad.187.2025.04.28.09.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:05:21 -0700 (PDT)
Message-ID: <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
Date: Mon, 28 Apr 2025 09:05:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, devel@lists.libvirt.org,
 Victor Toso <victortoso@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87a583789z.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/25/25 11:21 PM, Markus Armbruster wrote:
> Trouble is some uses of the second kind are in QAPI conditionals.  I can
> see three options:
> 
> (1) Drop these conditionals.
> 
> (2) Replace them by run-time checks.
> 
> (3) Have target-specific QAPI-generated code for multiple targets
>      coexist in the single binary.
> 
> As far as I can tell, your RFC series is an incomplete attempt at (2).
> 
> I gather you considered (3), but you dislike it for its bloat and
> possibly other reasons.  I sympathize; the QAPI-generated code is plenty
> bloated as it is, in good part to early design decisions (not mine).
> 
> Your "no noticeable differences" goal precludes (1).
> 
> Back to (2).  In C, replacing compile-time conditionals by run-time
> checks means replacing #if FOO by if (foo).  Such a transformation isn't
> possible in the QAPI schema.  To make it possible, we need to evolve the
> QAPI schema language.
> 
> docs/devel/qapi-code-gen.rst describes what we have:
> 
>          COND = STRING
>               | { 'all: [ COND, ... ] }
>               | { 'any: [ COND, ... ] }
>               | { 'not': COND }
> 
>      [....]
> 
>      The C code generated for the definition will then be guarded by an #if
>      preprocessing directive with an operand generated from that condition:
> 
>       * STRING will generate defined(STRING)
>       * { 'all': [COND, ...] } will generate (COND && ...)
>       * { 'any': [COND, ...] } will generate (COND || ...)
>       * { 'not': COND } will generate !COND
> 
> So, conditions are expression trees where the leaves are preprocessor
> symbols and the inner nodes are operators.
> 
> It's not quite obvious to me how to best evolve this to support run-time
> checks.
> 

After looking at the introspection code, I don't see any major blocker.
We need to keep some of existing "if", as they are based on config-host, 
and should apply.
We can introduce a new "available_if" (or any other name), which 
generates a runtime check when building the schema, or when serializing 
a struct.

This way, by modifying the .json with:
- if: 'TARGET_I386'
+ available_if: 'target_i386()'

This way, we keep the possibility to have ifdef, and we can expose at 
runtime based on available_if. So we can keep the exact same schema we 
have today per target.

> Whatever we choose should support generating Rust and Go as well.  Why?
> Rust usage in QEMU is growing, and we'll likely need to generate some
> Rust from the QAPI schema.  Victor Toso has been working on Go bindings
> for use in Go QMP client software.
> 

I don't see any blocker with that. If you mention generating Rust and Go 
from qapi json definitions, it's already dependent on C preprocessor 
because of ifdef constant. So it will have to be adapted anyway.
Having the same function (target_i386()) name through different 
languages is not something hard to achieve.

>>> The build system treats QAPI modules qapi/*-target.json as
>>> target-specific.  The .c files generated for them are compiled per
>>> target.  See qapi/meson.build.
>>>
>>> Only such target-specific modules can can use target-specific QAPI
>>> conditionals.  Use in target-independent modules will generate C that
>>> won't compile.
>>>
>>> Poisoned macros used in qapi/*-target.json:
>>>
>>>       CONFIG_KVM
>>>       TARGET_ARM
>>>       TARGET_I386
>>>       TARGET_LOONGARCH64
>>>       TARGET_MIPS
>>>       TARGET_PPC
>>>       TARGET_RISCV
>>>       TARGET_S390X
>>>
>>>>                              What we try to do here is to build them only once
>>>> instead.
>>>
>>> You're trying to eliminate target-specific QAPI conditionals.  Correct?
>>>
>>
>> Yes, but without impacting the list of commands exposed. Thus, it would
>> be needed to select at runtime to expose/register commands.
> 
> Conditionals affect more than just commands.
>

Thus, the proposal above to do the same for concerned struct members.

>>>> In the past, we identied that the best approach to solve this is to expose code
>>>> for all targets (thus removing all #if clauses), and stub missing
>>>> symbols for concerned targets.
>>>
>>> This affects QAPI/QMP introspection, i.e. the value of query-qmp-schema.
>>>
>>> Management applications can no longer use introspection to find out
>>> whether target-specific things are available.
>>>
>>
>> As asked on my previous email answering Daniel, would that be possible
>> to build the schema dynamically, so we can decide what to expose or not
>> introspection wise?
> 
> QAPI was designed to be compile-time static.  Revising such fundamental
> design assumptions is always fraught.  I can't give you a confident
> assessment now.  All I can offer you is my willingness to explore
> solutions.  See "really fancy" below.
> 
> Fun fact: we used to generate the value of query-qmp-schema as a single
> string.  We switched to the current, more bloated representation to
> support conditionals (commit 7d0f982bfbb).
>

It's nice to have this, and this is what would allow us to 
conditionnally include or not various definitions/commands/fields. I was 
a bit worried we would have a "static string", but was glad to find a 
static list instead.

>>> For instance, query-cpu-definitions is implemented for targets arm,
>>> i386, loongarch, mips, ppc, riscv, and s390x.  It initially was for
>>> fewer targets, and more targets followed one by one.  Still more may
>>> follow in the future.  Right now, management applications can use
>>> introspection to find out whether it is available.  That stops working
>>> when you make it available for all targets, stubbed out for the ones
>>> that don't (yet) implement it.
>>>
>>
>> I will repeat, just to be clear, I don't think exposing all commands is
>> a good idea.
>> The current series *does not* do this, simply because I didn't want to
>> huge work for nothing.
> 
> Got it.
> 
>>> Management applications may have to be adjusted for this.
>>>
>>> This is not an attempt to shoot down your approach.  I'm merely
>>> demonstrating limitations of your promise "if anyone notices a
>>> difference, it will be a bug."
>>>
>>
>> I stick to this promise :).
>>
>>> Now, we could get really fancy and try to keep introspection the same by
>>> applying conditionals dynamically somehow.  I.e. have the single binary
>>> return different introspection values depending on the actual guest's
>>> target.
>>>
>>> This requires fixing the target before introspection.  Unless this is
>>> somehow completely transparent (wrapper scripts, or awful hacks based on
>>> the binary's filename, perhaps), management applications may have to be
>>> adjusted to actually do that.
>>>
>>> Applies not just to introspection.  Consider query-cpu-definitions
>>> again.  It currently returns CPU definitions for *the* target.  What
>>> would a single binary's query-cpu-definitions return?  The CPU
>>> definitions for *all* its targets?  Management applications then receive
>>> CPUs that won't work, which may upset them.  To avoid noticable
>>> difference, we again have to fix the target before we look.
>>>
>>> Of course, "fixing the target" stops making sense once we move to
>>> heterogeneous machines with multiple targets.
>>>
>>
>> At this point, I don't have think about what should be the semantic when
>> we'll have multiple targets running simultaneously (expose the union,
>> restrict to the main arch, choose a third way).
> 
> We have to unless we make query-cpu-definitions fail or impossible to
> send while the target is still undecided.
> 
> Making it fail would violate the "no observable differences" goal.
> 
> The only path to true "no observable differences" I can see is to fix
> the target before the management application interacts with QEMU in any
> way.  This would make QMP commands (query-cpu-definitions,
> query-qmp-schema, ...) impossible to send before the target is fixed.
>

The current target will be set at the entry of main() in QEMU, so before 
the monitor is created. Thus, it will be unambiguous.

>>>> This series build QAPI generated code once, by removing all TARGET_{arch} and
>>>> CONFIG_KVM clauses. What it does *not* at the moment is:
>>>> - prevent target specific commands to be visible for all targets
>>>>     (see TODO comment on patch 2 explaining how to address this)
>>>> - nothing was done to hide all this from generated documentation
>>>
>>> For better or worse, generated documentation always contains everything.
>>>
>>
>> Fine for me, it makes sense, as the official documentation published,
>> which is what people will consume primarily, is for all targets.
>>
>>> An argument could be made for stripping out documentation for the stuff
>>> that isn't included in this build.
>>>
>>>>   From what I understood, the only thing that matters is to limit qmp commands
>>>> visible. Exposing enums, structure, or events is not a problem, since they
>>>> won't be used/triggered for non concerned targets. Please correct me if this is
>>>> wrong, and if there are unexpected consequences for libvirt or other consumers.
>>>
>>> I'm not sure what you mean by "to limit qmp commands visible".
>>>
>>> QAPI/QMP introspection has all commands and events, and all types
>>> reachable from them.  query-qmp-schema returns an array, where each
>>> array element describes one command, event, or type.  When a command,
>>> event, or type is conditional in the schema, the element is wrapped in
>>> the #if generated for the condition.
>>>
>>
>> After reading and answering to your valuable email, I definitely think
> 
> Thanks!
> 
>> the introspection schema we expose should be adapted, independently of
>> how we build QAPI code (i.e. using #ifdef TARGET or not).
>>
>> Is it something technically hard to achieve?
> 
> Unclear.  See "fundamental design assumptions" and "need to evolve the
> QAPI schema language" above.
> 
> If you want to learn more about introspection, I'd recommend
> docs/devel/qapi-code-gen.rst section "Client JSON Protocol
> introspection".
>

I'll give a try at conditioning all this by runtime checks, so you can 
review which changes it would create.

> [...]
> 

Regards,
Pierrick

