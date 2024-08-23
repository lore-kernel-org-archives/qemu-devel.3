Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1CEC5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 21:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shbS2-0006Fa-AI; Fri, 23 Aug 2024 17:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shbRz-0006Di-Bs
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 17:04:04 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shbRx-0000R7-Nn
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 17:04:03 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70940c9657dso1825670a34.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724447040; x=1725051840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k/mm/P4s0xYR+ROsyOm3GDJZTsd70mJXbCa5JrDAc2E=;
 b=NZ/ZvzN659Hn/u+2rbHlx7bBstZHBqol3as9sH3FLo6E+Ay/K6J752MDrjmyrh/M00
 NHZ0ZK5C7FJV/BsJtu+pe+AD7ghMD2MEy0YKjw2/PuoZHjChxQKhDAulqYfj9RoSjXyF
 CzXS3prO4kFPcYOicThdtMoGvhfsnv/Xsa55w7HsM1I3pahyfVmD7vD/lalC9GrOzl3g
 Dlp/TEjgz0/siuQB9UrTMZmaIdx0zrs6VkvYNR2gfBaYjIaZ18GPyxNQFztSyBxk1cu3
 fWEL7kCFG87ZWH5swWHRfq8N0n6VskoQCCqGDj1N5DI2mL06Yz6ZyBxRUzjzfCgS70CQ
 7K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724447040; x=1725051840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/mm/P4s0xYR+ROsyOm3GDJZTsd70mJXbCa5JrDAc2E=;
 b=RDSTU+uZk83u0XsTW24R5czWcXXPY9RS5NdnIvJOejTnHvXJ6XnC/zEr3rCy3Q4gmB
 ycgiqabo4AUTSDJiBb6NJ9RlGBu1z25T+xN+3RNuzA2NL+S6Opv3V6PDmQn8oc9jMLoS
 plYG/tH+GNnEm6jaex7jygaa54BgEMLFvX/2kadrkNJxY+G62674lqLlKUhZ1SR3F5Xz
 cAYBePpod1g/z7BJpZq5zxL/4guqFJoyYX7J/dqXEv5/dnOYbd9k7JivtPDuzNYP8ziJ
 hZOwk7b5Gt5xNEpHVlN0f3syDdzrXAl4QIncUqmQKyQtv6w+jp2IL7G6zuzmEe33Q4Au
 XwVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvEDP8BHuzanealKePjJgta7yj5JcAh9W4oUi40iWH6yfk0xJps1MKGhHbSv9GpeI+RFA7krVYw5b2@nongnu.org
X-Gm-Message-State: AOJu0YyL1QO27YlL8P1dpTQok4y0Ox2wIGv1WaWOjEifvzUHGZ0cYiTk
 hf+PDuLYrViQr7sRpxnGfSk3oKhi9XLuBGIuCDC6NInaoTaMut+akhNNrOZPlcM=
X-Google-Smtp-Source: AGHT+IHFV97kqwkmT3ffsS+/hNmLGfVFX10RiBtJ9p8SefNDThH3ifTeSQScrWrZvcGDogov44wEWw==
X-Received: by 2002:a05:6808:1922:b0:3dc:16ca:d9d9 with SMTP id
 5614622812f47-3de2a90b1f9mr3684845b6e.46.1724447039912; 
 Fri, 23 Aug 2024 14:03:59 -0700 (PDT)
Received: from [192.168.68.110] ([179.133.97.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad7db5fsm3131695a12.92.2024.08.23.14.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 14:03:59 -0700 (PDT)
Message-ID: <64fc8ef5-93f9-4d88-a552-4ca30dcfed77@ventanamicro.com>
Date: Fri, 23 Aug 2024 18:03:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: riscv: Enable Bit Manip for OpenTitan Ibex CPU
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: liwei1518@gmail.com, atishp@rivosinc.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240823003231.3522113-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240823003231.3522113-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 8/22/24 9:32 PM, Alistair Francis wrote:
> The OpenTitan Ibex CPU now supports the the Zba, Zbb, Zbc
> and Zbs bit-manipulation sub-extensions ratified in
> v.1.0.0 of the RISC-V Bit- Manipulation ISA Extension, so let's enable
> them in QEMU as well.
> 
> 1: https://github.com/lowRISC/opentitan/pull/9748
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..7e13fb2c0f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -701,6 +701,11 @@ static void rv32_ibex_cpu_init(Object *obj)
>       cpu->cfg.ext_zicsr = true;
>       cpu->cfg.pmp = true;
>       cpu->cfg.ext_smepmp = true;
> +
> +    cpu->cfg.ext_zba = true;
> +    cpu->cfg.ext_zbb = true;
> +    cpu->cfg.ext_zbc = true;
> +    cpu->cfg.ext_zbs = true;
>   }
>   
>   static void rv32_imafcu_nommu_cpu_init(Object *obj)

