Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC50C3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ofu-00055u-Tb; Tue, 29 Apr 2025 13:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ofm-0004x7-7U
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:23:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ofk-0001R2-FK
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:23:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3031354f134so5238901a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947385; x=1746552185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+umyPfklJSECgL445bhYrinb9y3aeVnccaB/sQD6/ag=;
 b=ckf2stiKx9BFH1aKtJG2320oEm8lG4+7GXQv0mjkfoNdCCCJAa071F8UPnqXhPdCBM
 G3qEXkj8A8DiowL5rYXp4e0fyLz+TdrlTeEEalmJhD/vQqAQINZejm8Ln+mkSDVAGlbK
 UwHfZk2dnz8TJaSXWBhFS/tQny11X8YoyTxt1J/n+pzRf2aEDW8QtO1LNwa33lD5lIum
 /CufqXcNIw259p40c+jOuOQwb2Z5gTeHL9OjJ9TeBW7KAgXV+mKiuzCmjqE1UzedVHtH
 ptF8c4ZB3u5LlO0Pq1/rEhl4zZdISj/SakC4mEOxjwoGvT8Z27wByS9//je0AVYunpLf
 ohuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947385; x=1746552185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+umyPfklJSECgL445bhYrinb9y3aeVnccaB/sQD6/ag=;
 b=QKZhCetvjtFJ1eDBYWREPwE9XCm2V1B9DUzghbcBDo/KL/puR3LCCp260QA2obyX8Y
 2kE0vLGFWnoQdrS3fB33SD9pBbckuZau+dDt9CxbJQDxp/lJrBI3kPwg2eznN9F3njlk
 xIlHvW6F+bBF16bXMgUx9CHEJl8erE44DJf40UOOaElnY7C6Rj5er2edfeeHBkkfOFeG
 SFIxl/KWoNmkbgV2M5FieFI59EAXTZNVBUMb6PuMl3ENg27yEnJw5221rNyaIJfrFJlI
 hvtVSDCNkFTHNYa9VFbkHt/D5OPW3Q+32J1xuWGvpCM9+kNGEhBy44v6XPTrCzsjDO+P
 09xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf2ES6zaHN7zvZeQYLz29glukS5R9Yu/hgyHVviYryNE/wiUMaVbDkN8zKeRE7Ck4NxbuVw+CgsDYQ@nongnu.org
X-Gm-Message-State: AOJu0YyHDwYseXuWmNTbW2O6dD8612y/IKuH1oz1rXg3j3GW6EAdLSx7
 +3SckHZcVBWHDo6n1b35FQLC8V/hUuX2XxfB2g1tHdHJpuE2J9/spAbTeLR0VAI=
X-Gm-Gg: ASbGncv/1dcbFNyqLNbHRMx0eLeOn1rPfDVNN3lx7sn99X99z6RDJOkbALgCpl/aIIW
 wDbCrlPJAkjwR5nT1EiF1bPWvy+keQTRTbrb1C546zoxPlMZWtMgXbIBR4C1Nlxab7QsP/mjJan
 3hfMI2CgYqoofsnoFYgRgVRdNeY+xYRCpXe8bg6KuOFl/3AMUF9RUIYHWWd9/oGegzI/hYBn5h4
 XIH7EkYlvC88BHiof85oEXgwo/NLF4TD8NR8A12okbH6Bg+JeJGzwqTrg7GyOpjm+xlfdPNzQUT
 Y1FgkEdvo5ZCTbFbHVmuESV9SnnOeRIn92a+5avJN3SX1abHAYzKXpU=
X-Google-Smtp-Source: AGHT+IG0w4uSOo5yKuIEf9zAjU1S7E/QahHNFFh1yvGPTiBskWbaxLrZ0mQYBC8n5gkNtOg/JAq9KA==
X-Received: by 2002:a17:90b:5388:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-30a2155098fmr8085883a91.12.1745947385403; 
 Tue, 29 Apr 2025 10:23:05 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef0612b1sm11428968a91.11.2025.04.29.10.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:23:04 -0700 (PDT)
Message-ID: <124f43d1-c16d-43c1-872b-b5af1888c787@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:23:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] hw/riscv/virt: Use setprop_sized_cells for aclint
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-7-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-7-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1029.google.com
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



On 4/29/25 3:12 AM, Joel Stanley wrote:
> The current device tree property uses two cells for the address (and for
> the size), but assumes the they are less than 32 bits by hard coding the
> high cell to zero.
> 
> Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
> and lower 32 bits across cells.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 62200ea39d07..0141ea4795e5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -387,8 +387,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>           qemu_fdt_add_subnode(ms->fdt, name);
>           qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>               "riscv,aclint-mswi");
> -        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -            0x0, addr, 0x0, RISCV_ACLINT_SWI_SIZE);
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +            2, addr, 2, RISCV_ACLINT_SWI_SIZE);
>           qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
>               aclint_mswi_cells, aclint_cells_size);
>           qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
> @@ -410,11 +410,11 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>       qemu_fdt_add_subnode(ms->fdt, name);
>       qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>           "riscv,aclint-mtimer");
> -    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
> -        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
> -        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> -        0x0, RISCV_ACLINT_DEFAULT_MTIME);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> +        2, size - RISCV_ACLINT_DEFAULT_MTIME,
> +        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> +        2, RISCV_ACLINT_DEFAULT_MTIME);
>       qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
>           aclint_mtimer_cells, aclint_cells_size);
>       riscv_socket_fdt_write_id(ms, name, socket);
> @@ -428,8 +428,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>           qemu_fdt_add_subnode(ms->fdt, name);
>           qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>               "riscv,aclint-sswi");
> -        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -            0x0, addr, 0x0, s->memmap[VIRT_ACLINT_SSWI].size);
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +            2, addr, 2, s->memmap[VIRT_ACLINT_SSWI].size);
>           qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
>               aclint_sswi_cells, aclint_cells_size);
>           qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);


