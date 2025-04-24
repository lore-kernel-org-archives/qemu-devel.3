Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0E6C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83hm-000373-B8; Thu, 24 Apr 2025 17:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83hc-00033m-JH
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:01:54 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83hZ-0000UA-Mp
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:01:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so1513313b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745528503; x=1746133303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mC5mET4uLYjhDaXp53Ol0DTEjz0Yxq8K22g6MPL+v6g=;
 b=qIlb+HWBNzyG+5Hwm7tLU2wKyBcfqA01BOTlBcllLHJKgydrnNWaVnKGCVPgZ6g4hB
 t/RRXjut1rZM5YB2Vx/CUeFIbN/2Uzyu8ZPXbiqmU5tcxgXjRt9Q4xbXnSzVAu3kYTEa
 rfzr4FfFC/Tbl90fXgLpAaHbzOlLJEj6lplDbkwMQGFAlxjU92Vq9U3xqkyaIqfwk6jh
 W58HllfuEySf1SGP8naTigPSONDxjYCLy/TxxxJKGLmv8xoPm8SU56un3GIOepw2Txng
 SdJPahB1ImKUhx7JCAxsIA8q2U08ZBPYWZk8NuNEWNeDn1Qcl/JdC//DR6HGpfiGcAsU
 uuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745528503; x=1746133303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mC5mET4uLYjhDaXp53Ol0DTEjz0Yxq8K22g6MPL+v6g=;
 b=v7TsFaRjW2D3TSCd+0pYLSrIoc03pfhm3Ro+GwQ26rebdiqBMbr2x8rPFn9PmfwmIe
 HT0WJWqBcKEmpfJ+gihU4dWmYLsjYMdUVDvF+EtxdN/KcepLPqCPYVzmUKGbiWBC44ZH
 4GyvOgxdwmWrdVtvUe6K0mQbmXi46W+FbOsM2xYFpPIJKPBbUaf0AlBFpKz6VZ1iSHKq
 7s7o47qr2C/sfyQVijHu8kGJQSi2LKm0hRfxcyLPu8tzBiODu0ysgR5lCCgHk9gwKhx0
 7dPq7PJKmiHvipSEoawAYDVHowfEUAhT9uzJjG2conGlsDRhB1kytWyLLm2P6fECeNJh
 S7Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/S9clEf+4fNdRZUhrEMNs9C1TMgjUseftlcEWjvIMZftUbX+pIJkAPVBLVvtnzvuqMf9hgAYwV4L@nongnu.org
X-Gm-Message-State: AOJu0YywIRyjXite0ra1jyQGWXu0ZtqaW3zUIWpatCoMI6hkOfIEoWJ8
 L0myS2fcH+KQu8rZNd+36D7BIyekIjNfPLcyUcPyyh+q3KYBQIlJ/ZM9hz///R8=
X-Gm-Gg: ASbGncuG/1ZgYuEaq3UkvqFbi1zk3R1wnRK/B0wK/QT1czL+Kj5B3QbOIvmcfdefe7H
 ZdFIKmo3t55Rc96nO/HKICWgwgZbWaUn29qnI2cZHvrkic+JOJKsqlOZ5y9t71+JMhOH2YI9Vh4
 kVBFTyUoi1eyWq8qzjZV6ReJRBElixJ7XUrzV4F8W07TJVT6z0eRWCQw1C0+Pf+A8cvyxPt5qsG
 sKPcOTT8+ooWxJqMNApmoQFCeIaguUQA/0oGCVkt6VOgsHyKIvYeWLfw7cRuZIphnjsKtUmjowV
 ROzYxlRMXZ6tlwgb1pLllMnXQLxrSCtkSY6CCp4LRd+4+3ybS7FInVKP1FSn2jlEtfrhVUvbkEi
 MQWJRuxzLXPzS1BgbZQ==
X-Google-Smtp-Source: AGHT+IGopFHwevDxSGC4cCmhyW0nJkiVmSwGZC/6S6tJDm25uSa2zjwaB9ZQbNnxVEy6KxiJ2VpZSA==
X-Received: by 2002:a05:6a00:2e9d:b0:736:ab1e:b1ab with SMTP id
 d2e1a72fcca58-73e32d6571amr1591296b3a.0.1745528503598; 
 Thu, 24 Apr 2025 14:01:43 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25964e38sm1879371b3a.75.2025.04.24.14.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 14:01:43 -0700 (PDT)
Message-ID: <431dce61-4cdb-4bf6-98f8-d2ac714a1ab6@linaro.org>
Date: Thu, 24 Apr 2025 14:01:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] target/riscv: Include missing
 'accel/tcg/getpc.h' in csr.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-8-philmd@linaro.org>
 <9f71ab55-523e-4720-aa1b-2b3271038df5@nutanix.com>
 <ebd88b93-3752-4e18-b5c0-78e3b4a4b8e2@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ebd88b93-3752-4e18-b5c0-78e3b4a4b8e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/24/25 13:13, Philippe Mathieu-Daudé wrote:
> On 24/4/25 12:14, Mark Cave-Ayland wrote:
>> On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:
>>
>>> "accel/tcg/getpc.h" is pulled in indirectly. Include it
>>> explicitly to avoid when refactoring unrelated headers:
>>>
>>>    target/riscv/csr.c:2117:25: error: call to undeclared function 'GETPC' [-Wimplicit- 
>>> function-declaration]
>>>     2117 |     if ((val & RVC) && (GETPC() & ~3) != 0) {
>>>          |                         ^
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/riscv/csr.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> index c52c87faaea..13086438552 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -28,6 +28,7 @@
>>>   #include "exec/cputlb.h"
>>>   #include "exec/tb-flush.h"
>>>   #include "exec/icount.h"
>>> +#include "accel/tcg/getpc.h"
>>>   #include "qemu/guest-random.h"
>>>   #include "qapi/error.h"
>>>   #include <stdbool.h>
>>
>> I'm mildly curious as to why the target needs to include accel/tcg/ getpc.h directly as 
>> it's almost a requirement for TCG
> 
> Indeed. There is a TODO around, added upon introduction in
> commit f18637cd611 ("RISC-V: Add misa runtime write support"):
> 
> 2113     /*
> 2114      * Suppress 'C' if next instruction is not aligned
> 2115      * TODO: this should check next_pc
> 2116      */
> 2117     if ((val & RVC) && (GETPC() & ~3) != 0) {
> 2118         val &= ~RVC;
> 2119     }

Yes, I've sent mail about this bug at least twice.

r~

