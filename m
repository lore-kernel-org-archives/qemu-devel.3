Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7F5C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 05:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucdxI-0002j4-I8; Fri, 18 Jul 2025 01:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucdwr-0002gS-4v
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 01:47:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucdwo-0004yg-Uy
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 01:47:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso1362277f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752817672; x=1753422472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=baqikEA6Bt2DPLQkQCy+8M2l3qcydKPQYEHK1DQGKTU=;
 b=cv9xXWcsL/v4K4vFlfXN5yCcxU55/UH9xYGT79tkjqgUeq51b+3jOB3l18bSpVlaWv
 MlSblXnUaBvH6L8xtpv0vctLFIUtzBLsoizQmrENetNwGKfwhedJjdTH+sswkMoVxJF8
 u0kKtIS0/1yHtEj66cgqHNukgv8Akmne06kqVYI2dA1ZLBHtjNETb5EsOFbXuRQQlzZY
 2PBkVoDzkftmVHyxhnOe3Qu/ZEE9v//EsFoPWqJpzE3gkwPtIZihvQWAhKyClhvAlPlz
 frc47q5Sku8vSr9JKB93BAmfxZW29t4d2nXxMmISErz3OhBaQxrPobZGvTxzTKTKc0VS
 YSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752817672; x=1753422472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=baqikEA6Bt2DPLQkQCy+8M2l3qcydKPQYEHK1DQGKTU=;
 b=Calb2v1B3JEqWz69G62pGxW6n+olXaUp8GYGIMOzzUmDh0AVzutWzNmraSxK6Wala9
 b8DN2UgsjNS4RYarxHOoe8+JYX4YorvwMUKTl/cSq3KTXPEYqBpDmNC0+3TB1e49Whlq
 S2pL/Lyl7Id8Fw1io7vi7Wj/SSuCN7hQiNHdjmw7mkp74dMZ0ZS31VWgxUb0i7M3qsGu
 5xBpZHEIf9ghpDTmC/4Tv2qqk5I/dQA9Edv6gz2s7nU4yWUGt0KNKEVV3v/pJdO7lTU1
 CWAhhM6kkJDVEjC1C1oWrWl9mNCy2OvI9/rSSogQ2+3q0WiEuhJupKkxtFU7VWJfvXPp
 HHlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp552gXusaJg87l6Mmgn6gIYq2H8jVkCSDMa+SGLe9UHjz0oHhzwNaAQGt5IokbijkDDL7ZAlG0QyA@nongnu.org
X-Gm-Message-State: AOJu0Yz7GVAlvcvhi1aLfHz8aUkBdn7flKxUj4zNeUDFIcj8GZKOIER4
 Rk0WzQBgCaWZp19fQPXK4RDGjZRFnKdi8MPPSWHJ2x7qywnyksiuqHT1STipEI6GRJ8=
X-Gm-Gg: ASbGncusy19H1Oxj03Iwz8o2fYxu0cCNWrRqP5qrx0tC0moKjkVKCp7XlbKTSXlT1Mw
 u3b2oijxPSoYjgJdmZUnjlPEZ9a1xfMqYDOX2tR6yb+iH2EHE+b37pwd/rFSfHQ4NBEH6Z/TmEX
 fGZWm/ouYi7FAVdYIkFKUmL0SBy7Peh1Z5smpXHtKyWnE/mnCcSvSC4iniCzw5nfAdIaiJgZATr
 8+yYhQLMLYMFTS3fQaFQyBoiKMMKkXB3CgRaVuTrqNHUJtq/fOoDZBTWlZRVXeACssmygwc5db/
 Pu4R4KOrM9Vdrc0wSWKu1ze7rcjBmNRMHH2nRww9kHyFcWOqdocby4wM4XpT880Tz160CDDXAOU
 6LiygoqTyss/bifUyXt9DE9/TetZ3lk4snsWEi0J7zup98tov/cCUScu+gucyTsaBeQ==
X-Google-Smtp-Source: AGHT+IFueJ+RJmVjsiwJ0yJcrpa9ej1WlGLYZoVYql5jbSGfdUyV2jZhvBIltr3sQdLEyzKdJIb+xA==
X-Received: by 2002:a05:6000:2c11:b0:3a8:6262:6ef5 with SMTP id
 ffacd0b85a97d-3b60e4b80a6mr8265560f8f.10.1752817672401; 
 Thu, 17 Jul 2025 22:47:52 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b74ed25sm10000365e9.24.2025.07.17.22.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 22:47:51 -0700 (PDT)
Message-ID: <45123543-91ab-463d-800e-04899d699352@linaro.org>
Date: Fri, 18 Jul 2025 07:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 37/42] accel/hvf: Emulate HVC at EL2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-38-philmd@linaro.org>
 <4bd8e983-d10f-437a-94fd-1cda26478e56@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4bd8e983-d10f-437a-94fd-1cda26478e56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 22/6/25 05:28, Richard Henderson wrote:
> On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 3907ea8791e..a4f823f834d 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -17,6 +17,7 @@
>>   #include "system/hvf.h"
>>   #include "system/hvf_int.h"
>>   #include "system/hw_accel.h"
>> +#include "system/tcg.h"
>>   #include "hvf_arm.h"
>>   #include "cpregs.h"
>> @@ -1117,6 +1118,8 @@ static void hvf_raise_exception(CPUState *cpu, 
>> uint32_t excp,
>>       env->exception.syndrome = syndrome;
>>       arm_cpu_do_interrupt(cpu);
>> +    cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
> 
> Why is this needed?

Left-over from previous intents, indeed unneeded.

> 
> r~
> 
>> +    cpu->exception_index = -1;
>>   }
>>   static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
>> @@ -2090,6 +2093,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>>                   /* SMCCC 1.3 section 5.2 says every unknown SMCCC 
>> call returns -1 */
>>                   env->xregs[0] = -1;
>>               }
>> +        } else if (tcg_enabled()) {

As you noted you last night during an epic debugging session, since HVF
doesn't execute the instructions but we get here being trapped, if we
are going to resume under TCG we need to skip the HVC call (otherwise
we keep looping over it) with:

                 env->pc += 4;

(Same applies to "Emulate SMC at EL3" patch).

>> +            /* FIXME check we are called from EL1 (so EL0 -> UDEF) ? */
>> +            hvf_raise_exception(cpu, EXCP_HVC, syn_aa64_hvc(0), 2);
>>           } else {
>>               trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
>>               hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 
>> 1);
> 


