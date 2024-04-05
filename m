Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A73BCD1284
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 05:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rscEZ-0002np-E9; Fri, 05 Apr 2024 01:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rscEY-0002ng-04
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 01:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rscET-0004Cx-Pw
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 01:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712295319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYk0Mf5qkcOU40lpeCWwIfCKfZxQUj0MbDKs8Q7MlEs=;
 b=ZW0cZdr4/KDUBRp8hTCN4/8zVNvGS1Us2zH44SY7uvXh8D+AbhB2EEm5vZmRgYENeUUrLu
 GFiJKtOYGXSKBY50leXMwpe1vi0f/kBlftLb0+pcntPA2TxO58E/Z6w4dXGDzsI7JOGUi2
 35n+m2WxdPgcegkjotPuCTaLbRhzhCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-fPEUtQ9dNVqKGDzntvYM-w-1; Fri, 05 Apr 2024 01:35:17 -0400
X-MC-Unique: fPEUtQ9dNVqKGDzntvYM-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7109685CBA2;
 Fri,  5 Apr 2024 05:35:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E668DC15771;
 Fri,  5 Apr 2024 05:35:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D087121E6757; Fri,  5 Apr 2024 07:35:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Michael Tokarev <mjt@tls.msk.ru>,  Laurent
 Vivier <laurent@vivier.eu>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [RFC PATCH-for-9.1] qapi: Do not generate
 commands/events/introspect code for user emulation
In-Reply-To: <20240404195543.9804-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 4 Apr 2024 21:55:43
 +0200")
References: <20240404195543.9804-1-philmd@linaro.org>
Date: Fri, 05 Apr 2024 07:35:10 +0200
Message-ID: <87il0w74oh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> User emulation requires the QAPI types. Due to the command
> line processing, some visitor code is also used. The rest
> is irrelevant (no QMP socket).
>
> Add an option to the qapi-gen script to allow generating
> the minimum when only user emulation is being built.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: Quick PoC for Markus. It is useful for user-only builds.
> ---
>  qapi/meson.build     |  6 +++++-
>  scripts/qapi/main.py | 16 +++++++++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 375d564277..5e02621145 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -115,10 +115,14 @@ foreach module : qapi_all_modules
>    endif
>  endforeach
>=20=20
> +qapi_gen_cmd =3D [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ]
> +if not (have_system or have_tools)
> +  qapi_gen_cmd +=3D [ '--types-only' ]
> +endif
>  qapi_files =3D custom_target('shared QAPI source files',
>    output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_out=
puts,
>    input: [ files('qapi-schema.json') ],
> -  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
> +  command: qapi_gen_cmd,
>    depend_files: [ qapi_inputs, qapi_gen_depends ])
>=20=20
>  # Now go through all the outputs and add them to the right sourceset.
> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 316736b6a2..925af5841b 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -33,7 +33,8 @@ def generate(schema_file: str,
>               prefix: str,
>               unmask: bool =3D False,
>               builtins: bool =3D False,
> -             gen_tracing: bool =3D False) -> None:
> +             gen_tracing: bool =3D False,
> +             gen_types_only: bool =3D False) -> None:
>      """
>      Generate C code for the given schema into the target directory.
>=20=20
> @@ -50,9 +51,10 @@ def generate(schema_file: str,
>      schema =3D QAPISchema(schema_file)
>      gen_types(schema, output_dir, prefix, builtins)
>      gen_visit(schema, output_dir, prefix, builtins)
> -    gen_commands(schema, output_dir, prefix, gen_tracing)
> -    gen_events(schema, output_dir, prefix)
> -    gen_introspect(schema, output_dir, prefix, unmask)
> +    if not gen_types_only:
> +        gen_commands(schema, output_dir, prefix, gen_tracing)
> +        gen_events(schema, output_dir, prefix)
> +        gen_introspect(schema, output_dir, prefix, unmask)

This is the behavior change, everything else is plumbing.  You suppress
generation of source code for commands, events, and introspection, i.e.

    qapi-commands*.[ch]
    qapi-init-commands.[ch]
    qapi-events*[ch]
    qapi-introspect.[ch]

and the associated .trace-events.

But none of these .c get compiled for a user-only build.

So, all we save is a bit of build time and disk space: less than 0.1s on
my machine, ~1.6MiB in ~220 files.  My linux-user-only build tree clocks
in at 317MiB in ~4900 files, a full build takes me around 30s (real
time, -j 14 with ccache), so we're talking about 0.5% in disk space and
0.3% in build time.

Moreover, the patch needs work:

    FAILED: tests/unit/test-qobject-input-visitor.p/test-qobject-input-visi=
tor.c.o=20
    cc [...] -c ../tests/unit/test-qobject-input-visitor.c
    ../tests/unit/test-qobject-input-visitor.c:27:10: fatal error: qapi/qap=
i-introspect.h: No such file or directory
       27 | #include "qapi/qapi-introspect.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~
    FAILED: libqemuutil.a.p/stubs_monitor-core.c.o=20
    cc [...] -c ../stubs/monitor-core.c
    ../stubs/monitor-core.c:3:10: fatal error: qapi/qapi-emit-events.h: No =
such file or directory
        3 | #include "qapi/qapi-emit-events.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~

I don't think it's worth the bother.

>=20=20
>=20=20
>  def main() -> int:
> @@ -75,6 +77,9 @@ def main() -> int:
>      parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_=
true',
>                          dest=3D'unmask',
>                          help=3D"expose non-ABI names in introspection")
> +    parser.add_argument('-t', '--types-only', action=3D'store_true',
> +                        dest=3D'gen_types_only',
> +                        help=3D"Only generate QAPI types")
>=20=20
>      # Option --suppress-tracing exists so we can avoid solving build sys=
tem
>      # problems.  TODO Drop it when we no longer need it.
> @@ -96,7 +101,8 @@ def main() -> int:
>                   prefix=3Dargs.prefix,
>                   unmask=3Dargs.unmask,
>                   builtins=3Dargs.builtins,
> -                 gen_tracing=3Dnot args.suppress_tracing)
> +                 gen_tracing=3Dnot args.suppress_tracing,
> +                 gen_types_only=3Dargs.gen_types_only)
>      except QAPIError as err:
>          print(err, file=3Dsys.stderr)
>          return 1


