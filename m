Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35482E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoxj-0000L8-SW; Wed, 04 Dec 2024 07:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIoxa-0008Rp-Id
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:58:31 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIoxY-0000GG-GY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:58:30 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so4028190a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733317107; x=1733921907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RvTBnz7ZNUA8H4NoRdWH9xyQCXotA8K3zl7nZUBj5O4=;
 b=hva8cukYpCtAAI0azwyk257ezkZm7SlWOE5JB29212wiB1wb4csCOC72iAKjGSGM+c
 w5Lvd7lzunWGEfky7+XdfqU84LQU9TCOPVGS5J3IgURl25x85+cvgguVsUfNZG7CD2dR
 bb402r0CSmWAn1py7UnzjQJ2ShNOJ8T7IDoF6ZdPHP3ryp8tVf8YLGBqeJpjgIXfot2k
 q0aFEvj1vrVbsvaR8az/089exmzZHWvgI5GYmElmMh34IxWLA1EfSJVnKu6RM6NrTkpN
 hBRxXazeC2PUJfvnBYJlYfZ0mJVdCTZpErXagiymCw9o14YBi/biWiIh5lJRm7ljOPpS
 x4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317107; x=1733921907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RvTBnz7ZNUA8H4NoRdWH9xyQCXotA8K3zl7nZUBj5O4=;
 b=Av7NNA5cjOz+wwi6N1JWc6UYuJG+3MfeCIHXk4IqbhO6V6SO2SmPwWF5vw33IRYaLD
 mjl29nwLs1DQM4MBTpVQlUCTvfLmLJsfAkjyFczVm3rKAXPwd/7oYvOj+FdJvOj3z1sj
 GtY3AmW26hS0U+WninK9BI7zIaa2ptoRuA/ipEwyVZz1OSqH3WsJmI+WAFTbldoYRjjk
 OiOpVfeP/wkvIww+Txy5+oxWX1DK9YU41hW/Uj3jzOritP1gA5n/Ptf49Y/iuMka7CZA
 FpBG1TBoYR+ymZ2oepjhTDBjgFVssm1gy4a1wC1nJ9cODd9/IR9+V5swT234EGHfIygM
 MbhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBTT+UE20b0nYbfmxMwAqF4hcs9A+ttdT6JsrefQXj4FR/Nqqaj2tufoeMLIxIYpPZTzHSfI18NMLh@nongnu.org
X-Gm-Message-State: AOJu0Yw61xY3Hpm4+BaCugpU6Wq1zqFhLce6lSGN7xzbAUTMrAnh8kjP
 70Nxp1bVJT1zYEgLXsR9OliwE5KrZcKqVoQxZaNTtqbzlp1/C/mgFAgOqrLzPiY=
X-Gm-Gg: ASbGnctNIvOMgKX2d/k2e1Eg+y6yYpRKiwheFExUjgJUloVKNg+pv4rn7JabTL4n0cu
 rzqbV6y/Mr/8L0Go2WazUVl5c7WT4+yVjei0vCVAvLyjUCFNoOQUojJLWrAs4nnZQp3ZxJLz2H1
 Val6U2joi4djxWUVC4nqBdSsYu7gi1sMO368ER3rO5eQR8P3jJMv5q2oTVo9q8G6FHh3f7gDqMB
 e+xz+9P58vsuLw8VLBPYocAAL8S2MdOlSLmghouTNUlDoKyQK8G9dwIYdI5M0s=
X-Google-Smtp-Source: AGHT+IG/MOJFKipQrYvwc12bg6JIj6eFzl6NstUgbMVwBtLOjNuFu85CZpcU6vLQF/JGQUNV9MvbCw==
X-Received: by 2002:a05:6a20:43a7:b0:1e0:be48:1797 with SMTP id
 adf61e73a8af0-1e16539f33emr8937854637.3.1733317106835; 
 Wed, 04 Dec 2024 04:58:26 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701d097sm1329199a91.13.2024.12.04.04.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 04:58:26 -0800 (PST)
Message-ID: <5414d5ae-0036-4b83-a14b-3ee524c4f55f@ventanamicro.com>
Date: Wed, 4 Dec 2024 09:58:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] target/riscv: add support for RV64 Xiangshan
 Nanhu CPU
To: MollyChen <xiaoou@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20241204031514.34531-1-xiaoou@iscas.ac.cn>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241204031514.34531-1-xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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

Hi,

Can you please re-send the patch rebased on top of:

https://github.com/alistair23/qemu/tree/riscv-to-apply.next

This is the branch we use to queue RISC-V patches that are pending upstreaming.


Thanks,

Daniel

On 12/4/24 12:15 AM, MollyChen wrote:
> Add a CPU entry for the RV64 XiangShan NANHU CPU which
> supports single-core and dual-core configurations. More
> details can be found at
> https://docs.xiangshan.cc/zh-cn/latest/integration/overview
> 
> Signed-off-by: MollyChen <xiaoou@iscas.ac.cn>
> ---
>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 29 +++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 62115375cd..8f6fac463c 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -49,6 +49,7 @@
>   #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
>   #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
> +#define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..738d833115 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -579,6 +579,34 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>   #endif
>   }
>   
> +static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +
> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
> +    env->priv_ver = PRIV_VERSION_1_12_0;
> +
> +    /* Enable ISA extensions */
> +    cpu->cfg.ext_zbc = true;
> +    cpu->cfg.ext_zbkb = true;
> +    cpu->cfg.ext_zbkc = true;
> +    cpu->cfg.ext_zbkx = true;
> +    cpu->cfg.ext_zknd = true;
> +    cpu->cfg.ext_zkne = true;
> +    cpu->cfg.ext_zknh = true;
> +    cpu->cfg.ext_zksed = true;
> +    cpu->cfg.ext_zksh = true;
> +    cpu->cfg.ext_svinval = true;
> +
> +    cpu->cfg.mmu = true;
> +    cpu->cfg.pmp = true;
> +
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> +#endif
> +}
> +
>   #ifdef CONFIG_TCG
>   static void rv128_base_cpu_init(Object *obj)
>   {
> @@ -2983,6 +3011,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
>       DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
>   #ifdef CONFIG_TCG
>       DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
>   #endif /* CONFIG_TCG */


