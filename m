Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBC9C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjJd-0005Fd-3z; Wed, 05 Feb 2025 12:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tfjJW-0005F3-Tj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:35:50 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tfjJU-0001Mf-TJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:35:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166360285dso1729485ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1738776945; x=1739381745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ixiab/9gnh2Z+mTAGAACielA9GpgARBsX0upzZOSq+U=;
 b=DPgZJ/hxnNQJ20i8ej3u45e9ykkowA9Km/HFNSnscOugn2YFhpu18E3+TnYSDu5Qwm
 mYDFaJmT5huvMAz8NHgHAuMVZbNSn/VXTe2Zb29a686R6HFhwDWKeInAMHCmjOuATPwm
 DUtFFIaGYu1TdRPzhiFypaIj/uuLaWhdD1LLHkOGrHr3sSFuY54ZD+y/CYL7ilCxUzyk
 aT9ukT/H916IM076XMWwghdq8cxBS8vGTCY47jRS7rwhx/bKIgAzR8n+IIE4ZZqXu2WO
 mr4yG3aMmdDY0HTbMAgRaw6L2UxnY6bGiPMIR8KnZAvt7S6vIFJt+couZ0E961F22dR5
 Hwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776945; x=1739381745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ixiab/9gnh2Z+mTAGAACielA9GpgARBsX0upzZOSq+U=;
 b=lCAg5NF1DtMrUtcHr3LuotzXymo+KsFCXcbdllmPuO05hU5sDlplphD4jNodUBPqm+
 rfmu0V5+JBEcvFZu6v72VMdqw3KJvW5DH/JGAtHq6nv1Qua1k6rCXLTvhjeu+8P9YOhI
 ph8rl0+ME3L0HmfP00vRKspU9NQtS0RC0R6fjwLpt9HXP/B+xaFBOBJBRERSFVNLs2CV
 iNtwQAMRKEeD50J98QV+2yCRPbKA7FAUrRvR8ynbSVn7Lkd/+pkl2U4RK7q+GLOBPTNo
 6QyRwxei2bNyph7MSGDMw6Acvi7owXaeWHbaH9YpnjQ0o9v4PtvhoxFBVb2SxmmIEPBA
 jufw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlTjW4kHGldvn1Qf6dJC45e0PWqCkzKIK+HnqkXjWYVxSbmF/E8f456BmNpiuZ4adNmeg+kfZYdhjI@nongnu.org
X-Gm-Message-State: AOJu0Yw8Dr4C7g5ClrAfmPHnBShUHrAjSkO0dT7P3kHjRP4G3QStqyy+
 fICfWlwlqkzAV3DjrVNmdhOUold8Y0zDkpmiWj1vnXm9BsHe25tn5Ewa2J76/g0=
X-Gm-Gg: ASbGnctvKemuRcHA1uPa5/ZO88V0gX8DWtGYX3UU9YtENA+OjiIpXJ9iA4Jpye4KtfC
 /dtWjJs1kDEGYWHCcjp/BDn9Cm4oKnH/VsX7M/HMBMS6hOnev9dbe4C+wMka/U472WMoThv1bTk
 +x9wuhJsVfqb0yCvGQT/o0GLmNs/4rs8EHkVfpo2c/wx1yW4FLF2QS9QmLhz8aMk5RcQRpAyrxS
 LItQODuhWOkl6txla3YxE9HlJbTeYe0YEeQ7acwi2+PFUKlrSuyXyVBSBequ+5Hu6SXlbF1GKFQ
 CUDQ3CrWXs406otBdCF+6I8e9VQfU7j7e3pQT59Cb/u6yb6Sj4V89a3MEIPdfzTz
X-Google-Smtp-Source: AGHT+IH1zNwMZViXMUPes3hBX7VaEiyoFTfF5IAxB5BQMjNzr+cGnyHH8qX7olE1bWS+Iz7kEm9ilg==
X-Received: by 2002:a17:902:e803:b0:215:e98c:c5c1 with SMTP id
 d9443c01a7336-21f17e74e67mr53507675ad.30.1738776945097; 
 Wed, 05 Feb 2025 09:35:45 -0800 (PST)
Received: from [192.168.68.110] (201-69-66-42.dial-up.telesp.net.br.
 [201.69.66.42]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f138cd647sm21271475ad.105.2025.02.05.09.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:35:44 -0800 (PST)
Message-ID: <2df9ae98-afb8-4647-be80-12540a1c4612@ventanamicro.com>
Date: Wed, 5 Feb 2025 14:35:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1 v1] target/riscv: optimize the memory probing for vector
 fault-only-first loads.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Jeremy Bennett
 <jeremy.bennett@embecosm.com>, Craig Blackmore <craig.blackmore@embecosm.com>
References: <20250129144435.82451-1-paolo.savini@embecosm.com>
 <20250129144435.82451-2-paolo.savini@embecosm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250129144435.82451-2-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 1/29/25 11:44 AM, Paolo Savini wrote:
> Fault-only-first loads in the RISC-V vector extension need to update
> the vl with the element index that causes an exception.
> In order to ensure this the emulation of this instruction used to probe the
> memory covered by the load operation with a loop that iterated over each element
> so that when a flag was raised it was possible to set the vl to the
> corresponding element index.
> This loop was executed every time whether an exception happened or not.
> 
> This commit removes the per element memory probing from the main execution path
> and adds a braod memory probing first. If this probing raises any flag that is

s/braod/broad ?

> not a watchpoint flag (that per standard is allowed by this instruction) we
> proceed with the per element probing to find the index of the element causing
> the exception and set vl to such index.
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 91 ++++++++++++++++++++++--------------
>   1 file changed, 56 insertions(+), 35 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5386e3b97c..d3ac99c72d 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -635,45 +635,66 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
>       uint32_t vma = vext_vma(desc);
>       target_ulong addr, offset, remain, page_split, elems;
>       int mmu_index = riscv_env_mmu_index(env, false);
> +    int flags;
> +    void *host;
>   
>       VSTART_CHECK_EARLY_EXIT(env);
>   
> -    /* probe every access */
> -    for (i = env->vstart; i < env->vl; i++) {
> -        if (!vm && !vext_elem_mask(v0, i)) {
> -            continue;
> -        }
> -        addr = adjust_addr(env, base + i * (nf << log2_esz));
> -        if (i == 0) {
> -            /* Allow fault on first element. */
> -            probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
> -        } else {
> -            remain = nf << log2_esz;
> -            while (remain > 0) {
> -                void *host;
> -                int flags;
> -
> -                offset = -(addr | TARGET_PAGE_MASK);
> -
> -                /* Probe nonfault on subsequent elements. */
> -                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
> -                                           mmu_index, true, &host, 0);
> -
> -                /*
> -                 * Stop if invalid (unmapped) or mmio (transaction may fail).
> -                 * Do not stop if watchpoint, as the spec says that
> -                 * first-fault should continue to access the same
> -                 * elements regardless of any watchpoint.
> -                 */
> -                if (flags & ~TLB_WATCHPOINT) {
> -                    vl = i;
> -                    goto ProbeSuccess;
> -                }
> -                if (remain <= offset) {
> -                    break;
> +    uint32_t probe_size = env->vl << log2_esz;

I believe this var can be declared and initialized at the start before
VSTART_CHECK_EARLY_EXIT(env).


> +    addr = base + ((env->vstart * nf) << log2_esz);
> +    page_split = -(addr | TARGET_PAGE_MASK);
> +    /* Get number of elements */
> +    probe_size = page_split / msize;
> +    if (unlikely(env->vstart + probe_size >= env->vl)) {
> +        probe_size = env->vl - env->vstart;
> +    }


Isn't this the same code, with 'probe_size' instead of 'elems', than this code
after "ProbeSuccess"?

ProbeSuccess:
    (...)

             /* Calculate the page range of first page */
             addr = base + ((env->vstart * nf) << log2_esz);
             page_split = -(addr | TARGET_PAGE_MASK);
             /* Get number of elements */
             elems = page_split / msize;
             if (unlikely(env->vstart + elems >= env->vl)) {
                 elems = env->vl - env->vstart;
             }


If that's the case I advise creating a 'vext_get_elems_number()' helper (feel free to use
another name) that contains this common code and use it in both locations.


> +
> +    /* Check page permission/pmp/watchpoint/etc. */
> +    flags = probe_access_flags(env, adjust_addr(env, addr), probe_size,
> +                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
> +
> +    /* If we are crossing a page check also the second page. */
> +    if (env->vl > probe_size) {
> +        addr = addr + (probe_size << log2_esz);
> +        flags |= probe_access_flags(env, adjust_addr(env, addr), probe_size,
> +                                    MMU_DATA_LOAD, mmu_index, true, &host, ra);
> +    }

I think it's a good idea to take a look at the 'probe_pages' helper in the same file.
It seems to be doing a similar job you're doing in these lines, with the exception
that probe_pages() is using probe_access() instead of probe_access_flags(). A small
change in the helper could make it work for this case and for the other existing
caller.

This is optional - if it's feasible it would be nice since we'll re-use code, but
if it makes things too complex to make it happen then just leave it as is.


Thanks,

Daniel


> +
> +    if (flags & ~TLB_WATCHPOINT) {
> +        /* probe every access */
> +        for (i = env->vstart; i < env->vl; i++) {
> +            if (!vm && !vext_elem_mask(v0, i)) {
> +                continue;
> +            }
> +            addr = adjust_addr(env, base + i * (nf << log2_esz));
> +            if (i == 0) {
> +                /* Allow fault on first element. */
> +                probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
> +            } else {
> +                remain = nf << log2_esz;
> +                while (remain > 0) {
> +                    offset = -(addr | TARGET_PAGE_MASK);
> +
> +                    /* Probe nonfault on subsequent elements. */
> +                    flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
> +                                               mmu_index, true, &host, 0);
> +
> +                    /*
> +                     * Stop if invalid (unmapped) or mmio (transaction may
> +                     * fail). Do not stop if watchpoint, as the spec says that
> +                     * first-fault should continue to access the same
> +                     * elements regardless of any watchpoint.
> +                     */
> +                    if (flags & ~TLB_WATCHPOINT) {
> +                        vl = i;
> +                        goto ProbeSuccess;
> +                    }
> +                    if (remain <= offset) {
> +                        break;
> +                    }
> +                    remain -= offset;
> +                    addr = adjust_addr(env, addr + offset);
>                   }
> -                remain -= offset;
> -                addr = adjust_addr(env, addr + offset);
>               }
>           }
>       }


