Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF0CC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYHE-0003kM-7Z; Tue, 01 Jul 2025 06:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWYHB-0003k5-7i
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:31:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWYH0-00020k-B7
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:31:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so4851705f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751365890; x=1751970690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tgrSfvx56bZGA5skQAUHASaONx9nnqJrkFCGPGoosE0=;
 b=RX6OjP+hCZJN+E4gVlXS+XB3Ircjt16hpBcn974c2tRHbfTPxl4iZFx6Wd4HqDQrHp
 v2WDEUu0/xgGuwPQKykc8GLQDy29hkryE9hP/tYL0u8dCKO8malIxrV6YMOZ4BWu/fVK
 ulp5FK/gU+7KGVYEPL/zVVhJgbo7jMsDtFa+74xHtAZdgzyKNJQAxQTd0FK/aQX18k6P
 yUK/97bSmHvQAikZ41GASjOT4PGcfYvmEewlSOTw3mCYAZ91zZu0sP+LEIcBf7S8Spaw
 IzRPZULeaDtFCYPGKXsPS023EbI0aTX5Wvx4wFtmE2Z/estxaX3Q9UwkvUp3scdwiyty
 lYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365890; x=1751970690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tgrSfvx56bZGA5skQAUHASaONx9nnqJrkFCGPGoosE0=;
 b=udNzOuNkj/f7240j3cH9IMkIWPDEniFQtimu13rFNeATinhSUas729g2NeJawfIM3R
 J+/+dJ9LHW1b4lk1+H9iuJB0b6e2/gt51W6kUxa/iHSxO2AFyrZ89P2/xEg3sfiI1PEz
 QD1JiYERv8bZ5hqY1UpPFD96RcnhnKyu1AKPtWlFkqFcx3RcEbgZlEd5gDagJdB8wfCG
 BcsZCJ0/bHOCdZY4XutosCmzobqlZj/q2jX4ThoCy7VsGcCubPvtv1Wr2tcnqgVIwS2U
 1DlwTD5Py5Ff+8cqebczZiR3Ub1yE5BvCVAFCk+JVHFslab8q+4D+sBRF3gQNAXA0hKg
 mSBw==
X-Gm-Message-State: AOJu0Ywr87ss5A+bJNHkWwyQpvL1b+ahkH8sHT4TTQmsh+qi049F1vOT
 mKILsrikFkPoJyinh3bxDmEYRZREl5gj/4cWWeZc/PWtJIem8MfB8HX+H49CdJP3ER5umno+yUZ
 iaOoQ
X-Gm-Gg: ASbGncsWJudgFQ69X6mAmMi8VJo1CDxjktckM/yb8Nyw5LuPwRUGsefidm7DcvKAECu
 QWtOyZ/q5nGDxcwRVGSfDMmI5BuSnwduLR+ALZr3hauSd98G7tFDX3EGqXecKBWAq2eG8VeU/zr
 g+avwO6+g24XCJq8zieqBWqO3n8arexiAoJGfByV00EWxCi8ankxj0f5hBARhgJDdV9AIbxYgHA
 gm9GZ78oB5ZK/U7/A9qFgQLpv6EA6nagNwFwQzHl1GmNwy/mhIpdxA2sUdR3D5sxsg8aevJ12L7
 wXhiP03bpFjfvs6PD1T/ExL4EXWZjZ3AgBIdiHmUZLEz5FZhzNxfPim221CPCh0GM//KvvlsaCm
 3yrSCYlmZ7UtFK/F6oVSM4tvCdCYuHnXMUw9+DKV3
X-Google-Smtp-Source: AGHT+IFsuPOO4ZQkbQocEzBcdPX/WR94zJ9rlgRpleB+R0Pf412nURn+DsNRInwdp97CIdhJVjsXHA==
X-Received: by 2002:a5d:634f:0:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a91893b647mr13065635f8f.59.1751365890416; 
 Tue, 01 Jul 2025 03:31:30 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fdfa6sm164810595e9.22.2025.07.01.03.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:31:29 -0700 (PDT)
Message-ID: <69d5a017-0ca0-4673-a31f-8d385a60d4cc@linaro.org>
Date: Tue, 1 Jul 2025 12:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/24] hw/misc/stm32_rcc: Fix stm32_rcc_write() arguments
 order
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe Michaud-Boudreault
 <philmb3487@proton.me>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250610125633.24411-1-philmd@linaro.org>
 <20250610125633.24411-23-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250610125633.24411-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/25 14:56, Philippe Mathieu-Daudé wrote:
> From: Philippe Michaud-Boudreault <philmb3487@proton.me>
> 
> The tracing function for the write case incorrectly has
> parameters switched around. So order them in the correct way.
> 
> Signed-off-by: Philippe Michaud-Boudreault <philmb3487@proton.me>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <HnyjTNqwrfGusE44bnM7kuLuj13Di1VgXN-dXVHMOSnfgCUhoipOVIoVS1WQaKrJxmEDy9XJGdlQj6zVTIdJE0QVlfBhfbcckFFWRRP56uY=@proton.me>

FTR, since qemu-trivial@ isn't archived on LORE, the original patch is:
https://lists.gnu.org/archive/html/qemu-trivial/2025-06/msg00002.html

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/stm32_rcc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
> index 94e8dae441c..5815b3efa54 100644
> --- a/hw/misc/stm32_rcc.c
> +++ b/hw/misc/stm32_rcc.c
> @@ -60,7 +60,7 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
>       uint32_t value = val64;
>       uint32_t prev_value, new_value, irq_offset;
>   
> -    trace_stm32_rcc_write(value, addr);
> +    trace_stm32_rcc_write(addr, value);
>   
>       if (addr > STM32_RCC_DCKCFGR2) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",


