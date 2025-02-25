Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C4BC021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmu6k-0008Nj-6y; Tue, 25 Feb 2025 07:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tmu6c-0008MH-7Z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tmu6Z-0002A8-DA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740486723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDh06e8kTtZF3b7EaISMI+rp/LjzoQejshGe5Ip6rKU=;
 b=g6siLM7z24Kpo0RIkOzsmBLTeDg++QvPELUdO5cnRqwHC4NW+HpasCnDhyjUixVaOb7UyD
 pFYovY4doogfjIgpVTsMdEbEzjgha0UtjjxB0xOD3poi3ulFknLG7qT1GhgAE5rdGA3/XT
 FaA+XTtsrCa15pKjfPYsST7kLgGi8c8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-D08dusr1Maacj5GhnjSnzw-1; Tue,
 25 Feb 2025 07:32:01 -0500
X-MC-Unique: D08dusr1Maacj5GhnjSnzw-1
X-Mimecast-MFC-AGG-ID: D08dusr1Maacj5GhnjSnzw_1740486720
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F4F218EB2C6; Tue, 25 Feb 2025 12:32:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0218919560B9; Tue, 25 Feb 2025 12:31:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D95A21E66B9; Tue, 25 Feb 2025 13:31:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Victor Toso <victortoso@redhat.com>,  Michael
 Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] qapi: pluggable backend code generators
In-Reply-To: <20250224182030.2089959-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 24 Feb 2025 18:20:30
 +0000")
References: <20250224182030.2089959-1-berrange@redhat.com>
Date: Tue, 25 Feb 2025 13:31:56 +0100
Message-ID: <87msea9pdv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> The 'qapi.backend.QAPIBackend' class defines an API contract for code
> generators. The current generator is put into a new class
> 'qapi.backend.QAPICBackend' and made to be the default impl.
>
> A custom generator can be requested using the '-k' arg which takes a

Missed an instance of -k.  Can fix this myself.

> fully qualified python class name
>
>    qapi-gen.py -B the.python.module.QAPIMyBackend
>
> This allows out of tree code to use the QAPI generator infrastructure
> to create new language bindings for QAPI schemas. This has the caveat
> that the QAPI generator APIs are not guaranteed stable, so consumers
> of this feature may have to update their code to be compatible with
> future QEMU releases.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> In v2:
>
>  - Create QAPISchema object ahead of calling backend
>  - Use -B instead of -k
>  - Fix mypy annotations
>  - Add error checking when loading backend
>  - Hardcode import of QAPICBackend to guarantee mypy coverage
>
>  scripts/qapi/backend.py | 63 ++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py    | 75 ++++++++++++++++++++++-------------------
>  2 files changed, 103 insertions(+), 35 deletions(-)
>  create mode 100644 scripts/qapi/backend.py
>
> diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> new file mode 100644
> index 0000000000..14e60aa67a
> --- /dev/null
> +++ b/scripts/qapi/backend.py
> @@ -0,0 +1,63 @@
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +
> +from abc import ABC, abstractmethod
> +
> +from .commands import gen_commands
> +from .events import gen_events
> +from .features import gen_features
> +from .introspect import gen_introspect
> +from .schema import QAPISchema
> +from .types import gen_types
> +from .visit import gen_visit
> +
> +
> +class QAPIBackend(ABC):
> +
> +    @abstractmethod
> +    def generate(self,
> +                 schema: QAPISchema,
> +                 output_dir: str,
> +                 prefix: str,
> +                 unmask: bool,
> +                 builtins: bool,
> +                 gen_tracing: bool) -> None:
> +        """
> +        Generate code for the given schema into the target directory.
> +
> +        :param schema: The primary QAPI schema object.
> +        :param output_dir: The output directory to store generated code.
> +        :param prefix: Optional C-code prefix for symbol names.
> +        :param unmask: Expose non-ABI names through introspection?
> +        :param builtins: Generate code for built-in types?
> +
> +        :raise QAPIError: On failures.
> +        """
> +
> +
> +class QAPICBackend(QAPIBackend):
> +
> +    def generate(self,
> +                 schema: QAPISchema,
> +                 output_dir: str,
> +                 prefix: str,
> +                 unmask: bool,
> +                 builtins: bool,
> +                 gen_tracing: bool) -> None:
> +        """
> +        Generate C code for the given schema into the target directory.
> +
> +        :param schema_file: The primary QAPI schema file.
> +        :param output_dir: The output directory to store generated code.
> +        :param prefix: Optional C-code prefix for symbol names.
> +        :param unmask: Expose non-ABI names through introspection?
> +        :param builtins: Generate code for built-in types?
> +
> +        :raise QAPIError: On failures.
> +        """
> +        gen_types(schema, output_dir, prefix, builtins)
> +        gen_features(schema, output_dir, prefix)
> +        gen_visit(schema, output_dir, prefix, builtins)
> +        gen_commands(schema, output_dir, prefix, gen_tracing)
> +        gen_events(schema, output_dir, prefix)
> +        gen_introspect(schema, output_dir, prefix, unmask)
> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 324081b9fc..8a8b1e0121 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -8,18 +8,14 @@
>  """
>=20=20
>  import argparse
> +from importlib import import_module
>  import sys
>  from typing import Optional
>=20=20
> -from .commands import gen_commands
> +from .backend import QAPIBackend, QAPICBackend
>  from .common import must_match
>  from .error import QAPIError
> -from .events import gen_events
> -from .features import gen_features
> -from .introspect import gen_introspect
>  from .schema import QAPISchema
> -from .types import gen_types
> -from .visit import gen_visit
>=20=20
>=20=20
>  def invalid_prefix_char(prefix: str) -> Optional[str]:
> @@ -29,32 +25,37 @@ def invalid_prefix_char(prefix: str) -> Optional[str]:
>      return None
>=20=20
>=20=20
> -def generate(schema_file: str,
> -             output_dir: str,
> -             prefix: str,
> -             unmask: bool =3D False,
> -             builtins: bool =3D False,
> -             gen_tracing: bool =3D False) -> None:
> -    """
> -    Generate C code for the given schema into the target directory.
> +def create_backend(path: str) -> QAPIBackend:
> +    if path is None:
> +        return QAPICBackend()
>=20=20
> -    :param schema_file: The primary QAPI schema file.
> -    :param output_dir: The output directory to store generated code.
> -    :param prefix: Optional C-code prefix for symbol names.
> -    :param unmask: Expose non-ABI names through introspection?
> -    :param builtins: Generate code for built-in types?
> +    if "." not in path:
> +        print(f"Missing qualified module path in '{path}'", file=3Dsys.s=
tderr)
> +        sys.exit(1)
>=20=20
> -    :raise QAPIError: On failures.
> -    """
> -    assert invalid_prefix_char(prefix) is None
> +    module_path, _, class_name =3D path.rpartition('.')

I'd like to tweak this to

       module_path, dot, class_name =3D path.rpartition('.')
       if not dot:
           print(f"argument of -B must be of the form MODULE.CLASS",
                 file=3Dsys.stderr)
           sys.exit(1)

> +    try:
> +        mod =3D import_module(module_path)
> +    except Exception as ex:

pylint complains:

    scripts/qapi/main.py:39:11: W0718: Catching too general exception Excep=
tion (broad-exception-caught)

I can't see offhand what exception(s) we're supposed to catch here, so
let's not worry about this now.

> +        print(f"Unable to import '{module_path}': {ex}", file=3Dsys.stde=
rr)
> +        sys.exit(1)
> +
> +    if not hasattr(mod, class_name):
> +        print(f"Module '{module_path}' has no class '{class_name}'", fil=
e=3Dsys.stderr)

pycodestyle-3 complains:

    scripts/qapi/main.py:44:80: E501 line too long (85 > 79 characters)

Let's break the line after the comma, and also start the error message
in lower case for consistency with error messages elsewhere.

> +        sys.exit(1)
> +    klass =3D getattr(mod, class_name)

Alternatively

       try:
           klass =3D getattr(mod, class_name)
       except AttributeError:
           print(f"module '{module_path}' has no class '{class_name}'",
                 file=3Dsys.stderr)
           sys.exit(1)

Admittedly a matter of taste.  I tend to avoid the

    if frobnicate would fail:
        error out
    frobnicate

pattern when practical.

> +
> +    try:
> +        backend =3D klass()

> +
> +        if not isinstance(backend, QAPIBackend):
> +            print(f"Backend '{path}' must be an instance of QAPIBackend"=
, file=3Dsys.stderr)

Likewise.

> +            sys.exit(1)
>=20=20
> -    schema =3D QAPISchema(schema_file)
> -    gen_types(schema, output_dir, prefix, builtins)
> -    gen_features(schema, output_dir, prefix)
> -    gen_visit(schema, output_dir, prefix, builtins)
> -    gen_commands(schema, output_dir, prefix, gen_tracing)
> -    gen_events(schema, output_dir, prefix)
> -    gen_introspect(schema, output_dir, prefix, unmask)
> +        return backend
> +    except Exception as ex:

Likewise too general exception.

I'd like to shrink the try block and reduce the nesting:

       try:
           backend =3D klass()
       except Exception as ex:
           print(f"Backend '{path}' cannot be instantiated: {ex}", file=3Ds=
ys.stderr)
           sys.exit(1)

       if not isinstance(backend, QAPIBackend):
           print(f"Backend '{path}' must be an instance of QAPIBackend", fi=
le=3Dsys.stderr)
           sys.exit(1)

       return backend

> +        print(f"Backend '{path}' cannot be instantiated: {ex}", file=3Ds=
ys.stderr)

Likewise line too long.

> +        sys.exit(1)
>=20=20
>=20=20
>  def main() -> int:
> @@ -77,6 +78,8 @@ def main() -> int:
>      parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_=
true',
>                          dest=3D'unmask',
>                          help=3D"expose non-ABI names in introspection")
> +    parser.add_argument('-B', '--backend', default=3DNone,
> +                        help=3D"Python module name for code generator")
>=20=20
>      # Option --suppress-tracing exists so we can avoid solving build sys=
tem
>      # problems.  TODO Drop it when we no longer need it.
> @@ -93,12 +96,14 @@ def main() -> int:
>          return 1
>=20=20
>      try:
> -        generate(args.schema,
> -                 output_dir=3Dargs.output_dir,
> -                 prefix=3Dargs.prefix,
> -                 unmask=3Dargs.unmask,
> -                 builtins=3Dargs.builtins,
> -                 gen_tracing=3Dnot args.suppress_tracing)
> +        schema =3D QAPISchema(args.schema)
> +        backend =3D create_backend(args.backend)
> +        backend.generate(schema,
> +                         output_dir=3Dargs.output_dir,
> +                         prefix=3Dargs.prefix,
> +                         unmask=3Dargs.unmask,
> +                         builtins=3Dargs.builtins,
> +                         gen_tracing=3Dnot args.suppress_tracing)
>      except QAPIError as err:
>          print(err, file=3Dsys.stderr)
>          return 1

Error reporting test cases:

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B nonexistent qapi/qapi-schema=
.json=20
argument of -B must be of the form MODULE.CLASS

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B qapi.backend.foo qapi/qapi-s=
chema.json=20
module 'qapi.backend' has no class 'foo'

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B nonexistent qapi/qapi-schema=
.json=20
$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B nonexistent qapi/qapi-schema=
.json=20
argument of -B must be of the form MODULE.CLASS

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B nonexistent.foo qapi/qapi-sc=
hema.json=20
unable to import 'nonexistent': No module named 'nonexistent'

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B qapi.backend.foo qapi/qapi-s=
chema.json=20
module 'qapi.backend' has no class 'foo'

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B qapi.backend.QAPIBackend qap=
i/qapi-schema.json=20
backend 'qapi.backend.QAPIBackend' cannot be instantiated: Can't instantiat=
e abstract class QAPIBackend without an implementation for abstract method =
'generate'

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -B qapi.common.Indentation qapi=
/qapi-schema.json=20
backend 'qapi.common.Indentation' must be an instance of QAPIBackend

Good enough.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

No need to respin, I can make the tweaks I suggested myself.  Feel free
to challenge my suggestions, of course.


