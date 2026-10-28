Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BC606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iNQzojsP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3sL-0000Se-2l; Wed, 28 Oct 2026 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM3s5-0000Nm-1I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM3s2-0007sR-W0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlD37NVhcfdbxopxrs/zNGEMuIapaRYAV0KDeDJa4aA=;
 b=iNQzojsP1wYf52sscdU+Zz2bLsxFV+fPKLifNFNHCLk7k6ZZ3q+Rz8FSg4HP3fi+/xZCnI
 cHr65XjqCy88aSjNsuD/o7tlz08hHy+GlS87tHMo8NGs5sBSBNB6pUCnM+cdMXmcK3Bbdr
 GJ+Q0R0QvmZ4Vaf8/fLS149BtG6j878=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-g6vS8oSGNIylsR3xKKGf5g-1; Wed,
 28 Oct 2026 09:39:12 -0400
X-MC-Unique: g6vS8oSGNIylsR3xKKGf5g-1
X-Mimecast-MFC-AGG-ID: g6vS8oSGNIylsR3xKKGf5g_1793194752
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC05B1954239; Wed, 28 Oct 2026 13:39:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CAEB46C; Wed, 28 Oct 2026 13:39:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1DDF21E6A04; Wed, 28 Oct 2026 14:39:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  John Snow <jsnow@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: ObjectPropertyInfo design
In-Reply-To: <at-MMBGue0-1q5jG@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 26 Oct 2026 17:21:52 +0000")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87ik2tj0g3.fsf@pond.sub.org> <at-MMBGue0-1q5jG@redhat.com>
Date: Wed, 28 Oct 2026 14:39:08 +0100
Message-ID: <87fqxqj66b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 22, 2026 at 04:04:44PM +0200, Markus Armbruster wrote:
>> Marc-Andr=C3=A9's series evolves ObjectPropertyInfo and ObjectPropertyVa=
lue:
>> it adds member @qapi-type and changes many values of member @type.
>>=20
>> I'd like to take a step back and discuss design.  I trimmed Cc:
>> accordingly.
>>=20
>>=20
>> =3D The current interface
>>=20
>> qom-list returns information on an object's properties, one
>> ObjectPropertyInfo per property.
>>=20
>> qom-list-properties returns information on properties an instance of a
>> type is known to have[*], one ObjectPropertyInfo per property.
>
> This is=20

Yes?

>> qom-list-get returns information on the properties of several objects,
>> one ObjectPropertyValue per property.
>
> Since 'qom-list-properties' is really introspecting types, rather
> than instances, I'd add its companion:
>
>   query-qmp-schema  returns information on properties from
>   user creatable QOM objects, via the ObjectOptions union
>   which handles data of arbitary complexity and nesting,
>   with strictly QAPI types only. Obviously missing QDev
>   and other internal only types.

Yes.  Ideally, it would cover everything, but QOM's design and the sheer
amount of QOM types and properties has kept that well out of reach.  QOM
introspection filled the gap, but badly.  Marc-Andr=C3=A9's work makes it
less bad.

>> * @description is rarely present (I see under 15% in a quick test).  The
>>   description text is commonly misleading for QMP.  For instance, qdev
>>   bool properties have description "on/off".  The possible values are
>>   actually JSON false and true.
>
> With query-qmp-schema  we have a description for 100% of properties,
> enforced by the QAPI schema parser. Only applies to UserCreatable QOM
> objects though.

Yes.

QAPI schema doc comments are mandatory, and they get validated against
the schema code.  They become the "QEMU QMP Reference Manual".

QOM property description strings are optional, and they are not checked
in any way.  They are used in help intended for humans.

> I see descriptions as primarily a documentation thing for humans, and
> perhaps for machines which are trying to generate code frmo QAPI
> schema and want to use descriptions for docs. These are both static
> querying tasks.
>
> I don't see descriptions as useful for mgmt apps at runtime for
> deployed QEMus.

Noted.

>> * @default-value can be useful with qom-list-properties, which operates
>>   on types.  I doubt it is with qom-list, which operates on objects.
>
> Likewise, IMHO this is useful info statically, but not at runtime.

Noted.

>> Let's pretend @description doesn't exist, and @default-value exists only
>> with qom-list-properties.
>>=20
>> This makes qom-list-get strictly more powerful than qom-list, so let's
>> further pretend qom-list doesn't exist.
>>=20
>>=20
>> =3D Simplified interface for the sake of discussion
>>=20
>> qom-list-properties returns information on properties an instance of a
>> type is known to have[*]: @name, @type, and maybe @default-value.
>
> In the ideal world 'qom-list-properties' would not need to exist,
> but it has to for the forseeable future, since none of QDev is
> modelled in QAPI schema currently.=20

Yes.

>> qom-list-get returns information on the properties of several objects:
>> @name, @type, and maybe @value.
>>=20
>>=20
>> =3D The meaning of @type
>>=20
>> Three cases:
>>=20
>> 1. For a child property (created with object_property_add_child() etc.),
>>    @type is "child<T>", where T is the child's QOM type.
>>=20
>> 2. For a link property (created with object_class_property_add_link()
>>    etc.), @type is "link<T>", where T is the target's QOM type.
>>=20
>> 3. For other properties, @type can be anything.  We commonly use QAPI
>>    type names (occasionally misspelled), and also "well-known" (but
>>    undocumented) non-QAPI names for primitive types.  Every now and
>>    then, developers get lazy and use values like "list", or creative and
>>    use values like "guest statistics".  Nobody has gotten sufficiently
>>    masochistic to use values starting with "child<" or "link<" so far,
>>    although nothing would stop that.
>>=20
>> Cases 1 and 2 go against the QAPI/QMP design maxim "don't encode stuff
>> in strings".
>
> They're not particular nice internally either as part of QDev/QOM.
> ie this is gross as a design approach:
>
>   static inline bool object_property_is_child(ObjectProperty *prop)
>   {
>     return strstart(prop->type, "child<", NULL);
>   }

I can top that!

    /* Go from link<FOO> to FOO.  */
    type =3D object_property_get_type(obj, name, NULL);
    target_type =3D g_strndup(&type[5], strlen(type) - 6);

>> Case 3 is is hard to use for anything.  You're forced into stupid and
>> brittle hardcoding.
>>=20
>> Marc-Andr=C3=A9's work adds a new optional member @qapi_type that refers=
 to a
>> QAPI type in the output of query-qmp-schema.  It's present for a large
>> subset of case 3.  When it's present, @type should not be used.
>>=20
>> It also cleans up many crap cases of 3, but without making it robust.  I
>> understand this isn't something the series tries to do, it's just
>> something that's easier to do than not to do.  If it creates
>> compatibility problems, we have to not do it.  I hope it doesn't.
>>=20
>>=20
>> =3D Can we do better?
>>=20
>> What information are we trying to convey?  Four cases:
>>=20
>> 1. Child property: the child's QOM type
>>=20
>> 2. Link property: the target's QOM type
>>=20
>> 3. QAPI-backed property: the property's QAPI type
>>=20
>> 4. Other property: we have nothing useful to offer
>>=20
>> Case 4 should go away eventually.
>>=20
>> How would we encode this in QAPI on a green field?  With a union, of
>> course:
>>=20
>>     { 'enum': 'ObjectPropertyKind',
>>       'data': [ 'child', 'link', 'qapi', 'other'] }
>>=20
>>     { 'struct': 'ObjectPropertyInfoLink',
>>       'data': { 'qom-type': 'str' } }
>>=20
>>     { 'struct': 'ObjectPropertyInfoQAPI',
>>       'data': { 'qapi-type': 'str' } }
>>=20
>>     { 'union': 'ObjectProperty...',
>>       'base': { 'kind': 'ObjectPropertyKind',
>>                 ... more ... },
>>       'discriminator': 'kind',
>>       'data': {
>>           'child': 'ObjectPropertyInfoLink',
>>           'link': 'ObjectPropertyInfoLink',
>>           'qapi': 'ObjectPropertyInfoQAPI' } }
>>=20
>> To make this a compatible evolution of ObjectPropertyInfo, we need
>> ... more ... to be
>>=20
>>                 'type': 'str',
>>                 '*description': 'str'
>>                 '*default-value': 'any',
>>=20
>> Sadly, we need to duplicate the union for ObjectPropertyValue.  There,
>> ... more ... needs to be
>>=20
>>                 'type': 'str',
>>                 '*value': 'any'
>>=20
>> We should deprecate @type.  I'd also deprecate @description.
>>=20
>> Thoughts?
>
> We currently have
>
>   { 'enum': 'ObjectType', .... }
>
> which provides a name in QMP schema for every QOM type that
> implements UserCreatable.
>
> We could relatively easily  extend that to cover *all* QOM
> types in existance, with some judicous grepping of TypeInfo
> classes.
>
> It would be nice if we could enforce at runtime though that
> anything passed to type_register() was listed in 'ObjectType'
> enum to catch omissions. Not sure if there are any unexpected
> dragons if we make type_register() check the type name
> against  'ObjectType_lookup' from qapi-types-qom.h ?

Can't see why that wouldn't work.

We use strings instead of a C enum for type names, because a C enum
would be conflict magnet, and also a "recompile the world" header.

Strings weaken the type checker, and also risk typos.  The #define
TYPE_FOO "foo" reduce that risk.  Since we don't always use them, we
always have to grep both for TYPE_FOO and "foo".

If we enumerate all the type names in a QAPI enum, we generate such a C
enum, but use it only to check the strings.  Still a conflict magnet,
but at least not a "recompile the world" header.

> Then your
>
>>     { 'struct': 'ObjectPropertyInfoLink',
>>       'data': { 'qom-type': 'str' } }
>
> could at least reference 'ObjectType' instead of 'str'

Yes.  There are a few more, e.g. CompatProperty member @qom-type.

>                                                        and be
> aligned more with query-qmp-schema.

What do you mean by that?


