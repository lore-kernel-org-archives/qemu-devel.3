Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAF1C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5JNK-0006Eq-S6; Sat, 12 Sep 2026 04:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5JNG-0006Ec-Ji
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 04:46:14 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5JND-0006Ph-Ow
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 04:46:13 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso604161a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789202768; x=1789807568; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CkiQ22R7gF1mYEjucGWSwhfG7S9uXgo/B28c/1GrAtQ=;
 b=n9qH7JWjeM3+RYwGox5FfkUD/8Rd/MQP904/JlsZxmbYHVvOQpPGpMQqH/0vjsrw2d
 wdFr3/HwFri6IURYNcA1pvXeZ+OX9jfh7rqiiHwSBFlBkpJESZTAT/ddSiylRAno68qm
 2+vtXENUd/VLtFbV5+XFtzSk/SNJNl2Ov/SqgTguMxf5srPHiKsuKSmvjnRoMTUXKE13
 j94EzJuuroQGMFRLNwYTcweOrR4U+EjGjbVPrJu5yuE/AUtu1jgph9SGjoPMxz7dfsPf
 AglhoLJDY3bkih7Ebb5S5c+SAsZgozpfQe2qurV8U/FSyoSg+LCeuj9nk2qIShFS043j
 vOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789202768; x=1789807568;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CkiQ22R7gF1mYEjucGWSwhfG7S9uXgo/B28c/1GrAtQ=;
 b=msD5L0wHL6ZHPmddAj7UTeApNOPatCuyHcCcMq3cg7ecr2O67bbK4j9L1oWZIDjSDP
 iPFRVukgRO875uLqN08ZUnzc6acs495D4PupH9bCIbF8FtXKwtcFygs3WRsjjznHqm8K
 PjRqu5TVOiNscPFGLjo/j0KS8ZreDvyLjZJ73D/8k2erJwjMipYhiCO6TcCoST0DOk0W
 6eCdXmkLBgCIRfndy+oe7emWayn8c8Ft+ir2pW0DZSbx+SisTKkqp9rlfuZ+iUh/sjMR
 e6s1Ne/s2FRyxwgpbWUnGEWV+KfJY/LPK+ee6STqh0QUouS+/c1HPn1nsqq3bNmWj1lR
 COIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkls1G9ahgJ1rB9wxpZ/ur6IIKFJpmiJ4iVfFbO8DkvRDqJcDFaeYnpkHY8yOmAYDRhJ59dZor35SR@nongnu.org
X-Gm-Message-State: AFuF++lIZVtg41hjq+h2lioCHstVdNOjrka7EaL80aiaV5p7O99QJz9m
 OgL02f4khAezKmX7Dmmc+C5QGfenSWF3/ImHfL3qWelIbRyFFXvaEuwlJcQXUTWkYF0=
X-Gm-Gg: AYBFou2gKmyEBDfNxwHOQi7GxCCQfohWX2+dcbgD0wuJb+2quo+K/+ESxOs9GqjWL1u
 S4I495aNwFnzUFqy6cdw0wxhIMuZcHDM7nwot66LezNth0+FmFBpFzO0WLstzJcYzT8AgZv+VB7
 KgDKQOAKIeZiTicGaMW56VC9rVTCbvVtZ4uQfbvbB5XnIPIEU8pbm17VRm6St54e0SVqRHiOUrI
 ZRxgY0ZPQu8vW6KvgOH6EmwptQBnk6jqbKav3H4aAYDANYcqIWkA39Vqc7zi7Ke5XGXQ+bcAAcQ
 r86K4EN6H52d4AAOMfAtUvk96ubfZa6NCOW+/HeEHcN1bD5+Av/4EJSi0Tc8gzGMsb3fUmCPt4R
 3ij4sbhOWQyimIDWr6DcqbU56uUuJrBbcxAEu1Z/8TdT31gU/Gk4ae064otPGvxqjzCh6JWbqe5
 AZtWYXQ3qqPCcBIUELu7owkcgsl1yAPrE7jVM+C7gtSQbl0nxe6O0721ExDfjggxDg/E2/8vbQ6
 Qi7MdzceU+kzefFqWhRbX+70ffeIrTrYe1Tb5Ijxf22p/B2l/V6//IhSV5M6w==
X-Received: by 2002:a17:90b:580e:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-39d9bbe47a7mr14789606a91.3.1789202767593; 
 Sat, 12 Sep 2026 01:46:07 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f1e434sm12039516eec.22.2026.09.12.01.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 01:46:07 -0700 (PDT)
Message-ID: <4e17f3d5-94df-44c4-a284-12422eda0446@linaro.org>
Date: Fri, 11 Sep 2026 22:46:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] testing: various docker clean-ups post meson tcg
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/10/26 08:14, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 
> Please review.
> 
> Alex.
> 
> Alex Bennée (8):
>    scripts/meson-buildoptions.sh: update missing options
>    tests/tcg: prefix meson built docker tags with qemu/
>    tests/tcg: use --add-current-user when building containers
>    tests/docker: add container registry to configure and use
>    tests/docker: remove used _read_qemu_dockerfile
>    tests/docker: strip remaining caching logic from docker.py
>    tests/docker: add specific command to parser
>    tests/docker: swap --quiet for --verbose
I haven't had time to pull this into a local branch, but I don't suppose 
something in here fixes

> [6/572] Generating tests/tcg/alpha-softmmu-hello with a custom command
> FAILED: [code=1] tests/tcg/alpha-softmmu-hello.test 
> /home/rth/qemu/src/tests/tcg/../docker/docker.py --command podman run --run-as-current-user -w /home/rth/qemu/bld-g -v /home/rth/qemu/src:/home/rth/qemu/src debian-all-test-cross alpha-linux-gnu-gcc /home/rth/qemu/src/tests/tcg/multiarch/system/hello.c -o tests/tcg/alpha-softmmu-hello.test -static -MMD -MF tests/tcg/alpha-softmmu-hello.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I /home/rth/qemu/src/tests/tcg/alpha/system/../../minilib /home/rth/qemu/src/tests/tcg/alpha/system/../../minilib/printf.c ../src/tests/tcg/alpha/system/boot.S -Wl,-T ../src/tests/tcg/alpha/system/kernel.ld -mcpu=ev6 -Wl,--no-warn-rwx-segments -lgcc
> Error: workdir "/home/rth/qemu/bld-g" does not exist on container 7670fc4a955a94d801b57dc0a6f6cd13ece35536a09b40634a37a83d733af942
> Traceback (most recent call last):
>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 657, in <module>
>     sys.exit(main())
>              ~~~~^^
>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 653, in main
>     return args.cmdobj.run(args, argv)
>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 395, in run
>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                                     as_user=args.run_as_current_user)
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 353, in run
>     ret = self._do_check(["run", "--rm", "--label",
>                          "com.qemu.instance.uuid=" + label] + cmd,
>                          quiet=quiet)
>   File "/home/rth/qemu/src/tests/tcg/../docker/docker.py", line 230, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.14/subprocess.py", line 420, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--label', 'com.qemu.instance.uuid=9ca55b05b3e540f7a0cda353bf6f1086', '--userns=keep-id', '-u', '1000', '-w', '/home/rth/qemu/bld-g', '-v', '/home/rth/qemu/src:/home/rth/qemu/src', 'debian-all-test-cross', 'alpha-linux-gnu-gcc', '/home/rth/qemu/src/tests/tcg/multiarch/system/hello.c', '-o', 'tests/tcg/alpha-softmmu-hello.test', '-static', '-MMD', '-MF', 'tests/tcg/alpha-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g', '-fno-strict-aliasing', '-nostdlib', '-ffreestanding', '-Wa,--noexecstack', '-I', '/home/rth/qemu/src/tests/tcg/alpha/system/../../minilib', '/home/rth/qemu/src/tests/tcg/alpha/system/../../minilib/printf.c', '../src/tests/tcg/alpha/system/boot.S', '-Wl,-T', '../src/tests/tcg/alpha/system/kernel.ld', '-mcpu=ev6', '-Wl,--no-warn-rwx-segments', '-lgcc']' returned non-zero exit status 126.
> filter=--filter=label=com.qemu.instance.uuid=9ca55b05b3e540f7a0cda353bf6f1086
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:170: run-ninja] Error 1

For avoidance of doubt, this is immediately after

   make docker-image-debian-all-test-cross NOCACHE=1 V=1


r~

