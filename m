Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF4C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZa4-0000jt-Df; Thu, 01 May 2025 15:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZZy-0000dZ-GG
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:28:19 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZZw-0000DO-Ba
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:28:18 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-86135d11760so111656139f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746127694; x=1746732494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lIT25lodBDqzC8QsLNZY/pbMkuQESJLFEJeOOfYgS7k=;
 b=KTfVlSVNYgbCkBJLW4AtJ9/ZoL9r7C/cAnvabz1bkxsl9L+4GEKUBXQ0pLUCtS0XE1
 XSjT+Fd2JctK6KhR/YEzeKFNZg9qTMytILzcZp9d++/p2jn3lmM6gHmw0jV5ZX0D9Iig
 N7X9hZmcdYCwPZ4cdbO0+Fw3rKT9szmpd+NHpmgs8CmGbNBDzy32d0MUkyrNWkvxtE3J
 8wpBEJHzSpke+aKUa2Wgt9U0ThTr+xdRYXumfpJELV3fB2RFQxcHLCmBkMjWZr6Khez5
 ibUU6G4YtrNBQ45Xz4Sn/kvf7ZZ7RfEp/gSpTtCfb8Dr0HiD9cpcXUQqZ1fAnECjUjQl
 qpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746127694; x=1746732494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIT25lodBDqzC8QsLNZY/pbMkuQESJLFEJeOOfYgS7k=;
 b=P6xWOa/NSSW4RRGyqsSzhNQpRq5jC9wDgqTMapB0rfP2B03Xb9AND3AUfs9+xNOtg0
 Ip6H25ZIPzZxZZnPr5MIAcj6kG77rLq2esqhLeCrxNaXjdISmVM1TbpaPzVePvt8O705
 kN7UKc0ikrxSnohZc/MWgZF3pcBU5t3nw2/J+elRagW+L4F+U/R4jdng50Yg8S+l18mV
 lJBqNVTnyLFw+m2wR2awonn2YzIvmt88SL+Hd6Z4690Eivf+/JTkTdMkY0wUFG9zTdG7
 eYS4JGNghP+izYUJ35FoPcTkIYNfVT5vAVIAGGzkAnHDtWPqvf181NNC6ds4L4zwHYvc
 0Zhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBBAmQ7i9aPK2uLYYwscSeEqsVWermRJr3jgEOJQTwBzCkzTrRBzgHYD8bwf3IxDh5W0kH62iIv8UC@nongnu.org
X-Gm-Message-State: AOJu0Yw7ytCU6dmtkHbv00cTZrfKbWsipIatf9T/C27AT8ik/T0NGNKE
 2HKKP43UfVW6XxDbkYwjfuLDveFOGEiVw9khe73QVQpg3iLOFVc/mKycp/8eiBw=
X-Gm-Gg: ASbGncsumg4imRzH+P7Y4LfEvSfBdj4FifCqvGH6zPU/2oXkfLlAjEpa4m70/vOwiq7
 4NpBQlNP53gHgfTQoeESNo6b2pGMWfYlBJ95Mrpu9UTDzrrTClrZLB5cKMl8sbM9XLrnjX+SHYq
 Bugko59xnCPrFyVGPOtN6irAyq/ymqOZBLKMxO+Pdhh2kiWNrwqV8iKFrrVzUMThLgqVq3wSM2D
 S9Ok1WSXV2bZeOWdrXlw9qcJmmkYWB+hADlpVe/IZTrau1hvwHdLgllsxkdJn5OHM/+k+zkCaiR
 kLupsnpZLtgrxG89opBsav7EYdOyZNPycT/GtCH1ytSP8QVRJeVchHHYBhdgojz4b70pE+mbX/O
 CG3Tj/vR9AQq0Ow==
X-Google-Smtp-Source: AGHT+IEoAXhkyPuNP0/8DAdoHy/HqssAna10I2RNVsH3pSdrPQk7pJA03PtTmN5jQqJrUcwb+a9PlA==
X-Received: by 2002:a05:6e02:12e7:b0:3d9:6dfe:5137 with SMTP id
 e9e14a558f8ab-3d97c19976fmr1707275ab.10.1746127694518; 
 Thu, 01 May 2025 12:28:14 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac80f6sm6839173.141.2025.05.01.12.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:28:13 -0700 (PDT)
Message-ID: <21b0915b-422f-4186-a6aa-c484f725bdc5@linaro.org>
Date: Thu, 1 May 2025 21:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/33] target/arm/debug_helper: remove target_ulong
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
 <e1afdcf4-a416-4742-bef2-352a9d184ea9@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e1afdcf4-a416-4742-bef2-352a9d184ea9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd30.google.com
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

On 1/5/25 17:07, Richard Henderson wrote:
> On 4/30/25 23:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/debug_helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
>> index 357bc2141ae..50ef5618f51 100644
>> --- a/target/arm/debug_helper.c
>> +++ b/target/arm/debug_helper.c
>> @@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
>>   {
>>       ARMCPU *cpu = ARM_CPU(cs);
>>       CPUARMState *env = &cpu->env;
>> -    target_ulong pc;
>> +    vaddr pc;

Why not directly use the symbol type (uint64_t)?

>>       int n;
>>       /*
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~


