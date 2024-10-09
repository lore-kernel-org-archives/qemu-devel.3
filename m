Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CDCCED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygYJ-0005JI-VF; Wed, 09 Oct 2024 19:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygYH-0005J2-Pa
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:57:09 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygYG-00080W-4r
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:57:09 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2a999b287so367426a91.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728518226; x=1729123026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzJzot95uLiiIhluUuJhuKKNTvBmjrxKwrri2fTcU1Q=;
 b=txtviRU0pV1HMwWbXIrwjgGXNVatWrwP2M+nL9gCSawLDlc5XDw6cP65ld+2/40lZk
 RPVnWlZYBsMOtNwd1SD5o29nZKuhT1WJ2CqKt2PRiN7l/KwWoWH3imWgb9GdEpRDLIwN
 Ids1yrAMnNySrPQHi4wH7aZN/CJXNbE94P98dNwRQcKODF7D/3J6i5wwimT+sef7sw4f
 MDFh+MQPsEwfSMtzH5JkXvz54lLiGvUJDPg8994Fz/187vTA2ozz23n3pqLkEHKYsgVx
 dU2fOxT0K32Dik1SWrCzG7BmNPxY5OQrZhVCufMtFpSl21S10YCxmc2IwaxkZfikawn+
 8Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728518226; x=1729123026;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SzJzot95uLiiIhluUuJhuKKNTvBmjrxKwrri2fTcU1Q=;
 b=kUPg9A6caHWCOJZoQsq74Jn1k2/oC8gGo9dvHnPo+tZIHbE2q+yeH6PkZGI62uc3FP
 /2r1lk71XvTOUaN5lCgNOyNAa9DHe3+7wrFRZIdT8qPrTkcKjtk4lHFWZB2Ha4p12EYz
 fFT0Mu3qQmq6x8/uktPZfL0lG3WoPmJTWPEUmR97jbeLfQ9nmdSs3ZAeTIIB6ckHmVRq
 7uQzM5uJo6YMPNnCu3bt2CrgD/WOxL6bv4b5Ic2oI5LrNDqwcGV5B34uPy+EdelL3Hf8
 LRRHeXEH9DCE3uJwEyVHfysl+iIivod63onCGp6A7ljwartFKhQWyLl9+egzsHSRYbfd
 H1Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLKsH+XkWJoCOQsNfwyFAZ3HR5mgnffgeCo+jflbbq3ezIDRupuVit1+y/SXxohr8yU4wcKPg5eI8/@nongnu.org
X-Gm-Message-State: AOJu0YxGSykdP+ArVlFPZ4Y7rGjWBbt5N17giZFN99Qp2Z66WnZgL51p
 BsxKJdZIL87ArUGJy6m2pTCcn6jwFmNTrxBa/7w6AHzxTGo+afmo9ypp0u64fQA+3K2kZ4Q2qb1
 mOBM=
X-Google-Smtp-Source: AGHT+IHn9AKQtIak9x+pXjWJ4X1+C6+50poaqVZc63EInh3DOVqj1iitQoxnOVUdvpLHXL+ArvVjIw==
X-Received: by 2002:a17:90a:3044:b0:2d3:c638:ec67 with SMTP id
 98e67ed59e1d1-2e2a18413a7mr4473314a91.0.1728518226604; 
 Wed, 09 Oct 2024 16:57:06 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55fe0cdsm2307570a91.23.2024.10.09.16.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:57:06 -0700 (PDT)
Message-ID: <bcd17259-0b64-45c6-81aa-02263bd3fc87@linaro.org>
Date: Wed, 9 Oct 2024 16:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] accel/tcg: Remove IntervalTree entries in
 tlb_flush_range_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> Flush a masked range of pages from the IntervalTree cache.
> When the mask is not used there is a redundant comparison,
> but that is better than duplicating code at this point.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 772656c7f8..709ad75616 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -311,6 +311,13 @@ static CPUTLBEntryTree *tlbtree_lookup_range(CPUTLBDesc *desc, vaddr s, vaddr l)
>       return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
>   }
>   
> +static CPUTLBEntryTree *tlbtree_lookup_range_next(CPUTLBEntryTree *prev,
> +                                                  vaddr s, vaddr l)
> +{
> +    IntervalTreeNode *i = interval_tree_iter_next(&prev->itree, s, l);
> +    return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
> +}
> +
>   static CPUTLBEntryTree *tlbtree_lookup_addr(CPUTLBDesc *desc, vaddr addr)
>   {
>       return tlbtree_lookup_range(desc, addr, addr);
> @@ -744,6 +751,8 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>       CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
>       CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
>       vaddr mask = MAKE_64BIT_MASK(0, bits);
> +    CPUTLBEntryTree *node;
> +    vaddr addr_mask, last_mask, last_imask;
>   
>       /*
>        * Check if we need to flush due to large pages.
> @@ -764,6 +773,22 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>           vaddr page = addr + i;
>           tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
>       }
> +
> +    addr_mask = addr & mask;
> +    last_mask = addr_mask + len - 1;
> +    last_imask = last_mask | ~mask;
> +    node = tlbtree_lookup_range(d, addr_mask, last_imask);
> +    while (node) {
> +        CPUTLBEntryTree *next =
> +            tlbtree_lookup_range_next(node, addr_mask, last_imask);
> +        vaddr page_mask = node->itree.start & mask;
> +
> +        if (page_mask >= addr_mask && page_mask < last_mask) {
> +            interval_tree_remove(&node->itree, &d->iroot);
> +            g_free(node); > +        }
> +        node = next;
> +    }
>   }
>   
>   typedef struct {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

