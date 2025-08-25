Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A758FCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 16:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqaPU-00048m-3M; Mon, 25 Aug 2025 12:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqaPP-00047X-Au
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 12:51:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqaPI-0002V5-8p
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 12:51:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso26373435e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756140650; x=1756745450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we0zGkulHShFs6KviAo4DPncCevtCv+4QsSfgxRq0RA=;
 b=iHZe8wo3RRpApRGAzmS+qwCEyRYt9TcQMuaRqXeX4kbtAQdCy35d8ngPM5qfCcBAHu
 P83dIh8ODNCR9A9nGfz8awKrsaynDS1Cf69kFDnF+jWTIufjuO3UjhwjnYEPZ5zgNZrl
 GjG/PYrRv59UWyF8wwGVr5iCd7PrWINFF/0V6QmnJqDUpk7qZTrg/BzgPuIqhval0DP8
 ORp0Bga1D5j1Sg3OQk1FuIOKYAslnugCPQQttixzpvVG9d1H3sCpTIunavdOPK3b4Km+
 MEdOwho7Rp7/WfFtgdcIbGP6rZJV4f2mN2K56IgKS3xPFt1qtx4tQEtWnPnAyDi/N2Nq
 0B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756140650; x=1756745450;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=we0zGkulHShFs6KviAo4DPncCevtCv+4QsSfgxRq0RA=;
 b=DkhSh34MYpI/C8mYgPoJ6XfS9UdF7ByoTlfxs/8GbTIlVPFawkmNJMBoVgp6OHLvSx
 LeBwXLwsQgjOTWbohvkOCw/4O8EGThnGyuBcMbdwlRUu/HC2ABG9QfGLfZmMOVQfmm2S
 c8EablMozjbaxu4PiOz8FmFYhnXNmsMwBgQ/qs+l8i03UYty1oA1Y58oNF2EEqgtAeVy
 eGE8PxN8WorMbUhoeLTRsLnDO1H1cEEbytASzGpo96dyVtS0Q21XzcpblRz1HSoxjLUB
 4ljRZ/RZkSJ2CFuZX2l6HG1DNkUTGpw54B4jpcGzvrfhHexQHvjVmqRuDCrCtniQjzeV
 ggUg==
X-Gm-Message-State: AOJu0YyBS9rrNcbG4qYpW0WH576nWhBt06jI1YLz3kGKEDlfJD6ynFcb
 DEXJ2mz+68FU9mwQcxusY2qvmsWMs8ZMlAsOlc4XuXv1Mzj52QOv2IYSt5YMDFyDXQY=
X-Gm-Gg: ASbGncvTMQocsPgArHN26wcnBvgs04eUaBpU4pqEEgFLHwNEpEMSHrN1kHikVE2WaCR
 fDpQ9ypWmrEUpeYB579FMT8LN3qMEZhj1k/q5VF1dkhDQXsLrqoQtxZZYx9HzC12ZitGUb4zAaI
 Gv1Cvy3HlKQ9UM2kw1EW6ojDpcfiGebNCOfkDMihoZg56ucKyBM7xEDJQujzUm1FHCekjFlk/Np
 pNJ5exyFnlgSwiXBzXN+b7xclItU555NBOqWKKz41+7wjhuUVkmU/kZmD4OjHe+mIWxav8QqaJs
 u6jETaQx6jpX+ICCd2aRDwtXdeLfOv7Au+JST+QvbVUsnduzI+n+yX+g0GH8Z5Gg2oLXjeI+j/b
 gJMAKFS7p6MZQS5dvto/yDSA=
X-Google-Smtp-Source: AGHT+IEGb+BAIFeSIaWSKlrgHOaJDOPwFRM09L2A2jzCWzt2q02NG6Q56eKEjBFfpzsnxqjS4XF1zw==
X-Received: by 2002:a05:600c:45ca:b0:45b:47e1:f5fa with SMTP id
 5b1f17b1804b1-45b517d8e37mr105995995e9.35.1756140650220; 
 Mon, 25 Aug 2025 09:50:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b5753528csm114990255e9.3.2025.08.25.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 09:50:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 65E165F7CB;
 Mon, 25 Aug 2025 17:50:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  qemu-arm@nongnu.org,
 1844144@gmail.com
Subject: Re: [PATCH 2/4] tests/functional: Support tests that require a runner
In-Reply-To: <20250819143916.4138035-3-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Tue, 19 Aug 2025 14:39:14 +0000")
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <20250819143916.4138035-3-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 25 Aug 2025 17:50:48 +0100
Message-ID: <87bjo32vmf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Add support for running tests that require a specific runner.
>
> The test is specified via a tuple (name, runner, protocol), where name
> is the test name as found in the tests/functional directory without the
> 'test_' prefix and the .py extension, runner is an array containing the
> runner and any arguments required by the runner, and protocol is
> the test protocol used by Meson to determine whether the test passed or
> failed.
>
> The test tuples are added to arrays that follow the current naming
> logic but with the suffix '_with_runner' appended to their names. In
> Meson it's not easy to select an element in an array at runtime based on
> its type, so it's simpler to have a new array for these new test types
> than use the current ones from the tests that don't require a runner,
> and so avoid mixing strings and tuples in the same array.
>
> Currently there is only one runner, the GDB runner, but more runners can
> be defined and associated to a test via the tuple.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  meson.build                  |  4 +++
>  tests/functional/meson.build | 62 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 50c774a195..8d482f0809 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -75,6 +75,10 @@ have_user =3D have_linux_user or have_bsd_user
>=20=20
>  sh =3D find_program('sh')
>  python =3D import('python').find_installation()
> +# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly ret=
urn the
> +# site-packages dir in pyvenv, so it is built manually.
> +python_ver =3D python.language_version()
> +python_site_packages =3D meson.build_root() / 'pyvenv/lib/python' + pyth=
on_ver / 'site-packages'
>=20=20
>  cc =3D meson.get_compiler('c')
>  all_languages =3D ['c']
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 311c6f1806..1f70b70fd4 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -349,6 +349,23 @@ tests_xtensa_system_thorough =3D [
>    'xtensa_replay',
>  ]
>=20=20
> +# Tests that require a specific runner.
> +gdb =3D find_program('gdb-multiarch', required: false)
> +if gdb.found()
> +    gdb_runner_script =3D  meson.project_source_root() + '/tests/guest-d=
ebug/run-test.py'
> +    gdb_runner =3D [gdb_runner_script, '--gdb', gdb, '--test']
> +
> +    # A test with a runner is a tuple (name, runner, protocol).
> +    # The tests must be elements of an array named like:
> +    #
> +    # test_<arch>_<mode=3D[system|linuxuser|bsduser]>_<speed=3D[quick|th=
orough]>_with_runner =3D [
> +    #      ['test0', gdb_runner, 'exitcode'],
> +    #      ...
> +    # ]
> +else
> +    message('GDB multiarch not found, skipping functional tests that rel=
y on it.')
> +endif
> +

We already have a --gdb option in configure which sets GDB=3D for
check-tcg - we should use the same configuration for these tests. You
may need to convert the configure probe to a meson-option.

>  precache_all =3D []
>  foreach speed : ['quick', 'thorough']
>    foreach dir : target_dirs
> @@ -372,9 +389,11 @@ foreach speed : ['quick', 'thorough']
>        suites =3D ['func-quick', 'func-' + target_base]
>        target_tests =3D get_variable('tests_' + target_base + '_' + sysmo=
de + '_quick', []) \
>                       + get_variable('tests_generic_' + sysmode)
> +      target_tests_r =3D get_variable('tests_' + target_base + '_' + sys=
mode + '_quick_with_runner', [])
>      else
>        suites =3D ['func-' + speed, 'func-' + target_base + '-' + speed, =
speed]
>        target_tests =3D get_variable('tests_' + target_base + '_' + sysmo=
de + '_' + speed, [])
> +      target_tests_r =3D get_variable('tests_' + target_base + '_' + sys=
mode + '_' + speed + '_with_runner', [])
>      endif
>=20=20
>      test_deps =3D [roms, keymap_targets]
> @@ -423,6 +442,49 @@ foreach speed : ['quick', 'thorough']
>             priority: test_timeouts.get(test, 90),
>             suite: suites)
>      endforeach
> +
> +    # Prepare tests that require a specific runner.
> +    foreach test : target_tests_r
> +      testname =3D '@0@-@1@'.format(target_base, test[0])
> +      testfile =3D 'test_' + test[0] + '.py'
> +      testpath =3D meson.current_source_dir() / testfile
> +      teststamp =3D testname + '.tstamp'
> +      testrunner  =3D test[1]
> +      testproto =3D test[2]
> +
> +      test_precache_env =3D environment()
> +      test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_di=
r() / teststamp)
> +      # python_site_packages, i.e., site packages from Python in pyvenv,=
 is
> +      # added to PYTHONPATH because some runners can run a program that =
has its
> +      # own Python hooks that, by its turn, will search for modules base=
d on
> +      # PYTHONPATH independently of the Python used by the runner, like,=
 for
> +      # example, GDB using libpython.
> +      test_precache_env.set('PYTHONPATH', meson.project_source_root() / =
'python' +
> +                                          ':' + meson.current_source_dir=
() +
> +                                          ':' + python_site_packages)
> +      precache =3D custom_target('func-precache-' + testname,
> +                               output: teststamp,
> +                               command: [testrunner, testpath],
> +                               depend_files: files(testpath),
> +                               build_by_default: false,
> +                               env: test_precache_env)
> +      precache_all +=3D precache
> +
> +      # See comment above about python_site_packages in test_precache_en=
v.
> +      # Don't append to test_env since it will affect previous uses of i=
t.
> +      test_r_env =3D test_env
> +      test_r_env.append('PYTHONPATH', python_site_packages)
> +
> +      test('func-' + testname,
> +           python,
> +           depends: [test_deps, test_emulator, emulator_modules, plugin_=
modules],
> +           env: test_r_env,
> +           args: [testrunner, testpath],
> +           protocol: testproto,
> +           timeout: test_timeouts.get(test[0], 90),
> +           priority: test_timeouts.get(test[0], 90),
> +           suite: suites)
> +    endforeach
>    endforeach
>  endforeach

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

