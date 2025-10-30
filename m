Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C82CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESZQ-0005V2-Qq; Thu, 30 Oct 2025 09:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vESZN-0005SI-GH
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:20:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vESZF-0004wZ-Aq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:20:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-79af647cef2so1074414b3a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761830389; x=1762435189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q33dVfR7I0sRlr0ArDRLpth+Uv5pZ35yocp5NV8Ir/8=;
 b=HeKXTvI8xFZdUjRm5/vFB+Hc5PSgxTpUYRUdH5gnbYkZOFybJ0hUpnRCitGRnVbWZM
 Wx1aPpr/vZ0INverjqvBPnO3MDoYFZSMxMimY0cDLfRrna8i3Xo5JaL6pl/HZL2a+cBS
 VVZr8Ldr92AYICs8mfe9L/LNBv8Zm4I0JnMA43yG111wwv2kz6uov20FaN35wYiHjLGB
 MTZigzHWcVxq5r1eTAt9DVTzhNRwt7R5XIyiTuxJXwRnn0t7LHtsTiB4B6QeSb1nrHBU
 qt/ZBtgZCbXG5LdG24F9psVUwo8/22AMI+fb1z/CH88G0emeB1AW1P0HEpwihtIPBnyM
 osDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761830389; x=1762435189;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q33dVfR7I0sRlr0ArDRLpth+Uv5pZ35yocp5NV8Ir/8=;
 b=GfI/pfxdWZ87ida6SZuV/X1fDtwV+QAeKUBeTHPRAOGouopkOVA4s572juiRtusA6z
 VYeCZYGfRQ4VRLK2w24O+QbivxrntJweh0EWVAKq7u+Zb7se0M+6DMxY/A6kc+AbB9ch
 mfWafE6IUUCUnR+aGpFP3iAzV3OFpMq0NISvObqQOrri0cyTnDhG7zEke4GdKECiqjQC
 NtAPqTdBO2Zf3REgfrXWim90/mbfkiLhxKe6v9Snbl13ZV5Qkcp9Jeh/uVBoD7ui/lfW
 ZL0l8X0ckoBa1tOKz80/tlH8oh9Yu84ghLdpxILvRLBKJyiKP7Fa6p8YWohwav7fa2LS
 ytPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXICy1aEOFYdwiv0NfdGERXkmj7dDrO+P5NoRFF+7HTEDqrNiTyh1KxVD3JuaJGCefY98S4OqjqzDn@nongnu.org
X-Gm-Message-State: AOJu0YzZw4hp8I4ahOdnv4v2UDp7TkruwWX1MUDQI3uld0Y+BnRZFG34
 2zGJ3KB4SVk1HyL9sOpZp9MLyW8STqlJWJgjRx9N7tdJ3sZWM/vO+4DZ+BST8wDNVk8=
X-Gm-Gg: ASbGncu/6i9TyT6hVJ1xgJcYsnsoiQhwF0buYlDweEyaoP3IGJYTxHyGiHAUgh2MEVp
 zkcPfF0u01gcf0dmfmARl5U7bbVtGkvCqyrsQMWkDW57rUKCxbLWdyFq2dQpD7tfvVZoF21PRBM
 ON4+BzBbBC7SPrM0xridm2/ZNzp+K+MuyskLS1/RwVE6XKqI7486diwJNfjISl3j0AZk4cuKaNH
 CLR6AqLyROhzse7Uj6NCijvJVXrw2XYmO1PdafQfZcBufx0iWRShGYQF2jv63f8LUduvBRF+uo1
 AKgAxIIqbv46yqfJtDRT+7+5YnI+duzjdUmPf6GFyQ0ublQ2NCc5i/RB0o8ep4YdsjM+4alFqLC
 8wACn7T01WZvZ5b54h327jDmZLua52lg6d/ldbJ27y8Oyo/Prq4HAN05fQQSEgkbdFTKBTwqxjw
 /sVjV5vq95KHhc5dwQRCs+phg=
X-Google-Smtp-Source: AGHT+IHBdcctJTdK54jyns5fuimMRNnCTLDhhckFxkdoJsjNRL8JTQ7RTpv+CgfCY5U2pEX7YNFpJA==
X-Received: by 2002:a05:6a21:6d95:b0:341:c4e5:f626 with SMTP id
 adf61e73a8af0-34784a490ccmr4511071637.7.1761830389128; 
 Thu, 30 Oct 2025 06:19:49 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.65.79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a41408e0cbsm18773622b3a.66.2025.10.30.06.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 06:19:48 -0700 (PDT)
Message-ID: <8200a695-2f99-4d08-a245-7fa9ea0ebb9d@ventanamicro.com>
Date: Thu, 30 Oct 2025 10:19:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/intc/riscv_aplic: Factor out source_active() and
 remove duplicate checks
To: Nikita Novikov <n.novikov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
 <20251029-n-novikov-aplic_aia_ro-v1-2-39fec74c918a@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251029-n-novikov-aplic_aia_ro-v1-2-39fec74c918a@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 10/29/25 4:17 AM, Nikita Novikov wrote:
> Refactor the APLIC code to consolidate repeated conditions checking
> whether an interrupt source is valid, delegated, or inactive.
> 
> Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/intc/riscv_aplic.c | 44 +++++++-------------------------------------
>   1 file changed, 7 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8c3b16074cd3ca1bc3004cfaaa13f34b8860bd48..ccfbc9b4656f3e2a69eb5bcd1cee9e5762020351 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -216,22 +216,13 @@ static inline bool riscv_aplic_source_active(RISCVAPLICState *aplic,
>   static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
>                                             uint32_t irq)
>   {
> -    uint32_t sourcecfg, sm, raw_input, irq_inverted;
> +    uint32_t sm, raw_input, irq_inverted;
>   
> -    if (!irq || aplic->num_irqs <= irq) {
> -        return false;
> -    }
> -
> -    sourcecfg = aplic->sourcecfg[irq];
> -    if (sourcecfg & APLIC_SOURCECFG_D) {
> -        return false;
> -    }
> -
> -    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
> -    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
> +    if (!riscv_aplic_source_active(aplic, irq)) {
>           return false;
>       }
>   
> +    sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
>       raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
>       irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
>                       sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
> @@ -284,22 +275,13 @@ static void riscv_aplic_set_pending_raw(RISCVAPLICState *aplic,
>   static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
>                                       uint32_t irq, bool pending)
>   {
> -    uint32_t sourcecfg, sm;
> +    uint32_t sm;
>   
> -    if ((irq <= 0) || (aplic->num_irqs <= irq)) {
> -        return;
> -    }
> -
> -    sourcecfg = aplic->sourcecfg[irq];
> -    if (sourcecfg & APLIC_SOURCECFG_D) {
> -        return;
> -    }
> -
> -    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
> -    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
> +    if (!riscv_aplic_source_active(aplic, irq)) {
>           return;
>       }
>   
> +    sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
>       if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
>           (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
>           if (!aplic->msimode) {
> @@ -370,19 +352,7 @@ static void riscv_aplic_set_enabled_raw(RISCVAPLICState *aplic,
>   static void riscv_aplic_set_enabled(RISCVAPLICState *aplic,
>                                       uint32_t irq, bool enabled)
>   {
> -    uint32_t sourcecfg, sm;
> -
> -    if ((irq <= 0) || (aplic->num_irqs <= irq)) {
> -        return;
> -    }
> -
> -    sourcecfg = aplic->sourcecfg[irq];
> -    if (sourcecfg & APLIC_SOURCECFG_D) {
> -        return;
> -    }
> -
> -    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
> -    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
> +    if (!riscv_aplic_source_active(aplic, irq)) {
>           return;
>       }
>   
> 


