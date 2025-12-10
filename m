Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDF4D3C92B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMxX-0000ci-NO; Wed, 10 Dec 2025 11:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTMxW-0000cR-9W
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:22:34 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTMxU-0007lZ-DU
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:22:34 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78c4d112cd8so36494337b3.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765383750; x=1765988550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JTQHI8sk3NMWaCGvI3mzurpRP9QoJ7XfSOOlWlFF6A=;
 b=BZ1fRK1+3acoC9MIiZtQhb7u9NBgo5PlX+wgST+IURxhO0UsHVyGBnCwg+bTC4CR54
 I3+OTSRDwlrdD8I/9IXKrxJIp/SuWRJfiSOb21K2Qeh0I2SJroHQT62fviPtfEVRfJ15
 BftwQyCqlZpkm40Kw20CitwmX3TgwysJd1LzWHUXtU8WASPutK/LMpqCyPxKdatKRiiR
 HBvNhpux0uuHCBJFLLPWhKsW2/vqmsFWJU0D9geRcAbzFwNGEbwkdot0tm9mcXrAOcR+
 f1UoKdwilWV7p0Fj9z5ylMgbEhNeOPg9xDz+LGb+eukkuEouC0zjJfct0pyyyKzsXLQN
 6z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765383750; x=1765988550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8JTQHI8sk3NMWaCGvI3mzurpRP9QoJ7XfSOOlWlFF6A=;
 b=jwwY+51Hlq/GfcwLXJHbxdwve71N+89MX0emGuaMUUnTM2gqpgnjZ5pMy5yJZtrahr
 3ZrhezpnfvuStptKKob0kRhFs5RozBwHqIOzYUsdj5OH6+dUGMZRY8HzL7Kw+7wnMLck
 jeBfziny93HW8Z6bD5YePMnVJhi3xfmqkZoOlR42xoM+Eog3p0quyV7fwJ4ekbwqEhC9
 eXweXjeW4N/lIka71QKPgMWXT0lID2qDfrMDYUN3lk5KUTqmjrFPRKEIpGHkVf/rU6lg
 XghsJxYmqbnpLFPAjturoTpESEwKjJOpxO4RS7pgXXaBfnOHp3/GU0aPbErrrapaNXYt
 Gnfg==
X-Gm-Message-State: AOJu0YyEiK31UxYalN5+fz47yWeg7/M745ibhLIeuLKCQ1p86fyEJ5zb
 T3WchpBJZQtfQAd5t4+WQaTSKiCmxRoOp9ouVAo2F73GKwLkSuipLd3+emQ4+HjTb8iip7LDhV5
 xiRlwRNkb9kPWFwR3LJpt9314mr1vYoYzI+5ry5ZoHMh4GTd9QsQnWZU=
X-Gm-Gg: AY/fxX5L7FUR4WdpSHYcHwqukJ5fhAXdBcwfUJdMvEmZEbUjxIuBczozECj3EMHeB2E
 PzCnf/IlzgAwIUHrdyBdVytWfAic5yovrpAgPYyRYf9POqpEDtCwE3SFcdhcMNZAXGj9UmqGtKw
 CgcBgrBSEhLRvdKO31sVZyNlUnQNgqLSavKAa+dupK/EZI+Hv8amOxfayYDKWQDPd5y4cl2NhMF
 O6FL+rC4+V/GJaEWkPozd4EzXD3UiGTGP/HA1LaAJdKistjE90sael46UbTPSC0RZybxKE3
X-Google-Smtp-Source: AGHT+IGfv+iqMJDNnb5ENZgvlv4u/FIfKnyfLUwwHpEfS/SN+cYcw3GY4B8T58ce5+NTKjomHu50rvsx9xHX0i7Sr0c=
X-Received: by 2002:a05:690c:490c:b0:789:2be7:ae80 with SMTP id
 00721157ae682-78c9d788d42mr48044647b3.54.1765383750374; Wed, 10 Dec 2025
 08:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20251210160544.2265437-1-berrange@redhat.com>
In-Reply-To: <20251210160544.2265437-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Dec 2025 16:22:18 +0000
X-Gm-Features: AQt7F2p2XzIBpx6ZiMBdAWUEO8iCEfObSCBtgzmq1KnwcoPyUNIrGjBmZP38BnI
Message-ID: <CAFEAcA__06DsQZrW3k1rUOOYAN6-6+2T_jTy4scGQ4s=2qUpfQ@mail.gmail.com>
Subject: Re: [PATCH] run: introduce a script for running devel commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 10 Dec 2025 at 16:06, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Various aspects of the development workflow are complicated by the need
> to set env variables ahead of time, or use specific paths. Introduce a
> $BUILD_DIR/run script that will do a number of things
>
>  * Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR
>  * Set $PYTHONPATH to point to $SRC_DIR/tests/functional
>
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
>   $ build/pyvenv/bin/python3 ./tests/functional/x86_64/test_virtio_versio=
n.py
>
> which is now simplified to
>
>   $ export QEMU_TEST_QEMU_BINARY=3Dqemu-system-x86_64
>   $ ./build/run ./tests/functional/x86_64/test_virtio_version.py
>
> This usefulness of this will be further enhanced with the pending
> removal of the QEMU python APIs from git, as that will require the use
> of the python venv in even more scenarios that today.

Mmm, I think this will be helpful. My review comments
below are all nitpicks.

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

", and"

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
>    will write the paths to various tools to this file, for use in ``Makef=
ile``
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/funct=
ional.rst
> index fdeaebaadc..1978f96eba 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -53,15 +53,14 @@ the following line will only run the tests for the x8=
6_64 target:
>    make check-functional-x86_64
>
>  To run a single test file without the meson test runner, you can also
> -execute the file directly by specifying two environment variables first,
> -the PYTHONPATH that has to include the python folder and the tests/funct=
ional
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
>  The test framework will automatically purge any scratch files created du=
ring
>  the tests. If needing to debug a failed test, it is possible to keep the=
se
> diff --git a/meson.build b/meson.build
> index d9293294d8..8f2320d362 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3507,6 +3507,17 @@ endif
>  config_host_h =3D configure_file(output: 'config-host.h', configuration:=
 config_host_data)
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
> +run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check: tr=
ue)

Does this work on Windows hosts ? (Obviously the run script
isn't going to be any use if you don't have a Posix-ish shell,
but we should at least not fall over.)

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

In my build tree the 'activate' script says it must
be used "from bash"; is it wrong, or should this be
#!/bin/bash instead ?

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Ensure that we find our local builds first
> +PATH=3D@build_dir@/qemu-bundle/@bin_dir@:$PATH
> +export PATH
> +
> +# Ensure that functional tests find their lib
> +PYTHONPATH=3D@src_dir@/tests/functional${PYTHONPATH:+:${PYTHONPATH}}

docs/devel/testing/functional.rst says PYTHONPATH also
needs to have $SRC_DIR/python on it.

> +export PYTHONPATH
> +
> +# Ensure that everything uses the venv python & site packages
> +source @build_dir@/pyvenv/bin/activate

Aren't there quoting issues here if e.g. @build_dir@ has
a space in it, or some existing PYTHONPATH or PATH
entry has a space in it?

> +exec $@

I thought this needed to be quoted, i.e. "$@" rather
than $@.

thanks
-- PMM

