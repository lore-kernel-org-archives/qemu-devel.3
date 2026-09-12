Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B7C88E56
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5RT4-0006Lw-Ju; Sat, 12 Sep 2026 13:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x5RT1-0006LP-G8
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 13:24:43 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x5RSz-0006GO-99
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 13:24:43 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so2779115e9.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789233878; x=1789838678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uuqvydzXbhF5WwOtiZ7B0n/FyiY2mFwD+1cNYP7akAE=;
 b=faZtMLYekOPxoBeYVIF+L7qnfW8XZD/8x6prxhAjNZnnbEvYZMO+8wg5Xs9HjFWJor
 N1hXmbiQG8qoRL68HWwKJqd3zx5EsWyE9DXlSpR+BZ0FtWsJ+VUnFT3ywJBUK9zaPC2f
 RQGVoeAQ25xBx2CY70JOQiAIfxcFIasZrhLHyg6OPUO27Tg1eOu8lfP2Hp1d4/7yDduP
 rzj+nzub4RX3NE4CoVAhh3HsCBWitGFS4JyeRh/fyNk+bZkASir5OrguadB7sCT2kEkt
 Wel4uYZhlW1xG6XVzRi9Of0+9qQhKWR1/UlDcPR5Y+QithmQASf3Db+egqUpL8ibEwEP
 Ofig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789233878; x=1789838678;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uuqvydzXbhF5WwOtiZ7B0n/FyiY2mFwD+1cNYP7akAE=;
 b=c4o4bUBM2OYqRfz1j22jsdOTslEbhkzFpnzjmkq6dGnGu4oHmTJHFFDJHXRILnQFkY
 QTq6FlIj8AKcKqZXoJvIer2lgwW5xQBBBgvTsgqaOGn+ETx0ZON7oswonOZYtLm1PQZs
 lsYCLYogV2DCPyd/259Z7Jr+TaceqidOjd75reab3zkJQLMkrrEgLcVrGCo6WKDAV46U
 DKkkJ4cr17hwuAUOLF2PWdmZVphlM30skYLL7r2feDnAkuwBCI4+9XkSZkHcZ2jUNQVi
 aufEC24OXh4VKrSVe2XEjwJou7U6HUipRW3eL3UImYJv+t5dw6y29LeJWst5Sm6WDiZ3
 5/Hg==
X-Gm-Message-State: AFuF++kXkwjXwkuPCCvTqCjhLmCwaMx0m1UNcy3VY1knzbfk0YxrGjAT
 WktAzNof88j2zhymcjV6+Bda//RI9rfC8MHyy+pBV4r1PhLVR+c80Fc3YpD8JBnNfCs=
X-Gm-Gg: AYBFou16ZoeWsnRlSZEvf/HNrJzuZHAaZA201Jvk3dkrdgcbUN0I+2jxtGhFd97tj3t
 FJhGhf3Nq7vRkQXA4h8QeAqLRxZLKN9wGlgGQpjR6L8yU1wLRU76HH2riOCnUxmUp2i2TLEWXVc
 ybuo6X3GgoAjwkTTbBVpfAGHPSS3Zm84i4br4eZorKALv8iqEJpFAjH/q27FcIDKZOpqHPNb8YF
 HAki7lmbu5uRuWNnp5SlUs/ek/MbIi449Slwm/8Ue0NTkT8dZAUCPWTKun44y6fX21L0925whU9
 RAqEnyXCMoP6ZHxn2mZQVA4gd4j5akqXM311lTgMhKt6ytvSsQN05gKRzIhxxqrETsIPo823L7g
 jsLUMI9wXxXZ4SY+MBMKQ6yrjHIBzftHNiXu0XOxSAtG2N9GUa7b8OLhs+o8MDP0hSqb70+z5P3
 aAqT6tHFVCLkRC5PGWwYC7X+kHMiBGiK+MBNlaQibDIxEz9y8QBtwEpZgyz9/ELV0s3ijvNF7/J
 tfGRNNzDA==
X-Received: by 2002:a05:600c:4e13:b0:49c:dada:f581 with SMTP id
 5b1f17b1804b1-49e6ca28d5emr30260365e9.0.1789233877991; 
 Sat, 12 Sep 2026 10:24:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62232cb7sm130066715e9.4.2026.09.12.10.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:24:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C68B05F8C6;
 Sat, 12 Sep 2026 18:24:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/9] testing: various docker clean-ups post meson tcg
 conversion
In-Reply-To: <4e17f3d5-94df-44c4-a284-12422eda0446@linaro.org> (Richard
 Henderson's message of "Fri, 11 Sep 2026 22:46:04 -1000")
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <4e17f3d5-94df-44c4-a284-12422eda0446@linaro.org>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Sat, 12 Sep 2026 18:24:35 +0100
Message-ID: <878q562xik.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/10/26 08:14, Alex Benn=C3=A9e wrote:
>> This cleans up a few bits and pieces although doesn't totally solve
>> the issue of an apparent stall while meson builds the docker image.
>> However with these changes there should be no difference between the
>> meson build and the equivalent "make docker-image-foo" invocation.
>> We also finally get rid of the ill-advised magic caching support in
>> docker.py.
>> Please review.
>> Alex.
>> Alex Benn=C3=A9e (8):
>>    scripts/meson-buildoptions.sh: update missing options
>>    tests/tcg: prefix meson built docker tags with qemu/
>>    tests/tcg: use --add-current-user when building containers
>>    tests/docker: add container registry to configure and use
>>    tests/docker: remove used _read_qemu_dockerfile
>>    tests/docker: strip remaining caching logic from docker.py
>>    tests/docker: add specific command to parser
>>    tests/docker: swap --quiet for --verbose
> I haven't had time to pull this into a local branch, but I don't
> suppose something in here fixes
>
>> [6/572] Generating tests/tcg/alpha-softmmu-hello with a custom command
>> FAILED: [code=3D1] tests/tcg/alpha-softmmu-hello.test
>> /home/rth/qemu/src/tests/tcg/../docker/docker.py --command podman
>> run --run-as-current-user -w /home/rth/qemu/bld-g -v

yes - the -v is missing it's args which is fixed by the argparse patch
before I switched --quiet and --verbose which exposed the latent bug.

>> /home/rth/qemu/src:/home/rth/qemu/src debian-all-test-cross
>> alpha-linux-gnu-gcc
>> /home/rth/qemu/src/tests/tcg/multiarch/system/hello.c -o
>> tests/tcg/alpha-softmmu-hello.test -static -MMD -MF
>> tests/tcg/alpha-softmmu-hello.d -Wall -Werror -O0 -g
>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
>> /home/rth/qemu/src/tests/tcg/alpha/system/../../minilib
>> /home/rth/qemu/src/tests/tcg/alpha/system/../../minilib/printf.c
>> ../src/tests/tcg/alpha/system/boot.S -Wl,-T
>> ../src/tests/tcg/alpha/system/kernel.ld -mcpu=3Dev6
>> -Wl,--no-warn-rwx-segments -lgcc
>> Error: workdir "/home/rth/qemu/bld-g" does not exist on container 7670fc=
4a955a94d801b57dc0a6f6cd13ece35536a09b40634a37a83d733af942
>> Traceback (most recent call last):
>>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 657, in =
<module>
>>     sys.exit(main())
>>              ~~~~^^
>>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 653, in =
main
>>     return args.cmdobj.run(args, argv)
>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 395, in =
run
>>     return Docker(args.command).run(argv, args.keep, quiet=3Dargs.quiet,
>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>                                     as_user=3Dargs.run_as_current_user)
>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 353, in =
run
>>     ret =3D self._do_check(["run", "--rm", "--label",
>>                          "com.qemu.instance.uuid=3D" + label] + cmd,
>>                          quiet=3Dquiet)
>>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 230, in =
_do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "/usr/lib/python3.14/subprocess.py", line 420, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--lab=
el', 'com.qemu.instance.uuid=3D9ca55b05b3e540f7a0cda353bf6f1086', '--userns=
=3Dkeep-id', '-u', '1000', '-w', '/home/rth/qemu/bld-g', '-v', '/home/rth/q=
emu/src:/home/rth/qemu/src', 'debian-all-test-cross', 'alpha-linux-gnu-gcc'=
, '/home/rth/qemu/src/tests/tcg/multiarch/system/hello.c', '-o', 'tests/tcg=
/alpha-softmmu-hello.test', '-static', '-MMD', '-MF', 'tests/tcg/alpha-soft=
mmu-hello.d', '-Wall', '-Werror', '-O0', '-g', '-fno-strict-aliasing', '-no=
stdlib', '-ffreestanding', '-Wa,--noexecstack', '-I', '/home/rth/qemu/src/t=
ests/tcg/alpha/system/../../minilib', '/home/rth/qemu/src/tests/tcg/alpha/s=
ystem/../../minilib/printf.c', '../src/tests/tcg/alpha/system/boot.S', '-Wl=
,-T', '../src/tests/tcg/alpha/system/kernel.ld', '-mcpu=3Dev6', '-Wl,--no-w=
arn-rwx-segments', '-lgcc']' returned non-zero exit status 126.
>> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D9ca55b05b3e540f7a0c=
da353bf6f1086
>> ninja: build stopped: subcommand failed.
>> make: *** [Makefile:170: run-ninja] Error 1
>
> For avoidance of doubt, this is immediately after
>
>   make docker-image-debian-all-test-cross NOCACHE=3D1 V=3D1
>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

