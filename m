Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5399EFD214
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB9O-0007wn-BE; Wed, 25 Feb 2026 04:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvB9K-0007so-Jw
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:25:42 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvB9I-0004B7-To
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:25:42 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8860d6251bso854794466b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 01:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772011539; x=1772616339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BwSYa+wxmFsKPse3RLjIC9gYyfv/UDyGuMLmqMg8YM=;
 b=m5AoJojjAfwQJFcYTYDap9CIHXdO4wmag53nfu8YEqsEazejRo1hfaSeIOF1mHHlLb
 mXMgftpIfAhkvUmV2IlvpEiis/nWUKKW3Xy8JW7fHf038vSvTMsdk00hBm9i9sTwCiQh
 6gy7nHOw6dQYfzNvlId5P+TGidJTZ4uUOCvkvaRor+yDeEPlVVtdaq92MvYPUXBMlFic
 ydaGXdlSADj41lxApx7zinK8fAqmPRq2sVVRK/fKgT6mQhqJVaOodf8A+60tpH8YTB41
 NysQr0Tiy4zhLmJiJGdsC0kCLWj3Q4wrL4myuaTN7a01Zb3zc4BzoKUqRPrrEoSmdvIq
 bCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772011539; x=1772616339;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1BwSYa+wxmFsKPse3RLjIC9gYyfv/UDyGuMLmqMg8YM=;
 b=CNm6mGzhJRdja6adZ84R5luBFvm1desMrmXkVAZhDKbkrqefRDGXtMlhr/kHNcDIrq
 u+/v8tdWOTPa8d+HDcYntcs40q8kpXOc5nlvC2gkT1pt0p2putKuDH3P4sv0gYw+svPf
 /pZ2eFd3y5+4536yvqXX4fG3axztPhIczTSif6g0kt/qnlSypPjdWffvxNJa1OSr/a8b
 IRnFcNPUEJTL1Gw50Iq3Timseu9W/014DeVhaotYb+/w3JTc/S3x1ZI9JPs9Z7RvxSG4
 QHBr6wdk6mnrmhPNmoAwbtR7zYS30W4NKHd6UHcmBgDNS180wJs/fZLBOzZaSZcvZHBE
 UQpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUsT6sIiKtFeNSdAvmJh27LGrswmh1gF5jwiYUb57Tzt4mWDA4Y5f53jCJMp43bJbJkwIUcA/INztj@nongnu.org
X-Gm-Message-State: AOJu0YwsP5Wvg2qsBTetR2bXEGOV1atVd9xKCV5iNKcAEw7FXXQVVkDx
 0HP7hMeBI9E9jhBNV/i9w+OS571ZQ1FzbGSbR6FRD+nOOb+vCa8u5MQILJmmSm7MfRI=
X-Gm-Gg: ATEYQzyRAEsAwNfshhtfRVPqYJHqQI0C8m4FSKxGjxm8MOQxRVPXUHn+uGhLr8cT9xc
 YRm1e6sQaY8mwH166y9KUtbAJM7MupOU9hSq9/YUEKUmODrQcUDNc6bApRQ5q9XJx1ChE/UPKnw
 rkcqEjSe+kVTcfM2qYsKsPKRjgyho81iKWzmEjMyO52GA/AkjXAlx6mrAbAA0/hbsnxd6uFcSbf
 h9gN2lwPlLjHDzaPKSqgd7HMt8z0ZRoQ/UntKld/ORvtEJ1xaJIVq0irPaScZ5/k9CdVJeAkqaW
 WKNsBXxusodurcNpqNWhZ/vXh9DFRqF4qZxk8EdAg/OeKsWP5xuf1+Q4A2rmaFn12hfewYa5xAa
 c+zztGClZU0lrIkctJFIc/DrkCKgarBNRxGTV74xqIfdAE3rYyHQZgGepzKXSlppu0Q/t22jgd7
 gfWrLq21tDpHBPe7bR3RQSoeU=
X-Received: by 2002:a17:907:e106:b0:b87:38e0:4403 with SMTP id
 a640c23a62f3a-b9081b5ff32mr726675166b.40.1772011539032; 
 Wed, 25 Feb 2026 01:25:39 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b931f81b914sm131126366b.7.2026.02.25.01.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:25:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 974395F834;
 Wed, 25 Feb 2026 09:25:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 2/7] linux-user: make syscall emulation interruptible
In-Reply-To: <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org> (Pierrick
 Bouvier's message of "Tue, 24 Feb 2026 13:05:09 -0800")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8096590c-bf13-4e5e-8167-ab38a37180bc@epfl.ch>
 <538ada16-07b8-403c-b1fa-f42db7cfc195@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 25 Feb 2026 09:25:37 +0000
Message-ID: <874in52mzy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 2/24/26 7:50 AM, Florian Hofhammer wrote:
>> The syscall emulation code previously wasn't interruptible via
>> cpu_loop_exit(), as this construct relies on a longjmp target that is not
>> live anymore in the syscall handling code. Consequently, longjmp() would
>> operate on a (potentially overwritten) stale jump buffer. This patch add=
s an additional
>> setjmp and the necessary handling around it to make longjmp() (and by
>> proxy cpu_loop_exit() safe to call even within a syscall context.
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   linux-user/aarch64/cpu_loop.c      |  2 +-
>>   linux-user/alpha/cpu_loop.c        |  2 +-
>>   linux-user/arm/cpu_loop.c          |  2 +-
>>   linux-user/hexagon/cpu_loop.c      |  2 +-
>>   linux-user/hppa/cpu_loop.c         |  4 ++++
>>   linux-user/i386/cpu_loop.c         |  8 +++++---
>>   linux-user/include/special-errno.h |  8 ++++++++
>>   linux-user/loongarch64/cpu_loop.c  |  5 +++--
>>   linux-user/m68k/cpu_loop.c         |  2 +-
>>   linux-user/microblaze/cpu_loop.c   |  2 +-
>>   linux-user/mips/cpu_loop.c         |  5 +++--
>>   linux-user/or1k/cpu_loop.c         |  2 +-
>>   linux-user/ppc/cpu_loop.c          |  6 ++++--
>>   linux-user/riscv/cpu_loop.c        |  2 +-
>>   linux-user/s390x/cpu_loop.c        |  2 +-
>>   linux-user/sh4/cpu_loop.c          |  2 +-
>>   linux-user/sparc/cpu_loop.c        |  4 +++-
>>   linux-user/syscall.c               | 16 ++++++++++++++++
>>   linux-user/xtensa/cpu_loop.c       |  3 +++
>>   19 files changed, 59 insertions(+), 20 deletions(-)
>> diff --git a/linux-user/sparc/cpu_loop.c
>> b/linux-user/sparc/cpu_loop.c
>> index 7391e2add8..f054316dce 100644
>> --- a/linux-user/sparc/cpu_loop.c
>> +++ b/linux-user/sparc/cpu_loop.c
>> @@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
>>                                 env->regwptr[2], env->regwptr[3],
>>                                 env->regwptr[4], env->regwptr[5],
>>                                 0, 0);
>> -            if (ret =3D=3D -QEMU_ERESTARTSYS || ret =3D=3D -QEMU_ESIGRE=
TURN) {
>> +            if (ret =3D=3D -QEMU_ERESTARTSYS
>> +                    || ret =3D=3D -QEMU_ESIGRETURN
>> +                    || ret =3D=3D -QEMU_ESETPC) {
>>                   break;
>>               }
>
> Just a style nit:
> if (ret =3D=3D -QEMU_ERESTARTSYS ||
>     ret =3D=3D -QEMU_ESIGRETURN ||
>     ret =3D=3D -QEMU_ESETPC) {

I was hopping the ret test could be wrapped up into a helper but it
seems sparc and x86 have enough variation in handled ret codes to make
that difficult.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

