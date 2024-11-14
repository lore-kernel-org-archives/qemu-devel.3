Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163BD68B00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZHF-0001yF-HG; Thu, 14 Nov 2024 07:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBZH9-0001xw-I6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBZH6-0004Sc-8y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731588518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oTcNx3w/U8IBQhXGQ/Wdt0vBn93j/WgCeLMVqtN6GM=;
 b=W0jDd1sca0AWBIqV40burxNHjqqjXf9o9eQdErmfGXYjOCAIwaxgzYiT36vb1h3TwDrZyZ
 4b0lt0aG3Gdv6iQIPq/ELXDvbsdYPnRcmcW2iikj+uJpVbM7yp/aHrZnkzEB5shzTLbtUl
 q4zlfXa5JmD+Kd/z+tNbkXrgduNfZK4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-sEY5j2XyMxWQTt96ksYfsw-1; Thu,
 14 Nov 2024 07:48:32 -0500
X-MC-Unique: sEY5j2XyMxWQTt96ksYfsw-1
X-Mimecast-MFC-AGG-ID: sEY5j2XyMxWQTt96ksYfsw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B2C61956080; Thu, 14 Nov 2024 12:48:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6AB51956054; Thu, 14 Nov 2024 12:48:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D691821E6A28; Thu, 14 Nov 2024 13:48:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 4/4] qapi: expose all schema features to code
In-Reply-To: <20241018101724.1221152-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 18 Oct 2024 11:17:24
 +0100")
References: <20241018101724.1221152-1-berrange@redhat.com>
 <20241018101724.1221152-5-berrange@redhat.com>
Date: Thu, 14 Nov 2024 13:48:28 +0100
Message-ID: <87r07ec76r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This replaces use of the constants from the QapiSpecialFeatures
> enum, with constants from the auto-generate QapiFeatures enum
> in qapi-features.h
>
> The 'deprecated' and 'unstable' features still have a little bit of
> special handling, being force defined to be the 1st + 2nd features
> in the enum, regardless of whether they're used in the schema. This
> retains compatibility with common code that references the features
> via the QapiSpecialFeatures constants.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build              |  1 +
>  scripts/qapi/commands.py |  1 +
>  scripts/qapi/features.py | 62 ++++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/gen.py      |  4 +--
>  scripts/qapi/main.py     |  2 ++
>  scripts/qapi/schema.py   | 19 +++++++++++-
>  scripts/qapi/types.py    |  6 ++--
>  scripts/qapi/visit.py    |  3 +-
>  8 files changed, 92 insertions(+), 6 deletions(-)
>  create mode 100644 scripts/qapi/features.py
>
> diff --git a/meson.build b/meson.build
> index d26690ce20..b9d58be66f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3332,6 +3332,7 @@ qapi_gen_depends =3D [ meson.current_source_dir() /=
 'scripts/qapi/__init__.py',
>                       meson.current_source_dir() / 'scripts/qapi/schema.p=
y',
>                       meson.current_source_dir() / 'scripts/qapi/source.p=
y',
>                       meson.current_source_dir() / 'scripts/qapi/types.py=
',
> +                     meson.current_source_dir() / 'scripts/qapi/features=
.py',
>                       meson.current_source_dir() / 'scripts/qapi/visit.py=
',
>                       meson.current_source_dir() / 'scripts/qapi-gen.py'
>  ]
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index d629d2d97e..bf88bfc442 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -355,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
>  #include "qemu/osdep.h"
>  #include "%(prefix)sqapi-commands.h"
>  #include "%(prefix)sqapi-init-commands.h"
> +#include "%(prefix)sqapi-features.h"
>=20=20
>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
>  {
> diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> new file mode 100644
> index 0000000000..dc10c7cea0
> --- /dev/null
> +++ b/scripts/qapi/features.py
> @@ -0,0 +1,62 @@
> +"""
> +QAPI types generator

QAPI features generator

> +
> +Copyright 2024 Red Hat
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +"""
> +
> +from typing import List, Optional

pylint gripes

    scripts/qapi/features.py:10:0: W0611: Unused List imported from typing =
(unused-
    import)
    scripts/qapi/features.py:10:0: W0611: Unused Optional imported from typ=
ing (unused-import)

> +
> +from .common import c_enum_const, mcgen, c_name

    scripts/qapi/features.py:12:0: W0611: Unused mcgen imported from common=
 (unused-import)

> +from .gen import QAPISchemaMonolithicCVisitor
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaFeature,
> +)
> +from .source import QAPISourceInfo

    scripts/qapi/features.py:18:0: W0611: Unused QAPISourceInfo imported fr=
om source (unused-import)

> +
> +
> +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
> +
> +    def __init__(self, prefix: str):
> +        super().__init__(
> +            prefix, 'qapi-features',
> +            ' * Schema-defined QAPI features',
> +            __doc__)
> +
> +        self.features =3D {}

mypy gripes

    scripts/qapi/features.py:29: error: Need type annotation for "features"=
 (hint: "features: Dict[<type>, <type>] =3D ...")  [var-annotated]

Elsewhere, we avoid rummaging in QAPISchema's innards by defining
suitable visit.  If that's too much trouble for you now, I can take this
as is an clean up on top.

> +
> +    def visit_begin(self, schema: QAPISchema):

mypy gripes

    scripts/qapi/features.py:31: error: Function is missing a return type a=
nnotation  [no-untyped-def]

> +        self.features =3D schema._feature_dict

pylint gripes

    scripts/qapi/features.py:32:24: W0212: Access to a protected member _fe=
ature_dict of a client class (protected-access)

> +
> +    def visit_end(self) -> None:
> +        features =3D [
> +            self.features[f]
> +            for f in QAPISchemaFeature.SPECIAL_NAMES
> +        ]
> +
> +        features.extend(
> +            sorted(
> +                filter(lambda f: not f.is_special(),
> +                       self.features.values()),
> +                key=3Dlambda f: f.name)
> +        )

@features is schema._feature_dict.values() sorted by name in a certain
way, namely first the .SPECIAL_NAMES in order, then all the others in
alphabetical order.

Why you do this is not immediately obvious.  I guess it's to make the
generated enum a compatible extension of enum QapiSpecialFeature.  That
one exists for use by schema-independent support code such
compat_policy_input_ok() and qobject_output_policy_skip().

I further guess you sort the non-special features just to make the
generated code easier for humans to navigate.

Correct?

> +
> +        self._genh.add("typedef enum {\n")
> +        for f in features:
> +            self._genh.add(f"    {c_enum_const('qapi_feature', f.name)}")
> +            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
> +                self._genh.add(f" =3D {c_enum_const('qapi', f.name)},\n"=
 )

pycodestyle gripes

    scripts/qapi/features.py:51:71: E202 whitespace before ')'

> +            else:
> +                self._genh.add(",\n")
> +
> +        self._genh.add("} " + c_name('QapiFeature') + ";\n")
> +

pycodestyle gripes

    scripts/qapi/features.py:57:1: E302 expected 2 blank lines, found 1

This part generates a C enum.  It's similar to gen_enum() from types.py,
except we work with a list of QAPISchemaFeature here, and a list of
QAPISchemaEnumMember there.

To reuse gen_enum() here, we'd have to make up a member list, like we do
in events.py for enum QAPIEvent.

> +def gen_features(schema: QAPISchema,
> +                 output_dir: str,
> +                 prefix: str) -> None:
> +    vis =3D QAPISchemaGenFeatureVisitor(prefix)
> +    schema.visit(vis)
> +    vis.write(output_dir)
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index aba1a982f6..6ef603941c 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -42,8 +42,8 @@
>=20=20
>=20=20
>  def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
> -    features =3D [f"1u << {c_enum_const('qapi', feat.name)}"
> -                        for feat in features if feat.is_special()]
> +    features =3D [f"1u << {c_enum_const('qapi_feature', feat.name)}"
> +                        for feat in features]
>      return ' | '.join(features) or '0'
>=20=20
>=20=20
> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 316736b6a2..2b9a2c0c02 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -18,6 +18,7 @@
>  from .introspect import gen_introspect
>  from .schema import QAPISchema
>  from .types import gen_types
> +from .features import gen_features
>  from .visit import gen_visit
>=20=20
>=20=20
> @@ -49,6 +50,7 @@ def generate(schema_file: str,
>=20=20
>      schema =3D QAPISchema(schema_file)
>      gen_types(schema, output_dir, prefix, builtins)
> +    gen_features(schema, output_dir, prefix)
>      gen_visit(schema, output_dir, prefix, builtins)
>      gen_commands(schema, output_dir, prefix, gen_tracing)
>      gen_events(schema, output_dir, prefix)
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index e97c978d38..5e14b1829b 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -> Non=
e:
>  class QAPISchemaFeature(QAPISchemaMember):
>      role =3D 'feature'
>=20=20
> +    # Features which are standardized across all schemas
> +    SPECIAL_NAMES =3D ['deprecated', 'unstable']
> +
>      def is_special(self) -> bool:
> -        return self.name in ('deprecated', 'unstable')
> +        return self.name in QAPISchemaFeature.SPECIAL_NAMES
>=20=20
>=20=20
>  class QAPISchemaObjectTypeMember(QAPISchemaMember):
> @@ -1138,6 +1141,11 @@ def __init__(self, fname: str):
>          self._entity_list: List[QAPISchemaEntity] =3D []
>          self._entity_dict: Dict[str, QAPISchemaDefinition] =3D {}
>          self._module_dict: Dict[str, QAPISchemaModule] =3D OrderedDict()
> +        self._feature_dict: Dict[str, QAPISchemaFeature] =3D {}
> +
> +        for f in QAPISchemaFeature.SPECIAL_NAMES:
> +            self._feature_dict[f] =3D QAPISchemaFeature(f, "special feat=
ure")

mypy gripes

    scripts/qapi/schema.py:1147: error: Argument 2 to "QAPISchemaFeature" h=
as incompatible type "str"; expected "Optional[QAPISourceInfo]"  [arg-type]

We commonly use None as info value for built-in stuff, and that's why
it's Optional[QAPISourceInfo], not just QAPISourceInfo.

But do we really need to make up some QAPISchemaFeature?  Hmm.  The
appended patch dumbs down ._feature_dict to a set.

> +
>          self._schema_dir =3D os.path.dirname(fname)
>          self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
>          self._make_module(fname)
> @@ -1258,6 +1266,15 @@ def _make_features(
>      ) -> List[QAPISchemaFeature]:
>          if features is None:
>              return []
> +
> +        for f in features:
> +            feat =3D QAPISchemaFeature(f['name'], info)
> +            if feat.name not in self._feature_dict:
> +                if len(self._feature_dict) =3D=3D 64:
> +                    raise Exception("Maximum of 64 schema features is pe=
rmitted")

The limit is an implementation restriction.  Okay, we can lift it when
it bites us.

However, the reporting is less than nice:

    $ python scripts/qapi-gen.py -o $$ tests/qapi-schema/features-too-many.=
json=20
    Traceback (most recent call last):
      File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
        sys.exit(main.main())
                 ^^^^^^^^^^^
      File "/work/armbru/qemu/scripts/qapi/main.py", line 96, in main
        generate(args.schema,
      File "/work/armbru/qemu/scripts/qapi/main.py", line 51, in generate
        schema =3D QAPISchema(schema_file)
                 ^^^^^^^^^^^^^^^^^^^^^^^
      File "/work/armbru/qemu/scripts/qapi/schema.py", line 1155, in __init=
__
        self._def_exprs(exprs)
      File "/work/armbru/qemu/scripts/qapi/schema.py", line 1482, in _def_e=
xprs
        self._def_struct_type(expr)
      File "/work/armbru/qemu/scripts/qapi/schema.py", line 1377, in _def_s=
truct_type
        features =3D self._make_features(expr.get('features'), info)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/work/armbru/qemu/scripts/qapi/schema.py", line 1274, in _make_=
features
        raise Exception("Maximum of 64 schema features is permitted")
    Exception: Maximum of 64 schema features is permitted



> +
> +                self._feature_dict[feat.name] =3D feat
> +
>          return [QAPISchemaFeature(f['name'], info,
>                                    QAPISchemaIfCond(f.get('if')))
>                  for f in features]
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index ade6b7a3d7..7618d3eb6f 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -308,11 +308,13 @@ def _begin_user_module(self, name: str) -> None:
>  #include "qapi/dealloc-visitor.h"
>  #include "%(types)s.h"
>  #include "%(visit)s.h"
> +#include "%(prefix)sqapi-features.h"
>  ''',
> -                                      types=3Dtypes, visit=3Dvisit))
> +                                      types=3Dtypes, visit=3Dvisit, pref=
ix=3Dself._prefix))

Long line, easy to break:

                                         types=3Dtypes, visit=3Dvisit,
                                         prefix=3Dself._prefix))

>          self._genh.preamble_add(mcgen('''
>  #include "qapi/qapi-builtin-types.h"
> -'''))
> +''',
> +                                      prefix=3Dself._prefix))
>=20=20
>      def visit_begin(self, schema: QAPISchema) -> None:
>          # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 8dbf4ef1c3..2d678c281d 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -360,8 +360,9 @@ def _begin_user_module(self, name: str) -> None:
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "%(visit)s.h"
> +#include "%(prefix)sqapi-features.h"
>  ''',
> -                                      visit=3Dvisit))
> +                                      visit=3Dvisit, prefix=3Dself._pref=
ix))
>          self._genh.preamble_add(mcgen('''
>  #include "qapi/qapi-builtin-visit.h"
>  #include "%(types)s.h"


diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
index dc10c7cea0..3662c1e568 100644
--- a/scripts/qapi/features.py
+++ b/scripts/qapi/features.py
@@ -7,7 +7,7 @@
 # See the COPYING file in the top-level directory.
 """
=20
-from typing import List, Optional
+from typing import List, Optional, Set
=20
 from .common import c_enum_const, mcgen, c_name
 from .gen import QAPISchemaMonolithicCVisitor
@@ -26,29 +26,25 @@ def __init__(self, prefix: str):
             ' * Schema-defined QAPI features',
             __doc__)
=20
-        self.features =3D {}
+        self.features: Set['str']
=20
-    def visit_begin(self, schema: QAPISchema):
-        self.features =3D schema._feature_dict
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self.features =3D schema._features
=20
     def visit_end(self) -> None:
-        features =3D [
-            self.features[f]
-            for f in QAPISchemaFeature.SPECIAL_NAMES
-        ]
+        features =3D QAPISchemaFeature.SPECIAL_NAMES.copy()
=20
         features.extend(
             sorted(
-                filter(lambda f: not f.is_special(),
-                       self.features.values()),
-                key=3Dlambda f: f.name)
+                filter(lambda f: f not in QAPISchemaFeature.SPECIAL_NAMES,
+                       self.features))
         )
=20
         self._genh.add("typedef enum {\n")
         for f in features:
-            self._genh.add(f"    {c_enum_const('qapi_feature', f.name)}")
-            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
-                self._genh.add(f" =3D {c_enum_const('qapi', f.name)},\n" )
+            self._genh.add(f"    {c_enum_const('qapi_feature', f)}")
+            if f in QAPISchemaFeature.SPECIAL_NAMES:
+                self._genh.add(f" =3D {c_enum_const('qapi', f)},\n" )
             else:
                 self._genh.add(",\n")
=20
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 6ef603941c..3fb84d36c2 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -42,9 +42,9 @@
=20
=20
 def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
-    features =3D [f"1u << {c_enum_const('qapi_feature', feat.name)}"
+    feats =3D [f"1u << {c_enum_const('qapi_feature', feat.name)}"
                         for feat in features]
-    return ' | '.join(features) or '0'
+    return ' | '.join(feats) or '0'
=20
=20
 class QAPIGen:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 5e14b1829b..dd71cbc8b7 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -28,6 +28,7 @@
     Dict,
     List,
     Optional,
+    Set,
     Union,
     cast,
 )
@@ -1141,10 +1142,7 @@ def __init__(self, fname: str):
         self._entity_list: List[QAPISchemaEntity] =3D []
         self._entity_dict: Dict[str, QAPISchemaDefinition] =3D {}
         self._module_dict: Dict[str, QAPISchemaModule] =3D OrderedDict()
-        self._feature_dict: Dict[str, QAPISchemaFeature] =3D {}
-
-        for f in QAPISchemaFeature.SPECIAL_NAMES:
-            self._feature_dict[f] =3D QAPISchemaFeature(f, "special featur=
e")
+        self._features: Set[str] =3D set(QAPISchemaFeature.SPECIAL_NAMES)
=20
         self._schema_dir =3D os.path.dirname(fname)
         self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
@@ -1269,11 +1267,11 @@ def _make_features(
=20
         for f in features:
             feat =3D QAPISchemaFeature(f['name'], info)
-            if feat.name not in self._feature_dict:
-                if len(self._feature_dict) =3D=3D 64:
+            if feat.name not in self._features:
+                if len(self._features) =3D=3D 64:
                     raise Exception("Maximum of 64 schema features is perm=
itted")
=20
-                self._feature_dict[feat.name] =3D feat
+                self._features.add(feat.name)
=20
         return [QAPISchemaFeature(f['name'], info,
                                   QAPISchemaIfCond(f.get('if')))


