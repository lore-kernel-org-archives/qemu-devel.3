Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786CAD729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4R3-0005St-ID; Fri, 29 Nov 2024 12:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tH4Qw-0005NV-8x
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:05:35 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tH4Qn-0007H2-Ml
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:05:30 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7252fba4de1so1914681b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732899923; x=1733504723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtG+cpEbhVniAaNGnC/vejL+ueOR2il7lkb0iPZ487A=;
 b=TfvTUomcqaMWREDeA86lnE4uBpa1LmKz7L628rACT2zXeNQv2pclQixX2ahaqmuhn7
 SYj1y+fnUW04C3CaMDvKQNDkJkS1ZkDDLPft9N7bUgpLHMemosA85dk5JQSpJwmU/lpr
 kJbQX+NUKHYtOM394VCkgLwaE13lw3KuyXQNDSv/HMkR4cUgq0VzuThVROTXuGO/Ed1C
 /bY4KetqiZzyLOCIkLpAGIAeyHcQoSK6bmjhFVWZxrAEu8kbHSp+Ok9MceUFp2ipgpom
 VzoatJTZ3kLnzsuiNpsQl5+z3BnWsTwhVJBy854L8oTdK5aLRNA6NI5lzeTtot8UzH46
 60Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732899923; x=1733504723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtG+cpEbhVniAaNGnC/vejL+ueOR2il7lkb0iPZ487A=;
 b=J0tzklKGV/MgibfB5rBtz7wML1QVaTfcfHtbuZcWzbJuiSFwkBHM9HZNpUl3ZxONkq
 Wc6LPT4pgPhb9ccdbBClveFqWCP6JAnSRLzOeaOkALQo6IeOFdJjO+5La4/IaeMq7ukc
 m+droYLMlx8Dm7XCSyXmMvVIIGsZDaSyH6uNbdXXO/HiYfwukJVX5ob+omMxFGWLi0Ft
 vhX+x4bsH6wpPewON2HGukGIqUJrWPQnvMy89IMppvagxX8633JdtHUjLMw/T8IYc57a
 EjlhwhDl9A/3xZvMK5tUGpLFeVlIeCxC9y5Rsl5X6d7XMTLpAKr47gH+TruHu5JQ9AcK
 tKzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlNceRD+x7MNzewewElqYVkzPt3sQ8vuMBeuvXlTn0x2wagpzGHqzpg04x6hMYeUgLdBjZd8caasK0@nongnu.org
X-Gm-Message-State: AOJu0YxWmtzUPNMeQ4aZi56Z4gI70o23NeiMlOund+7/PVyfxs+Ew5WO
 iC1DiuQBl/AfD3vO8imTu1CFDus3kZm/bkzCYMi3oPXhzmq+v1XNsTtGVb0SwKR3LIuI8ilKOda
 Y
X-Gm-Gg: ASbGnct8fyt3INi9ZWGHcJpjjyHWYTmb8ik+0K/a2cqeK7TyKO8bJQRQXayUHJgbzOJ
 DNd+AvZWCw1b3QFQsx4tRZg+zTeEuu8/ROAKeMuVRIkMIE2cRrnAfIYoI3wIDiPz6RU0nNp7w+C
 hbNoU15x+wge7xA5sYyl9ScwHuYuMrlvDopBCimRvoxM9REQlx8xmVTaZyMBEoigmmCc8cYRLHn
 V5FVIdfRi4x1HwbNPdgWDr7pxi4XydhzTYZCD1viKHSzL8xBDh5Q/j9C5MZudY=
X-Google-Smtp-Source: AGHT+IGQt8E3B76K40dBuR38XgTqHZSiNHFRBsc8ROkXE77PNpohSLxdseJUOwys0M/C+BrMUZFOMw==
X-Received: by 2002:a05:6a00:92a2:b0:71e:6c65:e7c4 with SMTP id
 d2e1a72fcca58-72530185399mr17694958b3a.26.1732899923071; 
 Fri, 29 Nov 2024 09:05:23 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725417fb9adsm3827007b3a.127.2024.11.29.09.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 09:05:22 -0800 (PST)
Message-ID: <cc2eb0d5-cfd7-4297-a98f-9f3f52e63204@ventanamicro.com>
Date: Fri, 29 Nov 2024 14:05:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 2/3] hw/char/riscv_htif: Explicit little-endian
 implementation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241129154304.34946-1-philmd@linaro.org>
 <20241129154304.34946-3-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241129154304.34946-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 11/29/24 12:43 PM, Philippe Mathieu-Daudé wrote:
> Since our RISC-V system emulation is only built for little
> endian, the HTIF device aims to interface with little endian
> memory accesses, thus we can explicit htif_mm_ops:endianness
> being DEVICE_LITTLE_ENDIAN.
> 
> In that case tswap64() is equivalent to le64_to_cpu(), as in
> "convert this 64-bit little-endian value into host cpu order".
> Replace to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/char/riscv_htif.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 0345088e8b3..3f84d8d6738 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -29,7 +29,7 @@
>   #include "qemu/timer.h"
>   #include "qemu/error-report.h"
>   #include "exec/address-spaces.h"
> -#include "exec/tswap.h"
> +#include "qemu/bswap.h"
>   #include "sysemu/dma.h"
>   #include "sysemu/runstate.h"
>   
> @@ -212,11 +212,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
>               } else {
>                   uint64_t syscall[8];
>                   cpu_physical_memory_read(payload, syscall, sizeof(syscall));
> -                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
> -                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
> -                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
> +                if (le64_to_cpu(syscall[0]) == PK_SYS_WRITE &&
> +                    le64_to_cpu(syscall[1]) == HTIF_DEV_CONSOLE &&
> +                    le64_to_cpu(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>                       uint8_t ch;
> -                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
> +                    cpu_physical_memory_read(le64_to_cpu(syscall[2]), &ch, 1);
>                       /*
>                        * XXX this blocks entire thread. Rewrite to use
>                        * qemu_chr_fe_write and background I/O callbacks
> @@ -324,6 +324,7 @@ static void htif_mm_write(void *opaque, hwaddr addr,
>   static const MemoryRegionOps htif_mm_ops = {
>       .read = htif_mm_read,
>       .write = htif_mm_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,


