Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F0C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBRL-0002Y9-89; Wed, 12 Aug 2026 12:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBQh-0001V3-G3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:03:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBQe-0000en-Be
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:03:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495437bb891so259595e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786550622; x=1787155422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LcDmUwfBIau8Yn0+4/7KEvRo2z4GgcaRgKndmqokrPI=;
 b=x1saXys6j8H1BjJEsysb8B18zLbwaolP77oremWslh9JQH8SI+3T7XNLEN0Gh5CGof
 9piAPX6Z0O72nRelSu537HJehhT3BC/tBXC0fmwTFltWpcVuCNGi59KhhxsfbkDuf2ha
 dC7sWUKuc4lD6Jha3NoDNCcfD5urvAIa2LB4tqgN+i2d69u/J5xlvPXD57F/ZC16DO2p
 FtLgr/0nwzhLFtjETubl8dvjKSyfftw396MayJbNiXIO28WwiCYTAk5a63ZKqaLfY7LL
 r/PiahweI9PYhcXxSyOWbdmVIlq83oajjRKhYYL2Dl0SSIzVNMKmeUGnFUBTtvSQ0RBQ
 Dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550622; x=1787155422;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LcDmUwfBIau8Yn0+4/7KEvRo2z4GgcaRgKndmqokrPI=;
 b=Tc6XKcP7ta95RzxI7rzgQiqkqXiSmdDc3lzFbVfwxIWITOXOciiG8ezR0pNWw45Aq8
 ncTTTD/RnHewvdVssdv9ALbaiNy4cs/ZJq+PXwmElLHi1Tbcvt8sdwnqdMqsjV4M4z/k
 MggEeA0mcfyz2SQHDrsXGF7LzUrv/D0Y4LMx2mK/uyTv809BEWX+GhLe0jyaAJoxk9uQ
 Uy3376iAjXxcStBdNqR3GYJpjXmuLYazpnY7F+Lr+T97KoIRAs8VK0cvgBWDTV7HZ3Bm
 4uajonwLtpT66ZeI13+UYypZXAvqkZ+GlWMCF0NnoFzp17RltmElx1Nvh2NHfagvydEu
 0sPQ==
X-Gm-Message-State: AOJu0YxIPCdAbYLx05ZrIw+Lx36DVwO5ZKXvqQ2to4Wc+n3KW6gGL6BC
 VqV0BW+3TXUmP48kfUQriMwi8yKniMBFWwmS9NQ7TDv4ICUGutJgLQZlwZEkWpVnDmc=
X-Gm-Gg: AR+sD11jQd6Dv2zheJ7oav9R1xfBVfr6Koe9grlGUtmMDnAsgMRSp0qrtipWrSQGFHB
 HTYPReM7QHQM/QSKShBraK+H9SBh9B+TdJTRfPOiRMBPIF01Tnyo/Se4qyDjPYc9D4C3XxNfhWI
 bAL46/b/4Fp6Qs9xR/28jenySMQcqKfVZQoJPP1QX05KG3u5iW53RcvWlk7ebRgF/nz7VQzX4W8
 vlKuQtMWQbGW4mLtoLxBORL0Vmfa/KSioGo6UghgxM5XSJ8tAR1AdzdYxRpTphpKOUyLodCQ+Ec
 RAZYNCzHJ2rY8kR2yB+82w49l7pHuoFO/SkgyGxjItRGLrSzflSAkOSTjFtcdoLGAL41X9iTd5r
 5YW8CKoiMzfwYAD5WMcxrDrt6O0h0ZXqdN3VuF4PvN4sloqtvHiBwNrOUzSMdhS/SDjOJIUXCeg
 RmKhzAGcsq4MSWzauWkBJO/QJD1budKnq03pb/X8cELi1PUYswcq/4W2V8PgWg
X-Received: by 2002:a05:600c:3103:b0:495:7aaf:77b with SMTP id
 5b1f17b1804b1-49981947114mr4912125e9.0.1786550621932; 
 Wed, 12 Aug 2026 09:03:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5f2fdsm8818852f8f.32.2026.08.12.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 09:03:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6F9F5F886;
 Wed, 12 Aug 2026 17:03:39 +0100 (BST)
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
In-Reply-To: <87v79fzfqb.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 12 Aug 2026 13:27:08 +0100")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-101-pierrick.bouvier@oss.qualcomm.com>
 <87v79fzfqb.fsf@draig.linaro.org>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 17:03:39 +0100
Message-ID: <8733wjz5pg.fsf@draig.linaro.org>
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>
>> When a user set explicit cross cc, we ensure it's available and working.
>> When a user set explicit cross cflags, we ensure they work with default
>> or overriden cross_cc.
>>
>> Made the first implementation with a single meson option (array), which
>> proved to be absolutely unreadable.
>> By having one option per target, we directly detect issue at configure
>> time, either for user, or when iterating on all our targets. This
>> ensures user can't mispell any target name, and that we can't forget any
>> new one in the future.
>> Also, it shows them in the configuration summary, which is a bonus.
>>
>> Since we now only need to know compiler to write tcg tests, we can
>> simply alias -cross-prefix-* options to compiler override.
>>
>> Examples
>> --------
>>
>> wrong architecture:
>> $ ./configure --cross-cc-bad=3D'cc'
>> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
>>
>> wrong option:
>> $ ./configure --cross-cc-cflags-aarch64=3D'-bad-option'
>> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-=
gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -=
nostdlib -r -o /dev/null` failed with status 1.
>> A full log can be found at /qemu/build/meson-logs/meson-log.txt
>>
>> cross compile with clang (fails at the moment, since some tests have
>> compilation errors with it):
>> $ ./configure --target-list=3Daarch64-linux-user --cross-cc-aarch64=3D'c=
lang' --cross-cc-cflags-aarch64=3D'-target aarch64-linux-gnu'
>>   User defined options
>>   ...
>>     tcg_tests_cross_cc_aarch64      : clang
>>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  configure             | 27 ++++++-------
>>  meson_options.txt     | 89 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/tcg/meson.build | 30 ++++++++++++---
>>  3 files changed, 126 insertions(+), 20 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 568de41dadd..c9e2cdcce5f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -227,19 +227,6 @@ for opt do
>>    ;;
>>    --extra-ldflags=3D*) EXTRA_LDFLAGS=3D"$EXTRA_LDFLAGS $optarg"
>>    ;;
>> -  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FO=
O option"
>> -  ;;
>> -  --cross-cc-cflags-*) cc_arch=3D${opt#--cross-cc-cflags-}; cc_arch=3D$=
{cc_arch%%=3D*}
>> -                      eval "cross_cc_cflags_${cc_arch}=3D\$optarg"
>> -  ;;
>> -  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
>> -                eval "cross_cc_${cc_arch}=3D\$optarg"
>> -  ;;
>> -  --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-p=
refix-FOO option"
>> -  ;;
>> -  --cross-prefix-*) cc_arch=3D${opt#--cross-prefix-}; cc_arch=3D${cc_ar=
ch%%=3D*}
>> -                    eval "cross_prefix_${cc_arch}=3D\$optarg"
>> -  ;;
>>    --without-default-features) default_feature=3D"no"
>>    ;;
>>    --wasm64-32bit-address-limit) wasm64_memory64=3D"2"
>> @@ -632,9 +619,19 @@ for opt do
>>    ;;
>>    --extra-ldflags=3D*)
>>    ;;
>> -  --cross-cc-*)
>> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FO=
O option"
>>    ;;
>> -  --cross-prefix-*)
>> +  --cross-cc-cflags-*) arch=3D${opt#--cross-cc-cflags-}; arch=3D${arch%=
%=3D*}
>> +                       meson_option_add "-Dtcg_tests_cross_cflags_${arc=
h}=3D${optarg}"
>> +  ;;
>> +  --cross-cc-*) arch=3D${opt#--cross-cc-}; arch=3D${arch%%=3D*}
>> +                meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D${opta=
rg}"
>> +  ;;
>> +  --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-p=
refix-FOO option"
>> +  ;;
>> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
>> +  --cross-prefix-*) arch=3D${opt#--cross-prefix-}; arch=3D${arch%%=3D*}
>> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D${=
optarg}gcc"
>>    ;;
>>    --enable-docs) docs=3Denabled
>>    ;;
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 5e91969414a..fd9ff0df893 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -389,3 +389,92 @@ option('containers', type: 'boolean', value: true,
>>         description: 'use containers to cross compile tcg tests')
>>  option('container_command', type: 'string',
>>         description: 'command to build/run containers')
>> +
>> +option('tcg_tests_cross_cc_aarch64', type: 'string',
>> +       description: 'cc for aarch64 tcg tests')
>> +option('tcg_tests_cross_cflags_aarch64', type: 'string',
>> +       description: 'cflags for aarch64 tcg tests')
>> +option('tcg_tests_cross_cc_aarch64_be', type: 'string',
>> +       description: 'cc for aarch64_be tcg tests')
>> +option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
>> +       description: 'cflags for aarch64_be tcg tests')
>> +option('tcg_tests_cross_cc_alpha', type: 'string',
>> +       description: 'cc for alpha tcg tests')
>> +option('tcg_tests_cross_cflags_alpha', type: 'string',
>> +       description: 'cflags for alpha tcg tests')
>> +option('tcg_tests_cross_cc_arm', type: 'string',
>> +       description: 'cc for arm tcg tests')
>> +option('tcg_tests_cross_cflags_arm', type: 'string',
>> +       description: 'cflags for arm tcg tests')
>> +option('tcg_tests_cross_cc_hexagon', type: 'string',
>> +       description: 'cc for hexagon tcg tests')
>> +option('tcg_tests_cross_cflags_hexagon', type: 'string',
>> +       description: 'cflags for hexagon tcg tests')
>> +option('tcg_tests_cross_cc_hppa', type: 'string',
>> +       description: 'cc for hppa tcg tests')
>> +option('tcg_tests_cross_cflags_hppa', type: 'string',
>> +       description: 'cflags for hppa tcg tests')
>> +option('tcg_tests_cross_cc_i386', type: 'string',
>> +       description: 'cc for i386 tcg tests')
>> +option('tcg_tests_cross_cflags_i386', type: 'string',
>> +       description: 'cflags for i386 tcg tests')
>> +option('tcg_tests_cross_cc_loongarch64', type: 'string',
>> +       description: 'cc for loongarch64 tcg tests')
>> +option('tcg_tests_cross_cflags_loongarch64', type: 'string',
>> +       description: 'cflags for loongarch64 tcg tests')
>> +option('tcg_tests_cross_cc_m68k', type: 'string',
>> +       description: 'cc for m68k tcg tests')
>> +option('tcg_tests_cross_cflags_m68k', type: 'string',
>> +       description: 'cflags for m68k tcg tests')
>> +option('tcg_tests_cross_cc_mips', type: 'string',
>> +       description: 'cc for mips tcg tests')
>> +option('tcg_tests_cross_cflags_mips', type: 'string',
>> +       description: 'cflags for mips tcg tests')
>> +option('tcg_tests_cross_cc_mips64', type: 'string',
>> +       description: 'cc for mips64 tcg tests')
>> +option('tcg_tests_cross_cflags_mips64', type: 'string',
>> +       description: 'cflags for mips64 tcg tests')
>> +option('tcg_tests_cross_cc_mips64el', type: 'string',
>> +       description: 'cc for mips64el tcg tests')
>> +option('tcg_tests_cross_cflags_mips64el', type: 'string',
>> +       description: 'cflags for mips64el tcg tests')
>> +option('tcg_tests_cross_cc_or1k', type: 'string',
>> +       description: 'cc for or1k tcg tests')
>> +option('tcg_tests_cross_cflags_or1k', type: 'string',
>> +       description: 'cflags for or1k tcg tests')
>> +option('tcg_tests_cross_cc_ppc64', type: 'string',
>> +       description: 'cc for ppc64 tcg tests')
>> +option('tcg_tests_cross_cflags_ppc64', type: 'string',
>> +       description: 'cflags for ppc64 tcg tests')
>> +option('tcg_tests_cross_cc_ppc64le', type: 'string',
>> +       description: 'cc for ppc64le tcg tests')
>> +option('tcg_tests_cross_cflags_ppc64le', type: 'string',
>> +       description: 'cflags for ppc64le tcg tests')
>> +option('tcg_tests_cross_cc_riscv64', type: 'string',
>> +       description: 'cc for riscv64 tcg tests')
>> +option('tcg_tests_cross_cflags_riscv64', type: 'string',
>> +       description: 'cflags for riscv64 tcg tests')
>> +option('tcg_tests_cross_cc_s390x', type: 'string',
>> +       description: 'cc for s390x tcg tests')
>> +option('tcg_tests_cross_cflags_s390x', type: 'string',
>> +       description: 'cflags for s390x tcg tests')
>> +option('tcg_tests_cross_cc_sh4', type: 'string',
>> +       description: 'cc for sh4 tcg tests')
>> +option('tcg_tests_cross_cflags_sh4', type: 'string',
>> +       description: 'cflags for sh4 tcg tests')
>> +option('tcg_tests_cross_cc_tricore', type: 'string',
>> +       description: 'cc for tricore tcg tests')
>> +option('tcg_tests_cross_cflags_tricore', type: 'string',
>> +       description: 'cflags for tricore tcg tests')
>> +option('tcg_tests_cross_cc_x86_64', type: 'string',
>> +       description: 'cc for x86_64 tcg tests')
>> +option('tcg_tests_cross_cflags_x86_64', type: 'string',
>> +       description: 'cflags for x86_64 tcg tests')
>> +option('tcg_tests_cross_cc_xtensa', type: 'string',
>> +       description: 'cc for xtensa tcg tests')
>> +option('tcg_tests_cross_cflags_xtensa', type: 'string',
>> +       description: 'cflags for xtensa tcg tests')
>> +option('tcg_tests_cross_cc_xtensaeb', type: 'string',
>> +       description: 'cc for xtensaeb tcg tests')
>> +option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
>> +       description: 'cflags for xtensaeb tcg tests')
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index ba73eecf1c9..8dd6623ad1d 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
>>      continue
>>    endif
>>=20=20
>> +  cc_arch =3D target.replace('-linux-user', '').replace('-softmmu', '')
>> +
>>    # Detect duplicated executables/tests, and report an error to force u=
ser to
>>    # choose how to deal with it.
>>    built_tests =3D {}
>> @@ -197,16 +199,34 @@ foreach target, plan: tcg_tests
>>    endforeach
>>=20=20
>>    cc =3D find_program(plan['cc'], required : false)
>> +  cc_cflags =3D []
>> +
>> +  check_flags =3D []
>> +  check_required =3D false
>> +  cross_cc =3D get_option('tcg_tests_cross_cc_' + cc_arch)
>> +  if cross_cc !=3D ''
>> +    # we make sure cross cc exists
>> +    cc =3D find_program(cross_cc, required: true)
>> +    check_required =3D true
>> +  endif
>> +  cross_cflags =3D get_option('tcg_tests_cross_cflags_' + cc_arch)
>> +  if cross_cflags !=3D ''
>> +    cc_cflags =3D cross_cflags.split()
>> +    # and that cross cc can compile programs
>> +    check_flags =3D cc_cflags
>> +    check_required =3D true
>> +  endif
>> +
>>    cc_from_system =3D cc.found()
>>    has_cc =3D cc.found()
>>    if has_cc
>> -    check_flags =3D ['-static']
>> +    check_flags +=3D ['-static']
>>      if target.endswith('softmmu')
>> -      check_flags =3D ['-nostdlib', '-r']
>> +      check_flags +=3D ['-nostdlib', '-r']
>>      endif

What it needs is -ffreestanding - it gets away with it on linux as the
compilers are mostly userspace compilers and it can fallback to those
headers. On macOS or if you install a pure bare metal compiler it would
fail.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

