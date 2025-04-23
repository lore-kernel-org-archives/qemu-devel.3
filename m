Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A61DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cwA-0004HW-EK; Wed, 23 Apr 2025 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cw9-0004HK-An
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:27:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cw6-000384-RK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:27:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224019ad9edso159105ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745425617; x=1746030417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=atIQL3gAw5Epa0svhyYgM6iVy4IB4FblYH6a9T9b4uM=;
 b=RB4NBMR7CTao5z4qxG851i8EQqJgJZszPkfJSho2ItrbNgIYdAumMO+8fkkIwD8OcC
 xF7Hlwjhw7L/q7xQ0+Wn0khkV0dr2cRm4wrwJLpi6VqMG9wBdWLeqkLHXmp5P5hdcuaG
 +2nGxp7AZL0GTedO6lPQSr4Eufx71iqR97/5rQ5+piSToRnrOLIB3Wbd5ZSD81Lqpv1s
 5nQR7p9qyd6OKXcqxU/k8dGcvV09lrOTKH3bGkv6y611+CTGkZtZwQgYckqW2oedNy9K
 S8pqhWc4Wm5eEOpuM+LxTJzquLS3hz8uaomEc9a+RgtiahAQi+u2dMIFgzghFg2d2OUb
 GQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745425617; x=1746030417;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=atIQL3gAw5Epa0svhyYgM6iVy4IB4FblYH6a9T9b4uM=;
 b=IqQfONSyCyvk0hvT/QLFXa7rFWb8x/2NH04BTjBP+WQCTw/PWyxJ8WigfzYDf0s8bp
 wSUbvlXiUB+efwwUCLyxDgWQ8FME3bByY1muDRiuHT+ou3QEM0aMd3gXHuebGA2nfrdc
 h2Um69BGNU2KMc31ipyrSDBS+qKd7kpbb6zQMQevn/pN3KzZfzwQd77Hq7HchdzLDYYH
 wlKBIflLXy4Tuf3xXok7qtsfgHVV1OvnUrDEBjIcj8ClGma+6ZNOkEIqvoV1rSrYXr4Y
 tSCIxclQouFCO+X3MN8D+ZwcxdhLOD6Il2RwtEF3wcY3m3M2c+nGaezVxQgZcjceDy1Q
 rA7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQHHskwNiBaYoKfTpSF2cUHBBFML5uZg2dxht2ZPclxi7M9PqBkY7la0er02PDvY4BpjUCapu7l3oI@nongnu.org
X-Gm-Message-State: AOJu0YxudfymHtNiMYUd/AutIfhtBiR6rrnlZ2IdMN04tcLv8c1HUfAG
 7zf42KmRaURKEv2mKc/uHXDRf32mFg3KeJ4ODq/rJ0HM+0mDmZFoI9o6BGz8vwnK8VrvBVQjlLZ
 I
X-Gm-Gg: ASbGncvKRFrW9H0RMYuaSOmCq4sfbqtMMU2A+DWrBNMydUMQi8kKO32AcLxj6/fGSM1
 ly/3K9ej/VbL5ML0r9/qVkhp+K3MLRlNZLnyOTp28MP+DVG8iCS87X2Puqncq+Pf/oM3Uj4ip6N
 V/jZ9tFsRxeL28W/SksyZuAuUlL3jscjhbuuwQBCVIrQlWCJFwsV5AaKOS5r9WUvBkOkmfl4f1f
 ZxfCv7z1flKFMrTc0HjOdK9PhJVgGTqL2NPwWLPoQSHdoSBI9xm0GNAsnkKx839O+Gc8OgD+Mfo
 0V3lCKfs61f5ZD+JiCiLTc9xr/Os99+LuI3vuyQ/cWdMF1IwLjnYjg==
X-Google-Smtp-Source: AGHT+IEnrXYE9INhsa/RFdtZNnOZLKVedpqqQdAl7tmonL7zK63pHBz8VjMKGzz2rOLzThIOBW0Y4A==
X-Received: by 2002:a17:902:e84a:b0:224:b60:3ce0 with SMTP id
 d9443c01a7336-22db1a6419cmr268785ad.5.1745425617289; 
 Wed, 23 Apr 2025 09:26:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3a6sm106496995ad.259.2025.04.23.09.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:26:56 -0700 (PDT)
Message-ID: <41f54ebf-6831-41d6-aa67-f083d6b7b0e8@linaro.org>
Date: Wed, 23 Apr 2025 09:26:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 118/147] target/arm/cpu: remove inline stubs for aarch32
 emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-119-richard.henderson@linaro.org>
 <4a8da7b6-7773-453d-b704-0991caa3cd97@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4a8da7b6-7773-453d-b704-0991caa3cd97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/23/25 03:35, Philippe Mathieu-Daudé wrote:
> On 22/4/25 21:27, Richard Henderson wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Directly condition associated calls in target/arm/helper.c for now.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20250325045915.994760-23-pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.h    | 8 --------
>>    target/arm/helper.c | 6 ++++++
>>    2 files changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index b1c3e46326..c1a0faed3a 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>>     */
>>    void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
>>    
>> -#ifdef TARGET_AARCH64
>>    int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>>    int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>>    void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>> @@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
>>    #endif
>>    }
>>    
>> -#else
>> -static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
>> -static inline void aarch64_sve_change_el(CPUARMState *env, int o,
>> -                                         int n, bool a)
>> -{ }
>> -#endif
>> -
>>    void aarch64_sync_32_to_64(CPUARMState *env);
>>    void aarch64_sync_64_to_32(CPUARMState *env);
>>    
> 
> Should we complete squashing:
> 
> -- >8 --
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index cf4ab17bc08..f9353887415 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1810,7 +1810,6 @@ static inline uint64_t
> pmu_counter_mask(CPUARMState *env)
>      return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
>    }
> 
> -#ifdef TARGET_AARCH64
>    GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
>    int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
>    int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
> @@ -1820,7 +1819,6 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs,
> GByteArray *buf, int reg);
>    int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
>    int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
>    int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
> -#endif
>    void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
>    void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
>    void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
> ---
> 
> ?
> 

This part of the series focus on hw/arm, so it was not needed to clean 
target/arm/internals.h as part of it.
That's why I "pushed" the TARGET_AARCH64 #ifdef to target/arm/helper.c, 
allowing to do it later.
I tried to cleanup that completely at the time, as requested by Peter, 
but it was pulling too many things, so I just dropped it.

So I think we should not squash it here.

>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index becbbbd0d8..7fb6e88630 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -6563,7 +6563,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>         */
>>        new_len = sve_vqm1_for_el(env, cur_el);
>>        if (new_len < old_len) {
>> +#ifdef TARGET_AARCH64
>>            aarch64_sve_narrow_vq(env, new_len + 1);
>> +#endif
>>        }
>>    }
>>    
>> @@ -10628,7 +10630,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>>             * Note that new_el can never be 0.  If cur_el is 0, then
>>             * el0_a64 is is_a64(), else el0_a64 is ignored.
>>             */
>> +#ifdef TARGET_AARCH64
>>            aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
>> +#endif
>>        }
>>    
>>        if (cur_el < new_el) {
>> @@ -11640,7 +11644,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
>>    
>>        /* When changing vector length, clear inaccessible state.  */
>>        if (new_len < old_len) {
>> +#ifdef TARGET_AARCH64
>>            aarch64_sve_narrow_vq(env, new_len + 1);
>> +#endif
>>        }
>>    }
>>    #endif
> 


