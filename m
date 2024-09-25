Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFFCCCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stWCg-0001Tn-S3; Wed, 25 Sep 2024 13:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stWCa-0001SE-VZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:53:24 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stWCZ-0005wa-DC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:53:24 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-49bd2b37fe9so50582137.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727286796; x=1727891596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNgmnswPo2nFwsXoBk0eLKeqHi2pOl7ck6V96JQ/8uk=;
 b=YUkG3UDCmbSMnSdiG9SrDkSTLJ0iOY3ORyQ2bFtuYrX04szpijmvWfpw5LFIJFLoN+
 TTbz44NiA2YoHgYsUQXhZEgPWMKPv/cn+SCHgIgXQEQkjygPSsE6wdzIyDgSxoRxWG27
 eibvVCTKZ7fepxYYqFOgeWZkaO/ZeuuLtUku9Ge2JK25m0uX31/lEdMxMu2ENRa0VWpj
 V+hoiXUzwsuw0HxdSmRAevhhum51CmPrdiwH6e6H9sAktLdK/nSG1bhtAQaxeKXu20eH
 3y5FZgBTUdiNPsDdYeTZUqZzREdXnOTWnQ4ZzUOdzv0qZx59xmF/pK5nufPBQpk3LomJ
 Gx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727286796; x=1727891596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DNgmnswPo2nFwsXoBk0eLKeqHi2pOl7ck6V96JQ/8uk=;
 b=J6wYGOTr6VTJpXC2mlvEnFdAgkH1agj9rnBSEZ4jYNm6PlqdwnhJmXY2HniGAwkQpW
 6a83dETTMmUGh2HvFKEQWpHMiNRyxjl3grxirpM7ulT2A5W8waHRn2HVfbggwcAajRkD
 C2Z5TGWqgM8eGH0bKAJ8QvNkEt1flrBrIsHaV05ZNWncRmcpD4ELbn+oE1CsiW9iMCqK
 dsokWjW9dI9EThb1ztST9HoJpBZjBhb75XZ+uePm35HYzv7HjlL0tsxzDjdyFVdZmDA/
 Fg3FLgawAaCtB0PgGIjxH9BKDEgLdrBKl12itHFgbMB0dB1Z155+vX8fNMCFu+84/EJx
 iKMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3TdsM9EFv65BG6PIofD4S+9JExei+aGoSAcGftomY0iMTmWZODrURs3e9x2adglgjZiCRAZ5MrLuX@nongnu.org
X-Gm-Message-State: AOJu0YzVEFgrtSqq0CL5hdi/9tUgSHavaNWw29KEIAlLvN3t7nSJxl5T
 89zS7bBnXgj32sQY25sWCrwHaxgNthwfRE8aW07YDkH3hQaheeS/xm1vGnxg/Sw=
X-Google-Smtp-Source: AGHT+IEy+fwHxf4TYkfp5IMfjNJrSmGQWJMq7L1w0zKcvPhCJMYCBcFOFp8XQdZnqXPZRn578gopQg==
X-Received: by 2002:a05:6102:ccd:b0:49e:928f:7976 with SMTP id
 ada2fe7eead31-4a15dc997c6mr3643661137.12.1727286796126; 
 Wed, 25 Sep 2024 10:53:16 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-84e9bb5d9b0sm105497241.31.2024.09.25.10.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 10:53:15 -0700 (PDT)
Message-ID: <1ed85a7b-dbab-4fa5-bc98-24b46d1d9845@ventanamicro.com>
Date: Wed, 25 Sep 2024 14:53:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt: Comment absence of #msi-cells
To: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240925163908.215456-2-ajones@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240925163908.215456-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 9/25/24 1:39 PM, Andrew Jones wrote:
> commit 6df664f87c73 ("Revert "hw/riscv/virt.c: imsics DT: add
> '#msi-cells'"") removed #msi-cells. Now that we have a Linux
> commit to reference add a comment explaining why it was removed
> to avoid it getting added back due to DT validation failures.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cef41c150aaf..4fd9c0edf038 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -552,6 +552,16 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
>                             FDT_IMSIC_INT_CELLS);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> +    /*
> +     * Per the DT binding, we should also add #msi-cells with a value of zero.
> +     * But, Linux which does not include commit db8e81132cf0 ("of/irq: Support
> +     * #msi-cells=<0> in of_msi_get_domain") does not properly handle #msi-cells
> +     * with a value of zero. For this reason, the property has intentionally
> +     * been left out. It's harmless to not add it since the absence of the
> +     * property and a value of zero for the property mean the same thing.
> +     * However, since the DT binding requires the property, DT validation may
> +     * fail.
> +     */
>       qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>                        imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>       qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,

