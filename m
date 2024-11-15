Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72AAD6DDDB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 07:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBr3b-0004C5-B3; Fri, 15 Nov 2024 02:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBr3M-0004Ar-By
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 02:47:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBr3I-0002Iu-JR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 02:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731656855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxkizwtCFE5oCT7Qglw1hTQ81AMwNKWWaXQtsWop3Js=;
 b=Tt5zEjWyShZi6Amj6h+VHppsHZ+T1KkTn8ZK1fm0bosuyIMMnB62/Bx9FU3hpSsSNpfbbM
 kRx40XOAL2XLmUwEgqZKQwHhwKnkiV1YN8r1hDBbDfeZbia7g34Z8JTKcpaIsJZa8FANse
 5/SaWkpwbxqeceMeb+ClH3K8f/qoo8w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-eVqOWCk3Mn6hrFHiSbSbzQ-1; Fri,
 15 Nov 2024 02:47:29 -0500
X-MC-Unique: eVqOWCk3Mn6hrFHiSbSbzQ-1
X-Mimecast-MFC-AGG-ID: eVqOWCk3Mn6hrFHiSbSbzQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01CA41903466; Fri, 15 Nov 2024 07:47:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77D4F1955F3C; Fri, 15 Nov 2024 07:47:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CA4421E6A28; Fri, 15 Nov 2024 08:47:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 4/4] qapi: expose all schema features to code
In-Reply-To: <ZzX6MXYTh97lzWZh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 14 Nov 2024 13:25:05 +0000")
References: <20241018101724.1221152-1-berrange@redhat.com>
 <20241018101724.1221152-5-berrange@redhat.com>
 <87r07ec76r.fsf@pond.sub.org> <ZzX6MXYTh97lzWZh@redhat.com>
Date: Fri, 15 Nov 2024 08:47:20 +0100
Message-ID: <87o72h9bw7.fsf@pond.sub.org>
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

> On Thu, Nov 14, 2024 at 01:48:28PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This replaces use of the constants from the QapiSpecialFeatures
>> > enum, with constants from the auto-generate QapiFeatures enum
>> > in qapi-features.h
>> >
>> > The 'deprecated' and 'unstable' features still have a little bit of
>> > special handling, being force defined to be the 1st + 2nd features
>> > in the enum, regardless of whether they're used in the schema. This
>> > retains compatibility with common code that references the features
>> > via the QapiSpecialFeatures constants.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  meson.build              |  1 +
>> >  scripts/qapi/commands.py |  1 +
>> >  scripts/qapi/features.py | 62 ++++++++++++++++++++++++++++++++++++++++
>> >  scripts/qapi/gen.py      |  4 +--
>> >  scripts/qapi/main.py     |  2 ++
>> >  scripts/qapi/schema.py   | 19 +++++++++++-
>> >  scripts/qapi/types.py    |  6 ++--
>> >  scripts/qapi/visit.py    |  3 +-
>> >  8 files changed, 92 insertions(+), 6 deletions(-)
>> >  create mode 100644 scripts/qapi/features.py
>> >
>> > diff --git a/meson.build b/meson.build
>> > index d26690ce20..b9d58be66f 100644
>> > --- a/meson.build
>> > +++ b/meson.build
>> > @@ -3332,6 +3332,7 @@ qapi_gen_depends =3D [ meson.current_source_dir(=
) / 'scripts/qapi/__init__.py',
>> >                       meson.current_source_dir() / 'scripts/qapi/schem=
a.py',
>> >                       meson.current_source_dir() / 'scripts/qapi/sourc=
e.py',
>> >                       meson.current_source_dir() / 'scripts/qapi/types=
.py',
>> > +                     meson.current_source_dir() / 'scripts/qapi/featu=
res.py',
>> >                       meson.current_source_dir() / 'scripts/qapi/visit=
.py',
>> >                       meson.current_source_dir() / 'scripts/qapi-gen.p=
y'
>> >  ]
>> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> > index d629d2d97e..bf88bfc442 100644
>> > --- a/scripts/qapi/commands.py
>> > +++ b/scripts/qapi/commands.py
>> > @@ -355,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
>> >  #include "qemu/osdep.h"
>> >  #include "%(prefix)sqapi-commands.h"
>> >  #include "%(prefix)sqapi-init-commands.h"
>> > +#include "%(prefix)sqapi-features.h"
>> >=20=20
>> >  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
>> >  {
>> > diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
>> > new file mode 100644
>> > index 0000000000..dc10c7cea0
>> > --- /dev/null
>> > +++ b/scripts/qapi/features.py
>> > @@ -0,0 +1,62 @@
>> > +"""
>> > +QAPI types generator
>>=20
>> QAPI features generator
>>=20
>> > +
>> > +Copyright 2024 Red Hat
>> > +
>> > +This work is licensed under the terms of the GNU GPL, version 2.
>> > +# See the COPYING file in the top-level directory.
>> > +"""
>> > +
>> > +from typing import List, Optional
>>=20
>> pylint gripes
>
> Sigh, I really wish we had pylint/mypy/pycodestyle being run as
> part of 'make check' by default. I don't like making the mistake
> of sending patches which fail extra non-default checks maintainers
> need compliance with.

We've made some progress towards running these checkers, but we're not
there, yet.

>>     scripts/qapi/features.py:10:0: W0611: Unused List imported from typi=
ng (unused-
>>     import)
>>     scripts/qapi/features.py:10:0: W0611: Unused Optional imported from =
typing (unused-import)
>>=20
>> > +
>> > +from .common import c_enum_const, mcgen, c_name
>>=20
>>     scripts/qapi/features.py:12:0: W0611: Unused mcgen imported from com=
mon (unused-import)
>>=20
>> > +from .gen import QAPISchemaMonolithicCVisitor
>> > +from .schema import (
>> > +    QAPISchema,
>> > +    QAPISchemaFeature,
>> > +)
>> > +from .source import QAPISourceInfo
>>=20
>>     scripts/qapi/features.py:18:0: W0611: Unused QAPISourceInfo imported=
 from source (unused-import)
>>=20
>> > +
>> > +
>> > +class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
>> > +
>> > +    def __init__(self, prefix: str):
>> > +        super().__init__(
>> > +            prefix, 'qapi-features',
>> > +            ' * Schema-defined QAPI features',
>> > +            __doc__)
>> > +
>> > +        self.features =3D {}
>>=20
>> mypy gripes
>>=20
>>     scripts/qapi/features.py:29: error: Need type annotation for "featur=
es" (hint: "features: Dict[<type>, <type>] =3D ...")  [var-annotated]
>>=20
>> Elsewhere, we avoid rummaging in QAPISchema's innards by defining
>> suitable visit.  If that's too much trouble for you now, I can take this
>> as is an clean up on top.
>>=20
>> > +
>> > +    def visit_begin(self, schema: QAPISchema):
>>=20
>> mypy gripes
>>=20
>>     scripts/qapi/features.py:31: error: Function is missing a return typ=
e annotation  [no-untyped-def]
>>=20
>> > +        self.features =3D schema._feature_dict
>>=20
>> pylint gripes
>>=20
>>     scripts/qapi/features.py:32:24: W0212: Access to a protected member =
_feature_dict of a client class (protected-access)
>>=20
>> > +
>> > +    def visit_end(self) -> None:
>> > +        features =3D [
>> > +            self.features[f]
>> > +            for f in QAPISchemaFeature.SPECIAL_NAMES
>> > +        ]
>> > +
>> > +        features.extend(
>> > +            sorted(
>> > +                filter(lambda f: not f.is_special(),
>> > +                       self.features.values()),
>> > +                key=3Dlambda f: f.name)
>> > +        )
>>=20
>> @features is schema._feature_dict.values() sorted by name in a certain
>> way, namely first the .SPECIAL_NAMES in order, then all the others in
>> alphabetical order.
>>=20
>> Why you do this is not immediately obvious.  I guess it's to make the
>> generated enum a compatible extension of enum QapiSpecialFeature.  That
>> one exists for use by schema-independent support code such
>> compat_policy_input_ok() and qobject_output_policy_skip().
>
> Yes, I wanted the overlapping enums vaules to match.

Needs a comment.

>> I further guess you sort the non-special features just to make the
>> generated code easier for humans to navigate.
>>=20
>> Correct?
>
> The remaining sort was just to give a predictable stable output,
> should QAPI usage of features be reordered.

We don't do that for enum QAPIEvent, and it hasn't inconvenienced us as
far as I can tell.  No big deal, I just like consistency.

>> > +
>> > +        self._genh.add("typedef enum {\n")
>> > +        for f in features:
>> > +            self._genh.add(f"    {c_enum_const('qapi_feature', f.name=
)}")
>> > +            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
>> > +                self._genh.add(f" =3D {c_enum_const('qapi', f.name)},=
\n" )
>>=20
>> pycodestyle gripes
>>=20
>>     scripts/qapi/features.py:51:71: E202 whitespace before ')'
>>=20
>> > +            else:
>> > +                self._genh.add(",\n")
>> > +
>> > +        self._genh.add("} " + c_name('QapiFeature') + ";\n")
>> > +
>>=20
>> pycodestyle gripes
>>=20
>>     scripts/qapi/features.py:57:1: E302 expected 2 blank lines, found 1
>>=20
>> This part generates a C enum.  It's similar to gen_enum() from types.py,
>> except we work with a list of QAPISchemaFeature here, and a list of
>> QAPISchemaEnumMember there.
>>=20
>> To reuse gen_enum() here, we'd have to make up a member list, like we do
>> in events.py for enum QAPIEvent.
>
> I'll have a look at that.

Reuse it only if it's easy for you.  We can always improve on top.

>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index e97c978d38..5e14b1829b 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>> > @@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -> =
None:
>> >  class QAPISchemaFeature(QAPISchemaMember):
>> >      role =3D 'feature'
>> >=20=20
>> > +    # Features which are standardized across all schemas
>> > +    SPECIAL_NAMES =3D ['deprecated', 'unstable']
>> > +
>> >      def is_special(self) -> bool:
>> > -        return self.name in ('deprecated', 'unstable')
>> > +        return self.name in QAPISchemaFeature.SPECIAL_NAMES
>> >=20=20
>> >=20=20
>> >  class QAPISchemaObjectTypeMember(QAPISchemaMember):
>> > @@ -1138,6 +1141,11 @@ def __init__(self, fname: str):
>> >          self._entity_list: List[QAPISchemaEntity] =3D []
>> >          self._entity_dict: Dict[str, QAPISchemaDefinition] =3D {}
>> >          self._module_dict: Dict[str, QAPISchemaModule] =3D OrderedDic=
t()
>> > +        self._feature_dict: Dict[str, QAPISchemaFeature] =3D {}
>> > +
>> > +        for f in QAPISchemaFeature.SPECIAL_NAMES:
>> > +            self._feature_dict[f] =3D QAPISchemaFeature(f, "special f=
eature")
>>=20
>> mypy gripes
>>=20
>>     scripts/qapi/schema.py:1147: error: Argument 2 to "QAPISchemaFeature=
" has incompatible type "str"; expected "Optional[QAPISourceInfo]"  [arg-ty=
pe]
>>=20
>> We commonly use None as info value for built-in stuff, and that's why
>> it's Optional[QAPISourceInfo], not just QAPISourceInfo.
>
> Yeah, not sure what I was thinking here, looking again I
> should have passed "None"
>
>> But do we really need to make up some QAPISchemaFeature?  Hmm.  The
>> appended patch dumbs down ._feature_dict to a set.

See below for a possible reason to keep .feature_dict.

> I was following the same pattern as self._entity_dict and
> self._module_dict, rather than dumbing down to the bare
> minimum needed by my current use case. I don't mind which
> strategy we take.

.entity_dict maps the name to the one entity.  Likewise .module_dict.
.feature_dict, however, maps it to the first of possibly many.  That's
not wrong, just peculiar and possibly less than obvious to readers who
aren't familiar with how we represent features internally.  Worth a
comment?

>> > +
>> >          self._schema_dir =3D os.path.dirname(fname)
>> >          self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
>> >          self._make_module(fname)
>> > @@ -1258,6 +1266,15 @@ def _make_features(
>> >      ) -> List[QAPISchemaFeature]:
>> >          if features is None:
>> >              return []
>> > +
>> > +        for f in features:
>> > +            feat =3D QAPISchemaFeature(f['name'], info)
>> > +            if feat.name not in self._feature_dict:
>> > +                if len(self._feature_dict) =3D=3D 64:
>> > +                    raise Exception("Maximum of 64 schema features is=
 permitted")
>>=20
>> The limit is an implementation restriction.  Okay, we can lift it when
>> it bites us.
>>=20
>> However, the reporting is less than nice:
>>=20
>>     $ python scripts/qapi-gen.py -o $$ tests/qapi-schema/features-too-ma=
ny.json=20
>>     Traceback (most recent call last):
>>       File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
>>         sys.exit(main.main())
>>                  ^^^^^^^^^^^
>>       File "/work/armbru/qemu/scripts/qapi/main.py", line 96, in main
>>         generate(args.schema,
>>       File "/work/armbru/qemu/scripts/qapi/main.py", line 51, in generate
>>         schema =3D QAPISchema(schema_file)
>>                  ^^^^^^^^^^^^^^^^^^^^^^^
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1155, in __i=
nit__
>>         self._def_exprs(exprs)
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1482, in _de=
f_exprs
>>         self._def_struct_type(expr)
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1377, in _de=
f_struct_type
>>         features =3D self._make_features(expr.get('features'), info)
>>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>       File "/work/armbru/qemu/scripts/qapi/schema.py", line 1274, in _ma=
ke_features
>>         raise Exception("Maximum of 64 schema features is permitted")
>>     Exception: Maximum of 64 schema features is permitted
>
> Is there any better way to approach this error reporting ?

Raise QAPISemError in .check().

Hmm, then you need a QAPISourceInfo to pass.  .feature_dict will give
you one: the .info of the feature added last.


