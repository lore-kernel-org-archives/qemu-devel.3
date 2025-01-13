Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F33EC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 18:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXPB8-0007TN-Sk; Mon, 13 Jan 2025 13:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXPB7-0007T5-C0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 13:28:45 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXPB5-0005RT-BA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 13:28:44 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5f304ac59b9so2093838eaf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736792922; x=1737397722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O7Dx07Rn/xR1XyNUVo3dpYTgwW7BOYCNpi/FVCpoqKc=;
 b=PRmLlBNcKtiISGrpnFikgHsI3bkCVANG6PmrtEOfs/3FuxOksiXCY55FpNGlV2neV1
 6OIf585qkag/m7C1fcAcMUgl3M89yzjqYmHF59qjfSwuFCNRBjamvFjvwToLv0lnFllb
 iBI3jMNl5RNgn+Bl9Hq4S8qHkHGmgpSPWRIcosSD1cAqj1Eh0YtdPvXW++LQS80Xj8vz
 25U7mVe81Hsk0DsIxpmY3coZEBFkFQ70JyeWs/pRQH7oeBAYlXPtUzYfyfD6OVaWT5iL
 Y569PPQz2yisLYLkLWZ/8LtPsenibQM5k5FnUNt6rtSaY2Y3S9Q8DFM0HvoslXpnUcN9
 Kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736792922; x=1737397722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O7Dx07Rn/xR1XyNUVo3dpYTgwW7BOYCNpi/FVCpoqKc=;
 b=B9zaOxZRJ7ktKjgfgo9NCrQHep+sXxuQydDKR9LqsDufUSO+vcrSQuUdg21j9SHTgY
 ltIejOwVLpi5VE1uQofYA9HEcyk3FnL7I/mAp6rqVRFSuuLG84bBFoLKlprdHVYt3gIT
 w0AGLisyDxDkAJXfMDlOx7K0H6YF8//hyOEGMp4/kzv9PokV87fuAGqqLG6w7QEzrzQr
 eEt9LTAgBbh35dsJAEzcRqYOSIrFonC6Xf3iLB9bqwu/bF0UYXe5WhrLap+E+CvP8yOU
 JPkHsaS+7ghm1OGD8gD9hwFmBPJ3TwwS73X3287YcYX4exOFVLRio3jaBUBXhOggSsJW
 ggWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuCX9wwh8gGzTpZhHDuvchzIdaKoPldaGRlLvB9Q8ogY02P2D76Ai8g5IYAwi/gyWCyYfhV03Xr9ll@nongnu.org
X-Gm-Message-State: AOJu0YxXsXiICFoMowF8nt9agRkE0/R0sQUbamwIo4gmgAIGMx6qoio9
 PUW60wzwsIylqNpTNqYoH75IYFP4iBiLax5SBzH4rYoS8ix5sgsGyPkgkT5e5rw=
X-Gm-Gg: ASbGncvPNLjVYpfGcC/0nkhBbMwaZfzRC/gEUWTHywx11ybWG8OnNfjN5h6LVYoOQhB
 3fxtVSjdydUYhezCwKywgNHnzGfJkTiTpigJK1PFbbVgklPmCL+zNcDYLnG4+kmU30PQO78wVxL
 jls2fWmqn8UNjdVTJIWD/FWaUbAJZ4q5CZSGFgxBH5wAj99my/0HH9Ysg81yTYRg2Y1NliJBVyp
 GTWJcvGza/bIa/DVMhmcv0cy4AC/+tuuKcLOntklanGdUI4s6g/cQScauuYvSTVCZTf10aFCZG1
 in0Xo3TiU8cyO1fLAq/yzvzDOAN3K2Xj7AQ=
X-Google-Smtp-Source: AGHT+IEsrl2kfbpOriQW/5NjfpH6O8zAfiQSVL2xKUn5NlzMAHZFQ+ZYMWIjLZuNThND/J+WniL7hg==
X-Received: by 2002:a05:6820:98f:b0:5f4:bff3:319f with SMTP id
 006d021491bc7-5f73071a44bmr12149862eaf.0.1736792921709; 
 Mon, 13 Jan 2025 10:28:41 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:6edb:f473:a9df:d551:443b?
 ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f882624f82sm3442318eaf.5.2025.01.13.10.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 10:28:40 -0800 (PST)
Message-ID: <70e93c37-9c03-40de-bb57-e0acf66cca65@ventanamicro.com>
Date: Mon, 13 Jan 2025 15:28:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Support Supm and Sspm as part of Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, frank.chang@sifive.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20250111130653.1239737-1-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250111130653.1239737-1-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2c.google.com
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

Hi Alexey,

On 1/11/25 10:06 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> The Zjpm v1.0 spec states there should be Supm and Sspm extensions that are used in profile specification.
> Enabling Supm extension enables both Ssnpm and Smnpm, while Sspm enables only Smnpm.
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---

This doesn't apply in the current alistair/riscv-to-apply.next tree. It's a trivial
rebase, so if you could rebase it and send it again that would be great.


I fixed the conflicts and tested it with the RVA23 patches I have, and it works. So
please also add a

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


Thanks,

Daniel

>   target/riscv/cpu.c     | 23 +++++++++++++++++++++++
>   target/riscv/cpu_cfg.h |  2 ++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index dace670e5e..8c5801b87a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -202,10 +202,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
>       ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> +    ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>       ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
>       ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>       ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> @@ -1612,6 +1614,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
>       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>       MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
> +    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
> +    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
>   
>       MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
>       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
> @@ -2756,6 +2760,24 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule SUPM_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_supm),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET(ext_smnpm),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule SSPM_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_sspm),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_smnpm),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2774,6 +2796,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>       &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
> +    &SUPM_IMPLIED, &SSPM_IMPLIED,
>       NULL
>   };
>   
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index ee7c908710..76579b9b95 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -133,6 +133,8 @@ struct RISCVCPUConfig {
>       bool ext_ssnpm;
>       bool ext_smnpm;
>       bool ext_smmpm;
> +    bool ext_sspm;
> +    bool ext_supm;
>       bool rvv_ta_all_1s;
>       bool rvv_ma_all_1s;
>       bool rvv_vl_half_avl;


