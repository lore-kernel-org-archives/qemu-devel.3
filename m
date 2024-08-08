Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290D3C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1zS-0000xd-Hd; Thu, 08 Aug 2024 08:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc1zO-0000wf-OW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc1zK-0003S2-Ly
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723119084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1GLgYHdyFflY6AfVnxjXystx2aBu/rT29OGerHm3kc=;
 b=Z/i8XlQc4LZGtvsqb5ujJ29Mjpx6V5mvaD+gJQIRZAbyoW8+PEFApFsFvXv6GyIO8SRsnC
 ZnRu2YgJzKdraDbImrCLzQr1Jg+Mln+Mb5XgsOJjJZ9BhHRRTFVpkntYgLgc65sWJ4B5cT
 M+rNIhUwcLVkUAhl4Sx7AvkjwBb1uSc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-9ejTa5YoNKeJNf-7SBSYJg-1; Thu,
 08 Aug 2024 08:11:22 -0400
X-MC-Unique: 9ejTa5YoNKeJNf-7SBSYJg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F8161955F4A; Thu,  8 Aug 2024 12:11:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D49601953973; Thu,  8 Aug 2024 12:11:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8050521E5E6E; Thu,  8 Aug 2024 14:11:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 6/6] qapi: expose all schema features to code
In-Reply-To: <20240801175913.669013-7-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Aug 2024 18:59:13
 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-7-berrange@redhat.com>
Date: Thu, 08 Aug 2024 14:11:17 +0200
Message-ID: <87plqjw6xm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This removed the QapiFeatures enum and auto-generates an enum which
> exposes all features defined by the schema to code.
>
> The 'deprecated' and 'unstable' features still have a little bit of
> special handling, being force defined to be the 1st + 2nd features
> in the enum, regardless of whether they're used in the schema. This
> is because QAPI common code references these features.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qapi/util.h      |   5 --
>  meson.build              |   1 +
>  scripts/qapi/features.py | 134 +++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py     |   2 +
>  scripts/qapi/schema.py   |   5 +-
>  scripts/qapi/types.py    |   4 +-
>  6 files changed, 144 insertions(+), 7 deletions(-)
>  create mode 100644 scripts/qapi/features.py
>
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index a693cac9ea..9e390486c0 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -11,11 +11,6 @@
>  #ifndef QAPI_UTIL_H
>  #define QAPI_UTIL_H
>=20=20
> -typedef enum {
> -    QAPI_FEATURE_DEPRECATED,
> -    QAPI_FEATURE_UNSTABLE,
> -} QapiFeature;
> -
>  typedef struct QEnumLookup {
>      const char *const *array;
>      const uint64_t *const features;
> diff --git a/meson.build b/meson.build
> index 97f63aa86c..40002c59f5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3268,6 +3268,7 @@ qapi_gen_depends =3D [ meson.current_source_dir() /=
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
> diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
> new file mode 100644
> index 0000000000..9b77be6310
> --- /dev/null
> +++ b/scripts/qapi/features.py
> @@ -0,0 +1,134 @@
> +"""
> +QAPI types generator
> +
> +Copyright 2024 Red Hat
> +
> +This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +"""
> +
> +from typing import List, Optional
> +
> +from .common import c_enum_const, mcgen, c_name
> +from .gen import QAPISchemaMonolithicCVisitor
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaAlternatives,
> +    QAPISchemaBranches,
> +    QAPISchemaEntity,
> +    QAPISchemaEnumMember,
> +    QAPISchemaFeature,
> +    QAPISchemaIfCond,
> +    QAPISchemaObjectType,
> +    QAPISchemaObjectTypeMember,
> +    QAPISchemaType,
> +    QAPISchemaVariants,
> +)
> +from .source import QAPISourceInfo
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
> +
> +    def visit_end(self) -> None:
> +        features =3D []
> +
> +        # We always want special features to have the same
> +        # enum value across all schemas, since they're
> +        # referenced from common code. Put them at the
> +        # start of the list, regardless of whether they
> +        # are actually referenced in the schema
> +        for name in QAPISchemaFeature.SPECIAL_NAMES:
> +            features.append(name)
> +
> +        features.extend(sorted(self.features.keys()))
> +
> +        if len(features) > 64:
> +            raise Exception("Maximum of 64 schema features is permitted")

This is just one notch above assert len(features) > 64, so nope :)

Backends are not supposed to diagnose schema errors or constraint
violations.  That's the frontend's job.

Perhaps the simplest way to check this in the frontend is to build a
feature set in QAPISchema: initialize in .__init__(), update in
._make_features(), fail right there when asked to make a 64th.

> +
> +        self._genh.add("typedef enum {\n")
> +        for name in features:
> +            self._genh.add(f"    {c_enum_const(self._prefix + 'QAPI_FEAT=
URE', name)},\n")

This duplicates part of gen.gen_features().  Suggest to factor out the
common part as gen_feature().

Note for later: enum QapiFeature is defined in generated
qapi-features.h.

> +
> +        self._genh.add("} " + c_name(self._prefix + 'QapiFeature') + ";\=
n")
> +
> +    def _record(self, features: List[QAPISchemaFeature]):
> +        for f in features:
> +            # Special features are handled separately
> +            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
> +                continue
> +            self.features[f.name] =3D True
> +
> +    def visit_enum_type(self,
> +                        name: str,
> +                        info: Optional[QAPISourceInfo],
> +                        ifcond: QAPISchemaIfCond,
> +                        features: List[QAPISchemaFeature],
> +                        members: List[QAPISchemaEnumMember],
> +                        prefix: Optional[str]) -> None:
> +        self._record(features)
> +
> +    def visit_object_type_flat(self,
> +                               name: str,
> +                               info: Optional[QAPISourceInfo],
> +                               ifcond: QAPISchemaIfCond,
> +                               features: List[QAPISchemaFeature],
> +                               members: List[QAPISchemaObjectTypeMember],
> +                               branches: Optional[QAPISchemaBranches]) -=
> None:
> +        self._record(features)
> +
> +    def visit_object_type(self,
> +                          name: str,
> +                          info: Optional[QAPISourceInfo],
> +                          ifcond: QAPISchemaIfCond,
> +                          features: List[QAPISchemaFeature],
> +                          base: Optional[QAPISchemaObjectType],
> +                          members: List[QAPISchemaObjectTypeMember],
> +                          branches: Optional[QAPISchemaBranches]) -> Non=
e:
> +        self._record(features)
> +
> +    def visit_alternate_type(self,
> +                             name: str,
> +                             info: Optional[QAPISourceInfo],
> +                             ifcond: QAPISchemaIfCond,
> +                             features: List[QAPISchemaFeature],
> +                             alternatives: QAPISchemaAlternatives) -> No=
ne:
> +        self._record(features)
> +
> +    def visit_command(self,
> +                      name: str,
> +                      info: Optional[QAPISourceInfo],
> +                      ifcond: QAPISchemaIfCond,
> +                      features: List[QAPISchemaFeature],
> +                      arg_type: Optional[QAPISchemaObjectType],
> +                      ret_type: Optional[QAPISchemaType],
> +                      gen: bool,
> +                      success_response: bool,
> +                      boxed: bool,
> +                      allow_oob: bool,
> +                      allow_preconfig: bool,
> +                      coroutine: bool) -> None:
> +        self._record(features)
> +
> +    def visit_event(self,
> +                    name: str,
> +                    info: Optional[QAPISourceInfo],
> +                    ifcond: QAPISchemaIfCond,
> +                    features: List[QAPISchemaFeature],
> +                    arg_type: Optional[QAPISchemaObjectType],
> +                    boxed: bool) -> None:
> +        self._record(features)
> +

pycodestyle-3 gripes

    scripts/qapi/features.py:129:1: E302 expected 2 blank lines, found 1

> +def gen_features(schema: QAPISchema,
> +                 output_dir: str,
> +                 prefix: str) -> None:
> +    vis =3D QAPISchemaGenFeatureVisitor(prefix)
> +    schema.visit(vis)
> +    vis.write(output_dir)

We have another gen_features() in gen.py.  Not a show stopper, but could
we find equally good names that don't clash?

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
> index d65c35f6ee..160ce0a7c0 100644
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
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index b2d26c2ea8..3435f1b0b0 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -313,7 +313,9 @@ def _begin_user_module(self, name: str) -> None:
>                                        types=3Dtypes, visit=3Dvisit))
>          self._genh.preamble_add(mcgen('''
>  #include "qapi/qapi-builtin-types.h"
> -'''))
> +#include "%(prefix)sqapi-features.h"

This works, because it pulls in qapi-features.h basically everywhere.

It's actually needed only where we use enum QapiFeature.  So far, we
only ever generate uses with gen.gen_features().  Callers:

* gen_register_command() for qapi-init-commands.c.

* gen_enum_lookup() for qapi-types*.c and qapi-emit-events.c.

* gen_visit_object_members() for qapi-visit*.c.

Please include it just in these generated .c files.

> +''',
> +                                      prefix=3Dself._prefix))
>=20=20
>      def visit_begin(self, schema: QAPISchema) -> None:
>          # gen_object() is recursive, ensure it doesn't visit the empty t=
ype


