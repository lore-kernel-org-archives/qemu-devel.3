Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1027C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcKf-0007GH-S1; Mon, 26 May 2025 14:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcKa-0007Fj-N3
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:13:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcKY-0005wD-2a
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:13:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4c9df6f92so2147875f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748283224; x=1748888024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MX/2oQovkWhnKf4iB+xkHA5twOjQ9CshfHVlUM5TGYw=;
 b=jHf7nvUfax5N1W5ERj1M8PdsATaR7TRFjBXJenuyEV6ZpdgrEggO/P3L/7+tWCsufE
 vQToAUHIDS+eJZuRXx+7JOxuwTA+8jTN1NEK4ZliUiOAl+Wlc54GgnFtBXTt6nUIjphn
 Dv312GUzaO3iV09O9KTtpnLQ0jMCaIHLHmGGNVYMZ+2rTF6P3TBf4WNRnSJ38PUByM5N
 GOMMbLC2q8s4j5UfGHenwSxe1EOvJaz4wuBAL+17wU1VrU8hyE7r0gQkzO3juYCm6BIC
 IZEO2oCb4eLF5PA1vBoSQhJ/Z6eIKs2Gp+NobIo8YOSz+1k2eSyC/A/djkf6WybaqAXa
 /2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283224; x=1748888024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MX/2oQovkWhnKf4iB+xkHA5twOjQ9CshfHVlUM5TGYw=;
 b=eKvmLCieRda7jO6nqDz+AZwUkR4puzW59nldkzA9i3zyaViplwDfIz0Orp4iC2Ntg3
 C8n0D8V8xlnFGLCIv4ZifdnrUD42A5JrqEVae44ULey+EqpoXyMfpKkhA6+FWrXYgCH+
 K0jQbSHt/hn5tSKThRBgXbMCKa0tyiy1QEnpR29AEoDUiJcCf+a5fkfF0yA8jtg64UHX
 LDTvnc7/Y6G4qBm9xDcmjtxbI7RSxKNRvTmZaj2pFdG4F27yTXfdLtaYIBgaMuv/8v0X
 jk/YFAAmx8BRK5G8xVJl4mBRrGMm721D+w7q+njc4uzU5W9HayQVKSGdW5jDwmWdtX4R
 bO8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9E8Fq2IyA3QtUMGLB0uTJl8gicEEdO3LB8jw16H2gR6natDbBgJ5Wv+RI4EiTBKgsLfa7C7INxTW1@nongnu.org
X-Gm-Message-State: AOJu0YwNmP8muDQ4J21S0U/6Rsu6cPzyIcgt0cMz/eIbEuD7ULzfVBc7
 sPAIAeGJ6xaeNk8DDZC3o0ktW4lliPaaKzw1qRCVJWE0y6XOpNmjSTzZ9rY+Fj3Zb/k=
X-Gm-Gg: ASbGncsVVBITNs+ephlPV85jtFggRba5sqg7qPTNdgr+Dbx/uiaxm2D+r66ebeybHtO
 0zaaIvsAZE1ZtKVFmpJ6yBpgHtZ8aE+t0k31qcT2z4o6rWHWz1B3CXLwjNuPJC4ncQGOW1OKqUk
 JpPmimLWr2MuGb0IVccTK7GugdwvvmWJuqJ2rIQCD3f3WYE6w6ZPVqedaq16zZQf/i6KWFSaO6Z
 ysS0SsfPVZMC6XCRzy7T62zJnGtgeYW30tcVOF5dlqa5II3q4vAwACO3sLCvX6GtASQo4FN5UAm
 osUHNAkQIXv9hE/B+Sa/fEz3wDmTYDeaN5KVA2f5AgRVEDQV0mAwh3RiLF+d1RifcHrjVsYrwhw
 n6HdMag5g5TDiyqcY2dc9Ayfx7ugOYlCkHyI=
X-Google-Smtp-Source: AGHT+IFQVusiXvWfI/MJ4+R++WwGhP+TkmMsdTqk5r4Vs/F6AWdJzMhJ3n8YmgpdvfrUeMRAufOmYQ==
X-Received: by 2002:a5d:64c9:0:b0:3a0:bdeb:c489 with SMTP id
 ffacd0b85a97d-3a4cb464b99mr8511204f8f.33.1748283223658; 
 Mon, 26 May 2025 11:13:43 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d74843b2sm4469754f8f.53.2025.05.26.11.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 11:13:43 -0700 (PDT)
Message-ID: <9d313409-5197-4abc-9213-4037aa563e96@linaro.org>
Date: Mon, 26 May 2025 20:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250524144031.49810-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250524144031.49810-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 24/5/25 16:40, Richard Henderson wrote:
> When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
> we failed to update atomic_mmu_lookup to properly reconstruct flags.
> 
> Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")

Cc'ing Pierrick

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
> @@ -1871,8 +1871,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           goto stop_the_world;
>       }
>   
> -    /* Collect tlb flags for read. */
> +    /* Finish collecting tlb flags for both read and write. */
> +    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>       tlb_addr |= tlbe->addr_read;
> +    tlb_addr &= TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
> +    tlb_addr |= full->slow_flags[MMU_DATA_STORE];
> +    tlb_addr |= full->slow_flags[MMU_DATA_LOAD];
>   
>       /* Notice an IO access or a needs-MMU-lookup access */
>       if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
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

Patch LGTM but this is outside my comfort zone, so better wait for
a second review ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


