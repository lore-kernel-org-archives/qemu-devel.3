Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2648CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysVV-0006D2-Si; Wed, 17 Sep 2025 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uysVU-0006CX-Nl
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:47:36 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uysVT-0004gM-8s
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:47:36 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-72ce9790aceso44693167b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758116854; x=1758721654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afCx/S2P9wlux9GcmAOzVrv0lndeyLcncX80adPZPP4=;
 b=Ag3rwL83FlDiF0I5oaRrh75P3K/VoPbCOAVcJ0XmeZIxQXCboPs+r2fMuMykMxFhFp
 kZkhSXtUk9G/DzDtswp2N+n1criF0JlgSGsVKtHmGTzDzJ++g1Z4DUFGyEEwydQHSstx
 tQuVeG64E92BQi39TLlKhli7Qfy6BJ/CFS/oaxKafTYc4vR9w4mCm9hwnQb2uI+aZYyT
 MicWjuSoxslU9NeIO+nYxWlXHNWaj6okAIU1ULNACzUrf3TAlJaaj1mDODV15XP6GG1m
 ouP4yCSyYoqc3CVDYkaZ+BqBz9P6jDoUxlrvAezrokRezTJDtRKCB/d5Srmev23fd/p4
 9Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116854; x=1758721654;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=afCx/S2P9wlux9GcmAOzVrv0lndeyLcncX80adPZPP4=;
 b=eDP1FkRwjcMt4+H53gPRdj0YTSIyGyVJ4/Uqa3rLUhxvfgHg7s7UXSuZtP57A/JunU
 ArfVQw9FuP2cW4BhVWHBB+8bZrWWw3bbUz3k3nHu+EsdfkEjA3+3BsHHDx8vT89dvDom
 w1yyxCKk1f3+EXFQsAqWokztgXmwXL2fxUP+wExxnLKJOL7uO6bdgmRUXsvaEDoN0kLq
 5bHLMgB6rfe72arWLm95jaVHTi0WO+hzbP3sujhf5ksXU0jf/3vBMmJfYpAIdKTNU28c
 Zlrr5DEHj77FFl7gg4ZOf5+p6VeZK/sd3T8XXEwXIvf1tOUFxCH683ZVmkTZVHLZGq9v
 KYow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoUsD0sgP+CjO2lHECyLe6r82Lx0188ytdK+7pXQUGStoYm/L0ygY4i0KU/U92SDDRRFHfoP6/pJbW@nongnu.org
X-Gm-Message-State: AOJu0YzgacJIbz/MdOBCeOqylACqvpBKIlNsLX48xb4cR8gSh3hf6kbL
 nilI/K8gVZstgzYfMsXv+RzJnDoP1sGVA7lrC+vlOgYt6OMn85CscKrdt6wX6O1RX1Q=
X-Gm-Gg: ASbGncvmDvaA34i9gnB5x2y9EGNYLHV+mav8NKgVLqeqAytO3m40r0tzzwgZpThxnP4
 /VNpvNFEEviZHQZ1+RCJ4EYGxyux7lvnGa1W9naiBl5KMsQd0QE3GXexJRZ1aDcYwSxNEVS30Si
 NO9eHdeSU022RRl3MMxcCnKAPFNN6WqA7MRr8RF93G4T53US9obB58Dm6H/Ptp+0jUmWPRpvtWU
 AYHLTMh4J7AB59qwvI4DlY8XKqtNDeQAIzWk//ehD1Ro8iOID4MxW5yeVKz2nX8EYgUnJTJaHRO
 XkX+pt9tPdLty40Y+ba2dr+fWzlqga8GGJyYKNOkraBtykZx048hMdURpEcIYp6vAQR5BsSiCXO
 Ts5UCu3oqjqRrIJnGaD+T0+ixLrsnGq5HXIVf8g==
X-Google-Smtp-Source: AGHT+IFmvjBoz4UYH2sQEAMF0BhzF53RQuAgaSFFyxHJnq0Fn6g+j76K3ZL7KZLCUXlGEfWP+1kCEg==
X-Received: by 2002:a05:690c:6e11:b0:721:6b2e:a08a with SMTP id
 00721157ae682-73892c58df9mr18143037b3.37.1758116853573; 
 Wed, 17 Sep 2025 06:47:33 -0700 (PDT)
Received: from [192.168.68.110] ([179.225.245.173])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-73887885289sm4533147b3.63.2025.09.17.06.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 06:47:32 -0700 (PDT)
Message-ID: <1e38dd76-f94a-4b2b-bdb5-329448c7dd1b@ventanamicro.com>
Date: Wed, 17 Sep 2025 10:47:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] target/riscv: Add the Zvfbfa extension implied
 rule
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
 <20250915084037.1816893-3-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250915084037.1816893-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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



On 9/15/25 5:40 AM, Max Chou wrote:
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fc0614dadba..b5c9f9ac586 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2576,6 +2576,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2589,8 +2598,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
>       &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
>       &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> -    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>       &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>       &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,


