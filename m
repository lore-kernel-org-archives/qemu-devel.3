Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4688C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 04:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgG8S-00012V-Vp; Thu, 06 Feb 2025 23:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tgG8R-00012F-86
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tgG8N-0006hU-Fd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738903108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTqvCvc5SQTL4VkxerRjFucnt+oPBX7dnmnTa1tffC4=;
 b=SSmD7Xt2Fk1dENkhgonk5uNqFB8k15UPtbkglWZ/YKuKTCLgMJ2/uCb06SnmaX/+s7xirt
 CFWxlzc6YP2qxPVgKveiqoUWf+pNPNnXoEJztah3vOPLQtTHZGcTyUOjn/3lxPEm5q9Rkl
 KJwQ+UKfdP2u+tJeoTo/y2OVQtVRYJc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-sl1m4Hr1NrOXLPxpxjzrlA-1; Thu, 06 Feb 2025 23:38:26 -0500
X-MC-Unique: sl1m4Hr1NrOXLPxpxjzrlA-1
X-Mimecast-MFC-AGG-ID: sl1m4Hr1NrOXLPxpxjzrlA
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fa166cf693so3494909a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 20:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738903105; x=1739507905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mTqvCvc5SQTL4VkxerRjFucnt+oPBX7dnmnTa1tffC4=;
 b=JqhAFBDVs8TcAGCQzqncwqAlA8jxbIqAUsXScOsCMgRHQ6D9V5bMy4swX3d53dC2sG
 TTr1Npba0sW478m6FQLFuDPx2HxMn5iTYOIWDJhs+n2oCHfk3aW9xCCz9+iJsRMTfzrm
 J0OlF/cHLWHa5Na8gtf3vMplx/MkgTDTgvFKsU6YRIYW/TsT0CXhoB/WbMVcUcc1qL+J
 QzZPyWj134m8Mzrg7S1EW1BLGrSO9zaDOMLf295ltDYByWr9p9di5/cGJOQFqQ0TwaEy
 gA+KYu8/uHcxraPHjqjdKKcVijWzSFaQYqJf3JxeljK4fDVkjlzT44//H2E8KdAk0MLN
 c7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrhDHmTdIDCBw6KGbzwpZojDujcGvIbHIayFcCFICLgSqOzw2VqzqLAyydsnzFB5r+aSoSAYccwEKh@nongnu.org
X-Gm-Message-State: AOJu0YwvFENLJuPKIMDZzn8eYf+gFEvRmhIaQmpaCwvAoYox4gPO+B7E
 Rp6in8aKZXhvvmDZlHzbk0Dw5n29i8X6Bc4U1H7LtK1vpCDFFBMT8cdZas8rKWXLJKuVjqVq9p/
 o6wKaLkY92N9IGHOXHHl/q9ahvmGtk8bHlTMA868CjUqYR4p7AmLgIRvDhmdFubhEMXVAmG0b2g
 /t39MFakGQdWzJ2fZB+/+MUQGhcBI=
X-Gm-Gg: ASbGnct5QSHYseuTMkk6bxGBVxEIKtjbhAibZwl/iFaqH8qUu3NhBAHIaO78/kvYkj8
 NZA0SCGbwb3oUVndH8FCKHhjiu/JXKeq6QzuuBV85loNf3LE0Gh7myXJ4hU6keVIEzmUzGFYsCr
 2pM/lgOpb1qemW0YUF9Q==
X-Received: by 2002:a17:90b:4fc6:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2fa23f55112mr2693050a91.1.1738903105340; 
 Thu, 06 Feb 2025 20:38:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjYmNqPy/ZRugeK59WlH3pk2GTjZjeoK+FPiIdglKhu3ud7z1jnPgR8uv9vutQ9fK3vMx1dcprNhxYTw6ul9Q=
X-Received: by 2002:a17:90b:4fc6:b0:2ee:db1a:2e3c with SMTP id
 98e67ed59e1d1-2fa23f55112mr2693014a91.1.1738903104824; Thu, 06 Feb 2025
 20:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20241212110616.3147676-1-berrange@redhat.com>
 <20241212110616.3147676-5-berrange@redhat.com>
 <87jzabm8ae.fsf@pond.sub.org>
In-Reply-To: <87jzabm8ae.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 6 Feb 2025 23:38:13 -0500
X-Gm-Features: AWEUYZlOwSg_1Jo9_ST0phKEa4AYoZAzbZUOcFvpiLa2dfCshEorGlzx-iTCTNE
Message-ID: <CAFn=p-Y4RXP395Kjc4ZnSWuEjn-Vr7YuVEtGAOsWse74pkqvCw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] qapi: expose all schema features to code
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000dcc07d062d85ed7f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000dcc07d062d85ed7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 8:18=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Cc: John Snow for Python typing expertise.
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > This replaces use of the constants from the QapiSpecialFeatures
> > enum, with constants from the auto-generate QapiFeatures enum
> > in qapi-features.h
> >
> > The 'deprecated' and 'unstable' features still have a little bit of
> > special handling, being force defined to be the 1st + 2nd features
> > in the enum, regardless of whether they're used in the schema. This
> > retains compatibility with common code that references the features
> > via the QapiSpecialFeatures constants.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  meson.build                              |  1 +
> >  scripts/qapi/commands.py                 |  1 +
> >  scripts/qapi/features.py                 | 51 ++++++++++++++++++++++++
> >  scripts/qapi/gen.py                      |  6 +--
> >  scripts/qapi/main.py                     |  2 +
> >  scripts/qapi/schema.py                   | 30 +++++++++++++-
> >  scripts/qapi/types.py                    |  7 +++-
> >  scripts/qapi/visit.py                    |  3 +-
> >  tests/meson.build                        |  2 +
> >  tests/qapi-schema/features-too-many.err  |  2 +
> >  tests/qapi-schema/features-too-many.json | 13 ++++++
> >  tests/qapi-schema/features-too-many.out  |  0
> >  tests/qapi-schema/meson.build            |  1 +
> >  13 files changed, 112 insertions(+), 7 deletions(-)
> >  create mode 100644 scripts/qapi/features.py
> >  create mode 100644 tests/qapi-schema/features-too-many.err
> >  create mode 100644 tests/qapi-schema/features-too-many.json
> >  create mode 100644 tests/qapi-schema/features-too-many.out
> >
> > diff --git a/meson.build b/meson.build
> > index 147097c652..3815878b23 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3444,6 +3444,7 @@ qapi_gen_depends =3D [ meson.current_source_dir()=
 /
> 'scripts/qapi/__init__.py',
> >                       meson.current_source_dir() /
> 'scripts/qapi/schema.py',
> >                       meson.current_source_dir() /
> 'scripts/qapi/source.py',
> >                       meson.current_source_dir() /
> 'scripts/qapi/types.py',
> > +                     meson.current_source_dir() /
> 'scripts/qapi/features.py',
> >                       meson.current_source_dir() /
> 'scripts/qapi/visit.py',
> >                       meson.current_source_dir() / 'scripts/qapi-gen.py=
'
> >  ]
> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> > index d629d2d97e..bf88bfc442 100644
> > --- a/scripts/qapi/commands.py
> > +++ b/scripts/qapi/commands.py
> > @@ -355,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
> >  #include "qemu/osdep.h"
> >  #include "%(prefix)sqapi-commands.h"
> >  #include "%(prefix)sqapi-init-commands.h"
> > +#include "%(prefix)sqapi-features.h"
> >
> >  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
> >  {
> > diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> > new file mode 100644
> > index 0000000000..f32f9fe5f4
> > --- /dev/null
> > +++ b/scripts/qapi/features.py
> > @@ -0,0 +1,51 @@
> > +"""
> > +QAPI features generator
> > +
> > +Copyright 2024 Red Hat
> > +
> > +This work is licensed under the terms of the GNU GPL, version 2.
> > +# See the COPYING file in the top-level directory.
> > +"""
> > +
> > +from typing import Dict
> > +
> > +from .common import c_enum_const, c_name
> > +from .gen import QAPISchemaMonolithicCVisitor
> > +from .schema import (
> > +    QAPISchema,
> > +    QAPISchemaFeature,
> > +)
> > +
> > +
> > +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
> > +
> > +    def __init__(self, prefix: str):
> > +        super().__init__(
> > +            prefix, 'qapi-features',
> > +            ' * Schema-defined QAPI features',
> > +            __doc__)
> > +
> > +        self.features: Dict[str, QAPISchemaFeature] =3D {}
> > +
> > +    def visit_begin(self, schema: QAPISchema) -> None:
> > +        self.features =3D schema.features()
>
> Inconsistent type hints:
>
>     $ mypy --config-file scripts/qapi/mypy.ini scripts/qapi-gen.py
>     scripts/qapi/schema.py:1164: error: Incompatible return value type
> (got "dict_values[str, QAPISchemaFeature]", expected
> "List[QAPISchemaFeature]")  [return-value]
>     scripts/qapi/features.py:31: error: Incompatible types in assignment
> (expression has type "List[QAPISchemaFeature]", variable has type
> "Dict[str, QAPISchemaFeature]")  [assignment]
>
> We've been working towards having the build run mypy, but we're not
> there, yet.  Sorry for the inconvenience!
>
> schema.features() returns .values(), i.e. a view object.
>
> I guess the type hint should be ValuesView[QAPISchemaFeature], both for
> type type of attribute .features above, and for the return type of
> method .features() below.  John?
>

It's probably easiest to just use list(...) in the return and then use
List[T] anywhere it matters. The values view type is "kind of, but not
actually a list" because it isn't mutable. It is, however, an
Iterable/Sequence. You can either convert it to a list or make the typing
more abstract.

(Rule of thumb: return types should be as specific as possible, input types
should be as abstract as possible.)

I apologize for this format of relaying patches as it is against the blood
oath I swore as a maintainer, but it's late in my day, forgive me:
https://gitlab.com/jsnow/qemu/-/commits/dan-fixup

That branch has two things in it:

(1) patches to make the python/ tests check the qapi module. This means the
"make check-minreqs" test you can run from python/ will be run by the
GitLab pipelines. You can also run "make check-tox" manually, or run the
optional python-tox test from the pipeline dashboard.

(2) two fixups for linting problems with this series with my s-o-b; feel
free to steal them if they're good enough for you.

Thank you for your patience,
--js


>
> Tentative fixup appended.
>
> > +        self._genh.add("#include \"qapi/util.h\"\n\n")
> > +
> > +    def visit_end(self) -> None:
> > +        self._genh.add("typedef enum {\n")
> > +        for f in self.features:
> > +            self._genh.add(f"    {c_enum_const('qapi_feature', f.name
> )}")
> > +            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
> > +                self._genh.add(f" =3D {c_enum_const('qapi', f.name)},\=
n")
>
> More type confusion here:
>
>     scripts/qapi/features.py:37: error: "str" has no attribute "name"
> [attr-defined]
>     scripts/qapi/features.py:38: error: "str" has no attribute "name"
> [attr-defined]
>     scripts/qapi/features.py:39: error: "str" has no attribute "name"
> [attr-defined]
>
> My fixup takes care of these, too.
>
> > +            else:
> > +                self._genh.add(",\n")
> > +
> > +        self._genh.add("} " + c_name('QapiFeature') + ";\n")
> > +
> > +
> > +def gen_features(schema: QAPISchema,
> > +                 output_dir: str,
> > +                 prefix: str) -> None:
> > +    vis =3D QAPISchemaGenFeatureVisitor(prefix)
> > +    schema.visit(vis)
> > +    vis.write(output_dir)
> > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> > index b51f8d955e..d3c56d45c8 100644
> > --- a/scripts/qapi/gen.py
> > +++ b/scripts/qapi/gen.py
> > @@ -42,9 +42,9 @@
> >
> >
> >  def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
> > -    featenum =3D [f"1u << {c_enum_const('qapi', feat.name)}"
> > -                for feat in features if feat.is_special()]
> > -    return ' | '.join(featenum) or '0'
> > +    feats =3D [f"1u << {c_enum_const('qapi_feature', feat.name)}"
> > +             for feat in features]
> > +    return ' | '.join(feats) or '0'
> >
> >
> >  class QAPIGen:
> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index 316736b6a2..2b9a2c0c02 100644
> > --- a/scripts/qapi/main.py
> > +++ b/scripts/qapi/main.py
> > @@ -18,6 +18,7 @@
> >  from .introspect import gen_introspect
> >  from .schema import QAPISchema
> >  from .types import gen_types
> > +from .features import gen_features
> >  from .visit import gen_visit
> >
> >
> > @@ -49,6 +50,7 @@ def generate(schema_file: str,
> >
> >      schema =3D QAPISchema(schema_file)
> >      gen_types(schema, output_dir, prefix, builtins)
> > +    gen_features(schema, output_dir, prefix)
> >      gen_visit(schema, output_dir, prefix, builtins)
> >      gen_commands(schema, output_dir, prefix, gen_tracing)
> >      gen_events(schema, output_dir, prefix)
> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> > index e97c978d38..39c91af245 100644
> > --- a/scripts/qapi/schema.py
> > +++ b/scripts/qapi/schema.py
> > @@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) ->
> None:
> >  class QAPISchemaFeature(QAPISchemaMember):
> >      role =3D 'feature'
> >
> > +    # Features which are standardized across all schemas
> > +    SPECIAL_NAMES =3D ['deprecated', 'unstable']
> > +
> >      def is_special(self) -> bool:
> > -        return self.name in ('deprecated', 'unstable')
> > +        return self.name in QAPISchemaFeature.SPECIAL_NAMES
> >
> >
> >  class QAPISchemaObjectTypeMember(QAPISchemaMember):
> > @@ -1138,6 +1141,16 @@ def __init__(self, fname: str):
> >          self._entity_list: List[QAPISchemaEntity] =3D []
> >          self._entity_dict: Dict[str, QAPISchemaDefinition] =3D {}
> >          self._module_dict: Dict[str, QAPISchemaModule] =3D OrderedDict=
()
> > +        # NB, values in the dict will identify the first encountered
> > +        #     usage of a named feature only
> > +        self._feature_dict: Dict[str, QAPISchemaFeature] =3D OrderedDi=
ct()
> > +
> > +        # All schemas get the names defined in the QapiSpecialFeature
> enum.
> > +        # Use of OrderedDict ensures they are emitted first when
> generating
> > +        # the enum definition, thus matching QapiSpecialFeature.
> > +        for f in QAPISchemaFeature.SPECIAL_NAMES:
> > +            self._feature_dict[f] =3D QAPISchemaFeature(f, None)
> > +
> >          self._schema_dir =3D os.path.dirname(fname)
> >          self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
> >          self._make_module(fname)
> > @@ -1147,6 +1160,9 @@ def __init__(self, fname: str):
> >          self._def_exprs(exprs)
> >          self.check()
> >
> > +    def features(self) -> List[QAPISchemaFeature]:
> > +        return self._feature_dict.values()
>
> See typing trouble above.
>
> > +
> >      def _def_entity(self, ent: QAPISchemaEntity) -> None:
> >          self._entity_list.append(ent)
> >
> > @@ -1258,6 +1274,12 @@ def _make_features(
> >      ) -> List[QAPISchemaFeature]:
> >          if features is None:
> >              return []
> > +
> > +        for f in features:
> > +            feat =3D QAPISchemaFeature(f['name'], info)
> > +            if feat.name not in self._feature_dict:
> > +                self._feature_dict[feat.name] =3D feat
> > +
> >          return [QAPISchemaFeature(f['name'], info,
> >                                    QAPISchemaIfCond(f.get('if')))
> >                  for f in features]
> > @@ -1485,6 +1507,12 @@ def check(self) -> None:
> >          for doc in self.docs:
> >              doc.check()
> >
> > +        features =3D list(self._feature_dict.values())
> > +        if len(features) > 64:
> > +            raise QAPISemError(
> > +                features[64].info,
> > +                "Maximum of 64 schema features is permitted")
> > +
> >      def visit(self, visitor: QAPISchemaVisitor) -> None:
> >          visitor.visit_begin(self)
> >          for mod in self._module_dict.values():
> > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> > index ade6b7a3d7..5294e5ea3b 100644
> > --- a/scripts/qapi/types.py
> > +++ b/scripts/qapi/types.py
> > @@ -308,11 +308,14 @@ def _begin_user_module(self, name: str) -> None:
> >  #include "qapi/dealloc-visitor.h"
> >  #include "%(types)s.h"
> >  #include "%(visit)s.h"
> > +#include "%(prefix)sqapi-features.h"
> >  ''',
> > -                                      types=3Dtypes, visit=3Dvisit))
> > +                                      types=3Dtypes, visit=3Dvisit,
> > +                                      prefix=3Dself._prefix))
> >          self._genh.preamble_add(mcgen('''
> >  #include "qapi/qapi-builtin-types.h"
> > -'''))
> > +''',
> > +                                      prefix=3Dself._prefix))
> >
> >      def visit_begin(self, schema: QAPISchema) -> None:
> >          # gen_object() is recursive, ensure it doesn't visit the empty
> type
> > diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> > index 8dbf4ef1c3..2d678c281d 100644
> > --- a/scripts/qapi/visit.py
> > +++ b/scripts/qapi/visit.py
> > @@ -360,8 +360,9 @@ def _begin_user_module(self, name: str) -> None:
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "%(visit)s.h"
> > +#include "%(prefix)sqapi-features.h"
> >  ''',
> > -                                      visit=3Dvisit))
> > +                                      visit=3Dvisit, prefix=3Dself._pr=
efix))
> >          self._genh.preamble_add(mcgen('''
> >  #include "qapi/qapi-builtin-visit.h"
> >  #include "%(types)s.h"
> > diff --git a/tests/meson.build b/tests/meson.build
> > index 907a4c1c98..a4ede66d0d 100644
> > --- a/tests/meson.build
> > +++ b/tests/meson.build
> > @@ -16,6 +16,8 @@ test_qapi_outputs =3D [
> >    'test-qapi-events-sub-sub-module.h',
> >    'test-qapi-events.c',
> >    'test-qapi-events.h',
> > +  'test-qapi-features.c',
> > +  'test-qapi-features.h',
> >    'test-qapi-init-commands.c',
> >    'test-qapi-init-commands.h',
> >    'test-qapi-introspect.c',
> > diff --git a/tests/qapi-schema/features-too-many.err
> b/tests/qapi-schema/features-too-many.err
> > new file mode 100644
> > index 0000000000..bbbd6e5202
> > --- /dev/null
> > +++ b/tests/qapi-schema/features-too-many.err
> > @@ -0,0 +1,2 @@
> > +features-too-many.json: In command 'go-fish':
> > +features-too-many.json:2: Maximum of 64 schema features is permitted
> > diff --git a/tests/qapi-schema/features-too-many.json
> b/tests/qapi-schema/features-too-many.json
> > new file mode 100644
> > index 0000000000..aab0a0b5f1
> > --- /dev/null
> > +++ b/tests/qapi-schema/features-too-many.json
> > @@ -0,0 +1,13 @@
> > +# Max 64 features, with 2 specials, so 63rd custom is invalid
> > +{ 'command': 'go-fish',
> > +  'features': [
> > +      'f00', 'f01', 'f02', 'f03', 'f04', 'f05', 'f06', 'f07',
> > +      'f08', 'f09', 'f0a', 'f0b', 'f0c', 'f0d', 'f0e', 'f0f',
> > +      'f10', 'f11', 'f12', 'f13', 'f14', 'f15', 'f16', 'f17',
> > +      'f18', 'f19', 'f1a', 'f1b', 'f1c', 'f1d', 'f1e', 'f1f',
> > +      'f20', 'f21', 'f22', 'f23', 'f24', 'f25', 'f26', 'f27',
> > +      'f28', 'f29', 'f2a', 'f2b', 'f2c', 'f2d', 'f2e', 'f2f',
> > +      'f30', 'f31', 'f32', 'f33', 'f34', 'f35', 'f36', 'f37',
> > +      'f38', 'f39', 'f3a', 'f3b', 'f3c', 'f3d', 'f3e'
> > +  ]
> > +}
> > diff --git a/tests/qapi-schema/features-too-many.out
> b/tests/qapi-schema/features-too-many.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/meson.build
> b/tests/qapi-schema/meson.build
> > index 0f479d9317..9577178b6f 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -105,6 +105,7 @@ schemas =3D [
> >    'event-case.json',
> >    'event-member-invalid-dict.json',
> >    'event-nest-struct.json',
> > +  'features-too-many.json',
> >    'features-bad-type.json',
> >    'features-deprecated-type.json',
> >    'features-duplicate-name.json',
>
>
> diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> index f32f9fe5f4..be3e5d03ff 100644
> --- a/scripts/qapi/features.py
> +++ b/scripts/qapi/features.py
> @@ -7,7 +7,7 @@
>  # See the COPYING file in the top-level directory.
>  """
>
> -from typing import Dict
> +from typing import Dict, ValuesView
>
>  from .common import c_enum_const, c_name
>  from .gen import QAPISchemaMonolithicCVisitor
> @@ -25,7 +25,7 @@ def __init__(self, prefix: str):
>              ' * Schema-defined QAPI features',
>              __doc__)
>
> -        self.features: Dict[str, QAPISchemaFeature] =3D {}
> +        self.features: ValuesView[QAPISchemaFeature]
>
>      def visit_begin(self, schema: QAPISchema) -> None:
>          self.features =3D schema.features()
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 39c91af245..f27933d244 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -29,6 +29,7 @@
>      List,
>      Optional,
>      Union,
> +    ValuesView,
>      cast,
>  )
>
> @@ -1160,7 +1161,7 @@ def __init__(self, fname: str):
>          self._def_exprs(exprs)
>          self.check()
>
> -    def features(self) -> List[QAPISchemaFeature]:
> +    def features(self) -> ValuesView[QAPISchemaFeature]:
>          return self._feature_dict.values()
>
>      def _def_entity(self, ent: QAPISchemaEntity) -> None:
>
>

--000000000000dcc07d062d85ed7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31,=
 2025 at 8:18=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Cc: John Snow for Python typing expertise.<br>
<br>
Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=
=3D"_blank">berrange@redhat.com</a>&gt; writes:<br>
<br>
&gt; This replaces use of the constants from the QapiSpecialFeatures<br>
&gt; enum, with constants from the auto-generate QapiFeatures enum<br>
&gt; in qapi-features.h<br>
&gt;<br>
&gt; The &#39;deprecated&#39; and &#39;unstable&#39; features still have a =
little bit of<br>
&gt; special handling, being force defined to be the 1st + 2nd features<br>
&gt; in the enum, regardless of whether they&#39;re used in the schema. Thi=
s<br>
&gt; retains compatibility with common code that references the features<br=
>
&gt; via the QapiSpecialFeatures constants.<br>
&gt;<br>
&gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@=
redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 scripts/qapi/commands.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 scripts/qapi/features.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 51 ++++++++++++++++++++++++<br>
&gt;=C2=A0 scripts/qapi/gen.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +--<br>
&gt;=C2=A0 scripts/qapi/main.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
&gt;=C2=A0 scripts/qapi/schema.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +++++++++++++-<br>
&gt;=C2=A0 scripts/qapi/types.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +++-<br>
&gt;=C2=A0 scripts/qapi/visit.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
&gt;=C2=A0 tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +<br>
&gt;=C2=A0 tests/qapi-schema/features-too-many.err=C2=A0 |=C2=A0 2 +<br>
&gt;=C2=A0 tests/qapi-schema/features-too-many.json | 13 ++++++<br>
&gt;=C2=A0 tests/qapi-schema/features-too-many.out=C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 tests/qapi-schema/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 13 files changed, 112 insertions(+), 7 deletions(-)<br>
&gt;=C2=A0 create mode 100644 scripts/qapi/features.py<br>
&gt;=C2=A0 create mode 100644 tests/qapi-schema/features-too-many.err<br>
&gt;=C2=A0 create mode 100644 tests/qapi-schema/features-too-many.json<br>
&gt;=C2=A0 create mode 100644 tests/qapi-schema/features-too-many.out<br>
&gt;<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 147097c652..3815878b23 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -3444,6 +3444,7 @@ qapi_gen_depends =3D [ meson.current_source_dir(=
) / &#39;scripts/qapi/__init__.py&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0meson.current_source_dir() / &#39;scripts/qapi/schema.py&#39;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0meson.current_source_dir() / &#39;scripts/qapi/source.py&#39;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0meson.current_source_dir() / &#39;scripts/qapi/types.py&#39;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0meson.current_source_dir() / &#39;scripts/qapi/features.py&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0meson.current_source_dir() / &#39;scripts/qapi/visit.py&#39;,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0meson.current_source_dir() / &#39;scripts/qapi-gen.py&#39;<br>
&gt;=C2=A0 ]<br>
&gt; diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py<br>
&gt; index d629d2d97e..bf88bfc442 100644<br>
&gt; --- a/scripts/qapi/commands.py<br>
&gt; +++ b/scripts/qapi/commands.py<br>
&gt; @@ -355,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -&gt; No=
ne:<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;%(prefix)sqapi-commands.h&quot;<br>
&gt;=C2=A0 #include &quot;%(prefix)sqapi-init-commands.h&quot;<br>
&gt; +#include &quot;%(prefix)sqapi-features.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..f32f9fe5f4<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/qapi/features.py<br>
&gt; @@ -0,0 +1,51 @@<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +QAPI features generator<br>
&gt; +<br>
&gt; +Copyright 2024 Red Hat<br>
&gt; +<br>
&gt; +This work is licensed under the terms of the GNU GPL, version 2.<br>
&gt; +# See the COPYING file in the top-level directory.<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +from typing import Dict<br>
&gt; +<br>
&gt; +from .common import c_enum_const, c_name<br>
&gt; +from .gen import QAPISchemaMonolithicCVisitor<br>
&gt; +from .schema import (<br>
&gt; +=C2=A0 =C2=A0 QAPISchema,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaFeature,<br>
&gt; +)<br>
&gt; +<br>
&gt; +<br>
&gt; +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, prefix: str):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix, &#39;qapi-features&=
#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; * Schema-defined QAPI=
 features&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __doc__)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features: Dict[str, QAPISchemaFeatur=
e] =3D {}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def visit_begin(self, schema: QAPISchema) -&gt; None:<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features =3D schema.features()<br>
<br>
Inconsistent type hints:<br>
<br>
=C2=A0 =C2=A0 $ mypy --config-file scripts/qapi/mypy.ini scripts/qapi-gen.p=
y <br>
=C2=A0 =C2=A0 scripts/qapi/schema.py:1164: error: Incompatible return value=
 type (got &quot;dict_values[str, QAPISchemaFeature]&quot;, expected &quot;=
List[QAPISchemaFeature]&quot;)=C2=A0 [return-value]<br>
=C2=A0 =C2=A0 scripts/qapi/features.py:31: error: Incompatible types in ass=
ignment (expression has type &quot;List[QAPISchemaFeature]&quot;, variable =
has type &quot;Dict[str, QAPISchemaFeature]&quot;)=C2=A0 [assignment]<br>
<br>
We&#39;ve been working towards having the build run mypy, but we&#39;re not=
<br>
there, yet.=C2=A0 Sorry for the inconvenience!<br>
<br>
schema.features() returns .values(), i.e. a view object.<br>
<br>
I guess the type hint should be ValuesView[QAPISchemaFeature], both for<br>
type type of attribute .features above, and for the return type of<br>
method .features() below.=C2=A0 John?<br></blockquote><div><br></div><div>I=
t&#39;s probably easiest to just use list(...) in the return and then use L=
ist[T] anywhere it matters. The values view type is &quot;kind of, but not =
actually a list&quot; because it isn&#39;t mutable. It is, however, an Iter=
able/Sequence. You can either convert it to a list or make the typing more =
abstract.</div><div><br></div><div>(Rule of thumb: return types should be a=
s specific as possible, input types should be as abstract as possible.)<br>=
</div><div><br></div><div>I apologize for this format of relaying patches a=
s it is against the blood oath I swore as a maintainer, but it&#39;s late i=
n my day, forgive me:</div><div><a href=3D"https://gitlab.com/jsnow/qemu/-/=
commits/dan-fixup">https://gitlab.com/jsnow/qemu/-/commits/dan-fixup</a></d=
iv><div><br></div><div>That branch has two things in it:</div><div><br></di=
v><div>(1) patches to make the python/ tests check the qapi module. This me=
ans the &quot;make check-minreqs&quot; test you can run from python/ will b=
e run by the GitLab pipelines. You can also run &quot;make check-tox&quot; =
manually, or run the optional python-tox test from the pipeline dashboard.<=
/div><div><br></div><div>(2) two fixups for linting problems with this seri=
es with my s-o-b; feel free to steal them if they&#39;re good enough for yo=
u.</div><div><br></div><div>Thank you for your patience,</div><div>--js<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Tentative fixup appended.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.add(&quot;#include \&quot;qapi=
/util.h\&quot;\n\n&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def visit_end(self) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.add(&quot;typedef enum {\n&quo=
t;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in self.features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.add(f&quot;=C2=
=A0 =C2=A0 {c_enum_const(&#39;qapi_feature&#39;, <a href=3D"http://f.name" =
rel=3D"noreferrer" target=3D"_blank">f.name</a>)}&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://f.name=
" rel=3D"noreferrer" target=3D"_blank">f.name</a> in QAPISchemaFeature.SPEC=
IAL_NAMES:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.ad=
d(f&quot; =3D {c_enum_const(&#39;qapi&#39;, <a href=3D"http://f.name" rel=
=3D"noreferrer" target=3D"_blank">f.name</a>)},\n&quot;)<br>
<br>
More type confusion here:<br>
<br>
=C2=A0 =C2=A0 scripts/qapi/features.py:37: error: &quot;str&quot; has no at=
tribute &quot;name&quot;=C2=A0 [attr-defined]<br>
=C2=A0 =C2=A0 scripts/qapi/features.py:38: error: &quot;str&quot; has no at=
tribute &quot;name&quot;=C2=A0 [attr-defined]<br>
=C2=A0 =C2=A0 scripts/qapi/features.py:39: error: &quot;str&quot; has no at=
tribute &quot;name&quot;=C2=A0 [attr-defined]<br>
<br>
My fixup takes care of these, too.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.ad=
d(&quot;,\n&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.add(&quot;} &quot; + c_name(&#=
39;QapiFeature&#39;) + &quot;;\n&quot;)<br>
&gt; +<br>
&gt; +<br>
&gt; +def gen_features(schema: QAPISchema,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_=
dir: str,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix:=
 str) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 vis =3D QAPISchemaGenFeatureVisitor(prefix)<br>
&gt; +=C2=A0 =C2=A0 schema.visit(vis)<br>
&gt; +=C2=A0 =C2=A0 vis.write(output_dir)<br>
&gt; diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py<br>
&gt; index b51f8d955e..d3c56d45c8 100644<br>
&gt; --- a/scripts/qapi/gen.py<br>
&gt; +++ b/scripts/qapi/gen.py<br>
&gt; @@ -42,9 +42,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def gen_features(features: Sequence[QAPISchemaFeature]) -&gt; st=
r:<br>
&gt; -=C2=A0 =C2=A0 featenum =3D [f&quot;1u &lt;&lt; {c_enum_const(&#39;qap=
i&#39;, <a href=3D"http://feat.name" rel=3D"noreferrer" target=3D"_blank">f=
eat.name</a>)}&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat in f=
eatures if feat.is_special()]<br>
&gt; -=C2=A0 =C2=A0 return &#39; | &#39;.join(featenum) or &#39;0&#39;<br>
&gt; +=C2=A0 =C2=A0 feats =3D [f&quot;1u &lt;&lt; {c_enum_const(&#39;qapi_f=
eature&#39;, <a href=3D"http://feat.name" rel=3D"noreferrer" target=3D"_bla=
nk">feat.name</a>)}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for feat in features]=
<br>
&gt; +=C2=A0 =C2=A0 return &#39; | &#39;.join(feats) or &#39;0&#39;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPIGen:<br>
&gt; diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py<br>
&gt; index 316736b6a2..2b9a2c0c02 100644<br>
&gt; --- a/scripts/qapi/main.py<br>
&gt; +++ b/scripts/qapi/main.py<br>
&gt; @@ -18,6 +18,7 @@<br>
&gt;=C2=A0 from .introspect import gen_introspect<br>
&gt;=C2=A0 from .schema import QAPISchema<br>
&gt;=C2=A0 from .types import gen_types<br>
&gt; +from .features import gen_features<br>
&gt;=C2=A0 from .visit import gen_visit<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; @@ -49,6 +50,7 @@ def generate(schema_file: str,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 schema =3D QAPISchema(schema_file)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 gen_types(schema, output_dir, prefix, builtins)<br=
>
&gt; +=C2=A0 =C2=A0 gen_features(schema, output_dir, prefix)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 gen_visit(schema, output_dir, prefix, builtins)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 gen_commands(schema, output_dir, prefix, gen_traci=
ng)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 gen_events(schema, output_dir, prefix)<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index e97c978d38..39c91af245 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -&g=
t; None:<br>
&gt;=C2=A0 class QAPISchemaFeature(QAPISchemaMember):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 role =3D &#39;feature&#39;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 # Features which are standardized across all schemas<br=
>
&gt; +=C2=A0 =C2=A0 SPECIAL_NAMES =3D [&#39;deprecated&#39;, &#39;unstable&=
#39;]<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def is_special(self) -&gt; bool:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return <a href=3D"http://self.name" rel=
=3D"noreferrer" target=3D"_blank">self.name</a> in (&#39;deprecated&#39;, &=
#39;unstable&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return <a href=3D"http://self.name" rel=
=3D"noreferrer" target=3D"_blank">self.name</a> in QAPISchemaFeature.SPECIA=
L_NAMES<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPISchemaObjectTypeMember(QAPISchemaMember):<br>
&gt; @@ -1138,6 +1141,16 @@ def __init__(self, fname: str):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_list: List[QAPISchemaEn=
tity] =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_dict: Dict[str, QAPISch=
emaDefinition] =3D {}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._module_dict: Dict[str, QAPISch=
emaModule] =3D OrderedDict()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # NB, values in the dict will identify th=
e first encountered<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0usage of a named fea=
ture only<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._feature_dict: Dict[str, QAPISchemaF=
eature] =3D OrderedDict()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # All schemas get the names defined in th=
e QapiSpecialFeature enum.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Use of OrderedDict ensures they are emi=
tted first when generating<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the enum definition, thus matching Qapi=
SpecialFeature.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in QAPISchemaFeature.SPECIAL_NAMES:=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._feature_dict[f] =3D Q=
APISchemaFeature(f, None)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._schema_dir =3D os.path.dirname=
(fname)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._make_module(QAPISchemaModule.B=
UILTIN_MODULE_NAME)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._make_module(fname)<br>
&gt; @@ -1147,6 +1160,9 @@ def __init__(self, fname: str):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._def_exprs(exprs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.check()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def features(self) -&gt; List[QAPISchemaFeature]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._feature_dict.values()<br>
<br>
See typing trouble above.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def _def_entity(self, ent: QAPISchemaEntity) -&gt;=
 None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._entity_list.append(ent)<br>
&gt;=C2=A0 <br>
&gt; @@ -1258,6 +1274,12 @@ def _make_features(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ) -&gt; List[QAPISchemaFeature]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if features is None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 feat =3D QAPISchemaFeature(=
f[&#39;name&#39;], info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://feat.n=
ame" rel=3D"noreferrer" target=3D"_blank">feat.name</a> not in self._featur=
e_dict:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._feature=
_dict[<a href=3D"http://feat.name" rel=3D"noreferrer" target=3D"_blank">fea=
t.name</a>] =3D feat<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return [QAPISchemaFeature(f[&#39;nam=
e&#39;], info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPISchemaIfCond(f.=
get(&#39;if&#39;)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in=
 features]<br>
&gt; @@ -1485,6 +1507,12 @@ def check(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for doc in self.docs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.check()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 features =3D list(self._feature_dict.valu=
es())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(features) &gt; 64:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features[64].=
info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Maximum=
 of 64 schema features is permitted&quot;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit(self, visitor: QAPISchemaVisitor) -&gt; =
None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 visitor.visit_begin(self)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for mod in self._module_dict.values(=
):<br>
&gt; diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py<br>
&gt; index ade6b7a3d7..5294e5ea3b 100644<br>
&gt; --- a/scripts/qapi/types.py<br>
&gt; +++ b/scripts/qapi/types.py<br>
&gt; @@ -308,11 +308,14 @@ def _begin_user_module(self, name: str) -&gt; No=
ne:<br>
&gt;=C2=A0 #include &quot;qapi/dealloc-visitor.h&quot;<br>
&gt;=C2=A0 #include &quot;%(types)s.h&quot;<br>
&gt;=C2=A0 #include &quot;%(visit)s.h&quot;<br>
&gt; +#include &quot;%(prefix)sqapi-features.h&quot;<br>
&gt;=C2=A0 &#39;&#39;&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 types=3Dtyp=
es, visit=3Dvisit))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 types=3Dtyp=
es, visit=3Dvisit,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3Dse=
lf._prefix))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.preamble_add(mcgen(&#39;&=
#39;&#39;<br>
&gt;=C2=A0 #include &quot;qapi/qapi-builtin-types.h&quot;<br>
&gt; -&#39;&#39;&#39;))<br>
&gt; +&#39;&#39;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefix=3Dse=
lf._prefix))<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_begin(self, schema: QAPISchema) -&gt; No=
ne:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # gen_object() is recursive, ensure =
it doesn&#39;t visit the empty type<br>
&gt; diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py<br>
&gt; index 8dbf4ef1c3..2d678c281d 100644<br>
&gt; --- a/scripts/qapi/visit.py<br>
&gt; +++ b/scripts/qapi/visit.py<br>
&gt; @@ -360,8 +360,9 @@ def _begin_user_module(self, name: str) -&gt; None=
:<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;%(visit)s.h&quot;<br>
&gt; +#include &quot;%(prefix)sqapi-features.h&quot;<br>
&gt;=C2=A0 &#39;&#39;&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 visit=3Dvis=
it))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 visit=3Dvis=
it, prefix=3Dself._prefix))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._genh.preamble_add(mcgen(&#39;&=
#39;&#39;<br>
&gt;=C2=A0 #include &quot;qapi/qapi-builtin-visit.h&quot;<br>
&gt;=C2=A0 #include &quot;%(types)s.h&quot;<br>
&gt; diff --git a/tests/meson.build b/tests/meson.build<br>
&gt; index 907a4c1c98..a4ede66d0d 100644<br>
&gt; --- a/tests/meson.build<br>
&gt; +++ b/tests/meson.build<br>
&gt; @@ -16,6 +16,8 @@ test_qapi_outputs =3D [<br>
&gt;=C2=A0 =C2=A0 &#39;test-qapi-events-sub-sub-module.h&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;test-qapi-events.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;test-qapi-events.h&#39;,<br>
&gt; +=C2=A0 &#39;test-qapi-features.c&#39;,<br>
&gt; +=C2=A0 &#39;test-qapi-features.h&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;test-qapi-init-commands.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;test-qapi-init-commands.h&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;test-qapi-introspect.c&#39;,<br>
&gt; diff --git a/tests/qapi-schema/features-too-many.err b/tests/qapi-sche=
ma/features-too-many.err<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..bbbd6e5202<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qapi-schema/features-too-many.err<br>
&gt; @@ -0,0 +1,2 @@<br>
&gt; +features-too-many.json: In command &#39;go-fish&#39;:<br>
&gt; +features-too-many.json:2: Maximum of 64 schema features is permitted<=
br>
&gt; diff --git a/tests/qapi-schema/features-too-many.json b/tests/qapi-sch=
ema/features-too-many.json<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..aab0a0b5f1<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qapi-schema/features-too-many.json<br>
&gt; @@ -0,0 +1,13 @@<br>
&gt; +# Max 64 features, with 2 specials, so 63rd custom is invalid<br>
&gt; +{ &#39;command&#39;: &#39;go-fish&#39;,<br>
&gt; +=C2=A0 &#39;features&#39;: [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f00&#39;, &#39;f01&#39;, &#39;f02&#39;, &#3=
9;f03&#39;, &#39;f04&#39;, &#39;f05&#39;, &#39;f06&#39;, &#39;f07&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f08&#39;, &#39;f09&#39;, &#39;f0a&#39;, &#3=
9;f0b&#39;, &#39;f0c&#39;, &#39;f0d&#39;, &#39;f0e&#39;, &#39;f0f&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f10&#39;, &#39;f11&#39;, &#39;f12&#39;, &#3=
9;f13&#39;, &#39;f14&#39;, &#39;f15&#39;, &#39;f16&#39;, &#39;f17&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f18&#39;, &#39;f19&#39;, &#39;f1a&#39;, &#3=
9;f1b&#39;, &#39;f1c&#39;, &#39;f1d&#39;, &#39;f1e&#39;, &#39;f1f&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f20&#39;, &#39;f21&#39;, &#39;f22&#39;, &#3=
9;f23&#39;, &#39;f24&#39;, &#39;f25&#39;, &#39;f26&#39;, &#39;f27&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f28&#39;, &#39;f29&#39;, &#39;f2a&#39;, &#3=
9;f2b&#39;, &#39;f2c&#39;, &#39;f2d&#39;, &#39;f2e&#39;, &#39;f2f&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f30&#39;, &#39;f31&#39;, &#39;f32&#39;, &#3=
9;f33&#39;, &#39;f34&#39;, &#39;f35&#39;, &#39;f36&#39;, &#39;f37&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;f38&#39;, &#39;f39&#39;, &#39;f3a&#39;, &#3=
9;f3b&#39;, &#39;f3c&#39;, &#39;f3d&#39;, &#39;f3e&#39;<br>
&gt; +=C2=A0 ]<br>
&gt; +}<br>
&gt; diff --git a/tests/qapi-schema/features-too-many.out b/tests/qapi-sche=
ma/features-too-many.out<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..e69de29bb2<br>
&gt; diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.b=
uild<br>
&gt; index 0f479d9317..9577178b6f 100644<br>
&gt; --- a/tests/qapi-schema/meson.build<br>
&gt; +++ b/tests/qapi-schema/meson.build<br>
&gt; @@ -105,6 +105,7 @@ schemas =3D [<br>
&gt;=C2=A0 =C2=A0 &#39;event-case.json&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;event-member-invalid-dict.json&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;event-nest-struct.json&#39;,<br>
&gt; +=C2=A0 &#39;features-too-many.json&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;features-bad-type.json&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;features-deprecated-type.json&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;features-duplicate-name.json&#39;,<br>
<br>
<br>
diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py<br>
index f32f9fe5f4..be3e5d03ff 100644<br>
--- a/scripts/qapi/features.py<br>
+++ b/scripts/qapi/features.py<br>
@@ -7,7 +7,7 @@<br>
=C2=A0# See the COPYING file in the top-level directory.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
-from typing import Dict<br>
+from typing import Dict, ValuesView<br>
<br>
=C2=A0from .common import c_enum_const, c_name<br>
=C2=A0from .gen import QAPISchemaMonolithicCVisitor<br>
@@ -25,7 +25,7 @@ def __init__(self, prefix: str):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39; * Schema-defined QAPI=
 features&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__doc__)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features: Dict[str, QAPISchemaFeature] =
=3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features: ValuesView[QAPISchemaFeature]<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0def visit_begin(self, schema: QAPISchema) -&gt; None:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.features =3D schema.features()<br>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index 39c91af245..f27933d244 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -29,6 +29,7 @@<br>
=C2=A0 =C2=A0 =C2=A0List,<br>
=C2=A0 =C2=A0 =C2=A0Optional,<br>
=C2=A0 =C2=A0 =C2=A0Union,<br>
+=C2=A0 =C2=A0 ValuesView,<br>
=C2=A0 =C2=A0 =C2=A0cast,<br>
=C2=A0)<br>
<br>
@@ -1160,7 +1161,7 @@ def __init__(self, fname: str):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._def_exprs(exprs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.check()<br>
<br>
-=C2=A0 =C2=A0 def features(self) -&gt; List[QAPISchemaFeature]:<br>
+=C2=A0 =C2=A0 def features(self) -&gt; ValuesView[QAPISchemaFeature]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._feature_dict.values()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _def_entity(self, ent: QAPISchemaEntity) -&gt; None=
:<br>
<br>
</blockquote></div></div>

--000000000000dcc07d062d85ed7f--


