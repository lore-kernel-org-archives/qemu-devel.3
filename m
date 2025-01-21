Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD6C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGzp-0004Xx-Vf; Tue, 21 Jan 2025 11:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGzo-0004Xo-LH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:20:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGzl-0006Ur-6W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:20:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso3359420f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476450; x=1738081250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pgwdjm2nJReyF3nS0TDyR7sO7kIF8PaKpe296SJ6F1Q=;
 b=IZzm7kRxRh+yVUOG+UfVkDaNaa9AXdk7BjFUZHStw0ctm++LHDuC6W1VhyRQI0giEO
 US4HKIYjCC6gQAxgeA/M6AdXsLZSC5gEZgBAzHQMvpWS/UN+E3YpAo90zBa77ghccGDY
 N6ACLpE+OMWVA6lF3D/HijSfTqQoMjt4LFJ8JMa8jc+K1J++ugJAaH8d2PmNbjabLD/U
 CfJDnOi/q+m8Vo4iDGkWHDIy3vwX0pCmAJqmRDG1r2yEEXdgs2mLAFPTrD3vs13QXzQ8
 aAnGSd0br1wlYhfldVtHhlLV/Fana8ZKhqk1kcxKabv1JE/aEjWlMLrsBrNlU2qOUvBp
 bg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476450; x=1738081250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgwdjm2nJReyF3nS0TDyR7sO7kIF8PaKpe296SJ6F1Q=;
 b=Vo/9tqnUHFQiXAulBX9NgY/5A93KxdzPAVdMAahy4/gTYkF+8bvhVQ+FnI0jC2Q1tt
 1u46rD48+qxPPcGja3lt/zo+nTwFlsraZAV3Qf5v9fEmLUDrWWT/xBtQ6awQSujpLRxp
 Dnn/oPBjmgsapoWPtl+GNRBIT31Fm4WCTI2dEQlnRGh1RTduTtatPnZdTgaX+3xL3Na+
 TlWTlfJpmuhYeBlCZlFnqOHXtzuZyTfY/z2gqDHb3/AuKmu+XiW72Icr86fH9sgViNbN
 ibkKbU4w/dPVcF9zwL91YX/mpz+ZxdR/LhKrnBy4hRxFIDAZcASVtBZEu9Z+I7ntu29v
 KgeQ==
X-Gm-Message-State: AOJu0YznRkACjOeo632ULl0XaU/7ERFt+u1ISndVgeSgA7e7QaUPG7VK
 uNov1ilyrlR2FsbOQ2SCtReam0KOQ7oIj4EqulY8M5b49KypZ8+tW27NXc7NWbB1CdeBoD7+Tkw
 jiJc=
X-Gm-Gg: ASbGnctntDBVkwY3HgtRgX4vqJtbXcbsKyB8nIY2GmlkhQMd78JknuauBlekMUh6nha
 JggBZzH7+af/YCPmsP79vSRJtmC5VXPp4VWVUQ/A0X4O1jqaLV3W28F65ITEv5AiwWKHuuuZn56
 LqJGTw7nHJrIRmnzTwqW2mT+Ai9v5Nh/LNJ4sIJf5h64AtMiZa/YTpz/3crFW42guRfobVDXVVm
 jBku0liV8urulgUf0zH+n5PuGpBtsWMQPLQbMbJI8fAACutEIy/ehStYRahIPcyWsClBoI4NtXv
 yuffQElRasNWyQBT0/sgGVPuOiNwNy2mbkh/Ew==
X-Google-Smtp-Source: AGHT+IEa02otuzbntMQsXRNrG0hR05yb/ys5LPuTVO4Lf5kEngwWiEE9uUFC7VoFrUmSg61FgZxW0Q==
X-Received: by 2002:a05:6000:4026:b0:385:e8b0:df13 with SMTP id
 ffacd0b85a97d-38bf57a9569mr19274894f8f.40.1737476450527; 
 Tue, 21 Jan 2025 08:20:50 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214d62sm13587734f8f.1.2025.01.21.08.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 08:20:50 -0800 (PST)
Message-ID: <7ad57755-90e7-41cf-a9b4-48827e096f60@linaro.org>
Date: Tue, 21 Jan 2025 17:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/mips: Allocate CPU IRQs within CPUMIPSState
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20250121161817.33654-1-philmd@linaro.org>
 <20250121161817.33654-7-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121161817.33654-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 21/1/25 17:18, Philippe Mathieu-Daudé wrote:
> There are always 8 IRQs created with a MIPS CPU.
> Allocate their state once in CPUMIPSState, initialize
> them in place in cpu_mips_irq_init_cpu(). Update hw/ uses.
> 
> Move cpu_mips_irq_init_cpu() declaration from "cpu.h"
> to "internal.h", as it shouldn't be accessible from hw/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.h               |  4 ++--
>   target/mips/internal.h          |  2 ++
>   hw/intc/mips_gic.c              |  4 ++--
>   hw/mips/fuloong2e.c             |  4 ++--
>   hw/mips/jazz.c                  |  6 +++---
>   hw/mips/loongson3_virt.c        |  4 ++--
>   hw/mips/malta.c                 |  4 ++--
>   hw/mips/mipssim.c               |  4 ++--
>   target/mips/system/cp0_timer.c  |  4 ++--
>   target/mips/system/interrupts.c | 11 +++--------
>   10 files changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index e5767ea9cf3..25a19b61913 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -8,6 +8,7 @@
>   #endif
>   #include "fpu/softfloat-types.h"
>   #include "hw/clock.h"
> +#include "hw/irq.h"
>   #include "mips-defs.h"
>   
>   typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
> @@ -1177,7 +1178,7 @@ typedef struct CPUArchState {
>       CPUMIPSMVPContext *mvp;
>   #if !defined(CONFIG_USER_ONLY)
>       CPUMIPSTLBContext *tlb;
> -    qemu_irq irq[8];
> +    IRQState irq[8];
>       MemoryRegion *itc_tag; /* ITC Configuration Tags */


> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 9a638f596bd..ccebc56adec 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -278,7 +278,7 @@ static void mips_fuloong2e_init(MachineState *machine)
>       }
>   
>       /* North bridge, Bonito --> IP2 */
> -    pci_bus = bonito_init(env->irq[2]);
> +    pci_bus = bonito_init(&env->irq[2]);

Orthogonal, but thinking of heterogeneous emulation, at some point
we'll need to expose vCPU IRQs as QDev GPIO.


