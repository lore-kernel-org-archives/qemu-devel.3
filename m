Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8CC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kYR-00033p-Dz; Tue, 29 Apr 2025 08:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kYO-0002u8-PD
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:59:16 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kYM-0000Lp-Kb
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:59:16 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301c4850194so4856067a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931553; x=1746536353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVo4dne972nTKadziczb2hv8dPAzjuCHEpOiobx/orI=;
 b=E6mexcbrZMfpk0dTjRATbIX386M4LFRXA/hHYrjm5/+uqn25CwjPcjl16rrwrzZZ0J
 rSgv8Dp5l3K9u5VTy9nEK7qsIi5IC1pCTb4+yG9DUXH7Krn4mTEZ63DarJaRbV01p409
 bm0QMT9bDxLG9H+GQmSnL/3x3dbLANkikwe5yAHpDbhRSEYICdrRlc9rW4S7AS6seRFM
 re+F6S2oim/eSzcMpMNsGkbdrmOiFBpWktdtWFFKofUXU1r8NsRlQhPiesT2+kKn+BIs
 dak/eS6QdfXBp2ZgGnu4XI6jgijgGS38+TvjhL3Jk+O31FY0Oz9Rwt4/E+bC//sVdfuu
 7rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931553; x=1746536353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVo4dne972nTKadziczb2hv8dPAzjuCHEpOiobx/orI=;
 b=SqFgdt7x5gBBJjNXtJQMBSuevopQ6l5mr916WPPzKGsus942MvyCc7ys7FuG5l453X
 GCfbvxjeIK8RJNpO0wN1IEcH440n0Voc3ETuZiK5zRfp7/oVxGo9IlrsENVkXhZ1s5UQ
 izupnNDzfWr8xIYs/8XQxHzOvoR87DPalIGI9L/CVR3K/Ov9F2NUIstE3sk47cOrH/l7
 3W7CLZAjsGGfdPatgStmHCpTNNiqQDjniXlVSTD02VvG2NNht2PMdvNaFiirTbulbkyc
 SknA3MH96tJ5vWJEJ4UBUWLLDLFD5XK2OuH8Zc2g3OzpAD0gIedf6U9woeGlWzp57KkA
 vlXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8nYFuv6b7ilVQcEIyNg0/2R+irkFBhCn3Jtzl8cn+oFVnUBpKMidWlVpUNg1ER+ZL5+37Eku96B18@nongnu.org
X-Gm-Message-State: AOJu0YzJnqz+/kdNYByiJfMfXbssA0bhLJ+D8BEBbifOs0OOY+3WgDND
 Q3zzPMpZG6XPw+9q1N0jNTjHnWgpJ/UbfbXY0/faFTpm8XkX+p1rgOxTbMeaN+jhP5uZy1Ok+/a
 M
X-Gm-Gg: ASbGnctNbnw0/Wz3ZDVPJUSB7w7tw+moFiY3USgfOudmuhRyLgCWh/VsbUbFov8fXAj
 WxJXJyQBWb3hnoieWNoYjwzHMo1reQELu26T6mocS48XlnnC1rM9qeNxEGju04J8puvHOJRMGfB
 4jqvrOjE2BE+YGG4aDYruzk8aS5+s50YBzXAJ9/tU3vvu8cUSZa+GNF4/N0M9vyLMV+2qT4TMbc
 FVE6vvzvh+klvnqLnuxHBStNy4yr86Z1Jp4wNyXrmPVrK+U1Xv99WZsbliECzzr53REvdkNpd0t
 Cj4BPiOn00Puqq2iy/fDEqxQvscHwkLSdYOEXfbi7j73GjUDxvM1l/4=
X-Google-Smtp-Source: AGHT+IHyDdNdsq/V/N3ZhboTWyaqfrAvDU4XeKVhDrxh/SIAY/tJdl51HtBULVyehbK10HFp0i6GyQ==
X-Received: by 2002:a17:90b:5249:b0:2f1:3355:4a8f with SMTP id
 98e67ed59e1d1-30a012ed05dmr16128208a91.4.1745931553151; 
 Tue, 29 Apr 2025 05:59:13 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5219ebfsm101206465ad.245.2025.04.29.05.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 05:59:12 -0700 (PDT)
Message-ID: <4bf4345b-55f7-4d6f-b7ef-985accdd60a9@ventanamicro.com>
Date: Tue, 29 Apr 2025 09:59:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] hw/riscv/virt: Fix clint base address type
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-2-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102d.google.com
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
> The address is a hardware address, so use hwaddr for consistency with
> the rest of the machine.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 17a790821484..e4c0ac8a2a9a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -324,7 +324,7 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
>       int cpu;
>       g_autofree char *clint_name = NULL;
>       g_autofree uint32_t *clint_cells = NULL;
> -    unsigned long clint_addr;
> +    hwaddr clint_addr;
>       MachineState *ms = MACHINE(s);
>       static const char * const clint_compat[2] = {
>           "sifive,clint0", "riscv,clint0"
> @@ -340,8 +340,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
>       }
>   
>       clint_addr = s->memmap[VIRT_CLINT].base +
> -                 (s->memmap[VIRT_CLINT].size * socket);
> -    clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
> +                 s->memmap[VIRT_CLINT].size * socket;
> +    clint_name = g_strdup_printf("/soc/clint@%"HWADDR_PRIx, clint_addr);
>       qemu_fdt_add_subnode(ms->fdt, clint_name);
>       qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
>                                     (char **)&clint_compat,


