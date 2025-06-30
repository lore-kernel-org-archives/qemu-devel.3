Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBBDC7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWD2u-0006u7-FA; Mon, 30 Jun 2025 07:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD2j-0006si-AD
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:51:30 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD2c-00087t-My
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:51:24 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7d38ddc198eso217859085a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284275; x=1751889075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hsix+QDvemlV3gz/UpeDemflmuRjux4V/Jm1LqpJO3I=;
 b=d9FhSTi/9ydOAxDHFYPxArVqi62JC7G6rsmDWjwtjL+GOAcHPNcq21JFRwQQ65sW8J
 C98JuS10ITFprQK2+ESV19d1uCPXyPgu4YM9B1MoZGL2ZDVe+4fDhqhwAeJTsJqNcG7G
 csS+ozvf06AhGJusoYykCSiS8HD35EpNU62FxbJUuEOjU1aZaf5hvZu/b47xolPkjbW8
 V26OWFKdj/7cHzrB+RkzCFhnzAYGhigkmFwfSH7FZUaaor0Lh7Wi7V1aIUUHkITja3Ym
 ykREV/JCpLVGfOgk93RhTlRsL+hxJ1P4OwgHougewInTu8LVJiNZhXOt3Zo7eVXqCEgn
 Q4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284275; x=1751889075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hsix+QDvemlV3gz/UpeDemflmuRjux4V/Jm1LqpJO3I=;
 b=RJnWSb+QPsgVGoo9P5U2rbR3iuxPQ9rObyevuZlIHctuQg70gDYWlnfORC8Vz485WD
 DPzndJqviN29VVYTVku+WWK5SYc5mItGo4P9nbg5ZNuYjlNiigvusHHgIQQM1/ilZu4J
 tdyvgbdv+kX0nDcmmh15YXkIJsQlr6kbYzhIzffel+/oUTzSpItj1ean7SQwQ8YHnx3j
 /xe7qPb4SAZwvrifw9/tZDrKND4pnJtMYTpNtaMpcIRBdv9iGhAhvwAe3jyv2hd6lvzm
 WVs+2sAMui8pIfu+sgFybcSOP68lOnl1MMlycapzUmWTDQeC+Hhe79zdiyoiGCDd1+gG
 e/vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIgWVh8PrVgJlxn9RcK2Lv6AbS5C3mpUlbdJaAMQbCPCE+V/fa86eiGuZBlm3D0Lo6gmrcjkywkX+v@nongnu.org
X-Gm-Message-State: AOJu0YzmDsl2e3MJFRnbwXkaO1Jl05EW2IO9L9rcYGEIr2sBSmQSfaO6
 WcCH//07N/oG4ZUKBLLEQejYUtt1Kn8umJDR7Gsb7tQWFgYWKys/XGzgqGc5EdpEwVo=
X-Gm-Gg: ASbGncvKnqbsp8xUj89JCe7QRAvSMyquObSzlUiLagYHzcqeLeh9yFagWH431dDgWbO
 ejbkaSyxQ5kIMgG8pwT2N9rdfECKqHwnBZLJpsiGnQAD9Ds3+Av/gaV3DzoMQ8p1kq/DijLvf5q
 99l3+agzj+Ioyt61nlvfR+SlaoUTstDvHdueh0isbAo8sGwO1zxordHufINjB72j9uC1FGTcc7A
 6EGp8+8hHRMfvUwhuNLiOacp0Y0jhQ7buZTB+tq5wWPAlylV14+nhE/UjFiPfLPEkNXRpOgVd3p
 cPfqw7vwL5d/Hr7SPvvvdpmq0GusAnA6w//Byy9IxXzd1UD1wVm2SI2U8p7U0som3vQouWC4/Sw
 =
X-Google-Smtp-Source: AGHT+IGmVhEHDLz3zfUk0BEOBXONFM9NCI8yxtbLNOu9EI3k6WDNhYFXxzF8XRXABCpXTyoVWSRnrQ==
X-Received: by 2002:a05:620a:2712:b0:7d2:1199:ac89 with SMTP id
 af79cd13be357-7d4439a6690mr1941779685a.36.1751284274740; 
 Mon, 30 Jun 2025 04:51:14 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443179f17sm580166685a.40.2025.06.30.04.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:51:14 -0700 (PDT)
Message-ID: <313db59a-5bf9-4001-bb68-ab67cbde310b@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:51:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] target/riscv: Add MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-4-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-4-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72c.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> Introduce P8700 CPU by MIPS.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu-qom.h      |  1 +
>   target/riscv/cpu.c          | 15 +++++++++++++++
>   target/riscv/cpu_vendorid.h |  1 +
>   3 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1ee05eb393..1e62b96094 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -55,6 +55,7 @@
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>   #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>   #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
> +#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..672e30378e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3167,6 +3167,21 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.max_satp_mode = VM_1_10_SV39,
>       ),
>   
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec = PRIV_VERSION_1_12_0,
> +        .cfg.max_satp_mode = VM_1_10_SV48,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.mmu = true,
> +        .cfg.pmp = true,
> +        .cfg.ext_zba = true,
> +        .cfg.ext_zbb = true,
> +        .cfg.marchid = 0x8000000000000201,
> +        .cfg.mvendorid = MIPS_VENDOR_ID,
> +    ),
> +
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>           .cfg.max_satp_mode = VM_1_10_SV57,
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..28f0ce9370 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -2,6 +2,7 @@
>   #define TARGET_RISCV_CPU_VENDORID_H
>   
>   #define THEAD_VENDOR_ID         0x5b7
> +#define MIPS_VENDOR_ID          0x722
>   
>   #define VEYRON_V1_MARCHID       0x8000000000010000
>   #define VEYRON_V1_MIMPID        0x111


