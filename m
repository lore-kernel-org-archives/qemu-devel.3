Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0C4C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 11:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnyeU-0007F2-Ff; Fri, 28 Feb 2025 06:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnyeR-0007Ec-KM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 06:35:31 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnyeP-0003rI-SP
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 06:35:31 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f5fc33602so1280016f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 03:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740742528; x=1741347328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUnP+rHeLe7e9aR3jQWR4LYTcuWyHFNuHhWwDOLRkbQ=;
 b=hh090XSHXVCVBia0rwPNwhwpUGUkGGYMEmllUqzQSnTTPuT56R0D17GZSKSWsCbHtr
 jtQHOCyn4uxPYdxXvsHanSLTmp6kPGPQaxbXGket53qgCnzDhBdS1TSmyf2jQkGLt9GI
 RTgEWY4ZkO9kiNxI69MjsozGdlZ6HdepJ/KLAxmM6IukF8BBffJHoyxHwdIPEeuJeVPH
 kyQfCv7b8fKGAsxKEYhznx3OiXxtqhVoPZOYvka6W9BGIRl2DynLfyt/3e59tpQ6yGXf
 KEy+wHujBPZogNFOQL0ks5uDwOq/2iSUprNxzl0r3Fq22iakpwWU9YZgj3BI9EjghQat
 85Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740742528; x=1741347328;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DUnP+rHeLe7e9aR3jQWR4LYTcuWyHFNuHhWwDOLRkbQ=;
 b=CoAFO3+3pWsmZoFH6they4ZCINij2AwNxhufavmiz72UXBn7GeVWZ7nzguFQ9jdyp+
 62LHz4tltYsXkT6avft7l18FrYgMIb6Cqudtm1YindTrh6swnw0/Gi9dQPKXqcSLw2uO
 al8qTAs8LRa3r2qTMHbNdKJLeNQrFnn594o54BSUApM7iMe9ajJBF08uxNmOpW4O7sBM
 j5BbDabswDuwcNlTpO1ggA168CMvPxkZDUpj5qo+E/3SZ5b0a7TLhlF55MW3wsfQdMFr
 yZDX0ZEOlrgYw+BHmkwTNqFuN0amMq/HdpGmWycCDnEIf5xOMHuBnuynQJbgg9pHvD+F
 bz3g==
X-Gm-Message-State: AOJu0YyCDqV5vWRWBZTH/qVAq8wHPmgFhy/D+YIWC61CwT5PfB03IWNT
 ZS0bj4WlxRq3QH1mTeagVPVTxR7nwzNIe38sJZvSz1p+/icNRcquQAIyd212w90=
X-Gm-Gg: ASbGncukUGpXl5huAFtWnu+4K61naCc2StQDuxdDECdYdGQohn57A8RILqlCNNtWZrO
 IpRphPH0PlekLp1SsAs+joJ4baVaZuyXD4Tpp727ITNV0v5wwAgiqpdtKzhNYkGZGVd6v3wD9N8
 7Zihm02NzusqsmJB5EjlwHe92DMduV2n0ft31JYftUnCQ0F4+YPCn2qpZiQh07NgYtS8BetwsO7
 Rx/Zd5kSlZSZAQmJSgBpacZsCB+kD2awJLNorbokE3X970LB3vYrPuePktem8PmtdWondL4Ns3G
 KPfViqUJjVdg7k2tZk89tnuXWg8Z
X-Google-Smtp-Source: AGHT+IGZ2sJlmRSTFrjObtKRrfXufEJ9frfKQiCeOTKtHGLo76l4/JQXw31G409b4A9mpSZ0fpRsTA==
X-Received: by 2002:a05:6000:2c7:b0:390:f0ff:2c10 with SMTP id
 ffacd0b85a97d-390f0ff30camr1565895f8f.19.1740742527746; 
 Fri, 28 Feb 2025 03:35:27 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844913sm4997462f8f.66.2025.02.28.03.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 03:35:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24A7E5F7DE;
 Fri, 28 Feb 2025 11:35:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 13/25] tests/tcg: fix constraints in test-i386-adcox
In-Reply-To: <5facb17d-c559-46df-be17-b37d22a212bc@linaro.org> (Richard
 Henderson's message of "Wed, 26 Feb 2025 09:26:24 -0800")
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-14-alex.bennee@linaro.org>
 <5facb17d-c559-46df-be17-b37d22a212bc@linaro.org>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Fri, 28 Feb 2025 11:35:26 +0000
Message-ID: <87y0xquwsh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/26/25 06:03, Alex Benn=C3=A9e wrote:
>> Clang complains:
>>    clang -O2 -m64 -mcx16
>> /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o
>> test-i386-adcox -static
>>    /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: erro=
r: invalid input constraint '0' in asm
>>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>>                             ^
>>    /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: erro=
r: invalid input constraint '0' in asm
>>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>>                             ^
>>    2 errors generated.
>> Pointing out a numbered input constraint can't point to a read/write
>> output [1]. Convert to a read-only input constraint to allow this.
>> [1]
>> https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036=
.html
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>   tests/tcg/i386/test-i386-adcox.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/tests/tcg/i386/test-i386-adcox.c
>> b/tests/tcg/i386/test-i386-adcox.c
>> index 16169efff8..b56dbc00f2 100644
>> --- a/tests/tcg/i386/test-i386-adcox.c
>> +++ b/tests/tcg/i386/test-i386-adcox.c
>> @@ -28,7 +28,7 @@ void test_adox_adcx(uint32_t in_c, uint32_t in_o, REG =
adcx_operand, REG adox_ope
>>           "adox %3, %2;"
>>           "adcx %3, %1;"
>>           "pushf; pop %0"
>> -        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
>> +        : "=3Dr"(flags), "=3Dr"(out_adcx), "=3Dr"(out_adox)
>>           : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>
> Alternately, drop all of the matching constraints as redundant.
> That's what "+r" does, anyway.

You mean like this:

    asm("push %0; popf;"
        "adox %3, %2;"
        "adcx %3, %1;"
        "pushf; pop %0"
        : "+r"(flags), "+r"(out_adcx), "+r"(out_adox));

Because that breaks the test:

  test-i386-adcox: /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.=
c:33: test_adox_adcx: Assertion `out_adcx =3D=3D in_c + adcx_operand - 1' f=
ailed.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

