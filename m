Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD9FC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZMe-0003aG-3G; Mon, 07 Sep 2026 09:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3ZMd-0003a8-5K
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:26:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3ZMa-00083O-Ga
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:26:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so34209275e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788787578; x=1789392378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qlEMIPKj6pLrGitAzEdKk6clfrYN8Rs3KryQqPJZwOw=;
 b=vgLv5Jzq7gfmFQcBsPiRvP6iswj5ufSg6OUxeE6yMlxCDWZ5B3Bkfwjxhuuv5/TUqf
 DHk8+fdhuoWTywPJc4cS7ZMPFeW7a4RBo+ueeUAZljHJgC3i9fjEUp3NPNNk7KZKmCkF
 l98oM0vdZoQUkZjwHC9GD+Yllk0E2X+7NFP1xgjwRAZFkHO4yozgy1HyURNFOMkFvL2Y
 ooZEp+xVWtOS1KwD9VCR/yWcs2gWQctzZmJp9N1id2XyAX8/aQM0+MW43N8mnBhBVfJ/
 wgM+qHtuqyGykYmmwzrOG3kLNhFG+uYs+MJ2Hlm2UDbYB30v/nVURE6n8nhn2Cnzejsc
 HknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787578; x=1789392378;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qlEMIPKj6pLrGitAzEdKk6clfrYN8Rs3KryQqPJZwOw=;
 b=VX93XJQgOHv/sBnURFkG+HHgOlDJzb6rd8CYLKpzRgnFKDTvJxJFOSl5vC7GQHGonj
 ySqRbR8PCfrjfiBxWTny0DF0PkTGvnNYvTPHgmD1GiRxcGnM05i4I/sKDz0/VfI03HZH
 op8cs3OTnnYcUMxNc4n/P6rpvG5Ojpcmy9z8g2NDBwydLPGIkeGdPiLfaQ4kMH7Zn51H
 E1h4AS7ZKUXJSR6bFxk+oVrd55xRsqRVv/H+y2XWMGJfe5czIwckm7CHHXVMdoFh3cg/
 WURw2echlGAEY70tK4le29TvCso81hVLhLmSxqRKGmKBNFleeNaprRRiFasOSH9Atzu7
 gCHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvPhOmsZFMRk9iT0VyIxEoWCTggBk4ZnKKEPUtDF6D3IP//7kW26EDbSClmLPPBJfxLY8UAoFLwfAJ@nongnu.org
X-Gm-Message-State: AFuF++n6ev2K6fGnPChADr+Cj9Z1rIz10Yb67TBM+ThtZ+klM8oVQ3xg
 zCVOD83rERBMbr//XisjcSacnFC+sj6sG3gCZ04OWGGY1ydZhZiZKuDwK6AVEQuaqa0=
X-Gm-Gg: AYBFou0jLdVmxycwF9qV2c3pTWNBDtPZ1w5PI4pP61PJ1Gx8o0WUHsFaZBR8Riv6/W9
 DoIQilYXBPxt/MISf0SkGRttvmmOZjpTDi015+D8aaDQuOsKG4ElUuVdaWowGBX2ac7ROwRek8f
 HPjq2i3DCaVjnQd97fW4PTt2oPmOJF8b3FmXUefenakQcKv54UtAQ3xzy0+/gCDQxNKjkZdKO9j
 mchAS/GiuXJnbA5NvkJ+U+U5x4GlxK2TQrpIlrrsglCVPMrX5FJ6buiK3d6D7f+37IEsaz47i9N
 Dlfqa0VmZ8qBfyV3galrZdf6E8nJTwiBtQXcrDeDHMiQzMoL/BKL/1hraCQlnf+33/h6yEQHAio
 BeJqDmv1G8/S/NOwTuAbguLYWagPp3asF3fj04R3QREF53tLcdK0ilHE9P1m9vvyOyRLy3DYovI
 7gmbYpi6jDbWz2TYqHqdldrDohGhfoNy3zOgDJ09akSb9WoK6T3/xEti7qjTrN
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id
 5b1f17b1804b1-49d0726cd2emr269820265e9.5.1788787578150; 
 Mon, 07 Sep 2026 06:26:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm200141185e9.4.2026.09.07.06.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:26:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C10AA5F870;
 Mon, 07 Sep 2026 14:26:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Aniket Sahu
 <asahu1x@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PULL 101/105] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
In-Reply-To: <ap60TwXjoICGsvKz@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 7 Sep 2026 13:55:43 +0100")
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-102-alex.bennee@linaro.org>
 <ap60TwXjoICGsvKz@redhat.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Mon, 07 Sep 2026 14:26:15 +0100
Message-ID: <87a4ptb3bc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This commit changes meson_options.txt, but did not refresh the
> scripts/meson-buildoptions.sh file, so it is sometimes showing
> up dirty when doing a build.
>
> Paolo, I feel like there must be some bug in the logic for triggering
> a rebuild of scripts/meson-buildoptions.sh as contributors frequently
> miss this change. With the current git HEAD, sometimes when I do a
> build it'll refresh the file leaving it dirty, but if I discard all
> local changes and do another build, then it doesn't refresh the file.

If it is refreshing automatically then should it be in git?

>
>
> On Fri, Sep 04, 2026 at 01:45:55PM +0100, Alex Benn=C3=A9e wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>=20
>> When a user set explicit cross cc, we ensure it's available and working.
>> When a user set explicit cross cflags, we ensure they work with default
>> or overriden cross_cc.
>>=20
>> Made the first implementation with a single meson option (array), which
>> proved to be absolutely unreadable.
>> By having one option per target, we directly detect issue at configure
>> time, either for user, or when iterating on all our targets. This
>> ensures user can't mispell any target name, and that we can't forget any
>> new one in the future.
>> Also, it shows them in the configuration summary, which is a bonus.
>>=20
>> Since we now only need to know compiler to write tcg tests, we can
>> simply alias -cross-prefix-* options to compiler override.
>>=20
>> Examples
>> --------
>>=20
>> wrong architecture:
>> $ ./configure --cross-cc-bad=3D'cc'
>> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
>>=20
>> wrong option:
>> $ ./configure --cross-cc-cflags-aarch64=3D'-bad-option'
>> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-=
gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -=
nostdlib -r -o /dev/null` failed with status 1.
>> A full log can be found at /qemu/build/meson-logs/meson-log.txt
>>=20
>> cross compile with clang (fails at the moment, since some tests have
>> compilation errors with it):
>> $ ./configure --target-list=3Daarch64-linux-user --cross-cc-aarch64=3D'c=
lang' --cross-cc-cflags-aarch64=3D'-target aarch64-linux-gnu'
>>   User defined options
>>   ...
>>     tcg_tests_cross_cc_aarch64      : clang
>>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
>>=20
>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Message-ID: <20260827221506.91574-102-pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> diff --git a/configure b/configure
>> index aa98cf39584..1973f023b1e 100755
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
>> @@ -631,9 +618,19 @@ for opt do
>>    ;;
>>    --extra-ldflags=3D*)
>>    ;;
>> -  --cross-cc-*)
>> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FO=
O option"
>> +  ;;
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
>>    ;;
>> -  --cross-prefix-*)
>> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
>> +  --cross-prefix-*) arch=3D${opt#--cross-prefix-}; arch=3D${arch%%=3D*}
>> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=3D${=
optarg}gcc"
>>    ;;
>>    --enable-docs) docs=3Denabled
>>    ;;
>> diff --git a/meson_options.txt b/meson_options.txt
>> index f9604a6c192..292625af08a 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -391,3 +391,92 @@ option('containers', type: 'boolean', value: true,
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
>> index 2458a231f5f..9cf632d2717 100644
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
>> @@ -197,16 +199,35 @@ foreach target, plan: tcg_tests
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
>>      if target.endswith('softmmu')
>> -      check_flags =3D ['-nostdlib', '-ffreestanding', '-r']
>> +      check_flags +=3D ['-nostdlib', '-ffreestanding', '-r']
>> +    else
>> +      check_flags +=3D ['-static']
>>      endif
>>=20=20
>>      cmd =3D run_command([cc, files('test_cc.c'), check_flags, '-o', '/d=
ev/null'],
>> -                      check: false)
>> +                      check: check_required)
>>      has_cc =3D cmd.returncode() =3D=3D 0
>>      cc_from_system =3D has_cc
>>    endif
>> @@ -333,9 +354,9 @@ foreach target, plan: tcg_tests
>>          endif
>>        endif
>>=20=20
>> -      cflags =3D []
>> +      cflags =3D cc_cflags
>>        if 'cflags' in setup
>> -        cflags =3D setup['cflags']
>> +        cflags +=3D setup['cflags']
>>        endif
>>=20=20
>>        if 'cc_feat' in setup
>> --=20
>> 2.47.3
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

