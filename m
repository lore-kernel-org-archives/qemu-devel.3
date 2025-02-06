Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F4C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8tx-0004mp-Kn; Thu, 06 Feb 2025 15:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8to-0004jG-Qf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:55:02 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8tn-0005vP-8c
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:55:00 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa0c039d47so1684973a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738875297; x=1739480097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T736wcqfl8iUrXsVFFQQn5049aj4LexG9uRyC2uJmb4=;
 b=Pjw/V9EsKKWRN22nvuc7cVZy7OVY6Qr4qqB4UyMWY7CxHNSPIJBrROuca5jsDfBnaG
 ZgNK9THiBncWRkj68+5d/D/wWWxY/6F4hibAZFavMDb1QxASGnFFZaZKHWmM11R9ChKv
 yPiUlqvcQLd9dqan+NFgyDSk/Bqe++2UgPtWex1b8JbQTzcl0YfAnOWQIsgYLvj/6kTG
 vf8zlIMewYLr9pVWAAELcSqV7RORvAhTq5KjM8OGS9FBXIx8zvT8SbWvA7txgvK7jb3J
 /Nbp1MiX18wCg+GKsYuNCX329iiV3MjVUgZVoLhIw+mE1fjNX9fGi04SYbUrAoTvlPwO
 7g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738875297; x=1739480097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T736wcqfl8iUrXsVFFQQn5049aj4LexG9uRyC2uJmb4=;
 b=k5S6BsiPj7Obb2aEd7mK0AcnN5dYrGFv+fRY6s5bOCZ9kaTgQRxb1wykGAGrqJcHKA
 Or+REv+6jMCkGD1Lu2GHg/pResLXlPfb1CPpoC+Zj6467Z/1N30tA2G/m/Bjtu6Ff87/
 JEQ/T3C5VEAhJQ2QMEBjjcLytFSHXnXTIlisWhS/jjvKU8o65wbW3lX9TJheBYyfHiPT
 6kcjRuyBkDgAHh8JVH8MU/VCWo52u6Cu3FUPvIkHkCCsYDe7Z0PcVFayHR3Do7CwyRSR
 rzea0JouYOMy2kQqF4DjK7dYHXNdvvlHtRqx3h9A3H34wPUoJ9QbDZxO5Wq1oAjXrsI4
 OSxw==
X-Gm-Message-State: AOJu0Yzdc6t8km+p09CgdggNpSdFwKBwjDac2RWuS6BJweq8g24OjX5e
 7u824tDbw591l/zX2lZBgnlS7qUETvTIoaJ+rLITkmjEILJZioIenndo2DgTOTfaGoN0s2laORM
 B
X-Gm-Gg: ASbGncu/MO9HHiErFRxQ0yiWqHSErwDBecvxsNzeWN4OBHmkxFdqwhsOIdk10JIMGjR
 3OxPtZOvUyl4pMzBvDylmH2YogNwCWH2NKBt9VAO250gUEhpHGQigNi1r415B6pCWfjXfrcQiFP
 qD+CabYEvy7LuqwrCJ2s5iEKPCnQllLOb6awM+8W3U8Edk6bd2atcSnHDRRobzMK1RYuMFoLgm7
 rHp+PUUsvn2nIWW9semCoot2iEeJLDMGnLlxuMVcDa4to9u94Q94kZjm4OCTnNPT3yHJfvOKG06
 wsNP4Huzm0v9Msg0FqbtO3OEBPmIRkh5tdVvXDt5hEg0t3XaYoCqUOw=
X-Google-Smtp-Source: AGHT+IEcyFuso+D/42VxrKb7J1/rR+sXr/n2Mqw9vLmivTC5WiG6QsnuY9HCfuGmol1Qefpt7jw2CA==
X-Received: by 2002:a05:6a00:3c8e:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-7305d44a11amr1133688b3a.6.1738875297130; 
 Thu, 06 Feb 2025 12:54:57 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048a9d7d5sm1711183b3a.32.2025.02.06.12.54.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 12:54:56 -0800 (PST)
Message-ID: <df5bb00a-a138-4b89-b448-fc186745bc3e@linaro.org>
Date: Thu, 6 Feb 2025 12:54:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/riscv/opentitan: Include missing
 'exec/address-spaces.h' header
To: qemu-devel@nongnu.org
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206181827.41557-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/6/25 10:18, Philippe Mathieu-Daudé wrote:
> opentitan_machine_init() calls get_system_memory(),
> which is declared in "exec/address-spaces.h". Include
> it in order to avoid when refactoring unrelated headers:
> 
>    hw/riscv/opentitan.c:83:29: error: call to undeclared function 'get_system_memory'
>       83 |     MemoryRegion *sys_mem = get_system_memory();
>          |                             ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/opentitan.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index b9e56235d87..98a67fe52a8 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -28,6 +28,7 @@
>   #include "hw/riscv/boot.h"
>   #include "qemu/units.h"
>   #include "system/system.h"
> +#include "exec/address-spaces.h"
>   
>   /*
>    * This version of the OpenTitan machine currently supports

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

