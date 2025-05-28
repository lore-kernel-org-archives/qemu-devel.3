Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E34C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 06:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKAUZ-0002sM-A9; Wed, 28 May 2025 02:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKAUX-0002s8-7r
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:42:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKAUV-0005iK-Iz
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:42:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a36f26584bso2528726f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748414536; x=1749019336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gh+KW/eukMcAFW/xleg7ksiDaY7hWmk+kL8GTBQvtvk=;
 b=nCspr4zBtEBWxZtrnNTfjUFvXcF+wZ31cC81roB4ZKiR7FvbXdNSyi3ms0BLThD3mS
 wr1bg9fXQuDkzmK++vsHp9D1bcmoSQJH2aDHwWX5eJPuyxinmiy96W/w6KR/V4XJCg7B
 jotnQL6HFbCV4tYCxNkgM5aJReT9+yuKU1RqFrEYIZARNOYiNJCoUA7SUjIJJUf3oAWZ
 jmSbdV2800/0uDWJbi02Ef4L+Lxi/gS9QYVPkqd+5qwomKa4OkgnjRvNbpQCt+kygKxq
 kpTIjSWwwLu9kZ3pwEKPhjz5BQbgW7D4xce9I/77IYhI/Tuee+1gZJHABQ8Pvbp8Y17A
 du+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748414536; x=1749019336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gh+KW/eukMcAFW/xleg7ksiDaY7hWmk+kL8GTBQvtvk=;
 b=WmmK9o49iu/UVt+1/QbFV1LMkpnFz9Z2fa8LUFIAkcWXUpDaI2xqEzqtN+gy9Qszcc
 QpljijlaPQ/dQA8NmgJCRvKPR3u7nqa6oOn3ll2Qnlnr8MMyWQ+NOdRgEtkdxxmKT7Ku
 E8Y2iTUSDXR23Kk8UL0iNdJlCIYCPeRy29tOU453m7X3isdwOQbCaggx34nGL8FhgqMm
 Zkvh1+SebipbEXUUkeMHsqLVcSE5yg+o7pvDZVx0XOhiPKtVsBONOQ/j1vKXnH2Ainnk
 YAIAY015NwnwrZUIp4m6Dx0uuXAKd5UhG4WeLWbNTjYrWOQdGrpgCxw6hKVD6UBg0U+Z
 rBzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr40JaSpkDefKB+rUT2uKlxeqspzMGeWbniiznN7UIlnKVEPSFyA9Im/6PiLXwS0BXQ5wIu/3g1Wms@nongnu.org
X-Gm-Message-State: AOJu0Yy9tU+fby+Pfyefboe4YUxrlVS90cDy6ceuVdVoF9KkOqO9eMuh
 sy4Losh49lUKn6sE+lp0Sm3lYSeZGunzMYX72oA6GJgr1iMOSA7M7ZqxUPz6W2f/lobnnbS/3H+
 AvNhkS3uGAA==
X-Gm-Gg: ASbGncvUX61Uka/b/3hrRlkbNVvSOZIoOWbYIlHmhiA6xoHy+Lf35Obc1dgOf3n9FTY
 VdatlWiaz4sodv+99jv2vT7Jl6K6Bj0sHj4BT6xg5MnyRkhyfVdAlTB6SlLfbty3uVYQ4iIv3mD
 Od4MyBTyTzxNSOGngtn0rTHMRRdLKI4F/jN+0GzJ4Sa2kFhVcKCraJATcCB/yHh3uUqI7ys0fcw
 lbie4bDlbeUFJp1U8uIMN4ujhzHh3NNB2uvXE1eQsTR1HnOydT/RCx+q3B6oCns3VVkugYxS8Ic
 8FqUsTpvncePqgj/qL5b6svWrcgJ+7JvzkBnWqbk7rpAGbNCjQUG2lkd+du5k9Heig==
X-Google-Smtp-Source: AGHT+IHV/lGVXLFz31cZh7CJt15bGQhU89RDIshWNAjKvY9aAcfyaxw4LGjwNvXOwWYGMMUr+6FOWQ==
X-Received: by 2002:a05:6000:22c8:b0:3a4:dbdf:7147 with SMTP id
 ffacd0b85a97d-3a4dbdf7452mr8368091f8f.54.1748414536233; 
 Tue, 27 May 2025 23:42:16 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450064a1b96sm10985855e9.13.2025.05.27.23.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 23:42:15 -0700 (PDT)
Message-ID: <bb371110-1561-4e38-8783-c6ba3073a0ad@linaro.org>
Date: Wed, 28 May 2025 07:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250524144031.49810-1-richard.henderson@linaro.org>
 <23fce516-74ca-44ca-9cfb-e3b632a977c9@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <23fce516-74ca-44ca-9cfb-e3b632a977c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/27/25 21:45, Pierrick Bouvier wrote:
> On 5/24/25 7:40 AM, Richard Henderson wrote:
>> When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
>> we failed to update atomic_mmu_lookup to properly reconstruct flags.
>>
>> Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
>> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/cputlb.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 5f6d7c601c..86d0deb08c 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
> 
> [...]
> 
>> @@ -1882,13 +1886,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, 
>> MemOpIdx oi,
>>       }
>>       hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
>> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>>       if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
>>           notdirty_write(cpu, addr, size, full, retaddr);
>>       }
>> -    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
>> +    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
>>           int wp_flags = 0;
>>           if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
>> @@ -1897,10 +1900,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, 
>> MemOpIdx oi,
>>           if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
>>               wp_flags |= BP_MEM_READ;
>>           }
>> -        if (wp_flags) {
>> -            cpu_check_watchpoint(cpu, addr, size,
>> -                                 full->attrs, wp_flags, retaddr);
>> -        }
>> +        cpu_check_watchpoint(cpu, addr, size,
>> +                             full->attrs, wp_flags, retaddr);
>>       }
>>       return hostaddr;
> 
> The watchpoint part is an additional cleanup, (BP_MEM_READ or BP_MEM_WRITE implies 
> TLB_WATCHPOINT is set). No problem to include it though, it might just be confusing for 
> the reviewer.

The watchpoint cleanup is required, since I remove TLB_FORCE_SLOW from the flags.  I 
suppose *that* isn't strictly necessary, but it's what we do elsewhere while combining 
"fast" and slow_flags.


r~

