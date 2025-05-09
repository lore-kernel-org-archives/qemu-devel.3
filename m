Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7DBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQDN-0006UX-5E; Fri, 09 May 2025 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDQD5-0006CD-6s
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDQCz-0004Xl-Cw
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746806660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9SGTty9vioSZ28fB68+a+8ZO7FqN4j+nQiW9zGlb68=;
 b=ad5kkB4KMIAsGVx71rn6vhE7F2OfbEQkahAZdL8JSQ31P/i58RwW/crQZx4rHh5GRJPWs5
 J4SVzq2KLsbZzXGt/7+1TBDJ35v7xU/FniI9139WVyLfzkjvGjA5rwINV2/A2XlxiE2NF/
 Zq9rkY1lNqJZO/9YNmGoj59rSUDrWB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-H4lHrAhAOK6vNF3BZblFRQ-1; Fri, 09 May 2025 12:04:17 -0400
X-MC-Unique: H4lHrAhAOK6vNF3BZblFRQ-1
X-Mimecast-MFC-AGG-ID: H4lHrAhAOK6vNF3BZblFRQ_1746806657
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b7c8b3e2so1469546f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746806656; x=1747411456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9SGTty9vioSZ28fB68+a+8ZO7FqN4j+nQiW9zGlb68=;
 b=sqF78Pn7cSlExeubz7S8fKGP1NrESOI/BRpuJ6pn7YbR9hplKUSkEQIytTJErNZI/K
 lU0XQnXEIERTDkQgLRTjd5SQfDyX5pVbAuwl648nxqns6YllLcxr2wJ8m/FtjfaRZ1nb
 Gzy2C5N9iDS07+MPz+OPIv33MjsAtE7UUBzN5P1+Q9FHEGF3zVB99Olhqz1tdewwu1kJ
 4bslNhlxi1V4MX3dxRou8bLcYuGT4TZRyZmkI3J3CfvWPNc80yc3fEtKEpLJ9SbeERY+
 lERK5QYiLGf+1/CZy6dhqqYyKbECd8mVYE40F6cSwjOo1muRl93xzeeCraNXPcRkUqnX
 2u2A==
X-Gm-Message-State: AOJu0YyQsHCIaSV1vFRGnrIM6YgLPAqLJf9Au3xn7wK0Ec+Uxs7u9/Su
 Q2NmgWf1XqvoHCQgUJYsH1AQt7erSBXZDHEEFd9trg6AgmafvPjXgE7bc+mMwcsQ5HhY8myzHcc
 Vw1uwlH9Y05dgD90YBuQF41vxe1XztpIUYYMetrIPOuxueRz81S1C
X-Gm-Gg: ASbGncv47THHWf1ewSAAJvAMw1FOKUKbfa769gWtZvO6nlfjIuZlHivFKwU0EbO3FW7
 k6/U0gaHOiCZ97bVFGNxiLg/LlJrTCTqdUehf47Yww1e9Op+lPjsVZ4r/ZOqsrQnmMVxAe8LLA5
 CaRrVkUMiOormNY0uIa4Nyw+XsoVyGn5MAKlDulEIszR7fwyyDq57Bnsb9f5vHJIGpdKwBC2664
 GNrfDpJzQ61TfZ0zxpwhHzsZTBZg9tmfdVeqvb0HP7oeupZtgmhHIt2lMMTj+BTNmPfMIEqwP8R
 dySPJ26ujFP9zXq4YLKY/0IAMctJXkm4
X-Received: by 2002:a05:6000:3113:b0:39c:1f0e:95af with SMTP id
 ffacd0b85a97d-3a1f64279d3mr3602036f8f.3.1746806656259; 
 Fri, 09 May 2025 09:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6cQYF6EWJWz+6FcQdM7QsRdpFYn7ZHkZ4Tmns/dMEuuVwt/TrFHlK5zhhQj3FktvxJlzsog==
X-Received: by 2002:a05:6000:3113:b0:39c:1f0e:95af with SMTP id
 ffacd0b85a97d-3a1f64279d3mr3601929f8f.3.1746806655504; 
 Fri, 09 May 2025 09:04:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2d3sm3674769f8f.63.2025.05.09.09.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 09:04:15 -0700 (PDT)
Date: Fri, 9 May 2025 18:04:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 10/27] hw/i386/pc: Remove linuxboot.bin
Message-ID: <20250509180411.10f6e683@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-11-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-11-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu,  8 May 2025 15:35:33 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> All PC machines now use the linuxboot_dma.bin binary,
> we can remove the non-DMA version (linuxboot.bin).
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/i386/pc.c                  |   3 +-


linuxboot.bin is referenced in a few more files:

hw/i386/x86-common.c:    option_rom[nb_option_roms].name =3D "linuxboot.bin=
";
hw/nvram/fw_cfg.c:    { "genroms/linuxboot.bin", 60 },

are you sure we should keep it there?

>  pc-bios/meson.build           |   1 -
>  pc-bios/optionrom/Makefile    |   2 +-
>  pc-bios/optionrom/linuxboot.S | 195 ----------------------------------
>  4 files changed, 2 insertions(+), 199 deletions(-)
>  delete mode 100644 pc-bios/optionrom/linuxboot.S
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 524d2fd98e8..4e6fe68e2e0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -654,8 +654,7 @@ void xen_load_linux(PCMachineState *pcms)
> =20
>      x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
>      for (i =3D 0; i < nb_option_roms; i++) {
> -        assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
> -               !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> +        assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
>                 !strcmp(option_rom[i].name, "pvh.bin") ||
>                 !strcmp(option_rom[i].name, "multiboot_dma.bin"));
>          rom_add_option(option_rom[i].name, option_rom[i].bootindex);
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index f2d4dc416a4..39a7fea332e 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -63,7 +63,6 @@ blobs =3D [
>    'efi-vmxnet3.rom',
>    'qemu-nsis.bmp',
>    'multiboot_dma.bin',
> -  'linuxboot.bin',
>    'linuxboot_dma.bin',
>    'kvmvapic.bin',
>    'pvh.bin',
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 1183ef88922..e694c7aac00 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -2,7 +2,7 @@ include config.mak
>  SRC_DIR :=3D $(TOPSRC_DIR)/pc-bios/optionrom
>  VPATH =3D $(SRC_DIR)
> =20
> -all: multiboot_dma.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.=
bin
> +all: multiboot_dma.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
>  # Dummy command so that make thinks it has done something
>  	@true
> =20
> diff --git a/pc-bios/optionrom/linuxboot.S b/pc-bios/optionrom/linuxboot.S
> deleted file mode 100644
> index ba821ab922d..00000000000
> --- a/pc-bios/optionrom/linuxboot.S
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -/*
> - * Linux Boot Option ROM
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - * Copyright Novell Inc, 2009
> - *   Authors: Alexander Graf <agraf@suse.de>
> - *
> - * Based on code in hw/pc.c.
> - */
> -
> -#include "optionrom.h"
> -
> -#define BOOT_ROM_PRODUCT "Linux loader"
> -
> -BOOT_ROM_START
> -
> -run_linuxboot:
> -
> -	cli
> -	cld
> -
> -	jmp		copy_kernel
> -boot_kernel:
> -
> -	read_fw		FW_CFG_SETUP_ADDR
> -
> -	mov		%eax, %ebx
> -	shr		$4, %ebx
> -
> -	/* All segments contain real_addr */
> -	mov		%bx, %ds
> -	mov		%bx, %es
> -	mov		%bx, %fs
> -	mov		%bx, %gs
> -	mov		%bx, %ss
> -
> -	/* CX =3D CS we want to jump to */
> -	add		$0x20, %bx
> -	mov		%bx, %cx
> -
> -	/* SP =3D cmdline_addr-real_addr-16 */
> -	read_fw		FW_CFG_CMDLINE_ADDR
> -	mov		%eax, %ebx
> -	read_fw		FW_CFG_SETUP_ADDR
> -	sub		%eax, %ebx
> -	sub		$16, %ebx
> -	mov		%ebx, %esp
> -
> -	/* Build indirect lret descriptor */
> -	pushw		%cx		/* CS */
> -	xor		%ax, %ax
> -	pushw		%ax		/* IP =3D 0 */
> -
> -	/* Clear registers */
> -	xor		%eax, %eax
> -	xor		%ebx, %ebx
> -	xor		%ecx, %ecx
> -	xor		%edx, %edx
> -	xor		%edi, %edi
> -	xor		%ebp, %ebp
> -
> -	/* Jump to Linux */
> -	lret
> -
> -
> -copy_kernel:
> -	/* Read info block in low memory (0x10000 or 0x90000) */
> -	read_fw		FW_CFG_SETUP_ADDR
> -	shr		$4, %eax
> -	mov		%eax, %es
> -	xor		%edi, %edi
> -	read_fw_blob_addr32_edi(FW_CFG_SETUP)
> -
> -	cmpw            $0x203, %es:0x206      // if protocol >=3D 0x203
> -	jae             1f                     // have initrd_max
> -	movl            $0x37ffffff, %es:0x22c // else assume 0x37ffffff
> -1:
> -
> -	/* Check if using kernel-specified initrd address */
> -	read_fw		FW_CFG_INITRD_ADDR
> -	mov		%eax, %edi             // (load_kernel wants it in %edi)
> -	read_fw		FW_CFG_INITRD_SIZE     // find end of initrd
> -	add		%edi, %eax
> -	xor		%es:0x22c, %eax        // if it matches es:0x22c
> -	and		$-4096, %eax           // (apart from padding for page)
> -	jz		load_kernel            // then initrd is not at top
> -					       // of memory
> -
> -	/* pc.c placed the initrd at end of memory.  Compute a better
> -	 * initrd address based on e801 data.
> -	 */
> -	mov		$0xe801, %ax
> -	xor		%cx, %cx
> -	xor		%dx, %dx
> -	int		$0x15
> -
> -	/* Output could be in AX/BX or CX/DX */
> -	or		%cx, %cx
> -	jnz		1f
> -	or		%dx, %dx
> -	jnz		1f
> -	mov		%ax, %cx
> -	mov		%bx, %dx
> -1:
> -
> -	or		%dx, %dx
> -	jnz		2f
> -	addw		$1024, %cx            /* add 1 MB */
> -	movzwl		%cx, %edi
> -	shll		$10, %edi             /* convert to bytes */
> -	jmp		3f
> -
> -2:
> -	addw		$16777216 >> 16, %dx  /* add 16 MB */
> -	movzwl		%dx, %edi
> -	shll		$16, %edi             /* convert to bytes */
> -
> -3:
> -	read_fw         FW_CFG_INITRD_SIZE
> -	subl            %eax, %edi
> -	andl            $-4096, %edi          /* EDI =3D start of initrd */
> -	movl		%edi, %es:0x218       /* put it in the header */
> -
> -load_kernel:
> -	/* We need to load the kernel into memory we can't access in 16 bit
> -	   mode, so let's get into 32 bit mode, write the kernel and jump
> -	   back again. */
> -
> -	/* Reserve space on the stack for our GDT descriptor. */
> -	mov             %esp, %ebp
> -	sub             $16, %esp
> -
> -	/* Now create the GDT descriptor */
> -	movw		$((3 * 8) - 1), -16(%bp)
> -	mov		%cs, %eax
> -	movzwl		%ax, %eax
> -	shl		$4, %eax
> -	addl		$gdt, %eax
> -	movl		%eax, -14(%bp)
> -
> -	/* And load the GDT */
> -	data32 lgdt	-16(%bp)
> -	mov		%ebp, %esp
> -
> -	/* Get us to protected mode now */
> -	mov		$1, %eax
> -	mov		%eax, %cr0
> -
> -	/* So we can set ES to a 32-bit segment */
> -	mov		$0x10, %eax
> -	mov		%eax, %es
> -
> -	/* We're now running in 16-bit CS, but 32-bit ES! */
> -
> -	/* Load kernel and initrd */
> -	read_fw_blob_addr32_edi(FW_CFG_INITRD)
> -	read_fw_blob_addr32(FW_CFG_KERNEL)
> -	read_fw_blob_addr32(FW_CFG_CMDLINE)
> -
> -	/* And now jump into Linux! */
> -	mov		$0, %eax
> -	mov		%eax, %cr0
> -
> -	/* ES =3D CS */
> -	mov		%cs, %ax
> -	mov		%ax, %es
> -
> -	jmp		boot_kernel
> -
> -/* Variables */
> -
> -.align 4, 0
> -gdt:
> -	/* 0x00 */
> -.byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> -
> -	/* 0x08: code segment (base=3D0, limit=3D0xfffff, type=3D32bit code exe=
c/read, DPL=3D0, 4k) */
> -.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00
> -
> -	/* 0x10: data segment (base=3D0, limit=3D0xfffff, type=3D32bit data rea=
d/write, DPL=3D0, 4k) */
> -.byte	0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00
> -
> -BOOT_ROM_END


