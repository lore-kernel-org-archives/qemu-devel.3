Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A562DD65C46
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 13:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVrdb-0006Ti-15; Wed, 17 Dec 2025 08:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVrdV-0006St-Mn
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 08:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vVrdT-0006ZP-C5
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 08:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765978330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlClCP04KEhWjdsKQcmn/ZHOyIpyi7Wz4RUkFJVZwbo=;
 b=Ykusd8/tpdPpcMQwIx6NNFZwJt3/UzrrB4KZ5jDmIzIaTghAQjP1KNuww8S7UASGpoDgGp
 3isxYktSGynWwH1y2Z+p3WewhMwJLsRJd4fcr+Z3904Qkr5nE9OcX4ExND2f35qSELAgHR
 JOhI/f4xbkp6U3f5+Tm479Eq6DNovbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-CBYg6NUfNkKT8bHJ27nVvA-1; Wed,
 17 Dec 2025 08:32:07 -0500
X-MC-Unique: CBYg6NUfNkKT8bHJ27nVvA-1
X-Mimecast-MFC-AGG-ID: CBYg6NUfNkKT8bHJ27nVvA_1765978326
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77EC2195608F; Wed, 17 Dec 2025 13:32:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0186180035A; Wed, 17 Dec 2025 13:32:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70BDB21E6A27; Wed, 17 Dec 2025 14:32:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <20251010151006.791038-15-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:59 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-15-pbonzini@redhat.com>
Date: Wed, 17 Dec 2025 14:32:03 +0100
Message-ID: <87wm2lkze4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Generate high-level native Rust declarations for the QAPI types.
>
> - char* is mapped to String, scalars to there corresponding Rust types
>
> - enums are simply aliased from FFI
>
> - has_foo/foo members are mapped to Option<T>
>
> - lists are represented as Vec<T>
>
> - structures have Rust versions, with To/From FFI conversions
>
> - alternate are represented as Rust enum
>
> - unions are represented in a similar way as in C: a struct S with a "u"
>   member (since S may have extra 'base' fields). However, the discriminant
>   isn't a member of S, since Rust enum already include it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lurea=
u@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build              |   4 +-
>  scripts/qapi/backend.py  |  27 ++-
>  scripts/qapi/main.py     |   4 +-
>  scripts/qapi/rs.py       | 181 +++++++++++++++++++
>  scripts/qapi/rs_types.py | 365 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 577 insertions(+), 4 deletions(-)
>  create mode 100644 scripts/qapi/rs.py
>  create mode 100644 scripts/qapi/rs_types.py
>
> diff --git a/meson.build b/meson.build
> index afaefa01722..ce914217c52 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3571,12 +3571,14 @@ qapi_gen_depends =3D [ meson.current_source_dir()=
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
>                       meson.current_source_dir() / 'scripts/qapi/features=
.py',
>                       meson.current_source_dir() / 'scripts/qapi/visit.py=
',
> -                     meson.current_source_dir() / 'scripts/qapi-gen.py'
> +                     meson.current_source_dir() / 'scripts/qapi-gen.py',
> +                     meson.current_source_dir() / 'scripts/qapi/rs.py',
>  ]
>=20=20
>  tracetool =3D [
> diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> index 49ae6ecdd33..305b62b514c 100644
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
> @@ -36,7 +37,7 @@ def generate(self,
>          """
>=20=20
>=20=20
> -class QAPICBackend(QAPIBackend):
> +class QAPICodeBackend(QAPIBackend):

Why this rename?

If we want it, separate commit, please.

>      # pylint: disable=3Dtoo-few-public-methods
>=20=20
>      def generate(self,
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
> +        gen_rs_types(schema, output_dir, prefix, builtins)

As discussed in reply to the cover letter, this series uses the -B
plumbing for out-of-tree backends for generating Rust.  Fine for a
prototype.  This class is the glue between -B and Rust generation.

> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 0e2a6ae3f07..4ad75e213f5 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -12,7 +12,7 @@
>  import sys
>  from typing import Optional
>=20=20
> -from .backend import QAPIBackend, QAPICBackend
> +from .backend import QAPIBackend, QAPICodeBackend
>  from .common import must_match
>  from .error import QAPIError
>  from .schema import QAPISchema
> @@ -27,7 +27,7 @@ def invalid_prefix_char(prefix: str) -> Optional[str]:
>=20=20
>  def create_backend(path: str) -> QAPIBackend:
>      if path is None:
> -        return QAPICBackend()
> +        return QAPICodeBackend()
>=20=20
>      module_path, dot, class_name =3D path.rpartition('.')
>      if not dot:
> diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
> new file mode 100644
> index 00000000000..2a9bbcb9f54
> --- /dev/null
> +++ b/scripts/qapi/rs.py
> @@ -0,0 +1,181 @@
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +"""
> +QAPI Rust generator
> +"""
> +
> +import os
> +import re
> +import subprocess
> +from typing import NamedTuple, Optional
> +
> +from .common import POINTER_SUFFIX
> +from .gen import QAPIGen
> +from .schema import QAPISchemaModule, QAPISchemaVisitor
> +
> +
> +# see to_upper_case()/to_lower_case() below
> +snake_case =3D re.compile(r'((?<=3D[a-z0-9])[A-Z]|(?!^)[A-Z](?=3D[a-z]))=
')
> +
> +
> +rs_name_trans =3D str.maketrans('.-', '__')
> +
> +
> +# Map @name to a valid Rust identifier.
> +# If @protect, avoid returning certain ticklish identifiers (like
> +# keywords) by prepending raw identifier prefix 'r#'.
> +def rs_name(name: str, protect: bool =3D True) -> str:
> +    name =3D name.translate(rs_name_trans)
> +    if name[0].isnumeric():
> +        name =3D '_' + name
> +    if not protect:
> +        return name
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
> +    # avoid some clashes with the standard library
> +    if name in ('String',):
> +        name =3D 'Qapi' + name
> +
> +    return name

This is like common.c_name().  Differences:

1. Funny input characters

   c_name() returns a valid C identifier for any non-empty input.

   rs_name() requires its argument to contain only characters valid in
   Rust identifiers plus '.' and '-'.

   I think we better avoid this difference.

2. "Protected" identifiers

   When @protect, then certain "protected" identifiers are prefixed with
   'q_'.  We typically pass False to @protect when the output is used as
   part of an identifier.

   c_name() and rs_name() protect different identifiers.  Makes sense.

3. Input starting with a digit

   c_name() treats them just like protected identifiers, i.e. prefix
   with 'q_' when @protect.

   rs_name() prefixes with '_'.  Is this a good idea?  Hmm...  "The Rust
   Reference:

       Note

       Identifiers starting with an underscore are typically used to
       indicate an identifier that is intentionally unused, and will
       silence the unused warning in rustc.

       https://doc.rust-lang.org/reference/identifiers.html

   rs_name() prefixes always, not just when @protect.  Is this a good
   idea?  Remember, @protect is typically false when the output is used
   as part of an identifier.  Or do we use it differently for Rust?

4. Name clash avoidance

   c_name() treats names that are prone to clash as protected,
   i.e. prefix 'q_' unless @protect.

   rs_name() prefixes 'Qapi' instead.  Why?

> +
> +
> +def rs_type(c_type: str,
> +            qapi_ns: str =3D 'qapi::',
> +            optional: bool =3D False,
> +            box: bool =3D False) -> str:
> +    (is_pointer, _, is_list, c_type) =3D rs_ctype_parse(c_type)
> +    to_rs =3D {
> +        'QNull': '()',
> +        'QObject': 'QObject',
> +        'any': 'QObject',
> +        'bool': 'bool',
> +        'char': 'i8',
> +        'double': 'f64',
> +        'int': 'i64',
> +        'int16': 'i16',
> +        'int16_t': 'i16',
> +        'int32': 'i32',
> +        'int32_t': 'i32',
> +        'int64': 'i64',
> +        'int64_t': 'i64',
> +        'int8': 'i8',
> +        'int8_t': 'i8',
> +        'number': 'f64',
> +        'size': 'u64',
> +        'str': 'String',
> +        'uint16': 'u16',
> +        'uint16_t': 'u16',
> +        'uint32': 'u32',
> +        'uint32_t': 'u32',
> +        'uint64': 'u64',
> +        'uint64_t': 'u64',
> +        'uint8': 'u8',
> +        'uint8_t': 'u8',
> +        'String': 'QapiString',
> +    }

The argument name @c_type suggests it is a C type, but this map contains
a mix of C types, QAPI built-in types, and even a user-defined QAPI type
(String).  How come?

Why do we even have to map from C type to Rust type?  Why can't we map
from QAPI type to Rust type, like we map from QAPI type to C type?

> +    if is_pointer:
> +        to_rs.update({
> +            'char': 'String',
> +        })
> +
> +    if is_list:
> +        c_type =3D c_type[:-4]
> +
> +    ret =3D to_rs.get(c_type, qapi_ns + c_type)
> +    if is_list:
> +        ret =3D 'Vec<%s>' % ret
> +    elif is_pointer and c_type not in to_rs and box:
> +        ret =3D 'Box<%s>' % ret
> +    if optional:
> +        ret =3D 'Option<%s>' % ret
> +    return ret
> +
> +
> +class CType(NamedTuple):
> +    is_pointer: bool
> +    is_const: bool
> +    is_list: bool
> +    c_type: str
> +
> +
> +def rs_ctype_parse(c_type: str) -> CType:
> +    is_pointer =3D False
> +    if c_type.endswith(POINTER_SUFFIX):
> +        is_pointer =3D True
> +        c_type =3D c_type[:-len(POINTER_SUFFIX)]
> +    is_list =3D c_type.endswith('List')
> +    is_const =3D False
> +    if c_type.startswith('const '):
> +        is_const =3D True
> +        c_type =3D c_type[6:]
> +
> +    c_type =3D rs_name(c_type)
> +    return CType(is_pointer, is_const, is_list, c_type)

This feels a bit brittle.

> +
> +
> +def to_camel_case(value: str) -> str:
> +    # special case for last enum value
> +    if value =3D=3D '_MAX':
> +        return value
> +    raw_id =3D False
> +    if value.startswith('r#'):
> +        raw_id =3D True
> +        value =3D value[2:]
> +    value =3D ''.join('_' + word if word[0].isdigit()
> +                    else word[:1].upper() + word[1:]
> +                    for word in filter(None, re.split("[-_]+", value)))
> +    if raw_id:
> +        return 'r#' + value
> +    return value
> +
> +
> +def to_upper_case(value: str) -> str:
> +    return snake_case.sub(r'_\1', value).upper()

This tackles the same problem as common.camel_to_upper().  Your code is
much simpler.  However, the two produce different output, e.g.

    input                       output
    QType                       QTYPE
                                Q_TYPE
    XDbgBlockGraphNodeType      XDBG_BLOCK_GRAPH_NODE_TYPE
                                X_DBG_BLOCK_GRAPH_NODE_TYPE
    QCryptoTLSCredsEndpoint     QCRYPTO_TLS_CREDS_ENDPOINT
                                Q_CRYPTO_TLS_CREDS_ENDPOINT

I doubt having two different mappings from CamelCase make sense.

See also commit 7b29353fdd9 (qapi: Smarter camel_to_upper() to reduce
need for 'prefix').

Aside: the examples in camel_to_upper()'s function comment are out of
date.  I'll take care of that.

> +
> +
> +def to_lower_case(value: str) -> str:
> +    return snake_case.sub(r'_\1', value).lower()
> +
> +
> +class QAPIGenRs(QAPIGen):
> +    pass

In my initial review of the generated code, I suggested a file comment.
Code for that would go here.  See QAPIGenC for an example.

> +
> +
> +class QAPISchemaRsVisitor(QAPISchemaVisitor):
> +
> +    def __init__(self, prefix: str, what: str):
> +        super().__init__()
> +        self._prefix =3D prefix
> +        self._what =3D what
> +        self._gen =3D QAPIGenRs(self._prefix + self._what + '.rs')
> +        self._main_module: Optional[str] =3D None
> +
> +    def visit_module(self, name: Optional[str]) -> None:
> +        if name is None:
> +            return
> +        if QAPISchemaModule.is_user_module(name):
> +            if self._main_module is None:
> +                self._main_module =3D name

._main_module appears to be unused.

> +
> +    def write(self, output_dir: str) -> None:
> +        self._gen.write(output_dir)
> +
> +        pathname =3D os.path.join(output_dir, self._gen.fname)

This duplicates ._gen.write()'s file name construction.  I think we
better make it a available from ._gen.

> +        try:
> +            subprocess.check_call(['rustfmt', pathname])

Interesting.  Worth mentioning in the commit message.

> +        except FileNotFoundError:
> +            pass

Huh?

Gotta run, rest left for later.

[...]


