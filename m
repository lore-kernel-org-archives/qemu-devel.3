Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEB7C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 16:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukmfZ-0008Dr-TO; Sat, 09 Aug 2025 12:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmfI-0008A8-JC
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:43:29 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmfF-00041g-Bq
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:43:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76bfd457607so3224722b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754757800; x=1755362600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxWL8OKtfEEmaBqLSDyJA7n7Cljt4UYRUUiJgZlRJCU=;
 b=O0osPoU+NCuJZQkG8sGoi1lZNBnu1oHopRDreSK9OiDyQZcXiiwqco8fy/ZF9+jQ/M
 RVCxAkVbntJoxLVEjI3wAtpirp1iQAWIl6RSjhfVRxyakPS34BDr/YbfpaOYkZ/b07Da
 aexsvSr+DDI6s5z1rRYuOc8Jh7LX2je4xU9PSO51dPA3/msaMuJ52CCFSJKaMJQA268z
 OSg1B+ENcfZLjuLKNg00yMQ8Cq4Qpy0ZZZ3RoFaGtFWW7go6ejhwzaQTQU/YFevh1P6+
 B3wNhgbQ5Dws+CyFmtR+kdW+hniKxlz8Cxj7khgOkEWq4vH35v8kcMgGzrkk8UTvnR6V
 hFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754757800; x=1755362600;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QxWL8OKtfEEmaBqLSDyJA7n7Cljt4UYRUUiJgZlRJCU=;
 b=rjqQceKp3yWwtMgMw4wHivKVjIwjJEMmTZ2l5VdQKUaRw46NLHbNEA1pU71qrYCrqX
 1T10Dn/sVEN2uIrKZsmI/EIH99iys4H+BB3dfSsOpEClvrtfj0YPwb0wreuovkRRVBpr
 MCH28rCpSzolLao0KnYOaTrYBLa2TRz/GbkEiTLBxpH72WweO/z0NtEpHB3OaWGDKcsH
 xp75giNa3nHOS7hzCVZkMl2/HEY56ksF+PN0ImKqWvbYaURO53QrGWgDLR0bRb2MtKNj
 N5pbSXC9tbUQ+iYvJK8X30EnEcYeP3cGS4RVBMq1RiNFrRtYXYdwUigLxad5gcafETkZ
 Ir3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH9puD9pOvpQXcPOH/InsColgBuFUDg4tG/p8rLcmUWxSnYQ1dSgclZ+MPyD01uGMo+Mlk2NeHfn/N@nongnu.org
X-Gm-Message-State: AOJu0YzM25P+6gZ1DmwcIcIgFkW+GYTtF8IA6RD0RtrVZNPNpDJLaAWy
 8LscEjExnCG6NNs4F1cpH1CGS79EPkiAl23Dx4/ZwLXpMXcTvv3CJslc5Og0XiPgfxM=
X-Gm-Gg: ASbGnctTN8TKT6mOsR1A3clQptkHOeESWPWgwoXLRceC18vWV/z0X8JZhCl7uScelHt
 Pdfyq2vaL5txgW3QjXzHyATEYySa1kyrlrleMEhcs/nZR6RdPLD8SlrNnQPnKVAygDP+uNmZS7w
 bZUiJJg/YIJpM/tMcfcjHg3louXhZEnhILUs1z+qSqtps3eJdsVhyQmaaFgNyro6eRP0f+G5RZ6
 z6BJyIfIERKZ85XloS/+Ozf2GSZ+VPvUxn4UVrWZtisz+ijhpL+xCQpxo2o8O0qC4B1z9/aAyYz
 Jr9kqURQaocgZtihJdeULQvKORe8mRoYqEnbQ9H3vq+QmI8+LW2c+NQEC1u3eGe66smA8NjTdUt
 VuHOWxNrl+S0oshDHHh5qKawc9R0/p00OCg+RE8B0KEk0s3Gy
X-Google-Smtp-Source: AGHT+IH5NyvFWhwrbhcaJOSnHvypxVtKt5SL1P7QvO9MhsgzfGszD7Ztnih8y9FjEiQ/vF5cJN5lAg==
X-Received: by 2002:a05:6a20:938e:b0:23f:f7ae:6e40 with SMTP id
 adf61e73a8af0-2405513bd47mr11622652637.22.1754757799680; 
 Sat, 09 Aug 2025 09:43:19 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b42d4b0ed65sm3143904a12.27.2025.08.09.09.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 09:43:19 -0700 (PDT)
Message-ID: <026f53fb-2f48-45c8-b873-8fa6b677abf3@ventanamicro.com>
Date: Sat, 9 Aug 2025 13:43:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] hw/misc: riscv_wgchecker: Check the slot
 settings in translate
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-18-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-18-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> The final part of wgChecker we need to implement is actually using the
> wgChecker slots programmed by guest to determine whether to block the
> transaction or not.
> 
> Since this means we now change transaction mappings when
> the guest writes to wgChecker slots, we must also call the IOMMU
> notifiers at that point.
> 
> One tricky part here is that the perm of 'blocked_io_as' is the
> condition of deny access. For example, if wgChecker only permits RO
> access, the perm of 'downstream_as' will be IOMMU_RO and the perm of
> 'blocked_io_as' will be IOMMU_WO.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/misc/riscv_wgchecker.c | 70 ++++++++++++++++++++++++++++++++++++---
>   hw/misc/trace-events      |  1 +
>   2 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
> index 5d2af7946f..5a70231837 100644
> --- a/hw/misc/riscv_wgchecker.c
> +++ b/hw/misc/riscv_wgchecker.c
> @@ -100,6 +100,52 @@ REG32(SLOT_CFG,             0x010)
>   #define P_READ                  (1 << 0)
>   #define P_WRITE                 (1 << 1)
>   
> +static IOMMUAccessFlags wgc_perm_to_iommu_flags(int wgc_perm)
> +{
> +    if (wgc_perm == (P_READ | P_WRITE)) {
> +        return IOMMU_RW;
> +    } else if (wgc_perm & P_WRITE) {
> +        return IOMMU_WO;
> +    } else if (wgc_perm & P_READ) {
> +        return IOMMU_RO;
> +    } else {
> +        return IOMMU_NONE;
> +    }
> +}
> +
> +static void wgchecker_iommu_notify_all(RISCVWgCheckerState *s)
> +{
> +    /*
> +     * Do tlb_flush() to whole address space via memory_region_notify_iommu()
> +     * when wgChecker changes it's config.
> +     */
> +
> +    IOMMUTLBEvent event = {
> +        .entry = {
> +            .addr_mask = -1ULL,
> +        }
> +    };
> +
> +    trace_riscv_wgc_iommu_notify_all();
> +
> +    for (int i=0; i<WGC_NUM_REGIONS; i++) {
> +        WgCheckerRegion *region = &s->mem_regions[i];
> +        uint32_t nworlds = worldguard_config->nworlds;
> +
> +        if (!region->downstream) {
> +            continue;
> +        }
> +        event.entry.iova = 0;
> +        event.entry.translated_addr = 0;
> +        event.type = IOMMU_NOTIFIER_UNMAP;
> +        event.entry.perm = IOMMU_NONE;
> +
> +        for (int wid=0; wid<nworlds; wid++) {
> +            memory_region_notify_iommu(&region->upstream, wid, event);
> +        }
> +    }
> +}
> +
>   static void decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
>   {
>       /*
> @@ -309,6 +355,9 @@ static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
>   {
>       WgCheckerRegion *region = container_of(iommu, WgCheckerRegion, upstream);
>       RISCVWgCheckerState *s = RISCV_WGCHECKER(region->wgchecker);
> +    bool is_write;
> +    WgAccessResult result;
> +    int wgc_perm;
>       hwaddr phys_addr;
>       uint64_t region_size;
>   
> @@ -327,18 +376,25 @@ static IOMMUTLBEntry riscv_wgc_translate(IOMMUMemoryRegion *iommu,
>        * Look at the wgChecker configuration for this address, and
>        * return a TLB entry directing the transaction at either
>        * downstream_as or blocked_io_as, as appropriate.
> -     * For the moment, always permit accesses.
>        */
>   
>       /* Use physical address instead of offset */
>       phys_addr = addr + region->region_offset;
> +    is_write = (flags == IOMMU_WO);
>   
> -    is_success = true;
> +    result = wgc_check_access(s, phys_addr, iommu_idx, is_write);
>   
>       trace_riscv_wgc_translate(phys_addr, flags,
> -        iommu_idx, is_success ? "pass" : "block");
> +        iommu_idx, result.is_success ? "pass" : "block");
>   
> -    ret.target_as = is_success ? &region->downstream_as : &region->blocked_io_as;
> +    wgc_perm = result.perm;
> +    if (!result.is_success) {
> +        /* if target_as is blocked_io_as, the perm is the condition of deny access. */
> +        wgc_perm ^= (P_READ | P_WRITE);
> +    }
> +    ret.perm = wgc_perm_to_iommu_flags(wgc_perm);
> +
> +    ret.target_as = result.is_success ? &region->downstream_as : &region->blocked_io_as;
>       return ret;
>   }
>   
> @@ -604,6 +660,9 @@ static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
>               break;
>           }
>   
> +        /* Flush softmmu TLB when wgChecker changes config. */
> +        wgchecker_iommu_notify_all(s);
> +
>           return;
>       }
>   
> @@ -699,6 +758,9 @@ static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
>               break;
>           }
>   
> +        /* Flush softmmu TLB when wgChecker changes config. */
> +        wgchecker_iommu_notify_all(s);
> +
>           return;
>       }
>   
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index b1d8538220..54dfcd50a1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -403,3 +403,4 @@ riscv_wgchecker_mmio_write(uint64_t base, uint64_t offset, unsigned int size, ui
>   riscv_wgc_mem_blocked_read(uint64_t addr, unsigned size, uint32_t wid) "wgChecker blocked read: offset 0x%" PRIx64 " size %u wid %" PRIu32
>   riscv_wgc_mem_blocked_write(uint64_t addr, uint64_t data, unsigned size, uint32_t wid) "wgChecker blocked write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u wid %" PRIu32
>   riscv_wgc_translate(uint64_t addr, int flags, int wid, const char *res) "wgChecker translate: addr 0x%016" PRIx64 " flags 0x%x wid %d: %s"
> +riscv_wgc_iommu_notify_all(void) "wgChecker iommu: notifying UNMAP for all"


