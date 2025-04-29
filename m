Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73D2C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9oh7-0000Eq-Ch; Tue, 29 Apr 2025 13:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9oh3-0008W9-VJ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:24:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9oh1-0001k7-I6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:24:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224100e9a5cso76814925ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947466; x=1746552266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P06xuHvGSJLkc71HiUE9jTxxAf7SFPP8chppX7+wB4o=;
 b=Wkkg1p2KMxVRammqJBDSbMUdhKA4YS56PA/LFcSSn2MNO9fuhCgraQ5qtvy1zUYCfT
 qkNJ03dRlNFFyuG2MwefQG9KSjogEIztkUYDlDzODEUqVEbvsr6Y9ySQJAWVS8o4HW/0
 0cuep4sMkB5hQ8m4ANw95kMCdZyXMhTApxX7nrZHMgFu4d6ykc9qDDRu1kgnY5EaYiWm
 adL8n5JfroDb6aRiO0IdeTjyVDGTeYRPoCB0EtagCiFZjcHszFkn4nYRnorK8U5ybL7R
 4RsYVPjM0OIKhj5OTSyTHM1B4ewdkm4k1QE3Owh+mNheGRoUfnnbZ//sD26ThtqFmE2O
 3a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947466; x=1746552266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P06xuHvGSJLkc71HiUE9jTxxAf7SFPP8chppX7+wB4o=;
 b=eslXMay6YHdLV0v1x/iquns+yMoHF87zTq+SAJiTM337RwLCTa9cr9bl/0foPH/LYe
 WlhIkebJkflGX08rbcigmo+2PjbCHlntZDtDiu4l976fuBUNgVZe5IQyHXxfo++06Sf7
 o96IRYTrB0QQq3tfJbxyfrBD89wJzgfO/e1le8jH79/c6cJSITZQpgkzmg8/RPeRkjJ9
 0isITNg4HQC+gL+N0Hx0cC0Ysak9vxhLSaoWbUwuuhX3YMUhWDtELcxrzNum8pMVcQWA
 DXL0XIMF8UPym9fc3Zy1eh+/uV/VXoSc1+FlMb8TRwH+bj2WYpDmmUloPddJRPQPK6a9
 JtMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVImX60/tUekuggoRA4h+ckbVKbXL2ngGySXu4R9ChqjyA9c3NCuByXmktRrFeL5LUKxIKTfNbQn4AQ@nongnu.org
X-Gm-Message-State: AOJu0YyoJOZZpeg4x+52YfcX5Jda3VrHXNl2QJYsul+SCCR++48kfaUI
 xNKLSN8/VJVSfAe7UYW6h0QCIAbKaGBq4HNWzMPaI2FZKfbYzRvZwa6r8nUWMlWXPhkrBXvQegb
 S
X-Gm-Gg: ASbGncvAWScW9Ioal+mK3ibx+9gAOmpRdIzkDr+s+a9ETBuQMYdRFRWp0rpVqEXqRwi
 wTnLfC+Ssw64NBU46ucp1N0ITmC3vuG0YIlsGV4vABCK6GjybwjgXH2YLzvmdpTQelXG7piH9bs
 JmhwMo6KL01fWxH91ksMf+9GSh9O5xhrhTVfoxWLu0zw7kUXAYx3s1KKbH8XtHckFVwHgvUBFQY
 nHI0S5ro9B/ftBnx0Cp2APskOOOeffs57Dc7476XM1K44xdIyOiuOtACxoUoZ+goY0jAZ/UVhBs
 0mmXUR0JnZOnDeGmSL7NMyiQb4jEu+IVCqGoeToM5C/1dmk6ELfIUqQ=
X-Google-Smtp-Source: AGHT+IFdkaalzIxqRNPunjMM+lY/U1J8tQxD6Sar+WG6oT9Ervkg8DLW4yFwUSAhqcpfdaLrWUUHGg==
X-Received: by 2002:a17:903:40c5:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22df356f7b7mr2721635ad.35.1745947465760; 
 Tue, 29 Apr 2025 10:24:25 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbcb26sm105426675ad.68.2025.04.29.10.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:24:25 -0700 (PDT)
Message-ID: <1c026dcf-5cd1-47c9-96c8-5c46758fb580@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:24:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] hw/riscv/virt: Use setprop_sized_cells for rtc
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-12-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-12-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

>   hw/riscv/virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d9303c9bb033..823ef7cbe447 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -992,8 +992,9 @@ static void create_fdt_rtc(RISCVVirtState *s,
>       qemu_fdt_add_subnode(ms->fdt, name);
>       qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>           "google,goldfish-rtc");
> -    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -        0x0, s->memmap[VIRT_RTC].base, 0x0, s->memmap[VIRT_RTC].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +                                 2, s->memmap[VIRT_RTC].base,
> +                                 2, s->memmap[VIRT_RTC].size);
>       qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>           irq_mmio_phandle);
>       if (s->aia_type == VIRT_AIA_TYPE_NONE) {


