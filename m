Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF6D69104
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGe6p-0006Ap-Ni; Thu, 28 Nov 2024 07:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGe6n-0006AV-V3
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:59:02 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGe6m-000142-Bc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:59:01 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso660554b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732798739; x=1733403539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBB9y1QxF3FeAhPNni7HuWH6Mijkm1BWd+FZvP1ekYo=;
 b=SZtsXm6I8hGR87UMBlO2REytMQk84VkPhJ8TFyjOsTw2888fCCkfRoF1LUif2b8t41
 1iSVV2ZM7EDaJftguPqnF0NV7m6Jv9Az+i/NisFI1NSaLbCX/b5q4G3t25XlqDehiyVP
 SpUhxwF84YYfz3oMplmXYjXDAROfUHfBom7gH27r6PqZfB4FH6baSKI6H2t/tqtB2lHy
 kzlV1EGfwBcT0HvthI6eCAdH8Rx/t2hVJjH/nFcTEL8fuv128+c4xltFUrCROOFSsJ7C
 gw69VjadLFbAD7QQZBspV5fgX0ujh7GEiWJ28NAkiyLu3oyM80vUO2uObjq8TmHQN8Nd
 ihgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732798739; x=1733403539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NBB9y1QxF3FeAhPNni7HuWH6Mijkm1BWd+FZvP1ekYo=;
 b=wimcqIZ+XniI5VfPdYr0DhcK4az/lxOxysnpGgqRIxaNWYy9FaRrWAKejPuwrAJG0X
 hdNIEUFcuNw2OPzVlcKeC4SQmsXZ1alu0QOll7MWtWo4xCyaSNdY3TeGUrfo/BvL2C8N
 QsVJ4+rUGIv0tT+w6EG6wumr38PBHj5riOdFB/KcKIRbPtt5akvs6feo7bcdHq/3GiAA
 7DE5kM94Xrf2rTAwpyGpkCgu3vqC5y56IHJMxeEsK0iIuymxCATh1qCEksQGaUvEGvU0
 xYdZ09OLRZA9os+t72zQw4u7xhHb9K3pYG6ekuy7mCZiuE7P5VGnag8qDlSXGQ8IRJGL
 DEFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCUZ7cXeaiXO7ZspGVxvzfsLkIUQH48zdvCtzY/f2HYLOkjisKflNTtaVEfJogIxTvhfEYxdWAciCC@nongnu.org
X-Gm-Message-State: AOJu0Yy2ExClQ0Cx1mISK8FLaA1GlQ5Rpi/RkWcYe3c+45Vs178KjzEK
 e6rDfGFSL/kkAXh2hP/C3qjfejXpYF5KeRzLRLjxEJ8/g5mCZqqIf1zw/jAmfKQ=
X-Gm-Gg: ASbGncvWskm1TP3OpbxkbfsCWVymb174fgEb9J19Ni3LSu0Mwk/AV/Is4Fc+e/ISRHp
 L7V8oltvHNxsiKU70iiseZHXVgv1tuTsaVOba1PDCN2ovxvZ7sOwBKXKccVH7SCkmSuZcz6goET
 ax6t3qbqgc4Wwi0aKtrpRtNVOayGlc+k2+DhYMs7WUo0d0grJvlYpM47CyhPvtYagt0JzjszwO4
 GOA3f/O+PddrPC7WKSdVG2okFKuYLbaB7Bl5GTrdt06YHw1y+/+lKtaCjrzsJ4=
X-Google-Smtp-Source: AGHT+IFFJCwiEvfdGt13JpsM89I+fjT572beMjTWhOq1jjQpSMpvXaKwWYcfPSdxXQeZRMzAwLQemA==
X-Received: by 2002:a05:6a00:845:b0:71e:1722:d02c with SMTP id
 d2e1a72fcca58-7252ffcbf9amr9660383b3a.3.1732798738649; 
 Thu, 28 Nov 2024 04:58:58 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725417fc064sm1434698b3a.130.2024.11.28.04.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 04:58:58 -0800 (PST)
Message-ID: <fca701ec-a3b8-4db1-a14f-73d72fcb85b2@ventanamicro.com>
Date: Thu, 28 Nov 2024 09:58:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] target/riscv: Add configuration for
 S[m|s]csrind, Smcdeleg/Ssccfg
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-11-476d6f36e3c8@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241117-counter_delegation-v3-11-476d6f36e3c8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 11/17/24 10:15 PM, Atish Patra wrote:
> Add configuration options so that they can be enabled/disabld from
> qemu commandline.
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 410ca2e3a666..2a4f285a974f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1477,6 +1477,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       /* Defaults for standard extensions */
>       MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>       MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
> +    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
> +    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
> +    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
>       MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
> 


