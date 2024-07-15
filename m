Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E7C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 15:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTNS3-0003V8-Sh; Mon, 15 Jul 2024 11:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTNS2-0003Ud-PA
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:17:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTNS1-0000ND-8Q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:17:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so5186955e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721056635; x=1721661435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CgBIBtUbyz34ks5AY1/9OwopG6GUqlM8cQubTXp/x7s=;
 b=IcuzSrGSaMSA9vwCpLANayERGqmcqVRRn7XDSFVT7/4qPc7MUDnEsWliP+5qkL1NDD
 LkyAK2xxZjmD4kQ7FfcoG9YOpFQYsAIlMNvSXatPMCjvauG2VzaCkzRTeb+hQ3wLkorJ
 lbeFBV8q0q1BXyRIWNG4z72ETA5dviBdALtHxQU+P+kPGTS2a0tvTnxNkxFilpLjtu73
 byX/1BVyaE/0abtr1PLxu87UB1W7JXLC2cQVsEMZtfF4f/QVV3Eau4k4EaRg3F6+W02L
 hc4DIkvgT0ywXgqqkGt9xWKnaQmJfeGRp0QJCM8HQRcZNAg3/VkttPXVe1d6yEHf+wLf
 gAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721056635; x=1721661435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CgBIBtUbyz34ks5AY1/9OwopG6GUqlM8cQubTXp/x7s=;
 b=axda1RRCixbo9cUUVkRo5hoQDDCgmE326vdwGKJEr8zz2ymZLUA6GCB2zQED8rrZ92
 Lc+YhLg/8LLz+GKSAmprWk72hcy4qHlpS/k26rCPUOR3FSuo4C1Yi2+KN6VoYoYWW/ZM
 rrODsohoUcx2MeNtJh0Tb9JLD646NaNYrEhF0U87oWdgcE9lkzRTIQRqiHns9lqKlTXP
 dTMAs+MkzQsDEHj/8dDk+Q0FgwdCfVDnkKD+dhBekSJemOfWggfaM8+XBaexaOnqqLF1
 IH77JIOnu7ACJea03i7nIriYTX9qHLEuXzDc079NMk4mKx6LQBpS62GxLXihC1cE9LQj
 KLPg==
X-Gm-Message-State: AOJu0YwznZ/kRX42OIJcahytzKPUvkbHb/a8bnwxuh4eXKqQfx/myRB6
 qRliLQqk0W38ulcAspABHKZQ4U02cvaSvPRQxuJZVrRtdhXDlP6ptBmK83tU1R8=
X-Google-Smtp-Source: AGHT+IHkGwkZZVf9jnvYmWrNF2usFSg6aAK4job1pobFqZr7SfkCm10vrlql1bxA1/pClzO5r0AfOA==
X-Received: by 2002:a05:600c:1c03:b0:426:711c:6591 with SMTP id
 5b1f17b1804b1-4279d9f2809mr81433745e9.4.1721056635579; 
 Mon, 15 Jul 2024 08:17:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3bd8sm6700168f8f.13.2024.07.15.08.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 08:17:14 -0700 (PDT)
Message-ID: <682d514b-1d49-4e23-9cb7-a6fd83cbd863@linaro.org>
Date: Mon, 15 Jul 2024 17:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Reconstruct loongson ipi driver
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240704033802.3838618-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240704033802.3838618-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 4/7/24 05:37, Bibo Mao wrote:
> Now loongson ipi and loongarch ipi share the same code with different
> macro, loongson ipi has its separate function such mmio region,
> loongarch ipi has other requirement such as irqchip in kernel.
> 
> Interrupt irqchip has strong relationship with architecture, since
> it sends irq to vcpu and interfaces to get irqchip register is also
> architecture specific.
> 
> Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
> is added, it comes from loongson ipi mostly. And it defined four abstract
> interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 machine,
> also can be used for 3A5000 irqchip in kernel mode soon.
> 
> Also Loongarch ipi and loongson ipi device are added here, it inherits
> from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
> loongson ipi device only passes to compile and make check, it is not
> tested.
> 
> Bibo Mao (4):
>    hw/intc/loongson_ipi_common: Add loongson ipi common class
>    hw/intc/loongarch_ipi: Add loongarch ipi support
>    hw/loongarch/virt: Replace loongson ipi with loongarch ipi
>    hw/intc/loongson_ipi: reconstruct driver inherit from common class

I'll try to respin a clearer v3.


