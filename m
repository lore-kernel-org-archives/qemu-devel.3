Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4A0E9D826
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 22:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9W6Z-0001Jn-Ao; Sun, 05 Apr 2026 18:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9W6X-0001IH-F7
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 18:38:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9W6V-0005VN-LY
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 18:38:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso2518997b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775428681; x=1776033481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzAW3EIFp0+QiQxjJE6yjUpF77Z7rvsyjuEYd+NvEF4=;
 b=N7aTG9hq9Qg10zZpSBCLvyzWx7UnyglM265x1k/4bSDJJlNldVXfV81iErSo3d2dsH
 RrToAq085/3jAShfGW5B0rKnZ5iVbIKR/NJ6ONErH4YA2t9mSUcdXhAP77EJn5t2ALPy
 mQKQLaY4B5hs4VUH9AiWzocEbzkJdRP0YgWh05x4cFP/hyMiWJXjefGI+30EHSSdRn1+
 c1m8UphUJaAFZ6r7L8m37e7n/g2X0NtEFEqZhmyuoVK6u+OIKe/Oq9u9Pgymtj+6o/Cp
 AXlQ3gWVNFc9tQHAGfeW2ltYQR/Py9Y9rbo/AHqceAIk061Po04rWK9o1tnd0ZLOk1+j
 Yieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775428681; x=1776033481;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jzAW3EIFp0+QiQxjJE6yjUpF77Z7rvsyjuEYd+NvEF4=;
 b=SZATw4OcWcXn6Mdenur/StJt9JJka4I3XKqSmQ8A4mmbbA5F7pMj8zcX9yGqGjfH+j
 +bYKV3N4drEc2PlIbAv6TPij9N0r/VLBQzTpchK1rINHqt2pjjfI2EOmz7FugtvkVbGb
 mX8fAspXPgiUOSTZbJE+Dqx7wb8i53/s82MK0/eb8oE3vLQpPt9Sm/UdSGKTv6wHJ6Sn
 lhSaXWwX4eXqvQkMabt727deHoZIl5EfNYWqDMADSzixHm+VbbdfdmkelBOk+6Y/R41s
 U0SwPNTVD7YDbjvMq9rEtA8zmB+8CPW08/7oTVEdEKsgZfnzL8pKor4JBpcdGQrfPrso
 ntQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzvtznm5mqNaQYVAtBEQdTcF8R+voftZaJniJob15vym3+g/4V54/cr/N00iDuQTb1kD3JSRjxKqJJ@nongnu.org
X-Gm-Message-State: AOJu0YzfO4pMRaT43vvHQdLwgH9rEMBBGlIeB6MBazjqHVPv7Kis9wBb
 rVs4NaiWRj0c8K0HAOO6rcWD3wRmja3lTvXt9bqSD45IbDoPrc7Ie+ZiNm0G1kOYbnc=
X-Gm-Gg: AeBDietRTIJIscbze2p7UgbhtT57YiP0t3W/nnTlBh/SHmNxW73cENVLQBssbxqX5DZ
 L+wxFQ1re8ekNlwJqCyTJa5RmfejSQDsRcCAlDIiICjLP44l+I+L72jSpMzGzZ1T0cRAeeF+tdI
 TM3HBzdLW03PQGVOFMZMiAB5F3ZRaaolq3R2fCpB4y4KRdQv62faZKMw/sLrUrwcAvV3hn4yfbf
 qa6xUOWcZmfx2UXveysePF/vmmQ4Q7Ucx7yCF08t2uDz1u3n5LRX+It66stB+2YDFYkiFgJchig
 zB+bzwEgiqsIy0gqTrxr28KmkLfvJ4wdMTmDRH86VUYSwGLc0Qh1DZo9x0hafTxavV8spVOC52m
 guF/RuRPxaUEtIi4WtPEVrgpkEdm2MbbrT944lLwOtVIC9GXak0NQZ1SXS/cNMVY2nEqtot5h0L
 UdQ5gxQfCqP/WjZT5LFIAXtI+iZFZ0SKk26AEWcJbI5q6mVGq4TcRJDUBIe/OnNGZAu14=
X-Received: by 2002:a05:6a00:4649:b0:82a:7b0b:f946 with SMTP id
 d2e1a72fcca58-82d00364e54mr11675382b3a.24.1775428680843; 
 Sun, 05 Apr 2026 15:38:00 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c41b8dsm11331593b3a.34.2026.04.05.15.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 15:38:00 -0700 (PDT)
Message-ID: <d1871c2b-6300-450f-a43a-68a83afced0e@linaro.org>
Date: Mon, 6 Apr 2026 08:37:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] target/arm: storing to canonical tag faults
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-8-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-8-daaf0375620d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/10/26 08:59, Gabriel Brookman wrote:
> According to ARM ARM, section "Memory region tagging types", tag-store
> instructions targeting canonically tagged regions cause a stage 1
> permission fault with MTX enabled.
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/tcg/mte_helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 07797aecf9..ddf4ffc51b 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -227,6 +227,20 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
>   #endif
>   }
>   
> +static void canonical_tag_write_fail(CPUARMState *env,
> +                                uint64_t dirty_ptr, uintptr_t ra)
> +{
> +    uint64_t syn;
> +
> +    env->exception.vaddress = dirty_ptr;
> +
> +    syn = syn_data_abort_no_iss(arm_current_el(env) != 0, 0, 0, 0, 0, 1, 0);
> +    syn |= BIT_ULL(42); /* TnD is bit 42 */
> +
> +    raise_exception_ra(env, EXCP_DATA_ABORT, syn, exception_target_el(env), ra);
> +    g_assert_not_reached();
> +}
> +
>   static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
>                                      uint64_t ptr, MMUAccessType ptr_access,
>                                      int ptr_size, MMUAccessType tag_access,
> @@ -372,7 +386,11 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
>       /* Store if page supports tags. */
>       if (mem) {
>           store1(ptr, mem, allocation_tag_from_addr(xt));
> +    } else if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {

Pass mtx from translator, all instances.

> @@ -415,6 +443,11 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
>                                     MMU_DATA_STORE, TAG_GRANULE,
>                                     MMU_DATA_STORE, ra);
>   
> +        if (!(mem1 && mem2) && canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
> +            canonical_tag_write_fail(env, ptr, ra);
> +            return;
> +        }
> +

This isn't correct.  The store to mem1 is independent from mem2 and might succeed; the 
fault from mem2 must increment the address.

> @@ -448,6 +486,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
>       int mmu_idx = arm_env_mmu_index(env);
>       uintptr_t ra = GETPC();
>       int in_page = -(ptr | TARGET_PAGE_MASK);
> +    uint8_t *mem1, *mem2;
>   
>       check_tag_aligned(env, ptr, ra);
>   
> @@ -457,6 +496,29 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
>           probe_write(env, ptr, TAG_GRANULE, mmu_idx, ra);
>           probe_write(env, ptr + TAG_GRANULE, TAG_GRANULE, mmu_idx, ra);
>       }
> +
> +    /* If we are storing to a canonically tagged memory region, fault. */
> +    if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
> +        if (likely(in_page >= 2 * TAG_GRANULE)) {
> +            mem1 = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE,
> +                                           2 * TAG_GRANULE, MMU_DATA_STORE,
> +                                           true, ra);
> +            if (!mem1) {
> +                canonical_tag_write_fail(env, ptr, ra);
> +            }
> +        } else {
> +            mem1 = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE,
> +                                           TAG_GRANULE, MMU_DATA_STORE,
> +                                           true, ra);
> +            mem2 = allocation_tag_mem_probe(env, mmu_idx,
> +                                                  ptr + TAG_GRANULE,
> +                                                  MMU_DATA_STORE, TAG_GRANULE,
> +                                                  MMU_DATA_STORE, true, ra);
> +            if (!mem1 || !mem2) {
> +                canonical_tag_write_fail(env, ptr, ra);
> +            }
> +        }
> +    }
>   }

No changes required for st2g_stub, because that's only used when tagaccess is false.  See 
AArch64.S1CheckPermissions.


r~

