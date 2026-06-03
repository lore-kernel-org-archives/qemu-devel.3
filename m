Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA7ACD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqsf-000502-5B; Wed, 03 Jun 2026 15:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUqsc-0004zK-IG
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:03:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUqsZ-00019n-Vp
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:03:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so3453410f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 12:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780513429; x=1781118229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3tTP/3rn1VEmYyj2nYZ/Q9SjzetXAgzeur6yd+pltA=;
 b=h07q3/OOaCPmk1vw+KpHyMnNQCHCITYPr0Fc/fKPksBfMZuM89NhrVpfyB6xYXeT2G
 vJvwnBd/6S1tdXRA/mDX8j/xlPgKxrva+ICWaIZUTddieLY1nZWHYnnGfjHyQgTESTjT
 3UwoANYFFa19Ol35kjDYb8NwRMDtsefwRAueXC6Zktqqp5uyHkmUMhym/2pjWbk1tSmn
 ezOSjw7D78HU5VfHLnLda4m7/seqr2mvVr31z78MyivZDmIEWimX/3PshT6zV27FQxx3
 fqtNwelHj2q9OV/F1IOvqBMByR0j2QfDmiP+F82O1p9P4IjvNEKpX/935JKf2WaIqENI
 ejUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780513429; x=1781118229;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3tTP/3rn1VEmYyj2nYZ/Q9SjzetXAgzeur6yd+pltA=;
 b=bNE3knteL37fT3RyTabAP/4r4cwMvdReGD/zl76PWieCeXfYaiUsa3tSulNKGY5Edi
 unv0VIzJ3JkV1G2UBzuS4GJhH8SjjlMKBtFiox5HM/iACpS/pN/mNk09VjXxyc7PeB1T
 1OFjYCQmISQknvNXRsuP4+xCtGf8u/g+g+mf6edbB2zip5kiFQT7xMZekQRuvfvOLNV7
 jxfcBfs5ATOaDR6TI7AsI/lcYr3hQj4I5993Dy/OHJpa/lfG6TfHmnirMp09LA71Sztg
 +NZ490wwGhnsbD2gcl90VLg2SuzUeTp4iCElHPvwVAwLMsbSIx0zvgQ+YQrCxFyeLm8c
 TcOg==
X-Gm-Message-State: AOJu0YwnnkRxMhVCnajFMLoYSPZkdl0tQe8qoNh96stKMRcetI0whf2H
 8vHyNldxp0HqNKWOzNDW3pxFypjC8InSQMGpTiKkbmKWiZSuEcSlpS7lYBcBdXgmsJ4=
X-Gm-Gg: Acq92OF77NOq++cdylk2cI3kT/5QGLhZvf2HOm12wKy86YRZXptlTPgZarE8mPVmU9G
 Js2GkcCBNaezekjVb7QJKsUm/Y+QgK4e0CqdjmhOfOWAXIiB9a7tCaaZXc8UGna+7tpmLMdZYn7
 OphB2fr61/mvKSwRdak9DJLgvz+zNTtRUr25PEkDfG700IxPU3EBmlj6ut1rziMNnK6I0ZhLHSr
 BBeTy7KR43kjmXnYULjjhpaKD+dIdXTtoXA1OUekwE3/x9s+vWwUZAkJYnx6vm1VPl4qCpPQwQY
 cngu2NolvQH7QkzaepHTW8EAnTUGXcZMidHDNqVLtSq95CJ+yKTaxIW4n2lpZ2hsuFd1iJ2QF/H
 8eZrGrA9SAl7ml6owqhml3+VR+kJ7rvdHgng8KpnUid9dd8ntlQVEhdcMgVE2je52Qb1CGNseY2
 A3b2AVZMJSp+eKWEr7xgVwfaVc5R1ngLmmsw==
X-Received: by 2002:a5d:550d:0:b0:45e:f631:2c73 with SMTP id
 ffacd0b85a97d-4602179271cmr5096416f8f.9.1780513429422; 
 Wed, 03 Jun 2026 12:03:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm9050847f8f.25.2026.06.03.12.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 12:03:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 966E15F8A6;
 Wed, 03 Jun 2026 20:03:47 +0100 (BST)
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
In-Reply-To: <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 28 May 2026 09:41:40 -0700")
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
 <87fr3eyrvp.fsf@draig.linaro.org>
 <8a878679-733c-451c-8053-663a74f8d4a7@oss.qualcomm.com>
 <87a4tlz897.fsf@draig.linaro.org>
 <86385e93-5425-4145-8a9f-0f72ed5de022@oss.qualcomm.com>
 <87o6hzx2np.fsf@draig.linaro.org>
 <5a4eedbb-483c-40ea-a4dd-b34a4b7d7b6e@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 03 Jun 2026 20:03:47 +0100
Message-ID: <87wlwfsay4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> On 5/28/2026 3:13 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 5/26/2026 11:17 PM, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>> <snip>
>>>>
>>>> What do you mean? I run check-tcg all the time.
>>>>
>>>> Which containers fail to build for you? The main cross-compiler one
>>>> (debian-all-test-cross) is built all the time.
>>>>
>>>
>>> Build is working out of the box now.
>>> However, it seems that only tests for aarch64, arm and x86_64 are run
>>> when using containers without having installed cross compilers.
>>> Maybe it's another carefully handcrafted feature of tcg Makefiles?
>>=20
>> Works for me over here. Do you have podman or docker installed?
>>=20
>> It's true the Makefile has to jump through some hoops to compute
>> TCG_TESTS_TARGETS from TCG_TESTS_WITH_COMPILERS (config-host.mak) and
>> CONFIGURED_TCG_TARGETS (via $(wildcard *-config-target.h)). Is that
>> where it fails?
>>
>
> Maybe, I reproduced that on two different machines, with different
> architectures. As you know, Makefiles are complex to debug, which is one
> of the reason I would like to get rid of it completely.
>
> I prefer to spend time replacing this, instead of investigating N days
> to understand why a dependency is missing (similar to the current patch)
> and solve it by adding new cryptic lines in an existing Makefile.
>
>> As I've said before I'm not wedded to Makefiles, in fact I would look
>> forward to a world when I can run an individual test directly from
>> meson. However I'm not prepared to throw away functionality, especially
>> the ability of new developers/testers to build the tests without having
>> to install cross-compilers. That would take us back to the *before
>> times* when TCG tests where hardly ever run and tended to bitrot.
>>
>
> Sure, I agree with you. The transition should not change anything,
> except how to run a single test. We can easily replicate the container
> functionality in meson I think.
>
> I just had the impression, previously in this thread, that instead of
> saying "Sounds good, let's explore the meson approach", the tone was
> more "this is wrong and this can't work, please don't touch this". Maybe
> it's just a communication issue.
>
> I made the effort to show a minimal example to prove you can compile
> stuff without having to declare a toolchain in meson, which was the
> "blocker" you mentioned. The rest, multi files tests and using a
> container instead of an installed cross compiler, are just small
> details. The key is "we can build a custom binary using a custom command
> with meson", and that's all we need to move forward.
>
>>>>> But well, if the cross-container thing is *really* a blocker, we can
>>>>> just wrap build and run in a script per cross compiler, that does
>>>>> docker/podman build && docker/podman run and call that.
>>>>
>>>> We still have the remnants of that in the docker.py script although for
>>>> most containers we moved to invoking docker (or podman) directly.
>>>>
>>>
>>> Maybe that's why I encountered issues in the past, and now it works out
>>> of the box.
>>=20
>> The original script attempted to deal with caching layers and the
>> consequences of custom USER/UID on local machines. Nowadays it is mostly
>> used as a basic wrapper around "probe" for the runtime and is still used
>> by the binfmt_misc and toolchain wrappers.
>>=20
>> For porting to meson it might be worth just having a minimal wrapper
>> just for building rather than mess with it.
>>
>
> Yep.
>
>>>> Also bear in mind the containers are also used to cross build QEMU
>>>> itself.=20
>>>>
>>>>>
>>>>> Now we solved the problem with system tests, and cross compilers, is
>>>>> there another thing that is absolutely needed from Makefiles?
>>>>>
>>>>>>> If it's not the case, then we should definitely move into the direc=
tion
>>>>>>> of migrating all this to meson, and rely on meson tests infrastruct=
ure.
>>>>>>>
>>>
>>> To add on top of this, I would be happy to help with the transition, but
>>> I want to make sure you'll accept it first, with a list of
>>> requirements.
>>=20
>> For check-tcg the requirements are simple:
>>
>
> Thanks for listing them. We can have specific test suites to address the
> categorization. For the rest, there is nothing custom targets won't be
> able to solve.
>>   - support building tests with containers
>>   - handle all existing tests
>>     - per-arch *-user and *-softmmu
>>       - including post test validation checks (conditional-diff-out, val=
idate-memory-counts.py, etc...)
>>       - per-target overrides (some targets are broken for some tests)
>>       - custom QEMU_OPTS for some tests
>>       - including sub-arch tests (e.g. x86_64 includes i386, mips64el in=
cludes mips64 etc...)
>>     - multiarch tests for all *-user targets
>>     - multiarch tests for all *-softmmu targets with boot.S
>>     - gdbstub tests
>>       - don't forget gdb feature probing for arch and arch features (e.g=
. GDB_HAS_SME_TILES)
>>     - record/replay tests
>>     - tcg plugin tests
>>       - modulate plugins over tests to avoid combinatorial explosion
>>       - filter some plugins from general testing (e.g. patch)
>>       - filter some plugins based on mode (e.g. syscall)
>>       - specific plugins with specific tests (e.g. patch, memory)
>>     - support build variations
>>       - compiler feature probing to gate tests
>>       - custom cflags for some tests
>>       - alternate cflag builds for some tests (e.g. sha512-[vector|sse|m=
vx|...])
>>       - build scripts (e.g. test-mmx.py)
>
> I have a proposal: How about I give it a try with a specific target
> (let's say aarch64?), to try to cover user, system, and multi arch
> tests, without the cross container as a first step.
>
> This way, we can focus on testing part, agree on what works, what
> doesn't, and iterate until having something nice.
> Then, we can add cross container support, and finally add the rest of
> targets. Once all of them are implemented, we can migrate check-tcg
> command to this.

I think that's a reasonable plan. We can certainly test and review
patches as we try different things out. aarch64 is a good first target
as it has user, softmmu and plugin specific tests.

What we can't do is merge piecemeal so I'd want a complete conversion
before we merge so we don't end up with a half-functional port to meson
in the tree (the bane of QEMU's API conversions).

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

