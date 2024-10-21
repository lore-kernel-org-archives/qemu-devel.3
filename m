Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C2BD15D90
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2sfn-0006Fu-IM; Mon, 21 Oct 2024 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t2sfg-0006Dy-OW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:42:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t2sfd-0002kD-3D
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:42:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e57d89ffaso3466384b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729518123; x=1730122923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQt4qyVQvBkSME2w7VgIQoWKRMuV3EQlOAIMaqHFXRQ=;
 b=Rm/GEoDqR7JRXr4S3RQdHYzInkFUjcLvbcxgrJbJru2nSr3Av3QwKtTx/v/f+DnSGk
 ZB2dsQjFjlCYepYFq36/xvN+HwmaZHQ01tHmRSxHa7WNynThmzlfa53xzXyO0HiK7UmW
 ZiGl1V1qJgSYGqPbdqwG0lgPsdCVtre1FZq75yjhtbXzlZp3RXrW/MeqXlGdks2xzWHh
 j1HJRuQGTlQkF/CfEPMozlWj6J4bsCcW4RdEcDWzFXStEYu7bLiKHyBAYX5rFw/kGdOl
 OMF/D5JAU6fl/MjMN3aqyWUjL9FNjOxMBZz7Wp6tMzPOnk8MeNvuuhqqeIZo7xJ1VY1c
 xjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729518123; x=1730122923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQt4qyVQvBkSME2w7VgIQoWKRMuV3EQlOAIMaqHFXRQ=;
 b=JNFb7IjoqS9vTMBAwKKSONe14gCa/fdbhcThM25gzjyZnxXUOfR5JDZ2CJKu9OE5zp
 F1nOpcxN/lEG8UE34w9/YvoYko42ChtBOBKuSVRKerMKQ34IxqIjnpHTdsN7xK17mZZC
 iHpCHlG5PRtrp1SqJv0kKbcy3TvuA5aWhFOoqvFPeZw6zNu2UKOg6R+0Ixiji0St3O0g
 skoBe+QxpqmTIRbHt+H8UHHQD5awKww+YqjYBzhyRAH3OY8jpwMDAOrNZCfsE51DxaGv
 cIhzaZR8awmsrWIVFBgswqVhe5Q4D7fwY3W0Uhxjuy52++5mKId7KcKTeMgByi4XXmbQ
 ZB3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSpmIczEv7nAHr8ajc3vI/vUqdEL/WJKqPBvOxFbUFOhamFcDCOz45Evf03kZqONoRtI6u0pSnjXjz@nongnu.org
X-Gm-Message-State: AOJu0YxxHyRXoLbUipOIPB0Xw5KJ3YDQ6Zl33O5jko3qamplyjC0zsUn
 KAs5GNs1jQlxXtMqrjYVoCJezegOoHG/JWCrRLAD48seUwVM5Q7aaDyG1oXdRyQ=
X-Google-Smtp-Source: AGHT+IGBkxsr4y7j7ew2DBoldju0CNnZxFNcnbVNwzBf5AaMYSsrq5Zx/tQhvllmF9rNqU/rldslIQ==
X-Received: by 2002:a05:6a00:3917:b0:71e:55e2:2c58 with SMTP id
 d2e1a72fcca58-71ea325b53emr15167300b3a.15.1729518123170; 
 Mon, 21 Oct 2024 06:42:03 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13eaae6sm2932045b3a.144.2024.10.21.06.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 06:42:02 -0700 (PDT)
Message-ID: <7a631349-accf-49b0-a679-f62b1cfb4b1c@ventanamicro.com>
Date: Mon, 21 Oct 2024 10:41:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241021040942.400-1-jim.shu@sifive.com>
 <20241021040942.400-2-jim.shu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241021040942.400-2-jim.shu@sifive.com>
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



On 10/21/24 1:09 AM, Jim Shu wrote:
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
> index 9115ecd91f..ad45bd7a6a 100644
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

I think it's a fine idea to do a different computation if we're running a 64 bit
CPU but this alone won't fix the issue you're reporting.

Running a 64-bit CPU does not guarantee that 'dram_end' will be enough to fit
kernel+initrd and the fdt. There's no correlation between running 64 bits and having
enough RAM to fit everything, i.e. you can run a 64-bit CPU with short RAM and end
up with the same problem. There's also the board mem topology to account for: the
Microchip board will always use a 1GB ram bank ('dram_end' will be always 1Gb max)
running 32 or 64 bit CPUs.

It seems that we also need to consider the end of kernel+initrd to properly tune
where to put the fdt, erroring out if we don't have enough size for everything.
This would make the logic work regardless of the word size of the CPU.

This information is calculated in riscv_load_kernel(), which is currently
returning only the kernel start addr.  We have the information we need written in
the FDT as "/chosen/linux,initrd-end" but that isn't enough because this attribute
is written only if we have an initrd. We would hit the same problem again if we
have a big enough kernel in an low enough RAM env.

First thing that comes to mind is to use an abstraction like

typedef struct RISCVBootProps {
     uint64_t kernel_start;
     uint64_t kernel_end;
     bool is_64bit;
} RISCVKernelProps;

And use it to allow riscv_load_kernel() to write both kernel_start (the current
return value) and kernel_end (that can be either kernel_start + kernel_size or,
if we have an initrd, the value written in linux,initrd-end). riscv_compute_fdt_addr()
would then use this as an extra arg and then we have the 'kernel_end' value to
calculate the fdt_addr too.



In fact, I think this can be further extended to fully encapsulate the boot process
of all boards, that are kind of doing the same thing with all these helpers, into a
single 'super function' that would receive a struct like the one from above (with
more properties), setting all the boot parameters the board needs, pass it to a single
function that does everything and just use the result as each board wants. This
is something that we might play around with but it'll be something for the next
release.


Thanks,

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
> index 9b3dcf3a7a..fd974f2357 100644
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
> index ee3129f3b3..cfbeeaf7d5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1399,7 +1399,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
>   
>       fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
>                                              memmap[VIRT_DRAM].size,
> -                                           machine);
> +                                           machine, &s->soc[0]);
>       riscv_load_fdt(fdt_load_addr, machine->fdt);
>   
>       /* load the reset vector */
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 18bfe9f7bf..7ccbe5f62a 100644
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

