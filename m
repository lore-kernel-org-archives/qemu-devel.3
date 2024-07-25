Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21E5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 20:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX55x-0006Rl-3X; Thu, 25 Jul 2024 16:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX55u-0006OB-7c
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:29:46 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX55r-0004Fi-Lw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:29:45 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f035ae1083so6817771fa.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721939382; x=1722544182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NgOb7V7h2OaLljhVsZYmHTZ0Z+pQ91WYYq1oDqM9mcQ=;
 b=NATkoQnqWwBf8/edxfEbsURtjWu8aw8bLt4ClTiLsrQWcXJlcPCyEcGV1mK2IYQh5j
 GMxQ/dYqI9KkYufnqpa5v0tEvfMSoFMBq3JI6g969NrkHndIz7y9eGmFGeF4PBHSD0Fo
 6tFnWMuyq4SNEwtrVXGy8QR6gBgOcHVAoBNzCt9rkWMyAd5oWmIOqh6zkIr8vMF+Kk8Y
 6PGRtuvJT742/gQuYDti1DMTesLaSgBVHpuYUupZ4FKhP22dsuHihixWRKcfAU/ZGQii
 dqsbwLi5MLBTabPS/1ly59zU7m0QTpf7LBNVs6JlCVrR1foQAxu0LAFX+lo8TDa2rfxo
 BtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721939382; x=1722544182;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgOb7V7h2OaLljhVsZYmHTZ0Z+pQ91WYYq1oDqM9mcQ=;
 b=s4cxs39GKnI+tmZgMNTBTuoIT63lBB4WQ+YoFzZGwf9Ie42se86imX0b+unKk7z2Rq
 NGbOMzPg8EvsnRP1rfz+MZlELS27MQkxqFYorgn3RfLK5tk6ZFeVzPIngv7Uqji0ghDk
 5N/SgIjmyGWVxafIG3yjF8RlSMdxw/3atXgV6czL9kHNn2/0rEBO3AbvNPDh7x0tBf5i
 ZahRiku2sC+ymr86L81SjLjT+S67dywrz+QBNAv/ukfoYjFjyq7leT776fNzhOnnyM5c
 XPBxNN0ZtWalbilix3A6lF6kOdUyFaDZixZwT7LZn4ABr69pE/1LZmsnX58ElIwb9Jks
 zXsg==
X-Gm-Message-State: AOJu0Yxcuqmr90MiglcZPz5R09EaqQQEd0rPZn+uW41VJzVjIUc3lvHK
 7n1lxwF4is1CTlpHNOCUZN6IaE1UiBtE1xVOy3c6iy2sTAEztiuq0SgOTcaH0h8=
X-Google-Smtp-Source: AGHT+IGWf4ZddWeRQzTw71BXkfALvBN0DrBRmplT/O+Zlfvmqif0y9vCudCemj2vWW5lhSfJONZA9g==
X-Received: by 2002:a05:651c:a08:b0:2ef:2e3f:35da with SMTP id
 38308e7fff4ca-2f03dbfbb32mr25159211fa.45.1721939381177; 
 Thu, 25 Jul 2024 13:29:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3c1esm1119263a12.78.2024.07.25.13.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:29:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B67595F863;
 Thu, 25 Jul 2024 21:29:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
In-Reply-To: <87wml9mdbf.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 25 Jul 2024 21:22:44 +0100")
References: <20240725154003.428065-1-npiggin@gmail.com>
 <87wml9mdbf.fsf@draig.linaro.org>
Date: Thu, 25 Jul 2024 21:29:38 +0100
Message-ID: <87sevxmczx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
>> clang-user job with an assertion failure in glibc that seems to
>> indicate corruption:
>>
>>   signals: allocatestack.c:223: allocate_stack:
>>     Assertion `powerof2 (pagesize_m1 + 1)' failed.
>>
>> Disable these tests for now.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.=
target
>> index 8c3e4e4038..509a20be2b 100644
>> --- a/tests/tcg/ppc64/Makefile.target
>> +++ b/tests/tcg/ppc64/Makefile.target
>> @@ -11,6 +11,18 @@ config-cc.mak: Makefile
>>=20=20
>>  -include config-cc.mak
>>=20=20
>> +# multi-threaded tests are known to fail (e.g., clang-user CI job)
>> +# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
>
> Given this is only a problem with clang can we only apply these
> workaround if we detect "clang" in $(CC)?

ifeq ($(findstring clang,$(CC)),clang)
...
endif

should do the trick
>
>> +run-signals: signals
>> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
>> +run-plugin-signals-with-%:
>> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
>> +
>> +run-threadcount: threadcount
>> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
>> +run-plugin-threadcount-with-%:
>> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
>> +
>>  ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
>>  PPC64_TESTS=3Dbcdsub non_signalling_xscv
>>  endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

