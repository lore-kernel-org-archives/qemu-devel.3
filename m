Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A5E67495
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 17:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXjIk-00085d-7A; Mon, 22 Dec 2025 12:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vXjHo-0007ds-8R
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 12:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vXjHl-0005Qx-Uk
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 12:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766422886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ALIGATKrzI5pnjC+gVMvURVoLNH7RTAfk+IJuULXVbA=;
 b=PXsyamzTd+80GF0Az+bmsWEKez9s4Ts2g6p4fsNOa8f5NIsd7rBDuCsRQf7nUt/Yolsl3D
 hmil8/YnVeSTqYCLIMNW6rHcXcDc0yqYWcwepSjHBP5chimvdrsQcYbVOPj5eR73p+m7EY
 uHc8GNFRhdJsHn9dOfpFQ80/Fcdk284=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-EE-AtwAZNTuxKZkAgDqyXg-1; Mon, 22 Dec 2025 12:01:24 -0500
X-MC-Unique: EE-AtwAZNTuxKZkAgDqyXg-1
X-Mimecast-MFC-AGG-ID: EE-AtwAZNTuxKZkAgDqyXg_1766422883
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so39999165e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766422883; x=1767027683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ALIGATKrzI5pnjC+gVMvURVoLNH7RTAfk+IJuULXVbA=;
 b=ps8mclLkonVspX5vaL7MZQgHpkGhwGf+RXNbYGQHFI+w8KVt/kz9G6OdknrqgzbwaI
 EWUFFCrPJwnTsyr8AA37PdnlbJnqkvVC5NA4pubk40/RW7hGBWVAn8Kv3CkLhSMSeDWf
 mhWXK9BEmjIkOU65cBwEmgjk/oH0racvaKxEpWxsaYKAiKmkPLpudteQgCgKlIngB2IT
 y/U9xTUJRIwd/XVCFx4wG7eCumil2+TjDTict2yMklDjeG1UgpHM6gG0l/Hw+jyQMCr8
 xOMWvQTXAvP8e2WNjc+qlJlZEvNhlt6vL5IM5XVmGNwXKNAqvdBHoWyF3s0LR2o6MG7I
 urgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766422883; x=1767027683;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALIGATKrzI5pnjC+gVMvURVoLNH7RTAfk+IJuULXVbA=;
 b=G6a0077bHX4VVHVvUJPzNlOM8Bc7PtddUXcXb8oBn/BpCusF4u6OCzb4Om4z0yT+Fh
 CLqDcunCatiZfkhpLVz+jcTAfbPLBLe1fnfEumJYvHsx8Ch+i4BoF/kBe+XdaZS/5quq
 L9KWYEIlG89/BncU1StLfQpFgVqUU/Kluj1c7G3w7NIcvhGrk+OHKTcbu1UQQCfvD/3i
 CB98XaxvEab2FnJ+yLnt75YAyx6owNnyAXzFm5aOtCPUeCMqEcbixQAUt4p+3s06JzQ4
 hmRlRxvSvxgPFgwUQ/Tde+1J2I4b01JXNN2d2hJWZ7FBUEZPPWYmxb/ZczSIl71O7vxU
 rTIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbpNowqHZwUPknMyTYXF8BEhIEmFoN7ffFW4BflylQZVdxSWCJmAF6TVjt3wckOL1utWqgb3aAAfKR@nongnu.org
X-Gm-Message-State: AOJu0Yw9LDmoc15BT+j4iz3IwhiXJMV1uG4wgdn36Vld2tAkD64bd0xr
 YV31aTlLzuxlGgtEtqesVbFqr2pHr+Y4HbUEfyeYpPnl0gUge3T1p+Wav4pSA4efs6VW25K9Txm
 TStI/2sOVE+ynAiVWmbP4PAIm9vlCvLQBpm5P/Ewwl1+4H9VFnqEudSc3
X-Gm-Gg: AY/fxX6viM/X64QAIoJuaLS0mEQf13my9M5RZW2VGO+aqJfkCHVTJ/1Sk8gQRSf8Eb0
 TxCWgtaFJvgHupB7N97LkZ0EeMoWQadaWvUR87LhUqKf8jRbUl4I5zJ/etT8qgRjvCKidgguR0a
 oZ4WEo9hehw3bFIC5J+qH08E1jI5w/UOWr+jpZAY8Z6DmFmw6Hpe6wa00iTGRakKa+LDgKkLCbI
 hjRh4Eu+Jz0Yxtdh8qRMeCOPCWQu+7d44QTMKRTpJwl+5Esr4fK0Jo+xHo3c6oirc4rlLkpE/vV
 ov9KmYCALhnzAuh85De4T+4diGaxg/9lp/uwFOzWz55xjPMvJJ+o3TLcp+w8C20Pj3DjtEXreHp
 c7PTzy+azq8CruoZ1WniOvsjAFXl0WwPAWiWLZYM12kjY60xMuaUOWXx5Axtym/Li1BuSar/ZKM
 tJ6PxIz3bwncpACZg=
X-Received: by 2002:a05:6000:22c8:b0:431:104:6db2 with SMTP id
 ffacd0b85a97d-4324e4c7440mr13084575f8f.3.1766422882702; 
 Mon, 22 Dec 2025 09:01:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdm7rE8eBD9ODnhSO63+XZoUxSlcMdA4MvMEpUKGYw+rdqO9kMrUKYrEXfygoEMl+CatQyjQ==
X-Received: by 2002:a05:6000:22c8:b0:431:104:6db2 with SMTP id
 ffacd0b85a97d-4324e4c7440mr13084415f8f.3.1766422880775; 
 Mon, 22 Dec 2025 09:01:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4324e9ba877sm22684770f8f.0.2025.12.22.09.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 09:01:20 -0800 (PST)
Message-ID: <1bf91b9f-19ce-4bdb-a403-e4fdd2cd943a@redhat.com>
Date: Mon, 22 Dec 2025 18:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] run: introduce a script for running devel commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251222113859.182395-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251222113859.182395-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/22/25 12:38, Daniel P. Berrangé wrote:
> Various aspects of the development workflow are complicated by the need
> to set env variables ahead of time, or use specific paths. Meson
> provides a 'devenv' command that can be used to launch a command with a
> number of appropriate project specific environment variables preset.
> 
> By default it will modify $PATH to point to any build directory that
> contains a binary built by the project.
> 
> This further augments that to replicate the venv 'activate' script:
> 
>   * Add $BUILD_DIR/pyvenv/bin to $PATH
>   * Set VIRTUAL_ENV to $BUILD_DIR/pyvenv
> 
> And then makes functional tests more easily executable
> 
>   * Add $SRC_DIR/tests/functional and $SRC_DIR/python to $PYTHONPATH
> 
> To see the benefits of this consider this command:
> 
>    $ source ./build/pyvenv/bin/activate
>    $ ./scripts/qmp/qmp-shell-wrap ./build/qemu-system-x86_64
> 
> which is now simplified to
> 
>    $ ./build/run ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 [args..]
> 
> This avoids the need repeat './build' several times and avoids polluting
> the current terminal's environment and/or avoids errors from forgetting
> to source the venv settings.
> 
> As another example running functional tests
> 
>    $ export PYTHONPATH=./python:./tests/functional
>    $ export QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64
>    $ build/pyvenv/bin/python3 ./tests/functional/x86_64/test_virtio_version.py
> 
> which is now simplified to
> 
>    $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>    $ ./build/run ./tests/functional/x86_64/test_virtio_version.py
> 
> This usefulness of this will be further enhanced with the pending
> removal of the QEMU python APIs from git, as that will require the use
> of the python venv in even more scenarios that today.
> 
> The 'run' script does not let 'meson devenv' directly launch the command
> to be run because it always requires $BUILD_DIR as the current working
> directory. It is desired that 'run' script always honour the current
> working directory of the terminal that invokes is. Thus the '--dump'
> flag is used to export the devenv variables into the 'run' script's
> shell.
> 
> This takes the liberty to assign 'run.in' to the "Build system" section
> in the MAINTAINERS file, given that it leverages meson's 'devenv'
> feature.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> Changed in v2:
> 
>   * Switch to use meson's  "devenv" framework
>   * Fix some typos
> 
>   MAINTAINERS                       |  1 +
>   docs/devel/build-system.rst       | 12 ++++++++++++
>   docs/devel/testing/functional.rst | 17 ++++++++---------
>   meson.build                       | 16 ++++++++++++++--
>   run.in                            |  6 ++++++
>   5 files changed, 41 insertions(+), 11 deletions(-)
>   create mode 100644 run.in
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63e9ba521b..f21b2927a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4479,6 +4479,7 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
>   S: Maintained
>   F: meson.build
>   F: meson_options.txt
> +F: run.in
>   F: scripts/check_sparse.py
>   F: scripts/symlink-install-tree.py
>   
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 6204aa6a72..b9797a374c 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -515,6 +515,18 @@ generates ``Makefile`` from ``Makefile.in``.
>   
>   Built by configure:
>   
> +``run``
> +  Used to run commands / scripts from the git checkout. Sets ``$PATH``
> +  to point to locally built binaries, and activates the python venv
> +  before running the requested command. Pass the command to run as
> +  args, for example::
> +
> +    $ ./build/run ./script/qmp/qmp-shell-wrap qemu-system-x86_64
> +
> +  will use the ``python3`` binary and site-packages from the local
> +  venv to run ``qmp-shell-wrap`` and spawn the QEMU emulator from
> +  the build directory.
> +
>   ``config-host.mak``
>     When configure has determined the characteristics of the build host it
>     will write the paths to various tools to this file, for use in ``Makefile``
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index fdeaebaadc..1978f96eba 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -53,15 +53,14 @@ the following line will only run the tests for the x86_64 target:
>     make check-functional-x86_64
>   
>   To run a single test file without the meson test runner, you can also
> -execute the file directly by specifying two environment variables first,
> -the PYTHONPATH that has to include the python folder and the tests/functional
> -folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
> -to the QEMU binary that should be used for the test. The current working
> -directory should be your build folder. For example::
> -
> -  $ export PYTHONPATH=../python:../tests/functional
> -  $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
> -  $ pyvenv/bin/python3 ../tests/functional/test_file.py
> +execute the file directly by specifying the name of the emulator target
> +binary as an env variable.
> +
> +Assuming the current working directory is the top level source checkout
> +and the build directory is './build'::
> +
> +  $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
> +  $ ./build/run tests/functional/x86_64/test_virtio_version.py
>   
>   The test framework will automatically purge any scratch files created during
>   the tests. If needing to debug a failed test, it is possible to keep these
> diff --git a/meson.build b/meson.build
> index d9293294d8..320fecf372 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3,8 +3,6 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>                             'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
>           version: files('VERSION'))
>   
> -meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
> -
>   add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
>                  env: ['RUST_BACKTRACE=1'])
>   add_test_setup('slow', exclude_suites: ['thorough'],
> @@ -3507,6 +3505,20 @@ endif
>   config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
>   genh += config_host_h
>   
> +devenv = environment()
> +devenv.set('MESON_BUILD_ROOT', meson.project_build_root())
> +devenv.set('VIRTUAL_ENV', meson.project_build_root() / 'pyvenv')
> +devenv.prepend('PATH', meson.project_build_root() / 'pyvenv'/ 'bin')
> +devenv.prepend('PYTHONPATH', meson.current_source_dir() / 'tests' / 'functional')
> +devenv.prepend('PYTHONPATH', meson.current_source_dir() / 'python')
> +meson.add_devenv(devenv)
> +
> +run_config = configuration_data({'build_dir': meson.current_build_dir()})
> +run = configure_file(input: 'run.in',
> +                     output: 'run',
> +                     configuration: run_config)
> +run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check: true)
> +
>   hxtool = find_program('scripts/hxtool')
>   shaderinclude = find_program('scripts/shaderinclude.py')
>   qapi_gen = find_program('scripts/qapi-gen.py')
> diff --git a/run.in b/run.in
> new file mode 100644
> index 0000000000..cf4821311d
> --- /dev/null
> +++ b/run.in
> @@ -0,0 +1,6 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +eval $(meson devenv -C @build_dir@ --dump --dump-format export)

This should use @build_dir@/pyvenv/bin/meson, because the system meson 
is not necessarily able to read the devenv setup from meson's 
pickle-format dumps.

And while at it, we can also change it to use -w "$PWD" instead:

exec @build_dir@/pyvenv/bin/meson devenv -C @build_dir@ -w "$PWD" "$@"

I'll do this and apply the patch, thanks!

Paolo


