Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDB0E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 20:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMCQW-0006MT-0Z; Fri, 13 Dec 2024 15:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tMCQT-0006L5-VD
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:38:17 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tMCQP-0004LC-5z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:38:17 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-725ef0397aeso1924881b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734122291; x=1734727091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRFktgGm38qO8Csj2wJgb6kJF5Uf5GY6gnXJpd6YWtU=;
 b=UT3rngyWJjN+AJ3ttnklYdAGGyCWQlUswYCUw+kPLlpexPb6IP+XgBU1yIo8z8YxwC
 c/SzfaBkdJ1KVS3CtiqI6C7766s/OQy3tC68lDxyYvBAVOtbqUudVveWnN/5hH6GTknv
 5Rj4Eu744vRItMOwtiHCpOem7HAWY9Q7gE7JxF0S3OFZXX9cF/skPRjWArRMdwmM/ORM
 Q+AryZSF0pLakMKu0u9YS9ocpoBaTijRSPcUT0tyXFLMBeN59uuw4H7OrtHBR+xD6e/a
 zl4Z5TVB1yOl76p73Omra98DzKcXRxLyHeP4fmdioxncLyr4SpQBF2c3BsZGsjkcpxqt
 Wmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734122291; x=1734727091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gRFktgGm38qO8Csj2wJgb6kJF5Uf5GY6gnXJpd6YWtU=;
 b=LqXMdCPbCFH1bZBZBIivNnzybuwE6bwedAs7kmVti/T3jKf8HWatS2bJClPY0sEfKw
 9QI9cR4fDoWrDAJ4uxZkkH9pkwls366XBxsjasLpQutJjXXUwtkicMVBDPua8DRG8x0o
 9Akz12z85LCESrzt6eou5XfTsY4A9u90ln4wngRIN7kQwYNASjUlLB9JE90d0y0i3r4m
 n+7k098CnKsccMpyrgbfphFPrClpQPG94IJU1zy7OqsT4A9DIS65BL2TjO4wEDJqyOXb
 u3jIP0/DXK+XSy54kAKgros+0arvUWnJ3hQZ3uwLJq8d3/kGih6KPUwlRA0xOIum3W/I
 c4wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgSU3/tnxrw3fhvHQS3RqJ4UeYnjYPqV+PnpD05qIrwFfP8w1oLIShyyWzdRMz72mTkP8mVzo9WAo6@nongnu.org
X-Gm-Message-State: AOJu0YzUDKC6atPt9+lXN2Ko9y9Q+rtORywtAbi09HRdXgQZqK/exD5M
 JYN7kxP9lj8BclCjPPptXimUcUBe/2V+owtqM//tK96xYv5uMcJqAEO8ukCA7G4=
X-Gm-Gg: ASbGnctghpIMNSIKIrJaVMKy7V+HjiIL/gXL8gjUCf8fYKqG/iNxxLgFFgquKldBDVz
 HTJmXjS9z4fhnGM68B2Rmlau0xtsdxk+5bpm5M1kJMLpxuwUtChkfWKAfr1GmPBloQ1spie7Akw
 g6CYM70TELB0BB35a7eTrCUG6wv0EQ92gBGR08uis/SlttbSlxFTHYQZiZX8OmrZxua3AHa3kld
 qhE05wTH1MbGUPOgrE8Vs+Mlb2sVJb6CuSYvtsa96T5B0YpJPbR68EJOMk4X9pY4AMp/gMwBH8F
 mbQOxGtvBdSNaiDc0x61OkQ1jWX3P3cu
X-Google-Smtp-Source: AGHT+IFcygqTjOxhrLRJOtQQ8qtKDxaqty0Oaod7p17YJzPfNcW506We74P/lJ9NwtiLfggLh2a8AA==
X-Received: by 2002:a05:6a00:3e21:b0:728:eb32:356c with SMTP id
 d2e1a72fcca58-7290c181477mr5894595b3a.11.1734122291111; 
 Fri, 13 Dec 2024 12:38:11 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9?
 ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bb0323sm198387b3a.148.2024.12.13.12.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 12:38:10 -0800 (PST)
Message-ID: <1e71d8ad-862e-4889-9cd0-4ec2d7bd67bd@ventanamicro.com>
Date: Fri, 13 Dec 2024 17:38:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/71] target/riscv: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-13-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241213190750.2513964-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 12/13/24 4:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 80b09952e7..4329015076 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2661,7 +2661,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       NULL
>   };
>   
> -static Property riscv_cpu_properties[] = {
> +static const Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>   
>       {.name = "pmu-mask", .info = &prop_pmu_mask},


