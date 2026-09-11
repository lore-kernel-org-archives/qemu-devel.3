Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D39C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x517B-0004mF-T2; Fri, 11 Sep 2026 09:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5177-0004lP-HW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5172-0001U6-6N
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789132574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57CzNCRTthODrbtT7dzu/I9yXOfaSOVq6sisdPP0skE=;
 b=hCM39xc4Q5rE4hGwJ8aewdsSaRkjKq1fR535nuP5XoejbK03+CpXXtHrYRwmHrRjElvIiq
 /j2uyK4lBckqM2hz7CrsL0oV6hU2wH/Ck6k/tfLQQEvgdr/jQNxIct+AfumBxvjrI7WLB0
 iquaVCSrrRtG6KP8cQdoaRHZBNRx4vg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-H4CT1uZLPl6LZHNmh8XYZw-1; Fri,
 11 Sep 2026 09:16:09 -0400
X-MC-Unique: H4CT1uZLPl6LZHNmh8XYZw-1
X-Mimecast-MFC-AGG-ID: H4CT1uZLPl6LZHNmh8XYZw_1789132567
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F24118011EC; Fri, 11 Sep 2026 13:16:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6992195608C; Fri, 11 Sep 2026 13:16:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B64221E6A04; Fri, 11 Sep 2026 15:16:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 05/75] qapi: add type-infos generator
In-Reply-To: <20260904-qom-qapi-v4-5-a985f168e938@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 04 Sep 2026 23:57:48 +0400")
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-5-a985f168e938@redhat.com>
Date: Fri, 11 Sep 2026 15:16:04 +0200
Message-ID: <87o6e453or.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I'm reviewing just the documentation right now.  I'll look at the
remainder later.

Documentation updates are commonly at least as hard as generator
changes, if not harder.  Please don't be discouraged by my remarks!

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> New QAPISchemaGenTypeInfoVisitor produces per-module
> qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
> pairing the QAPI type name with its masked introspection name.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst | 107 +++++++++++++++++++++++++-
>  meson.build                  |   1 +
>  scripts/qapi/backend.py      |   2 +
>  scripts/qapi/introspect.py   |   2 +-
>  scripts/qapi/type_infos.py   | 178 +++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 285 insertions(+), 5 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index b1cc5b5f0db1..d176238fc2ef 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1247,10 +1247,10 @@ meaningful type names instead.

This is in section "Client JSON Protocol introspection", which explains
query-qmp-schema.

A bit more context:

   Command and event names are part of the wire ABI, but type names are
   not.  Therefore, the SchemaInfo for types have auto-generated
   meaningless names.  For readability, the examples in this section use
   meaningful type names instead.

>  Optional member "features" exposes the entity's feature strings as a
>  JSON array of strings.
>=20=20
> -To examine a type, start with a command or event using it, then follow
> -references by name.
> -
> -QAPI schema definitions not reachable that way are omitted.
> +To examine a type used by QMP, start with a command or event using it,
> +then follow references by name. User-defined and array types are also
> +included when they are not reachable from a command or event, as they
> +may also be used by QOM.

The "To examine a type ..." sentence tries to tell readers not to look
up types by name.  Perhaps we can do without, because how would you even
do that?  It also prepares for "QAPI schema definitions not reachable
that way are omitted."  But you delete that.

The deletion should go into "[PATCH 04] qapi: register all
introspectable types, not just QMP-reachable ones".

The final sentence talks about types not reachable from commands or
events, and hints at QOM use.  I feel the former is a distraction here.
Regarding the latter: we need to say more about QOM introspection than
"[types] may also be used by QOM".  Before this series, query-qmp-schema
is the only QAPI introspection game in town, and this section explains
it.  Afterwards, there's also qom-list, qom-list-properties,
qom-list-get.  I fear doing them justice will require some rewriting.
Maybe just add a FIXME comment for now?

Two spaces between sentences for local consistency, please.

>  The SchemaInfo for a command has meta-type "command", and variant
>  members "arg-type", "ret-type" and "allow-oob".  On the wire, the
> @@ -2101,3 +2101,102 @@ Example::
>      }));
>=20=20
>      [Uninteresting stuff omitted...]
> +
> +
> +Code generated for type information
> +-----------------------------------
> +
> +Type info is generated for user-defined and array types. With option
> +``--builtins``, it is also generated for built-in types and the internal
> +``QType`` enum.

QType is also a built-in type.  It isn't reall internal: while it's not
currently used in the QAPI schema, it it is used outside the QAPI
subsystem, e.g. in qobject/qobject.h.

> +                Other implicit types are skipped.

The term "implicit type" is not really defined.  It's only mentioned
under "Client JSON Protocol introspection".  Do we need this sentence?

What about this:

   Type information is generated for user-defined types and their array
   types.  With option ``--builtins``, it is also generated for the
   built-in types.

By the way, we don't put `` around --builtins elsewhere.  Should we?
=20=20=20
> +
> +The following files are created:
> +
> + ``$(prefix)qapi-type-infos.c``
> +     A ``QAPITypeInfo`` instance for each type listed above, providing
> +     a mapping between the QAPI type name and the masked name used by
> +     introspection, along with optional enum lookup table and array
> +     type pointers.
> +
> + ``$(prefix)qapi-type-infos.h``
> +     Declarations for the above type info instances
> +
> +Each ``QAPITypeInfo`` struct has the following fields:
> +
> +``name``
> +    The QAPI type name (e.g. ``"UserDefOne"``). QOM uses this as the
> +    property type string.

Is "QOM uses this" relevant here?

Permit me a digression.  QAPI introspection masks type names, because
they're not ABI.  Exposing things not meant to be ABI invites misuse,
and then misuse becomes accidental ABI.  QOM exposes unmasked type
names.  I don't like it.

> +
> +``masked_name``
> +    For user-defined types, the masked name used in
> +    ``query-qmp-schema`` output. For array types, the corresponding
> +    bracketed introspection name. Built-in types use their QAPI name;

It's "the masked name used in query-qmp-schema output" for *all* types,
not just user-defined types.

An array's masked name is indeed the element's masked name enclosed in
brackets, but this document carefully avoids to specify that.  Closest
we get is this under "Client JSON Protocol introspection":

                                   For convenience, the array's name may
    resemble the element type; however, clients should examine member
    "element-type" instead of making assumptions based on parsing member
    "name".

Let's not specify more.

> +    note that introspection canonicalizes the integer built-in types
> +    to ``int``.

Yes.  Also under "Client JSON Protocol introspection":

    The QAPI schema supports a number of integer types that only differ in
    how they map to C.  They are identical as far as SchemaInfo is
    concerned.  Therefore, they get all mapped to a single type "int" in
    SchemaInfo.

Do we need to repeat it here?

> +                Internal types not present in introspection use
> +    ``NULL``.

Currently only QType.  Could we make that not a special case?
I.e. .masked_name =3D "QType" like for other built-in types.

> +
> +``lookup``
> +    For enum types, a pointer to the corresponding ``QEnumLookup``
> +    table.  ``NULL`` for non-enum types.
> +
> +``list``
> +    For types that have an array variant, a pointer to the array type's
> +    ``QAPITypeInfo``.  ``NULL`` when no array type exists.
> +
> +These type info instances are used by QOM property registration
> +functions (``object_property_add_qapi()``,
> +``object_class_property_add_qapi_enum()``, etc.) to associate each
> +property with its QAPI type.  The ``qom-list`` and
> +``device-list-properties`` QMP commands then expose the ``qapi-type``
> +field, giving management tools a formal type reference they can look
> +up in the introspection schema.

Alright, you talk a bit more about QOM introspection here.  Fine for
now, but it really needs comprehensive treatment similar to what we do
for query-qmp-schema.  But we can do that later.

> +
> +All user-defined and array types are included in introspection, even when
> +they are not reachable from a command or event.  Their type info therefo=
re
> +always provides the introspection cross-reference.

I'm not sure I understand this paragraph.  What are you trying to
convey?

> +
> +Example::
> +
> +    $ cat qapi-generated/example-qapi-type-infos.h
> +    [Uninteresting stuff omitted...]
> +
> +    #ifndef EXAMPLE_QAPI_TYPE_INFOS_H
> +    #define EXAMPLE_QAPI_TYPE_INFOS_H
> +
> +    #include "qapi/qapi-builtin-type-infos.h"
> +
> +    extern const QAPITypeInfo UserDefOne_type_info;
> +
> +    extern const QAPITypeInfo UserDefOneList_type_info;
> +
> +    #endif /* EXAMPLE_QAPI_TYPE_INFOS_H */
> +    $ cat qapi-generated/example-qapi-type-infos.c
> +    [Uninteresting stuff omitted...]
> +
> +    const QAPITypeInfo UserDefOne_type_info =3D {
> +        .name =3D "UserDefOne",
> +        .masked_name =3D "1",
> +        .list =3D &UserDefOneList_type_info,
> +    };
> +
> +    const QAPITypeInfo UserDefOneList_type_info =3D {
> +        .name =3D "UserDefOneList",
> +        .masked_name =3D "[1]",
> +    };
> +
> +    [Uninteresting stuff omitted...]

For me, it actually generates masked names "0" and "[0]".  Is the
mapping to masked names stable?

> +
> +For a modular QAPI schema (see section `Include directives`_), code for
> +each sub-module SUBDIR/SUBMODULE.json is actually generated into ::
> +
> + SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.h
> + SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.c
> +
> +If qapi-gen.py is run with option --builtins, additional files are
> +created:
> +
> + ``qapi-builtin-type-infos.h``
> +     Type info instances for built-in types
> +
> + ``qapi-builtin-type-infos.c``
> +     Definitions for the above type info instances

[...]


