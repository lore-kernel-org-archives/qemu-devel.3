Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62012C369CB
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Apr 2025 06:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Yus-0007On-HN; Sat, 26 Apr 2025 02:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8Yup-0007OU-PC
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 02:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8Yum-0006MN-HA
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 02:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745648484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRGMCHo1F4BHY8xBK4AEnENUevGHLiH8e5EyZ0Su6fo=;
 b=UfkRMriG/6mT0fog/gHUUGCHhPRff/kJVDnU+pBUUjRnwqZekDKHG38yPGtspzcChb0g5B
 kdxIuCjo2akzPF5uyBFDyK4Ueod25CV3ICCcRVvCI7sOXcnSvdo/8d6MwgWX6slSMASy2I
 6T7FoOQS9B4vecLafTgk94AyNaUZpt8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-r_25qHIeP0yzRx_zZxX9nw-1; Sat,
 26 Apr 2025 02:21:18 -0400
X-MC-Unique: r_25qHIeP0yzRx_zZxX9nw-1
X-Mimecast-MFC-AGG-ID: r_25qHIeP0yzRx_zZxX9nw_1745648476
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D99119560AD; Sat, 26 Apr 2025 06:21:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75E791800D97; Sat, 26 Apr 2025 06:21:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0887521E6768; Sat, 26 Apr 2025 08:21:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 stefanha@redhat.com,  Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com,  berrange@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  devel@lists.libvirt.org,
 Victor Toso <victortoso@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <5b21965d-2428-454c-9dd7-266987495abd@linaro.org> (Pierrick
 Bouvier's message of "Fri, 25 Apr 2025 14:07:34 -0700")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
Date: Sat, 26 Apr 2025 08:21:12 +0200
Message-ID: <87a583789z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 4/25/25 08:38, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>> 
>>> Note: This RFC was posted to trigger a discussion around this topic, and it's
>>> not expected to merge it as it is.
>>>
>>> Context
>>> =======
>>>
>>> Linaro is working towards heterogeneous emulation, mixing several architectures
>>> in a single QEMU process. The first prerequisite is to be able to build such a
>>> binary, which we commonly name "single-binary" in our various series.
>>> An (incomplete) list of series is available here:
>>> https://patchew.org/search?q=project%3AQEMU+single-binary
>>>
>>> We don't expect to change existing command line interface or any observable
>>> behaviour, it should be identical to existing binaries. If anyone notices a
>>> difference, it will be a bug.
>> 
>> Define "notice a difference" :)  More on that below.
>> 
>
> Given a single-binary *named* exactly like an existing qemu-system-X 
> binary, any user or QEMU management layer should not be able to 
> distinguish it from the real qemu-system-X binary.
>
> The new potential things will be:
> - introduction of an (optional) -target option, which allows to 
> override/disambiguate default target detected.
> - potentially more boards/cpus/devices visible, once we start developing 
> heterogeneous emulation. See it as a new CONFIG_{new_board} present.
>
> Out of that, once the current target is identified, based on argv[0], 
> there should be absolutely no difference, whether in the behaviour, UI, 
> command line, or the monitor interfaces.

Letting argv[0] affect behavior is problematic.  See prior discussion:

    Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
    Message-ID: <87bjttzh3b.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87bjttzh3b.fsf@pond.sub.org/

> Maybe (i.e. probably) one day people will be interested to create a new 
> shiny command line for heteregenous scenarios, but for now, this is 
> *not* the goal we pursue. We just want to be able to manually define a 
> board mixing two different cpu architectures, without reinventing all 
> the wheels coming with that. Once everything is ready (and not before), 
> it will be a good time to revisit the command line interface to reflect 
> this. Definitely a small task compared to all we have left to do now.
>
> Finally, even if we decide to do those changes, I think they should be 
> reflected on both existing binaries and the new single-binary. It would 
> be a mistake to create "yet another" way to use QEMU, just because we 
> have N architectures available instead of one.
>
>>> The first objective we target is to combine qemu-system-arm and
>>> qemu-system-aarch64 in a single binary, showing that we can build and link such
>>> a thing. While being useless from a feature point of view, it allows us to make
>>> good progress towards the goal, and unify two "distinct" architectures, and gain
>>> experience on problems met.
>> 
>> Makes sense to me.
>> 
>>> Our current approach is to remove compilation units duplication to be able to
>>> link all object files together. One of the concerned subsystem is QAPI.
>>>
>>> QAPI
>>> ====
>>>
>>> QAPI generated files contain conditional clauses to define various structures,
>>> enums, and commands only for specific targets. This forces files to be
>>> compiled for every target.
>> 
>> To be precise: conditionals that use macros restricted to
>> target-specific code, i.e. the ones poisoned by exec/poison.h.  Let's
>> call them target-specific QAPI conditionals.
>> 
>> The QAPI generator is blissfully unaware of all this.
>> 
>
> Indeed, the only thing QAPI generaor is aware of is that it's a compile 
> time definition, since it implements those with #if, compared to a 
> runtime check.

QAPI conditionals are designed to provide build-time configuration.  In
C, we use #if for that.  QAPI conditionals are merely a slight
abstraction of C #if.  Used to be even slighter until merge commit
c83fcfaf8a5.

Two kinds of #if conditions in QEMU C code:

1. True build-time configuration, i.e. control what's being built based
on what the host can do and what the user wants, as figured out by
configure.  These conditions are the same for the entire build.

2. Specializing target-specific code.  These conditions vary per target.
C code using them needs to be compiled per target.

To get a single binary, we want to reduce use of the second kind as much
as practical.  This can involve replacing compile-time conditionals by
run-time checks.  Remaining target-specific code needs to adjusted so
target-specific code for multiple targets can coexist in the single
binary.

Trouble is some uses of the second kind are in QAPI conditionals.  I can
see three options:

(1) Drop these conditionals.

(2) Replace them by run-time checks.

(3) Have target-specific QAPI-generated code for multiple targets
    coexist in the single binary.

As far as I can tell, your RFC series is an incomplete attempt at (2).

I gather you considered (3), but you dislike it for its bloat and
possibly other reasons.  I sympathize; the QAPI-generated code is plenty
bloated as it is, in good part to early design decisions (not mine).

Your "no noticeable differences" goal precludes (1).

Back to (2).  In C, replacing compile-time conditionals by run-time
checks means replacing #if FOO by if (foo).  Such a transformation isn't
possible in the QAPI schema.  To make it possible, we need to evolve the
QAPI schema language.

docs/devel/qapi-code-gen.rst describes what we have:

        COND = STRING
             | { 'all: [ COND, ... ] }
             | { 'any: [ COND, ... ] }
             | { 'not': COND }

    [....]

    The C code generated for the definition will then be guarded by an #if
    preprocessing directive with an operand generated from that condition:

     * STRING will generate defined(STRING)
     * { 'all': [COND, ...] } will generate (COND && ...)
     * { 'any': [COND, ...] } will generate (COND || ...)
     * { 'not': COND } will generate !COND

So, conditions are expression trees where the leaves are preprocessor
symbols and the inner nodes are operators.

It's not quite obvious to me how to best evolve this to support run-time
checks.

Whatever we choose should support generating Rust and Go as well.  Why?
Rust usage in QEMU is growing, and we'll likely need to generate some
Rust from the QAPI schema.  Victor Toso has been working on Go bindings
for use in Go QMP client software.

>> The build system treats QAPI modules qapi/*-target.json as
>> target-specific.  The .c files generated for them are compiled per
>> target.  See qapi/meson.build.
>> 
>> Only such target-specific modules can can use target-specific QAPI
>> conditionals.  Use in target-independent modules will generate C that
>> won't compile.
>> 
>> Poisoned macros used in qapi/*-target.json:
>> 
>>      CONFIG_KVM
>>      TARGET_ARM
>>      TARGET_I386
>>      TARGET_LOONGARCH64
>>      TARGET_MIPS
>>      TARGET_PPC
>>      TARGET_RISCV
>>      TARGET_S390X
>> 
>>>                             What we try to do here is to build them only once
>>> instead.
>> 
>> You're trying to eliminate target-specific QAPI conditionals.  Correct?
>>
>
> Yes, but without impacting the list of commands exposed. Thus, it would 
> be needed to select at runtime to expose/register commands.

Conditionals affect more than just commands.

>>> In the past, we identied that the best approach to solve this is to expose code
>>> for all targets (thus removing all #if clauses), and stub missing
>>> symbols for concerned targets.
>> 
>> This affects QAPI/QMP introspection, i.e. the value of query-qmp-schema.
>> 
>> Management applications can no longer use introspection to find out
>> whether target-specific things are available.
>> 
>
> As asked on my previous email answering Daniel, would that be possible 
> to build the schema dynamically, so we can decide what to expose or not 
> introspection wise?

QAPI was designed to be compile-time static.  Revising such fundamental
design assumptions is always fraught.  I can't give you a confident
assessment now.  All I can offer you is my willingness to explore
solutions.  See "really fancy" below.

Fun fact: we used to generate the value of query-qmp-schema as a single
string.  We switched to the current, more bloated representation to
support conditionals (commit 7d0f982bfbb).

>> For instance, query-cpu-definitions is implemented for targets arm,
>> i386, loongarch, mips, ppc, riscv, and s390x.  It initially was for
>> fewer targets, and more targets followed one by one.  Still more may
>> follow in the future.  Right now, management applications can use
>> introspection to find out whether it is available.  That stops working
>> when you make it available for all targets, stubbed out for the ones
>> that don't (yet) implement it.
>> 
>
> I will repeat, just to be clear, I don't think exposing all commands is 
> a good idea.
> The current series *does not* do this, simply because I didn't want to 
> huge work for nothing.

Got it.

>> Management applications may have to be adjusted for this.
>> 
>> This is not an attempt to shoot down your approach.  I'm merely
>> demonstrating limitations of your promise "if anyone notices a
>> difference, it will be a bug."
>>
>
> I stick to this promise :).
>
>> Now, we could get really fancy and try to keep introspection the same by
>> applying conditionals dynamically somehow.  I.e. have the single binary
>> return different introspection values depending on the actual guest's
>> target.
>> 
>> This requires fixing the target before introspection.  Unless this is
>> somehow completely transparent (wrapper scripts, or awful hacks based on
>> the binary's filename, perhaps), management applications may have to be
>> adjusted to actually do that.
>> 
>> Applies not just to introspection.  Consider query-cpu-definitions
>> again.  It currently returns CPU definitions for *the* target.  What
>> would a single binary's query-cpu-definitions return?  The CPU
>> definitions for *all* its targets?  Management applications then receive
>> CPUs that won't work, which may upset them.  To avoid noticable
>> difference, we again have to fix the target before we look.
>> 
>> Of course, "fixing the target" stops making sense once we move to
>> heterogeneous machines with multiple targets.
>> 
>
> At this point, I don't have think about what should be the semantic when 
> we'll have multiple targets running simultaneously (expose the union, 
> restrict to the main arch, choose a third way).

We have to unless we make query-cpu-definitions fail or impossible to
send while the target is still undecided.

Making it fail would violate the "no observable differences" goal.

The only path to true "no observable differences" I can see is to fix
the target before the management application interacts with QEMU in any
way.  This would make QMP commands (query-cpu-definitions,
query-qmp-schema, ...) impossible to send before the target is fixed.

>>> This series build QAPI generated code once, by removing all TARGET_{arch} and
>>> CONFIG_KVM clauses. What it does *not* at the moment is:
>>> - prevent target specific commands to be visible for all targets
>>>    (see TODO comment on patch 2 explaining how to address this)
>>> - nothing was done to hide all this from generated documentation
>> 
>> For better or worse, generated documentation always contains everything.
>> 
>
> Fine for me, it makes sense, as the official documentation published, 
> which is what people will consume primarily, is for all targets.
>
>> An argument could be made for stripping out documentation for the stuff
>> that isn't included in this build.
>> 
>>>  From what I understood, the only thing that matters is to limit qmp commands
>>> visible. Exposing enums, structure, or events is not a problem, since they
>>> won't be used/triggered for non concerned targets. Please correct me if this is
>>> wrong, and if there are unexpected consequences for libvirt or other consumers.
>> 
>> I'm not sure what you mean by "to limit qmp commands visible".
>> 
>> QAPI/QMP introspection has all commands and events, and all types
>> reachable from them.  query-qmp-schema returns an array, where each
>> array element describes one command, event, or type.  When a command,
>> event, or type is conditional in the schema, the element is wrapped in
>> the #if generated for the condition.
>> 
>
> After reading and answering to your valuable email, I definitely think 

Thanks!

> the introspection schema we expose should be adapted, independently of 
> how we build QAPI code (i.e. using #ifdef TARGET or not).
>
> Is it something technically hard to achieve?

Unclear.  See "fundamental design assumptions" and "need to evolve the
QAPI schema language" above.

If you want to learn more about introspection, I'd recommend
docs/devel/qapi-code-gen.rst section "Client JSON Protocol
introspection".

[...]


