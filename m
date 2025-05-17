Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C875C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 19:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNPb-00066j-0K; Sat, 17 May 2025 15:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNPY-00065C-HV
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:41:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNPW-0005td-SY
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:41:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-231fc83a33aso8520015ad.0
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747510889; x=1748115689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yCA0eR4SFMaZLv6uXNut1Hv8EQWRppbABh9ELNgVTwM=;
 b=QYu4+2PfE/WS4b1rHP26ITXXT6e6BdpzZCTBKQrVV50mrvLg1Y73H5O9hG7IPtdIC6
 +zyU0JdFi6A2D9vmK+2z3tt4gmEolD/iNCwhq4zZAiIwlykO41A4+qXlyzUwmq5C28wx
 fRFrpTegKPce8v1BmFxasHKHvTHeVAeWAZrqSN+dzzNlc6RVN80/Q69ECEhiM4SUt+4m
 qqfebN0nB9OzDWzMUtzjfo980YbcPTehmvCCBEu88RlRAiKLfmhenx8aJpFhb777Hx4f
 Bp/jilHzpfBiR8aozmZUs2yPTXFIC8ozzkKx/jD5minAOYgI9L1AVkwdeX1pLlXAtnOw
 pKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747510889; x=1748115689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yCA0eR4SFMaZLv6uXNut1Hv8EQWRppbABh9ELNgVTwM=;
 b=VJc8f3JmHAwrTdq5a4MYht+AWnrhvWQqhZmwA53KhKt3SHA6CygckcfP+k6gRR6Q+Y
 7rAM7jlP4dDW1CxW3BPyqwEJcNkA4dsx2myJEK7m/ENpdza34Wf4df27uFeVNSJykqz6
 ojo3b3qX2jhM+4wUH/7AWbrKh/58vxTyaoZJySGP1FGy42GBhofIEioTosWGAU8zSGrL
 VaV6ce9y/nolLfHBrKMYSQC28I07HmGJGer7fYP42lsQuZ7Mwz6FftMpH6VHwXk80JvS
 pJ5iWnLMZ7JS5NyhPWqUkCzuh18fWlrXKTmnxpQ2JzjQG9W8OMTEWVbXplzDHuMzge1j
 40Nw==
X-Gm-Message-State: AOJu0Yxy06E1p62iZ/khWfUb231mnVVvlWs7H1yqsud3+mAE/bg2fpOe
 P/LGIr6CrcGaL37OtkNK6d1FEQNILFgYgJn8gZh8wOwXW4dEAULTi5Jd2//Y3dEBK5k=
X-Gm-Gg: ASbGncty6X91XRlj44B98ay/l5Mhpb2TossX1OoyBDggAXDBXBNI5wW9hs1CeOa5tLe
 sOtNY56iok8hQIfCEQ2Zrpi0r+GdtN2D7jv1EqQGu13bnMl1n0iFEH1FyybszOR4h+oljgsOz+S
 LSwhXWbs95gfPmK1tddvTefsApAroPmBQ1Ra9EA0fabsJQadGf/b1gs6rrTwf/GBe6bBSvgAmPQ
 qGbZz2lDuvkZknCXX15tIsYZ9f98k/VCiMaJg/k2aLxl7KoUpzcppDPj3QGz7YPmlrZQ7JSME5W
 bkjgEua8JLx6cgzKXMNdfIJB+p/nPTYDXZaVlElKeQ4O7iEeROFgM/Ed6cv87Cod
X-Google-Smtp-Source: AGHT+IGnNdYevXYCJ6ViCYCM+uMQ2FXxnlJQcjG2+xwzswTTr6R9hEQWmMgpFtwAA0jmz9o0EO/UBA==
X-Received: by 2002:a17:902:f54a:b0:224:1eab:97b2 with SMTP id
 d9443c01a7336-231de3baf53mr104130605ad.53.1747510889286; 
 Sat, 17 May 2025 12:41:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adba6dsm34118125ad.68.2025.05.17.12.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 12:41:28 -0700 (PDT)
Message-ID: <6821ea3c-2863-4e8c-9d21-d7885f82557a@linaro.org>
Date: Sat, 17 May 2025 12:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] qapi: make most CPU commands unconditionally
 available
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-10-pierrick.bouvier@linaro.org>
 <87ldqvojxj.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ldqvojxj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/16/25 11:00 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> This removes the TARGET_* conditions from all the CPU commands
>> that are conceptually target independent. Top level stubs are
>> provided to cope with targets which do not currently implement
>> all of the commands.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   MAINTAINERS                           |   1 -
>>   qapi/machine-target.json              | 522 --------------------------
>>   qapi/machine.json                     | 363 ++++++++++++++++++
>>   stubs/monitor-cpu-s390x.c             |  23 ++
>>   stubs/monitor-cpu.c                   |  21 ++
>>   target/arm/arm-qmp-cmds.c             |   2 +-
>>   target/i386/cpu-system.c              |   2 +-
>>   target/i386/cpu.c                     |   2 +-
>>   target/loongarch/loongarch-qmp-cmds.c |   2 +-
>>   target/mips/system/mips-qmp-cmds.c    |  12 +-
>>   target/ppc/ppc-qmp-cmds.c             |  12 +-
>>   target/riscv/riscv-qmp-cmds.c         |   2 +-
>>   target/s390x/cpu_models_system.c      |   2 +-
>>   stubs/meson.build                     |   2 +
>>   14 files changed, 437 insertions(+), 531 deletions(-)
>>   delete mode 100644 qapi/machine-target.json
>>   create mode 100644 stubs/monitor-cpu-s390x.c
>>   create mode 100644 stubs/monitor-cpu.c
>>

[...]

>> -##
>> -# @query-cpu-definitions:
>> -#
>> -# Return a list of supported virtual CPU definitions
>> -#
>> -# Returns: a list of CpuDefinitionInfo
>> -#
>> -# Since: 1.2
>> -##
>> -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
>> -  'if': { 'any': [ 'TARGET_PPC',
>> -                   'TARGET_ARM',
>> -                   'TARGET_I386',
>> -                   'TARGET_S390X',
>> -                   'TARGET_MIPS',
>> -                   'TARGET_LOONGARCH64',
>> -                   'TARGET_RISCV' ] } }
>> -
> 
> Stuff deleted above is added to qapi/machine.json.  Okay.
> 
> Stuff deleted below is gone until the next commit adds it back to
> machine-s390x.json.  Build fails.  Oops :)
>

Thanks for catching this!
I'll fix order of deletion, and make sure every commit compiles cleanly.

Thanks,
Pierrick

