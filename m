Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEDFD49217
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 12:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU1rI-0000uj-LD; Fri, 12 Dec 2025 07:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU1rA-0000uF-N2
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:02:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU1r8-00073Q-Or
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:02:44 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so8987895e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 04:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765540961; x=1766145761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtbjbGtJ0bAX1CUydxCTuVm5sJW1YSTK8SfA91tBag4=;
 b=rZw6pgaXloxZSwvXDKkHwgRbDfcp7EYU9rZbfHv9yMy9M8e8t5IAh3aB1deM4+ivHu
 7JEQLJK/gKAFm4Mj93vkydCEDyHZ+dWtyJ/IMLgEA794GKURosiKahVnYPe2fTJ6/jFg
 zIPIFq8bZZArkUgMQQlW5LTFiuP8MY61+gA8qu7rnfOTmF6w1ftS1gP0hvoIindolVp1
 khrD0oN02lbwpnVdFH8TX4UOseq4JA2jXg9g3d6aiu5n9lixUlKBBNz7stLw4jin9Z8F
 msTaWVaNx9FLHJlim1GESK1UPZY8frBHIu0ZBB/1xu5zwmVNjVleP70K0gcPUfulIiP1
 uAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765540961; x=1766145761;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KtbjbGtJ0bAX1CUydxCTuVm5sJW1YSTK8SfA91tBag4=;
 b=pZsXYDsYoK0IueVwi4S3GhoQBgxnzn0tATkmqRXTd9XKVnEpl+Uyy92VWOKWCouP4J
 D+wwqOxI2yWyvZuYYxyefyU0oOXuEWSaTf12O0jWD7vbWYo1s17y07A4MsxSUMuP+QIj
 VezrfO3hYuVW61NXCNQYdT71tu6T76bkvy+UkvUQtu/vouWKjeFnT8vI3j4udnDQQOaZ
 HDR7gaEOuYOi6U00vKuivi6pGLql6q0I34IsJW/gO0PnitsiJ0HDBn/LLy6mIgPhN/0V
 D54N9pIl3Dv4644kF+dG1pFGRU3vmZUJJmD1mPXfg07rSiV/h+NEIiWpHn5LBg69KgOC
 Uu9A==
X-Gm-Message-State: AOJu0YzWAd8915fF91l/1mCdB/ztSS/qf2qDSAG2msxKGuY9IdWUG78e
 WG7vYqsQw+rIkj7phAXMv7YLqbCBd8SSkejoCZ84RSlvhO+GtwasryDp0fgII1mx6AU=
X-Gm-Gg: AY/fxX7YuW+9XygELcVteqUXBD4Omp5848Grd5On7J/pVl8npye80U1tIHDtArOKfs/
 F4LvccaMo1MQ+owQj/BCFFOwUHvycQebIh7u/U+kLxU61m+osLQpFY1kBQIwzNhsMfoHGD67EIM
 h9tk8pyBTfQUd1s1vATKCUldMWGG4rDDnv59cE3J8oX8GX7iGuQK9nlw/857XF+5oMth5z+zi6y
 yPJ7ZTTmWy/49dlDTlur3tA3UMVun7fPGE0FbI3Km8EyuLih3Yh0sTLgZf9pC/LXhcP4FM+1uiX
 AHA4+q54Z7vcs87wrd3Y+V+m0p8MtLv/HVMM03O/HIkqlHi9l7cX6CbYV6maaVcM8hPVeaIpIVX
 bc/NpusT5Xnl96jbHebkQmkH8xGuQ+QMIVlZTysY6voDUBvOPVATaNkASEuYjT7te4HsmFfpL1K
 UYtBq+XesliiM=
X-Google-Smtp-Source: AGHT+IGiHMRS9WJPLmKRkiPrWI23/jgsMZxuY13i2wQ1DzjsqbB/LCBvL1J3ZVCrTcim9N+fD7lCyg==
X-Received: by 2002:a05:600c:34cd:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-47a8f8c1d1amr18723065e9.13.1765540961073; 
 Fri, 12 Dec 2025 04:02:41 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85d1esm11395147f8f.26.2025.12.12.04.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 04:02:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A67E5F82E;
 Fri, 12 Dec 2025 12:02:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
In-Reply-To: <f06e2059-9d86-4a5c-acff-84cbeabcfb06@epfl.ch> (Florian
 Hofhammer's message of "Wed, 29 Oct 2025 16:57:49 +0100")
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <f06e2059-9d86-4a5c-acff-84cbeabcfb06@epfl.ch>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 12:02:39 +0000
Message-ID: <87ikebucv4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> Hi,
>
> Sorry for necrobumping this thread. I just wanted to follow up on this
> and ask if there is still interest in this plugin API extension or if it
> is going to be dropped in favor of the Lorelei patches (which would also
> fulfill my original use case).

These are the system call filter patches?

I guess that depends on if being able to change PC is only for skipping
syscalls?

>
> Thanks for your time,
> Florian
>
> On 06/10/2025 15:21, Florian Hofhammer wrote:
>> Hi,
>>=20
>> As originally discussed in the thread at
>> https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
>> and later proposed in a patch at
>> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02218.html,
>> I am sending an updated version of my patch based on the previous
>> feedback.
>>=20
>> Notable changes to v1:
>> - Added a setjmp() in the syscall handling path to allow redirecting
>>   the PC via cpu_loop_exit() also in syscall callbacks. The previous
>>   version would only work in instruction execution / memory access
>>   callback contexts, as the setjmp() corresponding to the longjmp() in
>>   cpu_loop_exit() was only live in those contexts.
>> - Added a flag to make sure the new API function is only called in
>>   contexts where it makes sense, i.e., during execution of guest code.
>> - Added a test that checks the new functionality by skipping a
>>   non-existent sentinel syscall.
>>=20
>> I made it an RFC patch this time as I am not entirely sure if my
>> setting/handling of the new flag makes sense the way it is. I briefly
>> looked into making the QEMU_PLUGIN_CB_* flags actual flags via a
>> bitfield instead of enum values, but that would have required touching
>> a lot of code all over the place, so I'm not sure this is the way to go.
>>=20
>> Happy to get feedback and your thoughts on the patches!
>>=20
>> Thanks,
>> Florian
>>=20
>>=20
>> Florian Hofhammer (2):
>>   plugins: Add PC diversion API function
>>   tests/tcg: add test for qemu_plugin_set_pc API
>>=20
>>  include/qemu/qemu-plugin.h                    | 15 +++++++
>>  linux-user/aarch64/cpu_loop.c                 |  2 +-
>>  linux-user/alpha/cpu_loop.c                   |  2 +-
>>  linux-user/arm/cpu_loop.c                     |  2 +-
>>  linux-user/hexagon/cpu_loop.c                 |  2 +-
>>  linux-user/hppa/cpu_loop.c                    |  4 ++
>>  linux-user/i386/cpu_loop.c                    |  8 ++--
>>  linux-user/include/special-errno.h            |  8 ++++
>>  linux-user/loongarch64/cpu_loop.c             |  5 ++-
>>  linux-user/m68k/cpu_loop.c                    |  2 +-
>>  linux-user/microblaze/cpu_loop.c              |  2 +-
>>  linux-user/mips/cpu_loop.c                    |  5 ++-
>>  linux-user/openrisc/cpu_loop.c                |  2 +-
>>  linux-user/ppc/cpu_loop.c                     |  6 ++-
>>  linux-user/riscv/cpu_loop.c                   |  2 +-
>>  linux-user/s390x/cpu_loop.c                   |  2 +-
>>  linux-user/sh4/cpu_loop.c                     |  2 +-
>>  linux-user/sparc/cpu_loop.c                   |  4 +-
>>  linux-user/syscall.c                          |  8 ++++
>>  linux-user/xtensa/cpu_loop.c                  |  3 ++
>>  plugins/api.c                                 | 17 +++++++-
>>  plugins/core.c                                | 25 ++++++-----
>>  tests/tcg/multiarch/Makefile.target           | 42 +++++++++++++++++++
>>  .../tcg/multiarch/test-plugin-skip-syscalls.c | 26 ++++++++++++
>>  tests/tcg/plugins/syscall.c                   |  6 +++
>>  25 files changed, 170 insertions(+), 32 deletions(-)
>>  create mode 100644 tests/tcg/multiarch/test-plugin-skip-syscalls.c
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

