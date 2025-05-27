Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8C3C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 20:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK1Aa-0005UQ-7Y; Tue, 27 May 2025 16:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uK1AY-0005UH-Ia
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:45:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uK1AW-0005zT-JK
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:45:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23278ce78efso26621025ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748378703; x=1748983503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYs2uaNZgsl5HyMBdzwahAqoaYYS2Fp8V5eJTBvga5w=;
 b=bNT0NvLF2945mUIV0IW4oaVRH1zETDmtxpdZJ6WJIlw4kFAkBlwtZtQmjqadTE8uL2
 IWGLqVg+1ylEBj+GEoZR9Gh6LZSZoEJWKrsxd0zkZWtof+3TD78UdIbX4WW9mMCHyWsW
 3Qd8qjYP1h7h8PGo0Zd/a1YynaKE4SC7j8/S3UMMBM+af3bQ7AJ6h/mQbNxgbxnKS4DJ
 bEppXWM+jAj2GmPCq73KUdi5kjRbGvp4Ogeye8mMrPzGoaZBVHLg6qLibfelxP1kWK4H
 pdw+cxuBeNjMa63Ua8Rc/s+znwio2RRiNEoE9Xby/gjIEevrlh+79WYPhtO6TscjHyWC
 j81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748378703; x=1748983503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYs2uaNZgsl5HyMBdzwahAqoaYYS2Fp8V5eJTBvga5w=;
 b=IrmEIZKo+qHTgT9uiX7seL/9lAC7FE0srXceu7hmWrWHju78gLMV2sTzD69p0nuE8A
 tmkr+NNJf7NZj6NiXoeiRu4Uw2qdSzbVyOGoDweTqLRObvIayK1UHJkR5b5qPKhY2jzH
 Tx3Oc7xlz/uXGSMOfdy6CmQLACfDbf25JjiKT/gt2L/ZtusrwxqZwFhxa92AqCQnFajX
 dpA9MCpS+XIVnhwCrYCD79FA/LHMOqk1yJQm8kB9luigfWZJNWTUPKKHuEG9i1UBjScf
 Nj8YepKIv7bhUdxojUg9IFkShI0NJgMBzJiKGRu39fM4LY6m4XFyYjJfY/2AUbthbtWg
 lUSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx5JcnRa+78tDOgZjxOslY8rvu+LqxWeqgmQpj/G/vwtXAOfwmYEElmbSdxgYNcewAPSlrLQS++P7f@nongnu.org
X-Gm-Message-State: AOJu0YzfqKY+Ab04olQ/ebi/p5QPtLxLRK+lx0yZ46hbYWoRaoGxjprf
 0kMUTpMwmHpoosFFtC8b0SMn9SSku82waee1QbWUt/H01JO5bPvuGVI+tZ3k0wU/7z4=
X-Gm-Gg: ASbGncsJrIc6/nfdQP7Ck61Nk0YCtztMd64NS99xfKOghRw97OV3KqNg6/5JNLdnoOF
 ptehwYUkt5FiHONOnu5NJ32a1R2kZJxFV4ozBavq3KIatIZpsmIjvPKIhSoRgnpd4q/rNOthpow
 9dqS96NLkS9fTt3BQITaV7mG7M61SB6jGc/7IzsQWPZFelhh7EOni8NpM7bO4z2c1K1qc3bXBAG
 O96910oxtoU8uzZGdox0Z5Kkba4EC3WWk/iQJYuq58Vq6WIZ5zzNn7SV79SoELgJm4Dc8MoUOkR
 UyBojW2J+RX9mfrD5wMYjNnCn5XcBJ2YMWZL/RYmh3SfNfXHCDuN+dLPO329ign/
X-Google-Smtp-Source: AGHT+IEhlYEt+ZohX0e/z8ZyfaQtaiue2lnqPwdTfrmFxd7tUAFbHPlhTnEysRHHO7C274i3gI9L8w==
X-Received: by 2002:a17:903:1a4e:b0:232:e33:1375 with SMTP id
 d9443c01a7336-23414f96401mr209194725ad.28.1748378702853; 
 Tue, 27 May 2025 13:45:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234cc11fd56sm132035ad.83.2025.05.27.13.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 13:45:02 -0700 (PDT)
Message-ID: <23fce516-74ca-44ca-9cfb-e3b632a977c9@linaro.org>
Date: Tue, 27 May 2025 13:45:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250524144031.49810-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250524144031.49810-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/24/25 7:40 AM, Richard Henderson wrote:
> When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
> we failed to update atomic_mmu_lookup to properly reconstruct flags.
> 
> Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5f6d7c601c..86d0deb08c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c

[...]

> @@ -1882,13 +1886,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       }
>   
>       hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>   
>       if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
>           notdirty_write(cpu, addr, size, full, retaddr);
>       }
>   
> -    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
> +    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
>           int wp_flags = 0;
>   
>           if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
> @@ -1897,10 +1900,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
>               wp_flags |= BP_MEM_READ;
>           }
> -        if (wp_flags) {
> -            cpu_check_watchpoint(cpu, addr, size,
> -                                 full->attrs, wp_flags, retaddr);
> -        }
> +        cpu_check_watchpoint(cpu, addr, size,
> +                             full->attrs, wp_flags, retaddr);
>       }
>   
>       return hostaddr;

The watchpoint part is an additional cleanup, (BP_MEM_READ or 
BP_MEM_WRITE implies TLB_WATCHPOINT is set). No problem to include it 
though, it might just be confusing for the reviewer.

