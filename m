Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983F7C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52bs-00049w-MJ; Fri, 11 Sep 2026 10:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x52aZ-0002i9-LH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x52aV-0002zF-KV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789138233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAdCGKncc6nuCM3vLvr4PganNkNVOJvdFONhtHZAcZs=;
 b=Ku7IyeDwrRZt3UPHFWdgd7TSfwfaDF1t4rM3vCPuhkTGLmPuVSxNoLuZuA1roK4WTuN6TU
 5d0HVnybFb5b7R5MlKZoI/cek2C+CowP4cbClmvC5fAYS/5FUcuhyj9JAt4o1SeyVxNHZm
 i8r80z8aRdZwcrRsb2Q3Ydqfh5Wcz10=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-_jPffYnsMcGYx9uqR3jLiw-1; Fri, 11 Sep 2026 10:50:31 -0400
X-MC-Unique: _jPffYnsMcGYx9uqR3jLiw-1
X-Mimecast-MFC-AGG-ID: _jPffYnsMcGYx9uqR3jLiw_1789138231
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-395543dc382so1401702a91.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789138229; cv=none;
 d=google.com; s=arc-20260327;
 b=SpEDtyjp9pG8bPNeKrvXu1wnI7RX/jD3+DfbrUnOoRnHQgaJPHtZjlSX3EE60ahzIu
 p1ClZrRApKUym+NcXSx39PL9OAMhhpnOmcy4ranIcX3pNIRuoKbNzpZ+cZox++PU3yMN
 nxn0HchHNQNOiYFGJONiiIS3qhemT30mc2IG97G6KU0mI93tNHHEN1D5k9QaU17qE1Do
 vOVdiXZhFJftdHYyFAXI//t/DvIdWyByMq8X+rjDamTAAoBupgV7hWl8XvIe4mFGSidm
 F5mnan6vmDQpggRFXBqrWC69kKOyuOKXndB1GoDJ8VEq8j7iyUY5qtT25oidprChzAo8
 rTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QAdCGKncc6nuCM3vLvr4PganNkNVOJvdFONhtHZAcZs=;
 fh=MSgXJWkfX6drgHhltmY4z9M9KmIuQLD56TEjfqsrTC8=;
 b=JDkyI8FMRzWKM4OPgSA4Qrqbg1JQ8vqxeNTPA+/Bc8mPftM/bzTa+mCdHzLwMxC/nR
 bMBJfmrfaRC4SDqy1O2MIpu7CaVQFk+Fjv4dSD7xTLhlvseb/Pg3KsFEvMlJ4SBJrPzU
 W+kRY9scetCO3GiyJW3u84UjtIiZof0m7BUQ2s2kMJ40S2WuNjpq5F2/1R7DOUOA5T+X
 JGt3fLKvleLx0WnGF6Cf83EsLSpfyFUL3026sVIq7po9vhtY2+nUtNdcqVB+PAprBoJp
 Vmq431bppMfK2VKgLIB8/02eboqaEPiIhiMUP4kJ8xGQ38oPcT4KDcc26n/vmlusQLC5
 rgzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789138229; x=1789743029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QAdCGKncc6nuCM3vLvr4PganNkNVOJvdFONhtHZAcZs=;
 b=VOjMTfH5lTfV28Zo+UsJ5r5nO6EkYklblUaaEbbqp2J6ruLPjNMSSNCedmKUQVpfoq
 QAZ94fYkCSjfJHKewK/Zm+CSHG9f+EVhnXF9BwYOYvmnGZ/fq5aUsNOuoWw/8m9VbCd8
 PseW9qKtgpHbLoJf2egHL2vS7XeJeaYatfR487XDtbXKUjPKXIzwlgfSCZKNEBIKjWkO
 pQmfmasvYE52OUn6sbobict5xDcE92F6YhHobd3IznFlinawv793j/jUsUgwnE2O8yT/
 4IJVP24TJy1U0v9gNcCCH0OcjIvoK70OWM/W87352ZuOQu2FwFV8fs2yMZ1Eji6z9z5X
 TPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138229; x=1789743029;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QAdCGKncc6nuCM3vLvr4PganNkNVOJvdFONhtHZAcZs=;
 b=Rb+zQxJvnV8Df4n0P/YgAMGcF/4E8dz5RibjhmB8x9PDSDUqZfQFeDZwHZGY8ZcQj+
 28E8wRnEK+rxkMrho6yP51uMvUwLnKOSylx8aqVWXrcftLS/vG6f9myes/+3M3heiBc5
 vJjIvJXNUIO/GH5j2OIRn9Lxy6TPoWkja2HLqV7Zz6Ob83xiT0u2XOJSIhvfHXBdPM+o
 AHRy/lk9MJuGHE8UF5/EvinVDGe6HFQ3M9UJ6EAgyc2dm2M194bUB3sSoV7eFSmkgxLx
 ZUk4iYRL3x6yRTeb9TuDP1aq2D28UxXAhJgUzcwasao6fqqFNZ6g3J8dvkIU1eF0ZJeR
 FQag==
X-Gm-Message-State: AFuF++nXJAfEKpDbKZYErn51hnHUc2x5wACJczb4Hp8BB7ib03sOcbyn
 YidBgYHusd7n9Adkl78c4pL4duj+GYnoXf5aRCD5JHlYPPDbhQG8mxRYFIFKri6xoZ1TQLQOd8D
 jW3mH/xSHHIUqDyiJaClNG3dV483Vpap5TBDbdp+BJ8CVubotN26QQliFj5cPLoFzQg4AdAXsOb
 sDQJvDmxHeXJz19UXr2vDbRCvhHDBDGlU=
X-Gm-Gg: AYBFou2wupo2MTtKHVANUovK7glvyFB7XFJnjuB+YZYCr4z71V8uC6VGmucTBqY6PIe
 oTBjMHtHlqiF5wFdoJMatUTtON2KzZ5zpBKrmq01I6oPzBIxdNo2GZ3QCrrZo6d/W4Y/a+pSkXN
 QyMsfsq/sppZQ+txI6EGIH4cUxMl4BzWr303ct+woQKvH3I7aFMBLahAOGayzGYw0GnAEiq+pNq
 TBLQQQQn+qohiFsiXIK8wd6GMxsCGjZDEIibpm6zolchyHcsgLd6TrmdQSGAHVROxvI5qMjsTqI
 0A==
X-Received: by 2002:a17:90b:582b:b0:39d:9b53:112a with SMTP id
 98e67ed59e1d1-39d9c378f02mr8660645a91.23.1789138229257; 
 Fri, 11 Sep 2026 07:50:29 -0700 (PDT)
X-Received: by 2002:a17:90b:582b:b0:39d:9b53:112a with SMTP id
 98e67ed59e1d1-39d9c378f02mr8660571a91.23.1789138228696; Fri, 11 Sep 2026
 07:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-5-a985f168e938@redhat.com> <87o6e453or.fsf@pond.sub.org>
In-Reply-To: <87o6e453or.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 18:50:16 +0400
X-Gm-Features: AcwNN1UwuQ-6BWixKc0_z_70tdJ5sDYlTrTsNPageWQb43B99BzXrwCWai8ymQU
Message-ID: <CAMxuvaxF_W6GAM9aV-ssZuY=QsWtBq+6kcy2PK=--GTDM5_RDQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/75] qapi: add type-infos generator
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

Hi

On Fri, Sep 11, 2026 at 5:16=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> I'm reviewing just the documentation right now.  I'll look at the
> remainder later.
>
> Documentation updates are commonly at least as hard as generator
> changes, if not harder.  Please don't be discouraged by my remarks!
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > New QAPISchemaGenTypeInfoVisitor produces per-module
> > qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
> > pairing the QAPI type name with its masked introspection name.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.rst | 107 +++++++++++++++++++++++++-
> >  meson.build                  |   1 +
> >  scripts/qapi/backend.py      |   2 +
> >  scripts/qapi/introspect.py   |   2 +-
> >  scripts/qapi/type_infos.py   | 178 +++++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 285 insertions(+), 5 deletions(-)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index b1cc5b5f0db1..d176238fc2ef 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -1247,10 +1247,10 @@ meaningful type names instead.
>
> This is in section "Client JSON Protocol introspection", which explains
> query-qmp-schema.
>
> A bit more context:
>
>    Command and event names are part of the wire ABI, but type names are
>    not.  Therefore, the SchemaInfo for types have auto-generated
>    meaningless names.  For readability, the examples in this section use
>    meaningful type names instead.
>
> >  Optional member "features" exposes the entity's feature strings as a
> >  JSON array of strings.
> >
> > -To examine a type, start with a command or event using it, then follow
> > -references by name.
> > -
> > -QAPI schema definitions not reachable that way are omitted.
> > +To examine a type used by QMP, start with a command or event using it,
> > +then follow references by name. User-defined and array types are also
> > +included when they are not reachable from a command or event, as they
> > +may also be used by QOM.
>
> The "To examine a type ..." sentence tries to tell readers not to look
> up types by name.  Perhaps we can do without, because how would you even
> do that?  It also prepares for "QAPI schema definitions not reachable
> that way are omitted."  But you delete that.
>
> The deletion should go into "[PATCH 04] qapi: register all
> introspectable types, not just QMP-reachable ones".

done

>
> The final sentence talks about types not reachable from commands or
> events, and hints at QOM use.  I feel the former is a distraction here.
> Regarding the latter: we need to say more about QOM introspection than
> "[types] may also be used by QOM".  Before this series, query-qmp-schema
> is the only QAPI introspection game in town, and this section explains
> it.  Afterwards, there's also qom-list, qom-list-properties,
> qom-list-get.  I fear doing them justice will require some rewriting.
> Maybe just add a FIXME comment for now?

added

>
> Two spaces between sentences for local consistency, please.
>

ok

> >  The SchemaInfo for a command has meta-type "command", and variant
> >  members "arg-type", "ret-type" and "allow-oob".  On the wire, the
> > @@ -2101,3 +2101,102 @@ Example::
> >      }));
> >
> >      [Uninteresting stuff omitted...]
> > +
> > +
> > +Code generated for type information
> > +-----------------------------------
> > +
> > +Type info is generated for user-defined and array types. With option
> > +``--builtins``, it is also generated for built-in types and the intern=
al
> > +``QType`` enum.
>
> QType is also a built-in type.  It isn't reall internal: while it's not
> currently used in the QAPI schema, it it is used outside the QAPI
> subsystem, e.g. in qobject/qobject.h.
>
> > +                Other implicit types are skipped.
>
> The term "implicit type" is not really defined.  It's only mentioned
> under "Client JSON Protocol introspection".  Do we need this sentence?
>
> What about this:
>
>    Type information is generated for user-defined types and their array
>    types.  With option ``--builtins``, it is also generated for the
>    built-in types.
>

ok

> By the way, we don't put `` around --builtins elsewhere.  Should we?

Eventually.. dropped for now

> > +
> > +The following files are created:
> > +
> > + ``$(prefix)qapi-type-infos.c``
> > +     A ``QAPITypeInfo`` instance for each type listed above, providing
> > +     a mapping between the QAPI type name and the masked name used by
> > +     introspection, along with optional enum lookup table and array
> > +     type pointers.
> > +
> > + ``$(prefix)qapi-type-infos.h``
> > +     Declarations for the above type info instances
> > +
> > +Each ``QAPITypeInfo`` struct has the following fields:
> > +
> > +``name``
> > +    The QAPI type name (e.g. ``"UserDefOne"``). QOM uses this as the
> > +    property type string.
>
> Is "QOM uses this" relevant here?
>

It gives some extra context, but I will remove it.

> Permit me a digression.  QAPI introspection masks type names, because
> they're not ABI.  Exposing things not meant to be ABI invites misuse,
> and then misuse becomes accidental ABI.  QOM exposes unmasked type
> names.  I don't like it.
>
> > +
> > +``masked_name``
> > +    For user-defined types, the masked name used in
> > +    ``query-qmp-schema`` output. For array types, the corresponding
> > +    bracketed introspection name. Built-in types use their QAPI name;
>
> It's "the masked name used in query-qmp-schema output" for *all* types,
> not just user-defined types.

ok, I'll use "The masked name used in query-qmp-schema output."

>
> An array's masked name is indeed the element's masked name enclosed in
> brackets, but this document carefully avoids to specify that.  Closest
> we get is this under "Client JSON Protocol introspection":
>
>                                    For convenience, the array's name may
>     resemble the element type; however, clients should examine member
>     "element-type" instead of making assumptions based on parsing member
>     "name".
>
> Let's not specify more.

ok

>
> > +    note that introspection canonicalizes the integer built-in types
> > +    to ``int``.
>
> Yes.  Also under "Client JSON Protocol introspection":
>
>     The QAPI schema supports a number of integer types that only differ i=
n
>     how they map to C.  They are identical as far as SchemaInfo is
>     concerned.  Therefore, they get all mapped to a single type "int" in
>     SchemaInfo.
>
> Do we need to repeat it here?

dropped

>
> > +                Internal types not present in introspection use
> > +    ``NULL``.
>
> Currently only QType.  Could we make that not a special case?
> I.e. .masked_name =3D "QType" like for other built-in types.
>

ok, done

> > +
> > +``lookup``
> > +    For enum types, a pointer to the corresponding ``QEnumLookup``
> > +    table.  ``NULL`` for non-enum types.
> > +
> > +``list``
> > +    For types that have an array variant, a pointer to the array type'=
s
> > +    ``QAPITypeInfo``.  ``NULL`` when no array type exists.
> > +
> > +These type info instances are used by QOM property registration
> > +functions (``object_property_add_qapi()``,
> > +``object_class_property_add_qapi_enum()``, etc.) to associate each
> > +property with its QAPI type.  The ``qom-list`` and
> > +``device-list-properties`` QMP commands then expose the ``qapi-type``
> > +field, giving management tools a formal type reference they can look
> > +up in the introspection schema.
>
> Alright, you talk a bit more about QOM introspection here.  Fine for
> now, but it really needs comprehensive treatment similar to what we do
> for query-qmp-schema.  But we can do that later.
>
> > +
> > +All user-defined and array types are included in introspection, even w=
hen
> > +they are not reachable from a command or event.  Their type info there=
fore
> > +always provides the introspection cross-reference.
>
> I'm not sure I understand this paragraph.  What are you trying to
> convey?

I expressed the motivation: type info allows cross-referencing with
the introspection schema. But I can drop it too.

>
> > +
> > +Example::
> > +
> > +    $ cat qapi-generated/example-qapi-type-infos.h
> > +    [Uninteresting stuff omitted...]
> > +
> > +    #ifndef EXAMPLE_QAPI_TYPE_INFOS_H
> > +    #define EXAMPLE_QAPI_TYPE_INFOS_H
> > +
> > +    #include "qapi/qapi-builtin-type-infos.h"
> > +
> > +    extern const QAPITypeInfo UserDefOne_type_info;
> > +
> > +    extern const QAPITypeInfo UserDefOneList_type_info;
> > +
> > +    #endif /* EXAMPLE_QAPI_TYPE_INFOS_H */
> > +    $ cat qapi-generated/example-qapi-type-infos.c
> > +    [Uninteresting stuff omitted...]
> > +
> > +    const QAPITypeInfo UserDefOne_type_info =3D {
> > +        .name =3D "UserDefOne",
> > +        .masked_name =3D "1",
> > +        .list =3D &UserDefOneList_type_info,
> > +    };
> > +
> > +    const QAPITypeInfo UserDefOneList_type_info =3D {
> > +        .name =3D "UserDefOneList",
> > +        .masked_name =3D "[1]",
> > +    };
> > +
> > +    [Uninteresting stuff omitted...]
>
> For me, it actually generates masked names "0" and "[0]".  Is the
> mapping to masked names stable?

it is not, as you know by design, it depends on registration order

>
> > +
> > +For a modular QAPI schema (see section `Include directives`_), code fo=
r
> > +each sub-module SUBDIR/SUBMODULE.json is actually generated into ::
> > +
> > + SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.h
> > + SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.c
> > +
> > +If qapi-gen.py is run with option --builtins, additional files are
> > +created:
> > +
> > + ``qapi-builtin-type-infos.h``
> > +     Type info instances for built-in types
> > +
> > + ``qapi-builtin-type-infos.c``
> > +     Definitions for the above type info instances
>
> [...]
>


