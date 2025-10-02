Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4P40-0005KX-C0; Thu, 02 Oct 2025 15:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4P3u-0005Jg-E2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:33:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4P3k-0007zj-QS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:33:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so1239735b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759433623; x=1760038423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A61MxiqiNEC/IXG8gXr+cC8oocbDeLUvMLOQmeencW0=;
 b=I7UjYblbb3VGpqlbuUE4jHUCaJKhWfrKFJGQVY0A7tkFyJFh9N/ub/yaDsvbhTsQjc
 fcRtG6qzqfO0BnDs81W2iHqckgRayRD9bBkA58q+JjJKp+bOPhYmgtx53KVIJjm0RyHY
 gsHCJWV+suiKKJdfq4jyK8mNxCYaQlwx7OkvQWKelzLWQZyviwWOywwzGl/eb8g0jkB4
 g9F56v82fdvqYoSmYXfuj/W7ph5jzaN/9Rr1UFdCKmH0j+1+IkOk6DXygCfod1DRSY+M
 S9nq/hVr67N24EO1xgQaWIHPUXelSdMcG896vM6P9spS8Y7mW6/wBq2f603kIrXnetb8
 5Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433623; x=1760038423;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A61MxiqiNEC/IXG8gXr+cC8oocbDeLUvMLOQmeencW0=;
 b=jSQa2jwnuJ9dtHjc/cuo5e6KLu7T2WRYdj11oeCV28Aji9TI9stZoJ5L5Z7/9wAULT
 0FoH0exo/nN6kb5MzjnRUFdSWRGlpvkkX/zL94kHa8tg2x9QCDjOBrPUGp8HWvrA/k3z
 QnV+izhNJoLW/xknCptsP2EgyYTGGZks7G8uK/UzpBuUf/NtqiaYgPkLWz4x0d4l8e2j
 N5FvoIj+ZI5p6K0fjzAzqORg4HzeXNYWO0hFgBFRgn//sMwI6CONGuhoKGKQ2yDoekj1
 inVf+lbktVxs5b6ZPzAM4nu7frsXBBdaQ/cDFnUV0aWPWA9aMlTetonYiX1Qk68qWh87
 ICpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZEOeW+bWwro9fQoEA7wTdJUYzeJZL8ZDZ3NtDDNBIHovIoSV8aTj/iLLa6ycgT5b3zBu7O41dmElE@nongnu.org
X-Gm-Message-State: AOJu0YytqD9vQ47ldrUYGPvTBZFWVcw1bkMt0Q/LvPhDvfVLhcdaYvpr
 gETmvVxYzU9ONaaiGtEdHqlqUztKCBTddbpXXystDmU9qlEKqV05L4gU2uMQ4md7+rI=
X-Gm-Gg: ASbGncuNQ7dflfG5Zq8URULZGVyreCzVMklGcn7hOvEmV7U/RTMEi6RJ9GIXfnX76aR
 vuxObQMjCsIB65xyCo/F8NeKlMcALfw9DJxFZTkl4NJ686Jtwb4bXd0JMIM7lIOr0/BjagGporg
 klGKAJRCtOq7UheudlQ/BQeYK6G1RiIVkDJwaC+9trZ5yUNXqY88hnOQT/DhE1i3mEkXfCaYId3
 jsIRpBdV6SNxUzH6zrVBqaeS5Vo2bYhUurieT2lmPUJTWcrHgW4GKjTvEabD8UhiquL8WLrDixA
 utaGpKn2x+5659RlCY7p8HRFoesTzELH1NVfDMuGV9JjHJE/D8PBe90Nc6UkC9hYxavkzUskJfs
 mq8GslNCEFF+8FaI18poiwZxxslUGHb4PkqcQKFgiw2PHkDDJlQND/ZtN/k1IkCE=
X-Google-Smtp-Source: AGHT+IH0DUNGM8OzDC3L+h++QR17J3TAEMZ6Zwwj3sb0PMqf7fQ39hdyj0YCZJTIPBy8KKhoeRwAsQ==
X-Received: by 2002:a05:6a21:3395:b0:2f4:a8f:7279 with SMTP id
 adf61e73a8af0-32b621284e4mr722504637.54.1759433622651; 
 Thu, 02 Oct 2025 12:33:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01fb16e4sm2813277b3a.21.2025.10.02.12.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:33:42 -0700 (PDT)
Message-ID: <cbc22e4a-84dd-4209-82fd-ec56ea138d27@linaro.org>
Date: Thu, 2 Oct 2025 12:33:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/33] target/riscv: Combine mhpmevent and mhpmeventh
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-6-anjo@rev.ng>
 <e1748ad3-3475-4cce-8add-2a1d76994f0b@linaro.org>
In-Reply-To: <e1748ad3-3475-4cce-8add-2a1d76994f0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/2/25 12:08 PM, Pierrick Bouvier wrote:
> On 10/1/25 12:32 AM, Anton Johansson wrote:
>> According to version 20250508 of the privileged specification,
>> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
>> when XLEN == 32 and accesses the top 32 bits of the 64-bit
>> mhpmeventn registers. Combine the two arrays of target_ulong
>> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
>>
>> This also allows for some minor code simplification where branches
>> handling either mhpmeventh[] or mhpmevent[] could be combined.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>    target/riscv/cpu.h     | 10 +++----
>>    target/riscv/csr.c     | 67 +++++++++++++++---------------------------
>>    target/riscv/machine.c |  3 +-
>>    target/riscv/pmu.c     | 53 ++++++++-------------------------
>>    4 files changed, 42 insertions(+), 91 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 3235108112..64b9964028 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -427,11 +427,11 @@ struct CPUArchState {
>>        /* PMU counter state */
>>        PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
>>    
>> -    /* PMU event selector configured values. First three are unused */
>> -    target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
>> -
>> -    /* PMU event selector configured values for RV32 */
>> -    target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
>> +    /*
>> +     * PMU event selector configured values. First three are unused.
>> +     * For RV32 top 32 bits are accessed via the mhpmeventh CSR.
>> +     */
>> +    uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
>>    
>>        PMUFixedCtrState pmu_fixed_ctrs[2];
>>    
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 859f89aedd..2d8916ee40 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -1166,8 +1166,9 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
>>                                         target_ulong *val)
>>    {
>>        int evt_index = csrno - CSR_MCOUNTINHIBIT;
>> +    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
>>    
>> -    *val = env->mhpmevent_val[evt_index];
>> +    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
>>    
>>        return RISCV_EXCP_NONE;
>>    }
>> @@ -1176,13 +1177,11 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
>>                                          target_ulong val, uintptr_t ra)
>>    {
>>        int evt_index = csrno - CSR_MCOUNTINHIBIT;
>> -    uint64_t mhpmevt_val = val;
>> +    uint64_t mhpmevt_val;
>>        uint64_t inh_avail_mask;
>>    
>>        if (riscv_cpu_mxl(env) == MXL_RV32) {
>> -        env->mhpmevent_val[evt_index] = val;
>> -        mhpmevt_val = mhpmevt_val |
>> -                      ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
>> +        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
> 
> Maybe I missed something, but should it be:
> deposit64(env->mhpmevent_val[evt_index], 32, 32, val)
> instead?
> 
> Reading the rest of the patch, I'm a bit confused about which bits are
> supposed to be used in 32/64 mode.

Indeed I missed something, it's more clear with next patchs combining 
low/high parts.
The concern I have that is left is regarding the definition of 
MHPMEVENT_BIT_OF. It seems to be out of sync with what we have now given 
that we now keep lower part in lower bits.
Existing implementation is quite confusing to be honest.

