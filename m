Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580C1C3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9og8-0005bP-12; Tue, 29 Apr 2025 13:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9og5-0005Tp-NX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:23:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9og3-0001Up-I3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:23:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7376e311086so8578103b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947406; x=1746552206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y4VJ81nBaIgsJSYbwfn1UW1K06RmmQYlp7s6VNc9KMU=;
 b=Vy3n8J2uwB9j88VWI55k0231ePDP3jCvoNhIB9y+Bz3z+4c6fxfR0qnFtXHbA6JVcb
 7Bn39Ty+yMgKBgUorOM5ULf7baKSzGwOnzReR8ZNRTFPwaEHaMfPeCpz7ymoBTF3X6o1
 bDa+BAwVi6fz86kXlzQgHcop3YqjHS/sdT3S4Bpr/Dw6LVUCo1uH+4Dpfnai6SZI6SQK
 VAbEu5E6A3+1MtEMT9zRu71+X1dM10U7s6qYCFFH6U0db9KVfeftHGN00V75Jwcb9A1+
 xJIke0DLOfppbOUkbljyqaFMVqENzgeJsyHwB7yYl5vVQAJEhQIC+4NsgiCZ07hKOuiy
 4z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947406; x=1746552206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4VJ81nBaIgsJSYbwfn1UW1K06RmmQYlp7s6VNc9KMU=;
 b=fvd/vf2vYAoi1yxudVQ9Lvb9U+Z0jCvL0XpDdYykUTT8TV9U/E+78XwVy2sHdWsdFa
 +bg+rrVlsZ8gR1xlK5RuKcVx9XVOqygwTR0Pc6sey1wellQjqWVWSW9Wb7SQhlkag0Li
 T2LuRIHuNy6IEHWwhhxeGMmVEwlMeKKv+FNE0Qjdwu+Ae5XDVdu7RNO9GKy8sBuDNQZN
 UARrX1G3AjNlnGOleHpM3JFKFPbLA6Td4Eq7xPdu2xRKZyZ6+hjc4xC5BQ39eCFoqLwR
 5CraREDefKc0vjSnbp/N+FM7zV9uFKmCsTEND2663hiu11HKaXSSsTpb2f6yJ37vKki6
 LVvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsxKt3IxPlG+4jL5XJZ6yEtEYwT16brq2RFOSTONqcnErvyelRFB4FV5hxjgNIkR+ph0YE5/69+KBp@nongnu.org
X-Gm-Message-State: AOJu0YyiPDzaRifXYB7TdNOQRUaGQlHD597kMhoy9POYjqb/x+KzYpoN
 JqvX9UjvkOmyD/+GQy4BG5XTAq/r50+pE23OnDdaxE92df8d5sGk8Hxa+hlZKOo=
X-Gm-Gg: ASbGncv/ZsFqHDoGk87WYJnOflIOZQpFQ3ziTKaT27s8NRCp4atI23j7WrTp7gVhMet
 H9ox56wuaDjuQFY5myWBpKBHHsGdEilOeVvlfhaLAG4G1xiqwEF4xgKR+Dmuegvgvk9jrVTJg5X
 ArbZ6R2N5JkkiltRSXSWxSkMriYXhLSfBcpKCPMf+U9xQeKXeD4+myRnuv0E1aYsppnG5jPZtCJ
 L6c/JRfYWE+2CI0G+DAKmn5SBN6lSlSZtNuRiO1DD/9Gzz2beXlsH9IrTDJm+82lp3oaP0CpVSn
 WxTOBkTJmK/QCEw0hl/tKXubSz2NNdX3N64MpuMvV0JgZmXe74f4sTCnPgVfIyKGVA==
X-Google-Smtp-Source: AGHT+IHjlDNhVF/a21JedAxjrIzkUErGpokPIojC+DwwMq6L0reJZznB9Fj+1UETlt3aAKSXVYJllw==
X-Received: by 2002:a05:6a00:2d0f:b0:736:73ad:365b with SMTP id
 d2e1a72fcca58-740389cd781mr153570b3a.14.1745947406185; 
 Tue, 29 Apr 2025 10:23:26 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134a9sm10150413b3a.24.2025.04.29.10.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:23:25 -0700 (PDT)
Message-ID: <455e52d2-eda6-4e7a-8d88-6b743cb5644e@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:23:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] hw/riscv/virt: Use setprop_sized_cells for plic
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-8-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-8-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

>   hw/riscv/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 0141ea4795e5..3b4c3d6b2683 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -493,8 +493,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>                            s->soc[socket].num_harts * sizeof(uint32_t) * 4);
>       }
>   
> -    qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
> -        0x0, plic_addr, 0x0, s->memmap[VIRT_PLIC].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, plic_name, "reg",
> +                                 2, plic_addr, 2, s->memmap[VIRT_PLIC].size);
>       qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
>                             VIRT_IRQCHIP_NUM_SOURCES - 1);
>       riscv_socket_fdt_write_id(ms, plic_name, socket);


