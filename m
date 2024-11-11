Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24B6D3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAYRb-0006oS-8D; Mon, 11 Nov 2024 12:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAYRa-0006nj-2l
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:43:18 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAYRY-0003EY-HV
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:43:17 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso1892782b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731346995; x=1731951795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vGcqJ3kQpO5ebNgDR5VJewzEAFwd0JWr/JucBnclfUE=;
 b=QKGFx4NMAXsKeZKmJtPq3FATYifB0WtYgWNM9R4tN5gLIB2zbHMMn3OBuvpOoTQXGO
 FdCDxcV+1kBIGz8IycGJGWXs+18hUX1vwstn8BvzY22pqIq+mMAytkMZqQURaIK6S6UZ
 6HigqugvwUtqbo4mT0aIs/Uhw8+AoB/E+k3ecnoNy+v8HeZMihMGPkrzK4vj16RuOYif
 LACNQgKy7VW8COJcyBcsgywU9ScBPAMd+4PKbfue16SkawEtjY3/ByOU5RZSi4f47T7q
 ldjnuD64udK1dSeZi24oU21bh9sr0tzlzsYlIYay7M36dyx/3Psu55r8fIFTeFYUNRbL
 REMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731346995; x=1731951795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGcqJ3kQpO5ebNgDR5VJewzEAFwd0JWr/JucBnclfUE=;
 b=JZH0Lv8NTcjOpH+mU7lo30BGYqWj884Bgr4GciDAWrGBSn7SE5zOQYZ+tQD8BSKczQ
 mqcn7obBTby1+6mo7cRQvC5K/ZIxbQonKSCSS7PrS1GL5B5gY7kea8l0KOBpsoEAab8G
 CnXrn3w8NLe60P8ZsR+STCQs3tbNcueKfqDjhWLMXIDFQ7tWpgRO4W63BBbdRcvc9y5V
 cW5o+mCOa4BU4b43i5Fo3DOpDapzdb5vR07hezjLcag0+ZkG7hoOUrg+bagBlIvNAV6W
 RcPsMUK8qGaYoSx7Gn4/wPRBSsXWhN7Tde99m+GbOxN/QopOEvacu3t6O9VhK9GOhAt2
 vorQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWot3LctBKPWjTOyJu/9zJpeAqyYYcoOFI3E1Xh44H2MuvaHoFsxKVcNaPyFV7W9cSO+bbUW2ElusNo@nongnu.org
X-Gm-Message-State: AOJu0Yzd0AIlGGDW8JcLwhLUuuYb+SNQ84pmgjN8FaRCDdoNkH0J6xdp
 gJUKafPWned7EeGfkKC1yu9uU4PAg0sB8Pd6RV3QTwLoeMYWo8318J8rA+dsSZ4=
X-Google-Smtp-Source: AGHT+IFquMzxYMWt0G2ybA0WpUJyn+ACZMSnF6zTzYIg+BmApkoM3a3fI3wnx+2quT6qlhN94tWYZQ==
X-Received: by 2002:a05:6a20:9150:b0:1db:eeb3:d06d with SMTP id
 adf61e73a8af0-1dc229b02e9mr17325878637.21.1731346995012; 
 Mon, 11 Nov 2024 09:43:15 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f486279sm7521923a12.2.2024.11.11.09.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 09:43:14 -0800 (PST)
Message-ID: <141fe18d-0433-42c0-9b12-0439a4852bb1@ventanamicro.com>
Date: Mon, 11 Nov 2024 14:43:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/riscv: Support hstatus[HUKTE] bit when
 svukte extension is enabled
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
 <20241108085239.2927152-4-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108085239.2927152-4-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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



On 11/8/24 5:52 AM, Fea.Wang wrote:
> Svukte extension add HUKTE bit, bit[24] in hstatus CSR. The written
> value will be masked when the svukte extension is not enabled.
> 
> When hstatus[HUKTE] bit is set, HLV/HLVX/HSV work in the U-mode should
> do svukte check.
> 
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h | 1 +
>   target/riscv/csr.c      | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 4b9f899217..fe4e34c64a 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -604,6 +604,7 @@ typedef enum {
>   #define HSTATUS_VTVM         0x00100000
>   #define HSTATUS_VTW          0x00200000
>   #define HSTATUS_VTSR         0x00400000
> +#define HSTATUS_HUKTE        0x01000000
>   #define HSTATUS_VSXL         0x300000000
>   
>   #define HSTATUS32_WPRI       0xFF8FF87E
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 1936a6f32a..b6fa8ae53f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3540,6 +3540,9 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
>   static RISCVException write_hstatus(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
> +    if (!env_archcpu(env)->cfg.ext_svukte) {
> +        val = val & (~HSTATUS_HUKTE);
> +    }
>       env->hstatus = val;
>       if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
>           qemu_log_mask(LOG_UNIMP,

