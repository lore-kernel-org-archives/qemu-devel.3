Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA18C61DE5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 12:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtmEm-0001CN-4P; Sat, 21 Feb 2026 07:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtmEk-0001C0-Sh
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:37:30 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtmEi-0007sd-T1
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:37:30 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-896f5af3d8aso42435696d6.1
 for <qemu-devel@nongnu.org>; Sat, 21 Feb 2026 04:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1771677448; x=1772282248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CEH12AtF9HPz0wJRDSQzSQPnGrKGrxPPiUk+KjVgvpI=;
 b=ISM2igSb4U7aAoYxQkErHstmz2tqL+2zvXjX1PstLSggItNmxLs2z6YQ6u0HR6m72t
 Yz7WxQzgy1QPxqwUSiveM55bCDLDNDzonvNCiIqEOS8zSRYnvr6JAAUaFi2tu89V7tkl
 mz2GpuUXUukiHGh/7xEdIiBUeTOXlEMtDF4HNtZ9uK01hKWBjTqV6UBeNJnlTsMM3Has
 R1T0Krm3gGU0nWdrIui1UgMq4Nc+KwXFe5z4KwahiIyQk7ovGa1lzayLOU3gJjOLNyl7
 HCNDwT97M8oJJUMQeJoEAVgeWTbFBOw/VHBNQixQH9TTBh9biIzgrrGk96icuz3anZi+
 /5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771677448; x=1772282248;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEH12AtF9HPz0wJRDSQzSQPnGrKGrxPPiUk+KjVgvpI=;
 b=mLrB8LDzU9VzkVyaJTwkNG7yC52Xdx4CdyQ/uagtM/TfrIvxnbezvI1G3hjcxU5auA
 KuhnskAOjBBjGsNsMqw5MI8Q5+t55sk6bFHPzygzRTBNfLBL3rF3OjkEcpHpp6FQ7lbz
 BTxsefxyKPGxxv2pF5/b4Skn1e64HGVeFJoYwSNyrLzE59FGaGg55dnU7dF5eYM/w8oV
 2/sG0WuR2wb6NzEwwxdmL2HNvzDS/esZZeB/3NrpJVY+EXsTNLwEYEoxD1OELV8nJa2E
 CU6LSJ5VVM7MVudPJwp3eYS/wzxHA2y/RqXed24Ak6IITanhLdfhrhO3vxVfsB8qninJ
 T3eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa2djihC3xhJEGuQrk+bdYYNoHZeLW0z5o7G/AZnKiFEmp06riUPrFH48AG2kryQL0j0ayFuyfMRub@nongnu.org
X-Gm-Message-State: AOJu0Yy2AuThIPQBagUme/2WKaP3EjHKzT7gZ2iM34NSl0pBl6e+YIzC
 IU4s3tzwTTcwKA5VHvPCZVzbMdaMI7BMIT+lICLyG0MWWzIb53Mrj18eUQRM9z7Kglk=
X-Gm-Gg: AZuq6aLD/3n8hZUxqTVA79NXDjlpMt/k3BnsBWY6L+FxyjUv+P6TAZggtwLbs4l7C7O
 vQlt/f5yNVAvx9HYQBb8VUPioEBQVTk+/HOuvLNFRkuMR54MW2DShHe97UFqtegFUMA5ZC8r+KX
 sV3B/eFCZ/b24DqGy309hL5esSVcOla7BI7vRgteF4NAP0BnKadXAaAuMVxgEgOBxHl7DHMvg8L
 9f55xrko2v3yEtmT+gv5Q0R1pvO8RiXOjiaIqUOr6ZAmIoooXwLpldOj9CwHv35GcIOiqqI/rRL
 Tu2a5aN2/WAZvKETt1liImgdCku1Y+SG+mRcw0cbEYYCHayKulzoqW1kG5qDCrCjtbRo3jZTYgd
 Q5gyB0vOafgkGkKR3jEHK4V7ExnjYemA/STALZxiMHPtP3U0HMl5r+AP8/NbVtZAA9Tv8/s7lm7
 IEfuVLsiicOV1Fs3P3BlwRZMEH3Jp2HALn9wubMu3Tu31vnYqH6A==
X-Received: by 2002:a05:6214:268a:b0:896:f320:b189 with SMTP id
 6a1803df08f44-89979c41fc6mr50892756d6.10.1771677447937; 
 Sat, 21 Feb 2026 04:37:27 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997c6b6af6sm17225096d6.12.2026.02.21.04.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Feb 2026 04:37:27 -0800 (PST)
Message-ID: <86208284-b07c-46d6-9010-896bc8ad149c@ventanamicro.com>
Date: Sat, 21 Feb 2026 09:37:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/50] target/riscv: Extract monitor-related code to
 monitor.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-7-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260219191955.83815-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf2a.google.com
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



On 2/19/2026 4:19 PM, Philippe Mathieu-Daudé wrote:
> Keep riscv-qmp-cmds.c for QMP, use monitor.c for HMP.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/monitor.c        | 148 +++++++++++++++++++++++++++++++++
>   target/riscv/riscv-qmp-cmds.c | 150 ----------------------------------
>   2 files changed, 148 insertions(+), 150 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 478fd392ac6..ccb7eb44d02 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -19,6 +19,8 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/ctype.h"
> +#include "qemu/qemu-print.h"
>   #include "cpu.h"
>   #include "cpu_bits.h"
>   #include "monitor/monitor.h"
> @@ -241,3 +243,149 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>   
>       mem_info_svxx(mon, env);
>   }
> +
> +/*
> + * We have way too many potential CSRs and regs being added
> + * regularly to register them in a static array.
> + *
> + * Declare an empty array instead, making get_monitor_def() use
> + * the target_get_monitor_def() API directly.
> + */
> +const MonitorDef monitor_defs[] = { { } };
> +const MonitorDef *target_monitor_defs(void)
> +{
> +    return monitor_defs;
> +}
> +
> +static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
> +                                 target_ulong *val, bool is_gprh)
> +{
> +    const char * const *reg_names;
> +    target_ulong *vals;
> +
> +    if (is_gprh) {
> +        reg_names = riscv_int_regnamesh;
> +        vals = env->gprh;
> +    } else {
> +        reg_names = riscv_int_regnames;
> +        vals = env->gpr;
> +    }
> +
> +    for (int i = 0; i < 32; i++) {
> +        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
> +
> +        g_assert(reg_name[0]);
> +        g_assert(reg_name[1]);
> +
> +        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
> +            g_ascii_strcasecmp(reg_name[1], name) == 0) {
> +            *val = vals[i];
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
> +{
> +    if (qemu_tolower(name[0]) != 'f') {
> +        return false;
> +    }
> +
> +    for (int i = 0; i < 32; i++) {
> +        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
> +
> +        g_assert(reg_name[0]);
> +        g_assert(reg_name[1]);
> +
> +        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
> +            g_ascii_strcasecmp(reg_name[1], name) == 0) {
> +            *val = env->fpr[i];
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static bool reg_is_vreg(const char *name)
> +{
> +    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
> +        return false;
> +    }
> +
> +    for (int i = 0; i < 32; i++) {
> +        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
> +{
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +    target_ulong val = 0;
> +    uint64_t val64 = 0;
> +    int i;
> +
> +    if (reg_is_ulong_integer(env, name, &val, false) ||
> +        reg_is_ulong_integer(env, name, &val, true)) {
> +        *pval = val;
> +        return 0;
> +    }
> +
> +    if (reg_is_u64_fpu(env, name, &val64)) {
> +        *pval = val64;
> +        return 0;
> +    }
> +
> +    if (reg_is_vreg(name)) {
> +        if (!riscv_cpu_cfg(env)->ext_zve32x) {
> +            return -EINVAL;
> +        }
> +
> +        qemu_printf("Unable to print the value of vector "
> +                    "vreg '%s' from this API\n", name);
> +
> +        /*
> +         * We're returning 0 because returning -EINVAL triggers
> +         * an 'unknown register' message in exp_unary() later,
> +         * which feels ankward after our own error message.
> +         */
> +        *pval = 0;
> +        return 0;
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
> +        RISCVException res;
> +        int csrno = i;
> +
> +        /*
> +         * Early skip when possible since we're going
> +         * through a lot of NULL entries.
> +         */
> +        if (csr_ops[csrno].predicate == NULL) {
> +            continue;
> +        }
> +
> +        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
> +            continue;
> +        }
> +
> +        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
> +
> +        /*
> +         * Rely on the smode, hmode, etc, predicates within csr.c
> +         * to do the filtering of the registers that are present.
> +         */
> +        if (res == RISCV_EXCP_NONE) {
> +            *pval = val;
> +            return 0;
> +        }
> +    }
> +
> +    return -EINVAL;
> +}
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index d5e9bec0f86..8a1856c50e0 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -31,10 +31,6 @@
>   #include "qapi/qobject-input-visitor.h"
>   #include "qapi/visitor.h"
>   #include "qom/qom-qobject.h"
> -#include "qemu/ctype.h"
> -#include "qemu/qemu-print.h"
> -#include "monitor/hmp.h"
> -#include "monitor/hmp-target.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "cpu-qom.h"
> @@ -244,149 +240,3 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>   
>       return expansion_info;
>   }
> -
> -/*
> - * We have way too many potential CSRs and regs being added
> - * regularly to register them in a static array.
> - *
> - * Declare an empty array instead, making get_monitor_def() use
> - * the target_get_monitor_def() API directly.
> - */
> -const MonitorDef monitor_defs[] = { { } };
> -const MonitorDef *target_monitor_defs(void)
> -{
> -    return monitor_defs;
> -}
> -
> -static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
> -                                 target_ulong *val, bool is_gprh)
> -{
> -    const char * const *reg_names;
> -    target_ulong *vals;
> -
> -    if (is_gprh) {
> -        reg_names = riscv_int_regnamesh;
> -        vals = env->gprh;
> -    } else {
> -        reg_names = riscv_int_regnames;
> -        vals = env->gpr;
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
> -
> -        g_assert(reg_name[0]);
> -        g_assert(reg_name[1]);
> -
> -        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
> -            g_ascii_strcasecmp(reg_name[1], name) == 0) {
> -            *val = vals[i];
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
> -{
> -    if (qemu_tolower(name[0]) != 'f') {
> -        return false;
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
> -
> -        g_assert(reg_name[0]);
> -        g_assert(reg_name[1]);
> -
> -        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
> -            g_ascii_strcasecmp(reg_name[1], name) == 0) {
> -            *val = env->fpr[i];
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -static bool reg_is_vreg(const char *name)
> -{
> -    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
> -        return false;
> -    }
> -
> -    for (int i = 0; i < 32; i++) {
> -        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
> -{
> -    CPURISCVState *env = &RISCV_CPU(cs)->env;
> -    target_ulong val = 0;
> -    uint64_t val64 = 0;
> -    int i;
> -
> -    if (reg_is_ulong_integer(env, name, &val, false) ||
> -        reg_is_ulong_integer(env, name, &val, true)) {
> -        *pval = val;
> -        return 0;
> -    }
> -
> -    if (reg_is_u64_fpu(env, name, &val64)) {
> -        *pval = val64;
> -        return 0;
> -    }
> -
> -    if (reg_is_vreg(name)) {
> -        if (!riscv_cpu_cfg(env)->ext_zve32x) {
> -            return -EINVAL;
> -        }
> -
> -        qemu_printf("Unable to print the value of vector "
> -                    "vreg '%s' from this API\n", name);
> -
> -        /*
> -         * We're returning 0 because returning -EINVAL triggers
> -         * an 'unknown register' message in exp_unary() later,
> -         * which feels ankward after our own error message.
> -         */
> -        *pval = 0;
> -        return 0;
> -    }
> -
> -    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
> -        RISCVException res;
> -        int csrno = i;
> -
> -        /*
> -         * Early skip when possible since we're going
> -         * through a lot of NULL entries.
> -         */
> -        if (csr_ops[csrno].predicate == NULL) {
> -            continue;
> -        }
> -
> -        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
> -            continue;
> -        }
> -
> -        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
> -
> -        /*
> -         * Rely on the smode, hmode, etc, predicates within csr.c
> -         * to do the filtering of the registers that are present.
> -         */
> -        if (res == RISCV_EXCP_NONE) {
> -            *pval = val;
> -            return 0;
> -        }
> -    }
> -
> -    return -EINVAL;
> -}


