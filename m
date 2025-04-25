Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7C0C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8QGz-0007oa-5c; Fri, 25 Apr 2025 17:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8QGv-0007oK-GF
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:07:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8QGn-0002ey-5l
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:07:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224171d6826so44100475ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745615255; x=1746220055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gn7/YzAmbgMZMWBqIsBRhz/7fnsDxcxT9/fkJK+mjhY=;
 b=n3WPR18U4YciMVu7xN0xOcwM1Hd0rGw7yrL+p9rgpSYVlWXb481nkHz8H6mpDij0wY
 VsO2FXozbtIGamGHj/gidaNnLCiq/VEOgsRIl+Wvi2v1zNAG1lejhQHbPY269StL7Wg3
 LhOGp4ii17m79Sdu6Rrcz9QpWUi8841AfUnSGpNPklQeqxhu9XveO1uUVbNf7FjO5pup
 t98B6hCfGau8vn70GVaOO5chVxeRy4Kyu0rM0T/EfexsOXMSKeIAalGt9G8cqjANJMN1
 F5p++auIboPIpB8qb58TZACHpogJuqBH9C4WkWvb2ksd4sOMqchesQuS/K8ZnT1CNBlV
 s+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745615255; x=1746220055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gn7/YzAmbgMZMWBqIsBRhz/7fnsDxcxT9/fkJK+mjhY=;
 b=t1sMet+lOB39cENwOiaZGKAcMpHNho8Yh6i2Y8tfD1c5Y8CLpP7oJ9s/HUU1Mddaw2
 9ugki1vGtlIeX2WYp6HvRE+r4VEDLUK+jCFrrnNJFBRSQrkXMMiMcnp6nu1DsS08jhdR
 Y3+HT1kXbxP0320sLP1Op8/mE0vS/c9npQ1tptuI2TLA1PRDwWDNLi/nP9kUhVwPoecu
 wA6v6RfI4df35kOh83xU3vQ3WjNIZgGjZQBOF4k3YMkcPyaJ3C2pWbE3H+iksHJsLcQQ
 iwgs5h3E8hnPxBqRfKa184cZc/PUrvyR0xjxe8nKfwqS/3ZG7wdE60dMW2vbeIPJhsCy
 Pr3w==
X-Gm-Message-State: AOJu0Yy+tLMcVlf5b/rcg58PHh+AwKBgBkzLRKwCO3gJ6yOWzIpp4rZx
 X7OAOWQNSsDm3FAQUGIY/7VTNsW/yOilLff1g6TVUuKpciZD9t+uhXpnz2QjevQ=
X-Gm-Gg: ASbGncsLDgnF4dsclbInO3WOBRB2VvN3lXrwsjKsXOfydQRNuJsX9P6EPSAaheuHUjA
 k1rXnaEbhh9fWtr90HtJUyGf+1E4dTNujqC2pixeAl8S1A4a39DIcmaub/2tgaIRDlo6P5z412/
 tfU57VMrdR/OnwdOZIrqjBodfzMx6QkElNiaxtuVc1fyE1h48gNhIKmYiWPOzdpnDwnxTq6LcnZ
 qrkYYusKdMNjtrTv57dMjOMM/hhbrUAti1IX10/ep8Pqf3+Epo9WlgN9f7VY99l6XnRfvTyG6S4
 RUzmBGGpFTkWrCEDH8HIUgJWeE0A+cBfJEGIzHxuZqSHqKcy0eQE7wwHSirQJ5qZ
X-Google-Smtp-Source: AGHT+IETgYhKR+XjWFuE1G8/OA8MOi3ErSUMgEXWLSYse2+pJuNB10ijZqVTbsSUs+t0oLxWbWtkEA==
X-Received: by 2002:a17:902:e143:b0:227:e6fe:2908 with SMTP id
 d9443c01a7336-22dc6a87998mr12765055ad.48.1745615255333; 
 Fri, 25 Apr 2025 14:07:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76f4bsm37315585ad.49.2025.04.25.14.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 14:07:34 -0700 (PDT)
Message-ID: <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
Date: Fri, 25 Apr 2025 14:07:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87a584b69n.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/25/25 08:38, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Note: This RFC was posted to trigger a discussion around this topic, and it's
>> not expected to merge it as it is.
>>
>> Context
>> =======
>>
>> Linaro is working towards heterogeneous emulation, mixing several architectures
>> in a single QEMU process. The first prerequisite is to be able to build such a
>> binary, which we commonly name "single-binary" in our various series.
>> An (incomplete) list of series is available here:
>> https://patchew.org/search?q=project%3AQEMU+single-binary
>>
>> We don't expect to change existing command line interface or any observable
>> behaviour, it should be identical to existing binaries. If anyone notices a
>> difference, it will be a bug.
> 
> Define "notice a difference" :)  More on that below.
> 

Given a single-binary *named* exactly like an existing qemu-system-X 
binary, any user or QEMU management layer should not be able to 
distinguish it from the real qemu-system-X binary.

The new potential things will be:
- introduction of an (optional) -target option, which allows to 
override/disambiguate default target detected.
- potentially more boards/cpus/devices visible, once we start developing 
heterogeneous emulation. See it as a new CONFIG_{new_board} present.

Out of that, once the current target is identified, based on argv[0], 
there should be absolutely no difference, whether in the behaviour, UI, 
command line, or the monitor interfaces.

Maybe (i.e. probably) one day people will be interested to create a new 
shiny command line for heteregenous scenarios, but for now, this is 
*not* the goal we pursue. We just want to be able to manually define a 
board mixing two different cpu architectures, without reinventing all 
the wheels coming with that. Once everything is ready (and not before), 
it will be a good time to revisit the command line interface to reflect 
this. Definitely a small task compared to all we have left to do now.

Finally, even if we decide to do those changes, I think they should be 
reflected on both existing binaries and the new single-binary. It would 
be a mistake to create "yet another" way to use QEMU, just because we 
have N architectures available instead of one.

>> The first objective we target is to combine qemu-system-arm and
>> qemu-system-aarch64 in a single binary, showing that we can build and link such
>> a thing. While being useless from a feature point of view, it allows us to make
>> good progress towards the goal, and unify two "distinct" architectures, and gain
>> experience on problems met.
> 
> Makes sense to me.
> 
>> Our current approach is to remove compilation units duplication to be able to
>> link all object files together. One of the concerned subsystem is QAPI.
>>
>> QAPI
>> ====
>>
>> QAPI generated files contain conditional clauses to define various structures,
>> enums, and commands only for specific targets. This forces files to be
>> compiled for every target.
> 
> To be precise: conditionals that use macros restricted to
> target-specific code, i.e. the ones poisoned by exec/poison.h.  Let's
> call them target-specific QAPI conditionals.
> 
> The QAPI generator is blissfully unaware of all this.
> 

Indeed, the only thing QAPI generaor is aware of is that it's a compile 
time definition, since it implements those with #if, compared to a 
runtime check.

> The build system treats QAPI modules qapi/*-target.json as
> target-specific.  The .c files generated for them are compiled per
> target.  See qapi/meson.build.
> 
> Only such target-specific modules can can use target-specific QAPI
> conditionals.  Use in target-independent modules will generate C that
> won't compile.
> 
> Poisoned macros used in qapi/*-target.json:
> 
>      CONFIG_KVM
>      TARGET_ARM
>      TARGET_I386
>      TARGET_LOONGARCH64
>      TARGET_MIPS
>      TARGET_PPC
>      TARGET_RISCV
>      TARGET_S390X
> 
>>                             What we try to do here is to build them only once
>> instead.
> 
> You're trying to eliminate target-specific QAPI conditionals.  Correct?
>

Yes, but without impacting the list of commands exposed. Thus, it would 
be needed to select at runtime to expose/register commands.

>> In the past, we identied that the best approach to solve this is to expose code
>> for all targets (thus removing all #if clauses), and stub missing
>> symbols for concerned targets.
> 
> This affects QAPI/QMP introspection, i.e. the value of query-qmp-schema.
> 
> Management applications can no longer use introspection to find out
> whether target-specific things are available.
> 

As asked on my previous email answering Daniel, would that be possible 
to build the schema dynamically, so we can decide what to expose or not 
introspection wise?

> For instance, query-cpu-definitions is implemented for targets arm,
> i386, loongarch, mips, ppc, riscv, and s390x.  It initially was for
> fewer targets, and more targets followed one by one.  Still more may
> follow in the future.  Right now, management applications can use
> introspection to find out whether it is available.  That stops working
> when you make it available for all targets, stubbed out for the ones
> that don't (yet) implement it.
> 

I will repeat, just to be clear, I don't think exposing all commands is 
a good idea.
The current series *does not* do this, simply because I didn't want to 
huge work for nothing.

> Management applications may have to be adjusted for this.
> 
> This is not an attempt to shoot down your approach.  I'm merely
> demonstrating limitations of your promise "if anyone notices a
> difference, it will be a bug."
>

I stick to this promise :).

> Now, we could get really fancy and try to keep introspection the same by
> applying conditionals dynamically somehow.  I.e. have the single binary
> return different introspection values depending on the actual guest's
> target.
> 
> This requires fixing the target before introspection.  Unless this is
> somehow completely transparent (wrapper scripts, or awful hacks based on
> the binary's filename, perhaps), management applications may have to be
> adjusted to actually do that.
> 
> Applies not just to introspection.  Consider query-cpu-definitions
> again.  It currently returns CPU definitions for *the* target.  What
> would a single binary's query-cpu-definitions return?  The CPU
> definitions for *all* its targets?  Management applications then receive
> CPUs that won't work, which may upset them.  To avoid noticable
> difference, we again have to fix the target before we look.
> 
> Of course, "fixing the target" stops making sense once we move to
> heterogeneous machines with multiple targets.
> 

At this point, I don't have think about what should be the semantic when 
we'll have multiple targets running simultaneously (expose the union, 
restrict to the main arch, choose a third way).

>> This series build QAPI generated code once, by removing all TARGET_{arch} and
>> CONFIG_KVM clauses. What it does *not* at the moment is:
>> - prevent target specific commands to be visible for all targets
>>    (see TODO comment on patch 2 explaining how to address this)
>> - nothing was done to hide all this from generated documentation
> 
> For better or worse, generated documentation always contains everything.
> 

Fine for me, it makes sense, as the official documentation published, 
which is what people will consume primarily, is for all targets.

> An argument could be made for stripping out documentation for the stuff
> that isn't included in this build.
> 
>>  From what I understood, the only thing that matters is to limit qmp commands
>> visible. Exposing enums, structure, or events is not a problem, since they
>> won't be used/triggered for non concerned targets. Please correct me if this is
>> wrong, and if there are unexpected consequences for libvirt or other consumers.
> 
> I'm not sure what you mean by "to limit qmp commands visible".
> 
> QAPI/QMP introspection has all commands and events, and all types
> reachable from them.  query-qmp-schema returns an array, where each
> array element describes one command, event, or type.  When a command,
> event, or type is conditional in the schema, the element is wrapped in
> the #if generated for the condition.
> 

After reading and answering to your valuable email, I definitely think 
the introspection schema we expose should be adapted, independently of 
how we build QAPI code (i.e. using #ifdef TARGET or not).

Is it something technically hard to achieve?

>>
>> Impact on code size
>> ===================
>>
>> There is a strong focus on keeping QEMU fast and small. Concerning performance,
>> there is no impact, as the only thing that would change is to conditionally
>> check current target to register some commands.
>> Concerning code size, you can find the impact on various qemu-system binaries
>> with optimized and stripped build.
>>
>> upstream:
>> 12588   ./build/qemu-system-s390x
>> 83992   ./build/qemu-system-x86_64
>> 31884   ./build/qemu-system-aarch64
>> upstream + this series:
>> 12644   ./build/qemu-system-s390x (+56kB, +0.004%)
>> 84076   ./build/qemu-system-x86_64 (+84kB, +0.001%)
>> 31944   ./build/qemu-system-aarch64 (+60kB, +0.001%)
>>
>> Feedback
>> ========
>>
>> The goal of this series is to be spark a conversation around following topics:
>>
>> - Would you be open to such an approach? (expose all code, and restrict commands
>>    registered at runtime only for specific targets)
> 
> Yes, if we can find acceptable solutions for the problems that come with
> it.
> 
>> - Are there unexpected consequences for libvirt or other consumers to expose
>>    more definitions than what we have now?
> 
> Maybe.
> 
>> - Would you recommend another approach instead? I experimented with having per
>>    target generated files, but we still need to expose quite a lot in headers, so
>>    my opinion is that it's much more complicated for zero benefit. As well, the
>>    code size impact is more than negligible, so the simpler, the better.
>>
>> Feel free to add anyone I could have missed in CC.
> 
> I'm throwing in devel@lists.libvirt.org.
> 
>> Regards,
>> Pierrick
>>
>> Pierrick Bouvier (3):
>>    qapi: add weak stubs for target specific commands
>>    qapi: always expose TARGET_* or CONFIG_KVM code
>>    qapi: make all generated files common
>>
>>   qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   qapi/meson.build           |  5 ++++-
>>   scripts/qapi/commands.py   |  4 ++++
>>   scripts/qapi/common.py     |  4 +++-
>>   4 files changed, 49 insertions(+), 2 deletions(-)
>>   create mode 100644 qapi/commands-weak-stubs.c
> 

Thanks,
Pierrick

