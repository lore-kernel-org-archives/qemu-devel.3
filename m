Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60281CCFA1C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGzKT-00010I-Q9; Thu, 06 Nov 2025 07:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGzKS-0000zj-OG
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:43:04 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGzKQ-0002Vm-Nk
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:43:04 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so535271a34.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 04:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762432981; x=1763037781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8L4HHWl5xKlF96QsmT1vm7FXuet16ligCF/DGn2KOM=;
 b=YpRaLDvXwSArZ3GFembnklff64NOPIuxEH6q2CFUG/CQZ2wDTea3E7YQYqktYltodr
 90rfG7w+rEEvJl1AHht7fy8k3eT5iY87kJNhHoznOzrRezR97vsqXxbZpYQQ3TSGUlxV
 ZlrJcCZcn6X3JoUC+BKq1MguvFAuio3PX0qfvIK0qQiXhQqH8YWV7hQJVKab3Dj1bYvy
 +S+xSud3we6m2qNM+dbrTRAI9qPZN1oRFdTN+hiLgY9DKlIWJNFpK2Zsh6Ylp3456vgf
 fSqx1tECtFeZLpBb3a0s+MaeMoZSgvwvXPJRoxWHqJA78A87SFacFINyrP/cyPrgd+o7
 w0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762432981; x=1763037781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8L4HHWl5xKlF96QsmT1vm7FXuet16ligCF/DGn2KOM=;
 b=CwMfYT+ID+VJlmvIr5t3+O1uEWyh5j6SQKpHhoQWvJBUoe/RgoE7TQsoN+KFyAiME+
 OgVNoJnc3HSGyvNd0EKQ/jVpsALkjKJtzbPla/CEm5oejSlaodk9rNN1WOKjMgHgxeen
 ZW4cF0Ojy9ah9wpyEC+5eDXeiyaOQzzlofC5kMXbafuf0Rh4asg8QVD/enNNLkNpH7bO
 O2Mi+6w/iuHjyThDgz5rJuy32P6dojduLGlQh8hePVxk8DWeVsk8grUiLAfxxrpCtkjW
 n9p+jZLhRIwE91EPBe1JklJb1ZfF3+sMgrpy9VKIgna3QhkuDwM3tKFI7b/yUmmmUzdM
 MysQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAapJtogYriknTrfZK5hjGpuSt4VVz6URO7CIcRInkLB+zdVxJH/PcIk+fMszuA0YzVSjMNv24ouP1@nongnu.org
X-Gm-Message-State: AOJu0YzVdoISTcFP5zfp4BCXnUkZk+Gln40m54RsuxfLHQlt5GNqXQJT
 q7DJLM+qusGCc200u9CfE+HvwxcHRGFKCFwZMyPlUXGB+xUoEKD5aIVMmD9RhNJl2cyywqA7MPo
 BV/NVQa0=
X-Gm-Gg: ASbGncswQ7eoBoFYQeTJFp8oCEtrIIXhKVDSvuMzohDbAZe0Y9PdI9/Quv2OqyxZ8+r
 d5HPKuXVn+dPv3LfobkZNrF5/aLNLNrZ/cOfmiZ4+7z8VbhSmDLyLet6+pmhiapi4RuyGEyHRvM
 8K8vJ9xwgWhe1wi1o3zrwG1bsmACG1hHU4Eo21QzkcJ1riPOMytKHwUna3TrapvMYkGPw/S/ki0
 yHVu0hNKZMp3sIy3N0fZgn24jFr9fsHeaL8kaqZmRzWkRRENMfYNFq0KRa+/cHbEqhbWMG5Dzos
 ZBxf2C1vWLqR5qiWSp/ACMffBQuw/GFF3A250ixUY3rlkvRtXDJnV+xv6WGf382aQumq6URGnz5
 divCfcInTsWR1+ozrZqfrBakzQ9+o6hZmouc1WT/5yH2Co9VJINgvJeekMumHodZhT1l7Q8xDfc
 j7lipFKi1DsAS41z9QYe9GjQP6
X-Google-Smtp-Source: AGHT+IFLuJ++zUSVpw33vpc9mja/7tlvKFSHEDwCUvpXExJQyOY0jPZBUUDP3pStg7iyLWHRGEzbew==
X-Received: by 2002:a05:6808:181e:b0:44f:6dcf:e9c3 with SMTP id
 5614622812f47-44fed42b920mr3817198b6e.66.1762432981209; 
 Thu, 06 Nov 2025 04:43:01 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e30857db14sm1018293fac.9.2025.11.06.04.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 04:43:00 -0800 (PST)
Message-ID: <8102ecad-fe07-4d58-9a7b-b39fa2624921@ventanamicro.com>
Date: Thu, 6 Nov 2025 09:42:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor
 CSR hooks
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251105185056.23565-1-michael@videogpu.com>
 <20251105185056.23565-2-michael@videogpu.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251105185056.23565-2-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
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



On 11/5/25 3:50 PM, Michael Levit wrote:
> From: Michael <michael@videogpu.com>
> 
> Introduce NEORV32 RV32 CPU type under target/riscv, wire NEORV32 vendor ID,
> and add a vendor CSR (CSR_MXISA) guarded by mvendorid match, plus meson glue.
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>
> ---
>   target/riscv/cpu-qom.h            |  2 ++
>   target/riscv/cpu.c                | 18 ++++++++++++++
>   target/riscv/cpu.h                |  3 +++
>   target/riscv/cpu_cfg.h            |  1 +
>   target/riscv/cpu_cfg_fields.h.inc |  1 +
>   target/riscv/cpu_vendorid.h       |  2 ++
>   target/riscv/meson.build          |  1 +
>   target/riscv/neorv32_csr.c        | 40 +++++++++++++++++++++++++++++++
>   8 files changed, 68 insertions(+)
>   create mode 100644 target/riscv/neorv32_csr.c
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..d091807160 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -43,6 +43,7 @@
>   #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>   #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>   #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
> +#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
>   #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> @@ -58,6 +59,7 @@
>   #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
> +

Extra blank line.

>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>   
>   #endif /* RISCV_CPU_QOM_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..ffe99f71e1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -233,6 +233,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
>       ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>       ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(xneorv32xisa, PRIV_VERSION_1_10_0, ext_xneorv32xisa),
>       ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>       ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>       ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1366,6 +1367,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>       MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>       MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>       MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +    MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
>   
>       { },
>   };
> @@ -3032,6 +3034,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.pmp_regions = 8
>       ),
>   
> +

Extra blank line here too.



Without the extra blank lines:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   #if defined(TARGET_RISCV32) || \
>       (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> @@ -3075,6 +3078,21 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .misa_mxl_max = MXL_RV32,
>           .misa_ext = RVE
>       ),
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max = MXL_RV32,
> +        .misa_ext = RVI | RVM | RVA | RVC | RVU,
> +        .priv_spec = PRIV_VERSION_1_10_0,
> +
> +        .cfg.max_satp_mode = VM_1_10_MBARE,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.pmp = true,
> +        .cfg.pmp_regions = 16,
> +        .cfg.mvendorid = NEORV32_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs = neorv32_csr_list
> +#endif
> +    ),
>   #endif
>   
>   #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 36e7f10037..6a9918a25a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -985,5 +985,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>   /* In th_csr.c */
>   extern const RISCVCSR th_csr_list[];
>   
> +/* Implemented in neorv32_csr.c */
> +extern const RISCVCSR neorv32_csr_list[];
> +
>   const char *priv_spec_to_str(int priv_version);
>   #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index aa28dc8d7e..9ad38506e4 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -64,5 +64,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
>   MATERIALISE_EXT_PREDICATE(xtheadmempair)
>   MATERIALISE_EXT_PREDICATE(xtheadsync)
>   MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
> +MATERIALISE_EXT_PREDICATE(xneorv32xisa)
>   
>   #endif
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecdc79..b84e1bd287 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
>   BOOL_FIELD(ext_xtheadmempair)
>   BOOL_FIELD(ext_xtheadsync)
>   BOOL_FIELD(ext_XVentanaCondOps)
> +BOOL_FIELD(ext_xneorv32xisa)
>   
>   BOOL_FIELD(mmu)
>   BOOL_FIELD(pmp)
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..66a8f30b81 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -7,4 +7,6 @@
>   #define VEYRON_V1_MIMPID        0x111
>   #define VEYRON_V1_MVENDORID     0x61f
>   
> +#define NEORV32_VENDOR_ID       0xF0000001
> +
>   #endif /*  TARGET_RISCV_CPU_VENDORID_H */
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index fdefe88ccd..44e706ad3f 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -40,6 +40,7 @@ riscv_system_ss.add(files(
>     'th_csr.c',
>     'time_helper.c',
>     'riscv-qmp-cmds.c',
> +  'neorv32_csr.c',
>   ))
>   
>   subdir('tcg')
> diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
> new file mode 100644
> index 0000000000..3b0f0cab05
> --- /dev/null
> +++ b/target/riscv/neorv32_csr.c
> @@ -0,0 +1,40 @@
> +/*
> + * NEORV32-specific CSR.
> + *
> + * Copyright (c) 2025 Michael Levit
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_vendorid.h"
> +
> +#define    CSR_MXISA    (0xfc0)
> +
> +static RISCVException smode(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    /* We don't support any extension for now on QEMU */
> +    *val = 0x00;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static bool test_neorv32_mvendorid(RISCVCPU *cpu)
> +{
> +    return cpu->cfg.mvendorid == NEORV32_VENDOR_ID;
> +}
> +
> +const RISCVCSR neorv32_csr_list[] = {
> +    {
> +        .csrno = CSR_MXISA,
> +        .insertion_test = test_neorv32_mvendorid,
> +        .csr_ops = { "neorv32.xisa", smode, read_neorv32_xisa }
> +    },
> +    { }
> +};
> +


