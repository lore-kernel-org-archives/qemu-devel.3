Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73521CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Ic-00040h-Gq; Tue, 07 Oct 2025 10:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v68Ia-00040H-A7
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:04:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v68IO-0000uf-2t
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:04:15 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b5f2c1a7e48so4283157a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759845838; x=1760450638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ApEdG0JWlXFe7JyIqDbGlSVzERcTf+zqVSSaff7l2OQ=;
 b=nAkhJnOqeRpQQT5Qx2muz+Wrkcn20eq+Ri4kyN6TnTc/RR6v5deifU4AiD0r2E5Mi4
 9i97JHUMaWDfB8CNdii5QCCpacUMFKSlNYWcUJ5ttLQLFdvio6WTZlwRK3E7fkyworE4
 Edd4QQM8Rl6+OJKrZaYm7XSprlkAYtxcrz+JbDqDOatfT5+X7Bv6ulSgQ/yy3ednw8In
 PyWq0hSuCuGPc/GgRTY0xIwYP9zTGU1SZyBoFzgEf3L/7OW/4V1a61l0yoi+nZDe4xT3
 o3LG2x6G1kKbA+1f5IDDnV40me87JYqaATSy23V13qtHcLb4NYX7nsiYU55skHMLlfcJ
 vpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759845838; x=1760450638;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ApEdG0JWlXFe7JyIqDbGlSVzERcTf+zqVSSaff7l2OQ=;
 b=GF+Cpu7RqxYxfPUmpwR6LKdqZ5IuO8OVL1DJJ1+xHPVYc8P47B3ZCWt6RsZHZ5dlN3
 UnXEmKdBLBSdqpRtSTTeE1wKzRfFZJvgbGRGUZOGfYLFjlIQAF0HOPuWCVNDuwClYo9T
 VMo3T99myQOXZdAbWyuwyv3YsLOaQTktfhQyzAPV8iJpP0RPEuzyixahaCoCF5bkytfM
 DxqqAApIyl7NdoggDXsMAqFItxXOMcqhu8fRd6QfwGQkQUADpxN6yqBX1s36cpqn1vTt
 94e6pTV6ANHufZo68bKwcICCiwtjeIuCbZxF/nEc8GpHpybiYWGnVYCro9U2C8FxJl5C
 m+LA==
X-Gm-Message-State: AOJu0YwGPRwbE7b+72DhYz/uBeyTq5zxo1+Kl6wc5dw37MjvurFoY8NQ
 rqrKlwJ4fs4fYOnz1OmCJWf+BV5DO3cu9x3UK2YFaXY9cq8RxUl+CD7qiISA8xu6T/Y=
X-Gm-Gg: ASbGncuR4P6rZrIOfow2pzE8wJnDrYiPLfbUfrvolTnQvEXED0MUL+fk9gaszwq/QQS
 DmlkF6fEftFRR0WmIIjQUmnMoj9Oq9hvpm9GCy7jk8XipbYbNTcpxdrA0fr70InqebilS3VAdCQ
 KYmlSqL2ZK53Q+SY477dTFmfhw8gA7XR6MEluwkqKgavoTbd+AsOxyhlOMpDLDpzMewXaf9jFC8
 Cr1oWpuH4QJS2i1P7X/AaL/L6mFLKi1c+Wjhf1wAbzZGQN8gwhAJcNKO0Mw88/Jv9Ink4QmN2al
 iBpnSmp2wOv0Cc/mxCZOvh0FnItlg7KtLDhJ1b+q/hS1zi4HFbMYX57ajCgtKVbMtu1J9gkkWir
 zm3z0iRqdqODnkNq4rVwIuWZkvtd64xhL9TJ5mrCtAMjdkqRBJKizWVZp0jFbUeaQ
X-Google-Smtp-Source: AGHT+IF6bPrWDGwzPybS9Cy2Nv75p9dqDiB17CKK1+rYlYyBGsMjp/fdCzrRH9ZZK/Viuzw8U3Tbuw==
X-Received: by 2002:a17:903:1b30:b0:267:ba92:4d19 with SMTP id
 d9443c01a7336-28e9a4465c0mr196422335ad.0.1759845837662; 
 Tue, 07 Oct 2025 07:03:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b845bsm167014335ad.79.2025.10.07.07.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 07:03:57 -0700 (PDT)
Message-ID: <3040ccf2-8fdf-45e3-af07-440b80949ce3@linaro.org>
Date: Tue, 7 Oct 2025 07:03:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 48/73] target/arm: Implement GCSPUSHM
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-49-richard.henderson@linaro.org>
 <CAFEAcA-WzWDem=u8w4sGB3aMHEBkUFo1PJztbwM+mqe+REzasA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-WzWDem=u8w4sGB3aMHEBkUFo1PJztbwM+mqe+REzasA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/7/25 03:17, Peter Maydell wrote:
> On Fri, 3 Oct 2025 at 18:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpregs.h            |  3 +++
>>   target/arm/cpregs-gcs.c        | 15 +++++++++++++++
>>   target/arm/tcg/translate-a64.c | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+)
> 
> 
>>   void define_gcs_cpregs(ARMCPU *cpu)
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index 38a1f51ed5..4fb73f821b 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -26,6 +26,7 @@
>>   #include "cpregs.h"
>>
>>   static TCGv_i64 cpu_X[32];
>> +static TCGv_i64 cpu_gcspr[32];
> 
> 32 ?

Oops.

> We only initialize 4, so I assume that the array size
> should be 4 as well.

Yes indeed.

r~

> 
> Otherwise
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM


