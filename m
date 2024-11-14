Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A6FD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeA3-0000Gf-PV; Thu, 14 Nov 2024 13:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeA1-0000DJ-PQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:01:42 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeA0-0002Wv-2W
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:01:41 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ee51d9ae30so650231a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607298; x=1732212098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0RiCfn7Tu7CH1xX7LYG0bmABtrtlKWxl87rP6zidoAw=;
 b=xFHIQ+4LJBs1xVgYz3xVANvJ1DuYPJkw/jYCnBmTCyHW0xh3hTtKQCF27bQ7xyeNq7
 g7lFwG7xxsEnVIzZ9xpe7EqXCqo8is9DhARYTMlq8JfS/hNggPQ2xuQPArxKS6ExoCCs
 p6EqChpH2jBNH7dsQ5twiRzjuPFVY4bq0QHly6DqXSZbVZwgyDC8CqCvySPIlKxc7Cp9
 WwmBOvAHoJVp27Jg7FQWj9b+An6BcPeaaD8v0Mi4GUFIUKcFaCWQ/49ymXBdXpixc3Ht
 1ioEw9kaNMYCx52D3Ol220A9PHtBA7JJhfYZrCxfN63m9o8taPGlm2Wl9dFYQXQ5wloZ
 IFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607298; x=1732212098;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0RiCfn7Tu7CH1xX7LYG0bmABtrtlKWxl87rP6zidoAw=;
 b=tH+KmgPlVCdt6kDuv+XYMXYjLZFjVQj2VzuqeRb+brgkKaMDkzi1yuuTiWmarCSoRI
 0gcJAm8lkDabeSqyM770jMkIx0SA53Xawoy94Pj21EysLLa+ovUXFwJ3LTjRIpzvtzWG
 gWzorIrNTdGdxSt3u2ziZZ3cji85zTNeqW5p/qSdEnkGNznC2cCHM6XaTgAYfLX8mqrj
 FBP6tDq0TODEksO1sDcp3f+Aw+G2by1IFbpabbCh1y842+KsFZuooIFFQc2MpUoo0Gdj
 dlwEv+hWhxNehr7Vi5e1t2BizhPfbc8CS03I8py1v1NnXFhxQjZ3Z7kYQ57HbefpHvgQ
 Z4AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuXZxvSiuBdp6Q6mR78g1QLwZkBtzZsSGLQFdSaqwUVWCRnXozAVTRLOfy/WQj4f56/wEqQOm0f2Bs@nongnu.org
X-Gm-Message-State: AOJu0Yy/RUvqmjN1ckF4zfIFs9oeMfpf0/Y2yuk3dC/QwVSoaZIlIESp
 vVAr6FegNH1iKjVRYxQ0P49gx7Jk9FlFI0xTbEYH7MHBykNFE4XRvsfNfAoWRDY=
X-Google-Smtp-Source: AGHT+IHy02N6uSwjHjdpbBiRyHdDr4y+YON7823ndAx8LXNKNfqOZfnZK7GMNPcFpDCfB9A7di9MZA==
X-Received: by 2002:a17:90b:2745:b0:2e2:e6c8:36a7 with SMTP id
 98e67ed59e1d1-2ea06599e58mr3215057a91.31.1731607298484; 
 Thu, 14 Nov 2024 10:01:38 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d2b748sm13590485ad.248.2024.11.14.10.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:01:38 -0800 (PST)
Message-ID: <1c13c2fe-988d-491a-b0a3-d497f7eb8de1@linaro.org>
Date: Thu, 14 Nov 2024 10:01:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/54] accel/tcg: Remove IntervalTree entries in
 tlb_flush_range_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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



On 11/14/24 08:00, Richard Henderson wrote:
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
> index d532d69083..e2c855f147 100644
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
> @@ -739,6 +746,8 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
>       CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
>       CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
>       vaddr mask = MAKE_64BIT_MASK(0, bits);
> +    CPUTLBEntryTree *node;
> +    vaddr addr_mask, last_mask, last_imask;
>   
>       /*
>        * Check if we need to flush due to large pages.
> @@ -759,6 +768,22 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
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
> +            g_free(node);
> +        }
> +        node = next;
> +    }
>   }
>   
>   typedef struct {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


