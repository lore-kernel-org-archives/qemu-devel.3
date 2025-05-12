Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C71CC3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESbr-0006O2-2c; Mon, 12 May 2025 08:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uESbD-000695-CF
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:49:42 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uESb5-0005EW-3C
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:49:37 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4c9cea30173so1679300137.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747054167; x=1747658967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vF/ohKV4eqweLIx2Ark7Ixvx2S1UIg1AJFcUNH/hOyY=;
 b=RmVv+EqBz9daOE+09LU4QLvSVBUbc+lm/ydSxHwDnf2cfPs123NTUV+XXD4eSHc3RD
 pAXJh3OdPKYx39zMpY4SUUsg8lc+Ewgo7FRdDaCcCJ7oSjffwQTnLzZMBxWP7dQVuUyY
 nUQWMILWP4SkOs6Betj2Tc9ECokm0iFsszLnk9gEJXFVF5mk4ChfVNxlBNR843sTX3Qi
 OijlLxhmC/87JmB14NTkrBZ6RfvQE5EPRqaZn7C7fi2BL6qvUSiFZ2wTIAgpl+XaopGX
 uhJlhAm3SDJRULpnu3w4fVRXx6IhQivWCS4gAZuW3yGI2yJ9XidTf6tXPEVEBPgVEnyj
 rY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747054167; x=1747658967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vF/ohKV4eqweLIx2Ark7Ixvx2S1UIg1AJFcUNH/hOyY=;
 b=R3tNWpQalRW+97+Ih8cA1CxA7ls9K4WBkmZnNoSOcUwPzh11nxaJ9rr2RgwrM24qgB
 Bhfc5oV/BxykiIKDPXXC7+IgZVUDhw9MvrFOQlQXXcQF16RURmLnQ+wbS05Yr7aJVnpr
 FdRcXZ4HQ3K5tDSxOsWt4EL2JAZt7L0JrtZM6W7jrGtxwwImCBT0s6GpDNAc+MS5K0mB
 k88WhVIbk5ZhAv631MwbbEe0jhjifkfRC/GVXBuDHhmoyDwf2Fd5Ei/K78K3rlr20jsL
 Vq1cwyxfBPINJlzij635TxYo9nePHm0IGyT7DTqGPsKSwusqNdvwkIuKlu2AgoLluHX6
 RQbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr8GeQ7b8wfT8Zj+GHl1NDY8tmxwLEl4njtuMACe4565fkA8Gw9EtKDtyJPYZpJDe03JewZl0s0yTv@nongnu.org
X-Gm-Message-State: AOJu0YzoROdR2lQuMMfj9MalLcVZBmTddkdZ9V0SPF5fNtASwuKvhaK7
 wjsUEiDZ5/Oo1kImFRrQY9pL56T3iGPzhUNNhTiQndb6W2jp/8hMqI2sHGrDrFw+4RZj73lKHCt
 T
X-Gm-Gg: ASbGncv0xhXHgFcfqIr4XTITj3EtE+OZNiV71G+MuuTSUeEuQkOmLaqP59zZxlEODnS
 4X8kQq6ZUzpnNNr8XHFRseZAQQoBgOMhIox1/ZdqArjqlOxheOtnTtUjpsJvSobU0aKoF6r4UcU
 sl9FxVh7fYJjEatXYW1kpJ63hVKHvaZzoNPriwL3aXkkUBVTerkKZ5fouLM3aHu6EfdmyGPOMYQ
 YjFuQ6WeweVIiWJWLnFOXBHFZMGmUvq4X/jiAsZHfYT3TUtgekOiFC3pzDf/cu8SERjcNo/Rhf0
 AmCU/6yGi0vClRr0Oql2Fa8do+6LbeZYeHQGMcRqY3bmyQvjwov5KKqjzzEiFRSnXQ==
X-Google-Smtp-Source: AGHT+IHJIY662gUj52i/lT9x/t3pf+k6j4ZQ6uVLXApHEA3nPgcKXReAb3+HtM6kHQ/6NlW/MOcL5g==
X-Received: by 2002:a05:6102:4b8b:b0:4de:b205:dd57 with SMTP id
 ada2fe7eead31-4deed406e69mr10723052137.25.1747054167241; 
 Mon, 12 May 2025 05:49:27 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-879f626c0casm4979184241.27.2025.05.12.05.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:49:26 -0700 (PDT)
Message-ID: <64371020-0d72-4fbc-8fc3-d0f3554090db@ventanamicro.com>
Date: Mon, 12 May 2025 09:49:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/23] target/riscv: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <cover.1746968215.git.neither@nut.email>
 <40c7216b842b7d06a0b947a7eee7cc11b9305b15.1746968215.git.neither@nut.email>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <40c7216b842b7d06a0b947a7eee7cc11b9305b15.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/11/25 10:14 AM, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for RISC-V targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d5039f69a9..dce7e34cba 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -36,6 +36,7 @@
>   #include "cpu_bits.h"
>   #include "debug.h"
>   #include "pmp.h"
> +#include "qemu/plugin.h"
>   
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   {
> @@ -2173,6 +2174,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
>       const bool prev_virt = env->virt_enabled;
>       const target_ulong prev_priv = env->priv;
> +    uint64_t last_pc = env->pc;
>       target_ulong tval = 0;
>       target_ulong tinst = 0;
>       target_ulong htval = 0;
> @@ -2195,6 +2197,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           case RISCV_EXCP_SEMIHOST:
>               do_common_semihosting(cs);
>               env->pc += 4;
> +            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
>               return;
>   #endif
>           case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> @@ -2464,6 +2467,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                           prev_priv, prev_virt);
>       }
>   
> +    if (async) {
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +    } else {
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +    }
> +
>       /*
>        * Interrupt/exception/trap delivery is asynchronous event and as per
>        * zicfilp spec CPU should clear up the ELP state. No harm in clearing


