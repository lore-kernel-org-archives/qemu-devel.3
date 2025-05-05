Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8424C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC12N-0000cJ-DW; Mon, 05 May 2025 14:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC12K-0000bM-KY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:59:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC12I-0007u8-Ng
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:59:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso4006995b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471569; x=1747076369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A7CuY77gO+ycPjhJR+jqTUZ/MuIElViaSpNHT9rkCNo=;
 b=dkwcPCrEKLzyCJPqJdnRSHbzv93vjgitQ69og6M3ILYGelkzNbWv7PvQRdg4lric7e
 IrgYQAqDEPFyo4jLi8pJ+/8gq8FLw5NaooROeAcDyH2hqpNn9udC5yoGHGdOvLPt4kmi
 Qr0mzorI7tJX9oWjcVahJONcQS36EiycsEzkAKcyQAc5WUQWMZDrg4nPYmK500UAAatG
 IRUO8LLmu0z+nWUEp+cS35v5paY3qLimNsiSBiw8pf92+12iGljJgsoFDul+DmbOh/1Z
 W9b+oLIiM4aNx+5Akaltlbga6Uo+Ez3pcAlKuUfEXVhasNhiYiiQ6QqOSQA8ydj6pKi3
 jGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471569; x=1747076369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A7CuY77gO+ycPjhJR+jqTUZ/MuIElViaSpNHT9rkCNo=;
 b=VaEBM7Thu3+RohqJY/Ywqv93s0wEbWPWhTNqYPegAFQANe3o6/6AFFOLUUltevK2Yu
 I8qK6QGNLkfjyjJ4PVnjb7w+2Gv768v4YPnz9JsUnEBX9NcQrNuP25P6p5tFHSKg91+Z
 e4YygilXMqIjMlfjIiwnk/9fs/h+vF6eVSAGbFExoRGzOYxoKYbM/kmK7NRFOboWyLAN
 REN3jiDqU970BD3oxNpcTt/3taZo/lE45YzvTyq4yYsxHWVFqeO3Efp4V5nSf/OxReNj
 53/3IzlNlL5EKTJVNXFEuY6oTc+kL6934pEMbX3iMKMEXIH4LFn60ePSqKB2N9DMlfm4
 /nfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpOkWVrfsNv9Ma0l4dWoKykYU8t3bRM5uav1R+Su/Ky6DN2Mf9a6YhgH5PTe8YTvV1gv56F6okcsag@nongnu.org
X-Gm-Message-State: AOJu0Yx692vEmEJ8N9h7jatDDi/g9JK4a4BonubInIfSY6t1ZGn01ahw
 ea1DEkoeUDPqjc+VdFL8z19Ow1Tz/eaTOGwsYNTHSAZiq2EEB7RahWwYTN6W0qE=
X-Gm-Gg: ASbGncsVzZ8M2mRw5ggdwJLrVCOtJ4mUQGbFF+HnGWAc6Rbt8GQf6zDzF4pbH7nrwKW
 fGwQYuADwisGjR46kSFpvyrchP2OZP4UzLvJVDkbN46oR2tIAqo3OLVUGAAuOIbb2Ma83+jlypM
 nsuEtF4dFVI3V+xajy86xy8rdYLgFn7RSl9gzRZ/b2/G8CkuB+jFvqv4RPJSo+cl8MA0LB9vPfv
 Yz9N/aoU8BunytYv3+ozYiHZUpXQpFAxehQYzYULt7l7yAubFMEj4DtmsFIkCnyCTahYGpm9xaj
 KjoirYdhi+wEKsaCssJt7RZ325zyQWwCKSvfqdlb/6grmOY408svZ/2ZwvWlZWv8ZtaLbdnhMsJ
 e4mKavRFGx6bpU0YRLQ==
X-Google-Smtp-Source: AGHT+IFtx/Xz3ZHyZJ9pqB72YEver0dszK8ydQaxSDRWE6dCehUNlZnNCnmh+KYwqNRHT8NIGtvzkw==
X-Received: by 2002:a05:6a00:420c:b0:736:5e28:cfba with SMTP id
 d2e1a72fcca58-74058ae70aemr20715150b3a.18.1746471568944; 
 Mon, 05 May 2025 11:59:28 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a3a6sm7193733b3a.2.2025.05.05.11.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:59:27 -0700 (PDT)
Message-ID: <702b4c82-653d-4782-8805-c4ff9a1155ae@linaro.org>
Date: Mon, 5 May 2025 11:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] target/riscv: Fill in TCGCPUOps.pointer_wrap
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-riscv@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-10-richard.henderson@linaro.org>
 <e8db1ec3-fcb3-42d1-a488-cf55d6060904@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e8db1ec3-fcb3-42d1-a488-cf55d6060904@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/5/25 09:47, Philippe Mathieu-Daudé wrote:
> On 4/5/25 22:57, Richard Henderson wrote:
>> Check 32 vs 64-bit and pointer masking state.
>>
>> Cc: qemu-riscv@nongnu.org
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/riscv/tcg/tcg-cpu.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>> index 55e00972b7..267186e5e3 100644
>> --- a/target/riscv/tcg/tcg-cpu.c
>> +++ b/target/riscv/tcg/tcg-cpu.c
>> @@ -237,6 +237,31 @@ static void riscv_restore_state_to_opc(CPUState *cs,
>>       env->excp_uw2 = data[2];
>>   }
>> +#ifndef CONFIG_USER_ONLY
>> +static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
>> +                                vaddr result, vaddr base)
>> +{
>> +    CPURISCVState *env = cpu_env(cs);
>> +    uint32_t pm_len;
>> +    bool pm_signext;
>> +
>> +    if (cpu_address_xl(env) == MXL_RV32) {
>> +        return (uint32_t)result;
>> +    }
>> +
>> +    pm_len = riscv_pm_get_pmlen(riscv_pm_get_pmm(env));
>> +    if (pm_len == 0) {
>> +        return result;
>> +    }
>> +
>> +    pm_signext = riscv_cpu_virt_mem_enabled(env);
>> +    if (pm_signext) {
>> +        return sextract64(result, 0, 64 - pm_len);
>> +    }
>> +    return extract64(result, 0, 64 - pm_len);
> 
> Is this safe for MXL_RV128?

The RV128 implementation only uses 64-bit pointers, so, yes.


r~

