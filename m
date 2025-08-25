Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ABECA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUrX-000777-Q7; Mon, 25 Aug 2025 06:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUrU-00076B-7Y
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:55:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUrM-0000v4-Dh
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:55:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b60fd5a1dso6221565e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756119325; x=1756724125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YTMmAtlYBpPyx7uvCP+0dkvpd9jM9kpze1Jc4278uck=;
 b=SJDhdvHSLCh0OM6BFeJvmVvDow/4rFxrOgAFQFChAWiX7Fl5LMKbnohpgEOp5dVM6U
 vy0Ty4+Gfg+jJGFH6JZd5ZHYs30LiSPHi4qPy4VyLTWBWGN5h8Gf/EuI/T5emTrR2r7K
 Q3S5D91qR4kMau7HJx6iNe23KsaeZCYqoNOqy68qLNT/itt/e9u1rLnGKe8yWm889s/2
 JAG+ymE8RTzfpARaOYbJ2jLW7Ni104ZlHR21vXyQ+snfxynVCOSvGebK3qub4FC5kl4D
 jLhwtYBwLCKjUN7ixz5fLTin/MImv5ajLRJk4dgH+exPiceM9iW5p5FfcHpeRIGBtPcu
 PcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756119325; x=1756724125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTMmAtlYBpPyx7uvCP+0dkvpd9jM9kpze1Jc4278uck=;
 b=n5GSrNfPtP6PS52RP13Ah4WwoddmWddG1LP12pAPdJkxaoBgwKzrXe8n7i4mVbLB37
 xwjETdOzFGlVZ7msMbO1S8SimLAjfV0O0wWtC/x4xtAO5ECkp/Zt7buvhEUxScr6Pl9d
 zRwntrkDpfRbdoMcZEyR4yk5XJmrY9pCTfxGPLRZpkZ9xmvaO1/kGy/QIcDUuQWbVesc
 Mz3NICNy6cD4kdYxwAyG8KLIsGdkTPeQBzjGAfXxJ3EbGbv1ytqhEMhIg0SqScsXUcTN
 NWAlyzi/aFagG8EnczK5izefYQKKqwpeA3ziucRlDgP0SeUn8RAcDdO8A6/rs82YjJoZ
 /p2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxAcOxN5fhx6ApXBNNYD3EqUDeqAIzsNz8P9G5gQoV+BFTBKmeDJRRP4VxSv7bT6hquAxyZ8d+TMPz@nongnu.org
X-Gm-Message-State: AOJu0YyEYWi1L1um6bqhXAxh+L2aLhwSY90DQefl5AhIbK7QST/2XDDP
 EJ3KGBrLEAcgon9mxiCAy8vuVqjgUoe+W/IkpbDG/upkS3Ec0zM/2mVqoY+ws6hqwv6QI+ev6mx
 L2IWL
X-Gm-Gg: ASbGnctVl9ORhFZSdqg6gAEGqFWCuo1VfY2modFLhd4swZ05NG6b5FIkI3I8b6nIJJC
 O0P9j5Fe8sxp9R45hs55NUG1jjTXhZhwKDthD6aefsMaURGoSm3Q5eBUw5TGZaDvhYSb31c74Xb
 LzN+JCY/vF8oWec4526efscDFNlkJaGamcbfF2MQnQGQg4b+Smm3MNnSUOzMsjqgCms3dekcllk
 NyDNMgRebVq3w5qK/P/vKWhJ4NmRmYgKqV5mjYazbYJCfw84J+tfyseAESI90YVvslgrxVw9axo
 K8rrZ30T7ZwuC5z71e1fuN18kEKPP0bHFMdiUltPduBFdfSsRzpVbl498jg3PfR172pqFyXAfaN
 lcfIXFY+G6fdTJMpc6tQ5gbjRfcNwmW9dGEcLXzHazNcGOqWoNo7e+L2TFmcEcUHiaQ==
X-Google-Smtp-Source: AGHT+IHKMEA5UQ6/uObPzesPFKlwgRLxVMg4rChnaFMtF05c63HDPx2qiSUfeo2HKOJG6TKGt5zvXQ==
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id
 5b1f17b1804b1-45b5ec68358mr35830645e9.11.1756119325363; 
 Mon, 25 Aug 2025 03:55:25 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57589e49sm103826475e9.18.2025.08.25.03.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 03:55:24 -0700 (PDT)
Message-ID: <8c52a821-021c-4711-98dc-30bfb605a3d6@linaro.org>
Date: Mon, 25 Aug 2025 12:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] memory: reintroduce BQL-free fine-grained PIO/MMIO
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, mtosatti@redhat.com
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-2-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250814160600.2327672-2-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 14/8/25 18:05, Igor Mammedov wrote:
> This patch brings back Jan's idea [1] of BQL-free IO access
> 
> This will let us make access to ACPI PM/HPET timers cheaper,
> and prevent BQL contention in case of workload that heavily
> uses the timers with a lot of vCPUs.
> 
> 1) 196ea13104f (memory: Add global-locking property to memory regions)
>     ... de7ea885c539 (kvm: Switch to unlocked MMIO)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> v4:
>    improove doc comment over memory_region_enable_lockless_io()
>      David Hildenbrand <david@redhat.com>
> v3:
>    add comment for 'mr->disable_reentrancy_guard = true'
>      Peter Xu <peterx@redhat.com>
> ---
>   include/system/memory.h | 12 ++++++++++++
>   system/memory.c         | 15 +++++++++++++++
>   system/physmem.c        |  2 +-
>   3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index e2cd6ed126..aa85fc27a1 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -833,6 +833,7 @@ struct MemoryRegion {
>       bool nonvolatile;
>       bool rom_device;
>       bool flush_coalesced_mmio;
> +    bool lockless_io;
>       bool unmergeable;
>       uint8_t dirty_log_mask;
>       bool is_iommu;
> @@ -2341,6 +2342,17 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
>    */
>   void memory_region_clear_flush_coalesced(MemoryRegion *mr);
>   
> +/**
> + * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.

Typo "access[es]".

> + *
> + * Enable BQL-free access for devices that are well prepared to handle
> + * locking during I/O themselves: either by doing fine grained locking or
> + * by providing lock-free I/O schemes.
> + *
> + * @mr: the memory region to be updated.

"the memory region to enable [lockless accesses]"?

> + */
> +void memory_region_enable_lockless_io(MemoryRegion *mr);
> +
>   /**
>    * memory_region_add_eventfd: Request an eventfd to be triggered when a word
>    *                            is written to a location.
> diff --git a/system/memory.c b/system/memory.c
> index 5646547940..44701c465c 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2546,6 +2546,21 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
>       }
>   }
>   
> +void memory_region_enable_lockless_io(MemoryRegion *mr)
> +{
> +    mr->lockless_io = true;
> +    /*
> +     * reentrancy_guard has per device scope, that when enabled
> +     * will effectively prevent concurrent access to device's IO
> +     * MemoryRegion(s) by not calling accessor callback.
> +     *
> +     * Turn it off for lock-less IO enabled devices, to allow
> +     * concurrent IO.
> +     * TODO: remove this when reentrancy_guard becomes per transaction.
> +     */
> +    mr->disable_reentrancy_guard = true;
> +}
> +
>   void memory_region_add_eventfd(MemoryRegion *mr,
>                                  hwaddr addr,
>                                  unsigned size,
> diff --git a/system/physmem.c b/system/physmem.c
> index e5dd760e0b..f498572fc8 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2900,7 +2900,7 @@ bool prepare_mmio_access(MemoryRegion *mr)
>   {
>       bool release_lock = false;
>   
> -    if (!bql_locked()) {
> +    if (!bql_locked() && !mr->lockless_io) {

Check @lockless_io first to avoid a call?

        if (likely(!mr->lockless_io) && !bql_locked()) {

>           bql_lock();
>           release_lock = true;
>       }


