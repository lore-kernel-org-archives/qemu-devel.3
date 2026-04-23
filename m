Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F03F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFr22-0005qP-5D; Thu, 23 Apr 2026 06:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFr1c-0005lM-93
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:11:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFr1a-00060v-Ij
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:11:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so52287895e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776939068; x=1777543868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9JB6XyoZ11qMXnbaAOLlXhXHCzkkYFk33rxmp3yvr9g=;
 b=KVEpAL8Ax1D7qEpNFAo6x+0ZvurIhFR3XmUbVRhg+HqC+owttHcHXSETLCNuYTjlqH
 9bwcJmX7GCiOKICmjKl3sYQ6LAw0qbQBnGfdgBDf2YWIK5lZDZY+3WzqbRsVUbuKV+OC
 YwrJl/qpSXU/IOYB6aJTqH5UkCze2AyoXWtANViaNgNGhYfKbKycahL+Zd3SRTX8ak/m
 a834vGRiJ1OfBaq0/nIMt3LNXj76b709hxcjA9NspZZEIuBM8IROIQZNfIH5BCl6I12P
 JDDtLS5pl8CJTE2f14BLgNU99yQLABbJ7MutYyb65aVL2ORItT7TadIhxsPJai78QzHI
 cKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776939068; x=1777543868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9JB6XyoZ11qMXnbaAOLlXhXHCzkkYFk33rxmp3yvr9g=;
 b=iK/KnJstka/M3kOT8sY8TYmGGNuE0t9aJhFIw8LJkPVloPen/XWRItUtCmZxWxEnAa
 9wsNXrxoGAQbvf7DzI/m0g+WCRobcJbV887fFiE0vqUkmzZmEJ3chXzThsRWsaIgbeqU
 o6PiBOIDsErbTglUVdjk4fdoDC1IW065VqOKoihhL9ZVXxfrtGMXyXMIaqN6gTPfXOSL
 8gQSTGR3EmGmlUek4Hm0MGLy0Vgyjfy9Z+FjY6AiD0PhQxGrd6JVD3cvjstScNGOtOyc
 +k7q6g3CEEjGmLO1Jok4kqe3ytz2k4LZxktcqgvtdvBDCblHgG0I7RjfjYNQltBVoUvE
 mPxg==
X-Gm-Message-State: AOJu0YzVIc2lit3fdBEb0UcFrGYFnawpu5U99IsehWro6mpO2s3b9vb9
 JB5hWYnfN8Lg442eiwyg4e8UOLI5q9NTxj1bw9hrib+40HUp9MdAc0Zs2Fe+k6PCkJnRLKmKrw+
 7DVdIQkM=
X-Gm-Gg: AeBDievG3UmmTLUN8neUBhr+A+aQtbyUgK4OuYMC9WbMTdTp1MTm3WHuhIieRpu99KU
 ftgxd+65PYiWgi8C6/qksL5jgWrnlSSaIHEcdpqAmMGliwnrOG144/RJ0mrO7mgyFuJQIqT8P10
 NluOAh6gH7wM4ysaqBXaHZU6kT5PC/KEr4gt8gIb/MITwIfGigmGosxv9aqV8hCh26zU5ZHHdM3
 6Ol6hlLhNXAMDZEOXdJdza1y8IIFSBBLpBWCexYytuz7RgV1LRZQT11tMhjzqbnt6dj8XLQYb8V
 7OIOb+c7b5cnKoc2X13bkGNBeQmTr6jyqOMAwdDqj0ifFWdD+9LQx+qnAnH857k66HT9vdPVtIX
 MPcsztVtlFmoCt1rB0tMlFQ4/qRTEAIlefTiPijvAGPDSsKI2ag6F6vos9SieLEOdJhm7WISj2V
 9lya3XRiZWpWy2HruEef3e/2LQEf4B0DCL18lcQcinYc492K7jAkzpvTufNSLSfAoVE6X05R+3z
 gP6F5WswbxwOCw=
X-Received: by 2002:a05:600c:c0c8:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-488fb78b8c5mr281292965e9.25.1776939067883; 
 Thu, 23 Apr 2026 03:11:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm477902545e9.11.2026.04.23.03.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 03:11:07 -0700 (PDT)
Message-ID: <5c0ed009-dc77-4807-8981-f66bdd8c3f62@linaro.org>
Date: Thu, 23 Apr 2026 12:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/microblaze: Replace translator_ldl_swap() ->
 translator_ldl_end()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423100612.27278-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 23/4/26 12:06, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the microblaze targets, using mo_endian(ctx) --
> which we introduced in commit 2c9e8ddd7699 -- instead of MO_TE.

"Remove mb_cpu_is_big_endian() which is now unused."

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/cpu.h       | 7 -------
>   target/microblaze/translate.c | 4 ++--
>   2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 5765786e6dc..ad5a4a8e7bf 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -412,13 +412,6 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
>   /* Ensure there is no overlap between the two masks. */
>   QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
>   
> -static inline bool mb_cpu_is_big_endian(CPUState *cs)
> -{
> -    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -
> -    return !cpu->cfg.endi;
> -}
> -
>   #if !defined(CONFIG_USER_ONLY)
>   bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                        MMUAccessType access_type, int mmu_idx,
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 5e8bb4ed77b..af6a30b7760 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1646,8 +1646,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>   
>       dc->tb_flags_to_set = 0;
>   
> -    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
> -                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
> +    ir = translator_lduw_end(cpu_env(cs), &dc->base, dc->base.pc_next,
> +                             mo_endian(dc));
>       if (!decode(dc, ir)) {
>           trap_illegal(dc, true);
>       }


