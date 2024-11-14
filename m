Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA07D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeBo-0001nJ-E4; Thu, 14 Nov 2024 13:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeBI-0001WL-3K
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:03:04 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeBD-0002qI-Ec
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:02:59 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ea0bf6bebbso534735a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607374; x=1732212174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+DHCUj647eTxA9ZjStP7YZDIYEDuwelCtwH9XLlI1J4=;
 b=qaINucQg+BFZPiN+NiLSEtHaAI3RvUohepL27GwMWiRsWot5lPPAQbP37RdJD5g2xZ
 sGeI4wCjA56qZ5eZQKIOk9r2SKXsyTslisjttkGpYPMHj9PuqgTSO77nOCwNKjGva3Dk
 NNFnf0QkS3HJ4ZucLTjSSEx9x+71Q3nOdTxEo+p01u5jf7xztVyzNXlhWlfnWzlsr4g0
 xCcJnxQaLihOTvuF68GOByzqxbWJCNNHno9zvTwfEmg8W8zPzDNRZbGhRPIYUr9BMrrt
 SVPZYkr8aXwTQcbhaW48AoxypOyDoEQYgRDpECW+KLxa4TZ9TLqwSa7Ps+fA1K1ZH4Lj
 5rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607374; x=1732212174;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+DHCUj647eTxA9ZjStP7YZDIYEDuwelCtwH9XLlI1J4=;
 b=ACnVwrSCm3Qy25uPQcHaCoi+/o+Iiz068j4NL26KSc7TXdBq+cwFbq0U9KhYBzfSUm
 29QPx+pJyD2yJYuaGdZfbzh7fLjuymCYuKd5twb6ufbex/UeUqdFm0DeKLOWMFQQFKcO
 gQjBiHAOoEUA4rQ+Dorq1pkgGTNDVGOZ4RNed8PZ7v3PjfZhMBbd47tQ4wZPjas6Ho7Q
 gZw68EYa3mjjy2OJmikun1fTpjhntbbOsKBSpkmbXMTPZiTWl0jUdSGLpvG+Sl8JkoxZ
 /dDnD3Ec6XY/soYhaQGqkS+zY1n+tL6HqvI8rIUr2p1+SdyN6ixgF+PHRjY8VD9KV7YI
 i65w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Q0HAmcYIjYX/aYdlpATfBo4ZOhqAwPYrxOOvJg65IghuSeeZ6Rykl8oKipWoOdle0L4S73fZpMQi@nongnu.org
X-Gm-Message-State: AOJu0Yw2SuHs3DpKzrfcvvocky1wdKVyOeiECFZhFiy6FJldSeZ+P/4q
 KQkSRIJUa1vnXlyqQOIdOB6HCQQy/mOONCPCFjF5L0QG7BoGH1MyJBBGSXeiXWopSwJVG68/RYT
 dKkQ0YQ==
X-Google-Smtp-Source: AGHT+IEdU/2fjWhxHzke+1Gl8AMMHLK8Dk54ecaqKKHALsMbdKcBY49FByjw+WHgYjtIAIzfGWwZkw==
X-Received: by 2002:a17:90b:3ec5:b0:2e9:5f95:54c1 with SMTP id
 98e67ed59e1d1-2e9b173c441mr35523365a91.17.1731607373996; 
 Thu, 14 Nov 2024 10:02:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f1c6c9sm1494838a91.22.2024.11.14.10.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:02:52 -0800 (PST)
Message-ID: <f6b7e545-e005-4d44-82ce-ea402da39791@linaro.org>
Date: Thu, 14 Nov 2024 10:02:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/54] accel/tcg: Process IntervalTree entries in
 tlb_set_dirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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
> Update the addr_write copy within an interval tree node.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 0c9f834cbe..eb85e96ee2 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1049,13 +1049,18 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
>       addr &= TARGET_PAGE_MASK;
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>       for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
> -    }
> +        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> +        CPUTLBEntryTree *node;
>   
> -    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        int k;
> -        for (k = 0; k < CPU_VTLB_SIZE; k++) {
> -            tlb_set_dirty1_locked(&cpu->neg.tlb.d[mmu_idx].vtable[k], addr);
> +        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
> +
> +        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
> +            tlb_set_dirty1_locked(&desc->vtable[k], addr);
> +        }
> +
> +        node = tlbtree_lookup_addr(desc, addr);
> +        if (node) {
> +            tlb_set_dirty1_locked(&node->copy, addr);
>           }
>       }
>       qemu_spin_unlock(&cpu->neg.tlb.c.lock);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


