Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB5C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHh6-000235-4l; Mon, 27 Jul 2026 05:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1woHh5-00021x-0n
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1woHgz-0002pt-77
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785144731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nvZFmqdfaAfRvEPJ0+wobsngTNrQRr62BSGUFfJx/1k=;
 b=U57BbpTgQ+/SxtMsaNIy+Gdb5C/+c1pVIsKZqn//k3h49n+EnTWzKaS3MpLONy+65212jz
 3tTtCsH9aYd2+YuT90u6JiKXZdKcMysYSloVgy2DhUmFKByzXBwNUR9es5KpD8JFqCTCWc
 KoTAaPmLDeCQ+gYwCGbgYYybuC2+8Sc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-D2dI5w0OPlmaZiTvWCRe2w-1; Mon,
 27 Jul 2026 05:32:09 -0400
X-MC-Unique: D2dI5w0OPlmaZiTvWCRe2w-1
X-Mimecast-MFC-AGG-ID: D2dI5w0OPlmaZiTvWCRe2w_1785144729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BACEA19560A2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:32:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AD57180029F
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:32:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A721921E6920; Mon, 27 Jul 2026 11:32:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
In-Reply-To: <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
 (Paolo Bonzini's message of "Sat, 25 Jul 2026 14:20:16 +0200")
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com>
 <87a4rf61e9.fsf@pond.sub.org>
 <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
Date: Mon, 27 Jul 2026 11:32:05 +0200
Message-ID: <87qzkozskq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il sab 25 lug 2026, 08:15 Markus Armbruster <armbru@redhat.com> ha scritto:
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > Prevent an all-zero struct from having different meanings with
>> > different configurations or builds of QEMU.
>>
>> This is a bit terse.  What *exactly* is broken?  Spelling this out
>> matters, because it can expose holes in the argument, if any.
>
>
> Nothing is broken; it's just something that can have unexpected
> consequences...
>
>> The numeric encoding of enum values is irrelevant except for zero,
>> because we actually use numeric zero via zero initialization.  If the
>> enum's first value is conditional, the meaning of zero depends on build
>> configuration.  We don't want such a default at the external interface.
>> It could conceivably lead to purely internal bugs, too.
>>
>
> ... like these.

I count 168 enum types including tests, 12 have conditional members, and
none of them have a first member that is conditional.  So this is merely
a latent issue.  Doesn't mean we shouldn't get rid of it, of course.

>> However, I'm not sure your solution fixes this problem completely.
>>
>> Consider type Arg with a mandatory member @mand and an optional enum
>> member @opt, both of enum type ENUM_TYPE.
>>
>> QMP input gets converted to native C like this:
>>
>>     if (!visit_type_Arg(v, NULL, &arg, errp)) {
>>         return;
>>     }
>>
>> If @opt is absent, then arg.has_opt and arg.opt are both zero.
>>
>> Code providing an explicit default then is still fine:
>>
>>     if (!arg.has_opt) {
>>         arg.opt = ENUM_TYPE_MUMBLE;
>>     }
>>
>> But we often use arg.opt without checking arg.has_opt for brevity.  This
>> is an implicit default to zero, whatever zero may mean.
>>
>> If the the optional enum's first member is conditional, this default
>> depends on build configuration.
>>
>> Stupidest solution that could possibly work: an enum's first member
>> cannot be conditional.
>>
>
> That would prevent an enum that is entirely compiled out, which seems like
> a plausibly desirable feature.
>
> Honestly I think this is a C problem, not a QAPI problem. Skipping has_xx
> for bools that default to false is already borderline; doing it for enums
> is well into "you shouldn't do it" territory.

Let's review how we represent optional members in C.

* Values of absent members are zero-initialized.

* There may be a bool has_member that is false when the member is
  absent, true when present.

* We commonly supply default values like this:

      member = obj.has_member ? obj.member : default_value;

  We then use member without checking .has_member again.

* Anything that maps to pointers: since null is not a valid value, we
  use it to represent "absent".  There is no obj.has_member then; we use
  !!obj.member instead.

* Except for arrays, which we represent as singly linked list[*], where
  null means empty: we need has_member.

  Absent array usually defaults to empty.  There's no need to make this
  explicit like

      member = obj.has_member ? obj.member : NULL;

  because obj.member is already null.  So we don't for brevity's sake,
  we just use obj.member.

  Since obj.member has the correct default value, there is no need to
  check .has_member, so we don't.

  In particular, we use code like

      for (elt = obj.member; elt; elt = elt->next) ...

   instead of guarding it with if (obj.has_member) ...

* Anything that doesn't map to pointers: we need has_member.

  When the default is zero, which is fairly common, there's again no
  need to explicitly supply it.  We just use obj.member, without
  cluttering the code with .has_member conditionals.

In my opinion, this (non-)usage of .has_member is just *fine* as long as
the meaning of zero is well-defined at the QAPI level.

For bool and and numbers, the meaning isn't just well-defined, it's also
completely obvious.

It's well-defined for enums as long as the enum's first member is
unconditional.  The meaning of zero is admittedly less obvious there.

We could certainly change the existing code to only read obj.member
where guarded by if (obj.has_member).  Inhowfar we'd then succeed at
keeping the shorter (and in my opinion more readable) forms from
creeping back is less certain.  But what's the benefit?  Enabling "a
plausibly desirable feature" we haven't found a use for is one, but I
don't think it can justify the change.  Are there other benefits I don't
see?  For Rust, maybe?

>                                               Whereas "unless you have
> mandatory pointer fields, g_malloc0(...) returns a valid *and portable*
> QAPI struct" is in my opinion supporting a desirable idiom.

We do rely on zero-initialization to do the right thing.

> Rust would spell it "Default::default()"; the language can help rejecting
> it if you have mandatory string fields (it would recursively default boxed
> structs, unlike C) but it cannot do anything about portability; this patch
> closes the gap completely for Rust, and does what it can for C.

I wouldn't call it a portability problem.  The actual problem is that
build-time configuration can have unwanted effects at least in theory.
Since different host platforms can require different configuration,
porting can trigger the problem.  I.e. it's a special case.  But I'm
getting close to splitting hairs, and should stop :)

I'm of course willing to evolve the schema language to help Rust, or to
eliminate ways for us to screw up.

You propose to

* Forbid empty enums [PATCH 2].  They are allowed simply because I never
  found a compelling reason to forbid them.  Yes, they're useless, but
  users can figure that out without the QAPI generator insisting.

  Does forbidding them help Rust?

  You still allow enums whose members are all conditional.  Build
  configuration could make these empty, but there are conceivable uses.

* Require members of enum type to be optional when the enum's first
  member is conditional [PATCH 1].

  Does this help Rust?

I believe these rules are mildly bothersome to explain.  Which you
sidestepped by not documenting them in docs/devel/qapi-code-gen.rst :)

PATCH 1's commit message claims it prevents "an all-zero struct from
having different meanings with different configurations or builds of
QEMU".  This is misleading without further qualifications: it doesn't
actually prevent it *with the existing coding conventions*.  The commit
message would be easy enough to fix, of course.

To actually prevent it reliably, we'd have to attack the root of the
problem, namely the meaning of enum types' zero value.  The obvious way
to do that is to require enums to have an unconditional first member.
This is also simpler to document, I think.

Drawback: it removes the ability to define an enum whose members are all
conditional, usable with optional object members.  Does this matter
enough to complicate things?

> Paolo
>
>> Thoughts?
>>
>> > This needs some changes to doc-good.json, which used unwittingly
>> > such an enum.
>> >
>> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

[...]

[*] A questionable choice, but here we are.


