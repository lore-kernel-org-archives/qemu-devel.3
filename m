Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EC8D3ABFA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcZU-0007DO-RV; Mon, 11 Nov 2024 17:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAcZT-0007Cu-Ba
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:07:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAcZQ-0004eC-Ay
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:07:43 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21145812538so45744025ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731362859; x=1731967659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgjHtmnW0FjhC3FIM2ddMQq7W/MISMI7HN6gaci+tNQ=;
 b=QcddDYm9GxkF9KZ2+oukWCTUz8RERDW4yA456+LneqPmTOnswhqt6W6KsC4bxJiboH
 UsVo5iqudF6t1Zj0q4bof4XZqVbr8+RcPjT7DNlo+bMc9jdjg1bUz9p0h0GCYTI50vSY
 IT7s6Qf4E8i0QjJyDXfHtYcYOTK60+s2hBHz0hX6MKH3WA/vn1pGlLFZ06nyD3JQeZTk
 wr3uqwRnhcHLXBq4MdM2KZj7o3J3g92Zh76U/TNBDNeUZPpr5n3fwrg0YvD9R5McOj7h
 v8QHGyKk/oc62T8cLJjdzsrx281PVoVYe6hhjghu47Hh20HmnRpBKvPZFuCoKEcE1s7D
 gLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731362859; x=1731967659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgjHtmnW0FjhC3FIM2ddMQq7W/MISMI7HN6gaci+tNQ=;
 b=Xq5Q3ylWfi1Rx4Qewjs9X0zvDtHdOd01JEjT9STWIoHJNNQ2bW+6iwQAFIjTAPYEGR
 TqGW7OKEMrzAFZAEYSQ06moMDfgplxwUohaFbhbrSruCB1VfO/iHZKRQkWK/c/O2AOIe
 C/UeFjjFLVqDG5RssyJyCfbA2s8AFQ1vXKRafKodyVaycJtuexfVJLVh4K/27gZnoyyp
 SRjjqyTI/maQqUo6iJlb8qJczJ9jg8M6tJSyPdgEO4ZzG9AKqe7JgMA4KAcUn6R4HgDv
 aHlXglRVnXgjpiYD5qlt5whnhcBOjBqMCaK/w10k6GGNVABRfYdScdE9E8e09Fm7nrMf
 SOaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0jtJ2o3toFwZ3+QSl4miyqhbAsP88iAAHCKMvoSZMfrz+u21TY/I3BOFeYqFBKYqs447nf2+ZH9rC@nongnu.org
X-Gm-Message-State: AOJu0Ywh7EfXpuEJDJUFxBeT5IhQS8zp5a9dHuc2uMqZnsi56oAuXvBH
 gKBHEIAv3G2VTLKfbhTHA9vtjEvarnPYOt/RLyK8J3cEcMQHvNRVhXfxKKhPQUM=
X-Google-Smtp-Source: AGHT+IFUrl6HPLQQiR8JjoCagdYcif8ezbyH8I7k8iaUQIeAZ3lNpCTs1Xz6DOAN/I1UelwYjEpRqA==
X-Received: by 2002:a17:902:c40c:b0:20c:8a91:3b43 with SMTP id
 d9443c01a7336-21183c8209cmr194283765ad.16.1731362858780; 
 Mon, 11 Nov 2024 14:07:38 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80472545ad.27.2024.11.11.14.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 14:07:38 -0800 (PST)
Message-ID: <c23c2007-4220-48ff-ad11-cdab432907a3@ventanamicro.com>
Date: Mon, 11 Nov 2024 19:07:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/riscv: Add the checking if DTB overlaps to
 kernel or initrd
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241108070454.12699-1-jim.shu@sifive.com>
 <20241108070454.12699-4-jim.shu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108070454.12699-4-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 11/8/24 4:04 AM, Jim Shu wrote:
> DTB is placed to the end of memory, so we will check if the start
> address of DTB overlaps to the address of kernel/initrd.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   hw/riscv/boot.c         | 25 ++++++++++++++++++++++++-
>   include/hw/riscv/boot.h |  3 +++
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index c7478d2365..d22d240854 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -70,6 +70,7 @@ char *riscv_plic_hart_config_string(int hart_count)
>   void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
>   {
>       info->kernel_size = 0;
> +    info->initrd_size = 0;
>       info->is_32bit = riscv_is_32bit(harts);
>   }
>   
> @@ -213,6 +214,9 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
>           }
>       }
>   
> +    info->initrd_start = start;
> +    info->initrd_size = size;
> +
>       /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
>       if (fdt) {
>           end = start + size;
> @@ -309,6 +313,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
>       int ret = fdt_pack(ms->fdt);
>       hwaddr dram_end, temp;
>       int fdtsize;
> +    uint64_t dtb_start, dtb_start_limit;
>   
>       /* Should only fail if we've built a corrupted tree */
>       g_assert(ret == 0);
> @@ -319,6 +324,17 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
>           exit(1);
>       }
>   
> +    if (info->initrd_size) {
> +        /* If initrd is successfully loaded, place DTB after it. */
> +        dtb_start_limit = info->initrd_start + info->initrd_size;
> +    } else if (info->kernel_size) {
> +        /* If only kernel is successfully loaded, place DTB after it. */
> +        dtb_start_limit = info->image_high_addr;
> +    } else {
> +        /* Otherwise, do not check DTB overlapping */
> +        dtb_start_limit = 0;
> +    }
> +
>       /*
>        * A dram_size == 0, usually from a MemMapEntry[].size element,
>        * means that the DRAM block goes all the way to ms->ram_size.
> @@ -338,7 +354,14 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
>           temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
>       }
>   
> -    return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> +    dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> +
> +    if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
> +        error_report("No enough memory to place DTB after kernel/initrd");
> +        exit(1);
> +    }
> +
> +    return dtb_start;
>   }
>   
>   /*
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 719ee1fe5f..e309cc1a7f 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -32,6 +32,9 @@ typedef struct RISCVBootInfo {
>       uint64_t image_low_addr;
>       uint64_t image_high_addr;
>   
> +    hwaddr initrd_start;
> +    ssize_t initrd_size;
> +
>       bool is_32bit;
>   } RISCVBootInfo;
>   

