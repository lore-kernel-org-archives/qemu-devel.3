Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6693C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 21:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBKou-0005Qj-Am; Sat, 03 May 2025 17:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBKos-0005QN-NJ
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:54:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBKoq-0001Iu-Vn
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:54:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227d6b530d8so30291585ad.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746309286; x=1746914086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8egesxN17cqZ0dc6fp9Kc2LxbU+ZhDHFMjM3QWxIJTo=;
 b=MGtxzfRhnKNeh90ze6TzU82BWoUVcYHteh1Zmw8rrDOVpXRPGNozyi4SdR0ECp1VTz
 zfDRTxqaBuZra6beZdJcMVeSyQxFbbrJtDH6WYfb62vusfvN9U7HjzwoVY4HHtlUQD2M
 KhWpV/l4b3R7lVjQXr7iz1f6ahexohGsXomBc2qTldh6TKRz2qcV1hFuroibcioTJ6Cs
 VXc5B3kcW35MNkKHNQIXsymjkMfxtMAAm1PsVrmo/Lig0merzeaFgETeFqvQoJpFeDXv
 cobYycb4tqzUnqWSY6TK9HybzkxefqihuU4cAnGehNQ1oB9HFLz4HdXA8Kf/bvlMT1ec
 Y72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746309286; x=1746914086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8egesxN17cqZ0dc6fp9Kc2LxbU+ZhDHFMjM3QWxIJTo=;
 b=WVY+fh02HKnleA13Z4d6k6ZPbs9UQoIfaQrX9gfA1TlqRvopLzWlgsBRK/B1Sf6k3/
 OUpiFPEAKok7DJIZWG/3WMjqHklRIbRCQ5G/mJIFJd0oFGZk4KIbWZpRvAwwGaRPBfw1
 3V2RQVitMxD6SQxCIcYCtIJP3UVszNu2bZq6fQdZMskuqDLbUNObtmkdpZAUmDi7AFsj
 1yOjZ8+gwdHTBqceGsoQEWYjFeKBpVkrvKUofLCVKcHYVa3rFjk8ZcTUlv25714Rxay2
 bDhYpQcHzHMvq3InrQnLHf+iOVEGrAet4f9N0ehxX4fXEXrHOddhR4RoRhn/o7GKQOHP
 1hzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz5LImSFdMGftUFxdC2kNwOhesLEZz8urMnOtZmJpiIX1LYx8E/cz0rdFMVxqlIbDo+1dihjQXZFd7@nongnu.org
X-Gm-Message-State: AOJu0YzlQ7ZbYiTwzvVymbMRXha+ozbffjrm7574wNNJJx5ZP5YQOvwV
 Ef9Q8T1GChsZvsctS1WWKc+a4ZmuhstGDOqFD8FFEVh+xuPVuKsAkG1NPFeNGGYy/YKgUoFIG6O
 osxQ=
X-Gm-Gg: ASbGnculBBqkmoB3FdQSPG5mA8jZ9rRtwbTNQb9jvv9HmR0Izmz9op1auThP7ybzgmd
 WeWQdmeE5i25FwlIS7FauFR0D1EkKgLujyr6QXpqB1ka+rAsJY6kkwQbKC2HpNstVOLxz9sA2ob
 meWrg+I4y5TEPrD8OaqPdJ3Bx1ZrNqVb3HZk++l4sDOl8mwtFj9naVZZitk4JhPnW/vKRAY2Vl9
 9I7xPgD2oixOf8W081n8SXB62AyRmOIGZS7YBw2PsSB9aCDV1JKaL05uNhgDl2gLltd7xHLDLfM
 qmiRFgMn0oSrnGxRj3qCytC0nQ0KTjCULjoiD7A02AxPepHm1MBkQQ==
X-Google-Smtp-Source: AGHT+IHqUyTV2oPY7FFs0inwI6ot7R54RcFhDq+LlJmRZ42OcG4Hr0D1+iatFhY+CtsMiQhL5RHdqg==
X-Received: by 2002:a17:902:f70e:b0:226:3781:379d with SMTP id
 d9443c01a7336-22e10353e7cmr118719275ad.33.1746309286678; 
 Sat, 03 May 2025 14:54:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fc49sm28331845ad.134.2025.05.03.14.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 14:54:46 -0700 (PDT)
Message-ID: <561ee7fc-a288-4fae-93ef-086af8857fd5@linaro.org>
Date: Sat, 3 May 2025 14:54:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/33] target/arm/helper: use i64 for
 exception_pc_alignment
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-14-pierrick.bouvier@linaro.org>
 <1844146d-18cd-42c7-a095-6d1b64ad6293@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1844146d-18cd-42c7-a095-6d1b64ad6293@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/1/25 9:30 AM, Richard Henderson wrote:
> On 4/30/25 23:23, Pierrick Bouvier wrote:
>> --- a/target/arm/helper.h
>> +++ b/target/arm/helper.h
>> @@ -49,7 +49,7 @@ DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
>>    DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
>>    DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
>>    DEF_HELPER_2(exception_swstep, noreturn, env, i32)
>> -DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
>> +DEF_HELPER_2(exception_pc_alignment, noreturn, env, i64)
>>    DEF_HELPER_1(setend, void, env)
>>    DEF_HELPER_2(wfi, void, env, i32)
>>    DEF_HELPER_1(wfe, void, env)
>> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
>> index 8841f039bc6..943b8438fc7 100644
>> --- a/target/arm/tcg/tlb_helper.c
>> +++ b/target/arm/tcg/tlb_helper.c
>> @@ -277,7 +277,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>>        arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
>>    }
>>    
>> -void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
>> +void helper_exception_pc_alignment(CPUARMState *env, uint64_t pc)
>>    {
>>        ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
>>        int target_el = exception_target_el(env);
> 
> I think for this and the next patch, it would be worth extending
> include/exec/helper-head.h.inc and include/tcg/ to allow vaddr.
>

Ok, I'll add it.

> 
> r~


