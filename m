Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953CDD4334A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 20:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTnFL-0002r8-Ox; Thu, 11 Dec 2025 15:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vTnFK-0002qw-38
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:26:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vTnFH-0005pB-Cf
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765484797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B9RMDjXuCzo4q9s5j0ubnxxBqYf2pIgf6MBIMO/NG/c=;
 b=Q8KIvcxuC3uBTjpTMZI5x1QEhCkjS9ewg2I+uMT7HAwScDHbeefTj/6nIGvzuknnDKc9/R
 t1pqjeIqDtmR56sqDfbRrTUQa7ssbvTJtP7XG8SGIQj1ErK0fai6mT1sRuSYDbunKSK6b0
 UsBqR6h/xyOy1CEFMGYOxd+muVVcfV8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-JVZw2XY2PT2e1Lm3IhOBTw-1; Thu, 11 Dec 2025 15:26:35 -0500
X-MC-Unique: JVZw2XY2PT2e1Lm3IhOBTw-1
X-Mimecast-MFC-AGG-ID: JVZw2XY2PT2e1Lm3IhOBTw_1765484795
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-787f7261b62so7222157b3.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 12:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765484795; x=1766089595; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B9RMDjXuCzo4q9s5j0ubnxxBqYf2pIgf6MBIMO/NG/c=;
 b=reVGD3/kEuxXOl/bh2u9oQ+kVJKR5hzGeumnjMXju9cKCIq+GSqU28juAfT7kSBLIC
 ylKH/g7z9CXufNta6Hi11MPeygNm9dzoZ7AXH7b0/BSzCdZXcaQWixb8Km61Z1Hj/360
 E98ZZ0UAf31pZihXBNpmya2i92yqImahWS3i+ZnOU4oFf/z6mSQVHoQSNpmDF+55Yg5W
 czhMNajLr5pZRzsaIZCAAZZTdQ81ez/BkPr8/GgWuqf9cg97XE67cbacbI9OYpPeti5Y
 PFgq4xOwICgUqsu6NcOOkyhLhjdgHMpaahyZr2yMTO0V3yJdSrrzoJrNBd4Y4W8Z87Fn
 5YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765484795; x=1766089595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9RMDjXuCzo4q9s5j0ubnxxBqYf2pIgf6MBIMO/NG/c=;
 b=poEmbVDgmjZCwirQE9+By+9DWRqUCLqOUG+pcwv6XWZmp2wosnMinZztCHFSA/UedX
 d3dCff37p6e9UGdA2y4dciPEYTK3wvXgHPpeWhSQwlEaJhCtZeq535vMzJYU1mXtz3J2
 iJx4dBzRybMEE/tmY0ziTjIGPBaBvamFhA/IUaErDbps4LE8fme7r1Y+LVnKJE09jAKr
 gu+TlcKdsnEEB0ID27GZvbIMihuiLksT0bF0gYmpsXrnEgL5cphw/67DRomeg17ueICa
 COCA0WiA5zJNl80Jeew5DZ7G7dlmiXPal1b2jf8EfzCL16xh6DtBjJwPpTQh0XhX08Xr
 feWg==
X-Gm-Message-State: AOJu0YwqK4BH8AKGgAzxmlqdfIWJIivCxzUQiRZCYfvjU9qE14u9HWCK
 U9enlkxpQIiGWPp7YS9RtRGLXyobK66/0oqXxIX5idcB3/nVQfTZkM5CBRYmD3trOYvyydbTTQJ
 LO0cuohkVNwfJkSNsnLiCl8cwLI0Fw72ngQL3TzXdGbHixwmLlvQvJfcwn0l62wQ7FXe5TyavOU
 MqBdgvDygMVA+EuhE7Z2XYmI/VquWjcms=
X-Gm-Gg: AY/fxX5cp/592niZUWhmBSa/DLi1ijVrHttdPsQ/ko7yEPhHGJnI9LwZ0G6TJdKF4qn
 l5we+CB6c14bGAsidc/RacfHKafbcYJRJY8gfjarLRyawIQaiveBzJw7tgz4VhtQ27v6BrUekkr
 yH0fa/Fa/ZdmxsNx4NJxpzCvC0WtoS52RcKn9gMdQe1MIGijkVRSUMz8k10HEKQofaO/Kjt2cav
 m8AnPiwzf6q1QZ1K8JInR2i4eD8
X-Received: by 2002:a53:c04a:0:20b0:641:f5bc:692d with SMTP id
 956f58d0204a3-6447a58e1e0mr2306800d50.38.1765484794845; 
 Thu, 11 Dec 2025 12:26:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwkaZzFn6SU1IDiaIxuhNSuB2JxGEjU2CSe0uck53MUNaCAD7qa7+ikZd2rCo+tsztgvXDBMU7N79ZcmWpZfA=
X-Received: by 2002:a53:c04a:0:20b0:641:f5bc:692d with SMTP id
 956f58d0204a3-6447a58e1e0mr2306782d50.38.1765484794400; Thu, 11 Dec 2025
 12:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20251210160544.2265437-1-berrange@redhat.com>
In-Reply-To: <20251210160544.2265437-1-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 11 Dec 2025 15:26:23 -0500
X-Gm-Features: AQt7F2pB4Vbl3BZNSxHyjDz6FrxvhIXAC3rmrd1e38_xbROwRDlgRpL3jPFLGRg
Message-ID: <CAFn=p-a9Hv6irx3AjBD5h7+KPKvDDgtdbBiOCaw+cqNMKVKvsg@mail.gmail.com>
Subject: Re: [PATCH] run: introduce a script for running devel commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000072a300645b2f611"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000072a300645b2f611
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025, 11:05=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> Various aspects of the development workflow are complicated by the need
> to set env variables ahead of time, or use specific paths. Introduce a
> $BUILD_DIR/run script that will do a number of things
>
>  * Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR
>  * Set $PYTHONPATH to point to $SRC_DIR/tests/functional
>  * Source $BUILD_DIR/pyvenv/bin/activate
>
> To see the benefits of this consider this command:
>
>   $ source ./build/pyvenv/bin/activate
>   $ ./scripts/qmp/qmp-shell-wrap ./build/qemu-system-x86_64
>
> which is now simplified to
>
>   $ ./build/run ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 [args..]
>
> This avoids the need repeat './build' several times and avoids polluting
> the current terminal's environment and/or avoids errors from forgetting
> to source the venv settings.
>
> As another example running functional tests
>
>   $ export PYTHONPATH=3D./python:./tests/functional
>   $ export QEMU_TEST_QEMU_BINARY=3D./build/qemu-system-x86_64
>   $ build/pyvenv/bin/python3
> ./tests/functional/x86_64/test_virtio_version.py
>
> which is now simplified to
>
>   $ export QEMU_TEST_QEMU_BINARY=3Dqemu-system-x86_64
>   $ ./build/run ./tests/functional/x86_64/test_virtio_version.py
>
> This usefulness of this will be further enhanced with the pending
> removal of the QEMU python APIs from git, as that will require the use
> of the python venv in even more scenarios that today.
>

Sounds good to me.


> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> Historical context: this 'run' script concept is something introduced
> by libguestfs a decade & a half ago, and copied by libvirt shortly
> after that. It has been very helpful in simplifying life for developers
> and should do likewise for QEMU.
>
>  docs/devel/build-system.rst       | 12 ++++++++++++
>  docs/devel/testing/functional.rst | 17 ++++++++---------
>  meson.build                       | 11 +++++++++++
>  run.in                            | 15 +++++++++++++++
>  4 files changed, 46 insertions(+), 9 deletions(-)
>  create mode 100644 run.in
>
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 6204aa6a72..8ec8d20175 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -515,6 +515,18 @@ generates ``Makefile`` from ``Makefile.in``.
>
>  Built by configure:
>
> +``run``
> +  Used to run commands / scripts from the git checkout. Sets ``$PATH``
> +  to point to locally built binaries & activates the python venv before
> +  running the requested command. Pass the command to run as args, for
> +  example::
> +
> +    $ ./build/run ./script/qmp/qmp-shell-wrap qemu-system-x86_64
> +
> +  will use the ``python3`` binary and site-packages from the local
> +  venv to run ``qmp-shell-wrap`` and spawn the QEMU emulator from
> +  the build directory.
> +
>  ``config-host.mak``
>    When configure has determined the characteristics of the build host it
>    will write the paths to various tools to this file, for use in
> ``Makefile``
> diff --git a/docs/devel/testing/functional.rst
> b/docs/devel/testing/functional.rst
> index fdeaebaadc..1978f96eba 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -53,15 +53,14 @@ the following line will only run the tests for the
> x86_64 target:
>    make check-functional-x86_64
>
>  To run a single test file without the meson test runner, you can also
> -execute the file directly by specifying two environment variables first,
> -the PYTHONPATH that has to include the python folder and the
> tests/functional
> -folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
> -to the QEMU binary that should be used for the test. The current working
> -directory should be your build folder. For example::
> -
> -  $ export PYTHONPATH=3D../python:../tests/functional
> -  $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64
> -  $ pyvenv/bin/python3 ../tests/functional/test_file.py
> +execute the file directly by specifying the name of the emulator target
> +binary as an env variable.
> +
> +Assuming the current working directory is the top level source checkout
> +and the build directory is './build'::
> +
> +  $ export QEMU_TEST_QEMU_BINARY=3Dqemu-system-x86_64
> +  $ ./build/run tests/functional/x86_64/test_virtio_version.py
>
>  The test framework will automatically purge any scratch files created
> during
>  the tests. If needing to debug a failed test, it is possible to keep the=
se
> diff --git a/meson.build b/meson.build
> index d9293294d8..8f2320d362 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3507,6 +3507,17 @@ endif
>  config_host_h =3D configure_file(output: 'config-host.h', configuration:
> config_host_data)
>  genh +=3D config_host_h
>
> +run_config =3D configuration_data(
> +    {'build_dir': meson.current_build_dir(),
> +     'src_dir': meson.current_source_dir(),
> +     'bin_dir': get_option('prefix') / get_option('bindir')},
> +)
> +
> +run =3D configure_file(input: 'run.in',
> +                     output: 'run',
> +                     configuration: run_config)
> +run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check:
> true)
> +
>  hxtool =3D find_program('scripts/hxtool')
>  shaderinclude =3D find_program('scripts/shaderinclude.py')
>  qapi_gen =3D find_program('scripts/qapi-gen.py')
> diff --git a/run.in b/run.in
> new file mode 100644
> index 0000000000..124f0daed2
> --- /dev/null
> +++ b/run.in
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Ensure that we find our local builds first
> +PATH=3D@build_dir@/qemu-bundle/@bin_dir@:$PATH
> +export PATH
> +
> +# Ensure that functional tests find their lib
> +PYTHONPATH=3D@src_dir@/tests/functional${PYTHONPATH:+:${PYTHONPATH}}
> +export PYTHONPATH
> +
> +# Ensure that everything uses the venv python & site packages
> +source @build_dir@/pyvenv/bin/activate
> +
> +exec $@
> --
> 2.51.1
>

Do we want to bootstrap the Python env here, too? I know you said you
didn't want to invoke Ninja, but we can always invoke mkvenv directly if
you wanted to.

Like if not file pyvenv/checktests.group, then:

pyvenv/bin/python3 python/scripts/mkvenv.py ensuregroup [--dir
python/wheels] [--online] checktests

(Typing from memory on my phone, consult mkvenv.py for precise syntax. The
mkvenv ensuregroup invocation as configured, with conditional online flag,
is available through config-host.mak, too.)

This would skip Ninja and would run bootstrapping when the timestamp file
is absent, but would otherwise not check if the env is outdated. Still
might be pretty convenient so you can get e.g. qmp-shell-wrap right out of
the gate, or run iotests, etc.

Until my series goes in, you could also just invoke NINJA=3D":" make
check-venv, too, and I can update the invocation in my patchset if you want=
.

Lemme know.

--js

>

--000000000000072a300645b2f611
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 10, 2025, 11:05=E2=
=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Various aspects of the development workflow are complicated by the need<br=
>
to set env variables ahead of time, or use specific paths. Introduce a<br>
$BUILD_DIR/run script that will do a number of things<br>
<br>
=C2=A0* Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR<br>
=C2=A0* Set $PYTHONPATH to point to $SRC_DIR/tests/functional<br>
=C2=A0* Source $BUILD_DIR/pyvenv/bin/activate<br>
<br>
To see the benefits of this consider this command:<br>
<br>
=C2=A0 $ source ./build/pyvenv/bin/activate<br>
=C2=A0 $ ./scripts/qmp/qmp-shell-wrap ./build/qemu-system-x86_64<br>
<br>
which is now simplified to<br>
<br>
=C2=A0 $ ./build/run ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 [args.=
.]<br>
<br>
This avoids the need repeat &#39;./build&#39; several times and avoids poll=
uting<br>
the current terminal&#39;s environment and/or avoids errors from forgetting=
<br>
to source the venv settings.<br>
<br>
As another example running functional tests<br>
<br>
=C2=A0 $ export PYTHONPATH=3D./python:./tests/functional<br>
=C2=A0 $ export QEMU_TEST_QEMU_BINARY=3D./build/qemu-system-x86_64<br>
=C2=A0 $ build/pyvenv/bin/python3 ./tests/functional/x86_64/test_virtio_ver=
sion.py<br>
<br>
which is now simplified to<br>
<br>
=C2=A0 $ export QEMU_TEST_QEMU_BINARY=3Dqemu-system-x86_64<br>
=C2=A0 $ ./build/run ./tests/functional/x86_64/test_virtio_version.py<br>
<br>
This usefulness of this will be further enhanced with the pending<br>
removal of the QEMU python APIs from git, as that will require the use<br>
of the python venv in even more scenarios that today.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sounds good to me.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
---<br>
<br>
Historical context: this &#39;run&#39; script concept is something introduc=
ed<br>
by libguestfs a decade &amp; a half ago, and copied by libvirt shortly<br>
after that. It has been very helpful in simplifying life for developers<br>
and should do likewise for QEMU.<br>
<br>
=C2=A0docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++++=
++<br>
=C2=A0docs/devel/testing/functional.rst | 17 ++++++++---------<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>
=C2=A0<a href=3D"http://run.in" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">run.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15 +++++++++++++++<br>
=C2=A04 files changed, 46 insertions(+), 9 deletions(-)<br>
=C2=A0create mode 100644 <a href=3D"http://run.in" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">run.in</a><br>
<br>
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst<br>
index 6204aa6a72..8ec8d20175 100644<br>
--- a/docs/devel/build-system.rst<br>
+++ b/docs/devel/build-system.rst<br>
@@ -515,6 +515,18 @@ generates ``Makefile`` from ``Makefile.in``.<br>
<br>
=C2=A0Built by configure:<br>
<br>
+``run``<br>
+=C2=A0 Used to run commands / scripts from the git checkout. Sets ``$PATH`=
`<br>
+=C2=A0 to point to locally built binaries &amp; activates the python venv =
before<br>
+=C2=A0 running the requested command. Pass the command to run as args, for=
<br>
+=C2=A0 example::<br>
+<br>
+=C2=A0 =C2=A0 $ ./build/run ./script/qmp/qmp-shell-wrap qemu-system-x86_64=
<br>
+<br>
+=C2=A0 will use the ``python3`` binary and site-packages from the local<br=
>
+=C2=A0 venv to run ``qmp-shell-wrap`` and spawn the QEMU emulator from<br>
+=C2=A0 the build directory.<br>
+<br>
=C2=A0``config-host.mak``<br>
=C2=A0 =C2=A0When configure has determined the characteristics of the build=
 host it<br>
=C2=A0 =C2=A0will write the paths to various tools to this file, for use in=
 ``Makefile``<br>
diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functio=
nal.rst<br>
index fdeaebaadc..1978f96eba 100644<br>
--- a/docs/devel/testing/functional.rst<br>
+++ b/docs/devel/testing/functional.rst<br>
@@ -53,15 +53,14 @@ the following line will only run the tests for the x86_=
64 target:<br>
=C2=A0 =C2=A0make check-functional-x86_64<br>
<br>
=C2=A0To run a single test file without the meson test runner, you can also=
<br>
-execute the file directly by specifying two environment variables first,<b=
r>
-the PYTHONPATH that has to include the python folder and the tests/functio=
nal<br>
-folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point<br>
-to the QEMU binary that should be used for the test. The current working<b=
r>
-directory should be your build folder. For example::<br>
-<br>
-=C2=A0 $ export PYTHONPATH=3D../python:../tests/functional<br>
-=C2=A0 $ export QEMU_TEST_QEMU_BINARY=3D$PWD/qemu-system-x86_64<br>
-=C2=A0 $ pyvenv/bin/python3 ../tests/functional/test_file.py<br>
+execute the file directly by specifying the name of the emulator target<br=
>
+binary as an env variable.<br>
+<br>
+Assuming the current working directory is the top level source checkout<br=
>
+and the build directory is &#39;./build&#39;::<br>
+<br>
+=C2=A0 $ export QEMU_TEST_QEMU_BINARY=3Dqemu-system-x86_64<br>
+=C2=A0 $ ./build/run tests/functional/x86_64/test_virtio_version.py<br>
<br>
=C2=A0The test framework will automatically purge any scratch files created=
 during<br>
=C2=A0the tests. If needing to debug a failed test, it is possible to keep =
these<br>
diff --git a/meson.build b/meson.build<br>
index d9293294d8..8f2320d362 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3507,6 +3507,17 @@ endif<br>
=C2=A0config_host_h =3D configure_file(output: &#39;config-host.h&#39;, con=
figuration: config_host_data)<br>
=C2=A0genh +=3D config_host_h<br>
<br>
+run_config =3D configuration_data(<br>
+=C2=A0 =C2=A0 {&#39;build_dir&#39;: meson.current_build_dir(),<br>
+=C2=A0 =C2=A0 =C2=A0&#39;src_dir&#39;: meson.current_source_dir(),<br>
+=C2=A0 =C2=A0 =C2=A0&#39;bin_dir&#39;: get_option(&#39;prefix&#39;) / get_=
option(&#39;bindir&#39;)},<br>
+)<br>
+<br>
+run =3D configure_file(input: &#39;<a href=3D"http://run.in" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">run.in</a>&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0output: &#39;run&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0configuration: run_config)<br>
+run_command(&#39;chmod&#39;, &#39;a+x&#39;, meson.current_build_dir() / &#=
39;run&#39;, check: true)<br>
+<br>
=C2=A0hxtool =3D find_program(&#39;scripts/hxtool&#39;)<br>
=C2=A0shaderinclude =3D find_program(&#39;scripts/shaderinclude.py&#39;)<br=
>
=C2=A0qapi_gen =3D find_program(&#39;scripts/qapi-gen.py&#39;)<br>
diff --git a/<a href=3D"http://run.in" rel=3D"noreferrer noreferrer" target=
=3D"_blank">run.in</a> b/<a href=3D"http://run.in" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">run.in</a><br>
new file mode 100644<br>
index 0000000000..124f0daed2<br>
--- /dev/null<br>
+++ b/<a href=3D"http://run.in" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">run.in</a><br>
@@ -0,0 +1,15 @@<br>
+#!/bin/sh<br>
+# SPDX-License-Identifier: GPL-2.0-or-later<br>
+<br>
+# Ensure that we find our local builds first<br>
+PATH=3D@build_dir@/qemu-bundle/@bin_dir@:$PATH<br>
+export PATH<br>
+<br>
+# Ensure that functional tests find their lib<br>
+PYTHONPATH=3D@src_dir@/tests/functional${PYTHONPATH:+:${PYTHONPATH}}<br>
+export PYTHONPATH<br>
+<br>
+# Ensure that everything uses the venv python &amp; site packages<br>
+source @build_dir@/pyvenv/bin/activate<br>
+<br>
+exec $@<br>
-- <br>
2.51.1<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Do we want to bootstrap the Python env here, too? I know you said you=
 didn&#39;t want to invoke Ninja, but we can always invoke mkvenv directly =
if you wanted to.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Like i=
f not file pyvenv/checktests.group, then:</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">pyvenv/bin/python3 python/scripts/mkvenv.py ensuregroup [=
--dir python/wheels] [--online] checktests</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">(Typing from memory on my phone, consult mkvenv.py for p=
recise syntax. The mkvenv ensuregroup invocation as configured, with condit=
ional online flag, is available through config-host.mak, too.)</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">This would skip Ninja and would run =
bootstrapping when the timestamp file is absent, but would otherwise not ch=
eck if the env is outdated. Still might be pretty convenient so you can get=
 e.g. qmp-shell-wrap right out of the gate, or run iotests, etc.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Until my series goes in, you could=
 also just invoke NINJA=3D&quot;:&quot; make check-venv, too, and I can upd=
ate the invocation in my patchset if you want.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Lemme know.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">--js</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000072a300645b2f611--


