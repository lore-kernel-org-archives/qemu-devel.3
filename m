Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76FBCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 11:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vER4h-0005B9-0p; Thu, 30 Oct 2025 07:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vER4e-0005Ay-IU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:44:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vER4T-00089Z-KI
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:44:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7a59ec9bef4so1290041b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761824634; x=1762429434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZtBwzTFoA28DOTGj1siDb0KDV+QHNz5oQKilWDAhNo=;
 b=GvqUwJOgCb82LbM7jAYDj6weXF8uN8bqPEb68VKoVH4FXwsGNzmyIOaXf5X4+PGZty
 rv2kMjJeDCo79voCo6sTJAkbRW4DQbBjpwrg27lLu5+b4XLNRpag3e7sZ/qL19+6v2Yp
 /lthpVa7YGmN+ltoRWJjLWrmkl4d6nHBMmHzvst26+mdxJ/P9RYMOLmOCzK7UMT2g/fF
 rNOH3rDZC/xCtuGxM2I7ETWleviztNMRqOhXD5E0wVJRCFLiuHgjDBey0y1N0PpfFRtE
 AltKttzUtaqiLInoYQLE8Jv0cM3b3S7B+8R1K4/gZ8p6ctQiW0kd91+0yM2yswxzGhpV
 0/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761824634; x=1762429434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZtBwzTFoA28DOTGj1siDb0KDV+QHNz5oQKilWDAhNo=;
 b=qw0Oi5JtQNgwytHo5o1+eaUcGnYN6VGTAZbZI2BC2M6vAALyH7bUsf71pgvwdeM/JB
 5Ea6xQKaQZLgUZORBNbwS8TksrMTAoQ7RMmXHUp9rer6ifZJUnG8RcqQubmlcvNmec54
 6KjaYhIJgUsVmVItrnTZy++a7JgawA6CGTg/Canab6YK0zG/NNZRpzolnJTTwCj5mNWp
 yW9E2s1H4WAH0Gk2YgL5q6Y0sV9jO5KgF2iQ0E149XSuY6bdA61JxJhqHXqk9gGsMygA
 jYbruQVV1jO1lpuyU6wYGSQTw56WzADpDci1Mqrr8C4iWjArFPsYjISdQAeCLJRQWefQ
 QshQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf33I1KdO7vmq9NABwkAX0XdPb9Lm9U84l60/9Zqv/ok9BOFf0H2tnGfSEtVfKbQmmySPLSMi59xoe@nongnu.org
X-Gm-Message-State: AOJu0Yw9KkTWEeUqOgFHf832SuTrFeSBBorBkl+JaU+Pz0JzIxkLD5FD
 lciLDMvW9cus69FgbNzTAOxj1J4NWYx2EheOxkrasx9wDZaT3vcZtVz06p0H+0voDKc=
X-Gm-Gg: ASbGncteUUM10n+fmggrT2j0ZpZEA4vnSRFjRmCQ1kZRYMzj4K1JiIomS3Ew8HMc0fR
 u6j7cGnts3Buhx1Kl9tk8Vv96+euQbSpW3WJIMp+HeJl6Mp8UtzSjX1ydowzy682Iq0YBhoBbeX
 Il6hLkFTw8c0Y5FNPQXUKyD4sqzDNHuDd/J4JFi33TCnh8gRAULzV/8C9YSNB2o9vzI+Q9U+fC0
 LvjE1FoSorGi50GOflJseO0UC+XR4514rSl86zPyIAlV6AP/bG5F3P95v8PZ8jP5Kq7FOml2M+j
 +ArnduHtWynLRltcA0+CkYopnKxJIdZbYzpunrCHsC3DUY7BFyL5kQhfhNyHOI53b6g32ElwKSM
 rUcDJpLsRqISaJhwjPG/9CC6yEFxh9/AFX7aMCk3XxTNki2l/3rDov83KtG4ZWpSZh0+EtzJtE7
 3EqMjN0IssNcG5nc1xDSjhn9vANrgTACVWikBmLIUjDr8q0w2hAuw=
X-Google-Smtp-Source: AGHT+IFP2Az6vABUtX5OKNubvfdNC8xUjeLeelZONf/IaEeLmfb6XjDcBzkK4DNjc/LJQZ94xVwdxg==
X-Received: by 2002:a05:6300:218e:b0:341:a688:90b0 with SMTP id
 adf61e73a8af0-3465798aae2mr8638743637.1.1761824633712; 
 Thu, 30 Oct 2025 04:43:53 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc2:d3c:248f:9caf:b5f3:fc32?
 ([2804:7f0:bcc2:d3c:248f:9caf:b5f3:fc32])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b712791576dsm16478751a12.12.2025.10.30.04.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 04:43:52 -0700 (PDT)
Message-ID: <116837b3-4dbf-4d1c-81cd-c492f4f14f0f@ventanamicro.com>
Date: Thu, 30 Oct 2025 08:43:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor
 CSR hooks
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-2-michael@videogpu.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251027100938.11822-2-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Hi,

This patch, and other patches from this series, has code style issues
(indentation with TABs, missing whitespaces, etc). I advise running the
scripts/checkpatch.pl script with your patch files to check for style
problems. E.g.:

----
/scripts/checkpatch.pl 0001-target-riscv-add-NEORV32-RV32-CPU-type-and-vendor-CS.patch
ERROR: trailing whitespace
#44: FILE: target/riscv/cpu.c:248:
+    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa), $

ERROR: space required after that ',' (ctx:VxV)
#44: FILE: target/riscv/cpu.c:248:
+    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa),
                                     ^

ERROR: space required after that ',' (ctx:VxV)
#44: FILE: target/riscv/cpu.c:248:
+    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa),
                                                         ^

ERROR: code indent should never use tabs
#52: FILE: target/riscv/cpu.c:1370:
+^IMULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),$

(...)
------



On 10/27/25 7:09 AM, Michael Levit wrote:
> From: Michael <michael@videogpu.com>
> 
> Introduce NEORV32 RV32 CPU type under target/riscv, wire NEORV32 vendor ID,
> and add a vendor CSR (CSR_MXISA) guarded by mvendorid match, plus meson glue.
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 75f4e43408..a39bf853cc 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -57,6 +57,8 @@
>   #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
>   #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
> +#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
> +

There's a non-written ordering here - generic CPUs first, vendor CPUs next, host CPU
always last. If you could add NEORV32 right after CPU_IBEX that would be great.

>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..7bcf93c66c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -245,6 +245,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
>       ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
>       ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
> +    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa),

We need this array to be sorted like described in the comment above isa_edata_arr[].
For this case you need to put this new entry before 'xtheadba'.

>   
>       { },
>   };
> @@ -1366,6 +1367,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>       MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>       MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
>       MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
> +	MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
>   
>       { },
>   };
> @@ -3032,6 +3034,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.pmp_regions = 8
>       ),
>   
> +
>   #if defined(TARGET_RISCV32) || \
>       (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
> @@ -3075,6 +3078,21 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .misa_mxl_max = MXL_RV32,
>           .misa_ext = RVE
>       ),
> +	DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
> +		.misa_mxl_max = MXL_RV32,
> +        .misa_ext = RVI | RVM | RVA | RVC | RVU,
> +        .priv_spec = PRIV_VERSION_1_10_0,
> +
> +        .cfg.max_satp_mode = VM_1_10_MBARE,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.pmp = true,
> +        .cfg.pmp_regions = 16,
> +		.cfg.mvendorid = NEORV32_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs = neorv32_csr_list
> +#endif
> +    ),
>   #endif
>   
>   #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
> 
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
> 
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
> 
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
> 
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
> 
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
> 
> diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
> new file mode 100644
> index 0000000000..0cb8663436
> --- /dev/null
> +++ b/target/riscv/neorv32_csr.c
> @@ -0,0 +1,54 @@
> +/*
> + * Neorv32-specific CSR.
> + *
> + * Copyright (c) 2025 Michael Levit
> + *
> + * Author:
> + *   Michael Levit <michael@videogpu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

If you run checkpatch.pl it will inform you that we expect a copyright header with a
different format for new files. Here's an example from target/riscv.cpu-param.h


/*
  * RISC-V cpu parameters for qemu.
  *
  * Copyright (c) 2017-2018 SiFive, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */


Thanks,

Daniel


> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_vendorid.h"
> +
> +#define    CSR_MXISA    (0xfc0)
> +
> +static RISCVException smode(CPURISCVState *env, int csrno)
> +{
> +	return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +	/* We don't support any extension for now on QEMU */
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


