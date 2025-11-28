Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32222CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxDV-0001rI-6F; Fri, 28 Nov 2025 07:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOxDT-0001nV-43
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:04:47 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOxDQ-0005Fb-Vu
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:04:46 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so880660b3a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764331482; x=1764936282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Whl/NJnC+XYvVl2CYaDDbR8WPhdyUcTaxO3NB2XTVnw=;
 b=fDvsTUpBgKnJQ5QzjnkoS4pbg9xWRCa5FvJbvcPamHoqFSgRmpPP7XU7Qfrkn0H78b
 YC73UiOQKwQYCv5KI9xXm98NAWXuV2iqscjj/pm0LpErHLaGwfYCWAnfRF5MS9kjopZA
 UDBZMk9zFORRvh+aROoLzp9y+q6X4apYg7xX5fGlGlYCaMWib99kkcVWisOG72NAeu/T
 FJE+8qH48g1LtL6qS12z2CX1vuru5XaLFqJz3C9BKjhhgwQXDLuwImlK6ddHNKTS8s7F
 RAD5Gn7U/HzinO4RUdBzUh8rfF8NRsq01bIVC9WEI28HzG7BR0GWbRwLemHyuyV4M6JC
 eqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764331482; x=1764936282;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Whl/NJnC+XYvVl2CYaDDbR8WPhdyUcTaxO3NB2XTVnw=;
 b=ee41P6LVob1OjveZpKBzr5yH06eOf0Wfp94puIVzuPCH7aG1OnWKQnyA9zw2avIo0w
 QmsR+ZOX3VN0vUsaiR+/YMYWmtYzxt2QNYn0jTM2c3qupPP4vZiLxxOD3MFjFUYI5XZN
 +YOjDb/x30T4/8f620gKnf7MtJVvIjf5FYMQ9r0xnhovGXfmrXcFcIRuPKvu9YjkWvp7
 W8bIeIPtuFuEd7r8VPESEBEqVrXTnqoYA9f+Yd8/h476P0aeJMGR5UJLq62TRPT5jQJZ
 rXx7vp375COdH3pSGci21zYhpovfjXDvW1NItQ5vYJCWkXeeOtCY3TuQDx6+dRombBiM
 zH+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpagGui+zN8jgw2F/GGD7nHbxzuhQWHwcXqY3CEm7al0Tt1oILHqFSgALnvwO8o/BcUwHhVGyD2JdD@nongnu.org
X-Gm-Message-State: AOJu0YxpShG1zyTRBhTQfeEXuhbZqC9g/tqAEXQZjq80wOG4I96oAsKy
 Tkmuby1cihPZeEdSpiD8PK0DpjShDt7RDyawmufZDatYNCJvu3aIPyCvJfAraeZ64E0=
X-Gm-Gg: ASbGncsfcYaxKpRmyWWe2wHOf2o/4dWuKCRbeRARPNShKAvGkzBcoLPqKgAavqRK0pp
 YkZS+yvd0hsxNgOyTE/kZ5ISfs6ih/+d5hew7BKgiI5Q3MKyuueHNBEzdHlW1TqHolQ9pjMytoZ
 iQSHYKSF9SqlpjAqUQTgAv3D0np19tSnCaYM25jbX44xpB+JYVyDZiYs7G/4xLfZFeO8GKs7eIU
 Yv3ivqFCdAfnOGwplmaNPNSKF2ycQ/a2fgzTbOAyg8SmWBH1H3Nx2xD2rPHd45yF2XBzrr5LQ9j
 fwPdpiz6hDMDACAbn0AgniLw8zltAtzmyYNFSsl/OfJ3lAXFQSifd1W0wvgizD5a0l+/FGpW/3S
 NqSYvve2ActdDu1hlN87TmC35lCP6437b3/w3kZukR3s2TgT3ZzGTHPBZgcZiPk9D7ok1tnqEcy
 KGoWAaIy5LmrQl/dQOPIKf+jQ+Iw==
X-Google-Smtp-Source: AGHT+IGk38H5ufyOoeUYvhuVQDPJoVYpyKUQg9jkdabm8L2aJv6L9o/yCPraCTNXYCWscxnLjAo+4w==
X-Received: by 2002:a05:6a00:2d97:b0:7a4:f552:b522 with SMTP id
 d2e1a72fcca58-7ca8b1b9334mr13762895b3a.27.1764331482241; 
 Fri, 28 Nov 2025 04:04:42 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15e7db416sm4777288b3a.41.2025.11.28.04.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:04:41 -0800 (PST)
Message-ID: <2c4fff31-161d-4896-b164-23ba58435784@ventanamicro.com>
Date: Fri, 28 Nov 2025 09:04:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix index of fired breakpoint and watchpoint
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, vivahavey@gmail.com,
 Yu-Ming Chang <yumin686@andestech.com>
References: <20251128080928.3160155-1-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251128080928.3160155-1-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 11/28/25 5:09 AM, Alvin Chang wrote:
> The do_trigger_action() receives index of fired trigger as second
> parameter. However, in current implementation, the argument is hardcoded
> as DBG_ACTION_BP which is 0. This is a bug because we may match/fire any
> breakpoints or watchpoints at other index than 0.
> 
> Fix this bug by iterating cpu_breakpoint[] and cpu_watchpoint[] to
> compare and match necessary checkpoints. The index of the fired
> cpu_breakpoint or the cpu_watchpoint is the index of the trigger we want
> to provide to do_trigger_action().
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/debug.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5664466..f3bca8e 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -929,11 +929,24 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
>   
>       if (cs->watchpoint_hit) {
>           if (cs->watchpoint_hit->flags & BP_CPU) {
> -            do_trigger_action(env, DBG_ACTION_BP);
> +            /* Search fired trigger and do its action */
> +            for (int i = 0; i < ARRAY_SIZE(env->cpu_watchpoint); i++) {
> +                if (cs->watchpoint_hit == env->cpu_watchpoint[i]) {
> +                    do_trigger_action(env, i);
> +                    break;
> +                }
> +            }
>           }
>       } else {
>           if (cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
> -            do_trigger_action(env, DBG_ACTION_BP);
> +            /* Search fired trigger and do its action */
> +            for (int i = 0; i < ARRAY_SIZE(env->cpu_breakpoint); i++) {
> +                CPUBreakpoint *bp = env->cpu_breakpoint[i];
> +                if (bp && bp->pc == env->pc && (bp->flags & BP_CPU)) {
> +                    do_trigger_action(env, i);
> +                    break;
> +                }
> +            }
>           }
>       }
>   }


