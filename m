Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D22C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrs6O-0002Uf-Jp; Thu, 06 Aug 2026 03:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrs6K-0002U3-N4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wrs6G-0005cr-IT
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785999666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjunRInz4ZwfHX1wypxRUbGkunht0qzTeN75YSzyuuE=;
 b=QaXbDI/ZznEwKT6XUas922fLwZdS9cEmG8LuaDP3zUk2/PsvTtmbQ6nMiFuzaBN+5MNDfs
 WA+HxoF2RHwJMMk1+XFX9wUrqG17Lt5rFxEt9a9fwFxQNgTUJ4kZwP+MoRx4f7mELyi0i0
 B/OBlDNAa1NwFxOi/YvHUM7UYBpgbPs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-I_qZ79fSM_m8fzmulbI4ww-1; Thu,
 06 Aug 2026 03:00:55 -0400
X-MC-Unique: I_qZ79fSM_m8fzmulbI4ww-1
X-Mimecast-MFC-AGG-ID: I_qZ79fSM_m8fzmulbI4ww_1785999654
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 059311800115
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2026 07:00:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB6F422
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2026 07:00:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA64821E6920; Thu, 06 Aug 2026 09:00:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
In-Reply-To: <69be7bb2-cc30-4788-8bb5-6a6c51a65bb9@redhat.com> (Paolo
 Bonzini's message of "Mon, 3 Aug 2026 07:14:45 +0200")
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com>
 <87a4rf61e9.fsf@pond.sub.org>
 <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
 <87qzkozskq.fsf@pond.sub.org>
 <69be7bb2-cc30-4788-8bb5-6a6c51a65bb9@redhat.com>
Date: Thu, 06 Aug 2026 09:00:50 +0200
Message-ID: <87ldajwx5p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 7/27/26 11:32, Markus Armbruster wrote:
>> I count 168 enum types including tests, 12 have conditional members, and
>> none of them have a first member that is conditional.  So this is merely
>> a latent issue.  Doesn't mean we shouldn't get rid of it, of course.
>
> Yes, it's latent.  Rust issues (see below) obviously are latent too.
>
>>>> However, I'm not sure your solution fixes this problem completely.
>>>>
>>>> Code providing an explicit default then is still fine:
>>>>
>>>>      if (!arg.has_opt) {
>>>>          arg.opt = ENUM_TYPE_MUMBLE;
>>>>      }
>>>>
>>>> But we often use arg.opt without checking arg.has_opt for brevity.  This
>>>> is an implicit default to zero, whatever zero may mean.  If the optional
>>>> enum's first member is conditional, this default depends on build
>>>> configuration.
>>>>
>>>> Stupidest solution that could possibly work: an enum's first member
>>>> cannot be conditional.
>>>
>>> That would prevent an enum that is entirely compiled out, which seems like
>>> a plausibly desirable feature.
>>>
>>> Honestly I think this is a C problem, not a QAPI problem. Skipping has_xx
>>> for bools that default to false is already borderline; doing it for enums
>>> is well into "you shouldn't do it" territory.
>>
>> Let's review how we represent optional members in C.
>>
>> * Values of absent members are zero-initialized.
[...]
>> * Anything that doesn't map to pointers: we need has_member.
>>
>>   When the default is zero, which is fairly common, there's again no
>>   need to explicitly supply it.  We just use obj.member, without
>>   cluttering the code with .has_member conditionals.
>>
>> In my opinion, this (non-)usage of .has_member is just *fine* as long as
>> the meaning of zero is well-defined at the QAPI level. [...]
>>
>> It's well-defined for enums as long as the enum's first member is
>> unconditional.  The meaning of zero is admittedly less obvious there.
>>
>> We could certainly change the existing code to only read obj.member
>> where guarded by if (obj.has_member).  Inhowfar we'd then succeed at
>> keeping the shorter (and in my opinion more readable) forms from
>> creeping back is less certain.
>
> I'm certain they would creep back, and I guess it's also fine if the
> enum has a 'default' or 'none' value.  But the language doesn't make a
> difference, because the programmer just uses "0" even if the first
> member is conditional.
>
> Instead, the Rust backend won't let you write Default::default() if
> the first item is conditional; it's a compile-time failure.  In that
> sense the C language has a deficiency.
>
>> But what's the benefit?  Enabling "a plausibly desirable feature" we
>> haven't found a use for is one, but I don't think it can justify the
>> change.
>
> The plausibly desirable feature if enums with conditional items
> only. The alternative is to forbid enums that can disappear
> completely.
>
> How desirable is it?  Here are the two that come closest:
>
> { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>
> { 'enum': 'BlockExportType',
>    'data': [ 'nbd',
>              { 'name': 'vhost-user-blk',
>                'if': 'CONFIG_VHOST_USER_BLK_SERVER' },
>              { 'name': 'fuse', 'if': 'CONFIG_FUSE' },
>              { 'name': 'vduse-blk', 'if': 'CONFIG_VDUSE_BLK_EXPORT' } ] }
>
> Other cases have a 'none' or even a 'default' member
> (DisplayType).

Yes.

Aside: I prefer "absent defaults to an actual value" over "absent means
something else than any value", because I find it simpler.

>                Qcow2CompressionType could grow one in case zlib option
> becomes mandatory.

Do you mean "becomes optional?"

Note that @zlib can't become optional without a compatibility break,
because @compression-type defaults to it in BlockdevCreateOptionsQcow2.

Moreover, Qcow2CompressionType needs members, because @compression-type
is mandatory in ImageInfoSpecificQCow2.

The hard requirement is "need members at build time", i.e. the build
configuration must not compile out all members.  Without that,
query-named-block-nodes cannot be made to work for QCOW2 images: it must
have a value to store in the mandatory @compression-type.  Storing 0
would be cheating, and also a dangerous violation of invariant "enum
variable must contain bits that represent an actual enum value".

We may want the stricter "need members in any build configuration",
i.e. not all members may be conditional.  And once we use that, we can
just as well require the first member to be unconditional.

> BlockExportType is the most potentially problematic, because it does
> not make sense to have 'none' there.

BlockExportType also needs members, because BlockExportOptions and
BlockExportInfo have a mandatory member @type of BlockExportType.

So, these two don't actually come close.  Doesn't mean we'll never
invent something else that does.

>                                       It would still not be usable -
> for example the C visit_type_BlockExportOptions_members() would
> collapse to
>
>     if (!visit_type_q_obj_BlockExportOptions_base_members(...) {
>         return false;
>     }
>     switch (obj->type) {
>     default:
>         abort();
>     }
>
> i.e. basically "return false" because neither
> visit_type_BlockExportType nor
> visit_type_q_obj_BlockExportOptions_base_members can succeed.
>
> However, QAPI schema generation would work, meaning that you _could_
> write the QMP commands generically, even if in practice they're dead
> code.  Bug or feature?

Or excursion into the weeds?

Joking aside, I wouldn't call it a feature, because "feature" implies
"good for something".  "Bug" implies "has some undesirable effect".  If
we volunteer for the mission "don't let the programmer specify useless
interfaces", then this is a bug.  If we go "you're asking for rope, have
some" instead, it's not.

Two common excuses for letting the programmer do stupid things:

1. Preventing stupid things would also prevent them from doing clever
   things.

2. It just isn't worth the bother.

   Preventing something people do and then regret is worth a lot more
   bother than preventing something they have not done in years.

>>> Rust would spell it "Default::default()"; the language can help rejecting
>>> it if you have mandatory string fields (it would recursively default boxed
>>> structs, unlike C) but it cannot do anything about portability; this patch
>>> closes the gap completely for Rust, and does what it can for C.
>>
>> I wouldn't call it a portability problem.  The actual problem is that
>> build-time configuration can have unwanted effects at least in theory.
>> Since different host platforms can require different configuration,
>> porting can trigger the problem.
>
> Yeah, portability in a wider sense---such as different behavior of
> clients when talking to different QEMU binaries.

Exactly.

>> You propose to
>>
>> * Forbid empty enums [PATCH 2].  They are allowed simply because I never
>>   found a compelling reason to forbid them.  Yes, they're useless, but
>>   users can figure that out without the QAPI generator insisting.
>>
>>   Does forbidding them help Rust?
>
> Somewhat; I cannot generate Default::default() for them.  It would be
> easy enough to skip generation of that method, but you'd still get a
> Rust compilation error if you put them in a struct.
>
> IMO this is telling us that empty enums should indeed fail to compile
> even earlier, in the QAPI schema generator.
>
> Empty enum types cannot be created, and neither can any structs or
> commands they contain.  There's simply no way to have code that refers
> to them, unless they're wrapped in something else that lets the code
> pretend they can exist: for example you can make a field optional and
> write "None" for it.
>
> With conditionally empty enums, this at least makes sense as a concept; on the other hand I just don't see the point in unconditionally empty enums, even if they're optional, so I left them out.

If forbidding empty enums makes Rust generation simpler or easier,
that's a compelling reason, isn't it?

You should mention the Rust reason(s) in the commit message then.

>>   You still allow enums whose members are all conditional.  Build
>>   configuration could make these empty, but there are conceivable uses.
>
> I allow them because patch 1 forces them to be optional and then, even
> if *the enum* has no default, "None" is a sensible default for *the
> field*.  In Rust, unlike C, I cannot just access the value of the enum
> if it's "None"; on top of that, optional_field.unwrap_or_default()
> fails to compile because the enum has no default.
>
>> * Require members of enum type to be optional when the enum's first
>>   member is conditional [PATCH 1].
>>
>>   Does this help Rust?
>
> Yes, it lets me cop out of writing a Default::default() implementation
> for them, while letting them have a sensible default ("None", just
> like in C) if embedded in a struct.
>
> Again, the language is IMO telling us that enums with a conditional
> first member are in general a bad idea, and the solution is to catch
> them earlier, in the QAPI schema generator.

I might have banned conditional first members from the start if I had
thought out things back then.

> I didn't ban them outright because IMO the fact that in C you can
> shoot yourself in the foot, and assume a meaning of "zero" for such an
> enum, *is* a language problem.  In particular it is a language problem
> that it is not able to express the relationship between has_foo and
> foo.
>
> But I can be convinced to do it, if you think we need not care about
> cases like BlockExportType.

To me, requiring unconditional first member feels simpler.

Perhaps I'm wrong.  I've been wrong before.  If you'd like to settle the
matter instead of relying on my gut feelings, try documenting both
solutions in docs/devel/qapi-code-gen.rst.

Perhaps we find uses for optional enums with only conditional members
later.  Doesn't feel too likely.  But if we do, we can complicate
matters then rather than now.

Even with more reasons than just helping Rust, you should still mention
the Rust reason(s) in the commit message.

> Paolo
>
>> I believe these rules are mildly bothersome to explain.  Which you
>> sidestepped by not documenting them in docs/devel/qapi-code-gen.rst :)
>>
>> To actually prevent it reliably, we'd have to attack the root of the
>> problem, namely the meaning of enum types' zero value.  The obvious way
>> to do that is to require enums to have an unconditional first member.
>> This is also simpler to document, I think.
>>
>> Drawback: it removes the ability to define an enum whose members are all
>> conditional, usable with optional object members.  Does this matter
>> enough to complicate things?


