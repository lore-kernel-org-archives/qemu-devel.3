Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F593C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu83C-0003yD-Gf; Wed, 12 Aug 2026 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu83A-0003xm-Vo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:27:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu837-0002bN-NT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:27:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so6313495e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537631; x=1787142431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OMpzuxFpEvb2aIDJW+DyGmuYogCYrrJoTKolLeso/5A=;
 b=P0p33fuJegPluqPuaO4INYaAcK/rFPpMNDz+vDXPV6j5VjqqbEMdPgtjbHgSPNUTja
 doF8357MTGdbrt9RbFEayTqVxPJ80B4KNeJo93tKzFqr0gl7e4+toz0SssV0wG98lI10
 jZL0QpCtuwiVT5c/HVQmGauctp2j7FJd4WHmYcVhiSnCbnhdSVKEM8+u+ELpOlYZ96Ty
 wn+OMYcYfqmIv6dKt5uUl18rECb1aGnLcDncQd3H+1cW2AJkqUtb3vYVjXxmhKN27L0j
 B0RJ7W1LG1KeNidG+Z/SiQ6od/b56Pp4BrBH9go2FMLhWG0EYTiQAjD6peVkXSX8/FPS
 aNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537631; x=1787142431;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OMpzuxFpEvb2aIDJW+DyGmuYogCYrrJoTKolLeso/5A=;
 b=Koq9Qvv5MK67B7XDU8Rgr0VU0UDzN/vz9rG06PqQ9MqoI2coS2BEVOgtJQM+pImsfw
 eK3wnU4VaPauIe2y50aB6Lmh2xIk1bY3oEzW4Y2uZIFJsQqTWyvXIfUTtdAH/UtJTQ9c
 HsmLGXIt1spZaIbiBTAspL/gFgotCISDStucRp06L65u2YjSkK3V6gjjPc2VP2gVLhfi
 2OyBK+vwjTIiToxWa4DICwalaTpTe1Q8fXEj5aRT5SvOuEaznoiroRPq6UXnytatEwE5
 d2R2SVvWIEK5Niyv7VL7JYs058U/52MDYWCsXSWP1DoSBUhubx0l79R6OdfGAvYhijI3
 onNg==
X-Gm-Message-State: AOJu0YxlILue221aTip6s3FsdeZF0GdNlS47RcReSSZCS9Ub0EK2/vxM
 qoReIzCroG28igKUvBFd1M45nm5xLdQYzUcwwS/cHTaFNRpmMOxZ6atl23pRm9FmX/A=
X-Gm-Gg: AR+sD12FTBd6N+OUYh0Sg1FKf2pvpmCdN8zTBibe959vIze4aCtMFxnKP8/GzYozjgq
 6X7sxg78UirPnmGBxZ+NZuLBDSkEjvud7IThtTPS3px0cf+7nuYWP8FlyE9MJYobgIABfa0RQm4
 NPDG7vQkNIJzq2f30YDmG6h6Es2+GONFUzcqXjtAaxji7AsE05lrAW26Jt2cWv/sVpd2DkTsauP
 fda0H7zNRP2AcN3nXsQxf5mq43kVFaTQufC4ecRjnJXsurmlbvfErTy+j3ErbwaVHgIBmNlPe5t
 yBWHptl0FzAxHadvFadIwEu1eWze4VM+dH8qHojgTG0+lLKO2Qu6LNdpW4nLLh9QABVD/6RdxX+
 Hw1SC6HH+0XGGSIouB3Gna0a57n1k4P0L0ZXeJgHAVqCAZajC/2n//nRYQyAO9ZSA0BoLW/E4wq
 RRdowaDH4DTNkJVQsByrGTrPLfLxmOvcwUnmu20fK0bGS6zrLDSv8cA0QUoJAYCy92AoqVRKQ=
X-Received: by 2002:a05:6000:1889:b0:481:5167:abda with SMTP id
 ffacd0b85a97d-48152b1ae87mr6246043f8f.9.1786537630938; 
 Wed, 12 Aug 2026 05:27:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5f2fdsm7449513f8f.32.2026.08.12.05.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:27:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 619135F886;
 Wed, 12 Aug 2026 13:27:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 100/103] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
In-Reply-To: <20260728044248.137626-101-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:44 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-101-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 13:27:08 +0100
Message-ID: <87v79fzfqb.fsf@draig.linaro.org>
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

> When a user set explicit cross cc, we ensure it's available and working.
> When a user set explicit cross cflags, we ensure they work with default
> or overriden cross_cc.
>
> Made the first implementation with a single meson option (array), which
> proved to be absolutely unreadable.
> By having one option per target, we directly detect issue at configure
> time, either for user, or when iterating on all our targets. This
> ensures user can't mispell any target name, and that we can't forget any
> new one in the future.
> Also, it shows them in the configuration summary, which is a bonus.
>
> Since we now only need to know compiler to write tcg tests, we can
> simply alias -cross-prefix-* options to compiler override.
>
> Examples
> --------
>
> wrong architecture:
> $ ./configure --cross-cc-bad=3D'cc'
> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
>
> wrong option:
> $ ./configure --cross-cc-cflags-aarch64=3D'-bad-option'
> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-g=
nu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -n=
ostdlib -r -o /dev/null` failed with status 1.
> A full log can be found at /qemu/build/meson-logs/meson-log.txt
>
> cross compile with clang (fails at the moment, since some tests have
> compilation errors with it):
> $ ./configure --target-list=3Daarch64-linux-user --cross-cc-aarch64=3D'cl=
ang' --cross-cc-cflags-aarch64=3D'-target aarch64-linux-gnu'
>   User defined options
>   ...
>     tcg_tests_cross_cc_aarch64      : clang
>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  configure             | 27 ++++++-------
>  meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
>  tests/tcg/meson.build | 30 ++++++++++++---
>  3 files changed, 126 insertions(+), 20 deletions(-)
>
> diff --git a/configure b/configure
> index 568de41dadd..c9e2cdcce5f 100755
> --- a/configure
> +++ b/configure
> @@ -227,19 +227,6 @@ for opt do
>    ;;
>    --extra-ldflags=3D*) EXTRA_LDFLAGS=3D"$EXTRA_LDFLAGS $optarg"
>    ;;
> -  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO=
 option"
> -  ;;
> -  --cross-cc-cflags-*) cc_arch=3D${opt#--cross-cc-cflags-}; cc_arch=3D${=
cc_arch%%=3D*}
> -                      eval "cross_cc_cflags_${cc_arch}=3D\$optarg"
> -  ;;
> -  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
> -                eval "cross_cc_${cc_arch}=3D\$optarg"
> -  ;;
> -  --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-pr=
efix-FOO option"
> -  ;;
> -  --cross-prefix-*) cc_arch=3D${opt#--cross-prefix-}; cc_arch=3D${cc_arc=
h%%=3D*}
> -                    eval "cross_prefix_${cc_arch}=3D\$optarg"
> -  ;;
>    --without-default-features) default_feature=3D"no"
>    ;;
>    --wasm64-32bit-address-limit) wasm64_memory64=3D"2"
> @@ -632,9 +619,19 @@ for opt do
>    ;;
>    --extra-ldflags=3D*)
>    ;;
> -  --cross-cc-*)
> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO=
 option"
>    ;;
> -  --cross-prefix-*)
> +  --cross-cc-cflags-*) arch=3D${opt#--cross-cc-cflags-}; arch=3D${arch%%=
=3D*}
> +                       meson_option_add "-Dtcg_tests_cross_cflags_${arch=
}=3D${optarg}"
> +  ;;
> +  --cross-cc-*) arch=3D${opt#--cross-cc-}; arch=3D${arch%%=3D*}
> +                meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D${optar=
g}"
> +  ;;
> +  --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-pr=
efix-FOO option"
> +  ;;
> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
> +  --cross-prefix-*) arch=3D${opt#--cross-prefix-}; arch=3D${arch%%=3D*}
> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D${o=
ptarg}gcc"
>    ;;
>    --enable-docs) docs=3Denabled
>    ;;
> diff --git a/meson_options.txt b/meson_options.txt
> index 5e91969414a..fd9ff0df893 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -389,3 +389,92 @@ option('containers', type: 'boolean', value: true,
>         description: 'use containers to cross compile tcg tests')
>  option('container_command', type: 'string',
>         description: 'command to build/run containers')
> +
> +option('tcg_tests_cross_cc_aarch64', type: 'string',
> +       description: 'cc for aarch64 tcg tests')
> +option('tcg_tests_cross_cflags_aarch64', type: 'string',
> +       description: 'cflags for aarch64 tcg tests')
> +option('tcg_tests_cross_cc_aarch64_be', type: 'string',
> +       description: 'cc for aarch64_be tcg tests')
> +option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
> +       description: 'cflags for aarch64_be tcg tests')
> +option('tcg_tests_cross_cc_alpha', type: 'string',
> +       description: 'cc for alpha tcg tests')
> +option('tcg_tests_cross_cflags_alpha', type: 'string',
> +       description: 'cflags for alpha tcg tests')
> +option('tcg_tests_cross_cc_arm', type: 'string',
> +       description: 'cc for arm tcg tests')
> +option('tcg_tests_cross_cflags_arm', type: 'string',
> +       description: 'cflags for arm tcg tests')
> +option('tcg_tests_cross_cc_hexagon', type: 'string',
> +       description: 'cc for hexagon tcg tests')
> +option('tcg_tests_cross_cflags_hexagon', type: 'string',
> +       description: 'cflags for hexagon tcg tests')
> +option('tcg_tests_cross_cc_hppa', type: 'string',
> +       description: 'cc for hppa tcg tests')
> +option('tcg_tests_cross_cflags_hppa', type: 'string',
> +       description: 'cflags for hppa tcg tests')
> +option('tcg_tests_cross_cc_i386', type: 'string',
> +       description: 'cc for i386 tcg tests')
> +option('tcg_tests_cross_cflags_i386', type: 'string',
> +       description: 'cflags for i386 tcg tests')
> +option('tcg_tests_cross_cc_loongarch64', type: 'string',
> +       description: 'cc for loongarch64 tcg tests')
> +option('tcg_tests_cross_cflags_loongarch64', type: 'string',
> +       description: 'cflags for loongarch64 tcg tests')
> +option('tcg_tests_cross_cc_m68k', type: 'string',
> +       description: 'cc for m68k tcg tests')
> +option('tcg_tests_cross_cflags_m68k', type: 'string',
> +       description: 'cflags for m68k tcg tests')
> +option('tcg_tests_cross_cc_mips', type: 'string',
> +       description: 'cc for mips tcg tests')
> +option('tcg_tests_cross_cflags_mips', type: 'string',
> +       description: 'cflags for mips tcg tests')
> +option('tcg_tests_cross_cc_mips64', type: 'string',
> +       description: 'cc for mips64 tcg tests')
> +option('tcg_tests_cross_cflags_mips64', type: 'string',
> +       description: 'cflags for mips64 tcg tests')
> +option('tcg_tests_cross_cc_mips64el', type: 'string',
> +       description: 'cc for mips64el tcg tests')
> +option('tcg_tests_cross_cflags_mips64el', type: 'string',
> +       description: 'cflags for mips64el tcg tests')
> +option('tcg_tests_cross_cc_or1k', type: 'string',
> +       description: 'cc for or1k tcg tests')
> +option('tcg_tests_cross_cflags_or1k', type: 'string',
> +       description: 'cflags for or1k tcg tests')
> +option('tcg_tests_cross_cc_ppc64', type: 'string',
> +       description: 'cc for ppc64 tcg tests')
> +option('tcg_tests_cross_cflags_ppc64', type: 'string',
> +       description: 'cflags for ppc64 tcg tests')
> +option('tcg_tests_cross_cc_ppc64le', type: 'string',
> +       description: 'cc for ppc64le tcg tests')
> +option('tcg_tests_cross_cflags_ppc64le', type: 'string',
> +       description: 'cflags for ppc64le tcg tests')
> +option('tcg_tests_cross_cc_riscv64', type: 'string',
> +       description: 'cc for riscv64 tcg tests')
> +option('tcg_tests_cross_cflags_riscv64', type: 'string',
> +       description: 'cflags for riscv64 tcg tests')
> +option('tcg_tests_cross_cc_s390x', type: 'string',
> +       description: 'cc for s390x tcg tests')
> +option('tcg_tests_cross_cflags_s390x', type: 'string',
> +       description: 'cflags for s390x tcg tests')
> +option('tcg_tests_cross_cc_sh4', type: 'string',
> +       description: 'cc for sh4 tcg tests')
> +option('tcg_tests_cross_cflags_sh4', type: 'string',
> +       description: 'cflags for sh4 tcg tests')
> +option('tcg_tests_cross_cc_tricore', type: 'string',
> +       description: 'cc for tricore tcg tests')
> +option('tcg_tests_cross_cflags_tricore', type: 'string',
> +       description: 'cflags for tricore tcg tests')
> +option('tcg_tests_cross_cc_x86_64', type: 'string',
> +       description: 'cc for x86_64 tcg tests')
> +option('tcg_tests_cross_cflags_x86_64', type: 'string',
> +       description: 'cflags for x86_64 tcg tests')
> +option('tcg_tests_cross_cc_xtensa', type: 'string',
> +       description: 'cc for xtensa tcg tests')
> +option('tcg_tests_cross_cflags_xtensa', type: 'string',
> +       description: 'cflags for xtensa tcg tests')
> +option('tcg_tests_cross_cc_xtensaeb', type: 'string',
> +       description: 'cc for xtensaeb tcg tests')
> +option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
> +       description: 'cflags for xtensaeb tcg tests')
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index ba73eecf1c9..8dd6623ad1d 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
>      continue
>    endif
>=20=20
> +  cc_arch =3D target.replace('-linux-user', '').replace('-softmmu', '')
> +
>    # Detect duplicated executables/tests, and report an error to force us=
er to
>    # choose how to deal with it.
>    built_tests =3D {}
> @@ -197,16 +199,34 @@ foreach target, plan: tcg_tests
>    endforeach
>=20=20
>    cc =3D find_program(plan['cc'], required : false)
> +  cc_cflags =3D []
> +
> +  check_flags =3D []
> +  check_required =3D false
> +  cross_cc =3D get_option('tcg_tests_cross_cc_' + cc_arch)
> +  if cross_cc !=3D ''
> +    # we make sure cross cc exists
> +    cc =3D find_program(cross_cc, required: true)
> +    check_required =3D true
> +  endif
> +  cross_cflags =3D get_option('tcg_tests_cross_cflags_' + cc_arch)
> +  if cross_cflags !=3D ''
> +    cc_cflags =3D cross_cflags.split()
> +    # and that cross cc can compile programs
> +    check_flags =3D cc_cflags
> +    check_required =3D true
> +  endif
> +
>    cc_from_system =3D cc.found()
>    has_cc =3D cc.found()
>    if has_cc
> -    check_flags =3D ['-static']
> +    check_flags +=3D ['-static']
>      if target.endswith('softmmu')
> -      check_flags =3D ['-nostdlib', '-r']
> +      check_flags +=3D ['-nostdlib', '-r']
>      endif
>=20=20
>      cmd =3D run_command([cc, files('test_cc.c'), check_flags, '-o', '/de=
v/null'],
> -                      check: false)
> +                      check: check_required)
>      has_cc =3D cmd.returncode() =3D=3D 0
>      cc_from_system =3D has_cc
>    endif
> @@ -333,9 +353,9 @@ foreach target, plan: tcg_tests
>          endif
>        endif
>=20=20
> -      cflags =3D []
> +      cflags =3D cc_cflags
>        if 'cflags' in setup
> -        cflags =3D setup['cflags']
> +        cflags +=3D setup['cflags']
>        endif
>=20=20
>        if 'cc_feat' in setup

I'm seeing failures here on MacOS:

  Program aarch64-linux-gnu-gcc found: NO
  Program aarch64-elf-gcc found: YES (/opt/homebrew/bin/aarch64-elf-gcc)

  ../../tests/tcg/meson.build:233:10: ERROR: Command `/opt/homebrew/bin/aar=
ch64-elf-gcc /Users/alex/lsrc/qemu.git/tests/tcg/test_cc.c -static -nostdli=
b -r -o /dev/null` failed with status 1.

  A full log can be found at /Users/alex/lsrc/qemu.git/builds/testing/meson=
-logs/meson-log.txt

  ERROR: meson setup failed

  =F0=9F=95=9913:21:02 alex@qemu-arm64-mac-00:qemu.git/builds/testing  on =
=EE=82=A0 review/check-tcg-meson-v6 [$?] took 18s [=F0=9F=94=B4 ERROR]=20
  =E2=9C=97  tail /Users/alex/lsrc/qemu.git/builds/testing/meson-logs/meson=
-log.txt
  --- stderr ---
  In file included from /Users/alex/lsrc/qemu.git/tests/tcg/test_cc.c:4:
  /opt/homebrew/Cellar/aarch64-elf-gcc/16.2.0/lib/gcc/aarch64-elf/16.2.0/in=
clude/stdint.h:11:16: fatal error: stdint.h: No such file or directory
     11 | # include_next <stdint.h>
        |                ^~~~~~~~~~
  compilation terminated.



  ../../tests/tcg/meson.build:233:10: ERROR: Command `/opt/homebrew/bin/aar=
ch64-elf-gcc /Users/alex/lsrc/qemu.git/tests/tcg/test_cc.c -static -nostdli=
b -r -o /dev/null` failed with status 1.

I guess by hosted its expecting a glibc despite the -nostdlib:

  #ifndef _GCC_WRAP_STDINT_H
  #if __STDC_HOSTED__
  # if defined __cplusplus && __cplusplus >=3D 201103L
  #  undef __STDC_LIMIT_MACROS
  #  define __STDC_LIMIT_MACROS
  #  undef __STDC_CONSTANT_MACROS
  #  define __STDC_CONSTANT_MACROS
  # endif
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wpedantic" // include_next
  # include_next <stdint.h>
  #pragma GCC diagnostic pop
  #else
  # include "stdint-gcc.h"
  #endif
  #define _GCC_WRAP_STDINT_H
  #endif


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

