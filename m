Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108DAF94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFIrn-0003Sb-Om; Tue, 21 Apr 2026 17:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFIrl-0003S0-NX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:42:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFIrj-0005jC-PF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:42:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so63700305e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776807762; x=1777412562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C6TUEyny4IJuhtMm7N5t43FrA1i9fO+v93mBZP7/xIc=;
 b=pwyhb1hIvkK3ijd8AhfN5L2a53++ltLjwzU9gADD/ivf4qXnpkjy2cg/KSJVMWrDN5
 X5PnfLbnetq+nBO7BEYd4Fwlo4QCdpTkKL63ghRF/B2sBsfWnlj7DyMvXYFim9gbKMhw
 dP9l/i08tGNYcpl3vWfHR0ofDkWq5jJ9aF2rFk7jlxQ8zPMyPSTOSMNoU+cI+HTU15L0
 ZpNgsHpb4inZ/dmwOTqjJu5CuJ/aPUHTuSRRWItd58UFBGvZaVHWnRvnEv9uckzULFLU
 Ijvt3AOSTix7HXW9yTJbnG8HLkymx8WEme1wkkRThWuAlehE+icIqO0yB/6UhSZksqks
 yZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776807762; x=1777412562;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6TUEyny4IJuhtMm7N5t43FrA1i9fO+v93mBZP7/xIc=;
 b=ry96KUlagkZ2UMQ2gRyu58yXYIPPKRrzhKg325CK/Bc1HjhFyJq1mGmE9gQlmn6n2N
 VBjPnVZjGlqurcs/va+/c8t3bzAFWYer4IhVL8rqIqvrKd9Xb7fVxfI9+Eh8xxDm3YiK
 Xdit+2TvOd8sNJkfpqvGWyETTqZPagyb6NiupdcAl0HgL5sbKON3Riec3MXO/2qxYCeu
 4DhlXK0iDWkY4BdMKUN6SQTj02FtAPRF3TuRBb6qk2aB2oXP3C8sV0PKA5IaWJ78eV7m
 J4SncuTaj0D/dTWZF1zBz8caZ5/tlhWQiL3jGWcFdYgfUjQY0sSEZNYlZCWrr32tgk9E
 f7CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/jhSuTLN5gihyvJrOH+EfqNGngXicfLsfO8qIVUYN5pCnqvzNQyWjqcMfmMZgHxIU0aQDisf6V/Yw@nongnu.org
X-Gm-Message-State: AOJu0Yy7BT1KbSlbvr78GI+lqQn7faC0dVeeZow/79BF8+kY4cUZ7vb1
 j14cqx6mmlvi99gmHtNZeAhe3NmCkR1YLFqXlBxpU9HUUk1/OxkdCh+tidVLvtv58yw=
X-Gm-Gg: AeBDiesygiX4apEMj08ILgGMKCRQK26tyRCoL8cCiJnV3comAxWMrxqfb/gHj15nGf0
 OdXeLUjh7R91LRnH2dgMIQeRTgvFOK33fKD9YWm5BvYnxPtCOA1MkgRE6f5D/nmXdikBcVFDiT8
 5nXAwIRZ4dCveVqNiPSB8b0c8q97qSfS3DaW0P6ORH8T3cz9wxLQn6CsLTWB9FmwOdfViL4V/Rj
 vBjoAOeDRpqn5hQSaB8U6Z+D1R9CFOdzISTXh++MjVi1Ae0mZJAhd2lxMFmNlGKEpUw3OjxZEO+
 1POehKspVLZCPwGfVxMW8mr34SJFuSRM4Mas99OtQiM3E3+UZhxgp6QN9ViJSrXDDV9hX4LNlA+
 TP/lCVGA42dR8Eapn/Crufw3Ma+OlAdP0Y6mlbjIxIwZCZOCjFIcMrfEL/FWDIt8ZFlhDHmPg0/
 Zxhxn/ohIg4Xdf0v8+z95n2g3DT2dCGO4o/er+F+TXkoDoCwRPeJbijaZzFZNyDOCIntM1js765
 fP0
X-Received: by 2002:a05:600c:c04a:b0:485:3cf3:1010 with SMTP id
 5b1f17b1804b1-488fb73ddefmr200321635e9.2.1776807761690; 
 Tue, 21 Apr 2026 14:42:41 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm50796675e9.2.2026.04.21.14.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 14:42:40 -0700 (PDT)
Message-ID: <1c3088c0-4388-4915-8bb3-c1f11675c093@linaro.org>
Date: Tue, 21 Apr 2026 23:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] hw/hexagon: Add machine configs for sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Markus Armbruster <armbru@redhat.com>, Mike Lambert <mlambert@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 16/4/26 23:02, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Some header includes are modified here: these are uniquely required for
> basic system emulation functionality and had not been required for linux-user.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                            |   2 +
>   include/hw/hexagon/hexagon.h           | 150 +++++++++++++++++++++++
>   hw/hexagon/machine_cfg_v66g_1024.h.inc |  64 ++++++++++
>   hw/hexagon/hexagon_dsp.c               | 161 +++++++++++++++++++++++++
>   system/qdev-monitor.c                  |   2 +-
>   target/hexagon/translate.c             |   1 +
>   hw/Kconfig                             |   1 +
>   hw/hexagon/Kconfig                     |   4 +
>   hw/hexagon/meson.build                 |   6 +
>   hw/meson.build                         |   1 +
>   10 files changed, 391 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/hexagon/hexagon.h
>   create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
>   create mode 100644 hw/hexagon/hexagon_dsp.c
>   create mode 100644 hw/hexagon/Kconfig
>   create mode 100644 hw/hexagon/meson.build
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4055fbe3c21..b9a7c553dfa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -246,6 +246,8 @@ Hexagon TCG CPUs
>   M: Brian Cain <brian.cain@oss.qualcomm.com>
>   S: Supported
>   F: target/hexagon/
> +F: hw/hexagon/
> +F: include/hw/hexagon/

IMHO long-term it is better to split architectural code from
hardware modelling in distinct MAINTAINERS sections (and distinct
set of reviewers / maintainers / lists).

>   X: target/hexagon/idef-parser/
>   X: target/hexagon/gen_idef_parser_funcs.py
>   F: linux-user/hexagon/


> +static void hexagon_common_init(MachineState *machine, Rev_t rev,
> +                                const struct hexagon_machine_config *m_cfg)
> +{
> +    MemoryRegion *address_space;
> +    MemoryRegion *sram;
> +    DeviceState *glob_regs_dev;
> +
> +    memset(&hexagon_binfo, 0, sizeof(hexagon_binfo));
> +    if (machine->kernel_filename) {
> +        hexagon_binfo.ram_size = machine->ram_size;
> +        hexagon_binfo.kernel_filename = machine->kernel_filename;
> +    }
> +
> +    machine->enable_graphics = 0;
> +
> +    address_space = get_system_memory();
> +
> +    sram = g_new(MemoryRegion, 1);
> +    memory_region_init_ram(sram, NULL, "ddr.ram",

DDRAM or SRAM?

> +        machine->ram_size, &error_fatal);
> +    memory_region_add_subregion(address_space, 0x0, sram);
> +
> +    glob_regs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
> +    qdev_prop_set_uint64(glob_regs_dev, "config-table-addr", m_cfg->cfgbase);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(glob_regs_dev), &error_fatal);
> +
> +    for (int i = 0; i < machine->smp.cpus; i++) {
> +        HexagonCPU *cpu = HEXAGON_CPU(object_new(machine->cpu_type));
> +        qemu_register_reset(do_cpu_reset, cpu);
> +
> +        /*
> +         * CPU #0 is the only CPU running at boot, others must be
> +         * explicitly enabled via start instruction.
> +         */
> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
> +        if (i == 0) {
> +            hexagon_init_bootstrap(machine, cpu);
> +            if (!qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal)) {
> +                return;
> +            }
> +        } else if (!qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal)) {
> +            return;
> +        }
> +
> +    }
> +}
> +
> +static void init_mc(MachineClass *mc)
> +{
> +    mc->block_default_type = IF_SD;

Is "By default try to boot on SD Card first" what you want?

> +    mc->default_ram_size = 4 * GiB;
> +    mc->no_parallel = 1;
> +    mc->no_floppy = 1;
> +    mc->no_cdrom = 1;
> +    mc->no_serial = 1;
> +    mc->is_default = false;
> +    mc->max_cpus = 8;
> +}


> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1ac6d9a8575..72abc9182a9 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -69,7 +69,7 @@ typedef struct QDevAlias
>                                 QEMU_ARCH_SPARC | \
>                                 QEMU_ARCH_XTENSA)
>   #define QEMU_ARCH_VIRTIO_CCW (QEMU_ARCH_S390X)
> -#define QEMU_ARCH_VIRTIO_MMIO (QEMU_ARCH_M68K)
> +#define QEMU_ARCH_VIRTIO_MMIO (QEMU_ARCH_M68K | QEMU_ARCH_HEXAGON)
>   
>   /* Please keep this table sorted by typename. */
>   static const QDevAlias qdev_alias_table[] = {
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index ae980c087f0..15258a203b3 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -32,6 +32,7 @@
>   #include "translate.h"
>   #include "genptr.h"
>   #include "printinsn.h"
> +#include "exec/target_page.h"

Rebase left-over?

>   
>   #define HELPER_H "helper.h"
>   #include "exec/helper-info.c.inc"


> diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
> new file mode 100644
> index 00000000000..f528d2bc4ab
> --- /dev/null
> +++ b/hw/hexagon/meson.build
> @@ -0,0 +1,6 @@
> +hexagon_ss = ss.source_set()
> +hexagon_ss.add(files('hexagon_tlb.c'))
> +hexagon_ss.add(files('hexagon_globalreg.c'))
> +hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c'))
> +
> +hw_arch += {'hexagon': hexagon_ss}

Better would be:

   hw_common_arch += {'hexagon': hexagon_common_ss}

Pierrick can help here!


