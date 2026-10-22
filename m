Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JoR0+xBS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtQ0-0000iP-Lv; Thu, 22 Oct 2026 10:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJtPc-0000Uv-CG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 10:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJtPa-0007mf-5d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 10:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792677890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0Dn4cMbatHc8u5gPwJqR6ERLr2a6FKdRWRqmYGAqKY=;
 b=JoR0+xBS+La8bOU3bcDCtZbGmfdfOg0RSpeyHJEERLvinnp3ctUZ42DOFCF3jVtMWFhr26
 2lPWCbN+jSIfgkL/xiJZUiehE4XRmnXWDAHaIGWKU7je0aNaihHRvTBXN+vIHUtjptOq1P
 R0G7HKoIWGLTvM9ViO/L9Ag98MkWuw0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-y55zXdV3Pde0jpNhjT7RhQ-1; Thu,
 22 Oct 2026 10:04:49 -0400
X-MC-Unique: y55zXdV3Pde0jpNhjT7RhQ-1
X-Mimecast-MFC-AGG-ID: y55zXdV3Pde0jpNhjT7RhQ_1792677888
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9BB195420D; Thu, 22 Oct 2026 14:04:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4065C180057F; Thu, 22 Oct 2026 14:04:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB84221E6A04; Thu, 22 Oct 2026 16:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  John Snow
 <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: ObjectPropertyInfo design (was: [PATCH v7 00/65] Hi)
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com> (marcandre
 lureau's message of "Tue, 20 Oct 2026 14:45:17 +0400")
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
Date: Thu, 22 Oct 2026 16:04:44 +0200
Message-ID: <87ik2tj0g3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Marc-Andr=C3=A9's series evolves ObjectPropertyInfo and ObjectPropertyValue:
it adds member @qapi-type and changes many values of member @type.

I'd like to take a step back and discuss design.  I trimmed Cc:
accordingly.


=3D The current interface

qom-list returns information on an object's properties, one
ObjectPropertyInfo per property.

qom-list-properties returns information on properties an instance of a
type is known to have[*], one ObjectPropertyInfo per property.

qom-list-get returns information on the properties of several objects,
one ObjectPropertyValue per property.

ObjectPropertyInfo and ObjectPropertyValue provide @name and @type.

ObjectPropertyInfo additionally provides @description and
@default-value, both optional.

ObjectPropertyValue additionally provides optional @value, absent when
the property cannot be read.

If ObjectPropertyValue was an extension of ObjectPropertyInfo, then
qom-list-get would be a strictly more powerful version of qom-list.
It isn't.  However, I think the information lost when moving from
qom-list to qom-list-get is not useful:

* @description is rarely present (I see under 15% in a quick test).  The
  description text is commonly misleading for QMP.  For instance, qdev
  bool properties have description "on/off".  The possible values are
  actually JSON false and true.

* @default-value can be useful with qom-list-properties, which operates
  on types.  I doubt it is with qom-list, which operates on objects.

Let's pretend @description doesn't exist, and @default-value exists only
with qom-list-properties.

This makes qom-list-get strictly more powerful than qom-list, so let's
further pretend qom-list doesn't exist.


=3D Simplified interface for the sake of discussion

qom-list-properties returns information on properties an instance of a
type is known to have[*]: @name, @type, and maybe @default-value.

qom-list-get returns information on the properties of several objects:
@name, @type, and maybe @value.


=3D The meaning of @type

Three cases:

1. For a child property (created with object_property_add_child() etc.),
   @type is "child<T>", where T is the child's QOM type.

2. For a link property (created with object_class_property_add_link()
   etc.), @type is "link<T>", where T is the target's QOM type.

3. For other properties, @type can be anything.  We commonly use QAPI
   type names (occasionally misspelled), and also "well-known" (but
   undocumented) non-QAPI names for primitive types.  Every now and
   then, developers get lazy and use values like "list", or creative and
   use values like "guest statistics".  Nobody has gotten sufficiently
   masochistic to use values starting with "child<" or "link<" so far,
   although nothing would stop that.

Cases 1 and 2 go against the QAPI/QMP design maxim "don't encode stuff
in strings".

Case 3 is is hard to use for anything.  You're forced into stupid and
brittle hardcoding.

Marc-Andr=C3=A9's work adds a new optional member @qapi_type that refers to=
 a
QAPI type in the output of query-qmp-schema.  It's present for a large
subset of case 3.  When it's present, @type should not be used.

It also cleans up many crap cases of 3, but without making it robust.  I
understand this isn't something the series tries to do, it's just
something that's easier to do than not to do.  If it creates
compatibility problems, we have to not do it.  I hope it doesn't.


=3D Can we do better?

What information are we trying to convey?  Four cases:

1. Child property: the child's QOM type

2. Link property: the target's QOM type

3. QAPI-backed property: the property's QAPI type

4. Other property: we have nothing useful to offer

Case 4 should go away eventually.

How would we encode this in QAPI on a green field?  With a union, of
course:

    { 'enum': 'ObjectPropertyKind',
      'data': [ 'child', 'link', 'qapi', 'other'] }

    { 'struct': 'ObjectPropertyInfoLink',
      'data': { 'qom-type': 'str' } }

    { 'struct': 'ObjectPropertyInfoQAPI',
      'data': { 'qapi-type': 'str' } }

    { 'union': 'ObjectProperty...',
      'base': { 'kind': 'ObjectPropertyKind',
                ... more ... },
      'discriminator': 'kind',
      'data': {
          'child': 'ObjectPropertyInfoLink',
          'link': 'ObjectPropertyInfoLink',
          'qapi': 'ObjectPropertyInfoQAPI' } }

To make this a compatible evolution of ObjectPropertyInfo, we need
... more ... to be

                'type': 'str',
                '*description': 'str'
                '*default-value': 'any',

Sadly, we need to duplicate the union for ObjectPropertyValue.  There,
... more ... needs to be

                'type': 'str',
                '*value': 'any'

We should deprecate @type.  I'd also deprecate @description.

Thoughts?


[*] It may have more; see the note in the doc comment of
qom-list-properties.


