Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C307BC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 20:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSjUh-0003zO-Qn; Wed, 24 Jan 2024 15:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSjUe-0003yf-Mg
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:05:05 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSjUb-0005ql-J2
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:05:03 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6da6b0eb2d4so3537469b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706126700; x=1706731500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufCY0AAmz/4tktcOfiZ5D1L5DiTbXWNKw8c6EmdNcV8=;
 b=oIrvgI59tznWwJLAPYmrd5O60/tR7qSXGsUC9ymavRAoVZtxCNYLHUZvEOQpFNlCQs
 ztwwkgAsFgXkA/rSJYqZtwBAsfFLT5vuezmpHZO82eizO43iR2sKaKe80/VvcjSgbLDp
 +atLmc4PSrjQabCrU7xjtmyvtLFEdS9eNQgzlBAZj9PYYnz5i+Y8AfoWS/NlliXEOXOL
 XloRqeFw1WHP2LDcHihqM523BvTEhfjepZN/1URTeHpPacchvW5mvpf5TYLpa57HNIXB
 1zk0BEG4GQZ0JyHEl5E2k6CPE7slEacizpXSS8tzPH3rJDx+5dEBTNiB0FX2IhPcz90J
 5gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706126700; x=1706731500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufCY0AAmz/4tktcOfiZ5D1L5DiTbXWNKw8c6EmdNcV8=;
 b=B32YSps9VSJZmNzKQt5Zhwz6WEkpO3nIUOfjA894t+7zsY9Il9oF6KUsSdJStZnj10
 DNevUr8KPzMoBn2av7fvxvYies2af92lYqlh3m6u7wCBtMUs1wHNmQm+yinymV7kQKpd
 ToHiU9hVatzLQmaOPYNx/j27ego4GT38aSJYZFTM4fKRtBYrjSgyN7syka1vqd/T5Gmb
 iMM6qHIwzavqg4hyJUdaPL3PeQDlXADddH8xX2ucAMjS3QuoeYwmCmX07C+iXJJKPS2J
 PKsyG9E1inSVhQ+dyJ+ipmYfISsgQLF3FeUMX3E/0OpLrYH11E/k6Qbsz2P1GtU7mODQ
 0pOQ==
X-Gm-Message-State: AOJu0YyraofcbKstzhsdOMi97YEJaefegTR+fesL/DBa6cnbQnuLE9z9
 rTOyyIqRLS7hoMiIPfKz8hA5PIpnxzCq1ABboVZgGuJXByAN3HJzzus8n4+jVQY=
X-Google-Smtp-Source: AGHT+IFgJOK1Uh5w8jIM1aKAeqj+DcEljB1LjrjEp4ODIPUNlGuauEmk7mdkvYY8mJo2he6V2VhWJw==
X-Received: by 2002:a62:61c6:0:b0:6db:9e9f:6a55 with SMTP id
 v189-20020a6261c6000000b006db9e9f6a55mr69526pfb.25.1706126698730; 
 Wed, 24 Jan 2024 12:04:58 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.94])
 by smtp.gmail.com with ESMTPSA id
 i192-20020a639dc9000000b005d6323da62esm14262pgd.84.2024.01.24.12.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 12:04:58 -0800 (PST)
Message-ID: <3163691b-89a6-4205-9ffa-076f1352bcd8@ventanamicro.com>
Date: Wed, 24 Jan 2024 17:04:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/riscv: support new isa extension detection
 devicetree properties
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, qemu-riscv@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Andrew Jones <ajones@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
References: <20240124-squatting-getup-a16a8499ad73@spud>
 <20240124-unvarying-foothold-9dde2aaf95d4@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240124-unvarying-foothold-9dde2aaf95d4@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/24/24 09:55, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A few months ago I submitted a patch to various lists, deprecating
> "riscv,isa" with a lengthy commit message [0] that is now commit
> aeb71e42caae ("dt-bindings: riscv: deprecate riscv,isa") in the Linux
> kernel tree. Primarily, the goal was to replace "riscv,isa" with a new
> set of properties that allowed for strictly defining the meaning of
> various extensions, where "riscv,isa" was tied to whatever definitions
> inflicted upon us by the ISA manual, which have seen some variance over
> time.
> 
> Two new properties were introduced: "riscv,isa-base" and
> "riscv,isa-extensions". The former is a simple string to communicate the
> base ISA implemented by a hart and the latter an array of strings used
> to communicate the set of ISA extensions supported, per the definitions
> of each substring in extensions.yaml [1]. A beneficial side effect was
> also the ability to define vendor extensions in a more "official" way,
> as the ISA manual and other RVI specifications only covered the format
> for vendor extensions in the ISA string, but not the meaning of vendor
> extensions, for obvious reasons.
> 
> Add support for setting these two new properties in the devicetrees for
> the various devicetree platforms supported by QEMU for RISC-V. The Linux
> kernel already supports parsing ISA extensions from these new
> properties, and documenting them in the dt-binding is a requirement for
> new extension detection being added to the kernel.
> 
> A side effect of the implementation is that the meaning for elements in
> "riscv,isa" and in "riscv,isa-extensions" are now tied together as they
> are constructed from the same source. The same applies to the ISA string
> provided in ACPI tables, but there does not appear to be any strict
> definitions of meanings in ACPI land either.
> 
> Link: https://lore.kernel.org/qemu-riscv/20230702-eats-scorebook-c951f170d29f@spud/ [0]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/riscv/extensions.yaml [1]
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/sifive_u.c |  7 ++----
>   hw/riscv/spike.c    |  6 ++---
>   hw/riscv/virt.c     |  6 ++---
>   target/riscv/cpu.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.h  |  1 +
>   5 files changed, 60 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ec76dce6c9..2f227f15bc 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -171,7 +171,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>           int cpu_phandle = phandle++;
>           nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>           char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        char *isa;
>           qemu_fdt_add_subnode(fdt, nodename);
>           /* cpu 0 is the management hart that does not have mmu */
>           if (cpu != 0) {
> @@ -180,11 +179,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>               } else {
>                   qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
>               }
> -            isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
> +            riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
>           } else {
> -            isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
> +            riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
>           }
> -        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
>           qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
>           qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
>           qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
> @@ -194,7 +192,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>           qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
>           qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
>           qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> -        g_free(isa);
>           g_free(intc);
>           g_free(nodename);
>       }
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 81f7e53aed..64074395bc 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>       MachineState *ms = MACHINE(s);
>       uint32_t *clint_cells;
>       uint32_t cpu_phandle, intc_phandle, phandle = 1;
> -    char *name, *mem_name, *clint_name, *clust_name;
> +    char *mem_name, *clint_name, *clust_name;
>       char *core_name, *cpu_name, *intc_name;
>       static const char * const clint_compat[2] = {
>           "sifive,clint0", "riscv,clint0"
> @@ -113,9 +113,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>               } else {
>                   qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
>               }
> -            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
> -            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
> -            g_free(name);
> +            riscv_isa_write_fdt(&s->soc[socket].harts[cpu], fdt, cpu_name);
>               qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
>               qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
>               qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f9fd1341fc..c47b2d397a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -215,7 +215,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>       int cpu;
>       uint32_t cpu_phandle;
>       MachineState *ms = MACHINE(s);
> -    char *name, *cpu_name, *core_name, *intc_name, *sv_name;
> +    char *cpu_name, *core_name, *intc_name, *sv_name;
>       bool is_32_bit = riscv_is_32bit(&s->soc[0]);
>       uint8_t satp_mode_max;
>   
> @@ -236,9 +236,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>               g_free(sv_name);
>           }
>   
> -        name = riscv_isa_string(cpu_ptr);
> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
> -        g_free(name);
> +        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
>   
>           if (cpu_ptr->cfg.ext_zicbom) {
>               qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4aa4b2e988..0d6000f2a8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -32,6 +32,7 @@
>   #include "hw/core/qdev-prop-internal.h"
>   #include "migration/vmstate.h"
>   #include "fpu/softfloat-helpers.h"
> +#include "sysemu/device_tree.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/tcg.h"
>   #include "kvm/kvm_riscv.h"
> @@ -2352,6 +2353,58 @@ char *riscv_isa_string(RISCVCPU *cpu)
>       return isa_str;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static char **riscv_isa_extensions_list(RISCVCPU *cpu, int *count)
> +{
> +    int maxlen = ARRAY_SIZE(riscv_single_letter_exts) + ARRAY_SIZE(isa_edata_arr);
> +    char **extensions = g_new(char *, maxlen);
> +
> +    for (int i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
> +        if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
> +            extensions[*count] = g_new(char, 2);
> +            snprintf(extensions[*count], 2, "%c",
> +                     qemu_tolower(riscv_single_letter_exts[i]));
> +            (*count)++;
> +        }
> +    }
> +
> +    for (const RISCVIsaExtData *edata = isa_edata_arr; edata->name; edata++) {
> +        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
> +            extensions[*count] = g_strdup(edata->name);
> +            (*count)++;
> +        }
> +    }
> +
> +    return extensions;
> +}
> +
> +void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
> +{
> +    const size_t maxlen = sizeof("rv128i");
> +    g_autofree char *isa_base = g_new(char, maxlen);
> +    g_autofree char *riscv_isa;
> +    char **isa_extensions;
> +    int count = 0;
> +    int xlen = riscv_cpu_max_xlen(cpu->env);
> +
> +    riscv_isa = riscv_isa_string(cpu);
> +    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
> +
> +    snprintf(isa_base, maxlen, "rv%di", xlen);
> +    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
> +
> +    isa_extensions = riscv_isa_extensions_list(cpu, &count);
> +    qemu_fdt_setprop_string_array(fdt, nodename, "riscv,isa-extensions",
> +                                  isa_extensions, count);
> +
> +    for (int i = 0; i < count; i++) {
> +        g_free(isa_extensions[i]);
> +    }
> +
> +    g_free(isa_extensions);
> +}
> +#endif
> +
>   #define DEFINE_CPU(type_name, initfn)      \
>       {                                      \
>           .name = type_name,                 \
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index aacc031397..ce03d91b01 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -517,6 +517,7 @@ bool riscv_cpu_option_set(const char *optname);
>   #define cpu_mmu_index riscv_cpu_mmu_index
>   
>   #ifndef CONFIG_USER_ONLY
> +void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename);
>   void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                        vaddr addr, unsigned size,
>                                        MMUAccessType access_type,

