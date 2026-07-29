Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE5C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3co-0004ih-FD; Wed, 29 Jul 2026 08:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp3cm-0004i1-Ma
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp3ck-00086f-1k
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785328980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPz6F9AKkWextfLFcg+vbKkB7BH7RigtCnEwaGf5qS0=;
 b=hg68inhrTIvvauNYwp4YeuTbIQmkGr2JR/pfuLnfirIeKRWWFCcvjpJCXRhPu4vnBaRWna
 6Hhg4Cg7cBEAHjybfvC09zcTrB6gG0CLt8975WMyu6BEvQiuEP9AZbyKn/M5hpVX4eHWgs
 ZNsnFH0dbSZxqzIMMGpzY5VM0YcOCjM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-A_nsbWgPOqSV6LNI_KpJ5g-1; Wed,
 29 Jul 2026 08:42:57 -0400
X-MC-Unique: A_nsbWgPOqSV6LNI_KpJ5g-1
X-Mimecast-MFC-AGG-ID: A_nsbWgPOqSV6LNI_KpJ5g_1785328977
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E79D01956045
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:42:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66630180044F
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:42:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D2A3D21E6920; Wed, 29 Jul 2026 14:42:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/54] qom/qdev: associate properties with QAPI schema
 types
In-Reply-To: <CAJ+F1CJBzrP9WjrO2zf7JEFmUchEFDZcGhc9zgR2XTU-rQZQiA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 29 Jul 2026
 14:04:03 +0400")
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <878q6us19k.fsf@pond.sub.org>
 <CAJ+F1CJBzrP9WjrO2zf7JEFmUchEFDZcGhc9zgR2XTU-rQZQiA@mail.gmail.com>
Date: Wed, 29 Jul 2026 14:42:53 +0200
Message-ID: <878q6uq84y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Wed, Jul 29, 2026 at 11:29=E2=80=AFAM Markus Armbruster via qemu
> development <qemu-devel@nongnu.org> wrote:
>> Before I dive into individual patches, let me try to work out what the
>> series does as a whole.
>>
>> > This series adds:
>> >   - A new QAPITypeInfo struct that pairs a property with its QAPI sche=
ma
>> >     type name, enum lookup table, and list-element type.
>>
>> Peeking at the code, I see that ObjectProperty gains a member @qapi_type
>> pointing to its QAPITypeInfo.
>>
>> It is null when the ObjectProperty doesn't have a QAPI type.
>>
>> If it's non-null, then ObjectProperty members @name and @type are
>> redundant with qapi_type.name and .type.
>>
>> Correct?
>
> Almost. @name is the property name (e.g. "policy"), not the type name.
> But @type becomes redundant with qapi_type->name when qapi_type is set
> (object_property_add_qapi derive prop->type from qapi_type->name).
>
> Also @type carries additional information for some property kinds that
> @qapi_type doesn't cover: child<T> and link<T> embed the linked
> object's QOM type name in the type string. qapi_type can't represent
> that atm.

Can child and link properties have non-null @qapi_type?

>> Would "every ObjectProperty has a QAPI type" be a reasonable goal for
>> the future?
>
> Maybe? we would need to address the child<>/link<> gap. At least we
> can make raw object_property_add() deprecated/static in object.c after
> this series

Interesting!

>> >   - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
>> >     instance for every schema-defined type, including the mapping
>> >     between internal C names and the schema name visible to clients.
>>
>> Peeking at the code, I find:
>>
>> * The type
>>
>>     typedef struct QAPITypeInfo {
>>         const char *name;
>>         const char *schema_name;
>>         const QEnumLookup *lookup;
>>         const struct QAPITypeInfo *list;
>>     } QAPITypeInfo;
>>
>> * A T_type_info for each QAPI type T, including built-in types.
>>
>> * T_type_info member @name is T's QAPI name, i.e. "T".
>>
>> * T_type_info member @schema_name is T's masked name used in
>>   query-qmp-schema output, null when T is elided there.
>>
>> * T_type_info member @list points to TList_type_info when that exists,
>>   else it's null.
>>
>> * T_type_info member @lookup points to T_lookup when T is an enum, else
>>   it's null.
>>
>> Correct?
>
> Yes
>
>> >   - A "qapi-type" field in the ObjectPropertyInfo and
>> >     ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
>> >     when present giving clients a cross-reference into query-qmp-schema
>> >     output.
>>
>> To be precise: when ObjectPropertyInfo member @type is "T", then member
>> @qapi-type is T_type_info.qapi-type.  Correct?
>
> @qapi-type is T_type_info.schema_name, the masked name

Right.

>> If .qapi-type is non-null, you can use it to look up precise type
>> information via QAPI introspection, i.e. query-qmp-schema.
>>
>> Correct?
>
> Yes
>
>>
>> Possible problem: query-qmp-schema covers only types that are actually
>> used in QMP.  But the above technique additionally wants QOM property
>> types.  I haven't checked what your series does about this, if anything.
>
> Most types used as QOM properties are also used by QMP commands. But
> it's true that types not used by QMP get schame_name =3D NULL atm.

So the problem is real, and to reap the full benefit of your work, we
need to solve it.  Not necessarily right away.

> Should we have a new pragma? Even if we have conditions, we may end up
> with unused types in the build, but that shouldn't be a big issue. Or
> we would need a more complicated several step build.

No need not worry about the how right now.

>> ObjectPropertyInfo is only used with QMP command handlers.  It is
>> computed from ObjectProperty.
>>
>> >   - Conversion of all PropertyInfo definitions from the old
>> >     .type/.enum_table strings to the new .qapi_type pointer.
>>
>> The above is QOM, this is qdev.
>>
>> Like ObjectProperty, PropertyInfo gains a member @qapi_type pointing to
>> its QAPITypeInfo.  Howver, this one cannot be null.
>>
>> PropertyInfo members @type and @enum_table are dropped, because they are
>> redundant with qapi_type.type and .lookup.
>>
>> Correct?
>
> Almost. Every PropertyInfo has a non-NULL qapi_type, except the array
> ones (created with DEFINE_PROP_ARRAY_INFO) which leave .qapi_type NULL
> and derive it at registration time from
> .element_info->qapi_type->list.

Can you point me to the code setting it?  Would save me the digging.

>                                 Either way, the resulting
> ObjectProperty always ends up with a non-NULL qapi_type.
>
> PropertyInfo members @type and @enum_table are dropped, because they
> are redundant with qapi_type->name and ->lookup.

Yes.

>> >   - Replacement of the generic qdev_prop_array with typed per-element
>> >     array PropertyInfos, removing the arrayinfo/arrayfieldsize
>> >     indirection from struct Property.
>>
>> Before the series, an array-valued Property's @info member is
>> @qdev_prop_array.  @qdev_prop_array provides no information on the array
>> elements.  Instead, Property member @arrayinfo points to the
>> PropertyInfo for the elements, and @arrayfieldsize is the size of an
>> element.
>>
>> Your series makes PropertyInfo array-capable: new members @element_info
>> and @element_size are the elements' PropertyInfo and size.  It then adds
>> a proper PropertyInfo for each such property, and drops
>> @qdev_prop_array.
>>
>> Correct?
>
> Yes
>
>>
>> This could perhaps be spun out and merged separately to reduce the size
>> of future respins.
>
> I can split it out if it helps

Splitting off self-contained parts of a big series can help if they can
be merged quicker than the entire series.  We'll see.

>> Not mentioned:
>>
>>     - New QOM property creation functions for creating properties of
>>       QAPI type.  These take a QAPITypeInfo.
>>
>>     - Convert some properties to use them.
>>
>> >   - Removal of the deprecated PropertyInfo.type and .enum_table fields,
>> >     and of the old object_property_add_enum/add_tm APIs.
>> >
>> > Along the way, a few pre-existing type mismatches in property
>> > definitions are fixed, the "struct tm" RTC property is replaced with a
>> > proper QAPI StructTm type etc. Introducing more specific types or a
>> > "typedef" to QAPI could help provide better associated type informatio=
ns
>> > than plain "str" in many cases, for example.
>>
>> Examples?
>>
>
> Properties using str_type_info that carry structured values with their
> own validation: macaddr ("52:54:00:12:34:56"), PCI addresses
> ("04:00.0"), netdev names, chardev names, drive names, UUID strings. A
> QAPI "typedef" (or newtype) for e.g. MacAddr, PciDevAddr, UUID could
> let tools know these aren't arbitrary strings (see "hw/nvdimm: convert
> UUID property to QAPI-aware registration" patch).

Two separate kinds:

1. Strings we need to parse: PCI addresses, MAC addresses, UUIDs, ...

   Parsing maps the string to something else, usually some object that
   isn't a string.

   We avoid string parsing in QAPI/QMP whenever practical.  You quoted
   several examples where we don't.

2. IDs of things we need to resolve

   Resolving maps the string to the object it names.

In both cases, we map strings to objects.

QAPI is unaware of this.  It simply uses strings in generated C.

What if QAPI was aware?  If the schema specified the object type, and
how to map from string to it?  This is a step beyond a mere typedef.
The mapping would move from handwritten code to generated code.
Generated interfaces would use the object types instead of strings.

Not now, of course.

>> > Comments welcome!
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>


