Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA44CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 10:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3BDj-0007Fg-MU; Mon, 29 Sep 2025 06:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3BDd-0007FI-TA
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:34:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3BDW-0002JJ-OC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:34:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so4096144f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759142084; x=1759746884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lU5j1ZW8B4DIdcsW0g80wtIon3aynrm35V2NiS0LFpQ=;
 b=ZhX+l+ZC4BNh2EkcN7j6YObbnYlTV1nJ9zoR/Ehwxw8zzSMbVi0Bq05QTZqmcgm2ri
 NijqZpuylIw6vaULvbaqUIHC09ZT1Ppsx3GSiOHmNBAGRhDt/QYobAXBjGzNuq00KqYT
 oXbR6d4cqqdkkhlvQzKMnXG65OgAbXnimWAJikrwZXrD3EZFqh554s4pAU4FpXYkr4It
 Aq5YxO+xzyegYCk9DNVuiUydv+XQCzN+nRXCGGxjz7FZzvSCBZQaBkShUfLg7yOpzIVt
 /OWQGxobyjuEMVdb0Zmzr7xF1B7xeY/36F5HuYPxQ/Gu3dQu1IxzhA7QnGCkLbnMqiMw
 tdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759142084; x=1759746884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lU5j1ZW8B4DIdcsW0g80wtIon3aynrm35V2NiS0LFpQ=;
 b=IAUaUDAjNS+SEofuVAwZJkSgyno/idIK+0t2K2wr51eBfhQBlZM6AnEs9MlJ44wdRB
 CMI4bGDVm7QHGxg5fVHvF+HdZWkZ53ugYWZMvb/Gxrlz5qBieG+PJUnT+6U+IW80qs/9
 b+uvkjDsd5yL4+G6+jhTbHSP8HMzkyhPHw6wLNtxH1v516vJWK6GYjYUP6+SMCm0+dwe
 o/J1P+/O1fsb8RlFfPB8UuvNu6rtqLN1teZoSzu81s05/CXw3yBvmu9PkrMgWIc2ozjM
 7Q1GN0deX4qYwkRfCkSK2b7IKni4SmAUxXdxutq2bYhENRxjlXAJcVKDporgzVG+jHuF
 4YyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU8k7n7hKF0LFhRrxURnjPRAzUoxP4gSbWUpg4zqb3PE7B3Y1+3+TYva5oNIUDeOrxnFZg+P9nTVrd@nongnu.org
X-Gm-Message-State: AOJu0Yx1VdpX66VLmzp5gtxvlu8+LEkCc2kTWx5o8esSV0hnzs2Cs7XA
 tyxcSjO5w07nO6YGNTIyzpiOPY3+x7OufXJKaKXOIb9PDqXUyaH5gL4U7RnyAvVaqwY=
X-Gm-Gg: ASbGncsB0xAuJb3Yvhntt+RKp1Nhdu5qkCX7u/zWk+KhH2QE83bMiMBBVXxoOvDh6b4
 PqRQj6P6cLg6vqkew4+BnrsOFTXoJQ8OlD+vEoEkl8TH468VkOE2R7Ln/Ku9N2AXImN4z7T04J1
 wYXwRKPBHOIvh6tX/dNUiVtlLuO2TKcIv7AG0pvevYZgqCRITwAnfOZsg+8ka09x8DeqRb1RTOx
 hy/0p65tV7aGobDYTlE8oeT5oNMYVRohW+JzGWCDM2nLfYDy8JP6roOIkABBD+zrDMqYeIN4eCL
 bFCYf2mLZfSoYSdIbFRvFBANJNmjYmta54vZBSlQcRdt59ahcX+Ti2xpr8TnWIOjCmOKgiBhu1c
 2inEFUdOGtXFwYYtfyGUPAQf9Km/WslzmXYBSIOXfSWz1OT5rQA2F2ATaEttcpHSV4A==
X-Google-Smtp-Source: AGHT+IEkNGd02Gft0MURV60kI3ZYG/yZ4zzb59CnjidNYnApzfkGAVWU5ekJUime5iaOE0RPsRn02g==
X-Received: by 2002:a05:6000:220e:b0:3ea:9042:e682 with SMTP id
 ffacd0b85a97d-40e469db815mr16093360f8f.11.1759142084111; 
 Mon, 29 Sep 2025 03:34:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc88b0779sm17497647f8f.58.2025.09.29.03.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 03:34:43 -0700 (PDT)
Message-ID: <70156c9c-5559-496d-8753-99f1ba5f68d1@linaro.org>
Date: Mon, 29 Sep 2025 12:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 38/47] hw/arm/xlnx-versal: add the target field in IRQ
 descriptor
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
 <20250926070806.292065-39-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250926070806.292065-39-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 26/9/25 09:07, Luc Michel wrote:
> Add the target field in the IRQ descriptor. This allows to target an IRQ
> to another IRQ controller than the GIC(s). Other supported targets are
> the PMC PPU1 CPU interrupt controller and the EAM (Error management)
> device. Those two devices are currently not implemented so IRQs
> targeting those will be left unconnected. This is in preparation for
> versal2.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/arm/xlnx-versal.c | 41 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 3d960ed2636..64744401182 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -50,18 +50,30 @@
>   #include "hw/cpu/cluster.h"
>   #include "hw/arm/bsa.h"
>   
>   /*
>    * IRQ descriptor to catch the following cases:
> + *   - An IRQ can either connect to the GICs, to the PPU1 intc, or the the EAM
>    *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
>    */
>   FIELD(VERSAL_IRQ, IRQ, 0, 16)
> +FIELD(VERSAL_IRQ, TARGET, 16, 2)
>   FIELD(VERSAL_IRQ, ORED, 18, 1)
>   FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
>   
> +typedef enum VersalIrqTarget {
> +    IRQ_TARGET_GIC,
> +    IRQ_TARGET_PPU1,
> +    IRQ_TARGET_EAM,

Maybe declare IRQ_TARGET_RSVD here,

> +} VersalIrqTarget;
> +
> +#define PPU1_IRQ(irq) ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
> +#define EAM_IRQ(irq) ((IRQ_TARGET_EAM << R_VERSAL_IRQ_TARGET_SHIFT) | (irq))
>   #define OR_IRQ(irq, or_idx) \
>       (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
> +#define PPU1_OR_IRQ(irq, or_idx) \
> +    ((IRQ_TARGET_PPU1 << R_VERSAL_IRQ_TARGET_SHIFT) | OR_IRQ(irq, or_idx))
>   
>   typedef struct VersalSimplePeriphMap {
>       uint64_t addr;
>       int irq;
>   } VersalSimplePeriphMap;
> @@ -412,19 +424,27 @@ static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
>    * Or gates are placed under the /soc/irq-or-gates QOM container.
>    */
>   static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
>                                             qemu_irq target_irq)
>   {
> +    static const char *TARGET_STR[] = {
> +        [IRQ_TARGET_GIC] = "gic",
> +        [IRQ_TARGET_PPU1] = "ppu1",
> +        [IRQ_TARGET_EAM] = "eam",
> +    };
> +
> +    VersalIrqTarget target;
>       Object *container = versal_get_child(s, "irq-or-gates");
>       DeviceState *dev;
>       g_autofree char *name;
>       int idx, or_idx;
>   
>       idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
>       or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> +    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);

and assert(target != IRQ_TARGET_RSVD) here?

>   
> -    name = g_strdup_printf("irq[%d]", idx);
> +    name = g_strdup_printf("%s-irq[%d]", TARGET_STR[target], idx);
>       dev = DEVICE(object_resolve_path_at(container, name));
>   
>       if (dev == NULL) {
>           dev = qdev_new(TYPE_OR_IRQ);
>           object_property_add_child(container, name, OBJECT(dev));
> @@ -436,16 +456,33 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
>       return qdev_get_gpio_in(dev, or_idx);
>   }
>   
>   static qemu_irq versal_get_irq(Versal *s, int irq_idx)
>   {
> +    VersalIrqTarget target;
>       qemu_irq irq;
>       bool ored;
>   
> +    target = FIELD_EX32(irq_idx, VERSAL_IRQ, TARGET);
>       ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
>   
> -    irq = versal_get_gic_irq(s, irq_idx);
> +    switch (target) {
> +    case IRQ_TARGET_EAM:
> +        /* EAM not implemented */
> +        return NULL;
> +
> +    case IRQ_TARGET_PPU1:
> +        /* PPU1 CPU not implemented */
> +        return NULL;
> +
> +    case IRQ_TARGET_GIC:
> +        irq = versal_get_gic_irq(s, irq_idx);
> +        break;
> +
> +    default:

And here 'case IRQ_TARGET_RSVD' instead.

> +        g_assert_not_reached();
> +    }
>   
>       if (ored) {
>           irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
>       }
>   


