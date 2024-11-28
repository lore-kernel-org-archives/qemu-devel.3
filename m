Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D0D69108
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeHa-00039I-JE; Thu, 28 Nov 2024 08:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGeHY-00036Z-3U
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:10:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGeHW-0000I6-6u
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:10:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21260cfc918so4869815ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732799404; x=1733404204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zUTka3/ByFwzBJ54bcJNSWNm6zfJKIYYIQy11SV94rk=;
 b=pdftz+aoVzSkHaz0UcdtEf2muozGNxwFjaM1Q+G08Uc89LopGbh+yLhBWN1gFt4JgQ
 pMBOtECMNsqke08bXukdSWptRtDs3APVZmyZz006OxXEeIEIIm/eMhukbpvQw98GMBI8
 ExeiwKai/QQO63cLMrwsqxVMFBNQrYd0x+svFrZMtOyILU4JYMihE7ZshJrDj6JYdMvK
 JbgRxdJZ4H1jo0Tl61XQFWn+y9Pfc1Nf60Y/nrutabeKcKyvdh4CbB1uF3JdEGx4t6pS
 T0melWAUtniq/vgEE9Z3eEYbyW5xmYWL9qJMeOxnNKZXfoF0Tz6+RuEw7xEkcFoh5I7R
 ap7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732799404; x=1733404204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUTka3/ByFwzBJ54bcJNSWNm6zfJKIYYIQy11SV94rk=;
 b=W9y7j3vrtqrDKB5D3wysv+L6tx1g/E71j2seK39T7Q3uteiMX29YpFrbjXQKV1cAPR
 rYCGtqQZ9mFa7yAnVz/q7bS76+LYyYihAyqy/XdN3fH3a+5uKIMqRcH7oiSyjs09xeVh
 /VPSV0s6HHiaCYWOSjs2xPhmyX7WUAkcVrOTkd25ogueuGl5gFjHaVwnrPY+FnmEiLQA
 68+RYuadwfWY1R+a1yqM6+IdwOwe/oWMicBh4yBWkpjArhDzd1F7i6z8HAfhZEXwJutc
 TahQJlmviqKnktV4Mca29w31Kb5wsaAOC5ZG+U2VKz2IZpeSxznAfwNeKcLRrktZUMXe
 gENQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgwoztruoPyD96H6SaQyLvlE2s6cZXtxN/Sx/nT5iBEeD/k+zJWkdgvaxrEQTwgKSD8qEo0y+0pBsp@nongnu.org
X-Gm-Message-State: AOJu0YxElI8u6F2jx6q1k7/eX6ibCN5aW+FYtN34kdNhMb/GSG1OmL4y
 A5AYcijd95O+L21un/+txLSVC3oIR6vSymeJhc5zWjTO91lv27DghASHI+IzsXN9LRJp0QwynrD
 I
X-Gm-Gg: ASbGncv4LSDjjG3nWVyITY350hxukbCTNmr4OMSw7qJupXPXEo6cjN9tT4/cxcOUfUB
 t87o+gMflzFYRdObyCeEnGtUzYdkzv1QERNl4qoFKAf8ru+JStol7+zVWWullkAhjjHTvgbINB5
 6U4S/MWU+UN5YjaEJ8lfl5E5Un4jZU3KaP+f86KUKWD97tw9s2TXKCK5TMX+rXy+uFj8BOd2B+d
 sdIaum0alvdKBT/ugdJIsQcDNB2tJnXC+HW5QNShs2zgL6veV3aL0fX9Aey2yc=
X-Google-Smtp-Source: AGHT+IHDQ8qmmioq3JlkSAUtI1vqm+AaW79kmx3GQOY15or3uiQOTD3VPC5IWDHLoPFmBLvRp/B2hQ==
X-Received: by 2002:a17:902:f545:b0:212:12a2:4007 with SMTP id
 d9443c01a7336-21501857891mr81615565ad.34.1732799404478; 
 Thu, 28 Nov 2024 05:10:04 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219851d1sm12967795ad.191.2024.11.28.05.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:10:04 -0800 (PST)
Message-ID: <4a90b96b-fd8c-426a-aae7-fccba441feb3@ventanamicro.com>
Date: Thu, 28 Nov 2024 10:10:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/riscv: Add the checking if DTB overlaps to
 kernel or initrd
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241120153935.24706-1-jim.shu@sifive.com>
 <20241120153935.24706-4-jim.shu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241120153935.24706-4-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 11/20/24 12:39 PM, Jim Shu wrote:
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
> index 81d27f935e..bc8074fec8 100644
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
> index 06b51ed086..7d59b2e6c6 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -32,6 +32,9 @@ typedef struct RISCVBootInfo {
>       hwaddr image_low_addr;
>       hwaddr image_high_addr;
>   
> +    hwaddr initrd_start;
> +    ssize_t initrd_size;
> +
>       bool is_32bit;
>   } RISCVBootInfo;
>   


