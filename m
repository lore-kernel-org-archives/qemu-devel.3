Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E29ECA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu6yx-0003pf-R2; Thu, 04 Sep 2025 06:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uu6yu-0003oS-Ln
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:14:16 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uu6yq-0008By-EP
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:14:16 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7454a992f7dso688247a34.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756980850; x=1757585650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9GxhJmWfwBye7noMnqDJZ/ZX2guxAEgJ0FNB26d/OM=;
 b=B/oxHCGFptNR2Ph8rqWP4ECYJi+kJzJyfKBiPMmzLKb5N+phWMVrw4vpeSaajIP4SL
 WEnODLSc9p83pnmFenXLI7wNuXGuJx9OlWfezPjtU/Mxp1qS9JIRhfh5Jk4k9SQjaCMc
 O5AFmAdRXjATws1dJOlLtglvDh9ZclAl0ssM9Yv2NLuXrcadRu8lr+dXzRTG/KR1rQok
 C1RUTpdJzncSM/McUiIc2YKwfFMNE0obyFR25ywxPdsUkzTyXKDt/7v37DnIMxHNPV4y
 Th4KPSGZZAIWVa/fgJB4yTQF0gTT50ZUjT/Lq27nFQOQEa7VRicUxORmfoxH+06hiLc4
 /GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756980850; x=1757585650;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F9GxhJmWfwBye7noMnqDJZ/ZX2guxAEgJ0FNB26d/OM=;
 b=uwiYiWkGFkWyxzcPQtUnIx7nV+7J+/h0FMrvuZz1zsRe7apSDymcF8u+WIeKmQ1D5e
 TbLNpgaCyPtSnN37zOyj4dmitdOza/xYs/+jooqoKn2Yuq/Z2LG0oID0P9NLdjpj77pJ
 hZ/TWbOsRFP2jE2/jrEItdBZwxQt70saVtxM9SZUNuDh13QW2S8SXDOTS2ZvFmzyIqP1
 L8I8E7Lnz+9GDwxYYsEuTZc0wfr7WoGuK3WutiiQKC5zY9hzCnALV/3lrxtmO9IS7ylH
 3+w5CA4AD9akW+mwwUsK45S8gJfI28KvongPB1K17l5pLcTqqTbZzi8iuBoelxPHgf+R
 M49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYlIt5I7i5s1+DeBHPaDlLqP80tvcxb/CKDT+gcPhiHl1fRCcbT8I5i0PVNzx9lg8QkR/oIf7cWXTf@nongnu.org
X-Gm-Message-State: AOJu0YxImZc09cSnZiWg1at1YdkukFsN9Pl6+dU85kegAIV9t3kBp3nH
 m2bFBCYWA3eZq35yYH7cymubuTOJ+aS2hBh0+2PdQcGribr2X0VxP1vpeJrvIFsEynw=
X-Gm-Gg: ASbGncvZHfbR4ty6R1un/Qvy3I3MSVL2D7JSnjXjaHWunnIW76v5EO/lAPIWVTy3E1e
 rn7M+fIjVJlXPRuQp3Hgh0Jm0u7BY6Qc8LCynYziOU5SVJ2Wb380auCKbD8zZ4emker8PM7Tra8
 +MvW07aiktB9B22Z7rB50nhQGlyJvUELS/FMinwqTP4vocn/JcZh0xCCGUn62/B0XbmI+ePvP0R
 PsbEW4xJGVguYm3wgtWofnsZ7JZQRYQxQQMm7cCjVZZ6UJ1x9kPh5eSV1YLiLSRBMwtdOzCUXOd
 7velN4T3bYlV5nRkCZ4UjsTxqNye1DKHRIRILrniWzG2WpLhBCjkzhjAV44pwdOiicKpo8QyeQi
 S3t4FcUsdg3IjHmWnaASzSUv7c4k7wf6vGrRWg7kp9J9/QJY=
X-Google-Smtp-Source: AGHT+IFMxCTjr2ulg1tUf6aQ5+QiW5mTfsn/q3zJ6U9Y39MM6DVTIllosa8QvDq4q3MRLNV+oh6wyg==
X-Received: by 2002:a05:6830:648e:b0:745:615a:fe6f with SMTP id
 46e09a7af769-74569db5623mr10148022a34.11.1756980849845; 
 Thu, 04 Sep 2025 03:14:09 -0700 (PDT)
Received: from [192.168.68.110] ([187.10.187.251])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319b6063d3dsm2049136fac.26.2025.09.04.03.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 03:14:09 -0700 (PDT)
Message-ID: <da524d10-fee5-45f2-ba9e-23f66a754e9b@ventanamicro.com>
Date: Thu, 4 Sep 2025 07:14:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/3] target/riscv: Add Zvqdotq cfg property
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org
References: <20250903140308.1705751-1-max.chou@sifive.com>
 <20250903140308.1705751-2-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250903140308.1705751-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
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



On 9/3/25 11:03 AM, Max Chou wrote:
> The Zvqdotq extension is the vector dot-product extension of RISC-V.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/cpu.c                | 1 +
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 5 +++++
>   3 files changed, 7 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..95edd02e68 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -187,6 +187,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>       ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXT_DATA_ENTRY(zvqdotq, PRIV_VERSION_1_12_0, ext_zvqdotq),

Is this really 1.12? If it's marked as experimental I would expect it be a new
extension, e.g. 1.13.


Thanks,

Daniel

>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index e2d116f0df..5da59c22d6 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -100,6 +100,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvqdotq)
>   BOOL_FIELD(ext_smaia)
>   BOOL_FIELD(ext_ssaia)
>   BOOL_FIELD(ext_smctr)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 78fb279184..7015370ab0 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -767,6 +767,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvqdotq && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Zvqdotq extension requires V or Zve* extensions");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
>           error_setg(
>               errp,


