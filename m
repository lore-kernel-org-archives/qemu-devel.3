Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B147CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyURJ-0006zQ-4i; Tue, 16 Sep 2025 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyURD-0006ys-Rk
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:05:37 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyUR6-0006I1-59
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:05:35 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d6083cc69so50620787b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758024324; x=1758629124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O1wTHEjKkT6gso74JJRkO0c9QRHBxGZBBewytwJK3co=;
 b=UFgtuOkxu6GJzYyrQ6ubpI1rgxBzzCy9HmqCalioGLudMhLLFsBrHUVe4JGwYAcHXx
 JrrtyFl6uzKePwcONd9psSKIth3sqaaKkZvTjWFOjlShzEBVTBJi39xmlHG70bqi0GKA
 001Aji6KSNxxP3aMZglUPzaJPwywJJSHVagXz8m0iUznHN32E1nI6sLf7/c53yaZzeXp
 ARS6maeXsSP5iC21N88ni96+5Q+wFymkldZX6IOpDkjm4I6n4rEfABcsQYC2Ykm0avZc
 CvDnAKGZOsIcgK9iLXXWjg/SjFdIwCz/0oi3FA/aoOsjdIVsWtUe8/x+UckmmTV0Xtyf
 3QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758024324; x=1758629124;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O1wTHEjKkT6gso74JJRkO0c9QRHBxGZBBewytwJK3co=;
 b=GgAlVouEvrGKPJXgN0mtVtBGgLN045Zqscz0ST41Pm70Q3hxENZ93GpSGg9kIoRHDg
 1c5q68N5Bki5BkF8sV8mwt5wdbHqh6CkGbvSUpRJIS9EgXrE+360Gxo84zaiLe/iUuCa
 XDzMmenDwiUxsex260KwkuDJyoWTfZvyH5+AxNZ6KwGpEjIyn/WV5HzEejfeGeb1hjpP
 KM4ratBOFbm6qNJ8GGK8cUr68qAHrG9NFvWIz/w2Tgkh7cXUTpuYvHn8KYInaXGDYuM9
 L48pvIhRL56X7gtYmIiSy22OKFQT8DuLdYMGsESWAVxER5ofOxVVNfSQTKkZcL8UEr1v
 r22Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgsvIkMnKouZbu6HKH+aT/zWwlWMPrKnH4zjAzNhDTDU96Nz1TxYtvTsVA71gKoFpxBPIVZJ1uI4Op@nongnu.org
X-Gm-Message-State: AOJu0YyI3x+6ffKs9zgVMI+LigaASMrLcyhRBhHZUJZwH+0515G6gdXw
 t+WyTrt+uA1gGYAAnGOT5iC5yZN8spSwXbe7OxYFLj6JlTaOe6LhwvE2OyR5vwT+e2Q=
X-Gm-Gg: ASbGncsJIffKXLbuQT2UkNiWJxY711a+DOCT4bNIqONYYYb6poRhhdDKrMbvYcaNeS/
 PYCRYdAW26TxV6uVELs2D/ZgtHZ/gWs9mZbJruJBQWuTIcs8M+LRQt5mmAYoPi5vr/I0anhDsCz
 Ml03VcQBd/xu+r4wyUqpifthbfskEm1XC06N9lnzHqc1scTAjGpa8aNOMALQ2VglnBO7kwzFkPm
 l6gJ9gi4wW/I2STYUw2zIATCe0hmebeXdlMTXNo4zKTPZZpD5QldpRF51zbAriREuid+FV4asvr
 Lv+9qmY2RNiN00XCmXLUbAd08+Zl6GsiJOuQmK83C/dmQjM7Es+akyHRzX0XoCPGZX3ViWWafOt
 HC7Diul7/U+rLfLYuZnQUF6cStJlZvBNDYEe6QI+SzuWNdVMC
X-Google-Smtp-Source: AGHT+IHtZDFYnW9576p1OORnG63/UreHrM/Lyp/leLHi30vS0/ghj9j8E+HG/sfSlQBhbLE7kTgZjw==
X-Received: by 2002:a05:690c:6c91:b0:730:4c94:be14 with SMTP id
 00721157ae682-730631947a2mr141129137b3.18.1758024323495; 
 Tue, 16 Sep 2025 05:05:23 -0700 (PDT)
Received: from [192.168.68.110] ([179.225.245.173])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-72f791a35bcsm39034557b3.39.2025.09.16.05.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 05:05:22 -0700 (PDT)
Message-ID: <7c7a8917-0b98-48e0-90db-8bfd7b13a8cb@ventanamicro.com>
Date: Tue, 16 Sep 2025 09:05:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/3] target/riscv: Add Zvqdotq cfg property
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org
References: <20250908025117.1728895-1-max.chou@sifive.com>
 <20250908025117.1728895-2-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250908025117.1728895-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112d.google.com
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



On 9/7/25 11:51 PM, Max Chou wrote:
> The Zvqdotq extension is the vector dot-product extension of RISC-V.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c                | 1 +
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 5 +++++
>   3 files changed, 7 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..d0909f7beb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -187,6 +187,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>       ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXT_DATA_ENTRY(zvqdotq, PRIV_VERSION_1_13_0, ext_zvqdotq),
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


