Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FAC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYU54-0005xN-6S; Thu, 16 Jan 2025 12:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU51-0005x7-Fv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:54:56 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU4z-0005dQ-HU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:54:55 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166651f752so28058915ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050091; x=1737654891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5KeSDZ/6DwMWP0/GinvXFUoma8pRGigPxo2i6ys0nk=;
 b=D2rX5//NvdvfsRb491QOG+BFriKdRqcTNx+r7FjY5Jz7XYnvdf82V0sGw9BrffnGBZ
 4hH1dKWriZ8yRWPrJjk2IBPOJLhotZZJB3y0o/ZwBdWlXV7FxWjCXu4eoDAz6Vk7wgxG
 cz8t4ELVU6coOB8K9fCqApp8xBliu3glrBYWrLNm385JqX67MG53mbPk3qoPl89vorBu
 enT5fgWW+LjNeIBCtqdofXh/06/zan4nivEwqxQAw/Sbk9gZcV20KMBxcUW37IRIja/P
 Q80dImGxS92DxZ3/9300gluzhf9gmofOd6+pMGYSvA9Xgk4c7oMt69G5kA7BrqgezsW3
 4zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050091; x=1737654891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5KeSDZ/6DwMWP0/GinvXFUoma8pRGigPxo2i6ys0nk=;
 b=hj3m9RFZd4ATWo96ymwrJ1V70Eyzsjsbhz8arS5vf7xYETzZtLGRcnlhDjty9sOehY
 Lp1obXnTg/tJHeWGAMbEoquv2ygrS+6cVBfrUwTjViOPnCPwB/VtNQD68Ytrtq49GfZb
 ykEF5LFo4G9xr10P/pHJLQFr0CWNAFBFCf3z21FmG74obzrf7xWJfK37FazK7hNGDfYR
 B1AzmM3AZEI+COqFDrquyWHJreRGDGFD6Rw74crmOLN/s0Pjsv8aITqiV2Iy4GcqP+ZT
 dC0JI+r3430NXEOe7B6FlEv2RCaS5wR9JbBE5wr36BKtfS6R0hQ+43jXdIDq0X+diXvN
 1BCg==
X-Gm-Message-State: AOJu0YzbPEy2+3kpPn/KtIeKJcFufdB22saxkeCTa5+RF3/v0Aukkx9e
 /yy/R9YXhLTyTMgUg88O07adi2GA/nnwyOpczN+uiGVOKuq9pRfCU/Z9pup24Pl5BbZprEdyfxZ
 X
X-Gm-Gg: ASbGncuV32PFBVHuhLcdRGYDco5hlKrdcaPbT28OWRNlmgvjdCLqL/m4npYeODzH5JM
 vTvzJ2yDCoL8ju8QhOqrXrwiLD1C80wAmlShKZpaN+osSaj+so3kF9aHjd9p9Iorxm2z8PC6QXr
 vDIH0uOcxtB8ZE/zS07C2IUuAvD8nFCdqIo7E+AiWsHPoGs4Nu4hS5wGlHRc0MtYDZQd+uSga0W
 3PNzgnjGIhU8NxSnfar6dGgf4VaZcshD7UmyhWtW5Tedl3wgt+iD/d20E3qyaL3PIz4drB58/7E
 fs5SdGL8vRTgE/JewchCFu8=
X-Google-Smtp-Source: AGHT+IFsNEgNp9VZ+Ow9dA6YfMoY82itMLNiWAIhMKaJK1FVXpd7a5zih6Vn4C4i1nqHQUWWoSmr2w==
X-Received: by 2002:a17:90b:2747:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-2f548e9c9bcmr51375813a91.2.1737050091649; 
 Thu, 16 Jan 2025 09:54:51 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77611a28asm451247a91.10.2025.01.16.09.54.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:54:51 -0800 (PST)
Message-ID: <897c250b-a9f6-4802-9d87-a9cd2cdd947d@linaro.org>
Date: Thu, 16 Jan 2025 09:54:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 05/13] hw/arm/virt: Remove
 VirtMachineClass::no_its field
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::no_its field was only used by
> virt-2.7 machine, which got removed. Remove it and
> simplify virt_instance_init() and virt_acpi_build().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/arm/virt.h    |  1 -
>   hw/arm/virt-acpi-build.c |  5 ++---
>   hw/arm/virt.c            | 16 ++++++----------
>   3 files changed, 8 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

