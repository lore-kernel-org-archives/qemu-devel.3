Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7D6C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 19:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9r0t-0001Oz-Ht; Tue, 29 Apr 2025 15:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9r0s-0001OT-MH
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:53:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9r0q-00050N-TU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:53:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so5417772b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745956383; x=1746561183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XaBxRpnoBWKEp3SnY6Xs3PMyoDZCa55c4hwoLvDCTHo=;
 b=iDiRiSE4Gq5ckC80DqI/a/A9x5KjI0izT9xwMXH7HBzbRLqP+OVBoraeFimh50xITz
 XrCv1hpRm+UPZxWQx4eeURWKlqeLjQ83n5NH9YQY6lOnbc0SfXAwMRBAfdiWhuRjyrog
 Imbt/nrjCJ81OB44Ear+O9O3lhHVI8jjKGGt2U3C0C76/cc1iiZZyMHjgs8Gpzm/q9/N
 LeSMJY0bT53oA82FM3wadf+Agr8rXXbS85TK9zgyuCobXbwsJ4z8y/sevEYI4Y18SBkO
 xvonJ7/8qdDGhlOcQpZGnC5JYXdQXSHEdBCSQyXsvIazDIWZFybnw5AeaNhC39TgWvNs
 2YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745956383; x=1746561183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XaBxRpnoBWKEp3SnY6Xs3PMyoDZCa55c4hwoLvDCTHo=;
 b=ZsxTEKCMZ9LWjw8CC/UIzT4psF1mMhtdaT3Rxjl8UKZZsa3XlK8WOSqPjI6R+2CnTZ
 bWDzg3wT6hviqRCWmLLyC5EZCIQT8s4UjkIzZDLdhxtWzv2KM+etJ0O51ghrTKJ02tip
 UNPWCw2ttNp6mrtxEbiKaiHxkYWVwXD30hMekzKlKapVGKVsz1K9b8LHPMOkE6X55rHK
 S04jULLtdhBNuQj2q79LC5UlZ8sEdTqLqAiypgCkHzGMO36OEjip6jfH29orPm/AEa1e
 T2hgPOYwryQrdH7znrhq0whUL9aqOONNo023mUH5apXX64U2U+VVfn6MOEQ3pF959MkJ
 j/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUosggVznr4ma4175bXWdP6/3Gck9Ll9kx6yf9q+TPzSdEI0V0d6OCPSNO1tq0SRsjXcshIsPju+OpI@nongnu.org
X-Gm-Message-State: AOJu0YyGqXxLwP2xxb3OUJDoRUgoF/YnoXeogTVBeK5l2J+lWu2EWOHk
 mpFP1HKcvAn95zbfZKQZLu9yuXUlBYUH2VXwSnM/0n0NdPayzhPdAjcbArzftbg=
X-Gm-Gg: ASbGnct3QtCyXVJEwNhjXAwJxwWRhlj7GeqJB6cUXXK1NGXl8H1EBzCBRRUOvP/fney
 qjhIXcPR8GyxUK6GG54++lSslo2IVbEuXRfRFGwpnI0aqS47PaLVh93bYfkxoV5qDdM4SYYwbes
 TopL4Kx8dL958Su3VMgE8Gx04jXKUQoZjZxMqHdoWZEEfcrpZbZow+OL7F177q+3OKLlW/57xMi
 op0o/Dk0nIbjQ4vTmKJxDnPYmNk/Dt/SUSpXzNdeGEDzJh8mcCwub7cpHtKvKeKKM90pQcP1VtY
 2RaO+rtscVbKKqATO/LkZt4WMLDBYTgsssSrchlUgk5rfBm2mvQGAR1oskhJaJ0znIeNvRhfKaM
 EwlIldyU=
X-Google-Smtp-Source: AGHT+IGFyM5ZpfJvtmMRaddXLi1yUxQE+djz0FdfE3L1cbFLFiueaWBu5DpLDIsz/DfOKQZGHSuF0w==
X-Received: by 2002:a05:6a00:3a0c:b0:73e:10ea:1196 with SMTP id
 d2e1a72fcca58-740389a1830mr885713b3a.8.1745956383039; 
 Tue, 29 Apr 2025 12:53:03 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740398f9fc8sm79802b3a.16.2025.04.29.12.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 12:53:02 -0700 (PDT)
Message-ID: <3782bdb3-3b59-4648-9cb5-ebe552e4e15e@linaro.org>
Date: Tue, 29 Apr 2025 12:53:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-4-richard.henderson@linaro.org>
 <b7c96493-c10c-44a8-8ab9-7879837fe143@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b7c96493-c10c-44a8-8ab9-7879837fe143@linaro.org>
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

On 4/28/25 23:44, Philippe Mathieu-Daudé wrote:
> On 28/4/25 22:10, Richard Henderson wrote:
>> Initialize all instances with cpu_reset(), so that there
>> is no functional change.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/accel/tcg/cpu-ops.h | 2 ++
>>   accel/tcg/cpu-exec.c        | 3 ++-
>>   target/alpha/cpu.c          | 1 +
>>   target/arm/cpu.c            | 1 +
>>   target/arm/tcg/cpu-v7m.c    | 1 +
>>   target/avr/cpu.c            | 1 +
>>   target/hppa/cpu.c           | 1 +
>>   target/i386/tcg/tcg-cpu.c   | 1 +
>>   target/loongarch/cpu.c      | 1 +
>>   target/m68k/cpu.c           | 1 +
>>   target/microblaze/cpu.c     | 1 +
>>   target/mips/cpu.c           | 1 +
>>   target/openrisc/cpu.c       | 1 +
>>   target/ppc/cpu_init.c       | 1 +
>>   target/riscv/tcg/tcg-cpu.c  | 1 +
>>   target/rx/cpu.c             | 1 +
>>   target/s390x/cpu.c          | 1 +
>>   target/sh4/cpu.c            | 1 +
>>   target/sparc/cpu.c          | 1 +
>>   target/tricore/cpu.c        | 1 +
>>   target/xtensa/cpu.c         | 1 +
>>   21 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
>> index 60b5e97205..3ff72b8d9d 100644
>> --- a/include/accel/tcg/cpu-ops.h
>> +++ b/include/accel/tcg/cpu-ops.h
>> @@ -155,6 +155,8 @@ struct TCGCPUOps {
>>       void (*do_interrupt)(CPUState *cpu);
>>       /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
>>       bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
>> +    /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
>> +    void (*cpu_exec_reset)(CPUState *cpu);
> 
> I'm not sure "cpu_exec" is still relevant these days, maybe we can
> directly call it "cpu_reset()". Anyhow,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

It's called from within the "cpu_exec loop".


r~

