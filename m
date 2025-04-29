Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA0AC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ogU-0006or-Sw; Tue, 29 Apr 2025 13:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ogN-0006fd-TV
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:23:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9ogM-0001Zq-BS
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:23:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso5546753b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947425; x=1746552225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uDvlbzqaXVlm7tYlOEBATASmwhmdbVDN5Rp7vmjiLeQ=;
 b=MyKYExW+WfTd/uscZ3s0NKMwadPlyqoPXrCrvBirHV0/RXv277qQAOGFjJ6HjBlemR
 2aZdKrvjQhfI5zbusW7j5jeuCT2sbXyFwv3M/ePaDxxruuQszE+eCEOabMSSZb8e90el
 D8cS6XatKREUysPpdjP6yGNklMSKRbzs6IwWBYDoI7E517tXYAPRCe7JchfNtWK/mrzE
 o/sPWj5qdQxzPKRq/K3jcwBr3N/yUULByhMUjWFwb8S0JE3RPWpswUZ3SViAoapST+2J
 DVWllboWqyWyDNt92XPkFY4Mz9AmwC1S/xNPoCUMN04EnJq9NRsxZpuv4SsFL7SI9y5o
 fwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947425; x=1746552225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uDvlbzqaXVlm7tYlOEBATASmwhmdbVDN5Rp7vmjiLeQ=;
 b=mq74pw2m8PusYniGydhIJBmQ0NWtK4pO8ws92EyVSkwyA9QxAyAjOnd2edUppJHyM9
 U1IKfY2O+SBjoTG2YULZYWkd4s8O/rQDmcUkITkmwvPQHRaCVkAsx9rZUnCXEhAx0goh
 SVXUFzPNrHrzALbMY8/kPdW+iZOR6olxzpANaEnEiflTdKXArWdtWLdMqSW9YTNdIJyq
 JcD5sx0sfEu2J6nC/VtEiVAisLpzjD7i8hmhZ/FqttBTubXB2OVDq4jbr6+Ri5Q5nK5J
 qsy5E0MLRs5uDxPrwZ1D/v7u33IkL36sT/tZ/W98hYmI54JP4vRRcDewRFTh65dxn1dh
 BhtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBczleV2wVPjQ8it24GjL9ivpVu/9GCNxyNtm8e/vXV1RxFZhub7sBY+OGe2zrdvywRFYlUgdNDB2V@nongnu.org
X-Gm-Message-State: AOJu0YyMPbtf9vcMq6rfyfnbIzDfDn6ngxcuURjlR07PAmmJ+TfYj3o9
 mXhu3kqDLmgtQ+j+BYbOQ/KuhbOfcxQ8Uc2lbS4T0X0PGr0Vb0QylhWl/23qFjM=
X-Gm-Gg: ASbGncu23e8kPrNNfWOF+WPCi529P9KdOlDA31wreZ3v+/vxSmObGAr3FQllO7daOzH
 sKfhF6rUbatpZ7TubkX9Z9qDkiTaoJkSQwpLTLS3P0MFmXSP1rA/ZBQ/1mocZGkedoa8UKf/dq1
 UMVkIHYXOGdIdrHu1uKIH36JloIx0dYA2WkiI2zXdQkqqUX9NWXBypgH/z73YsCHuyVfkXyCc1Y
 Pr1qq4bLDq/kjL9/SG4M9RTmT8zNmNBtNunGSNEIgC9X4iPNlRZPdhR3JmfcfFY0Iw7fjnp0qGO
 QXwweXRjALMrML6I4SDiQ8/bpmyKcyBcHRHngz/wrZ4w5gK82Xw667o=
X-Google-Smtp-Source: AGHT+IFYMi4bkkvWoUbV6Lz+Pp93qh3BE7T+nPrJoSVP+HdwNkkuihGGtdCPLFsDHjpO/9GLu6QQ8Q==
X-Received: by 2002:a05:6a21:998e:b0:1f5:55b7:1bb4 with SMTP id
 adf61e73a8af0-209561f31cfmr5020674637.11.1745947424785; 
 Tue, 29 Apr 2025 10:23:44 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74002791fb3sm5927898b3a.70.2025.04.29.10.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:23:44 -0700 (PDT)
Message-ID: <abc5b006-8c83-43cf-941b-e6381e2428a9@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:23:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/riscv/virt: Use setprop_sized_cells for virtio
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-9-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-9-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

>   hw/riscv/virt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 3b4c3d6b2683..cf7e16cc6678 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -856,9 +856,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
>   
>           qemu_fdt_add_subnode(ms->fdt, name);
>           qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
> -        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -                               0x0, addr,
> -                               0x0, size);
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
>           qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>               irq_virtio_phandle);
>           if (s->aia_type == VIRT_AIA_TYPE_NONE) {


