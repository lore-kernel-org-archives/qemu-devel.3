Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDFECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yT0-0002El-V9; Thu, 09 Oct 2025 17:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ySx-0002Ec-OV
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:46:27 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ySs-00008P-Rg
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:46:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7833765433cso1942807b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760046380; x=1760651180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GFPZXmUOTdS0rQwNrVbXzaV0CHNk2lyUQi0HM0g6XfE=;
 b=goObhncO5KeBjgziPYZnFnzWdYiwT0WYXBWQPINGXSmWGanqzUYV6uv1RNYU76pI/1
 1F4s/Ml2doOtSiJ8q1WnPSTwq9LMl3/VxF1Jm0mPMidWdbCKs4t1VXJ4JYoXwKVctyeI
 IUmaEnCO3LhcGOrDo2gWHcQKmVer2lM4ffGfN7fgv0x6m6CecSdOb6Np6+c8STqM0e+G
 otwTag21gfdwJK6sI4XY8DWWj1Q8PDl8Z125luZVhQ6h4o8MG7nWpGU4uIbfIijjk1m7
 UKvyskSMk2m0vyvIAMJzcrK+Q2m0ttvpszm14510W4YXZaXIoEf80pA+3haC6VlcT6zt
 Gx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760046380; x=1760651180;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFPZXmUOTdS0rQwNrVbXzaV0CHNk2lyUQi0HM0g6XfE=;
 b=JdsX28qhKcY1Kk9E5RZC9ood47VXop3+wO+KTitjLUF6R587YquXLl1OhRxdloD7kO
 jqr9rTp2SXXMPRkNXUHPoFWSJFoQBuoGgRLceFaWNo8R9zO5cei7b6ae/dyohvnPO1/G
 IBaiNnnvifkS0AUkomkbWR4tCRWvSX4y/QFYQro6q7ZXPsH5pLE+oafv8dQfXrAknWBL
 lk6zvR0bKzVrzTbw25MXavOBQLi1Vv5uT8GazAWMA3JhkDsgQJm6RXSHQ9d4JWl1YILx
 AfijjsFCSW3PWdxq821+JsQhrnSGaUIBgLgbndN1qRhZbkpZ8rO3uSBwm4s/R1F1ExLo
 /W2A==
X-Gm-Message-State: AOJu0Yx8BEUxfDVKgVKat/HhWp9ECrpG9Y7Tqsjm8G/cla891pXec4zf
 RqoeYmi0ec5MB5Es5lhkKbV9p8M0TaBVqo54hZ2bSSwWpBu+uD/PAqJGk/0Xm/f7hgEeAfctcCN
 RSZmS6vk=
X-Gm-Gg: ASbGncvtna0cJ0tlj1qScgVDCZoYX/pTm2Hg34ICjBC1LDARGzv4gXQc55PxHXlQnx7
 +P2vWuWiOXBhPc6pfO6f0i9wK+liPDlsC3Ku9Qku7DJZUJeL9rJ8la+lY9Qt8PivW256/oWxgnP
 q3gKKNsS0p4Jvg1zzJ4Y8/64dpxUwLkx9ct4xb6Ezkl+o6QNx7TnAUJqL7hYYA9LCMgir8Kv/0D
 ZUJprdED9/oHeD10Y2kGisS6s/1pMTqaYGy8jEOAuaCk1JVu7AVnMXmaZO6DgA/V+O90brRmvlK
 0RHspn9eeh2OVOgEAK7MXqyMcq7gEtcHbtWSExzw83cP0Z8Xh4qKJfkm4i2DI9MwAgCxjBr/+SN
 yte9dzj5oBbs+djtOEfkaJUSYJd4TzC1iJFEqHJt1uG/bQpKM0qcBk0XqVUnQqhEW
X-Google-Smtp-Source: AGHT+IE8FSQ9S8gW+TCXzH97Wwxt/7EtDn7eRWtTHNDNHQ9OqAGXov5wgh68zMlmeXobqA6wUF6qAQ==
X-Received: by 2002:a05:6a20:3d8d:b0:252:525c:2c2c with SMTP id
 adf61e73a8af0-32da813929amr12516254637.14.1760046379837; 
 Thu, 09 Oct 2025 14:46:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626bb7edsm547805a91.13.2025.10.09.14.46.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:46:19 -0700 (PDT)
Message-ID: <dbd10ec2-fb73-4206-8a09-3840e12f93b3@linaro.org>
Date: Thu, 9 Oct 2025 14:46:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/loongarch/boot: Remove unnecessary cast to
 target_ulong
To: qemu-devel@nongnu.org
References: <20251009201947.34643-1-philmd@linaro.org>
 <20251009201947.34643-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009201947.34643-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/9/25 13:19, Philippe Mathieu-Daudé wrote:
> Reduce initrd_size scope. It is already of signed type (ssize_t),
> no need to cast to unsigned for the comparison.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/loongarch/boot.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index a516415822d..3dd48cb8aab 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -306,7 +306,7 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
>       uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
> -    ssize_t kernel_size, initrd_size;
> +    ssize_t kernel_size;
>   
>       kernel_size = load_elf(info->kernel_filename, NULL,
>                              cpu_loongarch_virt_to_phys, NULL,
> @@ -328,7 +328,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>       }
>   
>       if (info->initrd_filename) {
> -        initrd_size = get_image_size(info->initrd_filename);
> +        ssize_t initrd_size = get_image_size(info->initrd_filename);
> +
>           if (initrd_size > 0) {
>               initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
>               initrd_offset = alloc_initrd_memory(info, initrd_offset,
> @@ -337,7 +338,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                                                 initrd_offset, initrd_size);
>           }
>   
> -        if (initrd_size == (target_ulong)-1) {
> +        if (initrd_size == -1) {
>               error_report("could not load initial ram disk '%s'",
>                            info->initrd_filename);
>               exit(1);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

