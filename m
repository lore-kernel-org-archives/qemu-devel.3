Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D6ECD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw3O-00079B-LU; Tue, 26 May 2026 13:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRw3M-00077z-SH
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:58:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRw3K-0008Sa-EI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:58:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso6412697f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779818332; x=1780423132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfhvteW6OePuP0G4po6kROOJkaLhl+e/wyXJSRtAICQ=;
 b=yG5r5RrXPXz43k9DCeqxSOQ3DiHftylZoYUOMOEq5T+5XdRRscC1ys5WXhUnaj9C0C
 sT2IVvk3osiCpOIxNQlJ0sb3t0C3EL74zBSO8dp3e1a/A+iGAUIGok62DwUJkGMVBP2e
 v2UPdMdTtSCucQ8yJ+Lzvgr96bBZmZDhHqlxxoXgr8U9Wc4YCRaf8K76HqHhHwv9sI/J
 mB4XH4ecCQHsKuDIHeqdGZmPjabDsBA4fJ4K0SdqCHFksxTPN6Uq+4AysWkxpx4Cajpu
 DxSYZvtVfbxenIE557ODsUnxh+KPrcQBaO5m2aQKnpJZHZzIYzN4eyqdcb+RrSVMSLHI
 zUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818332; x=1780423132;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfhvteW6OePuP0G4po6kROOJkaLhl+e/wyXJSRtAICQ=;
 b=SHcQegS82gy14JHtWU450jGPDGWhIy80G0XfVzBMRkA+VZ0CtTNnhpjBg/Rkv9/b+8
 6gXWkWTeyQUZBMYwz1uf2sUCAx8QYAcM+I6xU1SrYmYBsMKUYS1XbuSVaqbqJqMpNs+g
 dzCFahJprRQLAICTOVWLpcUIRXklrJApGSxMRBL2IihCGjzUVOR5Fq/QT8a+0feb8P6M
 mV8WDP9ta6fx5+B4pbmHfTf4p5o5mFRgZ+DkNlzqU5K//5GHw5FzumoFMAglLaUkVrKF
 qCEEfoMcAJSCfq4C0x3WmrjCE2dmRKlKBZ7l8RGv5YEDYQnArueg9wNQI7FYNp4JyvGe
 nZoA==
X-Gm-Message-State: AOJu0YyMINtalqCRKqAOdxUHliB5kuMniGh/ifNk/fDF7hXvrjWJ3IVR
 w8DX354ZT+UQbQ25xfm6yDSrDiFl2aSvEhH1Eo9K9fcLLqe6Xc7PZ29WcLXzq4HxjnQ=
X-Gm-Gg: Acq92OF7iHYIZszRBcyjgWtRUtibMSOHPO97AnT39EhOw98oRc1bUCtaxCsGUJeWwLs
 9hqwDKuE+pBbltRml7raQCx4xYAarPFYLEYXKtjFfbbMoTkfKbaZydJQ9u5p7Ype+erZrurCWX2
 JripLNTaZeOF3aXNPwkbxGb+xYs2NQ5L6ZRNRg0CNvy9nmu+1jDlkJCMeN2hYkPonrzwbprN0SI
 /a/uhwPW2zCJMrlZFzPfUa4q8VzhOFZ3jw8yaAmDhqp+fHtQ2G8sNtDcRsymat8W+tMLa0/rUHA
 IpfBwyF6vz9QwMvMobzRVtsVfsVeHLEzLjs5oeGgHIk85qSf/AxtEU2A6VwfD/lG3bYUhxLCd7A
 zrCReD9a9ejXBk+oIHpDP0/32AL0gk1JxTOLmZD7M77Ta+V5hdsaXQ+f9CL0YnmF32yBiUGGE+i
 LGOH/galEBpjehunXAoOs3DF8=
X-Received: by 2002:a05:6000:400c:b0:45d:d092:aca4 with SMTP id
 ffacd0b85a97d-45eb38a81b5mr30783438f8f.4.1779818332228; 
 Tue, 26 May 2026 10:58:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5caeesm38741704f8f.29.2026.05.26.10.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:58:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72BB05F87C;
 Tue, 26 May 2026 18:58:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,
 Song Gao <gaosong@loongson.cn>,  John Snow <jsnow@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Brad Smith
 <brad@comstyle.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency
 to run-tcg-tests-% rules
In-Reply-To: <06092208-1b56-4fea-8d92-bf035fbd0fa3@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Tue, 26 May 2026 10:15:00 -0700")
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
 <87tsrzl138.fsf@draig.linaro.org>
 <093614fb-ced1-4b15-b1e1-5da755f87237@oss.qualcomm.com>
 <87cxymec7b.fsf@draig.linaro.org>
 <5bd51a1a-4079-4073-bbd8-f0206a1ad458@oss.qualcomm.com>
 <0f73d717-1621-4c3f-9c5e-9bfdfaffb0b8@oss.qualcomm.com>
 <877bor9vor.fsf@draig.linaro.org>
 <7d58926d-a36d-430f-828e-7ebdd9cc4eb5@oss.qualcomm.com>
 <87qzmyzbut.fsf@draig.linaro.org>
 <06092208-1b56-4fea-8d92-bf035fbd0fa3@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 18:58:50 +0100
Message-ID: <87fr3eyrvp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

> On 5/26/2026 3:47 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 5/25/2026 11:43 AM, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> On 5/25/2026 8:46 AM, Pierrick Bouvier wrote:
>>>>>> On 5/23/2026 1:56 AM, Alex Benn=C3=A9e wrote:
>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>
>>>>>>>> On 5/22/2026 12:02 PM, Alex Benn=C3=A9e wrote:
>>>>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>>>>
>>>>>>>>>> On 5/21/2026 6:17 AM, Alex Benn=C3=A9e wrote:
>>>>>>>>>>> Explicitly set the appropriate QEMU binary as a dependency so w=
e can
>>>>>>>>>>> ensure they get built. This is especially important for MacOS w=
hich
>>>>>>>>>>> otherwise only builds the unsigned binaries on a normal "make a=
ll"
>>>>>>>>>>> run.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I'm not sure to see why it matters. tcg-tests don't make use of =
hvf, so
>>>>>>>>>> unsigned binaries are plenty for it.
>>>>>>>>>>
>>>>>>>>>> Which other binary is this building that is not built by default?
>>>>>>>>>>
>>>>>>>>>> In general, if something is not included in "all" target, let's =
make
>>>>>>>>>> sure it's included there (meson.build?) instead of adding a work=
around
>>>>>>>>>> here. Not only tests benefit this, but anyone doing a build on a
>>>>>>>>>> platform that might have optional binaries not built by default.
>>>>>>>>>
>>>>>>>>> If you have a suggestion on how to make that work I'm all ears.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I would be happy to help, but I don't understand what the goal is.=
 I
>>>>>>>> have three questions that should help to provide a suggestion.
>>>>>>>>
>>>>>>>> Which exact test command do you run?
>>>>>>>
>>>>>>> make check-tcg
>>>>>>>
>>>>>>>>
>>>>>>>> ```
>>>>>>>> Explicitly set the appropriate QEMU binary as a dependency so we c=
an
>>>>>>>> ensure they get built.
>>>>>>>> ```
>>>>>>>> Aren't they built by all?
>>>>>>>
>>>>>>> Apparently not.
>>>>>>>
>>>>>>>> It seems to be a dependency, at least for check-tcg:
>>>>>>>> .ninja-goals.check-tcg =3D all test-plugins
>>>>>>>>
>>>>>>>> ```
>>>>>>>> This is especially important for MacOS which otherwise only builds=
 the
>>>>>>>> unsigned binaries on a normal "make all" run.
>>>>>>>> ```
>>>>>>>> Why do you need signed binaries for testing on MacOS (hvf?)?
>>>>>>>
>>>>>>> In a previous iteration I made configure spit out the unsigned bina=
ries
>>>>>>> to config-target.mak but the request was to fix the dependencies
>>>>>>> instead.
>>>>>>>
>>>>>>> It all works on Linux so I'm not sure why MacOS is being so weird
>>>>>>> because the meson emulators target mechanism should be the same.
>>>>>>>
>>>>>>
>>>>>> Just tried now, and it does not work on Linux neither (make check-tcg
>>>>>> does not build any target beyond tests). Maybe you forgot to clean y=
our
>>>>>> folder?
>>>>>>
>>>>>
>>>>> The root issue is that tests/Makefile.include is included *after*
>>>>> evaluation of ninja-targets in main Makefile. Thus,
>>>>> .ninja-goals.check-tcg is ignored.
>>>>
>>>> So this replaces patch 1/16 - I think we have a circular dependency he=
re.
>>>>
>>>
>>> Indeed, I didn't notice the duplication. While it solves things under
>>> Linux, it doesn't trigger any build on MacOS, which is what you observed
>>> also. I wonder if it's a gmake vs whatever-make difference.
>>>
>>> Another solution that seems ok on both platforms is to use (harmful)
>>> recursive make:
>>>
>>>  .PHONY: check-tcg
>>> -.ninja-goals.check-tcg =3D all test-plugins
>>> -check-tcg: $(RUN_TCG_TARGET_RULES)
>>> +check-tcg:
>>> + $(MAKE) all test-plugins
>>> + $(MAKE) $(RUN_TCG_TARGET_RULES)
>>>
>>>  .PHONY: clean-tcg
>>>  clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>>>
>>> Or maybe just leave it as it is? Doc already mentions build should be
>>> done before running any test to avoid missing binaries.
>>> Hopefully we'll completely move tcg tests to meson one day, so there is
>>> no need to deal with make idiosyncrasy anymore.
>>=20
>> The blocker for that to happen would be meson knowing about anything
>> else than the host compiler and singular cross compiler.
>>
>
> Meson indeed supports a single compiler + cross compiler at a time.
> However, you can directly generate cross binaries using a custom_target
> or a generator object. This way, meson would generate programs without
> having to know it's a C compiler. Since all files are single source,

That is an incorrect assumption - the softmmu binaries especially have a
multiple objects which are linked together.

> it's not a problem, since we don't need to declare them.
> Generators have the advantage of being less verbose (you declare only
> once how to use them) than custom target when used several times.
>
> https://mesonbuild.com/Reference-manual_functions_generator.html
> https://mesonbuild.com/Generating-sources.html#using-generator
>
> See a full working example below:
> ```
> $ cat meson.build
> project('cross_compile_tests', 'c')
>
> cc_aarch64 =3D generator(
>                find_program('aarch64-linux-gnu-gcc'),
>                arguments: ['@INPUT@', '-o', '@OUTPUT@', '@EXTRA_ARGS@'],
>                output: '@BASENAME@')
>
> tests =3D [
>   cc_aarch64.process('test.c'),
>   cc_aarch64.process('test2.c', extra_args: '-lpthread')
> ]
> # we need a target that actually uses tests
> executable('test_aarch64', 'empty_main.c', tests)
>
> $ mkdir -p build && cd build
> $ meson && ninja -v
> [1/4] /usr/bin/aarch64-linux-gnu-gcc ../test.c -o test_aarch64.p/test
> [2/4] /usr/bin/aarch64-linux-gnu-gcc ../test2.c -o test_aarch64.p/test2
> -lpthread
> [3/4] ccache cc -Itest_aarch64.p -I. -I.. -fdiagnostics-color=3Dalways
> -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -O0 -g -MD -MQ
> test_aarch64.p/empty_main.c.o -MF test_aarch64.p/empty_main.c.o.d -o
> test_aarch64.p/empty_main.c.o -c ../empty_main.c
> [4/4] cc  -o test_aarch64 test_aarch64.p/empty_main.c.o -Wl,--as-needed
> -Wl,--no-undefined
> $ file test_aarch64.p/test*
> test_aarch64.p/test:  ELF 64-bit LSB pie executable, ARM aarch64,
> version 1 (SYSV), dynamically linked, interpreter
> /lib/ld-linux-aarch64.so.1,
> BuildID[sha1]=3D8162b8f045880c75118958ad46be78ed75bb708d, for GNU/Linux
> 3.7.0, not stripped
> test_aarch64.p/test2: ELF 64-bit LSB pie executable, ARM aarch64,
> version 1 (SYSV), dynamically linked, interpreter
> /lib/ld-linux-aarch64.so.1,
> BuildID[sha1]=3Deed48625e02cd436a2708f94e5dd9ce6d5c162a9, for GNU/Linux
> 3.7.0, not stripped
> ```
>
> We'll need to remove the mechanic to build cross compilers containers.
> In my experience, it's clunky anyway and fails when building several
> from scratch. Try it yourself after cleaning your docker/podman images.
> It's just better and simpler to expect user to install cross
> compilers.

That would loose a bunch of functionality and doesn't help users running
anything that isn't Debian.

> The only thing that prevented me to implement this before is that I
> didn't know if concerned maintainers would accept it, or just hold onto
> the precious handcrafted Makefiles, into which so much energy and time
> has been spent.

There is no desire to hold onto Makefiles, but I do want to keep the
same capabilities as the current system. The driver for containerising
the compilers was that setting up cross compilers is a barrier to
contributors who want to be able to add and build tests.

> If it's not the case, then we should definitely move into the direction
> of migrating all this to meson, and rely on meson tests infrastructure.
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

