Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8CACC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHI2x-0007od-39; Thu, 15 Oct 2026 05:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHI2o-0007no-1o
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHI2m-0007WB-5s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792057593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ydRTwpTuD/le7V7c9E0bZszxsjpfM4xmrdMuumnPwI=;
 b=Rp8oVZyRRLHuHN/PP326u5FQjAoVNc40pIRab1r6qhXBmMLkE6QfjNxgb49rRbgL8EOwqZ
 oAznmBE62mnyF0G17jFpEeVOurv1oWej1LlG8yBOCX9SwycVJg+vXiw/8j1o1zcYCqhJC+
 k0E1KRIHNzlbMHAryi85iTYY7nwJFlo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-hrCnIP6zPhKC0B_6U6uqJQ-1; Thu,
 15 Oct 2026 09:46:31 +0000
X-MC-Unique: hrCnIP6zPhKC0B_6U6uqJQ-1
X-Mimecast-MFC-AGG-ID: hrCnIP6zPhKC0B_6U6uqJQ_1792057590
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 959C71956063; Thu, 15 Oct 2026 09:46:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAE5B7D5; Thu, 15 Oct 2026 09:46:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EFDD21E6A04; Thu, 15 Oct 2026 11:46:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 60/62] qapi: expose integer signedness and width in
 introspection
In-Reply-To: <CAJ+F1CLaQjgT+fmp1SLLvgcWuUAq05u9aQfcjdJe0nW47OOVfw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 14 Oct 2026
 23:14:06 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-60-7732a55b7760@redhat.com>
 <8733u9ya8v.fsf@pond.sub.org>
 <CAMxuvax65ysmLnOEWbC87GrZxfc86a+7dOb6ZVwenz-NWwvNQQ@mail.gmail.com>
 <87tsmou89o.fsf@pond.sub.org>
 <CAJ+F1CLaQjgT+fmp1SLLvgcWuUAq05u9aQfcjdJe0nW47OOVfw@mail.gmail.com>
Date: Thu, 15 Oct 2026 11:46:27 +0200
Message-ID: <87jynj9tzg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Wed, Oct 14, 2026 at 10:06=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Hi
>> >
>> > On Tue, Oct 13, 2026 at 5:56=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> >>
>> >> > Integer built-in types are currently canonicalized to "int" in
>> >> > query-qmp-schema. Consequently, clients cannot distinguish types su=
ch
>> >> > as int8, uint64, and size, even though they accept different ranges.
>> >>
>> >> This is by design.
>> >>
>> >> Width and signedness are an implementation detail.  We can change them
>> >> freely without affecting syntactic compatibility of the wire protocol.
>> >>
>> >> If we expose them, we can't anymore, and docs/devel/qapi-code-gen.rst
>> >> section "Compatibility considerations" needs an update.
>> >>
>> >> Why would this be useful?  Knowing width and signedness narrows down =
the
>> >> possible values some, but it need not be tight.
>> >
>> > Well, this was just a first step toward a better introspection support
>> > for constaints. I understand the wire format is just json int, but we
>> > may want to express ranges, enumeration of valid values, alignment,
>> > string format etc.. Exposing signdness and width is the basics, and
>> > establishes a pattern for carrying type-level metadata beyond just
>> > "json-type". This enable clients to do proper validation and UI
>> > generation without knowledge of commands and internals.
>>
>> Let's assume for the sake of the argument we want to do this.
>>
>> How to best communicate constraints to clients is not obvious.  Not
>> least because our idea on what constraints exactly we want to
>> communicate is little more than hand-waving so far.
>>
>> Constraints on acceptable values for integer types could be encoded in
>> type names.  This is one way to communicate constraints.  Whether it's a
>> good way is not obvious.  But let's think about it some more.y
>
> The patch doesn't use type names to communicate constraints. They are
> just identifiers - the spec already says they're meaningless strings.
> Constraints are communicated with the "integer" member (signed/bits),
> purely additive to SchemaInfoBuiltin.

Point taken.

>> We'd move from the single type name "int" to multiple ones.  In theory,
>> existing clients use type name "int" only to lookup the SchemaInfo, then
>> recognize "meta-type": "builtin", "json-type": "int".  Splitting up
>> built-in type "int" into several types does not affect such clients as
>> long as the @json-type value remains the same.  In practice, Hyrum's law
>> applies, and we'd have to work with client developers to make sure we're
>> not breaking existing clients.
>
> I don't understand how that could confuse existing clients, it should
> be a compatible change.

It should be, which doesn't help much when it isn't.

docs/devel/qapi-code-gen.rst does tell clients to use type names only as
references:


    Command and event names are part of the wire ABI, but type names are
    not.  Therefore, the SchemaInfo for types have auto-generated
    meaningless names.  [...]  To examine a type, start with a command
    or event using it, then follow references by name.

And on built-in types in particular:

    The SchemaInfo for a built-in type has the same name as the type in
    the QAPI schema (see section `Built-in Types`_), with one exception
    detailed below.  It has variant member "json-type" that shows how
    values of this type are encoded on the wire.

    [...]

    The QAPI schema supports a number of integer types that only differ in
    how they map to C.  They are identical as far as SchemaInfo is
    concerned.  Therefore, they get all mapped to a single type "int" in
    SchemaInfo.

    As explained above, type names are not part of the wire ABI.  Not even
    the names of built-in types.  Clients should examine member
    "json-type" instead of hard-coding names of built-in types.

If telling clients what to do was reliable, our jobs would be easier.
It isn't, and we need to be careful.

First stop: would it break libvirt?

>> Signedness and width are a crude approximation of the actual
>> constraints.  I doubt it's useful by itself, and I'm unwilling to commit
>> to a way to communicate constraints just for that.
>
> It's useful to do client-side input validation, and present appropriate UI

How could the UI differ between 'int8' and 'int'?

> Again, this is the foundation, width and signedness are inherent
> properties. Future constraint systems (explicit ranges, alignment etc)
> would naturally extend SchemaInfoBuiltin. The "integer" member doesn't
> conflict with any design direction for richer additions.

Should the constraints be tied to the type or to the member?  Not
obvious!

I don't think we can design constraint introspection step by step.  We
need to start with an idea of what we want and why.  Then figure out how
to fit it into the existing interface.  Then implement it, possibly step
by step.

Right now we are at "what do we want and why?"

The answer need not be perfect --- we often learn along the way.  But it
needs to at least exist.

>> Fortunately, this patch is only losely connected to what your series is
>> about, namely to "associate properties with QAPI schema types".  We can
>> simply drop it.  If you'd like to work on communicating constraints, we
>> can talk about scope and interface design separately.
>>
>> [...]
>>
>>


