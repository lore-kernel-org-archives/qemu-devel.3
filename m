Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E27C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u82xA-000678-A0; Thu, 24 Apr 2025 16:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82x7-00066b-RB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:13:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82x6-0003zU-0B
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:13:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so865377f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745525621; x=1746130421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63zJrrW2qVN9BBMzZsGmSJtvdOThXGUiHQO85Hff6Mw=;
 b=kc9Yj2ahKMPmqPI2NZ6eSBbvfbRZ1vfcHNXTLRZ9mHsrZAlHe7ZgBP17WqHnxVdVW4
 JN6lyp5C0FBKa8tCFd7RqbRkTxg7uxFEBt/F1m5E2qJmTM3jgx8iMi/AdkkK4eFVkQQC
 vZ3Vn79aGStLrgbsTIW0yzyj2JSKBx+EDHtYXiKUQElvkkpfGd5SIGeMXeujh32gedmP
 Uk5R3EtyeduJ/uOS2vtFztmpRFVuHbCB8vlKUP4EPn1ri4g/jF7ffeU3ywnswEl7Ik2k
 M36O69n3ALruX6RJGzy31DVjpuZI9bpbhXdkxvoF+SPmxVXIH3H7A51khNlDsizqu+kp
 gRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745525621; x=1746130421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63zJrrW2qVN9BBMzZsGmSJtvdOThXGUiHQO85Hff6Mw=;
 b=uR1T77S7XXO5WTfysTe9IdInbtCPQrmeC1b9vnXSQ6VBg5CmebPGP6xb4R8u03bEUR
 RnfEICOGbb8NxFUhrI1riU6FvXYy0Vfk2UKZVUMtmelMOn99zJqkxnPeQ6Q8Q7XCquGf
 8if3QHjD5e07EJHHT+pxAGGq57fjRNFDYa4T6riBe5zkHBxyhqNzSdvr4Mgs9KuMIKKb
 doYCwvCPv+pzUNvV36eB10EwlfOQwZCcj81Qlv9Ns074kHS/yHZN2f6ZcGhsW/Z4VqAs
 Y0yv5KDE1Hv5LlIZFk+eXyJUy8HoG88QftQkonSF3paYr/T5oE3JjnsIw6dLUrQwsf80
 9esg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUACgva4SHtH7y6pau3Qe8IBJbPOqKV0mMTwbl5gXr+xzQ+XAfep4HFFLrIypW/Y1LT4jdMBp5FY9od@nongnu.org
X-Gm-Message-State: AOJu0Ywm9VF1Yohg+nuI37k41iuQmI7CaOJFwCgJsgnk0BP7yBgdhHVy
 3ctZD6dUGc7pZX8GFpy1XMv3VRwzfRzKT4+eLc2ZcZeQDs8llin7bSltMhArMQ0=
X-Gm-Gg: ASbGncvSU7cxXF21hZtSaGm9YUwU8p9h+VrHTPs2cUbGnqWY40+TdmkjUlwKOceWZEx
 SlOa+yMDjKSmnnPhMAufp84CZ5FCkLuAKYpCyniNzMe66O9m4tvfZhVaAJPOaLHBGUVGJ9SpTjE
 WQMTkYniaJtoYB71okOqu5R7Myq1XI0dUWswRiK3ZQkSCZTyC+hcw0VDSQ3fJodwECu9tbeiFbn
 OZdecFNARvvjOxuE1raKebyWfqSmrmsnQz3ibUu1D+tXPMIwXlKWSYzAMqGFPz4VqC29zYU5MQi
 uQecAZ1LVgeWC/xJnh412R58n44ck1kf6q6fu1ksr2djxanmGXPtjKPizeRIy1bGWFLRFmXkHhQ
 bu0Op7ubt
X-Google-Smtp-Source: AGHT+IHui0RgYF9Lw4mS2EovbWpD4PjEQdp4r72Hw4DrgMI9GsPisZv7Btm9vb8dxtZTri48ps190w==
X-Received: by 2002:a5d:64c3:0:b0:39c:dfb:9e8e with SMTP id
 ffacd0b85a97d-3a072a59b81mr517808f8f.8.1745525621214; 
 Thu, 24 Apr 2025 13:13:41 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5bc8bsm211226f8f.81.2025.04.24.13.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:13:40 -0700 (PDT)
Message-ID: <ebd88b93-3752-4e18-b5c0-78e3b4a4b8e2@linaro.org>
Date: Thu, 24 Apr 2025 22:13:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] target/riscv: Include missing
 'accel/tcg/getpc.h' in csr.c
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-8-philmd@linaro.org>
 <9f71ab55-523e-4720-aa1b-2b3271038df5@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9f71ab55-523e-4720-aa1b-2b3271038df5@nutanix.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/4/25 12:14, Mark Cave-Ayland wrote:
> On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:
> 
>> "accel/tcg/getpc.h" is pulled in indirectly. Include it
>> explicitly to avoid when refactoring unrelated headers:
>>
>>    target/riscv/csr.c:2117:25: error: call to undeclared function 
>> 'GETPC' [-Wimplicit-function-declaration]
>>     2117 |     if ((val & RVC) && (GETPC() & ~3) != 0) {
>>          |                         ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/csr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index c52c87faaea..13086438552 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -28,6 +28,7 @@
>>   #include "exec/cputlb.h"
>>   #include "exec/tb-flush.h"
>>   #include "exec/icount.h"
>> +#include "accel/tcg/getpc.h"
>>   #include "qemu/guest-random.h"
>>   #include "qapi/error.h"
>>   #include <stdbool.h>
> 
> I'm mildly curious as to why the target needs to include accel/tcg/ 
> getpc.h directly as it's almost a requirement for TCG

Indeed. There is a TODO around, added upon introduction in
commit f18637cd611 ("RISC-V: Add misa runtime write support"):

2113     /*
2114      * Suppress 'C' if next instruction is not aligned
2115      * TODO: this should check next_pc
2116      */
2117     if ((val & RVC) && (GETPC() & ~3) != 0) {
2118         val &= ~RVC;
2119     }


> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Thanks!

