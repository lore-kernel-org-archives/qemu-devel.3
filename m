Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817B6FDEE4D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2Xp-0007KD-FR; Thu, 23 Apr 2026 18:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Xj-0007Jg-NM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:29:08 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Xi-0002Dq-Ai
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:29:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so6273254a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776983345; x=1777588145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HT3dPnIYsn/YYAp/uYDFzEtCIrdo9tjK+ProFtp830M=;
 b=SCSwH2ViBPIp753iA/Wo8eWqPjhV9blCFfHUEc8udLWcFfSdNvhGg6vg+jDVA57ARb
 4QzNFOV9ANaD4fPA4dWdcWcnWRBuamf7ct6+Zv4a6NXoiCZ+RsSvWJa1B6IcRJDj9u9d
 DX0Jh5enWjnz+iqvPJIr4XNwYjH3NrvwX8SMDmHRxPVC7aC7OAPIUzp6B1TdDDQlPEtl
 s0X57b1+9qp0DshPTVYJhjNu1JVvw926LZwy3b2IEXWGO+eg59Hf/QjiQjvLROCD/BrV
 gy7L+UuZYOGGeVGySTrtUK77y5I5GPK48QfVULidB66Qi0pwnmh8cuoxmD88lF3YopAc
 leXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776983345; x=1777588145;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HT3dPnIYsn/YYAp/uYDFzEtCIrdo9tjK+ProFtp830M=;
 b=bzprFCWVqaB31SdG76AX3alG5O3F1r0RMsAoSr8nN7gVTvqSyFnnfMjmOXq5wqVf7e
 lDDdtAIlC6gGABKcA1uloI5yNjhddOsU9g+u1ynpp3dbNeZLYt96bEsQBaE99peEr0Z5
 MoPI38q/Q8xQZT6nO0kx3siggZLaGpkbE3Oh3BKCokijuPlKCWdOeEv1Jm6sjYLFo3tl
 RZSNHWIkqmUgIhilrMm8XPLKxJDhlaB3b3q6cUcCyVytc9kKl2SB2M+sdCHdQ8ih2YoA
 x3bhmncnauNSsILx6AwJbF0y3ykudGZnL98nskq/O9DPr+v5+RlM4R9ngUM73hHMaqVM
 njqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/66cV1vp5T+BK/wZ+cR6JYtFNN5elEeXsVqV5qJ+pn1mFcam6Do8rXTle+1qnYjM5n4yjtH8btCzzw@nongnu.org
X-Gm-Message-State: AOJu0Yx0WVvF3a36nEGnZCZgUYO47RImMzgbt5cdl0XQ5MMyFzF+7aFP
 eU7kT2NMmXkrejwB3BfcK+XaAiUCSk6URu7Xi+Y4p8WWKwonCsaXijEdlaXsb6bkmU0=
X-Gm-Gg: AeBDiesDiObd3UkZumPHV0oPT6gecEPIxc8JYERLOdaWJvxkEkjVUr4bIjK8ipyUqQ9
 DUPEXl5aNEzImGZ/GU/RKJc2j7p0kNvYaaluJdgIWY5fMzYI+fbm+70ojmnapyGsIvlyrZfyvKs
 /4EKJizKZ+dQv1f/K7oIKXTdT7G9XLkYRrg5l4zaRgxxpivsRQCvXylJeWt6EWfS8qD5iKPeBWt
 0sz5U0Wzz7wyZCfGbQeK2y74oREn4XZUIi3emcR8orYz2Jy415Bk/xDTG2owenFyNfhL1CUlMx1
 ta+qr2h2bFG+VLLOc6OMpob1C+X/HCQndpr+mNlG1lMkU2HWXuLGI+bhSa1RmL6AsdRdGde9WNh
 lCsrbPz3hs/c+UVeFyHK6/gdaUxBWB+uNq4EV0FihViC6bODuPpRj7y630d4H1DSCGxsDT5YoLT
 5FLAOTtiaRRgX71f4qb7/rlJ9jTGYVxPEKeyFbAfarGXIvHyUZ7Q==
X-Received: by 2002:a17:90b:5583:b0:35b:8d89:7199 with SMTP id
 98e67ed59e1d1-36140468a44mr30395264a91.15.1776983344860; 
 Thu, 23 Apr 2026 15:29:04 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410cc196sm21496885a91.17.2026.04.23.15.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:29:04 -0700 (PDT)
Message-ID: <a7846ecc-e933-42e4-b251-d9ea4e4b51ef@linaro.org>
Date: Fri, 24 Apr 2026 08:28:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] hw/arm/virt: Do not select Kconfig symbol
 PCI_EXPRESS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
> The PCIe bus is not provided by the Virt machine but by
> its GPEX host bridge (selected via PCI_EXPRESS_GENERIC_BRIDGE).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4e50fb1111f..41d5e968c86 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -15,7 +15,6 @@ config ARM_VIRT
>       select GPIO_KEY
>       select DEVICE_TREE
>       select FW_CFG_DMA
> -    select PCI_EXPRESS
>       select PCI_EXPRESS_GENERIC_BRIDGE
>       select PFLASH_CFI01
>       select PL011 # UART

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

