Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B4FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7d7U-0000Ru-QF; Wed, 23 Apr 2025 12:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7d7S-0000RW-UK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:38:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7d7Q-0004JF-Mi
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:38:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso571195e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745426319; x=1746031119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yLzJXDA+CN/xTWiNpDYE5amg25OuLYoru0TaLj2PX8Y=;
 b=rWcGRsMMAVS4hXEBH+JSQlx3AXaRk0sbNBjnjWlObyoBjjwEEAtHdmVxZ2W7E5+ull
 6QIjOQdCf8k5qweARRU8v05E3oJHBwelX9/Nepc+M9BN88eZEjGLubpQh6/Sf5cZbbsH
 WrtBpXMgs40J3ftvSL6pEdFqubIa1K8DEILxcidQou2M9+mKvVPRAS6SDd3KfahvwSZS
 H0YaFQMBUvmcvF/yc6EI9wOWqTNMgVKsPT/Mvovp1p3v8adMUOOPL/11I1dCbyqf/k5n
 CHVQvF+eBbRGx5ph0nx3eSMYbDPvNCoZltr3Cvlj872OPZGwGpmF2iDWaHdkApuSG3nv
 cnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745426319; x=1746031119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLzJXDA+CN/xTWiNpDYE5amg25OuLYoru0TaLj2PX8Y=;
 b=iHSXE9dyQDBm1lkMDndZDcAO/Ic8GdWGKh64zbg5n2PzZZdyAO3P5oeeURagcTLmRA
 d+In6yc8sV7VkHQyUcHEIMDytBgNgzlnndqAUWToefHIDIgc7TLxLVKxUJmEVvXqTyq0
 zXUOaBW0NY5/Qif4Z5S7b3K2AZR0wQpKhOaotMrEZwQoZfLcX0Rq31FmX97Q8GD4UPOm
 kPvsdlLdbmKT0IJ219QEuROQWKBSt+M+zQIsQTYGi138ZIJ3ZpOkF+oJT2nRSll/jjkj
 bljN/uuaFz0yExlmsc7RoRpKMVQpYQTk+Ot+m9gQNqac+iVBOH++jZxK8WhEz0eTq8t8
 tIUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0fahnbNXD16kUQ9PpbW7+DNHTvAGucQTL9UKS05Fcq1Nrj20GfWAEPBAuNL7CpLfMcYLmP/7agNIk@nongnu.org
X-Gm-Message-State: AOJu0Yw3S3Bw7k7/PzoHf4tlj9fHNZQ5r0Dd/byfYNnJkBO1jh9G9PHz
 b7frdNaSnkdwp940mTcyfNKbK+dn8KP6/ceJTk0FTd4sVQn5emjIm1rVD5lpMlU=
X-Gm-Gg: ASbGncshEBHfe0EEXgS1a/+Wh3AB841cc1ZuLlQueY5j9z+xtMtiNO/wl72qrr5WhbU
 Kvwo/qIOqTCSCLE6blcIzO7axl1Rrs+UukKEAU7fkU+nHPOfmBwZLkH+QIS4LdEVC+bp+cP+l6y
 v65yUkZIaMW/nwYFpvgzcjxsIWsTMyIstI8vkLz7ZPCB01xIVU0Kdcjfg+8rphj8+Wsn8kQzFUE
 9Z0mbP1BSCPboduOWGfPmsMnDtVUMm89SsXlryHi4O1GkBbdReXCQjiTN3ByxjFVl5NbtsqO9yi
 QIUNdCwO4CHFBphsIHj7dK0jIVxd8gOA6VW08yTKH3wnSaTve6c4L7Gn4mrzn+0h/DkPDsWH5Ts
 G/XX6gQdv
X-Google-Smtp-Source: AGHT+IG7VE9YDi5uz8+FtJbEltTi9NzNnUm5EaDlQvYaAvD4k1jBxZvqdOlFKMucGDCMSW0s5b3Omw==
X-Received: by 2002:a05:600c:1547:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-4406ababea3mr175785045e9.17.1745426318707; 
 Wed, 23 Apr 2025 09:38:38 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092dc229esm31978285e9.40.2025.04.23.09.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:38:38 -0700 (PDT)
Message-ID: <f5c71904-342b-47b4-af8e-4155067b5e7f@linaro.org>
Date: Wed, 23 Apr 2025 18:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 118/147] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-119-richard.henderson@linaro.org>
 <4a8da7b6-7773-453d-b704-0991caa3cd97@linaro.org>
 <41f54ebf-6831-41d6-aa67-f083d6b7b0e8@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <41f54ebf-6831-41d6-aa67-f083d6b7b0e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/4/25 18:26, Pierrick Bouvier wrote:
> On 4/23/25 03:35, Philippe Mathieu-Daudé wrote:
>> On 22/4/25 21:27, Richard Henderson wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Directly condition associated calls in target/arm/helper.c for now.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-ID: <20250325045915.994760-23-pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/cpu.h    | 8 --------
>>>    target/arm/helper.c | 6 ++++++
>>>    2 files changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index b1c3e46326..c1a0faed3a 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -1222,7 +1222,6 @@ int 
>>> arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>>>     */
>>>    void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
>>> -#ifdef TARGET_AARCH64
>>>    int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, 
>>> int reg);
>>>    int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, 
>>> int reg);
>>>    void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>>> @@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t 
>>> *dst, uint64_t *src, int nr)
>>>    #endif
>>>    }
>>> -#else
>>> -static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned 
>>> vq) { }
>>> -static inline void aarch64_sve_change_el(CPUARMState *env, int o,
>>> -                                         int n, bool a)
>>> -{ }
>>> -#endif
>>> -
>>>    void aarch64_sync_32_to_64(CPUARMState *env);
>>>    void aarch64_sync_64_to_32(CPUARMState *env);
>>
>> Should we complete squashing:
>>
>> -- >8 --
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index cf4ab17bc08..f9353887415 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -1810,7 +1810,6 @@ static inline uint64_t
>> pmu_counter_mask(CPUARMState *env)
>>      return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
>>    }
>>
>> -#ifdef TARGET_AARCH64
>>    GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int 
>> base_reg);
>>    int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
>>    int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
>> @@ -1820,7 +1819,6 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs,
>> GByteArray *buf, int reg);
>>    int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
>>    int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int 
>> reg);
>>    int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
>> -#endif
>>    void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
>>    void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
>>    void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
>> ---
>>
>> ?
>>
> 
> This part of the series focus on hw/arm, so it was not needed to clean 
> target/arm/internals.h as part of it.
> That's why I "pushed" the TARGET_AARCH64 #ifdef to target/arm/helper.c, 
> allowing to do it later.
> I tried to cleanup that completely at the time, as requested by Peter, 
> but it was pulling too many things, so I just dropped it.
> 
> So I think we should not squash it here.

OK, then this patch can be queued on top:
https://lore.kernel.org/qemu-devel/20250403235821.9909-37-philmd@linaro.org/


