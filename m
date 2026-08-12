Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF7CC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuElj-000713-5z; Wed, 12 Aug 2026 15:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuEld-00070h-3E
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:37:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuEla-0008DQ-PQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:37:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so2256185e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786563453; x=1787168253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VxtiUznwABrYOxoL3ttN2Q/seuvdt8LmJEehtNDNqjo=;
 b=vOleWu9uR1ViUhC8WChnvpWlULbcWtRBRSY437LflxsjSQTbSKg1rGq1Rk7g3sLVM2
 9Qquh+0mVWSTF82zJKV8Y2d6dX7d18h6GAXZNoKNrfGEVtfnuQyJCUi1YCKdT6BmmWg0
 D9kCJEQcGaCyTAuQPrY1/9ZyeAez8WFxOo4huaXc5xb8CsDtYJW02E/lWsnnxBMVfIda
 WVB70q8QwFrfQSb/3Zf4Me5UNEiBAMKt0BGQ65jPoogv4eWFIN7FpoiFYJiFNPQcFkL4
 lFI8nvU7FvhPZGumAA3jywmWPxmBX+hwSeKi3IFqtB2HKg66b3OSehASVOVA0WfY4Rjq
 NpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786563453; x=1787168253;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VxtiUznwABrYOxoL3ttN2Q/seuvdt8LmJEehtNDNqjo=;
 b=lKeA6xgMFOmzd6Bt83H+3o2hwEa/3/8X+tJtHFpuxUdM0fuhtXPmPJq2CYghgN5NJs
 jqjEA1Umh03COykvQaCprYeDdX3cgmqwHTJdD5N8tujzqdLr8XYQfFU2BJTvArLUeG8e
 hPZrgjBdTnpbSzcZHIJ1k97hG5xwsTZtZDLS6ECleTtOb1TcKkcQj18Mx2b4iBBptCb2
 G5E5CTzABrteiEjBEk+v78P5S33h8lJS2UotDmvI4m2LPpk9QEWheacAS2nsgCrOPIuw
 UgO1U3mf6HQdqizpFXDHzBwbWBNS2sQJEKFmbVJ5P+YlY3R5t+LOR9aIKvrHPRdJSTh3
 K6Yg==
X-Gm-Message-State: AOJu0Yz1j7a5ngIpqkM382+BUi4tiNrmgodU6O9XJdQlqcjD82UhVBoq
 DIZ8hoNLDuJxzQ4SXJEtXPvGtaPMlmcC9/+fAOcLeYfO17aODUFwoL98qT/YgsaPbGk=
X-Gm-Gg: AR+sD10ECqi00FTXgJzJVRGfscOtPRGqsZpIl+wXt7vc15iWBcxaWQxP4PAGhKF7CAZ
 Rmr238GFK5/+Bd+sdfokVm0yntFYcDTJ/xK/JBRxVbpEPw+mzqNhXgGvt5iSW3FUuouQFlLQj41
 wkGqIYCW/gg8ekScchvxCPPjv45e2nYOJbx7v9YgXSnBAtlYtIqevHhqL2fkbKChoOsps980kA0
 p4G9TG9R72sEkSk15VqvIKZmkDdeMntPmHBBEZ2dKKrEqjWdLhBYbLRnypo0QoKbNJ6W+LhXAjH
 WZ18RUMje/cHOk1RoYV9DZ6pbkt96giX62uv4+ZTWoBMxBCxF1SfnWDjGZ6yQWbJOdTcTh/Gm2f
 e46VFQ/qcPPaQpzJcRtx87Ufr9oxWKPubxJpEzoWVM85K6fGUjpEfsOyZSeOqCo2tC/RISyrj6v
 E1O2bv6fVPWneAJm0EgNY7/cPwCK6+0VwQZg2WC2IHeiV3qKx83f9J1M8W2Zlu
X-Received: by 2002:a05:600c:810a:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-4998216f7eamr1281605e9.2.1786563452894; 
 Wed, 12 Aug 2026 12:37:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b1063esm14073335e9.6.2026.08.12.12.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 12:37:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6D445F89F;
 Wed, 12 Aug 2026 20:37:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 100/103] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
In-Reply-To: <8da0e719-fda6-4edd-b436-458c0d4f3d39@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 12 Aug 2026 09:10:14 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-101-pierrick.bouvier@oss.qualcomm.com>
 <87v79fzfqb.fsf@draig.linaro.org> <8733wjz5pg.fsf@draig.linaro.org>
 <8da0e719-fda6-4edd-b436-458c0d4f3d39@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 20:37:30 +0100
Message-ID: <87ldabxh8l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 8/12/2026 9:03 AM, Alex Benn=C3=A9e wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> When a user set explicit cross cc, we ensure it's available and workin=
g.
>>>> When a user set explicit cross cflags, we ensure they work with default
>>>> or overriden cross_cc.
>>>>
>>>> Made the first implementation with a single meson option (array), which
>>>> proved to be absolutely unreadable.
>>>> By having one option per target, we directly detect issue at configure
>>>> time, either for user, or when iterating on all our targets. This
>>>> ensures user can't mispell any target name, and that we can't forget a=
ny
>>>> new one in the future.
>>>> Also, it shows them in the configuration summary, which is a bonus.
>>>>
>>>> Since we now only need to know compiler to write tcg tests, we can
>>>> simply alias -cross-prefix-* options to compiler override.
>>>>
>>>> Examples
>>>> --------
>>>>
>>>> wrong architecture:
>>>> $ ./configure --cross-cc-bad=3D'cc'
>>>> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
>>>>
>>>> wrong option:
>>>> $ ./configure --cross-cc-cflags-aarch64=3D'-bad-option'
>>>> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linu=
x-gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static=
 -nostdlib -r -o /dev/null` failed with status 1.
>>>> A full log can be found at /qemu/build/meson-logs/meson-log.txt
>>>>
>>>> cross compile with clang (fails at the moment, since some tests have
>>>> compilation errors with it):
>>>> $ ./configure --target-list=3Daarch64-linux-user --cross-cc-aarch64=3D=
'clang' --cross-cc-cflags-aarch64=3D'-target aarch64-linux-gnu'
>>>>   User defined options
>>>>   ...
>>>>     tcg_tests_cross_cc_aarch64      : clang
>>>>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  configure             | 27 ++++++-------
>>>>  meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
>>>>  tests/tcg/meson.build | 30 ++++++++++++---
>>>>  3 files changed, 126 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/configure b/configure
>>>> index 568de41dadd..c9e2cdcce5f 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -227,19 +227,6 @@ for opt do
>>>>    ;;
>>>>    --extra-ldflags=3D*) EXTRA_LDFLAGS=3D"$EXTRA_LDFLAGS $optarg"
>>>>    ;;
>>>> -  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-=
FOO option"
>>>> -  ;;
>>>> -  --cross-cc-cflags-*) cc_arch=3D${opt#--cross-cc-cflags-}; cc_arch=
=3D${cc_arch%%=3D*}
>>>> -                      eval "cross_cc_cflags_${cc_arch}=3D\$optarg"
>>>> -  ;;
>>>> -  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=
=3D*}
>>>> -                eval "cross_cc_${cc_arch}=3D\$optarg"
>>>> -  ;;
>>>> -  --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross=
-prefix-FOO option"
>>>> -  ;;
>>>> -  --cross-prefix-*) cc_arch=3D${opt#--cross-prefix-}; cc_arch=3D${cc_=
arch%%=3D*}
>>>> -                    eval "cross_prefix_${cc_arch}=3D\$optarg"
>>>> -  ;;
>>>>    --without-default-features) default_feature=3D"no"
>>>>    ;;
>>>>    --wasm64-32bit-address-limit) wasm64_memory64=3D"2"
>>>> @@ -632,9 +619,19 @@ for opt do
>>>>    ;;
>>>>    --extra-ldflags=3D*)
>>>>    ;;
>>>> -  --cross-cc-*)
>>>> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-=
FOO option"
>>>>    ;;
>>>> -  --cross-prefix-*)
>>>> +  --cross-cc-cflags-*) arch=3D${opt#--cross-cc-cflags-}; arch=3D${arc=
h%%=3D*}
>>>> +                       meson_option_add "-Dtcg_tests_cross_cflags_${a=
rch}=3D${optarg}"
>>>> +  ;;
>>>> +  --cross-cc-*) arch=3D${opt#--cross-cc-}; arch=3D${arch%%=3D*}
>>>> +                meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D${op=
targ}"
>>>> +  ;;
>>>> +  --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross=
-prefix-FOO option"
>>>> +  ;;
>>>> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
>>>> +  --cross-prefix-*) arch=3D${opt#--cross-prefix-}; arch=3D${arch%%=3D=
*}
>>>> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D=
${optarg}gcc"
>>>>    ;;
>>>>    --enable-docs) docs=3Denabled
>>>>    ;;
>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>> index 5e91969414a..fd9ff0df893 100644
>>>> --- a/meson_options.txt
>>>> +++ b/meson_options.txt
>>>> @@ -389,3 +389,92 @@ option('containers', type: 'boolean', value: true,
>>>>         description: 'use containers to cross compile tcg tests')
>>>>  option('container_command', type: 'string',
>>>>         description: 'command to build/run containers')
>>>> +
>>>> +option('tcg_tests_cross_cc_aarch64', type: 'string',
>>>> +       description: 'cc for aarch64 tcg tests')
>>>> +option('tcg_tests_cross_cflags_aarch64', type: 'string',
>>>> +       description: 'cflags for aarch64 tcg tests')
>>>> +option('tcg_tests_cross_cc_aarch64_be', type: 'string',
>>>> +       description: 'cc for aarch64_be tcg tests')
>>>> +option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
>>>> +       description: 'cflags for aarch64_be tcg tests')
>>>> +option('tcg_tests_cross_cc_alpha', type: 'string',
>>>> +       description: 'cc for alpha tcg tests')
>>>> +option('tcg_tests_cross_cflags_alpha', type: 'string',
>>>> +       description: 'cflags for alpha tcg tests')
>>>> +option('tcg_tests_cross_cc_arm', type: 'string',
>>>> +       description: 'cc for arm tcg tests')
>>>> +option('tcg_tests_cross_cflags_arm', type: 'string',
>>>> +       description: 'cflags for arm tcg tests')
>>>> +option('tcg_tests_cross_cc_hexagon', type: 'string',
>>>> +       description: 'cc for hexagon tcg tests')
>>>> +option('tcg_tests_cross_cflags_hexagon', type: 'string',
>>>> +       description: 'cflags for hexagon tcg tests')
>>>> +option('tcg_tests_cross_cc_hppa', type: 'string',
>>>> +       description: 'cc for hppa tcg tests')
>>>> +option('tcg_tests_cross_cflags_hppa', type: 'string',
>>>> +       description: 'cflags for hppa tcg tests')
>>>> +option('tcg_tests_cross_cc_i386', type: 'string',
>>>> +       description: 'cc for i386 tcg tests')
>>>> +option('tcg_tests_cross_cflags_i386', type: 'string',
>>>> +       description: 'cflags for i386 tcg tests')
>>>> +option('tcg_tests_cross_cc_loongarch64', type: 'string',
>>>> +       description: 'cc for loongarch64 tcg tests')
>>>> +option('tcg_tests_cross_cflags_loongarch64', type: 'string',
>>>> +       description: 'cflags for loongarch64 tcg tests')
>>>> +option('tcg_tests_cross_cc_m68k', type: 'string',
>>>> +       description: 'cc for m68k tcg tests')
>>>> +option('tcg_tests_cross_cflags_m68k', type: 'string',
>>>> +       description: 'cflags for m68k tcg tests')
>>>> +option('tcg_tests_cross_cc_mips', type: 'string',
>>>> +       description: 'cc for mips tcg tests')
>>>> +option('tcg_tests_cross_cflags_mips', type: 'string',
>>>> +       description: 'cflags for mips tcg tests')
>>>> +option('tcg_tests_cross_cc_mips64', type: 'string',
>>>> +       description: 'cc for mips64 tcg tests')
>>>> +option('tcg_tests_cross_cflags_mips64', type: 'string',
>>>> +       description: 'cflags for mips64 tcg tests')
>>>> +option('tcg_tests_cross_cc_mips64el', type: 'string',
>>>> +       description: 'cc for mips64el tcg tests')
>>>> +option('tcg_tests_cross_cflags_mips64el', type: 'string',
>>>> +       description: 'cflags for mips64el tcg tests')
>>>> +option('tcg_tests_cross_cc_or1k', type: 'string',
>>>> +       description: 'cc for or1k tcg tests')
>>>> +option('tcg_tests_cross_cflags_or1k', type: 'string',
>>>> +       description: 'cflags for or1k tcg tests')
>>>> +option('tcg_tests_cross_cc_ppc64', type: 'string',
>>>> +       description: 'cc for ppc64 tcg tests')
>>>> +option('tcg_tests_cross_cflags_ppc64', type: 'string',
>>>> +       description: 'cflags for ppc64 tcg tests')
>>>> +option('tcg_tests_cross_cc_ppc64le', type: 'string',
>>>> +       description: 'cc for ppc64le tcg tests')
>>>> +option('tcg_tests_cross_cflags_ppc64le', type: 'string',
>>>> +       description: 'cflags for ppc64le tcg tests')
>>>> +option('tcg_tests_cross_cc_riscv64', type: 'string',
>>>> +       description: 'cc for riscv64 tcg tests')
>>>> +option('tcg_tests_cross_cflags_riscv64', type: 'string',
>>>> +       description: 'cflags for riscv64 tcg tests')
>>>> +option('tcg_tests_cross_cc_s390x', type: 'string',
>>>> +       description: 'cc for s390x tcg tests')
>>>> +option('tcg_tests_cross_cflags_s390x', type: 'string',
>>>> +       description: 'cflags for s390x tcg tests')
>>>> +option('tcg_tests_cross_cc_sh4', type: 'string',
>>>> +       description: 'cc for sh4 tcg tests')
>>>> +option('tcg_tests_cross_cflags_sh4', type: 'string',
>>>> +       description: 'cflags for sh4 tcg tests')
>>>> +option('tcg_tests_cross_cc_tricore', type: 'string',
>>>> +       description: 'cc for tricore tcg tests')
>>>> +option('tcg_tests_cross_cflags_tricore', type: 'string',
>>>> +       description: 'cflags for tricore tcg tests')
>>>> +option('tcg_tests_cross_cc_x86_64', type: 'string',
>>>> +       description: 'cc for x86_64 tcg tests')
>>>> +option('tcg_tests_cross_cflags_x86_64', type: 'string',
>>>> +       description: 'cflags for x86_64 tcg tests')
>>>> +option('tcg_tests_cross_cc_xtensa', type: 'string',
>>>> +       description: 'cc for xtensa tcg tests')
>>>> +option('tcg_tests_cross_cflags_xtensa', type: 'string',
>>>> +       description: 'cflags for xtensa tcg tests')
>>>> +option('tcg_tests_cross_cc_xtensaeb', type: 'string',
>>>> +       description: 'cc for xtensaeb tcg tests')
>>>> +option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
>>>> +       description: 'cflags for xtensaeb tcg tests')
>>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>>> index ba73eecf1c9..8dd6623ad1d 100644
>>>> --- a/tests/tcg/meson.build
>>>> +++ b/tests/tcg/meson.build
>>>> @@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
>>>>      continue
>>>>    endif
>>>>=20=20
>>>> +  cc_arch =3D target.replace('-linux-user', '').replace('-softmmu', '=
')
>>>> +
>>>>    # Detect duplicated executables/tests, and report an error to force=
 user to
>>>>    # choose how to deal with it.
>>>>    built_tests =3D {}
>>>> @@ -197,16 +199,34 @@ foreach target, plan: tcg_tests
>>>>    endforeach
>>>>=20=20
>>>>    cc =3D find_program(plan['cc'], required : false)
>>>> +  cc_cflags =3D []
>>>> +
>>>> +  check_flags =3D []
>>>> +  check_required =3D false
>>>> +  cross_cc =3D get_option('tcg_tests_cross_cc_' + cc_arch)
>>>> +  if cross_cc !=3D ''
>>>> +    # we make sure cross cc exists
>>>> +    cc =3D find_program(cross_cc, required: true)
>>>> +    check_required =3D true
>>>> +  endif
>>>> +  cross_cflags =3D get_option('tcg_tests_cross_cflags_' + cc_arch)
>>>> +  if cross_cflags !=3D ''
>>>> +    cc_cflags =3D cross_cflags.split()
>>>> +    # and that cross cc can compile programs
>>>> +    check_flags =3D cc_cflags
>>>> +    check_required =3D true
>>>> +  endif
>>>> +
>>>>    cc_from_system =3D cc.found()
>>>>    has_cc =3D cc.found()
>>>>    if has_cc
>>>> -    check_flags =3D ['-static']
>>>> +    check_flags +=3D ['-static']
>>>>      if target.endswith('softmmu')
>>>> -      check_flags =3D ['-nostdlib', '-r']
>>>> +      check_flags +=3D ['-nostdlib', '-r']
>>>>      endif
>>=20
>> What it needs is -ffreestanding - it gets away with it on linux as the
>> compilers are mostly userspace compilers and it can fallback to those
>> headers. On macOS or if you install a pure bare metal compiler it would
>> fail.
>>
>
> Makes sense, that's a good reason for having this flag setup by default.
> Does it solve the issue to find stdint.h on the mac setup you have?

For softmmu yes, for linux-user we shouldn't ever try to build a target
on macOS (although I don't know if the bsd-user would work?).

>> <snip>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

