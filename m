Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73A2CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 09:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvY4U-0007Gf-SA; Mon, 08 Sep 2025 05:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvY4T-0007Dh-99
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 05:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvY4K-0002nq-6q
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 05:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757323302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QltnutdHvCokmOcNASWNTMGcEaGltqtGCKSMHli3Lsc=;
 b=W29qwh+2s5zfAtJfJFEPRQArCST329hksRUfr/GyCiBXJIcvN+mcMpmNK1s4vokUp3xPI8
 5a9BmMJNaFwdLIZLw22+st8BQQrjVsCTBwZ/JNIlBnZSRTJhumkXxa4MKW3yJDN/EmLqpt
 upmYLFkl+qvwfMPyLfKsUUYdnX2Vc3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-l8hjK_lsPpKWDTFfVtjwuA-1; Mon, 08 Sep 2025 05:21:41 -0400
X-MC-Unique: l8hjK_lsPpKWDTFfVtjwuA-1
X-Mimecast-MFC-AGG-ID: l8hjK_lsPpKWDTFfVtjwuA_1757323300
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e2055ce8b7so1491642f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 02:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757323300; x=1757928100;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QltnutdHvCokmOcNASWNTMGcEaGltqtGCKSMHli3Lsc=;
 b=d/494IAiDKpqtpKDdppjzhy/j3FoprlG5Yjo8Xbt9iL3jKdMacVJC3GBlPNoWD8ZMR
 8tFZU/1kSPdT53oFmxY+LBiLAbzGIAAzT847/BzF0wxc9e5gGBXfOIHW3Cx+kugg1cV4
 ayKEOP0BJdM/vRdIl5FPWbbqC0aUKzTffPK0C2x78trlJCw/BUfc25zCjMaLtYUGcCif
 35KINzlHle65633fJk5fHFnJB/b4sBLVVgGQC6iQhiJIKrjtuzsAlb/ZHsV9WU6PVCUs
 5sTNNGIy5raNyK50J4zgagvWwNpAUze+Np7GEFa4RXlRcUSeWAWlIM9vsEzukI+CECHo
 Ghvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhsH7I6YH47LbAPImlV/OohdfCCIMsPNosvshYkE8IdjVeiyJPjPx/iFZ8X5GlVHH8seze5focxQaR@nongnu.org
X-Gm-Message-State: AOJu0Yyt+Vp/6oJtyf+i1GIiAGgoxyRCvqK+KzjhUSABUuLVFU0XrcI2
 5VOrxe16EPa3GbCU543MLUizfnLWAOnO73W+KVKVHmWhLP/wJou08yEeAUACGzQ9jw7gHl5iJu6
 1N+5HoiCLpNPpi2Qzbm84gDFT6kja0nYB2EyLTPFKA9mIRJewiEZM3v/Y
X-Gm-Gg: ASbGncvVCgRzhH6uG+qcXrUgli5+7Q5Q9GaactuegD58Sb2gj9jE2bOV6nRCnSvKRdo
 VjgtNk9Legs54wnTs7Da+WTagaSsWpwCp+A0cBGRm9mgq/HqmQ83S+aNWPxAIFUMnn0F/4XJR6J
 xUe2HYgxVrjI3ZNTKBN6317z/Ha85Iye7760vIJk6mGe4yXkOaRrCCR0fvGzZbWlAlH9uyZguyT
 JDQbVTHZp9q659Q3xLO8VEfK+JFEmV4coInNfr4kLIRvReKAW9lNNLSA0ZEeEz9REaZKNfeUt3s
 5U74BgAekAhcVlPlm/MQ/+sgDzmIA3ODcXoR5/jm5qOECASfiooI3W7fQsB3lxJCkQLUcQblEIa
 p4Nw5/Q==
X-Received: by 2002:a05:6000:2a82:b0:3e7:490c:1b0 with SMTP id
 ffacd0b85a97d-3e7490c03aemr1307837f8f.12.1757323299874; 
 Mon, 08 Sep 2025 02:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6vAOeQ7O01kaQvht5K6XC3+j+cvADtUsEEeUs1ThJ7otRQkkcXx/nOYqPF+dvlAVOucVVhw==
X-Received: by 2002:a05:6000:2a82:b0:3e7:490c:1b0 with SMTP id
 ffacd0b85a97d-3e7490c03aemr1307812f8f.12.1757323299371; 
 Mon, 08 Sep 2025 02:21:39 -0700 (PDT)
Received: from [192.168.0.5] (ltea-047-064-114-112.pools.arcor-ip.net.
 [47.64.114.112]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e329475a13sm12854079f8f.14.2025.09.08.02.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 02:21:38 -0700 (PDT)
Message-ID: <b29080f8-c79f-44e5-840e-e1e49b0007ea@redhat.com>
Date: Mon, 8 Sep 2025 11:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] tests/functional: Support tests that require a
 runner
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, 1844144@gmail.com
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-5-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250904154640.52687-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/09/2025 17.46, Gustavo Romero wrote:
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
> The GDB runner is only defined if GDB is detected. The probe is done
> in 'configure' and the full path is passed to meson.build via the -Dgdb=
> option.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   configure                     |  2 ++
>   meson.build                   |  4 +++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  2 ++
>   tests/functional/meson.build  | 65 +++++++++++++++++++++++++++++++++++
>   5 files changed, 75 insertions(+)
> 
> diff --git a/configure b/configure
> index 274a778764..8e2e2cd562 100755
> --- a/configure
> +++ b/configure
> @@ -1978,6 +1978,8 @@ if test "$skip_meson" = no; then
>     test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
>     test "$plugins" = yes && meson_option_add "-Dplugins=true"
>     test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
> +  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
> +
>     run_meson() {
>       NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
>     }
> diff --git a/meson.build b/meson.build
> index 0d42de61ae..7e0afe8288 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -75,6 +75,10 @@ have_user = have_linux_user or have_bsd_user
>   
>   sh = find_program('sh')
>   python = import('python').find_installation()
> +# Meson python.get_path() on 'purelib' or 'platlib' doesn't properly return the
> +# site-packages dir in pyvenv, so it is built manually.
> +python_ver = python.language_version()
> +python_site_packages = meson.build_root() / 'pyvenv/lib/python' + python_ver / 'site-packages'
>   
>   cc = meson.get_compiler('c')
>   all_languages = ['c']
> diff --git a/meson_options.txt b/meson_options.txt
> index fff1521e58..5bb41bcbc4 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -36,6 +36,8 @@ option('trace_file', type: 'string', value: 'trace',
>   option('coroutine_backend', type: 'combo',
>          choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
>          value: 'auto', description: 'coroutine backend to use')
> +option('gdb', type: 'string', value: '',
> +       description: 'Path to GDB')
>   
>   # Everything else can be set via --enable/--disable-* option
>   # on the configure script command line.  After adding an option
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 0ebe6bc52a..f4bd21220e 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -58,6 +58,7 @@ meson_options_help() {
>     printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
>     printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
>     printf "%s\n" '                           firmware]'
> +  printf "%s\n" '  --gdb=VALUE              Path to GDB'
>     printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
>     printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
>     printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
> @@ -323,6 +324,7 @@ _meson_option_parse() {
>       --disable-fuzzing) printf "%s" -Dfuzzing=false ;;
>       --enable-gcrypt) printf "%s" -Dgcrypt=enabled ;;
>       --disable-gcrypt) printf "%s" -Dgcrypt=disabled ;;
> +    --gdb=*) quote_sh "-Dgdb=$2" ;;
>       --enable-gettext) printf "%s" -Dgettext=enabled ;;
>       --disable-gettext) printf "%s" -Dgettext=disabled ;;
>       --enable-gio) printf "%s" -Dgio=enabled ;;
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 2a0c5aa141..febd31a263 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -9,6 +9,25 @@ if get_option('tcg_interpreter')
>     subdir_done()
>   endif
>   
> +# Define the GDB runner if GDB is available.
> +gdb = get_option('gdb')
> +if gdb != ''
> +    gdb_runner_script =  meson.project_source_root() + '/tests/guest-debug/run-test.py'
> +    gdb_runner = [gdb_runner_script, '--quiet', '--gdb', gdb, '--test']
> +
> +    message('GDB runner defined based on GDB found at: ', gdb)
> +
> +    # A test with a runner is a tuple (name, runner, protocol).
> +    # The tests must be elements of an array named like:
> +    #
> +    # test_<arch>_<mode=[system|linuxuser|bsduser]>_<speed=[quick|thorough]>_with_runner = [
> +    #      ['test0', gdb_runner, 'exitcode'],
> +    #      ...
> +    # ]
> +else
> +    message('GDB not found, skipping functional tests that rely on it.')
> +endif
> +
>   subdir('aarch64')
>   subdir('alpha')
>   subdir('arm')
> @@ -61,9 +80,11 @@ foreach speed : ['quick', 'thorough']
>         suites = ['func-quick', 'func-' + target_base]
>         target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
>                        + get_variable('tests_generic_' + sysmode)
> +      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_quick_with_runner', [])
>       else
>         suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
>         target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
> +      target_tests_r = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed + '_with_runner', [])
>       endif
>   
>       test_deps = [roms, keymap_targets]
> @@ -121,6 +142,50 @@ foreach speed : ['quick', 'thorough']
>              priority: time_out,
>              suite: suites)
>       endforeach
> +
> +    # Prepare tests that require a specific runner.
> +    foreach test : target_tests_r
> +      testname = '@0@-@1@'.format(target_base, test[0])
> +      testfile = target_base / 'test_' + test[0] + '.py'
> +      testpath = meson.current_source_dir() / testfile
> +      teststamp = testname + '.tstamp'
> +      testrunner  = test[1]
> +      testproto = test[2]
> +
> +      # python_site_packages, i.e., site packages from Python in pyvenv, is
> +      # added to PYTHONPATH because some runners can run a program that has its
> +      # own Python hooks that, by its turn, will search for modules based on
> +      # PYTHONPATH independently of the Python used by the runner, like, for
> +      # example, GDB using libpython.
> +      test_r_precache_env = test_precache_env
> +      test_r_precache_env.append('PYTHONPATH', python_site_packages)
> +      # For similar reasons, PYTHONPATH must also include the path to the test
> +      # scripts, otherwise unittest's introspection will failed.
> +      test_r_precache_env.append('PYTHONPATH', meson.current_source_dir() / target_base)
> +
> +      precache = custom_target('func-precache-' + testname,
> +                               output: teststamp,
> +                               command: [testrunner, testpath],
> +                               depend_files: files(testpath),
> +                               build_by_default: false,
> +                               env: test_r_precache_env)
> +      precache_all += precache
> +
> +      # See comments above about PYTHONPATH in test_r_precache_env.
> +      test_r_env = test_env
> +      test_r_env.append('PYTHONPATH', python_site_packages)
> +      test_r_env.append('PYTHONPATH', meson.current_source_dir() / target_base)
> +
> +      test('func-' + testname,
> +           python,
> +           depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
> +           env: test_r_env,
> +           args: [testrunner, testpath],
> +           protocol: testproto,
> +           timeout: time_out,
> +           priority: time_out,
> +           suite: suites)
> +    endforeach
>     endforeach
>   endforeach

It's a little bit unfortunate that we get quite a bit of almost duplicated 
code in meson.build this way, but I currently also lack an idea of doing it 
in a better way... So from my side:

Acked-by: Thomas Huth <thuth@redhat.com>


