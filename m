Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50CEC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fd2-0005xp-At; Tue, 29 Apr 2025 03:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9fcv-0005wA-RE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9fct-0008Ei-Ic
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745912613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0Orxb14iJSwkNSi164Bf3tZZOHuW8KEfaRDrDLp3tY=;
 b=JYNTJSQeEE1felbdVPoSpB15rqDAJ/cInX+IPVQ6AYapbHL3vtNvPH7K37qNCjxAtp0bgR
 2HcUaG6mNszR4+qx5WD0X6SQGS0k1UApQJTjoIgILD3zRVUp28xQssFFErJdVyAV8uXR6r
 2g5stncA1Gr/zAHgXyfqSVdr1icTLiM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-gP_KBMkZMqGzW3Mkk01rOg-1; Tue,
 29 Apr 2025 03:43:29 -0400
X-MC-Unique: gP_KBMkZMqGzW3Mkk01rOg-1
X-Mimecast-MFC-AGG-ID: gP_KBMkZMqGzW3Mkk01rOg_1745912608
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E5B18001D5; Tue, 29 Apr 2025 07:43:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B43E1956094; Tue, 29 Apr 2025 07:43:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D30AF21E6768; Tue, 29 Apr 2025 09:43:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 stefanha@redhat.com,  Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com,  berrange@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  devel@lists.libvirt.org,  Victor Toso
 <victortoso@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org> (Pierrick
 Bouvier's message of "Mon, 28 Apr 2025 09:05:19 -0700")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
Date: Tue, 29 Apr 2025 09:43:24 +0200
Message-ID: <8734drpg4j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

> On 4/25/25 11:21 PM, Markus Armbruster wrote:
>> Trouble is some uses of the second kind are in QAPI conditionals.  I can
>> see three options:
>> 
>> (1) Drop these conditionals.
>> 
>> (2) Replace them by run-time checks.
>> 
>> (3) Have target-specific QAPI-generated code for multiple targets
>>      coexist in the single binary.
>> 
>> As far as I can tell, your RFC series is an incomplete attempt at (2).
>> 
>> I gather you considered (3), but you dislike it for its bloat and
>> possibly other reasons.  I sympathize; the QAPI-generated code is plenty
>> bloated as it is, in good part to early design decisions (not mine).
>> 
>> Your "no noticeable differences" goal precludes (1).
>> 
>> Back to (2).  In C, replacing compile-time conditionals by run-time
>> checks means replacing #if FOO by if (foo).  Such a transformation isn't
>> possible in the QAPI schema.  To make it possible, we need to evolve the
>> QAPI schema language.
>> 
>> docs/devel/qapi-code-gen.rst describes what we have:
>> 
>>          COND = STRING
>>               | { 'all: [ COND, ... ] }
>>               | { 'any: [ COND, ... ] }
>>               | { 'not': COND }
>> 
>>      [....]
>> 
>>      The C code generated for the definition will then be guarded by an #if
>>      preprocessing directive with an operand generated from that condition:
>> 
>>       * STRING will generate defined(STRING)
>>       * { 'all': [COND, ...] } will generate (COND && ...)
>>       * { 'any': [COND, ...] } will generate (COND || ...)
>>       * { 'not': COND } will generate !COND
>> 
>> So, conditions are expression trees where the leaves are preprocessor
>> symbols and the inner nodes are operators.
>> 
>> It's not quite obvious to me how to best evolve this to support run-time
>> checks.
>> 
>
> After looking at the introspection code, I don't see any major blocker.
> We need to keep some of existing "if", as they are based on config-host, 
> and should apply.
> We can introduce a new "available_if" (or any other name), which 
> generates a runtime check when building the schema, or when serializing 
> a struct.
>
> This way, by modifying the .json with:
> - if: 'TARGET_I386'
> + available_if: 'target_i386()'
>
> This way, we keep the possibility to have ifdef, and we can expose at 
> runtime based on available_if. So we can keep the exact same schema we 
> have today per target.

The name is ugly.  Naming is hard.  No need to worry about it right now.

Semantics of having both 'if' and 'available_if'?  To work out an
answer, let's consider how to convert conditionals:

* 'if': STRING

  If STRING is a target-specific macro, replace by 'available_if': PRED,
  where PRED is the equivalent run-time predicate.

  Else, no change.

* 'if': { 'all': [COND, ...] }

  If COND contains only target-specific macros, replace by
  'available_if': { 'all': [PRED, ...] }, where the PRED are the
  equivalent run-time predicates.

  If COND contains no target-specific macros, no change.

  What if it contains both?

  - If each COND contains either only target-specific macros, or no
    target-specific macros, we could split the target-specific ones off
    into an additional 'available_if'.  This requires defining the
    semantics of having both 'if' and 'available_if' as "both conditions
    must be satisfied".

  - What if this isn't the case?

* 'if' { 'any': [COND, ...] }

  Similar, but to be able to split the COND we need "either condition
  must be satisfied".

Even if we can make this work somehow, it would likely be a royal mess
to explain in qapi-code-gen.rst.

We currently don't have "mixed" conditionals.  So we could sidestep the
problem: you can have either 'if' or 'available_if', but not both.
Feels like a cop out to me.

What if we move the "is dynamic" bit from the root of the conditional to
its leaves?  So far, the leaves are macro names.  What if we
additionally permit a function name?

Function name, not C expression, to not complicate generating code in
languages other than C too much.

Ignore the question of syntax for now, i.e. how to decide whether a leaf
is a macro or a function name.

>> Whatever we choose should support generating Rust and Go as well.  Why?
>> Rust usage in QEMU is growing, and we'll likely need to generate some
>> Rust from the QAPI schema.  Victor Toso has been working on Go bindings
>> for use in Go QMP client software.
>> 
>
> I don't see any blocker with that. If you mention generating Rust and Go 
> from qapi json definitions, it's already dependent on C preprocessor 
> because of ifdef constant. So it will have to be adapted anyway.
> Having the same function (target_i386()) name through different 
> languages is not something hard to achieve.

I can't see concrete blockers at this time.  I just wanted to make you
aware of the emerging need to support other languages.

[...]

>> QAPI was designed to be compile-time static.  Revising such fundamental
>> design assumptions is always fraught.  I can't give you a confident
>> assessment now.  All I can offer you is my willingness to explore
>> solutions.  See "really fancy" below.
>> 
>> Fun fact: we used to generate the value of query-qmp-schema as a single
>> string.  We switched to the current, more bloated representation to
>> support conditionals (commit 7d0f982bfbb).
>>
>
> It's nice to have this, and this is what would allow us to 
> conditionnally include or not various definitions/commands/fields. I was 
> a bit worried we would have a "static string", but was glad to find a 
> static list instead.

I'm mildly unhappy about the bloat, but not enough to fix it.

[...]

>> The only path to true "no observable differences" I can see is to fix
>> the target before the management application interacts with QEMU in any
>> way.  This would make QMP commands (query-cpu-definitions,
>> query-qmp-schema, ...) impossible to send before the target is fixed.
>>
>
> The current target will be set at the entry of main() in QEMU, so before 
> the monitor is created. Thus, it will be unambiguous.

I reiterate my dislike for having behavior depend on argv[0].  We'll
figure out something.

[...]


