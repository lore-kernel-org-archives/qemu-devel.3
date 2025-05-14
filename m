Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75127C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFSj-0008DF-BN; Wed, 14 May 2025 13:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFFSX-0007vT-K1
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:59:58 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFFSV-0006eX-SB
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:59:57 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b1ffeda9363so7141259a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747241994; x=1747846794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g3S4QE6pPmLrLEvlLvbVcXELDi040PZqynpaUxvCe/o=;
 b=S8CpU/LEgwDu3CmD6OZlOImrDFWuX5Mr2XnV1TAmk79rP9ow9Q0nhmBBOBbvnJshyg
 9JkuXHcN4O8xaGh3FA407W8qSZDMmBiYjXaW6TpsNCE47giPZbKNspe4LYdFEQVO1rrA
 CUgO/c7M4AlAMgWCK1B1nfnmzIZRobrvk9sQozd/g/bMeIne8ciTnQ6itvxFHJPengng
 //Qpud+DzOfwLfF5XEvKqxTsZJ4j49d/2GQRKB3cXC6DnPTL69yo/gt6RHXjIV0ND8at
 dsUUe4g13OrYC0m30gNW4feqeC1kl2NMdlSNiJgX4hgFfl6fslDdTyOcYJY5CDSt7IMK
 w2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241994; x=1747846794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3S4QE6pPmLrLEvlLvbVcXELDi040PZqynpaUxvCe/o=;
 b=jmLQD1USrbqbl/aEL8Ust9KIGnDxkzoAE5MS/Iy8JruE9Gj3xmendxeD9xJBEEB6kp
 8jxCIVfZrcuTnMiSEZE8kpYtZzHCs4rebxt6MVndcqBUx/cHlbM+XJ/fmIyINbxctOdk
 OQ4Vc1jWt9eYCnpKOEYimVvfrD1wz/fA7zHJ5257qAXAAR17k2W4zIKUNHQNQOON4Ghl
 Ns4DIbTG6uFp9X5rTQvpYYN4ZSRHQxvz45MD1KOAZO+PVLuhepfOuLLUZ21+9bQlAlgP
 Mi5Q06r7FOWt8n9tnA3ONSeQQLL+twC8aDNwAcW013awv3Ve9sybV8Z3E+qag0HNHkP6
 yEgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcpb6IMwfUfD4kVAyP7A9yjrbFxo50Ze7KZmj8GuAoJGNkxm8rT02E+5a3lElkYy6liqEGZTeKOEPC@nongnu.org
X-Gm-Message-State: AOJu0YziYOBLEnTZgrwUPIIn8Q5EI+NiDeKY4idvOnQffFUD4sswvYQv
 vSXx3+FHxDGk4OieZSRsoUbUE/UG8fcIKMXmb+lmVQtYRmxxnsQsUjhXunW+4u0=
X-Gm-Gg: ASbGncumXR56jirAItuGWkh77lL5eIbL5+fTyZF1mBrc3XTJIa4eexAtqUEaQEazSGT
 qAbaA0gQ/luRMNaMk5vmHvEm3XKhp86/tXXllJHD2Y+lhyvPqoo7ApTcOI8ZR4EM89yZdruRqKn
 UGgpNjAd41uRX6iBx+W4xm520jKDKpfqvdfWUsXCa/8dNM7M4gLq0k7F0bmp5CeDG+Z5fBFZJ05
 YdM5IHDE5c2+puz4hr0hmkNcBpsKTVFPdl76NlvaQlKmX+vSdUDX0zZo1U1DMW6CcQugLu0S8om
 cbGvJRRfYBqp2L8ZLGaemYFkIa7T+YDlnQ+rlySRtzlFteXmyE+IPbLSlyieyB8G
X-Google-Smtp-Source: AGHT+IHo9bOBsAz6ft5k4LVrImzRL3Plw35Cq+JcMCPF7f3WwrSdD8GmjkJSIIFcsrWCro/ID8nJlg==
X-Received: by 2002:a17:90a:e704:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-30e2e62fd2bmr5984474a91.32.1747241994192; 
 Wed, 14 May 2025 09:59:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e334254f5sm1822292a91.13.2025.05.14.09.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:59:53 -0700 (PDT)
Message-ID: <59b1ccbe-9ddb-43f0-98c4-8000a08d27b0@linaro.org>
Date: Wed, 14 May 2025 09:59:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-17-philmd@linaro.org>
 <b6c81748-091b-4d61-8d34-beaa0442aab3@linaro.org>
 <f7bcd8b2-2c0c-4907-8a0e-af172c235d56@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f7bcd8b2-2c0c-4907-8a0e-af172c235d56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 5/14/25 9:53 AM, Philippe Mathieu-Daudé wrote:
> On 14/5/25 10:24, Richard Henderson wrote:
>> On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
>>> arm_cpu_has_feature() is equivalent of arm_feature(), however
>>> while the latter uses CPUARMState so is target-specific, the
>>> former doesn't and can be called by target-agnostic code in hw/.
>>
>> CPUARMState is no more target-specific than ARMCPU.
> 
> ARMCPU is forward-declared as opaque pointer in target/arm/cpu-qom.h,
> so we can expose prototypes using it to non-ARM units.
> CPUARMState is only declared in "cpu.h", itself only accessible by
> ARM-related units.
> 

Maybe we can simply postpone introduction of arm_cpu_has_feature() when 
it will be really needed.

Patches 17 and 18 are not strictly needed, as cpu.h (which resolves to 
target/arm/cpu.h implicitely) is perfectly accessible to code in hw/arm 
without any problem.

I asked in the past if there was a real need for this function, but 
didn't have a clear answer on where it's mandatory. In this series, it's 
an optional change.

That said, I don't want block any work arguing over this, so if you feel 
it's better to have it, so be it, and let's pull this.

>>
>> Did you really mean to use CPUState?
>> Or is it merely that arm_cpu_has_feature is out-of-line?
>>
>>
>> r~
>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/cpu_has_feature.h | 2 ++
>>>    target/arm/cpu.c             | 7 +++++++
>>>    2 files changed, 9 insertions(+)
>>>
>>> diff --git a/target/arm/cpu_has_feature.h b/target/arm/cpu_has_feature.h
>>> index 2adfccd9208..352f9d75bed 100644
>>> --- a/target/arm/cpu_has_feature.h
>>> +++ b/target/arm/cpu_has_feature.h
>>> @@ -62,4 +62,6 @@ typedef enum arm_features {
>>>        ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
>>>    } ArmCpuFeature;
>>> +bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature);
>>> +
>>>    #endif
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 8c9d161f2ef..759636a3b0e 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -54,6 +54,13 @@
>>>    #include "target/arm/gtimer.h"
>>>    #include "target/arm/multiprocessing.h"
>>> +bool arm_cpu_has_feature(ARMCPU *cpu, ArmCpuFeature feature)
>>> +{
>>> +    CPUARMState *env = &cpu->env;
>>> +
>>> +    return arm_feature(env, feature);
>>> +}
>>> +
>>>    static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>>>    {
>>>        ARMCPU *cpu = ARM_CPU(cs);
>>
> 


