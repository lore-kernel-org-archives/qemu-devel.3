Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A2AC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuPM8-0000cZ-Ad; Thu, 13 Aug 2026 02:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuPM3-0000Zz-M1
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuPLz-0006QD-PD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786604149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OeC+DnIXCtvYDxO9rGSs/Cdw7aoQXpY6Q3CZiFkm1gE=;
 b=SP/uEZXwxjVKEA2DxUQ6Av0nmnjIhsBW/KKpzn7UUKWqMOgyrviVGjx3jGXAT2T0FB7/PR
 R7ivIPDil+UECdH3quU3TT68XGcWwJPtaX+lXYt4mOapYcCr+9b2yvyb8VGNsQmFJKLP/y
 U86HPyQNL1ECZFqIeeOljst+uFsoAFs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-SR-EHHCBM6OZqRCMavwKaQ-1; Thu, 13 Aug 2026 02:55:47 -0400
X-MC-Unique: SR-EHHCBM6OZqRCMavwKaQ-1
X-Mimecast-MFC-AGG-ID: SR-EHHCBM6OZqRCMavwKaQ_1786604146
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso1452505a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 23:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786604146; cv=none;
 d=google.com; s=arc-20260327;
 b=JJp5BrTTbCYlxHRMhCEi3v014pUZ5OVIRe4IYaarfW/5sgK2ZZQD6lMNlZ4T/KW1sO
 hm69/LjBK/1m51EhxticuBrW2RZDkDOpB5EBgpO+DVmBeGlFj5wYXPQ/WuKpQkUnWDrA
 xCXX+0OHMzrPALJyOifJI4HYyMzepVBsyCmCenoYKTai1NXL1e64NZljvFwXvMnF6Sfi
 wdnXOPjAwA7GTvk9z5wWjYYFWx0kC4JopytsPAT2h7Fn+J5vnGqD8Sb/nLHZUfgZcNm8
 shtFonZIHcGMSUP4P1OeUyfhwb6gLFFnwjuY0AmbsKaR3ex13pFuMScdcPo0JmTe7DgI
 1djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OeC+DnIXCtvYDxO9rGSs/Cdw7aoQXpY6Q3CZiFkm1gE=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=moNty3p5dDl5vQGOneKimwvd8QM0WlTrP/UbYdx7PakyC0tQ74CPaKrd6oMMl5jFQL
 k0h473bBwi0nze7Uuayld/a2HRfGMSmS8Qkvk4KO/ficN+gyFz2atI7aIUoaIquq8mj/
 TIk+SsYQgbX4MxbPNPvF7vBY+TP7K9cCaOLwJbZo8JjBxY0RzWifuZdrlzY8HJdnDOMF
 vVjPIO7WXTLexeagJJ/yqPS1YVpTZF1spVK1zPNQdF8mBKBo0irBngF5FqhOYYsdplkP
 /Ps5s7Le1QKPGybfN2C27rUfqfICttZG8W6S4tOZqU2GIWQilZfi3J2IsZhHZar15wMW
 6+Jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786604146; x=1787208946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OeC+DnIXCtvYDxO9rGSs/Cdw7aoQXpY6Q3CZiFkm1gE=;
 b=VPtHXRVNNoEJpLlHliRBFzefjhptyomaXSQnZc5JuNYqWlQk5YdH6/AZCSgRZvdIZq
 cHbq06nbn33Qb2V4c4g+UOg4nXPBpd5/C/E+Ivp7NZVTlkUwZt8fGvcaGpEZnv9iwx3N
 P3baQkrgOjZ7YT6tW4isr7pKHlG51RPsT9jbmvQt9uTXjks2EpcommkdgM3AwwSA1e2y
 EtkXfmFfWqdPTOdMA3BWx+GSrWgNFdQ6VRK/+avniKUT9wCW0Rqk2j9TkWVdm4qstA3r
 kQpOa1ofZ6X79iRzrZU58sj0y/9sH+h1n2Q6qWr55C1t0VJ9ODJGeZ7GjklFPIqz1Fgp
 q81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604146; x=1787208946;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OeC+DnIXCtvYDxO9rGSs/Cdw7aoQXpY6Q3CZiFkm1gE=;
 b=jNyNdKhtv9aEmAybj3qnEITWMRJ9M4SiknJ5eHjOI+xRCQTlJwW0y07GuZ2eEzIKaa
 OCigaulrENHXzWEDXTj/zWrgy6BWZWGBaIPN8MIgttLyjyEccQtor95yms8KQKvmuqcT
 t1WI+H5AcVMSUulywEzlHenQtXXC6pkDiqtkjSeIHtnLMFNuapzRbElmdLPK8Bs07dHG
 xtJwIF6bJVLkt3IkGf5Psybjggq9K+zOZAXELpk3Thmht1BLZvYFrofmp7v0a0HIhdlt
 q0eVBimzOe4dGISTGDGFqOoYjsD8AJuj0L0b0jU6bU797y9RHDNVvh+tBHFIKMz+7S4n
 Sylw==
X-Gm-Message-State: AOJu0YxcKQ32QVvaCmS/7AHMxd6fHb91zqD82EqA7EspLCEKulXnKLB8
 NMNby88d4QeFlQbDzwxd9Cj7KlJEBQ+fqak3oq3e7ND41FOvh7KGb93e+iGTMCic5edfuObKuHw
 QQaHLTp6iPTnpUjYvIiHk6rZxOFvAIkwQxNOoJq71wm/Prqao8bqt1wJKB3UXhjwmk+HYEoZNHO
 QcnqQPr2jqKM/JqRacLuelxEbwjcQr3fc=
X-Gm-Gg: AR+sD10nAdK9JfKGkBHnpBAoBW1imn6BJ7BxSED6T1NTHpYhdsAfaNyXV9NVxsFaLIf
 l54qghMamjHkskxKiQ5Lv/LAbzNavbex/oSkyu1zv/qH5G77xPuA1CPELLAAuup6fLyq3oEAzze
 zKUlSu+8I8gZVi4VgrgA8+UK3w2NvJKlrbPYFOokW/CE0gtB9DI+nR892hm5wkrf4KWP1AniK4p
 uNK06yTj1BDt33+krDHHbih+6oFqoWUx/6ce+EZ+ok/F2dcPrntCDdrQKvejh8VI8QqXKxqwrPQ
 jA==
X-Received: by 2002:a05:6a21:e0a2:b0:3cc:3d08:da2b with SMTP id
 adf61e73a8af0-3cc5503a46dmr4954100637.15.1786604146293; 
 Wed, 12 Aug 2026 23:55:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:e0a2:b0:3cc:3d08:da2b with SMTP id
 adf61e73a8af0-3cc5503a46dmr4954047637.15.1786604145757; Wed, 12 Aug 2026
 23:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-3-cc9396b9c18c@redhat.com> <87zeyztkcs.fsf@pond.sub.org>
In-Reply-To: <87zeyztkcs.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 10:55:31 +0400
X-Gm-Features: AUfX_myDtune3dxeFB4N1UGBZgubGfSJEIuhGFFWhPSidWRsCUEsUtUj1OlFN-k
Message-ID: <CAMxuvazV=Fq6kYQ_1iPrLUHHxF2CwYTd7EbHnE-W5csT-pOsgQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/53] qapi: add type-infos generator
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Hi

On Thu, Aug 6, 2026 at 6:06=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > New QAPISchemaGenTypeInfoVisitor produces per-module
> > qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
> > pairing the QAPI type name with its masked introspection name.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  docs/devel/qapi-code-gen.rst |  90 +++++++++++++++++++++
> >  meson.build                  |   1 +
> >  scripts/qapi/type_infos.py   | 182 +++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 273 insertions(+)
> >
> > diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rs=
t
> > index 3a632b4a648..bb2e8d9c675 100644
> > --- a/docs/devel/qapi-code-gen.rst
> > +++ b/docs/devel/qapi-code-gen.rst
> > @@ -2103,3 +2103,93 @@ Example::
> >      }));
> >
> >      [Uninteresting stuff omitted...]
> > +
> > +
> > +Code generated for type information
> > +-----------------------------------
> > +
> > +The following files are created:
> > +
> > + ``$(prefix)qapi-type-infos.c``
> > +     A ``QAPITypeInfo`` instance for each schema-defined type, providi=
ng
> > +     a mapping between the C type name and the schema name used by
> > +     introspection, along with optional enum lookup table and list-ele=
ment
> > +     pointers.
> > +
> > + ``$(prefix)qapi-type-infos.h``
> > +     Declarations for the above type info instances
> > +
> > +Each ``QAPITypeInfo`` struct has the following fields:
> > +
> > +``name``
> > +    The C identifier of the type (e.g. ``"UserDefOne"``).
>
> Isn't this the name used in the QAPI schema source?

correct

>
> > +
> > +``schema_name``
> > +    The masked name used in ``query-qmp-schema`` output, or ``NULL``
> > +    for built-in types whose schema name equals their C name.  This
> > +    allows management tools to cross-reference a QOM property's
> > +    ``qapi-type`` against the introspection schema.
>
> I believe it can also be null when query-qmp-schema omits the type.
> More on that below.

Yes, that's a current limitation. Only types reachable from QMP are in
the introspection schema. I will try to address this

>
> > +
> > +``lookup``
> > +    For enum types, a pointer to the corresponding ``QEnumLookup``
> > +    table.  ``NULL`` for non-enum types.
> > +
> > +``list``
> > +    For types that have an array variant, a pointer to the list type's
> > +    ``QAPITypeInfo``.  ``NULL`` when no list type exists.
>
> Confusing mix of "array" and "list" in the same sentence.  Suggest "the
> array type's".
>
> QAPI can't decide whether to call the thing an array (like JSON) or a
> list (like the C implementation).  Unfortunate.
> docs/devel/qapi-code-gen.rst generally sticks to array, but there are a
> few lapses.

fixed

>
> > +
> > +These type info instances are used by QOM property registration
> > +functions (``object_property_add_qapi()``,
> > +``object_class_property_add_qapi_enum()``, etc.) to associate each
> > +property with its QAPI schema type.
>
> You're using "schema type" like you do above, i.e. for the masked type
> name.  Correct?

I mean the type in general

>
> >                                       The ``qom-list`` and
> > +``device-list-properties`` QMP commands then expose the ``qapi-type``
> > +field, giving management tools a formal type reference into the
> > +introspection schema.
>
> As far as I understand, we connect a property of QAPI type to the type's
> QAPITypeInfo, the commands you mentioned then use it to emit the masked
> type name, so that management applications can use that to find a
> property's type in the output of query-qmp-schema.
>
> Problem (already discussed elsewhere): only works when the type is used
> in QMP.  If it isn't, we still have QAPITypeInfo, but its .schema_name
> is null.  This needs to be documented as a known shortcoming.

ok

>
> Other uses of QAPITypeInfo may emerge in the future.  We might also
> replace it by something that supports additional uses; see my ramblings
> in review of PATCH 01.  In this series, however, connecting QOM
> properties to their masked QAPI type name is their only use.  I
> understand we emit QAPITypeInfo for any QAPI type that could be used as
> QOM property type.  Dead data unless it is actually used as QOM property
> type.  This is acceptable; we already generate similarly dead visitors.
> But it's worth mentioning in the commit message, I think.
>
> > +
> > +Implicit types (names starting with ``q_``) are skipped.
>
> This isn't quite correct.  Array types are also implicitly defined, and
> their names don't start with 'q_'.
>
> Possible fixes:
>
> * Drop the sentence (only if we believe it's not needed)
>
> * Drop the parenthesis, add "other than arrays" or something like that.
>
> * Positive instead of negative: only user-defined and built-in types.
>   This could perhaps be worked into the text under "The following files
>   are created".  May want to add why: only these may be used as property
>   types.

rephrased, thanks

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
> > +        .schema_name =3D "1",
> > +        .list =3D &UserDefOneList_type_info,
> > +    };
> > +
> > +    const QAPITypeInfo UserDefOneList_type_info =3D {
> > +        .name =3D "UserDefOneList",
> > +        .schema_name =3D "[1]",
> > +    };
> > +
> > +    [Uninteresting stuff omitted...]
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
> > diff --git a/meson.build b/meson.build
> > index 19e123423b5..f135eddad12 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3487,6 +3487,7 @@ qapi_gen_depends =3D [ meson.current_source_dir()=
 / 'scripts/qapi/__init__.py',
> >                       meson.current_source_dir() / 'scripts/qapi/parser=
.py',
> >                       meson.current_source_dir() / 'scripts/qapi/schema=
.py',
> >                       meson.current_source_dir() / 'scripts/qapi/source=
.py',
> > +                     meson.current_source_dir() / 'scripts/qapi/type_i=
nfos.py',
> >                       meson.current_source_dir() / 'scripts/qapi/types.=
py',
> >                       meson.current_source_dir() / 'scripts/qapi/visit.=
py',
> >                       meson.current_source_dir() / 'scripts/qapi-gen.py=
'
> > diff --git a/scripts/qapi/type_infos.py b/scripts/qapi/type_infos.py
> > new file mode 100644
> > index 00000000000..dc7e2bace9e
> > --- /dev/null
> > +++ b/scripts/qapi/type_infos.py
>
> Please use '-' instead of '_' in filenames for local consistency.

It has to use _ for import, afaik

>
> > @@ -0,0 +1,182 @@
> > +"""
> > +QAPI type info generator
> > +
> > +SPDX-License-Identifier: GPL-2.0-or-later
> > +"""
> > +
> > +from typing import (
> > +    Dict,
> > +    List,
> > +    Optional,
> > +    Set,
> > +)
> > +
> > +from .common import c_name, mcgen
> > +from .gen import QAPISchemaModularCVisitor, ifcontext
> > +from .schema import (
> > +    QAPISchema,
> > +    QAPISchemaAlternatives,
> > +    QAPISchemaBranches,
> > +    QAPISchemaEnumMember,
> > +    QAPISchemaFeature,
> > +    QAPISchemaIfCond,
> > +    QAPISchemaObjectType,
> > +    QAPISchemaObjectTypeMember,
> > +    QAPISchemaType,
> > +    QAPISchemaVisitor,
> > +)
> > +from .source import QAPISourceInfo
> > +
> > +
> > +class _ArrayTypeCollector(QAPISchemaVisitor):
> > +    def __init__(self) -> None:
> > +        self.list_types: Set[str] =3D set()
> > +
> > +    def visit_array_type(self,
> > +                         name: str,
> > +                         info: Optional[QAPISourceInfo],
> > +                         ifcond: QAPISchemaIfCond,
> > +                         element_type: QAPISchemaType) -> None:
> > +        self.list_types.add(name)
> > +
> > +
> > +class QAPISchemaGenTypeInfoVisitor(QAPISchemaModularCVisitor):
> > +
> > +    def __init__(self, prefix: str, name_map: Dict[str, str],
> > +                 list_types: Set[str]):
> > +        super().__init__(
> > +            prefix, 'qapi-type-infos',
> > +            ' * Schema-defined QAPI type info',
> > +            ' * Built-in QAPI type info', __doc__)
> > +        self._name_map =3D name_map
> > +        self._list_types =3D list_types
> > +
> > +    def _begin_builtin_module(self) -> None:
> > +        self._genc.preamble_add(mcgen('''
> > +#include "qemu/osdep.h"
> > +#include "qapi/qapi-builtin-types.h"
> > +#include "qapi/qapi-builtin-type-infos.h"
> > +'''))
> > +        self._genh.preamble_add(mcgen('''
> > +#include "qapi/qapi-type-info.h"
> > +'''))
> > +
> > +    def _begin_user_module(self, name: str) -> None:
> > +        type_infos =3D self._module_basename('qapi-type-infos', name)
> > +        types =3D self._module_basename('qapi-types', name)
> > +        self._genc.preamble_add(mcgen('''
> > +#include "qemu/osdep.h"
> > +#include "%(types)s.h"
> > +#include "%(type_infos)s.h"
> > +''',
> > +                                      types=3Dtypes,
> > +                                      type_infos=3Dtype_infos))
> > +        self._genh.preamble_add(mcgen('''
> > +#include "qapi/qapi-builtin-type-infos.h"
> > +'''))
> > +
> > +    def _gen_type_info(self, name: str,
> > +                       ifcond: Optional[QAPISchemaIfCond] =3D None,
> > +                       with_lookup: bool =3D False,
> > +                       with_list: bool =3D False,
> > +                       schema_name: Optional[str] =3D None) -> None:
> > +        c_id =3D c_name(name + '_type_info')
> > +        lookup =3D ''
> > +        if with_lookup:
> > +            lookup =3D mcgen('''
> > +    .lookup =3D &%(c_name)s_lookup,
> > +''',
> > +                           c_name=3Dc_name(name))
> > +        list_ref =3D ''
> > +        if with_list:
> > +            list_ref =3D mcgen('''
> > +    .list =3D &%(list_id)s,
> > +''',
> > +                             list_id=3Dc_name(name + 'List_type_info')=
)
> > +        if schema_name is None:
> > +            masked =3D self._name_map.get(name)
> > +            schema_name =3D '"%s"' % masked if masked is not None else=
 'NULL'
> > +        else:
> > +            schema_name =3D '"%s"' % schema_name
> > +        with ifcontext(ifcond or QAPISchemaIfCond(),
> > +                       self._genh, self._genc):
> > +            self._genh.add(mcgen('''
> > +
> > +extern const QAPITypeInfo %(c_id)s;
> > +''',
> > +                                 c_id=3Dc_id))
> > +            self._genc.add(mcgen('''
> > +
> > +const QAPITypeInfo %(c_id)s =3D {
> > +    .name =3D "%(name)s",
> > +    .schema_name =3D %(schema_name)s,
> > +%(lookup)s%(list_ref)s};
>
> This substitutes values of mcgen() into mcgen().  That's not how it
> wants to be used.  Please ...
>
> > +''',
> > +                                 c_id=3Dc_id, name=3Dname,
> > +                                 schema_name=3Dschema_name,
> > +                                 lookup=3Dlookup,
> > +                                 list_ref=3Dlist_ref))
>
> ... try something like
>
>                self._genh.add(mcgen('''
>
>    extern const QAPITypeInfo %(c_id)s;
>    ''',
>                                     c_id=3Dc_id))
>                self._genc.add(mcgen('''
>
>    const QAPITypeInfo %(c_id)s =3D {
>        .name =3D "%(name)s",
>        .schema_name =3D %(schema_name)s,
>    ''',
>                                     c_id=3Dc_id, name=3Dname,
>                                     schema_name=3Dschema_name))
>
>                if with_lookup:
>                    self._genc.add(mcgen('''
>        .lookup =3D &%(c_name)s_lookup,
>    ''',
>                               c_name=3Dc_name(name))
>
> and so forth.

ok

>
> > +
> > +    def _has_list(self, name: str) -> bool:
> > +        return name + 'List' in self._list_types
>
> Simpler, I think:
>
>            return self._schema.lookup_type(name + 'List')
>
> where self._schema is set in .visit_begin().

ok

>
> > +
> > +    def visit_builtin_type(self,
> > +                           name: str,
> > +                           info: Optional[QAPISourceInfo],
> > +                           json_type: str) -> None:
> > +        self._gen_type_info(name, with_list=3Dself._has_list(name))
> > +
> > +    def visit_enum_type(self,
> > +                        name: str,
> > +                        info: Optional[QAPISourceInfo],
> > +                        ifcond: QAPISchemaIfCond,
> > +                        features: List[QAPISchemaFeature],
> > +                        members: List[QAPISchemaEnumMember],
> > +                        prefix: Optional[str]) -> None:
> > +        self._gen_type_info(name, ifcond, with_lookup=3DTrue,
> > +                            with_list=3Dself._has_list(name))
> > +
> > +    def visit_object_type(self,
> > +                          name: str,
> > +                          info: Optional[QAPISourceInfo],
> > +                          ifcond: QAPISchemaIfCond,
> > +                          features: List[QAPISchemaFeature],
> > +                          base: Optional[QAPISchemaObjectType],
> > +                          members: List[QAPISchemaObjectTypeMember],
> > +                          branches: Optional[QAPISchemaBranches]) -> N=
one:
> > +        if name.startswith('q_'):
>
> Duplicates QAPISchemaObjectType.is_implicit().  Similar code in types.py
> and visit.py.  Not this patch's fault; moving on.
>
> > +            return
> > +        self._gen_type_info(name, ifcond,
> > +                            with_list=3Dself._has_list(name))
> > +
> > +    def visit_array_type(self,
> > +                         name: str,
> > +                         info: Optional[QAPISourceInfo],
> > +                         ifcond: QAPISchemaIfCond,
> > +                         element_type: QAPISchemaType) -> None:
> > +        elem_schema =3D self._name_map.get(element_type.name,
> > +                                         element_type.name)
> > +        self._gen_type_info(name, ifcond,
> > +                            schema_name=3D'[' + elem_schema + ']')
> > +
> > +    def visit_alternate_type(self,
> > +                             name: str,
> > +                             info: Optional[QAPISourceInfo],
> > +                             ifcond: QAPISchemaIfCond,
> > +                             features: List[QAPISchemaFeature],
> > +                             alternatives: QAPISchemaAlternatives) -> =
None:
> > +        self._gen_type_info(name, ifcond,
> > +                            with_list=3Dself._has_list(name))
> > +
> > +
> > +def gen_type_infos(schema: QAPISchema,
> > +                   output_dir: str,
> > +                   prefix: str,
> > +                   opt_builtins: bool,
> > +                   name_map: Dict[str, str]) -> None:
> > +    collector =3D _ArrayTypeCollector()
> > +    schema.visit(collector)
> > +    vis =3D QAPISchemaGenTypeInfoVisitor(prefix, name_map,
> > +                                       collector.list_types)
> > +    schema.visit(vis)
> > +    vis.write(output_dir, opt_builtins)
>


