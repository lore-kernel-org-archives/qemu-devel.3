Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBFFC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Pwf-00016w-Kw; Mon, 28 Apr 2025 10:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Pwb-00016i-4P
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:58:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9PwZ-0004xx-5v
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:58:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so3983725b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745852329; x=1746457129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HMnnQp3Qy3sSdk8cyhT47of0kYbAf1dAsOQz6r2tgEQ=;
 b=A6+LFBmaCIGjSBwDOcDJX7aaLvkO7ZhPSRJCvrP9B2IQbMSv0UeI48qHZJrCDAUQKd
 Mk5dOPnNLSGuS/cABeTuN4NGSzvbmXwBoowzzA5TBFOArjVJHZI/zLCjjaY7WK52agwt
 9GcrEnyBeM8/+1ODEWgaXa9NxmK2jMB6vtjGw2XroetALD2LDZ3mWKzL3zjGMzCqTvX9
 4iKTGD9sL8sFEbrsc0F08kD6GLzwVsQzpkx6hh9ffEdi7ONnkOtvTIcy9106iy5TyiUl
 H7aMLEB5E/AeSY7gbMLu5n2TbJFOGKiyq1/RY01dsK48+LItq0WVB05yn5JkhS6lLm0E
 BmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745852329; x=1746457129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMnnQp3Qy3sSdk8cyhT47of0kYbAf1dAsOQz6r2tgEQ=;
 b=UEgSM4KiEaoTQCMKcywZQsWTBx0VDu5IMFXRfLHdFHsx5jDrLZnt4hw4/KJAt3gAcE
 8R5MDvOrP+NZW5D4horSn/Sp5fQzedrNU5HYtQY3XKcPviF9Pi7DNFQHQ6ss+nog4kc2
 Sy+v94KD/8y0AC34zAuPebI5J8IJ8yY9Xs4zzj8+40PJD5vUJ5CX/r9F0zVycUujr4Sd
 hR4lHxum3K14SzIoFkQw0U0tBAZSPiEjeVWfXjtpbZXI9PWWGbXjDNkVOBLY60Jym9Vx
 wllj1vQLaaa7qrORKPNAYUEzWVGdbT0FtpOvZg21RXBrO3GW6TtC8rfHkpppJrxBf1q4
 uAPA==
X-Gm-Message-State: AOJu0Yz7nz2Bjr7Rt8L8t3viK+mKXcXeLHScuZUyU9TFywzhEiIBHk7p
 KPjBD4gQAvo6UT59SAXRZoDenm1HyH/MI1Tr0oqIUmghXTA4Tv7jL6YNMRwezHIfhzUpqvi4erk
 k
X-Gm-Gg: ASbGncvWD+V+2AauzRDbRcxfIjJIeiFlESVazHUFakfutThBPJW/KLJhzRHm3YdazBp
 g+WoV1QlHQtlMDiDA+YPVuX8iTylvpITMvP1bZO4cinH4RHKItsch9SLwUWvJqLqcqi/iyCZcmH
 Jp3JnpLx16d7xSVSEa7mW0QUa13thmrSoav107J3jYCA+xgzKqe8etgwEHV4lhsqHoxtCQMgL8y
 HKZ/aaagvitDwiGiQeiu9BtEVNN7QQ8+5Ab8jNg4qjWQ96ko+Zi/9MpPPXOdkVcA3PvytXlztKA
 S9w1+EQPiEOeLLOWfYrHpWdKIkW8RVYaPtylyAfMd6SKvMuq46LG/m2IPGoqHTmywxbpiEOvAeo
 qu7/SU6I=
X-Google-Smtp-Source: AGHT+IFbxq/lLe0tDWG6QI6eKu/kIBEiqG5j3JWoYh9Kl+8MptFA6RVfIb2OEcmskcb+n0SKCtkiHg==
X-Received: by 2002:a05:6a20:9c9b:b0:203:de5e:798c with SMTP id
 adf61e73a8af0-2045b6f519amr18357525637.18.1745852329366; 
 Mon, 28 Apr 2025 07:58:49 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7eb7914sm7276678a12.20.2025.04.28.07.58.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 07:58:48 -0700 (PDT)
Message-ID: <5ecee8bf-c340-4d7e-b47b-461c80ee9bfa@linaro.org>
Date: Mon, 28 Apr 2025 07:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/26] target/riscv: store RISCVCPUDef struct directly in
 the class
To: qemu-devel@nongnu.org
References: <20250428073442.315770-1-pbonzini@redhat.com>
 <20250428073442.315770-9-pbonzini@redhat.com>
 <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <30770d2b-ac76-4d13-b8f2-ca39c0b82e0f@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/28/25 04:50, Daniel Henrique Barboza wrote:
>>   static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>>       {
>>           .name = TYPE_RISCV_CPU_HOST,
>>           .parent = TYPE_RISCV_CPU,
>> -        .class_init = riscv_host_cpu_class_init,
>> +#if defined(TARGET_RISCV32)
>> +        .class_data = &((const RISCVCPUDef) {
>> +            .misa_mxl_max = MXL_RV32,
>> +        },
>> +#elif defined(TARGET_RISCV64)
>> +        .class_data = &((const RISCVCPUDef) {
>> +            .misa_mxl_max = MXL_RV64,
>> +        },
>> +#endif
>>       }
>>   };
> 
> Are we sure this patch compiles? As I said in the v3 this except opening 2 parentheses
> and closing just one after RISCVCPUDef:
> 
> 
>> -        .class_init = riscv_host_cpu_class_init,
>> +#if defined(TARGET_RISCV32)
>> +        .class_data = &(( <-----
>                         const RISCVCPUDef) {

I'll repeat that the parenthesis are completely unnecessary, just

   = &(const RISCVCPUDef){ ... }

The extras should be dropped everywhere.


r~


