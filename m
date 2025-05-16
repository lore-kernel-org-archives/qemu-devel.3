Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F3AC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 11:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFtZw-0004r7-S9; Fri, 16 May 2025 07:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFtZr-0004oF-0Z
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:50:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFtZo-0002G1-Qz
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:50:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so16000045e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747396206; x=1748001006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0A9MS1vmxv0EzmUdbLkMsjsRwI+NwrQUgv8MqvSU02k=;
 b=Tj2Q6+UT+t/fopg864QNXZWYMbbWwoBecqzZfbrwC+xiNwTxs2+2xxPwZpfYPmYX49
 DuofY5XK2ZCaGfUc0RiZNBmPo+XcNPI3qq/Qe6B6ISmRFxEAcmcfPLEPBaC7DeT4AkoI
 jLKGf+Y100ykrYY+yT/3Qbkht55onYrJ451aJawsaDnQPtsloQwD6rFtL/kM/0owhCIc
 DT+3bfII9z50v3BLKcB2P1c2MXYqb87DeLl5tt9RIjZkPINg+1lXjtagR1FbkcVCI3Fj
 4oW8uzrVLOsHHhh7LjWbmA55TIg4OFDxLJnZu6Wt14XTIfrgyA9t4oPetgchzvWOEhxA
 ZyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747396206; x=1748001006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0A9MS1vmxv0EzmUdbLkMsjsRwI+NwrQUgv8MqvSU02k=;
 b=eHyUyPs/+S+fl03tekvgo9JxHXZLYqyg0NPflbzo97hEzoWkags3AfHI8HwZRao2VT
 tcGISdtXX6Wo4zXc6QgAXbqGGOQTu8I7KclaSs2mBWCFKI4R6WOf0EeE5szUfv+Ay49S
 U0S2DWVGVDqSnSy3t8/iczygRTZCMfv84Y4WGYZG8mvJs32zLK1v5jl8PxWt0wdAR7yn
 JnhYvqFkRAd5EkHSNfWweuVphHUGHdDzCRXFjHtH6smm8FJBlPVnDp4BYWtuDnO0buvu
 mPYyanF9Qip5+Bb+fSU1QtgiCxzqHmp5sgGT1gXmqkEfJ3EKuRY7pcIMwg3P3eoUFszS
 gZAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTa+Krc4M/Hg7yY6ARuSrs6vW3ekK4mqI0vXSYin7Fz7aP5eAtZTaYllT343phBEv/1xldokHWkvo/@nongnu.org
X-Gm-Message-State: AOJu0YzePXaHTsRAl+3kwkC4x+n5KzAIcUEJoEJehG9WmhRIzmRvm2rj
 t33FzncsVoM5uoq32qqs3mLlELAPAAKFOdtJmuiOLSbvQTBzM5j6akKfGO05Q4PIEZA=
X-Gm-Gg: ASbGncso/bQ8t+8yVtEUfhtGWwuHddp8LevGJTjN2OGvxlWq/7pNVfVHXF7wC6ytGmV
 cZBrUccYGarr6CKdliUHj+8NIYc7RxaNUhonUZGdAzMtt1blQyZOMyTNqOjkFRNHFNJEpPwhQ4F
 7MumpoESmZ1jhSnVCX5bcEw6x+U5VwcEXdXT7GZk8tqrk49cVHMBVEOYlcsHmEhdAmR9Z55iZov
 9mNEZagVUgSvUy5jxhKo1iAFtdbcitxyRvbAViMEb3uthXL/v48i+hKDRRvOPrZfo5Xq0rSXuPC
 9gMZ6ZY1qKlyCb5g43tFxjuBjJBhP1m1/OQAeJ7755P7/KWS8vDWAaogD67gQWPWr1E1N+uftUQ
 u5beTkzwdQxPszR4kXYoRDgc=
X-Google-Smtp-Source: AGHT+IHZTq2CB/oyylLd/8hEV4HoeQhGxmwHd+7HjI+ZB3CiLIJ+fAfI5x22s6Xe36BtYqa8f6GFxw==
X-Received: by 2002:a05:600c:1c28:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-442fd60b66emr30395985e9.4.1747396206121; 
 Fri, 16 May 2025 04:50:06 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3368fbasm103084755e9.2.2025.05.16.04.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 04:50:05 -0700 (PDT)
Message-ID: <4feacbca-76fe-42cd-a8f6-9daf70f2b437@linaro.org>
Date: Fri, 16 May 2025 12:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 34/46] hw/intc/aspeed: Add Support for AST2700 INTCIO
 Controller
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250309135130.545764-1-clg@redhat.com>
 <20250309135130.545764-35-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250309135130.545764-35-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 9/3/25 14:51, Cédric Le Goater wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Introduce a new ast2700 INTCIO class to support AST2700 INTCIO.
> Added new register definitions for INTCIO, including enable and status
> registers for IRQs GICINT192 through GICINT197.
> Created a dedicated IRQ array for INTCIO, supporting six input pins and six
> output pins, aligning with the newly defined registers.
> Implemented "aspeed_intcio_read" and "aspeed_intcio_write" to handle
> INTCIO-specific register access.


> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-18-jamin_lin@aspeedtech.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/intc/aspeed_intc.h |   1 +
>   hw/intc/aspeed_intc.c         | 112 ++++++++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+)


> +static uint64_t aspeed_intcio_read(void *opaque, hwaddr offset,
> +                                   unsigned int size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    const char *name = object_get_typename(OBJECT(s));
> +    uint32_t reg = offset >> 2;
> +    uint32_t value = 0;
> +
> +    value = s->regs[reg];
> +    trace_aspeed_intc_read(name, offset, size, value);
> +
> +    return value;
> +}

> +static const MemoryRegionOps aspeed_intcio_ops = {
> +    .read = aspeed_intcio_read,
> +    .write = aspeed_intcio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }

Could be safer to also add .impl.min_access_size = 4.

> +};

