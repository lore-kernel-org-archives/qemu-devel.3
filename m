Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C6CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETZa-0001Q1-Gz; Thu, 30 Oct 2025 10:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vETZT-0001Mn-TW
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:24:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vETZL-00068R-Uq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:24:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-290dc63fabbso10945535ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761834238; x=1762439038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qhmL40yJuYA7VTug2A9/droT3+foPeGGcISVtBeqCo=;
 b=eW6YF6Vl7R2l8rOG1c0ncuA0CFxX30fii8kDpeNDmTemxXktOnvJrePE6ZY6ylISgH
 cljFQsqffugtxf2obrlflCINmuOWWYHG7C4ic/OpYjLciKIobaYHIB/p7bgIP9b5+D+d
 IgbxnXHk7+n7e4R2YGxpkzD7I90/IaPoEoxcejdt1nzpvyEG03embWVjlkABK2IeaCQT
 OqzGXRUTz5s1g8WDzXD+GMPS6qDCcwZOTjOCT8iZHu4IUtcoSX6MOF/H5RsqTgPtuhKC
 7NKKf82Rat71owgp4Ue+vDff0xsY7SIRhNeM5MziRhATYUh7g9NZOy6djTvZJvsi/8GO
 f55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761834238; x=1762439038;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qhmL40yJuYA7VTug2A9/droT3+foPeGGcISVtBeqCo=;
 b=CqfiNhLWagTm4xv4lItvGmFWNuZ6P6ZhQcVsHPVBzFH07NUpwcNghL4D99NxQErSJ2
 J9seqVK0EwRa0AiKNVWa2czFbK6fMFX/bgb2lUKvix606LbcFC/NpS7lvzaqCPJ4HMKA
 rhCHOJnBdOwgcl/OrPraJ+NhSG+XCeZJMs8uDrBColGEataxSvz2chAoV6zsw+maCarP
 McZx++yHSMYy1zCsj3S5LhD79JsSUzJ4JoxI00MqANRDRzdJmLIRRGxvFh2YRKNsKSMv
 gxLRSw8erD78QNG4We+3G7xTBZ8CQac8v/VH+5bCV4bHa+GNJiGDL31r04nkieomeqdM
 GvaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUydZd0RE+r00QTjJS9KG2Qyo0VaLWifF6rLxbT+7Fn9rIrUoMgI+6/XCWYHqhH7iRX8ki7l1lJ7gF@nongnu.org
X-Gm-Message-State: AOJu0YzvUGTpVOpsKZ7TiHQX1HepB3xNnz7HDaLlVXR0sCncz3kqFxr5
 pA5fsW7BoWL7Cte9gWNZPy8tIdzCTdpYWDr165Pzl6pPgnWgSwT8QCdcKNycvfdFeG00UCWIiPg
 gYZ0JZGY=
X-Gm-Gg: ASbGncsyCfDuqCX1TxJgWpzb0SwNOLG8m5zU9A40GSw9590ltfOczH4fWYESxeZn07C
 Tn4dM3FclRqCrOF5eNgIlw8xPmXWnLgaU+FYpskR6o5RtNWTfThq7MP6X5INtBiIa2015NCiP1M
 R0eBGLnIDJ6Ob7/Kojlocta4JrGyYS4d7UgmlFVdUCHwX0q47lr4PRaGV3KUFmi6GbjxiXkPh4N
 +WH/Wp0kwvHm6cTEayVROPvhAOB2NsMXnYYsRWQRmD+ZU6MVEqAYNGBIZnbbqVd29t1lS6oIMiK
 Lq1q9yIqHMYb79QESki8wd5rJV/N9toijmmsSnbcnhPeyTM3GruYLyHl1xu0ELJKmbsJ3lbLUFN
 G/LpH21Nd6I0qrltLKU660YPs5L72ku6rBVokCo59j8SHmaK/KZok6gDDnallvVP8ZE6jheyu4/
 hO0X+IrxjMTe2jMssmihaO+F0=
X-Google-Smtp-Source: AGHT+IFuwKo04u9v0JNDnnu0lw8LLMTDxx7C5hMRIO22lCjQU5IfvCCWveWeiXaY9m3O8KUM2m2QRw==
X-Received: by 2002:a17:903:1a4e:b0:246:80b1:8c87 with SMTP id
 d9443c01a7336-294deef8844mr94161415ad.43.1761834229801; 
 Thu, 30 Oct 2025 07:23:49 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.65.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d0c414sm189617475ad.44.2025.10.30.07.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 07:23:49 -0700 (PDT)
Message-ID: <8a1ee6f6-0198-4a6c-b4db-180ede88187f@ventanamicro.com>
Date: Thu, 30 Oct 2025 11:23:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: riscv-iommu: Don't look up DDT cache in Off and
 Bare modes
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20251028085032.2053569-1-frank.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251028085032.2053569-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 10/28/25 5:50 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> According to the RISC-V IOMMU specification:
> 
> * When ddtp.iommu_mode is set to Off, there is no DDT look-up, and an "All
>    inbound transactions disallowed" fault (cause = 256) is reported for any
>    inbound transaction.
> 
> * When ddtp.iommu_mode is set to Bare, there is no DDT look-up, and the
>    translated address is the same as the IOVA, unless the transaction type
>    is disallowed (cause = 260).
> 
> In the current implementation, the DDT cache is incorrectly looked up
> even when ddtp.iommu_mode is set to Off or Bare. This may result in
> unintended cache hits.
> 
> Therefore, the DDT cache must not be looked up when ddtp.iommu_mode is
> set to Off or Bare. For other modes, software is required to issue cache
> invalidation commands before any inbound transactions.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b33c7fe3259..95db811f125 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1290,13 +1290,18 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
>           .devid = devid,
>           .process_id = process_id,
>       };
> +    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
>   
>       ctx_cache = g_hash_table_ref(s->ctx_cache);
> -    ctx = g_hash_table_lookup(ctx_cache, &key);
>   
> -    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> -        *ref = ctx_cache;
> -        return ctx;
> +    if (mode != RISCV_IOMMU_DDTP_MODE_OFF &&
> +        mode != RISCV_IOMMU_DDTP_MODE_BARE) {
> +        ctx = g_hash_table_lookup(ctx_cache, &key);
> +
> +        if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +            *ref = ctx_cache;
> +            return ctx;
> +        }
>       }
>   
>       ctx = g_new0(RISCVIOMMUContext, 1);


