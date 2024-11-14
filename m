Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A905D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf42-0001nA-PC; Thu, 14 Nov 2024 13:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf3b-0000t5-Ti
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:59:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBf3a-0000ro-9H
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:59:07 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20caea61132so8942965ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731610744; x=1732215544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1tz4130t+lbSaAcybO/XZoiHinIKq2xaWf06ccWtIVw=;
 b=S3L+CEZbnOhLsQY9aGnfEIX0mTVMiJWDmQNRy7+VW6TZbwjzhqlfriTKjHixRKBMkx
 g605lIj9loAiQ8ikw7s+13Yl/JAOMnYpP9XJL/++fv1bPezt2icoKg+0HBnUME3dNFpT
 tsz0FRNugXg4Lc02knvTCYoqXL3fEe9rG4SCGw8W0hnXdqiFcaL75/HYVmdjzEbMIK8Q
 /0mF90BRBVuvZGWJQiJYLZ3aSJGQrnkXr4RHg07BIeLLsIyxP+GMrMoRxKUAHtyJqwoC
 1Ne4kEoYEdJYA21x1E4f1KEc25TVGYRai4z6KoKCyR9ZW2sbhi7mL2LNHbLYL+bGhgLY
 Wpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731610744; x=1732215544;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tz4130t+lbSaAcybO/XZoiHinIKq2xaWf06ccWtIVw=;
 b=jDrkxzu9Hf7T2sfyKViTX1rs9SGt3mvseJMG71pFFdf7YObsnl5hM3Z7npxQQ3ouGz
 Xl/ea/8vY1D0QfOfq5aDAR+mMbmyV38Z3vK008IlyNQXPJjPZg4IWBVt1d1I82x3KWHo
 nl3Ip328mnXjw8rz85lTspP+phnUKiKCqIT6STpgI6gop/mD2xsIJcWgySU0Uhq/rTPO
 XL3gtrHTbmzqVoXIqDPGvx518eLiIp3QTd9vgwbjY6ZAHfwp8FfU0S2j3WoShu8mEppa
 GhIBRhce8DUO9UzhsxFB6Gec2OLmYH4jJqnbaiGrlhV7B1rvj4yeeGQuuAxU6IJ9yc9E
 dM/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLaCTj5joyNTsZ6bRa0q9S6/FeJAwpyODBs1a3dmPRrEb+g6SU058DRnO3kGVOgQ9/mI/l92AAXv74@nongnu.org
X-Gm-Message-State: AOJu0YwnOb/kBrgUTBRObEHmgxOU8J77IBvNra8O55JtCVno0eauQJ8k
 2oRevwXOXXM2yKu6/ZfOuJfCjKNe//ocZrw+25rxifi+A0vQGBP7MxCcoCb6ck0=
X-Google-Smtp-Source: AGHT+IHogG507l5uIfSMju4FAF0XSvDU6ick8F+dKKaSx8UWNGhxzG4o2BBtRfO4vBTKRbpLgdOF+g==
X-Received: by 2002:a17:902:f54d:b0:20b:ab6a:3a18 with SMTP id
 d9443c01a7336-211c4fb4c4emr32250705ad.17.1731610744659; 
 Thu, 14 Nov 2024 10:59:04 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c2c97dsm13978065ad.25.2024.11.14.10.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:59:04 -0800 (PST)
Message-ID: <52b3c03d-af8e-4122-90b5-7767f940dc24@linaro.org>
Date: Thu, 14 Nov 2024 10:59:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 54/54] accel/tcg: Return CPUTLBEntryTree from
 tlb_set_page_full
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-55-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-55-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Avoid a lookup to find the node that we have just inserted.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 20af48c6c5..6d316e8767 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1037,8 +1037,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>    * Called from TCG-generated code, which is under an RCU read-side
>    * critical section.
>    */
> -static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
> -                              vaddr addr, CPUTLBEntryFull *full)
> +static CPUTLBEntryTree *tlb_set_page_full(CPUState *cpu, int mmu_idx,
> +                                          vaddr addr, CPUTLBEntryFull *full)
>   {
>       CPUTLB *tlb = &cpu->neg.tlb;
>       CPUTLBDesc *desc = &tlb->d[mmu_idx];
> @@ -1187,6 +1187,8 @@ static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>       copy_tlb_helper_locked(te, &node->copy);
>       desc->n_used_entries++;
>       qemu_spin_unlock(&tlb->c.lock);
> +
> +    return node;
>   }
>   
>   static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
> @@ -1266,18 +1268,14 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
>           tcg_debug_assert(probe);
>           return false;
>       }
> -    tlb_set_page_full(cpu, i->mmu_idx, addr, &o->full);
> +    node = tlb_set_page_full(cpu, i->mmu_idx, addr, &o->full);
>       o->did_tlb_fill = true;
>   
>       if (access_type == MMU_INST_FETCH) {
> -        node = tlbtree_lookup_addr(desc, addr);
> -        tcg_debug_assert(node);
>           goto found_code;
>       }
>   
> -    entry = tlbfast_entry(fast, addr);
> -    cmp = tlb_read_idx(entry, access_type);
> -    node = entry->tree;
> +    cmp = tlb_read_idx(&node->copy, access_type);
>       /*
>        * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
>        * to force the next access through tlb_fill_align.  We've just

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

