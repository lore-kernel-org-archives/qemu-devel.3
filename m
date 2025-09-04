Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CF0CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu6z3-0003w3-QF; Thu, 04 Sep 2025 06:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uu6z2-0003vc-7Y
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:14:24 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uu6yw-0008Ch-Om
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:14:23 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-61e526608f3so588923eaf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756980857; x=1757585657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l/yR6M74PCFzVjAUqQfwhFVlLv7FromAIG+fewQNg3Q=;
 b=ARd5/EiPtPQfZzwIxLg6Et9LphXrPWaOrKzkX14Wd9X1voUKDqIZTUYRmzdzenBEFw
 kchOpRSjcRiiPAsDKfaV6wXXL1GZUavBJokmuS7TJQr9h2tQTQV3UTVM/ZcR4pjlXqHY
 bOtRdQ618zGxzk58oVQScQ5CfbikYNH/nSakme4c9phxRFteNuENUAYBxP0RhXTMSTR5
 gdQ+EbS2pkUprU6fouzMIPZqqhPSVez2ovonifz/JTpnpRIasRexArGhOTvrYldn1ZoY
 XgvfShzp9GPNPeKE8tqibmIJwfJ0mx1YqDvqKKBbohIff5rNNsxzaWbWlHW0GIxzgamd
 me0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756980857; x=1757585657;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/yR6M74PCFzVjAUqQfwhFVlLv7FromAIG+fewQNg3Q=;
 b=iZOKx1ybw6mN4Zj8fem9ZYtiYul8r8+mXJSyR4o+3uQr5ktEX+u5T5TQYJ6Cm8e8RS
 W+nuLYApi90jwrTgXgWsE1HcUobyhoEvE+w2Qopz5JiZ8XgzFgcX8Jkspr1PeAG8vQrQ
 zwuSVOfSs3GE5RszUnG5+NkFzkbdoU2T3g+XTVoMMAV2AqaH4zd1SOq425SgWVDiRUR0
 ENzYFkmRxBBr0PZKEWSy2bIpx4SZ6pBoUqr3wXiwNnB3/++2wcagATlnOglw104/rfZs
 VCMgpqFqQnZ3eIabT1YqpxtPNZvsxhzyb/rLAbdImgUVtrp8lTX85OuaOitPAmjPH+HK
 +cKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5lUF3bpdcDZMAzqS/yo/3LBTrB9qmaXyFhZ3m6T8moVQ7lXSmcwFgVVRdPI5LGcb9eBiYu/l2Allv@nongnu.org
X-Gm-Message-State: AOJu0YyKa34OJgVIsbsirVEPrHiIiLh/ze5EhJGQbAzqHYZY+eziIIon
 arNLrLCGETe+xpvzeVTXYBcMcIK9Jl8Iwk2cba1WxBo6l/FLFn3no78Yo+xQ6Jvk6A4=
X-Gm-Gg: ASbGncsoM72HzxpQ7+tcnWlvis2tMTI8juytyJbgbX+/EgFiqA65SDtIjLJK238OX/Q
 HbkUrmVNlteKFHbPb+jpmMS3iHsj5qZFZ4+aHybf6UdqWGAIVAnNZmcFGWEIwhMOF5oG8IQxbmu
 D9PBJZuRCrKziMOW+J8OyjrdUuryUrzcobBR24ZdEZRA+oLhWocdPR6fRG+v/gQfem9wv8UmJL0
 M7AWXhQsGKZ2OQP6X5NUSeF7rpqI554lLMh2INsvzC6CDEUkAfRT1NfPoh1Uv1H2vdtvdSbwwpY
 q5cTsi9N+7p2xt3s7XAHqLT7F4nL3pPN4RrvWp8VeCPkL93QIUONK5lJJzBi2JB/Ybjr0xoS19+
 dgBXX27obKsNn/R7bFnpQU5zUjsExh8Ld+z+ePWF19JXAaMo=
X-Google-Smtp-Source: AGHT+IFtHENZmou+j3cb+4+f/VxqCNMwFnjmLRlw2wlo3gsYwArBnDXB+G6cwJqCiDVRXRv4cBaV3A==
X-Received: by 2002:a05:6871:4186:b0:2bc:918c:ee04 with SMTP id
 586e51a60fabf-319630cafbcmr11118579fac.14.1756980856729; 
 Thu, 04 Sep 2025 03:14:16 -0700 (PDT)
Received: from [192.168.68.110] ([187.10.187.251])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319b6063d3dsm2049136fac.26.2025.09.04.03.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 03:14:15 -0700 (PDT)
Message-ID: <2f2cafa3-0017-4fa9-8766-554556a9aa8b@ventanamicro.com>
Date: Thu, 4 Sep 2025 07:14:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] target/riscv: Expose Zvqdotq extension as a
 cpu property
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org
References: <20250903140308.1705751-1-max.chou@sifive.com>
 <20250903140308.1705751-4-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250903140308.1705751-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
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



On 9/3/25 11:03 AM, Max Chou wrote:
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 95edd02e68..ed486113ba 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1373,6 +1373,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>   /* These are experimental so mark with 'x-' */
>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
> +    MULTI_EXT_CFG_BOOL("x-zvqdotq", ext_zvqdotq, false),
>   
>       { },
>   };


