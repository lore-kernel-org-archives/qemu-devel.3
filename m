Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174DECCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGzAp-0008Gg-37; Thu, 06 Nov 2025 07:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGzAn-0008GP-I5
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:33:05 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGzAk-00050s-G2
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:33:05 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c67d9577b3so508998a34.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 04:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762432381; x=1763037181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eIUUeHNWGzYD0lFuVIlrxwNNM4RwDMa7R6X36QyDTMY=;
 b=jqqU0TmsLW3eG+0I2rm/6aYiK2+T+aMgqoXdBJQFWefVHNtZp9PfQITLniTTX57PTN
 Kq3sWEpIY/kjrYwxN9R5L62A7hDmhB33m1gMn7kziahxZUHw7FF0eiVGlT+J6NrIg242
 tVwaHb/6/Ns6ZyYMgg6Dbkzyh4T/QW/0yRpRyPi4cVnc/iLpZ9ZTGN4b/wfi4h26GUZe
 AYOe13Oo8ZPGoBS0umgIYu3iDAaoNIEamgjFN0DZ/z5X8FZTaXJEY0iJc69fiLtzI8cn
 pGXN3dFsBZ7BH+jhqtrsQB8QWE4/ns3AUpr9ZN+iALvp2O+FLZnlXLI3liIb3fKyNrUH
 00hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762432381; x=1763037181;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eIUUeHNWGzYD0lFuVIlrxwNNM4RwDMa7R6X36QyDTMY=;
 b=b0Cu0Aj/XegJoiDgnJG2gAIveYzEdnLp+qCX61d8VXhlJ45ebPBRWNTaxZOQaysh+7
 2m1Rlp4cyE0Iw2oRTQSA1noh0nlfc8NkARHClyi5H8KZShdX//0gLT1oekopx4MzEABT
 ECY/MeEDW4R2CAd4709gfj43q+prtqmKo7VI40oRMfDlFaR21FePqI0PVGtxjLVO6gmf
 F4lOd05uIUgxTBK28lKOYGAzijBoQuzui4YF03phKNfW3hMs4MrL3mlP9erb/q4mFhrQ
 +zOiWSuU4XczJgKa+UArESHoziI18owcXmhzmkw07HN3090HMzi8yL+2P0mzxQPCt+75
 qFbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0QEkkt20AdE3tGjuLWEMLS3afndDIq04uy2Wp0f5bIMoxTUgam+ovIGozUbBq76zurRrODc8+90HE@nongnu.org
X-Gm-Message-State: AOJu0YyqasK6G8+NW422yk0ZY+eXo4BciYIxr/g3anSmqCcuMFV7d4pz
 +lARMOBlJe6AHoG54xBQNoYTA+P75y/kbVfcxrgaPD3tXFGJmRJDQnJu6TkxEdA9CIQ=
X-Gm-Gg: ASbGncuKaLyLLrzmIK85qec9J9vF4ukkxrbrpvLVvK/07MAbW8FrER+Yq6HtkPxGEH6
 DzEV2AB3OpuwGhC4CXUzTxg1FL8lOw/WuMlDmp0XPdX9P0lMhJmP7K81U/cq1iUpMSAJIs5eP6i
 wnr/1ZaLw+ockEzQAm5Ua/djhyYHN8Nc8MjNm27t0MZYzrPxT+eZNNm0jDbPc88zxhMsDodzjJO
 CIdSmaE2SMSLtKLIybX96J6Y2vwO9+TQWtqKSDCszZ2h5y9ENy0eXP6o76G82k2hEMPMLinZtv9
 hFbmVQ5N+qAUv3Q2+ouRRlu+JYsynt+lF9BDs479ucI7pLgjespAkGduIcOMVbJstt2PSNbSPnJ
 bYw6y7GOxsq9eLbCT5kxuxvWhuesFGUVBcpBDrgjkM5xTDzGaPzMomtyRUj280qf8t9/FGtuW5i
 581LTH/Z6Grd5jfQ==
X-Google-Smtp-Source: AGHT+IGM8JbZ80M3vPqX1ySsWNGc58oWtEkYD3colqmwULESs5vICjItnUBF7+3qlQ4dfeYo3mPp6A==
X-Received: by 2002:a05:6808:189e:b0:44f:6d6d:4a04 with SMTP id
 5614622812f47-44fed36fed5mr4026398b6e.58.1762432380762; 
 Thu, 06 Nov 2025 04:33:00 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45002592016sm749216b6e.7.2025.11.06.04.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 04:32:59 -0800 (PST)
Message-ID: <0ea7b8fc-db50-415d-94cb-fcdab2d7a65a@ventanamicro.com>
Date: Thu, 6 Nov 2025 09:32:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hw/riscv: introduce 'neorv32' board, docs, and
 riscv32 device config
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251105185056.23565-1-michael@videogpu.com>
 <20251105185056.23565-6-michael@videogpu.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251105185056.23565-6-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
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

This patch won't build the docs, at least for me. Here's the error:


[3023/3024] Generating docs/QEMU manual with a custom command
FAILED: docs/docs.stamp
/usr/bin/env CONFDIR=etc/qemu /home/danielhb/work/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=1 -j auto -Dversion=10.1.50 -Drelease= -Ddepfile=docs/docs.d -Ddepfile_stamp=docs/docs.stamp -b html -d /home/danielhb/work/qemu/build/docs/manual.p /home/danielhb/work/qemu/docs /home/danielhb/work/qemu/build/docs/manual
/home/danielhb/work/qemu/docs/system/riscv/neorv32.rst:32: WARNING: Title underline too short.

QEMU build configuration:
------------------------ [docutils]
/home/danielhb/work/qemu/docs/system/riscv/neorv32.rst:32: WARNING: Title underline too short.

QEMU build configuration:
------------------------ [docutils]
/home/danielhb/work/qemu/docs/system/riscv/neorv32.rst:60: ERROR: Unexpected indentation. [docutils]
/home/danielhb/work/qemu/docs/system/riscv/neorv32.rst: WARNING: document isn't included in any toctree
ninja: build stopped: subcommand failed.



Here's a diff that fixes it:

$ git diff
diff --git a/docs/system/riscv/neorv32.rst b/docs/system/riscv/neorv32.rst
index 7f9048a7ad..caa57a005d 100644
--- a/docs/system/riscv/neorv32.rst
+++ b/docs/system/riscv/neorv32.rst
@@ -29,7 +29,7 @@ the specific patch series you are using.)
  
  
  QEMU build configuration:
-------------------------
+-------------------------
  /path/to/qemu/configure \
    --python=/usr/local/bin/python3.12 \
    --target-list=riscv32-softmmu \
@@ -56,8 +56,7 @@ Preparing the SPI flash with a “Hello World” example
     Replace ``/path/to/neorv32_exe.bin`` with the path to your compiled
     example application (e.g., the NEORV32 ``hello_world`` example)::
  
-   $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin \
-        bs=1 seek=$((0x00400000)) conv=notrunc
+   $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin bs=1 seek=$((0x00400000)) conv=notrunc
  
  Running the “Hello World” example
  ---------------------------------
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..fbd8270022 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -68,6 +68,7 @@ undocumented; you can get a complete list by running
  
     riscv/microblaze-v-generic
     riscv/microchip-icicle-kit
+   riscv/neorv32
     riscv/shakti-c
     riscv/sifive_u
     riscv/virt


Thanks,

Daniel


On 11/5/25 3:50 PM, Michael Levit wrote:
> From: Michael <michael@videogpu.com>
> 
> Introduce the 'neorv32' board wiring IMEM/DMEM/BOOTROM, SYSINFO, UART0, and SPI0;
> add docs/system/riscv/neorv32.rst and riscv32-softmmu device config entry.
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>
> ---
>   configs/devices/riscv32-softmmu/default.mak |   1 +
>   docs/system/riscv/neorv32.rst               | 110 ++++++++++
>   hw/riscv/Kconfig                            |   8 +
>   hw/riscv/meson.build                        |   1 +
>   hw/riscv/neorv32.c                          | 215 ++++++++++++++++++++
>   include/hw/riscv/neorv32.h                  |  54 +++++
>   6 files changed, 389 insertions(+)
>   create mode 100644 docs/system/riscv/neorv32.rst
>   create mode 100644 hw/riscv/neorv32.c
>   create mode 100644 include/hw/riscv/neorv32.h
> 
> diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/devices/riscv32-softmmu/default.mak
> index c2cd86ce05..4fdc94ab48 100644
> --- a/configs/devices/riscv32-softmmu/default.mak
> +++ b/configs/devices/riscv32-softmmu/default.mak
> @@ -10,3 +10,4 @@
>   # CONFIG_SIFIVE_U=n
>   # CONFIG_RISCV_VIRT=n
>   # CONFIG_OPENTITAN=n
> +# CONFIG_NEORV32=n
> diff --git a/docs/system/riscv/neorv32.rst b/docs/system/riscv/neorv32.rst
> new file mode 100644
> index 0000000000..7f9048a7ad
> --- /dev/null
> +++ b/docs/system/riscv/neorv32.rst
> @@ -0,0 +1,110 @@
> +
> +NEORV32 Soft SoC (``neorv32``)
> +==============================
> +
> +The ``neorv32`` machine models a minimal NEORV32-based SoC sufficient to
> +exercise the stock NEORV32 bootloader and run example applications from an
> +emulated SPI NOR flash. It exposes a UART for console I/O and an MTD-backed
> +SPI flash device that can be populated with user binaries.
> +
> +Neorv32 full repo:
> +https://github.com/stnolting/neorv32
> +
> +Current QEMU implementation base on commit 7d0ef6b2 in Neorv32 repo.
> +
> +Supported devices
> +-----------------
> +
> +The ``neorv32`` machine provides the core peripherals needed by the
> +bootloader and examples:
> +
> +* UART for console (mapped to the QEMU stdio when ``-nographic`` or
> +  ``-serial stdio`` is used).
> +* SPI controller connected to an emulated SPI NOR flash (exposed to the
> +  guest via QEMU's ``if=mtd`` backend).
> +* Basic timer/CLINT-like facilities required by the example software.
> +
> +(Exact register maps and optional peripherals depend on the QEMU version and
> +the specific patch series you are using.)
> +
> +
> +QEMU build configuration:
> +------------------------
> +/path/to/qemu/configure \
> +  --python=/usr/local/bin/python3.12 \
> +  --target-list=riscv32-softmmu \
> +  --enable-fdt \
> +  --enable-debug \
> +  --disable-vnc \
> +  --disable-gtk
> +
> +Boot options
> +------------
> +
> +Typical usage is to boot the NEORV32 bootloader as the QEMU ``-bios`` image,
> +and to provide a raw SPI flash image via an MTD drive. The bootloader will
> +then jump to the application image placed at the configured flash offset.
> +
> +Preparing the SPI flash with a “Hello World” example
> +----------------------------------------------------
> +
> +1. Create a 64 MiB flash image (filled with zeros)::
> +
> +   $ dd if=/dev/zero of=$HOME/flash_contents.bin bs=1 count=$((0x04000000))
> +
> +2. Place your application binary at the **4 MiB** offset inside the flash.
> +   Replace ``/path/to/neorv32_exe.bin`` with the path to your compiled
> +   example application (e.g., the NEORV32 ``hello_world`` example)::
> +
> +   $ dd if=/path/to/neorv32_exe.bin of=$HOME/flash_contents.bin \
> +        bs=1 seek=$((0x00400000)) conv=notrunc
> +
> +Running the “Hello World” example
> +---------------------------------
> +
> +Run QEMU with the NEORV32 bootloader as ``-bios`` and attach the prepared
> +flash image via the MTD interface. Replace the placeholder paths with your
> +local paths::
> +
> +  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
> +      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
> +      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw
> +
> +Notes:
> +
> +* ``-nographic`` routes the UART to your terminal (Ctrl-A X to quit when
> +  using the QEMU monitor hotkeys; or just close the terminal).
> +* The bootloader starts first and will transfer control to your application
> +  located at the 4 MiB offset of the flash image.
> +* If you prefer, you can use ``-serial stdio`` instead of ``-nographic``.
> +
> +Machine-specific options
> +------------------------
> +
> +Unless otherwise noted by the patch series, there are no special board
> +options beyond the standard QEMU options shown above. Commonly useful
> +generic options include:
> +
> +* ``-s -S`` to open a GDB stub on TCP port 1234 and start paused, so you can
> +  debug both QEMU and the guest.
> +* ``-d guest_errors,unimp`` (or other trace flags) for additional logging.
> +
> +Example: debugging with GDB::
> +
> +  $ /path/to/qemu-system-riscv32 -nographic -machine neorv32 \
> +      -bios /path/to/neorv32/bootloader/neorv32_raw_exe.bin \
> +      -drive file=$HOME/flash_contents.bin,if=mtd,format=raw \
> +      -s -S
> +
> +  # In another shell:
> +  $ riscv32-unknown-elf-gdb /path/to/neorv32/bootloader/main.elf
> +  (gdb) target remote :1234
> +
> +
> +Known limitations
> +-----------------
> +
> +This is a functional model intended for software bring-up and testing of
> +example programs. It may not model all timing details or every optional
> +peripheral available in a specific NEORV32 SoC configuration.
> +
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fc9c35bd98..976acd2a1b 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -128,3 +128,11 @@ config XIANGSHAN_KUNMINGHU
>       select RISCV_APLIC
>       select RISCV_IMSIC
>       select SERIAL_MM
> +
> +config NEORV32
> +    bool
> +    default y
> +    depends on RISCV32
> +    select NEORV32_UART
> +    select NEORV32_SPI
> +    select NEORV32_SYSINFO_QEMU
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2a8d5b136c..b8788e2035 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
> +riscv_ss.add(when: 'CONFIG_NEORV32', if_true: files('neorv32.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/neorv32.c b/hw/riscv/neorv32.c
> new file mode 100644
> index 0000000000..41494d2893
> --- /dev/null
> +++ b/hw/riscv/neorv32.c
> @@ -0,0 +1,215 @@
> +/*
> + * QEMU RISC-V Board Compatible with Neorv32 IP
> + *
> + * Provides a board compatible with the Neorv32 IP:
> + *
> + * 0) SYSINFO
> + * 1) IMEM
> + * 2) DMEM
> + * 3) UART
> + * 4) SPI
> + *
> + * Copyright (c) 2025 Michael Levit
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/char/serial.h"
> +#include "hw/misc/unimp.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "chardev/char.h"
> +#include "system/system.h"
> +#include "hw/ssi/ssi.h"    /* For ssi_realize_and_unref() */
> +
> +#include "hw/riscv/neorv32.h"
> +#include "hw/misc/neorv32_sysinfo.h"
> +#include "hw/char/neorv32_uart.h"
> +#include "hw/ssi/neorv32_spi.h"
> +
> +/* TODO: get BOOTLOADER_ROM, IMEM, DMEM sizes from rtl auto-generated header */
> +static const MemMapEntry neorv32_memmap[] = {
> +
> +    [NEORV32_IMEM]           = { NEORV32_IMEM_BASE,    SYSINFO_IMEM_SIZE},
> +    [NEORV32_BOOTLOADER_ROM] = { NEORV32_BOOTLOADER_BASE_ADDRESS, 0x2000},
> +    [NEORV32_DMEM]           = { NEORV32_DMEM_BASE,    SYSINFO_DMEM_SIZE},
> +    [NEORV32_SYSINFO]        = { NEORV32_SYSINFO_BASE, 0x100},
> +    [NEORV32_UART0]          = { NEORV32_UART0_BASE,   0x100},
> +    [NEORV32_SPI0]           = { NEORV32_SPI_BASE,     0x100},
> +};
> +
> +static void neorv32_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const MemMapEntry *memmap = neorv32_memmap;
> +
> +    Neorv32State *s = NEORV32_MACHINE(machine);
> +    MemoryRegion *sys_mem = get_system_memory();
> +    int i;
> +    RISCVBootInfo boot_info;
> +    hwaddr start_addr = memmap[NEORV32_BOOTLOADER_ROM].base;
> +
> +    if (machine->ram_size != mc->default_ram_size) {
> +        char *sz = size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_RISCV_NEORV32_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    /* Data Tightly Integrated Memory */
> +    memory_region_add_subregion(sys_mem,
> +        memmap[NEORV32_DMEM].base, machine->ram);
> +
> +    /* Instruction Memory (IMEM) */
> +    memory_region_init_ram(&s->soc.imem_region, OBJECT(&s->soc),
> +                           "riscv.neorv32.imem",
> +                           memmap[NEORV32_IMEM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[NEORV32_IMEM].base,
> +                                &s->soc.imem_region);
> +
> +    /* Mask ROM reset vector */
> +    uint32_t reset_vec[4];
> +
> +    reset_vec[1] = 0x204002b7;  /* 0x1004: lui     t0,0x20400 */
> +    reset_vec[2] = 0x00028067;      /* 0x1008: jr      t0 */
> +    reset_vec[0] = reset_vec[3] = 0;
> +
> +    /* copy in the reset vector in little_endian byte order */
> +    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
> +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
> +    }
> +
> +    /* Neorv32 bootloader */
> +    if (machine->firmware) {
> +        riscv_find_and_load_firmware(machine, machine->firmware,
> +                                     &start_addr, NULL);
> +    }
> +
> +    /* Neorv32 example applications */
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +    if (machine->kernel_filename) {
> +        riscv_load_kernel(machine, &boot_info,
> +                          memmap[NEORV32_IMEM].base,
> +                          false, NULL);
> +    }
> +}
> +
> +static void neorv32_machine_instance_init(Object *obj)
> +{
> +
> +    /* Placeholder for now */
> +    /* Neorv32State *s = NEORV32_MACHINE(obj); */
> +}
> +
> +static void neorv32_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RISC-V SOC compatible with Neorv32 SDK";
> +    mc->init = neorv32_machine_init;
> +    mc->max_cpus = 1;
> +    mc->default_cpu_type = NEORV32_CPU;
> +    mc->default_ram_id = "riscv.neorv32.dmem";
> +    mc->default_ram_size = neorv32_memmap[NEORV32_DMEM].size;
> +
> +}
> +
> +static const TypeInfo neorv32_machine_typeinfo = {
> +    .name          = MACHINE_TYPE_NAME("neorv32"),
> +    .parent        = TYPE_MACHINE,
> +    .class_init    = neorv32_machine_class_init,
> +    .instance_init = neorv32_machine_instance_init,
> +    .instance_size = sizeof(Neorv32State),
> +};
> +
> +static void neorv32_machine_init_register_types(void)
> +{
> +    type_register_static(&neorv32_machine_typeinfo);
> +}
> +
> +type_init(neorv32_machine_init_register_types)
> +
> +static void neorv32_soc_init(Object *obj)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    Neorv32SoCState *s = RISCV_NEORV32_SOC(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
> +    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
> +                            &error_abort);
> +
> +    object_property_set_int(OBJECT(&s->cpus), "resetvec",
> +                            NEORV32_BOOTLOADER_BASE_ADDRESS, &error_abort);
> +
> +}
> +
> +static void neorv32_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const MemMapEntry *memmap = neorv32_memmap;
> +    Neorv32SoCState *s = RISCV_NEORV32_SOC(dev);
> +    MemoryRegion *sys_mem = get_system_memory();
> +
> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +
> +    /* Bootloader ROM */
> +    memory_region_init_rom(&s->bootloader_rom, OBJECT(dev),
> +                           "riscv.bootloader.rom",
> +                           memmap[NEORV32_BOOTLOADER_ROM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem,
> +        memmap[NEORV32_BOOTLOADER_ROM].base, &s->bootloader_rom);
> +
> +
> +    /* Sysinfo ROM */
> +    neorv32_sysinfo_create(sys_mem, memmap[NEORV32_SYSINFO].base);
> +
> +    /* Uart0 */
> +    neorv32_uart_create(sys_mem, memmap[NEORV32_UART0].base, serial_hd(0));
> +
> +    /* SPI controller */
> +    NEORV32SPIState *spi = neorv32_spi_create(sys_mem,
> +                                              memmap[NEORV32_SPI0].base);
> +
> +    if (!spi) {
> +        error_setg(errp, "SPI is not created");
> +        return;
> +    }
> +}
> +
> +static void neorv32_soc_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    dc->realize = neorv32_soc_realize;
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo neorv32_soc_type_info = {
> +    .name = TYPE_RISCV_NEORV32_SOC,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(Neorv32SoCState),
> +    .instance_init = neorv32_soc_init,
> +    .class_init = neorv32_soc_class_init,
> +};
> +
> +static void neorv32_soc_register_types(void)
> +{
> +    type_register_static(&neorv32_soc_type_info);
> +}
> +
> +type_init(neorv32_soc_register_types)
> diff --git a/include/hw/riscv/neorv32.h b/include/hw/riscv/neorv32.h
> new file mode 100644
> index 0000000000..bc90c2bc04
> --- /dev/null
> +++ b/include/hw/riscv/neorv32.h
> @@ -0,0 +1,54 @@
> +/*
> + * NEORV32 SOC presentation in QEMU
> + *
> + * Copyright (c) 2025 Michael Levit
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_NEORV32_H
> +#define HW_NEORV32_H
> +
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/boards.h"
> +
> +#if defined(TARGET_RISCV32)
> +#define NEORV32_CPU TYPE_RISCV_CPU_NEORV32
> +#endif
> +
> +#define TYPE_RISCV_NEORV32_SOC "riscv.neorv32.soc"
> +#define RISCV_NEORV32_SOC(obj) \
> +    OBJECT_CHECK(Neorv32SoCState, (obj), TYPE_RISCV_NEORV32_SOC)
> +
> +typedef struct Neorv32SoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    DeviceState *plic;
> +    MemoryRegion imem_region;
> +    MemoryRegion bootloader_rom;
> +} Neorv32SoCState;
> +
> +typedef struct Neorv32State {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    Neorv32SoCState soc;
> +} Neorv32State;
> +
> +#define TYPE_NEORV32_MACHINE MACHINE_TYPE_NAME("neorv32")
> +#define NEORV32_MACHINE(obj) \
> +    OBJECT_CHECK(Neorv32State, (obj), TYPE_NEORV32_MACHINE)
> +
> +enum {
> +    NEORV32_IMEM,
> +    NEORV32_BOOTLOADER_ROM,
> +    NEORV32_DMEM,
> +    NEORV32_SYSINFO,
> +    NEORV32_UART0,
> +    NEORV32_SPI0,
> +};
> +
> +#endif /* HW_NEORV32_H */


