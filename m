Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3018DD6CFA5
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2Hz-0000GN-50; Thu, 22 Jan 2026 16:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2Hx-0000Cg-3w
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:32:25 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2Hv-0003ak-Fv
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:32:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so11390265e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769117541; x=1769722341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N5jkxwR3oNxIhB9k1F8oMVvBfAvOK7/dGQ98rBR0ti0=;
 b=Hq1G0P1s0gk3Y9dxdWf/cN5TlcC9b+JIYFYoY3gXgsCgLhGKfXpp15jwCYNnGi18ff
 nT7KjVbU27/gTu+50uGYLU4L8LgPii1lbYZ3f/zqJs/pImsbLGs6Pn71/4h0YgeDnu+S
 cn3kuXMighqRymYBrpJrOhpb6PmoeWja0BllDz7YUte/09VaGW/IIRoUi7Oz1fhFrmqd
 TqW83pQFWVmri++EchkBM0l+bYrEtatD8iKqBXAVrAV2e1XX2Pdpm3pKr9MDQdN0DygR
 chRr/HGFLuN2aySVdSlFMpgvU/MZNMHDRG+SeHi1Yqxq1bipqlsdcYgcjeifVOP0ARGG
 MGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769117541; x=1769722341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5jkxwR3oNxIhB9k1F8oMVvBfAvOK7/dGQ98rBR0ti0=;
 b=CrJ9tUGyiGaQVvpoKWYri9LQkPhTcCYJ89h1bumHNIf0aOyOA9QnKx7F/4mfP3iWGi
 zokO7lxZrXqXDs1gkLgr61VH6F1cAJSLDAQxIhz44nQuRR+Y/f7InaEj/usHHtdtCWSO
 LfgQKl4zkcCoBAdo75MYUsAnxgXMn+xOsyEh8LK0G6rs7hXbFKIP5F5qwa83MqJssi9R
 Gs3mmlNA5F5xxchwpiRgBFTrFO3rGyMkhHwHVConkrKTIZk5KJXl/qFy/bJLLjyplM9N
 bcXe3/KKShFNU8li7Ue1QqLUUf1ixSL4ghWrzQxhwn8eIbnB1JV91LkVlllU0SO1LKPN
 tWwg==
X-Gm-Message-State: AOJu0YwzJkrk5yEdeQKrkaxc6SEEgWp5GcfmRfxjyMP6ncw06ECO3gwQ
 ErWE8kzayQsyjNdym9WDRr50sdcM4yewdKlOlrTyju6WSr4tQqjqQuk1GgV053J9Mtc3XZtJvKq
 cZqfN3Ig=
X-Gm-Gg: AZuq6aKXn0DazKSrQDIGTp7EKiWnX2jQ7bfYfs1/z96d9twqqYJsRnICsmWNSn69eF2
 V0lBmL/MwUo2vg2LDHghfy8PeVNJGIB52vX14TGXekgSLWmzoOWCGFI+0wj7lD6q4lehrO7xzYn
 k6qYVoz3v6DLX5rUdmqMcAVfrbSe3u1Yoncndxsz5oTzsEKAFJoiQ1PrCISZjOqAZTgdXkOrJh0
 pyVyU1pEbEJroDfjuQfOqKUD2trAYWbJhSLEKVhYGerFePrmm3ljZ3LEhTEIfwU6movUlVPXsuk
 nYAMI9YP0WvzrB5LzBjy4xG/OQca0r5L5HknANBbTwoiMnXwS9lEt0DCJTwen96BlPGf3XVfsKO
 OePmaveIzfoNhfyDwCXWMB7t8q1ocGMOogPrxvyNJk7tLYtklly+4Q1aKlbn8ZSQt1oPnJufcdm
 g3Tx6BVbzcJaepYmsfMws9xRndsYP1ayszqZ6F3UZwLEX0NyXysFp5Xw==
X-Received: by 2002:a05:600c:190b:b0:47e:e949:37e8 with SMTP id
 5b1f17b1804b1-4804c9c8d1fmr15615685e9.30.1769117541411; 
 Thu, 22 Jan 2026 13:32:21 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8a5c32sm10123065e9.11.2026.01.22.13.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 13:32:20 -0800 (PST)
Message-ID: <1674527c-5d2f-4a6a-8bda-a547eb3b3b5e@linaro.org>
Date: Thu, 22 Jan 2026 22:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] target/ppc: Inline cpu_ld/st_mmuidx_ra() calls
 in memory helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
 <20260122210101.55358-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260122210101.55358-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 22/1/26 22:00, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ld*_mmuidx_ra() and
> cpu_st*_mmuidx_ra() calls, inline them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/mem_helper.c | 37 ++++++++++++++++++++++++++++---------
>   1 file changed, 28 insertions(+), 9 deletions(-)


> @@ -241,8 +252,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>               break;
>           }
>       } else {
> +        MemOp op = MO_TE | MO_UL | MO_UNALN;
> +        MemOpIdx oi = make_memop_idx(op, mmu_idx);
> +
>           for (; nb > 3; nb -= 4) {
> -            cpu_stl_mmuidx_ra(env, addr, env->gpr[reg], mmu_idx, raddr);
> +            cpu_stl_mmu(env, addr, env->gpr[reg], oi, raddr);
>               reg = (reg + 1) % 32;
>               addr = addr_add(env, addr, 4);
>           }
> @@ -252,10 +266,12 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>               cpu_stb_mmuidx_ra(env, addr, val >> 24, mmu_idx, raddr);
>               break;
>           case 2:
> -            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
> +            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
> +            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
>               break;
>           case 3:
> -            cpu_stw_mmuidx_ra(env, addr, val >> 16, mmu_idx, raddr);
> +            oi = make_memop_idx(MO_TE | MO_UW | MO_UNALN, mmu_idx);
> +            cpu_stw_mmu(env, addr, val >> 16, oi, raddr);
>               addr = addr_add(env, addr, 2);
>               cpu_stb_mmuidx_ra(env, addr, val >> 8, mmu_idx, raddr);
>               break;
I failed my rebase :( v5 coming.


