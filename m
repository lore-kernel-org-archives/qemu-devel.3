Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA01C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ogy-0007zd-BV; Tue, 29 Apr 2025 13:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ogo-0007U1-8F
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:24:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ogl-0001fS-IH
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:24:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c3407a87aso93315845ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947450; x=1746552250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h838S+PEIw0WKsswku0EbN0h1I/N/caDw+cTunuN/es=;
 b=kmmaSbdJd8V+ERm+HN60lTcLbvK0iwf/O+UNQKB6wrWOXyNIU4qOHfQjoXvpofHfVH
 1W+IHx3/CqdpGgR0XCcznXp9fEyGtpXFlsawOR2zzQFvSfpj1k1asL35MO+dzp0ywYtp
 D7AAh5wphQg0ioDDxaOLs+BW/SysSB+a+Th9emyZi8yX/kr6bv+9YcUJJGD1pLc8g604
 NnoRV1b48uwUwz4XsDaGqfy17ZQmgFrbzNzsfKKaIPL0vEaSg0oQoDntScyz+TB8dw6S
 DP0AK5BEBelqEAMHpH27Ho7OZKeQcyCL+zEWgZnUe2K3eU1+XL7KFlxXUqqxwg1ZxU4f
 TBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947450; x=1746552250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h838S+PEIw0WKsswku0EbN0h1I/N/caDw+cTunuN/es=;
 b=DgwPqym2/72bb6Y5CIEHo9KAem67a7bp61ETnlkd4TFhJs5ae/jiAtjem58B4/5Jge
 qGrihwEx0Ujr8IztyFrRNssrjamM5XCTl76H5B5JW7AdGlssEhEp6D5ix5OSrqAVF059
 Sc+R3Rq4d2aRfbb9+dQoPQOFagBI15/BlHhXny3Zp0NByKBWH+8brXVTs+Z/UwueArnO
 5Sz70HF7PuPMLeP3CsvxP+46KncIdmehvsAn4SY51OBfaBbvaTY+eC10eRGK7RCXRFVH
 4Xd6c3M1AQ103/p9QF13TSpQH1E0OacXJ18gDGCFF98A93yx3hQJaSFqEMXGCtBZAdfw
 2gbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwO0cnW6OQtkZEgPmwMq3MMfwiex11IjYa9gNwLkgKXoYL6fmuFeqyS9CKAzrS4QqrHsnvDZjCqYhh@nongnu.org
X-Gm-Message-State: AOJu0YwCSdfMsgVJ1z/nYJ7HKCYZaxppmRglEJowLtDZQMMdqlKKPAKd
 GG8X+GUJ0fAYB1Aj/K0JnjBe+5ckLr7wgDTS4eR9guwyPNTtE859cB8RpFgRDoN8xX4yhdDc95Y
 E
X-Gm-Gg: ASbGncvqaYyOpsJu2obBdwyitPTeIRIwmk9CptgVNPAQyN2wg2lgcsyIHL5md9cjwp3
 UEz8wpXTLYRxLGP0rCpQFrMPmh1IdxgXQPsN4x9c6Hj46gAzxf8rvIshk1O22zYUStD8EEAv7tX
 Y77+5qkfipnh8lbM6fRqZ1Ub3ef2cgN6GmELsRX+sxf2uxyT+8bmrW687X9FvUWWg+iMCLZsmua
 W7L0Ztd6c4Fdc539+ebcsnrkDtNEZb1O6Yezdl3rjkUOoqBez2DfkOylHxbG0rJvNaf7ryeJEsn
 KXg1OeLLzvJ77laax2gDcLX+kNeY2K51cNWJqBJ6ywlonK094POO9TM=
X-Google-Smtp-Source: AGHT+IFRsP2CFCFvtJujXh9w/9cqNdaAfa/cD3HzvtapxYBfVDBUmDI0jRDU1Qu0kK3rqyFxCsw0/A==
X-Received: by 2002:a17:902:f685:b0:224:1219:934b with SMTP id
 d9443c01a7336-22df3591151mr2606785ad.50.1745947450049; 
 Tue, 29 Apr 2025 10:24:10 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db510283bsm105620235ad.200.2025.04.29.10.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:24:09 -0700 (PDT)
Message-ID: <c2299ffd-ed97-4d86-bccd-98b74ac3e314@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:24:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] hw/riscv/virt: Use setprop_sized_cells for uart
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-11-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-11-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

>   hw/riscv/virt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index baa894b11aa6..d9303c9bb033 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -966,9 +966,9 @@ static void create_fdt_uart(RISCVVirtState *s,
>                              s->memmap[VIRT_UART0].base);
>       qemu_fdt_add_subnode(ms->fdt, name);
>       qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
> -    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, s->memmap[VIRT_UART0].base,
> -        0x0, s->memmap[VIRT_UART0].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +                                 2, s->memmap[VIRT_UART0].base,
> +                                 2, s->memmap[VIRT_UART0].size);
>       qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
>       qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
>       if (s->aia_type == VIRT_AIA_TYPE_NONE) {


