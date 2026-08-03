Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBFBC5516F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 05:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wql10-00014Z-7k; Mon, 03 Aug 2026 01:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wql0u-000142-8F
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 01:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wql0q-0001t5-IJ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 01:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785734094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yPRW5VxT8Q4Mo22GJAAwhAdjOLJ68T1jeK2iNXk8mGw=;
 b=ePbp4L98grtZcYWOCaUz6vNRmBi+AlfLjnuT4jMXGe6GnXvA5I8OSr0S1FroS1yqm/R6Sh
 myyhtn3CUrBCYna2DbZXfy2thBaWsmfKUZHpYIAJmeEH0YZISWIpjtRVBfii237tHVFT8C
 ifaxoFj/b4pXUr62IX4c+Os1UPKv5QM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-OklGnmieMfqmGvyM0aZzog-1; Mon,
 03 Aug 2026 01:14:53 -0400
X-MC-Unique: OklGnmieMfqmGvyM0aZzog-1
X-Mimecast-MFC-AGG-ID: OklGnmieMfqmGvyM0aZzog_1785734092
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21AC0180048E
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2026 05:14:52 +0000 (UTC)
Received: from [10.44.32.52] (unknown [10.44.32.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0714A1956086; Mon,  3 Aug 2026 05:14:49 +0000 (UTC)
Message-ID: <69be7bb2-cc30-4788-8bb5-6a6c51a65bb9@redhat.com>
Date: Mon, 3 Aug 2026 07:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com> <87a4rf61e9.fsf@pond.sub.org>
 <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
 <87qzkozskq.fsf@pond.sub.org>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87qzkozskq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 7/27/26 11:32, Markus Armbruster wrote:
> I count 168 enum types including tests, 12 have conditional members, and
> none of them have a first member that is conditional.  So this is merely
> a latent issue.  Doesn't mean we shouldn't get rid of it, of course.

Yes, it's latent.  Rust issues (see below) obviously are latent too.

>>> However, I'm not sure your solution fixes this problem completely.
>>>
>>> Code providing an explicit default then is still fine:
>>>
>>>      if (!arg.has_opt) {
>>>          arg.opt = ENUM_TYPE_MUMBLE;
>>>      }
>>>
>>> But we often use arg.opt without checking arg.has_opt for brevity.  This
>>> is an implicit default to zero, whatever zero may mean.  If the optional
>>> enum's first member is conditional, this default depends on build
>>> configuration.
>>>
>>> Stupidest solution that could possibly work: an enum's first member
>>> cannot be conditional.
>>
>> That would prevent an enum that is entirely compiled out, which seems like
>> a plausibly desirable feature.
>>
>> Honestly I think this is a C problem, not a QAPI problem. Skipping has_xx
>> for bools that default to false is already borderline; doing it for enums
>> is well into "you shouldn't do it" territory.
> 
> Let's review how we represent optional members in C.
> 
> * Values of absent members are zero-initialized.
> 
> * Anything that doesn't map to pointers: we need has_member.
> 
>    When the default is zero, which is fairly common, there's again no
>    need to explicitly supply it.  We just use obj.member, without
>    cluttering the code with .has_member conditionals.
> 
> In my opinion, this (non-)usage of .has_member is just *fine* as long as
> the meaning of zero is well-defined at the QAPI level. [...]
> It's well-defined for enums as long as the enum's first member is
> unconditional.  The meaning of zero is admittedly less obvious there.
> We could certainly change the existing code to only read obj.member
> where guarded by if (obj.has_member).  Inhowfar we'd then succeed at
> keeping the shorter (and in my opinion more readable) forms from
> creeping back is less certain.

I'm certain they would creep back, and I guess it's also fine if the 
enum has a 'default' or 'none' value.  But the language doesn't make a 
difference, because the programmer just uses "0" even if the first 
member is conditional.

Instead, the Rust backend won't let you write Default::default() if the 
first item is conditional; it's a compile-time failure.  In that sense 
the C language has a deficiency.

> But what's the benefit?  Enabling "a plausibly desirable feature" we
> haven't found a use for is one, but I don't think it can justify the
> change.

The plausibly desirable feature if enums with conditional items only. 
The alternative is to forbid enums that can disappear completely.

How desirable is it?  Here are the two that come closest:

{ 'enum': 'Qcow2CompressionType',
    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }

{ 'enum': 'BlockExportType',
    'data': [ 'nbd',
              { 'name': 'vhost-user-blk',
                'if': 'CONFIG_VHOST_USER_BLK_SERVER' },
              { 'name': 'fuse', 'if': 'CONFIG_FUSE' },
              { 'name': 'vduse-blk', 'if': 'CONFIG_VDUSE_BLK_EXPORT' } ] }

Other cases have a 'none' or even a 'default' member (DisplayType). 
Qcow2CompressionType could grow one in case zlib option becomes mandatory.

BlockExportType is the most potentially problematic, because it does not 
make sense to have 'none' there.  It would still not be usable - for 
example the C visit_type_BlockExportOptions_members() would collapse to

     if (!visit_type_q_obj_BlockExportOptions_base_members(...) {
         return false;
     }
     switch (obj->type) {
     default:
         abort();
     }

i.e. basically "return false" because neither visit_type_BlockExportType 
nor visit_type_q_obj_BlockExportOptions_base_members can succeed.

However, QAPI schema generation would work, meaning that you _could_ 
write the QMP commands generically, even if in practice they're dead 
code.  Bug or feature?

>> Rust would spell it "Default::default()"; the language can help rejecting
>> it if you have mandatory string fields (it would recursively default boxed
>> structs, unlike C) but it cannot do anything about portability; this patch
>> closes the gap completely for Rust, and does what it can for C.
> 
> I wouldn't call it a portability problem.  The actual problem is that
> build-time configuration can have unwanted effects at least in theory.
> Since different host platforms can require different configuration,
> porting can trigger the problem.

Yeah, portability in a wider sense---such as different behavior of 
clients when talking to different QEMU binaries.

> You propose to
> 
> * Forbid empty enums [PATCH 2].  They are allowed simply because I never
>    found a compelling reason to forbid them.  Yes, they're useless, but
>    users can figure that out without the QAPI generator insisting.
> 
>    Does forbidding them help Rust?

Somewhat; I cannot generate Default::default() for them.  It would be 
easy enough to skip generation of that method, but you'd still get a 
Rust compilation error if you put them in a struct.

IMO this is telling us that empty enums should indeed fail to compile 
even earlier, in the QAPI schema generator.

Empty enum types cannot be created, and neither can any structs or 
commands they contain.   There's simply no way to have code that refers 
to them, unless they're wrapped in something else that lets the code 
pretend they can exist: for example you can make a field optional and 
write "None" for it.

With conditionally empty enums, this at least makes sense as a concept; 
on the other hand I just don't see the point in unconditionally empty 
enums, even if they're optional, so I left them out.

>    You still allow enums whose members are all conditional.  Build
>    configuration could make these empty, but there are conceivable uses.

I allow them because patch 1 forces them to be optional and then, even 
if *the enum* has no default, "None" is a sensible default for *the 
field*.  In Rust, unlike C, I cannot just access the value of the enum 
if it's "None"; on top of that, optional_field.unwrap_or_default() fails 
to compile because the enum has no default.

> * Require members of enum type to be optional when the enum's first
>    member is conditional [PATCH 1].
> 
>    Does this help Rust?

Yes, it lets me cop out of writing a Default::default() implementation 
for them, while letting them have a sensible default ("None", just like 
in C) if embedded in a struct.

Again, the language is IMO telling us that enums with a conditional 
first member are in general a bad idea, and the solution is to catch 
them earlier, in the QAPI schema generator.

I didn't ban them outright because IMO the fact that in C you can shoot 
yourself in the foot, and assume a meaning of "zero" for such an enum, 
*is* a language problem.  In particular it is a language problem that it 
is not able to express the relationship between has_foo and foo.

But I can be convinced to do it, if you think we need not care about 
cases like BlockExportType.

Paolo

> I believe these rules are mildly bothersome to explain.  Which you
> sidestepped by not documenting them in docs/devel/qapi-code-gen.rst :)
>
> To actually prevent it reliably, we'd have to attack the root of the
> problem, namely the meaning of enum types' zero value.  The obvious way
> to do that is to require enums to have an unconditional first member.
> This is also simpler to document, I think.
> 
> Drawback: it removes the ability to define an enum whose members are all
> conditional, usable with optional object members.  Does this matter
> enough to complicate things?


