Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9F2C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 07:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1SH-0004AX-9P; Thu, 20 Feb 2025 02:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tl1SE-0004AJ-4A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 02:58:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tl1S9-0004Hj-Qu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 02:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740038315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7f1/xs1NcxUWeW/O1egAGp+M9gkPcoGFKe3C3ld67k=;
 b=MsPs4FT0IHcz5HDo4JyOFvVy5UhZyjZy2TBofWfr8B8CBdZcSBBZnHiU1cwNqf9RlUDrmE
 1lLCktzGmZSZj5Zg+KamseE+SZQW4E7PbJRqSh8+vAKtiHdqqatVpzIdf67FkCWo8k4qER
 ccMon0igfGc/Htw+Q4mvXt4xxm0rKcw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-adwn7oJ4NMWCozBqQ1uedQ-1; Thu,
 20 Feb 2025 02:58:22 -0500
X-MC-Unique: adwn7oJ4NMWCozBqQ1uedQ-1
X-Mimecast-MFC-AGG-ID: adwn7oJ4NMWCozBqQ1uedQ_1740038301
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F6431800875; Thu, 20 Feb 2025 07:58:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E44E21955BCB; Thu, 20 Feb 2025 07:58:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5713021E6A28; Thu, 20 Feb 2025 08:58:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Victor Toso <victortoso@redhat.com>,  Michael
 Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] qapi: pluggable backend code generators
In-Reply-To: <20250217134927.1288486-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 17 Feb 2025 13:49:27
 +0000")
References: <20250217134927.1288486-1-berrange@redhat.com>
Date: Thu, 20 Feb 2025 08:58:17 +0100
Message-ID: <87ikp5ujxi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cc: John for advice on my somewhat nebulous mypy worries at the end.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'qapi.backend.QAPIBackend' class defines an API contract for
> code generators. The current generator is put into a new class
> 'qapi.backend.QAPICBackend' and made to be the default impl.
>
> A custom generator can be requested using the '-k' arg which takes
> a fully qualified python class name
>
>    qapi-gen.py -k the.python.module.QAPIMyBackend

I understand why that will be useful, but explaining it briefly in the
commit message wouldn't hurt.

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> This is an impl of the idea I mentioned at:
>
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-02/msg03475.html
>
> With this change, it is possible for the Go generator code to live
> outside of qemu.git, invoked using:
>
>   $ PYTHONPATH=3D/path/to/qemu.git/scripts \
>     python /path/to/qemu.git/scripts/qapi-gen.py \
>       -o somedir \
>       -k qapi.golang.golang.QAPIGoBackend \
>       /path/to/qemu.git/qga/qapi-schema.json
>
> The external app could just expect qemu.git to be checkedout somewhere
> convenient, or could use a git submodule to reference it.
>
>  scripts/qapi/backend.py | 96 +++++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py    | 65 ++++++++--------------------
>  2 files changed, 113 insertions(+), 48 deletions(-)
>  create mode 100644 scripts/qapi/backend.py
>
> diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> new file mode 100644
> index 0000000000..b6873fd2e3
> --- /dev/null
> +++ b/scripts/qapi/backend.py
> @@ -0,0 +1,96 @@
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +
> +from abc import ABC, abstractmethod
> +from typing import Optional
> +
> +from .commands import gen_commands
> +from .common import must_match
> +from .events import gen_events
> +from .features import gen_features
> +from .introspect import gen_introspect
> +from .schema import QAPISchema
> +from .types import gen_types
> +from .visit import gen_visit
> +
> +
> +def invalid_prefix_char(prefix: str) -> Optional[str]:
> +    match =3D must_match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
> +    if match.end() !=3D len(prefix):
> +        return prefix[match.end()]
> +    return None
> +
> +
> +class QAPIBackend(ABC):
> +
> +    def run(self,
> +            schema_file: str,
> +            output_dir: str,
> +            prefix: str,
> +            unmask: bool =3D False,
> +            builtins: bool =3D False,
> +            gen_tracing: bool =3D False) -> None:
> +        """
> +        Run the code generator for the given schema into the target dire=
ctory.
> +
> +        :param schema_file: The primary QAPI schema file.
> +        :param output_dir: The output directory to store generated code.
> +        :param prefix: Optional C-code prefix for symbol names.
> +        :param unmask: Expose non-ABI names through introspection?
> +        :param builtins: Generate code for built-in types?
> +
> +        :raise QAPIError: On failures.
> +        """
> +        assert invalid_prefix_char(prefix) is None
> +
> +        schema =3D QAPISchema(schema_file)

Hmm.  This makes the backend run the frontend.  Could we keep this in
main.py instead?

> +        self.generate(schema, output_dir, prefix, unmask, builtins, gen_=
tracing)
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
> +        pass

pylint prefers not to pass:

    scripts/qapi/backend.py:68:8: W0107: Unnecessary pass statement (unnece=
ssary-pass)

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
> index 324081b9fc..35552dffce 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -8,53 +8,18 @@
>  """
>=20=20
>  import argparse
> +from importlib import import_module
>  import sys
> -from typing import Optional
>=20=20
> -from .commands import gen_commands
> -from .common import must_match
>  from .error import QAPIError
> -from .events import gen_events
> -from .features import gen_features
> -from .introspect import gen_introspect
> -from .schema import QAPISchema
> -from .types import gen_types
> -from .visit import gen_visit
> +from .backend import invalid_prefix_char

isort wants you to put this above from .error, like this:

   from .backend import invalid_prefix_char
   from .error import QAPIError

>=20=20
>=20=20
> -def invalid_prefix_char(prefix: str) -> Optional[str]:
> -    match =3D must_match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', prefix)
> -    if match.end() !=3D len(prefix):
> -        return prefix[match.end()]
> -    return None
> -
> -
> -def generate(schema_file: str,
> -             output_dir: str,
> -             prefix: str,
> -             unmask: bool =3D False,
> -             builtins: bool =3D False,
> -             gen_tracing: bool =3D False) -> None:
> -    """
> -    Generate C code for the given schema into the target directory.
> -
> -    :param schema_file: The primary QAPI schema file.
> -    :param output_dir: The output directory to store generated code.
> -    :param prefix: Optional C-code prefix for symbol names.
> -    :param unmask: Expose non-ABI names through introspection?
> -    :param builtins: Generate code for built-in types?
> -
> -    :raise QAPIError: On failures.
> -    """
> -    assert invalid_prefix_char(prefix) is None
> -
> -    schema =3D QAPISchema(schema_file)
> -    gen_types(schema, output_dir, prefix, builtins)
> -    gen_features(schema, output_dir, prefix)
> -    gen_visit(schema, output_dir, prefix, builtins)
> -    gen_commands(schema, output_dir, prefix, gen_tracing)
> -    gen_events(schema, output_dir, prefix)
> -    gen_introspect(schema, output_dir, prefix, unmask)
> +def import_class_from_string(path):
> +    module_path, _, class_name =3D path.rpartition('.')
> +    mod =3D import_module(module_path)
> +    klass =3D getattr(mod, class_name)
> +    return klass

Lacks error handling, see appended test cases.

Moreover, mypy points out

    scripts/qapi/main.py:18: error: Function is missing a type annotation  =
[no-untyped-def]

The argument is str, but what is returned?

The function name suggests it returns a class.

As coded, the function could return pretty much anything.

The caller actually needs a QAPIBackend class.

We need a checked cast to QAPIBackend class somewhere.  If you put it in
this function, it returns a QAPIBackend class, and its name should be
adjusted accordingly.  import_backend() maybe?

>=20=20
>=20=20
>  def main() -> int:
> @@ -77,6 +42,8 @@ def main() -> int:
>      parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_=
true',
>                          dest=3D'unmask',
>                          help=3D"expose non-ABI names in introspection")
> +    parser.add_argument('-k', '--backend', default=3D"qapi.backend.QAPIC=
Backend",

Any particular reason for picking -k for --backend?

-b is taken, but -B would be available.

Break the line before default=3D, please.

> +                        help=3D"Python module name for code generator")
>=20=20
>      # Option --suppress-tracing exists so we can avoid solving build sys=
tem
>      # problems.  TODO Drop it when we no longer need it.
> @@ -92,13 +59,15 @@ def main() -> int:
>          print(f"{sys.argv[0]}: {msg}", file=3Dsys.stderr)
>          return 1
>=20=20
> +    backendclass =3D import_class_from_string(args.backend)
>      try:
> -        generate(args.schema,
> -                 output_dir=3Dargs.output_dir,
> -                 prefix=3Dargs.prefix,
> -                 unmask=3Dargs.unmask,
> -                 builtins=3Dargs.builtins,
> -                 gen_tracing=3Dnot args.suppress_tracing)
> +        backend =3D backendclass()
> +        backend.run(args.schema,
> +                    output_dir=3Dargs.output_dir,
> +                    prefix=3Dargs.prefix,
> +                    unmask=3Dargs.unmask,
> +                    builtins=3Dargs.builtins,
> +                    gen_tracing=3Dnot args.suppress_tracing)
>      except QAPIError as err:
>          print(err, file=3Dsys.stderr)
>          return 1

The connection to the backend moves to run-time: static import
statements get replaced by a dynamic import_module().  Fine, it's what
it takes to support pluggable backends.

However, it might hide the bundled backend from tools like mypy.  Would
that be bad?  I'm not sure.

If it is, we could avoid it pretty easily: instead of defaulting the
module name, so we dynamically load the bundled backend module by
default, default the class, so we create the bundled backend class by
default.


The promised test cases:

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -k noexistent qapi/qapi-schema.=
json=20
Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ~~~~~~~~~^^
  File "/work/armbru/qemu/scripts/qapi/main.py", line 62, in main
    backendclass =3D import_class_from_string(args.backend)
  File "/work/armbru/qemu/scripts/qapi/main.py", line 20, in import_class_f=
rom_string
    mod =3D import_module(module_path)
  File "/usr/lib64/python3.13/importlib/__init__.py", line 88, in import_mo=
dule
    return _bootstrap._gcd_import(name[level:], package, level)
           ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1384, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1298, in _sanity_check
ValueError: Empty module name

 python3 scripts/qapi-gen.py -o /tmp/$$ -b -k noexistent.foo qapi/qapi-sche=
ma.json=20
Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ~~~~~~~~~^^
  File "/work/armbru/qemu/scripts/qapi/main.py", line 62, in main
    backendclass =3D import_class_from_string(args.backend)
  File "/work/armbru/qemu/scripts/qapi/main.py", line 20, in import_class_f=
rom_string
    mod =3D import_module(module_path)
  File "/usr/lib64/python3.13/importlib/__init__.py", line 88, in import_mo=
dule
    return _bootstrap._gcd_import(name[level:], package, level)
           ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1324, in _find_and_load_unlock=
ed
ModuleNotFoundError: No module named 'noexistent'

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -k qapi.backend.foo qapi/qapi-s=
chema.json=20
Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ~~~~~~~~~^^
  File "/work/armbru/qemu/scripts/qapi/main.py", line 62, in main
    backendclass =3D import_class_from_string(args.backend)
  File "/work/armbru/qemu/scripts/qapi/main.py", line 21, in import_class_f=
rom_string
    klass =3D getattr(mod, class_name)
AttributeError: module 'qapi.backend' has no attribute 'foo'

$ python3 scripts/qapi-gen.py -o /tmp/$$ -b -k qapi.backend.QAPIBackend qap=
i/qapi-schema.json=20
Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ~~~~~~~~~^^
  File "/work/armbru/qemu/scripts/qapi/main.py", line 64, in main
    backend =3D backendclass()
TypeError: Can't instantiate abstract class QAPIBackend without an implemen=
tation for abstract method 'generate'

 $ python3 scripts/qapi-gen.py -o /tmp/$$ -b -k qapi.common.Indentation qap=
i/qapi-schema.json=20
Traceback (most recent call last):
  File "/work/armbru/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ~~~~~~~~~^^
  File "/work/armbru/qemu/scripts/qapi/main.py", line 65, in main
    backend.run(args.schema,
    ^^^^^^^^^^^
AttributeError: 'Indentation' object has no attribute 'run'


