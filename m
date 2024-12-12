Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2110BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkoz-0003nn-Dm; Thu, 12 Dec 2024 10:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkor-0003nM-Kp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:09:37 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLkom-0002wz-Qs
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:09:37 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5ee9db85af0so983738eaf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734016171; x=1734620971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9oF6eQQlS69dSBYxXXRL6GlPIpFaJ6sU/s45Vqo82HE=;
 b=loAa5cTe/ciCy51XvgNs6c+7b7bMomy+Sf+u6RWH7B5oeNhw1VzjK9uos9CRw9Fc0t
 NRVbX4rRNPdWY6BdxthFQdQvG/wa7CdRprVUYMeQNDjoqxp5jI53s9cxRyi2XjmdmhK2
 cLaDycIcoxv9GpjE0OpxUSy49V29QxwG5Rqz87AHmpI4ZydDA1h7apNm6CZdA5i27DfM
 KADn4EndEbVoVeRF0ItWSt0PEVOZ7kKDCvd2vrTPWJCfN1PqB2DboSXKgxWVgPxVzKlW
 6cEOdUAFQuTdTt4bdG+PLrlpojs4uJQEeFzjUi6kWHz2o3aQDAtAWH5OaF/2hHS39UyA
 sA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734016171; x=1734620971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9oF6eQQlS69dSBYxXXRL6GlPIpFaJ6sU/s45Vqo82HE=;
 b=SvlxTjaZjJdQZLJjYNcbUtUXEBgcuUsvQ1AxX2TZH641JwMX2QDRtvaJKf2FAUfTSK
 PzM0K3vHt7jXHp3WuMcQ8D02uHTj4MIkg9XCeixfFkom/O/5xpsF0GQXjRaSQfPBX8o1
 fZuwj8iEfTRIguh1UyGKvViNR89tCyQe56ewxsy72c3W8S/lKRla+98SyaSHfzuZEtFc
 pcGXTaKO1mnpSW5xOIFueaE7kFI3INilMcYXJEw+Ur0lXmkeiQ6FuSRHuDntf9cO0Qbw
 PIFvZWKHJBpZGHHOyUQbfX9dHByFzEJrwax8U53qsmrAjM3eFGb2ydKUQAfwWtlNpAp4
 Gg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlTYPHtXFvpXMsORr4CgK9B3wPVGhmU/zfJDZPuULcThkXPltLyFT2PJYuFN2He108RozyKgb9QjjS@nongnu.org
X-Gm-Message-State: AOJu0YzD6Ioy3Yjah5TCQfh98xweOSvkXnS8ro84ZXTmp/Fsgd7F+HfC
 zwjBfF7H/UJCa8M856mHR0LO8f41Rjl+vftrbgpD/fIJV2aZE83z1KnyqO/FEMg=
X-Gm-Gg: ASbGncsATPMAN3TttcRhtG8NtqxinxY/ZTyo/1RQm21Y2cxH/SAlVNw1O9tHXd0B5cv
 zwQDXmD0Ovz6DNrDIFwBNJxyUDtb/nBQQwpmU35ouzIiqBEQR74gX6kK+WQy9Kp2kYOGRHczFhq
 o9z1V/z8iNTCvHPbDJ6cMQ039lNRxnsjTr3cHcKlKYNvr2CqtECRMZwIDdqeTDnPsj/N+UD73tc
 80T62bSh4E/UolAs3OQdypw+Y2omw1kGtHNwTJdH4S+vAB+Xi5+ORoxSVqRU8KRr/FrIewQuivO
 HueDJmsQtgln6lbIlN/YDZiHbiVpg5OHaeY=
X-Google-Smtp-Source: AGHT+IE8mnkZUo62wf6lhxLB0qwF6/+JJVW+22AV8dOQ15tmIS2AWPKHVCFXNNbYNui/WaoLsCdr3A==
X-Received: by 2002:a05:6870:b13:b0:29d:f65b:85fa with SMTP id
 586e51a60fabf-2a38541ba0fmr1881820fac.10.1734016170728; 
 Thu, 12 Dec 2024 07:09:30 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f9b53b838sm3294255fac.3.2024.12.12.07.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:09:30 -0800 (PST)
Message-ID: <6bcfeea1-de10-4ca9-839d-c195ac52c506@linaro.org>
Date: Thu, 12 Dec 2024 09:09:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] accel/tcg: Move tcg_cflags_has/set() to
 'exec/translation-block.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241212144430.66224-1-philmd@linaro.org>
 <20241212144430.66224-2-philmd@linaro.org>
 <fa492acd-9fc5-4c90-9441-aee632c8c511@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fa492acd-9fc5-4c90-9441-aee632c8c511@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 12/12/24 09:00, Philippe Mathieu-Daudé wrote:
> On 12/12/24 15:44, Philippe Mathieu-Daudé wrote:
>> The TranslationBlock flags are defined in 'exec/translation-block.h'.
>> tcg_cflags_has/set() and curr_cflags() use them, it is more logical
>> to declare them in the same place. Move them there too.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu-common.h               | 6 ------
>>   include/exec/translation-block.h        | 6 ++++++
>>   accel/tcg/cpu-exec.c                    | 1 +
>>   accel/tcg/tcg-accel-ops.c               | 1 +
>>   accel/tcg/watchpoint.c                  | 1 +
>>   linux-user/mmap.c                       | 1 +
>>   linux-user/syscall.c                    | 1 +
>>   target/arm/cpu.c                        | 1 +
>>   target/avr/cpu.c                        | 1 +
>>   target/hexagon/cpu.c                    | 1 +
>>   target/hppa/cpu.c                       | 1 +
>>   target/i386/cpu.c                       | 1 +
>>   target/i386/helper.c                    | 1 +
>>   target/loongarch/cpu.c                  | 1 +
>>   target/microblaze/cpu.c                 | 1 +
>>   target/mips/tcg/exception.c             | 1 +
>>   target/mips/tcg/sysemu/special_helper.c | 1 +
>>   target/openrisc/cpu.c                   | 1 +
>>   target/riscv/tcg/tcg-cpu.c              | 1 +
>>   target/rx/cpu.c                         | 1 +
>>   target/sh4/cpu.c                        | 1 +
>>   target/sparc/cpu.c                      | 1 +
>>   target/tricore/cpu.c                    | 1 +
>>   23 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 638dc806a5f..bdeb9d68f32 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -187,12 +187,6 @@ void list_cpus(void);
>>   #ifdef CONFIG_TCG
>> -bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
>> -void tcg_cflags_set(CPUState *cpu, uint32_t flags);
>> -
>> -/* current cflags for hashing/comparison */
>> -uint32_t curr_cflags(CPUState *cpu);
>> -
>>   /**
>>    * cpu_unwind_state_data:
>>    * @cpu: the cpu context
>> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
>> index b99afb00779..c1e48a48aab 100644
>> --- a/include/exec/translation-block.h
>> +++ b/include/exec/translation-block.h
>> @@ -153,4 +153,10 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
>>       return qatomic_read(&tb->cflags);
>>   }
>> +bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
>> +void tcg_cflags_set(CPUState *cpu, uint32_t flags);
>> +
>> +/* current cflags for hashing/comparison */
>> +uint32_t curr_cflags(CPUState *cpu);
> 
> Per this comment I suppose accel/tcg/tb-hash.h is better for
> curr_cflags(). Also because it is internal to accel/tcg/.

Given the usage of curr_cflags() in accel/tcg/watchpoint.c, accel/tcg/internal-common.h 
would be the place.  tb-hash.h strictly concerns the hashing itself.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>





