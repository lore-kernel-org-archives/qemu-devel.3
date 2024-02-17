Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48F7C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 09:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbHG3-000519-2C; Sat, 17 Feb 2024 04:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rbHFz-0004yy-J3
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:45:16 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rbHFr-00034m-HU
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:45:15 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e09493eb8eso3079590b3a.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708163106; x=1708767906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8Cz9CZUe7qvuagMteR1dzEPTjXiLhQgV9FMcMB/Jb0=;
 b=KZfPVG5UlrGerZ/WnI5Yh1xc9JfedgVlad/57+PoPltoHbbyLE/DTikdDzL/HEcvxz
 uLJBcS7muDhfHCTGU6KG0EXIySoqcFTCy8mUBnJDsAtqrXsL03tR7jmh0LtJx6ZNZnE4
 C7gKMoTW6sIIB/O3kMDw2XulMu9Bgy8kppmfdf/dC2lEE020kGQTWHEFerXAFvq9IApq
 etXZb752QDGwcbKs9o+Sg45Bvd0Kq5ug04Hqa/oFcXn+MA+7UXxyYU8QFdbdeupR8nEW
 kLWxBydbOJV7I0ERTq7a+fN3C2v8BPY1QxE7fitKs7OsIoMBW2K4kLMRE86xZP32mlie
 pv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708163106; x=1708767906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8Cz9CZUe7qvuagMteR1dzEPTjXiLhQgV9FMcMB/Jb0=;
 b=kzwPKiktUV/0vHzB1NrEqoyPknyGnweCDndOXH6xGY3I7NeeUkNhuD4ULXQWZDVa6u
 D40/9JixnnCDGTYepgaR5qR/wmfst129V6egWOZPo8SemU3zo5aRUd14aKireKLQe+Fp
 y6z5u33iDGbS5ufJ9cZHHKgXmEglsQNAd9FRTcOf1iwTFjSaMEXOXuRCyHYEaoTggz9c
 ufY9b9AubPcBx1WzFLYquJGpc106uEO0inE2x4KPGSfHckjqBRzZGfsxEg0OzINuIzyy
 Tdc2CFM/WSMPnyeSbf5B//i8CU6VAUEnL32mxjMxxjFT5SJ1yQkvBKBRgUwUMcmLi//T
 AWVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2GtDiemoNAXeVhspdJIo+BEnSvCICRDPuDVwYFFWZXUWtud+Bw7z2LyLD5prh9G9HH2WAoPLCKCzn++B02NN/fwC/5iw=
X-Gm-Message-State: AOJu0YwcJT/tq8qn6PuNlqnMTGpSCpZ+yW5l4zkjewSspv0KX061OBJe
 htX0/pSbYJw1gzBVAV9OiN+wTHvQuhe6tbuCgs5rkIG+L1nnBf0CHnwQN2Zl85o=
X-Google-Smtp-Source: AGHT+IGXvsWdSDmajc3upYnmeAZWZmPKB08QcSpIHnZK7dXZLflNWp5Bxna4e+4yH5/K2/3NYNKLXQ==
X-Received: by 2002:a05:6a20:6f03:b0:1a0:85ed:4769 with SMTP id
 gt3-20020a056a206f0300b001a085ed4769mr6425035pzb.11.1708163105899; 
 Sat, 17 Feb 2024 01:45:05 -0800 (PST)
Received: from [100.64.0.1] ([136.226.240.197])
 by smtp.gmail.com with ESMTPSA id
 n15-20020aa7984f000000b006e0651ec052sm1295608pfq.32.2024.02.17.01.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 01:45:05 -0800 (PST)
Message-ID: <60c09bf6-a0c9-04ff-ede9-eab4092a3a72@sifive.com>
Date: Sat, 17 Feb 2024 17:45:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 2/6] accel/tcg: Avoid uncessary call overhead from
 qemu_plugin_vcpu_mem_cb
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-3-max.chou@sifive.com>
 <2d119d74-3a12-4efa-94e1-acebfe4f0742@ventanamicro.com>
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <2d119d74-3a12-4efa-94e1-acebfe4f0742@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.399,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

I think the the overhead from the plugin callbacks depending on the type 
of plugin callbacks.
Because there is only qemu_plugin_vcpu_mem_cb in the perf report of the 
glibc memcpy benchtest, so I just looked it up for the the memory 
callbacks in this RFC.
I'll try to get more experiment results to check the status of other 
plugin callbacks.

Thanks,
Max

On 2024/2/16 4:21 AM, Daniel Henrique Barboza wrote:
>
>
> On 2/15/24 16:28, Max Chou wrote:
>> If there are not any QEMU plugin memory callback functions, checking
>> before calling the qemu_plugin_vcpu_mem_cb function can reduce the
>> function call overhead.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>
> This was in my TODO list for some time. Thanks for looking it up.
>
> Can't we avoid all callbacks, not just qemu_plugin_vcpu_mem_cb, if 
> there's no
> plugin loaded? The performance increase when building with 
> --disable-plugins
> shouldn't be a thing - if the user isn't using plug-ins it should have a
> penalty to it.
>
> Thanks,
>
> Daniel
>
>>   accel/tcg/ldst_common.c.inc | 40 +++++++++++++++++++++++++++----------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
>> index c82048e377e..bf24986c562 100644
>> --- a/accel/tcg/ldst_common.c.inc
>> +++ b/accel/tcg/ldst_common.c.inc
>> @@ -134,7 +134,9 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr 
>> addr, MemOpIdx oi, uintptr_t ra)
>>         tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
>>       ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
>> -    plugin_load_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_load_cb(env, addr, oi);
>> +    }
>>       return ret;
>>   }
>>   @@ -145,7 +147,9 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr 
>> addr,
>>         tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
>>       ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
>> -    plugin_load_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_load_cb(env, addr, oi);
>> +    }
>>       return ret;
>>   }
>>   @@ -156,7 +160,9 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr 
>> addr,
>>         tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
>>       ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
>> -    plugin_load_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_load_cb(env, addr, oi);
>> +    }
>>       return ret;
>>   }
>>   @@ -167,7 +173,9 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr 
>> addr,
>>         tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
>>       ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
>> -    plugin_load_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_load_cb(env, addr, oi);
>> +    }
>>       return ret;
>>   }
>>   @@ -178,7 +186,9 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr 
>> addr,
>>         tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
>>       ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
>> -    plugin_load_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_load_cb(env, addr, oi);
>> +    }
>>       return ret;
>>   }
>>   @@ -195,7 +205,9 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr 
>> addr, uint8_t val,
>>                    MemOpIdx oi, uintptr_t retaddr)
>>   {
>>       helper_stb_mmu(env, addr, val, oi, retaddr);
>> -    plugin_store_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_store_cb(env, addr, oi);
>> +    }
>>   }
>>     void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
>> @@ -203,7 +215,9 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, 
>> uint16_t val,
>>   {
>>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
>>       do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
>> -    plugin_store_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_store_cb(env, addr, oi);
>> +    }
>>   }
>>     void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
>> @@ -211,7 +225,9 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, 
>> uint32_t val,
>>   {
>>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
>>       do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
>> -    plugin_store_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_store_cb(env, addr, oi);
>> +    }
>>   }
>>     void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
>> @@ -219,7 +235,9 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, 
>> uint64_t val,
>>   {
>>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
>>       do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
>> -    plugin_store_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_store_cb(env, addr, oi);
>> +    }
>>   }
>>     void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
>> @@ -227,7 +245,9 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr 
>> addr, Int128 val,
>>   {
>>       tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
>>       do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
>> -    plugin_store_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_store_cb(env, addr, oi);
>> +    }
>>   }
>>     /*

