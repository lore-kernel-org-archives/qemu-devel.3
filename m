Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE419FD3764
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvG3V-0006Zl-Gg; Wed, 25 Feb 2026 09:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvG3T-0006ZN-Ka
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvG3Q-0005ia-Rs
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772030395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0qNgnDYy4mbgVze5LfgLFwLZZhFBqB/p8P7eWOuads=;
 b=SInY1KtbwuiHeqIqhISD19RCNfElZYvtlNrtKTHCv4hDi4jFHlyn0OtEzQlZzkx7c+4X2G
 UHQv4B3KKC/dtFOtMxITUwTQViSwUY6v7y2lFv6RWfDzkY1AhRglKghzKf+/FnEU1s40cY
 FPDfrhEqlbZ9vZull1mBAvtscvY5hMA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-vzwyXqCiM9GA4jSsKe360A-1; Wed,
 25 Feb 2026 09:39:53 -0500
X-MC-Unique: vzwyXqCiM9GA4jSsKe360A-1
X-Mimecast-MFC-AGG-ID: vzwyXqCiM9GA4jSsKe360A_1772030393
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7156195605A; Wed, 25 Feb 2026 14:39:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 266CC1955F43; Wed, 25 Feb 2026 14:39:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7AF8921E692D; Wed, 25 Feb 2026 15:39:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-rust@nongnu.org
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <20260108131043.490084-13-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 8 Jan 2026 14:10:39 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
Date: Wed, 25 Feb 2026 15:39:49 +0100
Message-ID: <87jyw0khu2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate high-level native Rust declarations for the QAPI types.
>
> - char* is mapped to String, scalars to there corresponding Rust types
>
> - enums use #[repr(u32)] and can be transmuted to their C counterparts
>
> - has_foo/foo members are mapped to Option<T>
>
> - lists are represented as Vec<T>
>
> - structures map fields 1:1 to Rust
>
> - alternate are represented as Rust enum, each variant being a 1-element
>   tuple
>
> - unions are represented in a similar way as in C: a struct S with a "u"
>   member (since S may have extra 'base' fields). The discriminant
>   isn't a member of S, since Rust enum already include it, but it can be
>   recovered with "mystruct.u.into()"
>
> Anything that includes a recursive struct puts it in a Box.  Lists are
> not considered recursive, because Vec breaks the recursion (it's possible
> to construct an object containing an empty Vec of its own type).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lurea=
u@redhat.com
> [Paolo: rewrite conversion of schema types to Rust types]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build              |   4 +-
>  scripts/qapi/backend.py  |  25 +++
>  scripts/qapi/common.py   |  43 +++++
>  scripts/qapi/rs.py       |  61 +++++++
>  scripts/qapi/rs_types.py | 373 +++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/schema.py   |  59 +++++--
>  6 files changed, 546 insertions(+), 19 deletions(-)
>  create mode 100644 scripts/qapi/rs.py
>  create mode 100644 scripts/qapi/rs_types.py
>
> diff --git a/meson.build b/meson.build
> index db87358d62d..4228792f0f6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3540,11 +3540,13 @@ qapi_gen_depends =3D [ meson.current_source_dir()=
 / 'scripts/qapi/__init__.py',
>                       meson.current_source_dir() / 'scripts/qapi/introspe=
ct.py',
>                       meson.current_source_dir() / 'scripts/qapi/main.py',
>                       meson.current_source_dir() / 'scripts/qapi/parser.p=
y',
> +                     meson.current_source_dir() / 'scripts/qapi/rs_types=
.py',
>                       meson.current_source_dir() / 'scripts/qapi/schema.p=
y',
>                       meson.current_source_dir() / 'scripts/qapi/source.p=
y',
>                       meson.current_source_dir() / 'scripts/qapi/types.py=
',
>                       meson.current_source_dir() / 'scripts/qapi/visit.py=
',
> -                     meson.current_source_dir() / 'scripts/qapi-gen.py'
> +                     meson.current_source_dir() / 'scripts/qapi-gen.py',
> +                     meson.current_source_dir() / 'scripts/qapi/rs.py',
>  ]
>=20=20
>  tracetool =3D [
> diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> index 49ae6ecdd33..8023acce0d6 100644
> --- a/scripts/qapi/backend.py
> +++ b/scripts/qapi/backend.py
> @@ -7,6 +7,7 @@
>  from .events import gen_events
>  from .features import gen_features
>  from .introspect import gen_introspect
> +from .rs_types import gen_rs_types
>  from .schema import QAPISchema
>  from .types import gen_types
>  from .visit import gen_visit
> @@ -63,3 +64,27 @@ def generate(self,
>          gen_commands(schema, output_dir, prefix, gen_tracing)
>          gen_events(schema, output_dir, prefix)
>          gen_introspect(schema, output_dir, prefix, unmask)
> +
> +
> +class QAPIRsBackend(QAPIBackend):
> +    # pylint: disable=3Dtoo-few-public-methods
> +
> +    def generate(self,
> +                 schema: QAPISchema,
> +                 output_dir: str,
> +                 prefix: str,
> +                 unmask: bool,
> +                 builtins: bool,
> +                 gen_tracing: bool) -> None:
> +        """
> +        Generate Rust code for the given schema into the target director=
y.
> +
> +        :param schema_file: The primary QAPI schema file.
> +        :param output_dir: The output directory to store generated code.
> +        :param prefix: Optional C-code prefix for symbol names.
> +        :param unmask: Expose non-ABI names through introspection?
> +        :param builtins: Generate code for built-in types?
> +
> +        :raise QAPIError: On failures.
> +        """
> +        gen_rs_types(schema, output_dir, prefix)
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index c75396a01b5..e9261a3411e 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -64,6 +64,13 @@ def camel_to_upper(value: str) -> str:
>      return ret.upper()
>=20=20
>=20=20
> +def camel_to_lower(value: str) -> str:
> +    """
> +    Converts CamelCase to camel_case.
> +    """
> +    return camel_to_upper(value).lower()
> +
> +
>  def c_enum_const(type_name: str,
>                   const_name: str,
>                   prefix: Optional[str] =3D None) -> str:
> @@ -129,6 +136,42 @@ def c_name(name: str, protect: bool =3D True) -> str:
>      return name
>=20=20
>=20=20
> +def rs_name(name: str) -> str:
> +    """
> +    Map @name to a valid, possibly raw Rust identifier.
> +    """
> +    name =3D re.sub(r'[^A-Za-z0-9_]', '_', name)
> +    if name[0].isnumeric():

.isdigit()?  It's what c_name() uses...

> +        name =3D '_' + name

In review of v1, I pointed to "The Rust Reference"

       Identifiers starting with an underscore are typically used to
       indicate an identifier that is intentionally unused, and will
       silence the unused warning in rustc.

       https://doc.rust-lang.org/reference/identifiers.html

You replied "In this case it doesn't really matter: public items (such
as QAPI enum entries, or struct fields) do not raise the unused warning
anyway."

What gives us confidence rs_name() will only be used where it doesn't
really matter?

> +    # based from the list:
> +    # https://doc.rust-lang.org/reference/keywords.html
> +    if name in ('Self', 'abstract', 'as', 'async',
> +                'await', 'become', 'box', 'break',
> +                'const', 'continue', 'crate', 'do',
> +                'dyn', 'else', 'enum', 'extern',
> +                'false', 'final', 'fn', 'for',
> +                'if', 'impl', 'in', 'let',
> +                'loop', 'macro', 'match', 'mod',
> +                'move', 'mut', 'override', 'priv',
> +                'pub', 'ref', 'return', 'self',
> +                'static', 'struct', 'super', 'trait',
> +                'true', 'try', 'type', 'typeof',
> +                'union', 'unsafe', 'unsized', 'use',
> +                'virtual', 'where', 'while', 'yield'):
> +        name =3D 'r#' + name

TIL...

> +    # avoid some clashes with the standard library
> +    if name in ('String',):
> +        name =3D 'Qapi' + name

This hides the unwise use of 'String' in qapi/net.json from Rust.  I'd
rather rename that one.

> +
> +    return name
> +
> +
> +def to_camel_case(value: str) -> str:
> +    return ''.join('_' + word if word[0].isdigit()
> +                   else word[:1].upper() + word[1:]
> +                   for word in filter(None, re.split("[-_]+", value)))

Please use r'...' for regular expressions always.

Why do you need filter()?

This maps 'foo-0123-bar' to 'Foo_0123Bar'.  Intentional?  I'd kind of
expect 'Foo0123Bar'.

> +
> +
>  class Indentation:
>      """
>      Indentation level management.
> diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
> new file mode 100644
> index 00000000000..2cf0c0e07f1
> --- /dev/null
> +++ b/scripts/qapi/rs.py
> @@ -0,0 +1,61 @@
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +"""
> +QAPI Rust generator
> +"""
> +
> +import os
> +import re
> +import subprocess
> +import sys
> +
> +from .common import mcgen as mcgen_common
> +from .gen import QAPIGen
> +from .schema import QAPISchemaVisitor
> +
> +
> +def mcgen(s: str, **kwds: object) -> str:
> +    s =3D mcgen_common(s, **kwds)
> +    return re.sub(r'(?: *\n)+', '\n', s)

This eats trailing spaces and blank lines.  The latter is a big hammer.
Without it, I see unwanted blank lines generated.  With it, I see wanted
blank lines eaten.  For instance:

    // @generated by qapi-gen, DO NOT EDIT

    //!
    //! Schema-defined QAPI types
    //!
    //! Copyright (c) 2025 Red Hat, Inc.
    //!
    //! This work is licensed under the terms of the GNU LGPL, version 2.1 =
or
    //! later. See the COPYING.LIB file in the top-level directory.

    #![allow(unexpected_cfgs)]
    #![allow(non_camel_case_types)]
    #![allow(clippy::empty_structs_with_brackets)]
    #![allow(clippy::large_enum_variant)]
    #![allow(clippy::pub_underscore_fields)]

    // Because QAPI structs can contain float, for simplicity we never
    // derive Eq.  Clippy however would complain for those structs
    // that *could* be Eq too.
    #![allow(clippy::derive_partial_eq_without_eq)]

    use serde_derive::{Serialize, Deserialize};

    use util::qobject::QObject;

becomes

    // @generated by qapi-gen, DO NOT EDIT
    //!
    //! Schema-defined QAPI types
    //!
    //! Copyright (c) 2025 Red Hat, Inc.
    //!
    //! This work is licensed under the terms of the GNU LGPL, version 2.1 =
or
    //! later. See the COPYING.LIB file in the top-level directory.
    #![allow(unexpected_cfgs)]
    #![allow(non_camel_case_types)]
    #![allow(clippy::empty_structs_with_brackets)]
    #![allow(clippy::large_enum_variant)]
    #![allow(clippy::pub_underscore_fields)]
    // Because QAPI structs can contain float, for simplicity we never
    // derive Eq.  Clippy however would complain for those structs
    // that *could* be Eq too.
    #![allow(clippy::derive_partial_eq_without_eq)]
    use serde_derive::{Serialize, Deserialize};
    use util::qobject::QObject;

This text is generated by QAPIGenRs._top() and
QAPISchemaGenRsTypeVisitor.visit_begin().  The blank lines are clearly
intentional there.

Hmm.

Possibly related: rustfmt below.

> +
> +
> +class QAPIGenRs(QAPIGen):
> +    def __init__(self, fname: str, blurb: str, pydoc: str):
> +        super().__init__(fname)
> +        self._blurb =3D blurb
> +        self._copyright =3D '\n//! '.join(re.findall(r'^Copyright .*', p=
ydoc,
> +                                                   re.MULTILINE))
> +
> +    def _top(self) -> str:
> +        return mcgen('''
> +// @generated by qapi-gen, DO NOT EDIT
> +
> +//!
> +//! Schema-defined QAPI types

I think you want %(blurb) here.

> +//!
> +//! %(copyright)s
> +//!
> +//! This work is licensed under the terms of the GNU LGPL, version 2.1 or
> +//! later. See the COPYING.LIB file in the top-level directory.
> +
> +''',
> +                     tool=3Dos.path.basename(sys.argv[0]),
> +                     blurb=3Dself._blurb, copyright=3Dself._copyright)
> +
> +
> +class QAPISchemaRsVisitor(QAPISchemaVisitor):
> +
> +    def __init__(self, prefix: str, what: str,
> +                 blurb: str, pydoc: str):
> +        super().__init__()
> +        self._prefix =3D prefix
> +        self._what =3D what
> +        self._gen =3D QAPIGenRs(self._prefix + self._what + '.rs', blurb=
, pydoc)

Break the line before blurb, please.

> +
> +    def write(self, output_dir: str) -> None:
> +        self._gen.write(output_dir)
> +
> +        try:
> +            subprocess.check_call(['rustfmt', self._gen.fname], cwd=3Dou=
tput_dir)

Break the line before cwd=3D, please.

> +        except FileNotFoundError:
> +            pass

This runs rustfmt to clean up the generated file.  Silently does nothing
if we don't have rustfmt.

Should we make rustfmt a hard requirement?  Please discuss this briefly
in the commit message.

> diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
> new file mode 100644
> index 00000000000..64702eb54ae
> --- /dev/null
> +++ b/scripts/qapi/rs_types.py

[Interesting part left for tomorrow...]

> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 15f5d97418f..a65b25141fa 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -37,6 +37,7 @@
>      docgen_ifcond,
>      gen_endif,
>      gen_if,
> +    rs_name,
>      rsgen_ifcond,
>  )
>  from .error import QAPIError, QAPISemError, QAPISourceError
> @@ -341,6 +342,11 @@ def c_param_type(self) -> str:
   class QAPISchemaType(QAPISchemaDefinition, ABC):
       # Return the C type for common use.
       # For the types we commonly box, this is a pointer type.
       @abstractmethod
       def c_type(self) -> str:
           pass

       # Return the C type to be used in a parameter list.
       def c_param_type(self) -> str:
           return self.c_type()

       # Return the C type to be used where we suppress boxing.
>      def c_unboxed_type(self) -> str:
>          return self.c_type()
>=20=20
> +    # Return the Rust type for common use

Are the uncommon uses?

There are for C types, and that's why we have both .c_type(),
.c_param_type(), nad .c_unboxed_type().

> +    @abstractmethod
> +    def rs_type(self) -> str:
> +        pass
> +
>      @abstractmethod
>      def json_type(self) -> str:
>          pass
> @@ -382,11 +388,12 @@ def describe(self) -> str:
>  class QAPISchemaBuiltinType(QAPISchemaType):
>      meta =3D 'built-in'
>=20=20
> -    def __init__(self, name: str, json_type: str, c_type: str):
> +    def __init__(self, name: str, json_type: str, rs_type: str, c_type: =
str):
>          super().__init__(name, None, None)
>          assert json_type in ('string', 'number', 'int', 'boolean', 'null=
',
>                               'value')
>          self._json_type_name =3D json_type
> +        self._rs_type_name =3D rs_type
>          self._c_type_name =3D c_type
>=20=20
>      def c_name(self) -> str:
> @@ -406,6 +413,9 @@ def json_type(self) -> str:
>      def doc_type(self) -> str:
>          return self.json_type()
>=20=20
> +    def rs_type(self) -> str:
> +        return self._rs_type_name
> +
>      def visit(self, visitor: QAPISchemaVisitor) -> None:
>          super().visit(visitor)
>          visitor.visit_builtin_type(self.name, self.info, self.json_type(=
))
> @@ -449,6 +459,9 @@ def is_implicit(self) -> bool:
>      def c_type(self) -> str:
>          return c_name(self.name)
>=20=20
> +    def rs_type(self) -> str:
> +        return rs_name(self.name)
> +
>      def member_names(self) -> List[str]:
>          return [m.name for m in self.members]
>=20=20
> @@ -498,6 +511,9 @@ def is_implicit(self) -> bool:
>      def c_type(self) -> str:
>          return c_name(self.name) + POINTER_SUFFIX
>=20=20
> +    def rs_type(self) -> str:
> +        return 'Vec<%s>' % self.element_type.rs_type()

This may be called only after .check(), because that's when
.element_type becomes valid.  .ifcond() has the same precondition, and
states it explicitly with assert self._checked.  Let's do the same here.

> +
>      def json_type(self) -> str:
>          return 'array'
>=20=20
> @@ -630,6 +646,9 @@ def c_type(self) -> str:
>      def c_unboxed_type(self) -> str:
>          return c_name(self.name)
>=20=20
> +    def rs_type(self) -> str:
> +        return rs_name(self.name)
> +
>      def json_type(self) -> str:
>          return 'object'
>=20=20
> @@ -711,6 +730,9 @@ def c_type(self) -> str:
>      def json_type(self) -> str:
>          return 'value'
>=20=20
> +    def rs_type(self) -> str:
> +        return rs_name(self.name)
> +
>      def visit(self, visitor: QAPISchemaVisitor) -> None:
>          super().visit(visitor)
>          visitor.visit_alternate_type(
> @@ -1234,9 +1256,10 @@ def _def_include(self, expr: QAPIExpression) -> No=
ne:
>              QAPISchemaInclude(self._make_module(include), expr.info))
>=20=20
>      def _def_builtin_type(
> -        self, name: str, json_type: str, c_type: str
> +        self, name: str, json_type: str, rs_type: str, c_type: str
>      ) -> None:
> -        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_ty=
pe))
> +        builtin =3D QAPISchemaBuiltinType(name, json_type, rs_type, c_ty=
pe)
> +        self._def_definition(builtin)
>          # Instantiating only the arrays that are actually used would
>          # be nice, but we can't as long as their generated code
>          # (qapi-builtin-types.[ch]) may be shared by some other
> @@ -1255,21 +1278,21 @@ def is_predefined(self, name: str) -> bool:
>          return False
>=20=20
>      def _def_predefineds(self) -> None:
> -        for t in [('str',    'string',  'char' + POINTER_SUFFIX),
> -                  ('number', 'number',  'double'),
> -                  ('int',    'int',     'int64_t'),
> -                  ('int8',   'int',     'int8_t'),
> -                  ('int16',  'int',     'int16_t'),
> -                  ('int32',  'int',     'int32_t'),
> -                  ('int64',  'int',     'int64_t'),
> -                  ('uint8',  'int',     'uint8_t'),
> -                  ('uint16', 'int',     'uint16_t'),
> -                  ('uint32', 'int',     'uint32_t'),
> -                  ('uint64', 'int',     'uint64_t'),
> -                  ('size',   'int',     'uint64_t'),
> -                  ('bool',   'boolean', 'bool'),
> -                  ('any',    'value',   'QObject' + POINTER_SUFFIX),
> -                  ('null',   'null',    'QNull' + POINTER_SUFFIX)]:
> +        for t in [('str',    'string',  'String',  'char' + POINTER_SUFF=
IX),
> +                  ('number', 'number',  'f64',     'double'),
> +                  ('int',    'int',     'i64',     'int64_t'),
> +                  ('int8',   'int',     'i8',      'int8_t'),
> +                  ('int16',  'int',     'i16',     'int16_t'),
> +                  ('int32',  'int',     'i32',     'int32_t'),
> +                  ('int64',  'int',     'i64',     'int64_t'),
> +                  ('uint8',  'int',     'u8',      'uint8_t'),
> +                  ('uint16', 'int',     'u16',     'uint16_t'),
> +                  ('uint32', 'int',     'u32',     'uint32_t'),
> +                  ('uint64', 'int',     'u64',     'uint64_t'),
> +                  ('size',   'int',     'u64',     'uint64_t'),
> +                  ('bool',   'boolean', 'bool',    'bool'),
> +                  ('any',    'value',   'QObject', 'QObject' + POINTER_S=
UFFIX),
> +                  ('null',   'null',    '()',      'QNull' + POINTER_SUF=
FIX)]:
>              self._def_builtin_type(*t)
>          self.the_empty_object_type =3D QAPISchemaObjectType(
>              'q_empty', None, None, None, None, None, [], None)


