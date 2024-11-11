Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFFD3ABF4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 21:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcLN-000342-Mo; Mon, 11 Nov 2024 16:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAcLM-00033g-LZ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 16:53:08 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAcLJ-0002xR-Cl
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 16:53:08 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-720aa3dbda5so3528540b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731361984; x=1731966784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9oS8SQgfl29181tXJY3a64I+ZdgAM/IWV0LN3rBYrz0=;
 b=Fw/B+fILCEFhQ9aKqrHw7yWxvw7wSvOJzx3RKpBWv9RRB2DD/wsoXaDwf6ya1M6g2D
 UXL34GdCvlSEul7d/QEsRbevJxZxYAt0QXyGbNI6koaHucElBj4p9NHOURyXojK0r0Nj
 d1EjlwMRdMzve8OqWbIUVtBZSvOukDwOPzmEkG5LPBD2pXLqnFBQtpPL8Ivn8lCN1D+3
 7jGB9NxFFT4go+mCCVLDJCbK27li0R9sbBBo7H5tIE2h9OFNU90YiqXYm4rX0kpQ8uP/
 4AC/kDnQ4zBS4kE0dTpnVX5G+jK5n8g8mOdoMbELU1X/pL433BWYcixommoLf3qxv22b
 64fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731361984; x=1731966784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9oS8SQgfl29181tXJY3a64I+ZdgAM/IWV0LN3rBYrz0=;
 b=qSwC7gTJRnGl37/Tt392pbov+UgGl0FL/rpIEwuZhUtX7MzOUxlH4YJaXyuQEC8LRA
 wgvMx847p2SsPIiQ1S9ckSFysQ4OBIAYFGwZMhSfWPXepO+IJzmBN4UlM6h0qFh3Vwwf
 bc8qa8s+RXCa9299WCp8DfO9UmjcZjLybaHRknw2xB8CZpiexH5VFUdXOmyEn7prtD8k
 M2J90r8LCFPn03IT5CO+nbM3VWwZxysgCIlqyOoIh0r8RzKzazXDWmRwTehAk/8iwzdy
 A5O3w4c55pQ2QWZkIR1fvgnR2YVzRy7jdJVi4msPN82eTW33XoEbtYmYbSUsjQGCFW8q
 cn6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgxGy3B3kheYtiMSresHeO/4mufwsKL/BAu7t4XPpC9xbKvQM6lEq3RWhd97drztM36r4A4QFaoIm@nongnu.org
X-Gm-Message-State: AOJu0Yy/lNdzzAK8qvvT6uTUjh+c1SQirAn7/NJN0+yn2BOJHHQjQI+p
 Dqk6BLLTHfzL/XTL36YTKoMXSJc10V4htHYf7KFQ9CMVdwLMQ3TIxXr9mwW8dOg=
X-Google-Smtp-Source: AGHT+IGomwAB47QO8F8+edf9Gn2IMmtfsNnMZd8Npt64vFrxrLQW6Nw4KpBIbKpQ67kw5CITNoJP6g==
X-Received: by 2002:a05:6a00:a0f:b0:71e:658f:c43b with SMTP id
 d2e1a72fcca58-7244a4fde8emr734668b3a.2.1731361983754; 
 Mon, 11 Nov 2024 13:53:03 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240785ffaasm9718051b3a.4.2024.11.11.13.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 13:53:03 -0800 (PST)
Message-ID: <484d7570-7425-4bb1-adcd-c59c233c6893@ventanamicro.com>
Date: Mon, 11 Nov 2024 18:52:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241108070454.12699-1-jim.shu@sifive.com>
 <20241108070454.12699-2-jim.shu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108070454.12699-2-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 11/8/24 4:04 AM, Jim Shu wrote:
> Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
> system doesn't have 32-bit addressable issue, we just load DTB to the end
> of dram in 64-bit system.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/riscv/boot.c            | 8 ++++++--
>   hw/riscv/microchip_pfsoc.c | 4 ++--
>   hw/riscv/sifive_u.c        | 4 ++--
>   hw/riscv/spike.c           | 4 ++--
>   hw/riscv/virt.c            | 2 +-
>   include/hw/riscv/boot.h    | 2 +-
>   6 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 2e319168db..4e4e106a2b 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -293,7 +293,7 @@ out:
>    * The FDT is fdt_packed() during the calculation.
>    */
>   uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> -                                MachineState *ms)
> +                                MachineState *ms, RISCVHartArrayState *harts)
>   {
>       int ret = fdt_pack(ms->fdt);
>       hwaddr dram_end, temp;
> @@ -321,7 +321,11 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
>        * Thus, put it at an 2MB aligned address that less than fdt size from the
>        * end of dram or 3GB whichever is lesser.
>        */
> -    temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
> +    if (!riscv_is_32bit(harts)) {
> +        temp = dram_end;
> +    } else {
> +        temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
> +    }

We'll need to update the comment right before this code given that we're
changing the logic for 64 bit CPUs. Thanks,


Daniel

>   
>       return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
>   }
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index f9a3b43d2e..ba8b0a2c26 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -519,7 +519,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>       bool kernel_as_payload = false;
>       target_ulong firmware_end_addr, kernel_start_addr;
>       uint64_t kernel_entry;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>       DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
>   
>       /* Sanity check on RAM size */
> @@ -625,7 +625,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>           /* Compute the fdt load address in dram */
>           fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
>                                                  memmap[MICROCHIP_PFSOC_DRAM_LO].size,
> -                                               machine);
> +                                               machine, &s->soc.u_cpus);
>           riscv_load_fdt(fdt_load_addr, machine->fdt);
>   
>           /* Load the reset vector */
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c5e74126b1..05467e833a 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -519,7 +519,7 @@ static void sifive_u_machine_init(MachineState *machine)
>       const char *firmware_name;
>       uint32_t start_addr_hi32 = 0x00000000;
>       int i;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>       uint64_t kernel_entry;
>       DriveInfo *dinfo;
>       BlockBackend *blk;
> @@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *machine)
>   
>       fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
>                                              memmap[SIFIVE_U_DEV_DRAM].size,
> -                                           machine);
> +                                           machine, &s->soc.u_cpus);
>       riscv_load_fdt(fdt_load_addr, machine->fdt);
>   
>       if (!riscv_is_32bit(&s->soc.u_cpus)) {
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index fceb91d946..acd7ab1ae1 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -201,7 +201,7 @@ static void spike_board_init(MachineState *machine)
>       hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
>       target_ulong kernel_start_addr;
>       char *firmware_name;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>       uint64_t kernel_entry;
>       char *soc_name;
>       int i, base_hartid, hart_count;
> @@ -317,7 +317,7 @@ static void spike_board_init(MachineState *machine)
>   
>       fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
>                                              memmap[SPIKE_DRAM].size,
> -                                           machine);
> +                                           machine, &s->soc[0]);
>       riscv_load_fdt(fdt_load_addr, machine->fdt);
>   
>       /* load the reset vector */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 45a8c4f819..761bce3304 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1424,7 +1424,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
>   
>       fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
>                                              memmap[VIRT_DRAM].size,
> -                                           machine);
> +                                           machine, &s->soc[0]);
>       riscv_load_fdt(fdt_load_addr, machine->fdt);
>   
>       /* load the reset vector */
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index f778b560de..34a80c5ff4 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -49,7 +49,7 @@ target_ulong riscv_load_kernel(MachineState *machine,
>                                  bool load_initrd,
>                                  symbol_fn_t sym_cb);
>   uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
> -                                MachineState *ms);
> +                                MachineState *ms, RISCVHartArrayState *harts);
>   void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
>   void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
>                                  hwaddr saddr,

