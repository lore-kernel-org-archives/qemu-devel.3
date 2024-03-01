Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1CFC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 10:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg061-0004zq-5m; Fri, 01 Mar 2024 05:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg05z-0004zd-IC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:26:27 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg05x-0006iZ-O7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:26:27 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e1d327595so295065f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709288784; x=1709893584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0v/gTgHs0goQHqvP2wizu2jNBN2qIwxelTd3qnbraw=;
 b=QJDUJTGEB18NzoVjI5PhQWdTC/8rg+CAK8L9nkqqPFGbXXzgMnr2hUCmSrkjYjQqWb
 g39DEoBzo4tyvsgjdLmLVqoWZeGNZeRj3Qj0P3eFS31Q1QaBUSjToIaRGuq1H4FUWuDI
 wlc31V1v8fLayGtDpR/02YCnt2ZfA1nf2wSQuWBFQaosv4DUxZEW56xFbb/UxCleZms5
 SxleYjTaUHugs19V77gSQt6uCe6Fo6X90nNKUoHqvzlqb69thY073Riiyur8D2oNtUTd
 QxXcT9tJzhCtU6XmnGrPHorjBNtLSoS0CaHfls45XF2IiX+dvpPgAU5t+UYhS4Ls8QxD
 0Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709288784; x=1709893584;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j0v/gTgHs0goQHqvP2wizu2jNBN2qIwxelTd3qnbraw=;
 b=Uh08RwJoTtQITi3evWXM1mli3vKlAT7CUDtudhMBWzOw8Tw96RrmPcp5pBx3H3xscy
 0kq3rfUc1F+B0M6j8sTHRsBcxh9V4ezhkV66WJrEI12bBkNsDsQphzlKlVOXXy8LKtJS
 oWBiWfVRRau1Kci+ng1jI69g/wWjBRzg9B1u0iwn1DacQkCVLJhyarggl7pu/EDGw9T6
 efz/ot+dPHiQEruT9feDUKyGPI6VzkgbHhjJmdKuufyRrWo/KC9Z0c9mkhouNyrNaV+U
 QOYljHqkrz4Lw8vzazM/zB5EmU9oD5TQscQNpnr1A4hyayDp+YzkHajmQQpOSEgP/8B/
 cuLw==
X-Gm-Message-State: AOJu0YyxWUtBeaCeGjkbkBd3IVzXxkb+LYqgGaHO+RB8mTaHZk5p+Ohv
 AVCx6Nc/0xGFxVc76Vz91Ug+RY48Da8p2UXP3EfLa6+CE98XkEdOtqnXPNmXFGI=
X-Google-Smtp-Source: AGHT+IFgWcWHVIqW7z/CnEnUxWT96HM9dC0YZnE+MdMPiHsgXTK6xT17rV1pwf72Wr9sQbj0GVzKJg==
X-Received: by 2002:a5d:5702:0:b0:33d:f457:ab45 with SMTP id
 a2-20020a5d5702000000b0033df457ab45mr840131wrv.43.1709288783975; 
 Fri, 01 Mar 2024 02:26:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u9-20020a056000038900b0033dca6f8b44sm4277663wrf.16.2024.03.01.02.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 02:26:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 540745F75D;
 Fri,  1 Mar 2024 10:26:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 08/12] tests/plugin/bb: migrate to new per_vcpu API
In-Reply-To: <349de033-c966-4b99-a852-78b93a41e555@linaro.org> (Pierrick
 Bouvier's message of "Fri, 1 Mar 2024 13:58:07 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-9-pierrick.bouvier@linaro.org>
 <87o7bz9wrn.fsf@draig.linaro.org>
 <349de033-c966-4b99-a852-78b93a41e555@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 10:26:23 +0000
Message-ID: <87h6hq5ju8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/29/24 6:21 PM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> I did notice there is a discrepancy between what libisns and libb
>> report. The libb looks like an overcount so I wonder if there are some
>> instructions we are not picking up but I can't see where that would be.
>>    =E2=9E=9C  ./qemu-hppa -plugin ./tests/plugin/libinsn.so -plugin
>> ./tests/plugin/libbb.so,inline=3Dtrue -d plugin
>> ./tests/tcg/hppa-linux-user/sha512
>>    1..10
>>    ok 1 - do_test(&tests[i])
>>    ok 2 - do_test(&tests[i])
>>    ok 3 - do_test(&tests[i])
>>    ok 4 - do_test(&tests[i])
>>    ok 5 - do_test(&tests[i])
>>    ok 6 - do_test(&tests[i])
>>    ok 7 - do_test(&tests[i])
>>    ok 8 - do_test(&tests[i])
>>    ok 9 - do_test(&tests[i])
>>    ok 10 - do_test(&tests[i])
>>    CPU0: bb's: 54282, insns: 775697
>>    Total: bb's: 54282, insns: 775697
>>    cpu 0 insns: 774827
>>    total insns: 774827
>> Although weirdly maybe only an hppa thing. Richard?
>>=20
>
> Do you observe the exact same number if you run only one of the plugin?
>
> bb count number of instructions in an executed block, while insn
> effectively count every instructions ran.
> Maybe there is hppa specifity that makes some tb exit in the middle,
> thus executing less instructions than expected from bb count.

Almost certainly - I just wasn't sure what would do that on straight
line code. Probably some funky aspect of HPPA I'm not aware off ;-)

>
> I don't know how to reproduce this test. Did you run it from a
> specific docker env?

If you have docker enabled the "make check-tcg" will build and use a
container to build the test cases. If you are on debian you just need:

    apt install gcc-hppa-linux-gnu libc6-dev-hppa-cross

and re-run configure.

>
>>    =E2=9E=9C  ./qemu-aarch64 -plugin ./tests/plugin/libinsn.so -plugin .=
/tests/plugin/libbb.so,inline=3Dtrue -d plugin  ./tests/tcg/aarch64-linux-u=
ser/sha512
>>    1..10
>>    ok 1 - do_test(&tests[i])
>>    ok 2 - do_test(&tests[i])
>>    ok 3 - do_test(&tests[i])
>>    ok 4 - do_test(&tests[i])
>>    ok 5 - do_test(&tests[i])
>>    ok 6 - do_test(&tests[i])
>>    ok 7 - do_test(&tests[i])
>>    ok 8 - do_test(&tests[i])
>>    ok 9 - do_test(&tests[i])
>>    ok 10 - do_test(&tests[i])
>>    CPU0: bb's: 41513, insns: 302671
>>    Total: bb's: 41513, insns: 302671
>>    cpu 0 insns: 302671
>>    total insns: 302671
>> Anyway:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

