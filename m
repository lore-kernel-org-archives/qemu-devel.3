Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AD3C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NeX-0001FL-Mf; Thu, 03 Apr 2025 12:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0NeW-0001Ep-FQ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:42:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0NeU-0007yw-PU
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:42:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227d6b530d8so11522315ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743698569; x=1744303369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OlQdPSZlIGM0IBVL6uDuYCcRk8Lqp6cTIpLW0jsNHtI=;
 b=YIvHSr9aH2ihsyRLjZDtwSLJoVMmZZdmVXnbL6jnmdFaGmnxol89msZItKq0pR3CdN
 QVzLrnn+8/MWMTZ2n6/cNcsDxnh4nAlF8+kMBV4+6ZpYXQZTJehX5UJxMGhagoOVOjco
 NpgNOv2pJOzm4RQUiNguOqHvxNsbRFJlAQwrxO+IPsFAGFVgIVezGCeFIqdWZCw4S3Bv
 iRU0SrtkmjDUvetspd/TEwLkauv2si+KyZcXgeTsjZjHM6jW/cypCmavDQuE3v6zJXJH
 YW4GF7qPopefiw0BDrR7I9WXCJ5TYmzThGeHobh2Nq0980dj54xkFKd33Dw7tI2aFOm8
 pAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743698569; x=1744303369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlQdPSZlIGM0IBVL6uDuYCcRk8Lqp6cTIpLW0jsNHtI=;
 b=Ki/IaJD8s9wBmYRHSB3Ps7Pfg0Rp1ZIf2WKwkHJHhtHDKdjSNN1vsYibpk+KySriUt
 y8tIAxTWP5XUHuqEpO9NHDthqWTrX0exRlRYKHmrWUusuZALf/Td6oVIFlZCJ6QoN9tu
 /osUM6YpHVWxyE93/ans1dfJF8rwCePPEn9378y0i0eYmfYshM9dE5hPHe3qGKCmf7Ml
 87PaftjBxLl6kGfZH8ObHZp08ac6vFYmvbqYwVYgCGLbTJ3O9pgflFiI82YbxhACkvsY
 RwPHwovq6EXOOOvPOS09howv1DPbaulpfZbWSJeVVQRoJgmncZRTF6j8eoPwXsEN9jyQ
 s/Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3duqU3n/g8rMd5+SJMm+LxYdfR2IKldj9oXN+X5RzojqfooR+TyJcv8BQDPmPYurD5AnN2rgyBRw7@nongnu.org
X-Gm-Message-State: AOJu0YxykaSnQnMkyJpSL70lmkeUmrJhD7yYUQYgTirwGuAsi52FyxSk
 cAF8Syjrevlu+rDK30AP2EVViEruzCLgDOS1cgWZTnLsFZl+z6BbJBCxa+axjDo=
X-Gm-Gg: ASbGnctvBBdOhe07jVthp7dcP0K+rOxfqhG9N21lhMusTAmd90urO3SS1CWKP0HUUxe
 l1q5SdYvBORI0ESZ3TUEZjE8IOh+Vu9uIuSFekJdLnHMSs3hsr0cZZnVkAWbNffcGJbLV8V4a9I
 U/z3JqHTgB5NnYCFU9ML+/R9kmU5pPiwhlDyvnot1uCH+2hkN/h/r23RFwXHdZbkZL1+1VlSYvc
 i5lS8mBo0aEYOEFoU56T8H8Bg8xbjlbRroldIeJybDOpSV+qTZAH0Lhq36HwMkYRH9ucqoD1teC
 eg8tJTzGAAGhTsGGk6TWFG00cd1RxE4LL2Z8XxsX4Gmiap2ygenEjDtZ5B1n5mOE3xk1JHw0fdu
 hqOhIJ+hu
X-Google-Smtp-Source: AGHT+IEbc1KrAh0XvidFeW35K4/VZhmjwCK5jCAJNnQalvI4sPqSGFDmHqa7Q8vQx9veG7VHjbda8Q==
X-Received: by 2002:a17:902:ea09:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-22993c09e21mr41028955ad.15.1743698569175; 
 Thu, 03 Apr 2025 09:42:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978771c07sm16751755ad.212.2025.04.03.09.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 09:42:48 -0700 (PDT)
Message-ID: <215773f1-d901-4200-b278-e2f6e4b91135@linaro.org>
Date: Thu, 3 Apr 2025 09:42:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 23/24] hw/core/cpu: Remove CPUClass::mmu_index()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250401080938.32278-1-philmd@linaro.org>
 <20250401080938.32278-24-philmd@linaro.org>
 <03556e83-472c-4ac1-910d-bff29fa3ba58@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <03556e83-472c-4ac1-910d-bff29fa3ba58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/1/25 20:50, Philippe Mathieu-Daudé wrote:
> On 1/4/25 10:09, Philippe Mathieu-Daudé wrote:
>> All targets have been converted to TCGCPUOps::mmu_index(),
>> remove the now unused CPUClass::mmu_index().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu-mmu-index.h | 4 +---
>>   include/hw/core/cpu.h        | 2 --
>>   2 files changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
>> index 651526e9f97..a87b6f7c4b7 100644
>> --- a/include/exec/cpu-mmu-index.h
>> +++ b/include/exec/cpu-mmu-index.h
>> @@ -32,9 +32,7 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
>>   # endif
>>   #endif
>> -    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
>> -    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
>> -                                 : cs->cc->mmu_index(cs, ifetch);
>> +    int ret = cs->cc->tcg_ops->mmu_index(cs, ifetch);
>>       tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
>>       return ret;
>>   }
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 60b7abaf49b..10b6b25b344 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -104,7 +104,6 @@ struct SysemuCPUOps;
>>    *                 instantiatable CPU type.
>>    * @parse_features: Callback to parse command line arguments.
>>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>> - * @mmu_index: Callback for choosing softmmu mmu index.
>>    * @memory_rw_debug: Callback for GDB memory access.
>>    * @dump_state: Callback for dumping state.
>>    * @query_cpu_fast:
>> @@ -151,7 +150,6 @@ struct CPUClass {
>>       ObjectClass *(*class_by_name)(const char *cpu_model);
>>       void (*parse_features)(const char *typename, char *str, Error **errp);
>> -    int (*mmu_index)(CPUState *cpu, bool ifetch);
>>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>>                              uint8_t *buf, size_t len, bool is_write);
>>       void (*dump_state)(CPUState *cpu, FILE *, int flags);
> 
> And I'll squash:
> 
> -- >8 --
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 8057a5a0ce8..b00f046b29f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1077,6 +1077,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>           assert(tcg_ops->cpu_exec_interrupt);
>   #endif /* !CONFIG_USER_ONLY */
>           assert(tcg_ops->translate_code);
> +        assert(tcg_ops->mmu_index);
>           tcg_ops->initialize();
>           tcg_target_initialized = true;
>       }
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

