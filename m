Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBFBC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgfb-0000Eu-6f; Mon, 23 Jun 2025 08:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTgfT-00005l-HN
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTgfP-00050d-Qt
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750683172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVv+1yzCVJQ5S8hZjncSmphMsf9Mx1qg2KfiRAfyY8A=;
 b=NFjJPs0bXSaLN7cHI8ZPFB2ml3FYXTfULIIwhCANrQEN3zK9jZwEpibQ8/mE3Qu9vDNhMg
 1Onzu/eWLxiR8DBaZXwcQGizmhs68PhU4AMlk7vj82eO94TgXjMSUk5D0mQC2SmB3gaGqr
 3uxT4BSbBkUdxCxVkLPGlDChasbJRzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-nwjyiC15NQm2RxPopxnhSA-1; Mon,
 23 Jun 2025 08:52:51 -0400
X-MC-Unique: nwjyiC15NQm2RxPopxnhSA-1
X-Mimecast-MFC-AGG-ID: nwjyiC15NQm2RxPopxnhSA_1750683170
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA15D1800343; Mon, 23 Jun 2025 12:52:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 107D419560A3; Mon, 23 Jun 2025 12:52:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BFBA21E6A27; Mon, 23 Jun 2025 14:52:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-rust@nongnu.org,  Martin Kletzander
 <mkletzan@redhat.com>
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
In-Reply-To: <CABgObfY7==Q8z9xPS6oO-qv9U4LJ19Y+mCYENqSYnGFwkhoBYw@mail.gmail.com>
 (Paolo Bonzini's message of "Wed, 18 Jun 2025 19:36:00 +0200")
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <aEk6vdosWZgyQGXD@intel.com>
 <CABgObfaK8h3GE4GWbPrn22JshYcCFdXsxWHWuAPVC4pRb7GZ0A@mail.gmail.com>
 <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
 <877c19nn3p.fsf@pond.sub.org>
 <CABgObfY7==Q8z9xPS6oO-qv9U4LJ19Y+mCYENqSYnGFwkhoBYw@mail.gmail.com>
Date: Mon, 23 Jun 2025 14:52:46 +0200
Message-ID: <877c1262n5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il mer 18 giu 2025, 16:25 Markus Armbruster <armbru@redhat.com> ha scritt=
o:
>
>> I don't know enough about Rust/serde to give advice.  I do know how to
>> make a fool of myself by asking dumb questions.
>>
>
> No dumb questions, only dumb answers.
>
>> For commands this is not a problem because the real underlying
>> > transformation is QObject->QObject and the intermediate steps (to and
>> > from QObject) can use serde.
>>
>> Are you talking about commands implemented in Rust?
>>
>
> Yes. I will intersperse your text with the corresponding Rust/serde
> implementation.
>
>> The existing data flow is roughly like this (I'm simplifying):
>>
>> 1. Parse JSON text into request QObject, pass to QMP core
>>
>> 2. Extract command name string and argument QDict
>>
>> 3. Look up generated command marshaller / unmarshaller, pass argument
>>    QDict to it
>>
>
> Same so far since this is C code.
>
>> 4. Unmarshall argument QDict with the QObject input visitor and
>>    generated visit_type_ARG()
>
> Unmarshall with QObject Deserializer, which talks to a serde-generated
> Deserialize implementation.
>
>> 5. Pass the C arguments to the handwritten command handler, receive the
>>    C return value
>>
>
> Same.
>
>> 6. Marshall the return value into a QObject with the QObject output
>>    visitor and generated visit_type_RET(), return it to QMP core
>>
>
> Marshall with the QObject Serializer, which talks to a serde-generated
> Serialize implementation.
>
>> 7. Insert it into a response QObject
>>
>> 8. Unparse response QObject into JSON text
>>
>
> Same.
>>
>> How would a Serde flow look like?
>>
>
> As described above, visitors are bypassed and the marshalling/unmarshalli=
ng
> works directly at the QObject level.

We use the same code (handwritten QMP core) up to QObject and from
QObject on.

In between, we use QObject input/output visitors with generated C data
types for commands implemented in C, and Serde-generated
deserializers/serializers with generated Rust data types for commands
implemented in Rust.

Correct?

> Implementation-wise the main difference is that 1) the type code
> (Serialize/Deserialize) is not the same for serialization and
> desetialization, unlike visit_type_*() 2) the code generation is done by
> serde instead of qapi-gen and we'd be mostly oblivious to how it works.
>
> The Serializer and Deserializer should be about 1500 lines of Rust + test=
s,
> and they would do the functionality of the QObject input and output
> visitors.

We end up with two separate ways to do the same job, which is kind of
sad.

I gather the alternative would be to use generated QAPI visitors for the
generated Rust data types instead of Serde.  This would be unusual for
Rust code: Serde exists and works, so reinvent it would be wasteful and
dumb.

Gut feeling: sticking to how things are usually done (here: with Serde)
is the more prudent choice.

>> > However, QOM property getters/setters (especially, but not
>> > exclusively, for properties with compound types) remain a problem
>> > since these use callbacks with a Visitor* argument.
>>
>> object_property_set() takes the new property value wrapped in an input
>> visitor.  The property setter extracts it using visit_type_FOOs() with
>> this input visitor as it sees fit.  Ideally, it uses exactly
>> visit_type_PROPTYPE().
>>
>> object_property_get() takes an output visitor to be wrapped it around
>> the property value.  The property getter inserts it using
>> visit_type_FOOs() with this output visitor as it sees fit.  Ideally, it
>> uses exactly visit_type_PROPTYPE().
>>
>> We sometimes use a QObject input / output visitor, and sometimes a
>> string input / output visitor.  The latter come with restrictions, and
>> are evolutionary dead ends.
>>
>> The QObject visitors wrap a QObject, the string visitors wrap a string
>> (d'oh).
>>
>
> Yep. The string visitor is why we cannot just change getters and setters =
to
> use QObject.

The string visitors have long been a thorn in my side.

I wish QOM wasn't so annoyingly flexible.  I wish a property had to be
of QAPI type (possibly complex).  Less headaches.  Less boilerplate,
too.

Almost all QOM properties are.  And the few that aren't feel like bad
ideas to me.

> In this case, without writing a visit_type_*() implementation that can
> write to a Rust struct, an intermediate QObject would be the only way to
> turn a Visitor into a Rust data type. So I can imagine three ways to
> operate:
>
> * Keep using serde like for commands: in the callback that is invoked by
> object_property_set() do Visitor->QObject->setter (yes that means double
> conversion when the source visitor is and QObject visitor) or for the
> getter case, getter->QObject->Visitor. This has the minimum amount of code
> added to qapi-gen.

Recall the callback gets the new property value wrapped in an input
visitor.  Whereas a C setter extracts it into some C variable(s), a Rust
setter extracts it into a QObject, which it then passes to Serde for
deserialization into Rust variables.  Correct?

> * Generate a visit_type_*() implementation that emits a Rust struct (i.e.
> one that maps for example 'str' to a String and not a *mut c_char) and
> forgo serde completely. Use this generated implementation everywhere: QOM
> getters and setters, as well as QMP commands. This is how C code works.

This is the alternative mentioned above.

> * Generate rust->C (e.g. String->*mut c_char) and C->rust converters from
> qapi-gen; use the existing C visit_type_*() to extract data from visitors
> and then apply said converters to turn the data into a Rust struct, and
> likewise in the other direction. This was the way Marc-Andr=C3=A9's proto=
type
> worked.

Converters between C and Rust data types let us cut at the C data type
instead of at QObject.

We use the same code up to QAPI-generated C data type and from
QAPI-generated C data type on.

In between, we work directly with the C data type for properties
implemented in C, and convert to and from the Rust data type for
properties implemented in Rust.

Correct?

The simplest such converters convert via QObject.  Grossly inefficient
:)

Marc-Andr=C3=A9's prototype demonstrates efficient converters can be had.
The question is whether they're worth their keep.

>> I'm afraid this is too terse for ignorant me.
>>
>
> I tried to translate that. :)

Thank you!


