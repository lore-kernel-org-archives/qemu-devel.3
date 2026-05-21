Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D806CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyxT-0005t2-6e; Thu, 21 May 2026 04:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPyxR-0005si-CP
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:40:45 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPyxK-0003Dd-RI
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:40:45 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso4103367eec.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779352837; x=1779957637; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mRlAVpGhqBhk1Bl74ldc1zSKU73oeYm6Y02/mNtInkU=;
 b=cF3lb1Kj0weO0i9DKWdv+WHVMIrBWJ3eqL+wZDnOc+bOE9AY+eb9G41XDO2NOmOtLl
 nbL4F/CXrNMUTbcYTYU0vwOZJ7tHK6nv2OnyBXaS1K1cZekWOd6rQEA6/+i5wCOY3xAi
 BzjBLvzLiRSEwm/iwRLGzMmnU3YfpduqSZ3g09Mw9o7AfcVfsEML1bKgKMv6xdt4mV/W
 KUITaeP41jTXgC9tmisviEL6oCD49TNuhZO3ofK1oza87fLDJOiumbF1yz5LT5QWvYbp
 5C5P/WpwZ1IFu/awTwsS3aX+C7L1gCKatzVmxUfGZYDQHGXlEJ8j7wBKmgmmMT4hoQE4
 lSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352837; x=1779957637;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mRlAVpGhqBhk1Bl74ldc1zSKU73oeYm6Y02/mNtInkU=;
 b=FMaJxtu8i9aHQIlNcvYB+Orom+ODbT7ZYpr3/KuSaRLCii1DAuQ4o7zJ8pxi8kHycv
 RG0ceXSu5vfrOqKUnGK7ibX9hGSsatXAfT4tk7kgfQUeWJwNSWBUO2Xmv7Q4D/tqDG74
 ehdl10eO/Ew6z0I2M1hQY7u/j8ncNRraOc7kwQfUt6pXEIeycLBvIocrGF1L+BPzv5Tm
 BIXZ3I8SpSc7m9c+wApzBApTK7O8n+IG8MRC9sw1dENDEq1sNZCUzzg6ANGc0i9jibRU
 zYpABIbMsCfZivQ2rQN1+GrfDpz9DRPW0YIQsobAHImqwS1zG6m1Aob6DHL4k1Snz+tI
 b1zQ==
X-Gm-Message-State: AOJu0YyJc/VZ9unIw6SWJgpR68SZEQCH8+mZ01eW9zRsIFKZUlEgSFKN
 7U1g9ixYMOSE0U9ihp3v7XAnXPEmP2zEYnrgcq+bTH3gMtoM00zv/9hx
X-Gm-Gg: Acq92OEueHkBvLLdXNzu3B9NPlWE3SYYCDZqSyL/XQBRhq8DhLB9tM+2vqCaijHoug2
 Kc04q+gSK4RXdOvvdRHsWFMIcNO8YAsjUIppbgr6eb9vhjX5bC/KVAPXcZtKEjT9kiVaL9J1luU
 P/CLsrRcYgByUic8PLbyplsUsqqhtzb4XjDvPB9qGpDGC0MjKk1/eaInQlzfL8RiisQS7w+3Ben
 EEpKhvkw8losRuNzNQ0r4ORn+v1vCQBQgoDQmWYTN2HR6fS46emB2DkmshcDZyFBcQdNihZycG2
 GrJDD1cnHVWVRT8YTJYi+WMBbJ8MJYajGQiJh1qlFTAQ4x+aEaYjnM52+FmbkmcL2X9XSR0J9rG
 8E4/sdiVixsxRs3lY8hJdjew7RzhgzwZAoJRBVrJ7toe5VOBLJVriipRQ24n5Gpd7fnf45oC4Hl
 y/GwcVhFo7psDoF3r3rdXa+NA9mbu4Dpo06p+BxPbgCA81gIH7sqGndawvdLQ=
X-Received: by 2002:a05:693c:300f:b0:2f2:5c68:5052 with SMTP id
 5a478bee46e88-3042f488615mr977746eec.13.1779352836887; 
 Thu, 21 May 2026 01:40:36 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm19990685eec.21.2026.05.21.01.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:40:36 -0700 (PDT)
Date: Thu, 21 May 2026 16:40:34 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Subject: Re: [PATCH v3 13/14] hw/riscv: Define SiFive E/U CPUs using runtime
 conditions
Message-ID: <ag7E9zgfYPOX9oob@ChaodeMacBook-Pro.local>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-13-d1123ea63d9c@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-13-d1123ea63d9c@rev.ng>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 20, 2026 at 03:13:05PM +0800, Anton Johansson via wrote:
> Macros are removed and replaced with inlined ternary statements.  The
> now empty sifive_cpu.h header is then removed.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  include/hw/riscv/sifive_cpu.h | 31 -------------------------------
>  include/hw/riscv/sifive_e.h   |  1 -
>  include/hw/riscv/sifive_u.h   |  1 -
>  hw/riscv/sifive_e.c           |  3 ++-
>  hw/riscv/sifive_u.c           |  7 +++++--
>  5 files changed, 7 insertions(+), 36 deletions(-)
> 
> diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
> deleted file mode 100644
> index 136799633a..0000000000
> --- a/include/hw/riscv/sifive_cpu.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/*
> - * SiFive CPU types
> - *
> - * Copyright (c) 2017 SiFive, Inc.
> - * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2 or later, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#ifndef HW_SIFIVE_CPU_H
> -#define HW_SIFIVE_CPU_H
> -
> -#if defined(TARGET_RISCV32)
> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
> -#elif defined(TARGET_RISCV64)
> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
> -#endif
> -
> -#endif /* HW_SIFIVE_CPU_H */
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 4cf902ebc0..0f0d407d5d 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -20,7 +20,6 @@
>  #define HW_SIFIVE_E_H
>  
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/sifive_cpu.h"
>  #include "hw/gpio/sifive_gpio.h"
>  #include "hw/misc/sifive_e_aon.h"
>  #include "hw/core/boards.h"
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index e4c9860d50..bfaaf254af 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -24,7 +24,6 @@
>  #include "hw/dma/sifive_pdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/sifive_cpu.h"
>  #include "hw/gpio/sifive_gpio.h"
>  #include "hw/misc/sifive_u_otp.h"
>  #include "hw/misc/sifive_u_prci.h"
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 71925583bd..76505fdc4d 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -151,7 +151,8 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
>      mc->desc = "RISC-V Board compatible with SiFive E SDK";
>      mc->init = sifive_e_machine_init;
>      mc->max_cpus = 1;
> -    mc->default_cpu_type = SIFIVE_E_CPU;
> +    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_E51
> +                                              : TYPE_RISCV_CPU_SIFIVE_E31;
>      mc->default_ram_id = "riscv.sifive.e.ram";
>      mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
>  
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6a637e3b86..b1f5bad8aa 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -723,7 +723,8 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
>      mc->init = sifive_u_machine_init;
>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> -    mc->default_cpu_type = SIFIVE_U_CPU;
> +    mc->default_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_U54
> +                                              : TYPE_RISCV_CPU_SIFIVE_U34;
>      mc->default_cpus = mc->min_cpus;
>      mc->default_ram_id = "riscv.sifive.u.ram";
>      mc->auto_create_sdcard = true;
> @@ -756,6 +757,8 @@ type_init(sifive_u_machine_init_register_types)
>  static void sifive_u_soc_instance_init(Object *obj)
>  {
>      SiFiveUSoCState *s = RISCV_U_SOC(obj);
> +    const char *e_cpu_type = (target_riscv64()) ? TYPE_RISCV_CPU_SIFIVE_E51
> +                                                : TYPE_RISCV_CPU_SIFIVE_E31;
>  
>      object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
>      qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
> @@ -764,7 +767,7 @@ static void sifive_u_soc_instance_init(Object *obj)
>                              TYPE_RISCV_HART_ARRAY);
>      qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
>      qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
> -    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", SIFIVE_E_CPU);
> +    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type", e_cpu_type);
>      qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", 0x1004);
>  
>      object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
> 
> -- 
> 2.52.0
> 
> 

