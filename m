Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A40CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syg9b-0000OX-4K; Wed, 09 Oct 2024 19:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syg9Z-0000OA-1J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:31:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syg9X-0004Ip-Bh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:31:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e050190ddso285681b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728516693; x=1729121493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q+QUc0ixt+edFqWbId/5MwIrD5Y+CqmVmhLe/TkwL2M=;
 b=MJ2hmiQ+jkvaSFxbkgQ398xRm5wPtdQt0aqEh2ADDFNQ6aTozx7DH3Bqvk9KscTasu
 MnLBq/mx4rcywLTWMYgErbr1rI5Iw+CqxAgHHNtAKd4QZHXSTpGdAL9L0OCg/qqLO7pL
 mY11M9Q9oOK12FBKSKu3F4pLpvOzIOdVXhcBZMYqLRabNpWaW1bvy66NhdMGhyb+w59l
 IpF6tQlbnOLAOSOdwMoj7vWJ6g5m2boYZyb1uKOIpovWwzVA4IrY35KrAipb3KMFetGm
 BOc1GCJcUHh8go8ZiRrHtjQoFo3Usl9uE1X45Tgm64cE4heHliRv2MlP95OcOHhQNVOb
 0GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728516693; x=1729121493;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+QUc0ixt+edFqWbId/5MwIrD5Y+CqmVmhLe/TkwL2M=;
 b=b/JRLFb0u55dyseRW+r3Pq89lDZz9uNlY68EDF43hzPHWsRl9pkBi1vfeRZQI4uTIG
 YewDc5/IEXaiU1zBV9/9Vu5hLJiZf4bbxQLiYvEbLnigIDudqPJMjfIxVjXw1++72JAf
 vUD9EIihwRsFH0OUovMB219mjnH+/gtkxAfDNkfhrqj5ATp+T0cVv9a2vSLyS1IXKm/t
 WeqJXB9jE85U9TtOf1rSTQ8DSpIEoGlMSHGmcKxlcwFmO5nqLRQKC6RqVA/0JZiH0kvK
 R8InKl+n6zTZY4kBSIfP3CJxLKm956T1bp3XmEwlFsES3vacqRw6sVVbdkf9ZeA+VUA7
 0ylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmNaOdAtD09Z/wNBT4s5mPQknu/joXltQ4TfBlGhrYziKAR1sWM5adgR162qDAR3Tz73bFg5dZETW+@nongnu.org
X-Gm-Message-State: AOJu0YyULG8tLPQjJQZXL1uhq7we7Zd2+LmeWvyEcXg6SqFeMUkh1S2c
 7F1YcTA4eWIMQMgqZegJqeObbB8kMWn2yeoAu0TezvsnmXv8tMLYf9hQ+a3Sr6Q=
X-Google-Smtp-Source: AGHT+IH/VFo+Rd8hON89R6nGOXDRgRMpj/rMQZs7cDmWdHhbgs3ahUGuh8/lQ0HC1w4PgWiaLFToJg==
X-Received: by 2002:a05:6a20:9f0a:b0:1d6:de67:91c0 with SMTP id
 adf61e73a8af0-1d8a3c1fb15mr6068963637.27.1728516693475; 
 Wed, 09 Oct 2024 16:31:33 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbba1csm8319035b3a.33.2024.10.09.16.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:31:33 -0700 (PDT)
Message-ID: <dfb15f20-5b39-454b-be83-b797ff78b141@linaro.org>
Date: Wed, 9 Oct 2024 16:31:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/23] accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
> Add the data structures for tracking softmmu pages via
> a balanced interval tree.  So far, only initialize and
> destroy the data structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  3 +++
>   accel/tcg/cputlb.c    | 11 +++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index d21a24c82f..b567abe3e2 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -34,6 +34,7 @@
>   #include "qemu/rcu_queue.h"
>   #include "qemu/queue.h"
>   #include "qemu/thread.h"
> +#include "qemu/interval-tree.h"
>   #include "qom/object.h"
>   
>   typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
> @@ -287,6 +288,8 @@ typedef struct CPUTLBDesc {
>       CPUTLBEntry vtable[CPU_VTLB_SIZE];
>       CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
>       CPUTLBEntryFull *fulltlb;
> +    /* All active tlb entries for this address space. */
> +    IntervalTreeRoot iroot;
>   } CPUTLBDesc;
>   
>   /*
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 8affa25db3..435c2dc132 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -89,6 +89,13 @@ QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
>   QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>   #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>   
> +/* Extra data required to manage CPUTLBEntryFull within an interval tree. */
> +typedef struct CPUTLBEntryTree {
> +    IntervalTreeNode itree;
> +    CPUTLBEntry copy;
> +    CPUTLBEntryFull full;
> +} CPUTLBEntryTree;
> +
>   static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
>   {
>       return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
> @@ -305,6 +312,7 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>       desc->large_page_mask = -1;
>       desc->vindex = 0;
>       memset(desc->vtable, -1, sizeof(desc->vtable));
> +    interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
>   }
>   
>   static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
> @@ -326,6 +334,7 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
>       fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>       fast->table = g_new(CPUTLBEntry, n_entries);
>       desc->fulltlb = g_new(CPUTLBEntryFull, n_entries);
> +    memset(&desc->iroot, 0, sizeof(desc->iroot));
>       tlb_mmu_flush_locked(desc, fast);
>   }
>   
> @@ -365,6 +374,8 @@ void tlb_destroy(CPUState *cpu)
>   
>           g_free(fast->table);
>           g_free(desc->fulltlb);
> +        interval_tree_free_nodes(&cpu->neg.tlb.d[i].iroot,
> +                                 offsetof(CPUTLBEntryTree, itree));
>       }
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

