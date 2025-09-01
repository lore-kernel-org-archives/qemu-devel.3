Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2630BCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyND-0007ky-LD; Mon, 01 Sep 2025 02:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyN9-0007kF-AI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:50:37 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyN3-0003jZ-0e
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:50:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ce772ce0dbso2578878f8f.0
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709425; x=1757314225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6E9A960jbVOAMlyqedfCczgm/vu++jpw8uZfh5+v1VA=;
 b=D+Qk/8C6pIhOrD+cP9oqIAdXxKLrqTri9hwLt3v1NqyIbeWdJs8qhf4Mwp+65/5lqJ
 1voEZ+JOGlaxksQAZqgtfZOjas/sIkUuz0FBATxQOcvuCEvq98PHbu/eRw1Shz0QI/8V
 JOmiYY07dPjlo8H+0JJJ8T1IjCOmFM8T2fVRxAKD54VPMSD2In+LJWqclCNXUfIq9S1e
 0ss+zHJHtOmaTE1hO2dzjvU9cVtSw65DDgCkZ968jR9epnnSNbAOli7F1KYg0EwWDYwn
 QGDPq46gSpj17FG6YgKktyPnGzxE7bzbcrT28ykEtM0QS6ZNEuNhBcuarUNwAICqQtXB
 j0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709425; x=1757314225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6E9A960jbVOAMlyqedfCczgm/vu++jpw8uZfh5+v1VA=;
 b=nQLzvgM8/u+FEVK7BziTWpbWUwpPgt6JAuoOXwNjppGogZx0v2VdvDOI1SnRwyAQ9i
 EEL8MqZwE16jsxzL3cy9+10uJrYJaewlDqpvoU7d//5doaiGNdRZBSyG/OKGpRA1xfI9
 uULiLpUjxIJBF3uuR2qO2qFmFAYbtxT2EolXLcRkPHMludrYg5wUxrLnTcCVRRZpyN2u
 P8CE/a3ZvBR2BMjXOvg27lRZbGyEU4pX0NU1IlbA0/+9gp4D6N9VHYAneu8LuIZvtTMX
 TVf2/JJtgajszZB6WKKMDGgoDHGoEPxQmnOK5F6hiIy+cZkEnPXJGFnvqIOzIDryRvSK
 epEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxfW92VcOiIDiD+w4r3MpTQNm2mAfYiqavackPTJRtDsMpyUttdCw3QW3vf9vzflFhTHs3udE0fI1D@nongnu.org
X-Gm-Message-State: AOJu0YyxwOQ+6vFoevo20pIdpo7kF/evEmcgQJbOV8hXqqiEhY7mvKTN
 Z4lsTfElfQSKzCo1DFtNRgs28ZCix63DrV26XBBsVw2I4m41u4smrPsCxWgLckBJ3WepJ3Z0c65
 akGzN
X-Gm-Gg: ASbGncv2Q3m3DEARQbkaPyTj9AzMg3KJ7elRnt/CEGqjZYD1w8Bek8AvT35cI65R1nm
 Ss33I/muG9tfB7UXpK4qlcfoaYCQor2ucj7wxc8QlJk1pFrtRaMptnh8m5IPcHm1TDVIzDjVVb+
 i4wW32ze1tDfPmewQg2p7Gn6DJkxTi02TEa47qLTkQa4teMaQHxs2CkVBpl3jRXd/++SULLg4DJ
 E+u4gwSZTVvM23z9QU91jSQHpgYLniHaB++covn1l1/xygOfty/r3dl0m6gMgjpfLaohAs/On0d
 oZRWA9QUUcOp5mllINJIxwKwU5gJ3cuER8C0ReIk/YmRxyv0PrpZuQw8+Y+O38CzeiXJ99nomFk
 fTnjhteM3pEIB30mg7+VNSIfuGYmp81/PvH8c04/naG5bm8bNaLp7EScISZnUTmjk0A==
X-Google-Smtp-Source: AGHT+IH+Vz9AAtejZG7AKap9TuvI9eZyLA+uHYvAqZssl8H7Jv8L/XtfHjAQi31LygZpuM2tvrX4tA==
X-Received: by 2002:a05:6000:4312:b0:3cf:3f1:acc3 with SMTP id
 ffacd0b85a97d-3d1df631895mr5909239f8f.60.1756709425083; 
 Sun, 31 Aug 2025 23:50:25 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d53fda847dsm4910570f8f.0.2025.08.31.23.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:50:24 -0700 (PDT)
Message-ID: <1d66cb4e-525e-48a3-8853-f23a86d4f010@linaro.org>
Date: Mon, 1 Sep 2025 08:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/19] target/loongarch: Move some function definition
 to kvm directory
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730030202.3425934-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 30/7/25 05:01, Bibo Mao wrote:
> Move function definition specified with kvm to the corresponding
> directory. Also remove header file "cpu.h" including outside of
> macro QEMU_KVM_LOONGARCH_H.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/loongarch/virt.c                  | 1 +
>   target/loongarch/cpu.h               | 9 ---------
>   target/loongarch/kvm/kvm_loongarch.h | 4 ++--
>   3 files changed, 3 insertions(+), 11 deletions(-)


> diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
> index 1051a341ec..51475675d6 100644
> --- a/target/loongarch/kvm/kvm_loongarch.h
> +++ b/target/loongarch/kvm/kvm_loongarch.h
> @@ -5,11 +5,11 @@
>    * Copyright (c) 2023 Loongson Technology Corporation Limited
>    */
>   
> -#include "cpu.h"
> -

Technically we need "target/loongarch/cpu-qom.h" to get
LoongArchCPU's declaration.

>   #ifndef QEMU_KVM_LOONGARCH_H
>   #define QEMU_KVM_LOONGARCH_H
>   
> +void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu);
> +void kvm_loongarch_init_irq_routing(void);
>   int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
>   void kvm_arch_reset_vcpu(CPUState *cs);
>   
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


