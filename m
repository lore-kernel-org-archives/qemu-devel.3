Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F441C87FCA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTZR-0000MC-D7; Fri, 25 Jul 2025 21:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTZH-0000KX-A5
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:19:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTZE-0007EG-Pv
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:19:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23f8bcce78dso31441705ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753492755; x=1754097555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/hqB/YIevZPRPxiBKUsVS93MXbGffUXyz+Cg+2sjbM=;
 b=UEiGOvLmGd3lAoil+yCLQtWPW0L6g/sac6IwFU3VakEnaSg4wjtkADnILstjRhW4ox
 +pAfXCTqU1K1qSKONy9Y75XpmLFyOME/qtJkuqX67r9AagOUXNiFMhGzjoe2mfqn9xBs
 OPpnHnI83twvXYKxRwGcU50NAzh8v53rcBtgDR+YP0Uh+Y01MQ03FQ3+vUR2ifuyW5q1
 xOJcbGO21hGctvSDQMm839sUvjmvoPI9I3VLM8kTrtgrqWIBecPh3iQxkSOgGSnteK17
 8omnRlwCNmYSOMEu/CDUwoxQrzFlaGqMbRgeZb8vDxGPj9efFZwh+BvakXN/U7fK4Kvf
 kPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753492755; x=1754097555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v/hqB/YIevZPRPxiBKUsVS93MXbGffUXyz+Cg+2sjbM=;
 b=SWKGQmD1/8+QmeKJQyhuY8dTfZiTIfgqsOAepleb+o4epX3BoM2tymN8DOpnulHhCu
 e6Udf8TuoO61pUTlpDrNkzcr+gjqiC6D0mqFeu9Ox0+Ll3v1zGiP6VUZBXNZTegwrZId
 6uAgbJgSxCZd4/LIrXPRtpdBtTwzrCYiZaQoPYmuONv3qeqNp4sVUgQoa9RjEWjwLIM6
 MJl4+EzczaZsqEdRT8iLX993YC25hHfOh8LFqJnLWx/H7YfV1Smsrbg+guo6bF5XJpka
 j1ICMquCVWkdkb/ZbDXWQNCXkPNtDep8ppvsK34zREB/rhhlQMs8IuJh6oJYoSVPpv7H
 gzbw==
X-Gm-Message-State: AOJu0YzZBKgzQDEj53PC3ULj40lIF+23BTewgULs8D4cXbIu2rgStfuT
 2jH8DUJoW+IIfxiQGmVjJvtthpNqwSwIcUF0dhM/gD55kbSnTfgPDtSYXJPVPdi/2pQooSPPdWt
 jq2f7
X-Gm-Gg: ASbGncuSrUYuw/SLbhoz944L6yyPT79748RqP9e/fuHbP4HmmrUjTnLYo00MPtiRJYN
 0Pa7KsLHOST933gUs1n7AiMf/0hqyfBUkmAbl0JMudOlbBMG0SDXb0xQ0HJGUH+nzWeAb7rnMou
 LOnvf9oISR0ymJtGCYzaU43zb35A4+4zRlUrqZ5QCTjJTw0juoAluq3fDwSbMy++BsYR81T5Pqk
 B0TE6TsldH/1ubJ8LncvZ8/3x8EeyNcaCPJw8Ph7ewC3oVgHGmgTF/Ok9owoJUyAOGYG56cRMC3
 ysZNtdEuuV3GN9Z+RTQtGtim05zvs9OstQERQsxu/4WTuQh19iZBWWl5/sHEM1zrmnSbcZZXWZL
 5XU+oE28BPAbay7OukP2oTO5hbgRgRIpJGZTJyuFPnddyo9ZycDWmrzxLsDNPJ0SPuqdj9taoni
 yIfw==
X-Google-Smtp-Source: AGHT+IHDMhCwq4i3K2D3qsw0jPHHqO3OSxp+0eNhfwFay8AoQHSsq3/rk9XpKlBBUIzEP++7ZVIclg==
X-Received: by 2002:a17:903:1a68:b0:23c:6cc2:feb9 with SMTP id
 d9443c01a7336-23fb317a043mr73698225ad.45.1753492755308; 
 Fri, 25 Jul 2025 18:19:15 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f5b5fbdsm668319a12.30.2025.07.25.18.19.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:19:14 -0700 (PDT)
Message-ID: <98090f39-b71a-4770-b9f8-9b7545e2442a@linaro.org>
Date: Fri, 25 Jul 2025 15:19:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] target/loongarch: Add common function
 loongarch_check_pte()
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-6-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> Common function loongarch_check_pte() is to check tlb entry, return
> the physical address and access priviledge. Also it can be used with
> page table entry, which is used in page table walker.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h        | 10 +++++
>   target/loongarch/cpu_helper.c     | 62 ++++++++++++++++++++++++++++++
>   target/loongarch/tcg/tlb_helper.c | 63 ++++++-------------------------
>   3 files changed, 84 insertions(+), 51 deletions(-)
> 
> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
> index 4c5cbd7425..62b3acfbc7 100644
> --- a/target/loongarch/cpu-mmu.h
> +++ b/target/loongarch/cpu-mmu.h
> @@ -19,7 +19,17 @@ enum {
>       TLBRET_PE = 7,
>   };
>   
> +typedef struct mmu_context {
> +    target_ulong  vaddr;

Use the 'vaddr' type.

> +    uint64_t      pte;
> +    hwaddr        physical;
> +    int           ps;  /* page size shift */
> +    int           prot;
> +} mmu_context;

QEMU coding style prefers CamelCase.

> +int loongarch_check_pte(CPULoongArchState *env, mmu_context *context,
> +                        int access_type, int mmu_idx)

Use MMUAccessType access_type.
And fix loongarch_map_tlb_entry in a separate patch.
That's the type from loongarch_get_addr_from_tlb and above.


r~

