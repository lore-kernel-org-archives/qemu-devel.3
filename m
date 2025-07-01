Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F15C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWY1I-0007ii-Ct; Tue, 01 Jul 2025 06:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWY1G-0007iN-Aq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:15:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWY1E-00040L-5T
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:15:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453066fad06so36804155e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751364911; x=1751969711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aCAWKACQX2fPUuLCEOQi2kKR8kfTCXZQfgtxYqfJhnQ=;
 b=lzCfpkte7Q+MG5f8zz8vG7HF/X9fQ5G53fIBIBTGku2dQNPxu8nocmmtF0e0bRbHf1
 oP4x8lWuQfltlJlw/aLfkib7cU29JNOUB2zEb4VbsRRDKLt2se9/G2UNW+A1rZPjDzR2
 q7CMvYMOQ9T8SE5LRZHK0JmB1UbpDuAhtxVkpkCE3OVty+OpaX8bd0p2Zn3ntvAxE15I
 1fPM23heyfYG0wqTQKsNIdYl/YhT7d1Vw3eytuMTSmUBKLlmcpdGJUFB2Sm1hF23PL/7
 HvD0V83I/PbiXm+KoQ7Piq57j7ybfv8Av4I4VWr6iNUfbtkZXbQ/Cm4iM2CMia1OY0CB
 rStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751364911; x=1751969711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aCAWKACQX2fPUuLCEOQi2kKR8kfTCXZQfgtxYqfJhnQ=;
 b=mUXQLS7cp/Q4tiPVGegx0+Drp92qJuLt+7WN/qct9jpPhAVdrUfiZroMvHyNlVQhHz
 H5hZn3ibmlA49PRzeNusNPtAT7V3xWKwB32fXV1OQreghnlOxe/mrEwR6G4oeLpZp0Tp
 WTJJEtijym5wMhRnrWE3pJBKXu4ddCHCLcIrS4ifKGSOHMUYBR0oG/yGRI+f9F1hUtnP
 8mehOR1IUZFfExb2d8jGpJo8ho9Gywcqv29Hu6XAAvoulUaYqVtqghCpk4yras+YGdaL
 1gvaFUex2xrlKLHeDgk0QNrgKKblwVyskIcG9AD7/71dlgbjLutjzn2n5L8ZyoRd1oWe
 SN1g==
X-Gm-Message-State: AOJu0Yy23ES3Fw03uF4yYhH/5yVzvVDBsLBvMhsAMgaHGQi/Ra4oRQWY
 HEnCcfU3Gfrt4d7MSlOTF7U1S8V4D1ZNbRv3DkjomtuBGh/hVJRsLYRjwaXYLSeRKTg=
X-Gm-Gg: ASbGncuoC11uJZUb68kQ2k7MVIT2IS42c39oIzLXT5SN0fcRgH2VTj4/D4rESlhbLLO
 1jKbdtyoSk6GbtxMDlQgNc/Ct1BWBhALIALeUYf+dKlFzYOonXyb4DJXn7WT7SrDjJK8zOhR619
 LYj2m1dbGjPsqYSWdEkPfajneU+O0bDKHyaj7qAt5zwNthsvjk+LMtrxA/dh4JD8+DSQYGQTorO
 srMBZpSOlc/1uzJWqZZeeDPLehuC8jXM/UjAUlkp26PRq3IaTtkDe3Rqr8c2AEC2gn3ihUufiZe
 Gb19GqltqsubH9XoRbWmZYP9vcrYOj3h56CxkqlAcVwHJhfH4hnBFPloO3OmJU2TVxIi8zAu6X0
 BrmdrxTYcZbcNWsi4RjHcca/oUCWawQ==
X-Google-Smtp-Source: AGHT+IE2TIUCu3tWDUhYMKR2RX27xn19+zw/Sg/ImtPMtPrU5FOrGBc29LXE1pvk/a3tWyk20y/Jvw==
X-Received: by 2002:a05:600c:4f46:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4549ff26757mr11446845e9.16.1751364911092; 
 Tue, 01 Jul 2025 03:15:11 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad0f3sm194858785e9.19.2025.07.01.03.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:15:10 -0700 (PDT)
Message-ID: <34fa39b2-fc0a-4d3b-9a3f-4888d02bdebc@linaro.org>
Date: Tue, 1 Jul 2025 12:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/26] target/arm/hvf: Trace hv_vcpu_run() failures
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-7-philmd@linaro.org>
 <CAFEAcA9ref1SFd2uPRBBjyg=eph+GptWxoyURxMZj8aSVD7zAg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9ref1SFd2uPRBBjyg=eph+GptWxoyURxMZj8aSVD7zAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/7/25 11:49, Peter Maydell wrote:
> On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c        | 10 +++++++++-
>>   target/arm/hvf/trace-events |  1 +
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index ef76dcd28de..cc5bbc155d2 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1916,7 +1916,15 @@ int hvf_vcpu_exec(CPUState *cpu)
>>       bql_unlock();
>>       r = hv_vcpu_run(cpu->accel->fd);
>>       bql_lock();
>> -    assert_hvf_ok(r);
>> +    switch (r) {
>> +    case HV_SUCCESS:
>> +        break;
>> +    case HV_ILLEGAL_GUEST_STATE:
>> +        trace_hvf_illegal_guest_state();
>> +        /* fall through */
>> +    default:
>> +        g_assert_not_reached();
> 
> This seems kind of odd.
> 
> If it can happen, we shouldn't g_assert_not_reached().
> If it can't happen, we shouldn't trace it.
> 
> But the hvf code already has a lot of "assert success
> rather than handling possible-but-fatal errors more
> gracefully", so I guess it's OK.

OK, you can drop this patch: I will replace with error("unrecoverable:
...") && exit(1); to avoid such oddity.

